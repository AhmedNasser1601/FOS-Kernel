
obj/user/quicksort_interrupt:     file format elf32-i386


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
  800031:	e8 c4 05 00 00       	call   8005fa <libmain>
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
  800049:	e8 0d 1b 00 00       	call   801b5b <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 1f 1b 00 00       	call   801b74 <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();

		sys_disable_interrupt();
  80005d:	e8 c9 1b 00 00       	call   801c2b <sys_disable_interrupt>
			readline("Enter the number of elements: ", Line);
  800062:	83 ec 08             	sub    $0x8,%esp
  800065:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  80006b:	50                   	push   %eax
  80006c:	68 80 22 80 00       	push   $0x802280
  800071:	e8 c9 0f 00 00       	call   80103f <readline>
  800076:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	6a 0a                	push   $0xa
  80007e:	6a 00                	push   $0x0
  800080:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800086:	50                   	push   %eax
  800087:	e8 19 15 00 00       	call   8015a5 <strtol>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800092:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800095:	c1 e0 02             	shl    $0x2,%eax
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	50                   	push   %eax
  80009c:	e8 ac 18 00 00       	call   80194d <malloc>
  8000a1:	83 c4 10             	add    $0x10,%esp
  8000a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a7:	83 ec 0c             	sub    $0xc,%esp
  8000aa:	68 a0 22 80 00       	push   $0x8022a0
  8000af:	e8 09 09 00 00       	call   8009bd <cprintf>
  8000b4:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b7:	83 ec 0c             	sub    $0xc,%esp
  8000ba:	68 c3 22 80 00       	push   $0x8022c3
  8000bf:	e8 f9 08 00 00       	call   8009bd <cprintf>
  8000c4:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c7:	83 ec 0c             	sub    $0xc,%esp
  8000ca:	68 d1 22 80 00       	push   $0x8022d1
  8000cf:	e8 e9 08 00 00       	call   8009bd <cprintf>
  8000d4:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\nSelect: ") ;
  8000d7:	83 ec 0c             	sub    $0xc,%esp
  8000da:	68 e0 22 80 00       	push   $0x8022e0
  8000df:	e8 d9 08 00 00       	call   8009bd <cprintf>
  8000e4:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8000e7:	e8 b6 04 00 00       	call   8005a2 <getchar>
  8000ec:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8000ef:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000f3:	83 ec 0c             	sub    $0xc,%esp
  8000f6:	50                   	push   %eax
  8000f7:	e8 5e 04 00 00       	call   80055a <cputchar>
  8000fc:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	6a 0a                	push   $0xa
  800104:	e8 51 04 00 00       	call   80055a <cputchar>
  800109:	83 c4 10             	add    $0x10,%esp
		sys_enable_interrupt();
  80010c:	e8 34 1b 00 00       	call   801c45 <sys_enable_interrupt>
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800111:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800115:	83 f8 62             	cmp    $0x62,%eax
  800118:	74 1d                	je     800137 <_main+0xff>
  80011a:	83 f8 63             	cmp    $0x63,%eax
  80011d:	74 2b                	je     80014a <_main+0x112>
  80011f:	83 f8 61             	cmp    $0x61,%eax
  800122:	75 39                	jne    80015d <_main+0x125>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800124:	83 ec 08             	sub    $0x8,%esp
  800127:	ff 75 ec             	pushl  -0x14(%ebp)
  80012a:	ff 75 e8             	pushl  -0x18(%ebp)
  80012d:	e8 e6 02 00 00       	call   800418 <InitializeAscending>
  800132:	83 c4 10             	add    $0x10,%esp
			break ;
  800135:	eb 37                	jmp    80016e <_main+0x136>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  800137:	83 ec 08             	sub    $0x8,%esp
  80013a:	ff 75 ec             	pushl  -0x14(%ebp)
  80013d:	ff 75 e8             	pushl  -0x18(%ebp)
  800140:	e8 04 03 00 00       	call   800449 <InitializeDescending>
  800145:	83 c4 10             	add    $0x10,%esp
			break ;
  800148:	eb 24                	jmp    80016e <_main+0x136>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80014a:	83 ec 08             	sub    $0x8,%esp
  80014d:	ff 75 ec             	pushl  -0x14(%ebp)
  800150:	ff 75 e8             	pushl  -0x18(%ebp)
  800153:	e8 26 03 00 00       	call   80047e <InitializeSemiRandom>
  800158:	83 c4 10             	add    $0x10,%esp
			break ;
  80015b:	eb 11                	jmp    80016e <_main+0x136>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  80015d:	83 ec 08             	sub    $0x8,%esp
  800160:	ff 75 ec             	pushl  -0x14(%ebp)
  800163:	ff 75 e8             	pushl  -0x18(%ebp)
  800166:	e8 13 03 00 00       	call   80047e <InitializeSemiRandom>
  80016b:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  80016e:	83 ec 08             	sub    $0x8,%esp
  800171:	ff 75 ec             	pushl  -0x14(%ebp)
  800174:	ff 75 e8             	pushl  -0x18(%ebp)
  800177:	e8 e1 00 00 00       	call   80025d <QuickSort>
  80017c:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  80017f:	83 ec 08             	sub    $0x8,%esp
  800182:	ff 75 ec             	pushl  -0x14(%ebp)
  800185:	ff 75 e8             	pushl  -0x18(%ebp)
  800188:	e8 e1 01 00 00       	call   80036e <CheckSorted>
  80018d:	83 c4 10             	add    $0x10,%esp
  800190:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800193:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800197:	75 14                	jne    8001ad <_main+0x175>
  800199:	83 ec 04             	sub    $0x4,%esp
  80019c:	68 f8 22 80 00       	push   $0x8022f8
  8001a1:	6a 42                	push   $0x42
  8001a3:	68 1a 23 80 00       	push   $0x80231a
  8001a8:	e8 5c 05 00 00       	call   800709 <_panic>
		else
		{ 
			sys_disable_interrupt();
  8001ad:	e8 79 1a 00 00       	call   801c2b <sys_disable_interrupt>
				cprintf("\n===============================================\n") ;
  8001b2:	83 ec 0c             	sub    $0xc,%esp
  8001b5:	68 38 23 80 00       	push   $0x802338
  8001ba:	e8 fe 07 00 00       	call   8009bd <cprintf>
  8001bf:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001c2:	83 ec 0c             	sub    $0xc,%esp
  8001c5:	68 6c 23 80 00       	push   $0x80236c
  8001ca:	e8 ee 07 00 00       	call   8009bd <cprintf>
  8001cf:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 a0 23 80 00       	push   $0x8023a0
  8001da:	e8 de 07 00 00       	call   8009bd <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8001e2:	e8 5e 1a 00 00       	call   801c45 <sys_enable_interrupt>
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_disable_interrupt();
  8001e7:	e8 3f 1a 00 00       	call   801c2b <sys_disable_interrupt>
			cprintf("Freeing the Heap...\n\n") ;
  8001ec:	83 ec 0c             	sub    $0xc,%esp
  8001ef:	68 d2 23 80 00       	push   $0x8023d2
  8001f4:	e8 c4 07 00 00       	call   8009bd <cprintf>
  8001f9:	83 c4 10             	add    $0x10,%esp
		sys_enable_interrupt();
  8001fc:	e8 44 1a 00 00       	call   801c45 <sys_enable_interrupt>

		//freeHeap() ;

		///========================================================================
	//sys_disable_interrupt();
		sys_disable_interrupt();
  800201:	e8 25 1a 00 00       	call   801c2b <sys_disable_interrupt>
			cprintf("Do you want to repeat (y/n): ") ;
  800206:	83 ec 0c             	sub    $0xc,%esp
  800209:	68 e8 23 80 00       	push   $0x8023e8
  80020e:	e8 aa 07 00 00       	call   8009bd <cprintf>
  800213:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800216:	e8 87 03 00 00       	call   8005a2 <getchar>
  80021b:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  80021e:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	50                   	push   %eax
  800226:	e8 2f 03 00 00       	call   80055a <cputchar>
  80022b:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80022e:	83 ec 0c             	sub    $0xc,%esp
  800231:	6a 0a                	push   $0xa
  800233:	e8 22 03 00 00       	call   80055a <cputchar>
  800238:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80023b:	83 ec 0c             	sub    $0xc,%esp
  80023e:	6a 0a                	push   $0xa
  800240:	e8 15 03 00 00       	call   80055a <cputchar>
  800245:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_enable_interrupt();
  800248:	e8 f8 19 00 00       	call   801c45 <sys_enable_interrupt>

	} while (Chose == 'y');
  80024d:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800251:	0f 84 f2 fd ff ff    	je     800049 <_main+0x11>

}
  800257:	90                   	nop
  800258:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80025b:	c9                   	leave  
  80025c:	c3                   	ret    

0080025d <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  80025d:	55                   	push   %ebp
  80025e:	89 e5                	mov    %esp,%ebp
  800260:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800263:	8b 45 0c             	mov    0xc(%ebp),%eax
  800266:	48                   	dec    %eax
  800267:	50                   	push   %eax
  800268:	6a 00                	push   $0x0
  80026a:	ff 75 0c             	pushl  0xc(%ebp)
  80026d:	ff 75 08             	pushl  0x8(%ebp)
  800270:	e8 06 00 00 00       	call   80027b <QSort>
  800275:	83 c4 10             	add    $0x10,%esp
}
  800278:	90                   	nop
  800279:	c9                   	leave  
  80027a:	c3                   	ret    

0080027b <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80027b:	55                   	push   %ebp
  80027c:	89 e5                	mov    %esp,%ebp
  80027e:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800281:	8b 45 10             	mov    0x10(%ebp),%eax
  800284:	3b 45 14             	cmp    0x14(%ebp),%eax
  800287:	0f 8d de 00 00 00    	jge    80036b <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  80028d:	8b 45 10             	mov    0x10(%ebp),%eax
  800290:	40                   	inc    %eax
  800291:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800294:	8b 45 14             	mov    0x14(%ebp),%eax
  800297:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  80029a:	e9 80 00 00 00       	jmp    80031f <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  80029f:	ff 45 f4             	incl   -0xc(%ebp)
  8002a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002a5:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002a8:	7f 2b                	jg     8002d5 <QSort+0x5a>
  8002aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b7:	01 d0                	add    %edx,%eax
  8002b9:	8b 10                	mov    (%eax),%edx
  8002bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002be:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c8:	01 c8                	add    %ecx,%eax
  8002ca:	8b 00                	mov    (%eax),%eax
  8002cc:	39 c2                	cmp    %eax,%edx
  8002ce:	7d cf                	jge    80029f <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002d0:	eb 03                	jmp    8002d5 <QSort+0x5a>
  8002d2:	ff 4d f0             	decl   -0x10(%ebp)
  8002d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002d8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002db:	7e 26                	jle    800303 <QSort+0x88>
  8002dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ea:	01 d0                	add    %edx,%eax
  8002ec:	8b 10                	mov    (%eax),%edx
  8002ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002f1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8002fb:	01 c8                	add    %ecx,%eax
  8002fd:	8b 00                	mov    (%eax),%eax
  8002ff:	39 c2                	cmp    %eax,%edx
  800301:	7e cf                	jle    8002d2 <QSort+0x57>

		if (i <= j)
  800303:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800306:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800309:	7f 14                	jg     80031f <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80030b:	83 ec 04             	sub    $0x4,%esp
  80030e:	ff 75 f0             	pushl  -0x10(%ebp)
  800311:	ff 75 f4             	pushl  -0xc(%ebp)
  800314:	ff 75 08             	pushl  0x8(%ebp)
  800317:	e8 a9 00 00 00       	call   8003c5 <Swap>
  80031c:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80031f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800322:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800325:	0f 8e 77 ff ff ff    	jle    8002a2 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80032b:	83 ec 04             	sub    $0x4,%esp
  80032e:	ff 75 f0             	pushl  -0x10(%ebp)
  800331:	ff 75 10             	pushl  0x10(%ebp)
  800334:	ff 75 08             	pushl  0x8(%ebp)
  800337:	e8 89 00 00 00       	call   8003c5 <Swap>
  80033c:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80033f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800342:	48                   	dec    %eax
  800343:	50                   	push   %eax
  800344:	ff 75 10             	pushl  0x10(%ebp)
  800347:	ff 75 0c             	pushl  0xc(%ebp)
  80034a:	ff 75 08             	pushl  0x8(%ebp)
  80034d:	e8 29 ff ff ff       	call   80027b <QSort>
  800352:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800355:	ff 75 14             	pushl  0x14(%ebp)
  800358:	ff 75 f4             	pushl  -0xc(%ebp)
  80035b:	ff 75 0c             	pushl  0xc(%ebp)
  80035e:	ff 75 08             	pushl  0x8(%ebp)
  800361:	e8 15 ff ff ff       	call   80027b <QSort>
  800366:	83 c4 10             	add    $0x10,%esp
  800369:	eb 01                	jmp    80036c <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80036b:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800374:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80037b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800382:	eb 33                	jmp    8003b7 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800384:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800387:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80038e:	8b 45 08             	mov    0x8(%ebp),%eax
  800391:	01 d0                	add    %edx,%eax
  800393:	8b 10                	mov    (%eax),%edx
  800395:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800398:	40                   	inc    %eax
  800399:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a3:	01 c8                	add    %ecx,%eax
  8003a5:	8b 00                	mov    (%eax),%eax
  8003a7:	39 c2                	cmp    %eax,%edx
  8003a9:	7e 09                	jle    8003b4 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003b2:	eb 0c                	jmp    8003c0 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003b4:	ff 45 f8             	incl   -0x8(%ebp)
  8003b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ba:	48                   	dec    %eax
  8003bb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003be:	7f c4                	jg     800384 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003c3:	c9                   	leave  
  8003c4:	c3                   	ret    

008003c5 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003c5:	55                   	push   %ebp
  8003c6:	89 e5                	mov    %esp,%ebp
  8003c8:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	01 d0                	add    %edx,%eax
  8003da:	8b 00                	mov    (%eax),%eax
  8003dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ec:	01 c2                	add    %eax,%edx
  8003ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8003f1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	01 c8                	add    %ecx,%eax
  8003fd:	8b 00                	mov    (%eax),%eax
  8003ff:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800401:	8b 45 10             	mov    0x10(%ebp),%eax
  800404:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040b:	8b 45 08             	mov    0x8(%ebp),%eax
  80040e:	01 c2                	add    %eax,%edx
  800410:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800413:	89 02                	mov    %eax,(%edx)
}
  800415:	90                   	nop
  800416:	c9                   	leave  
  800417:	c3                   	ret    

00800418 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800418:	55                   	push   %ebp
  800419:	89 e5                	mov    %esp,%ebp
  80041b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80041e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800425:	eb 17                	jmp    80043e <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800427:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80042a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800431:	8b 45 08             	mov    0x8(%ebp),%eax
  800434:	01 c2                	add    %eax,%edx
  800436:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800439:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80043b:	ff 45 fc             	incl   -0x4(%ebp)
  80043e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800441:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800444:	7c e1                	jl     800427 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800446:	90                   	nop
  800447:	c9                   	leave  
  800448:	c3                   	ret    

00800449 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800449:	55                   	push   %ebp
  80044a:	89 e5                	mov    %esp,%ebp
  80044c:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80044f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800456:	eb 1b                	jmp    800473 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800462:	8b 45 08             	mov    0x8(%ebp),%eax
  800465:	01 c2                	add    %eax,%edx
  800467:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046a:	2b 45 fc             	sub    -0x4(%ebp),%eax
  80046d:	48                   	dec    %eax
  80046e:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800470:	ff 45 fc             	incl   -0x4(%ebp)
  800473:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800476:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800479:	7c dd                	jl     800458 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  80047b:	90                   	nop
  80047c:	c9                   	leave  
  80047d:	c3                   	ret    

0080047e <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80047e:	55                   	push   %ebp
  80047f:	89 e5                	mov    %esp,%ebp
  800481:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800484:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800487:	b8 56 55 55 55       	mov    $0x55555556,%eax
  80048c:	f7 e9                	imul   %ecx
  80048e:	c1 f9 1f             	sar    $0x1f,%ecx
  800491:	89 d0                	mov    %edx,%eax
  800493:	29 c8                	sub    %ecx,%eax
  800495:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800498:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80049f:	eb 1e                	jmp    8004bf <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ae:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b4:	99                   	cltd   
  8004b5:	f7 7d f8             	idivl  -0x8(%ebp)
  8004b8:	89 d0                	mov    %edx,%eax
  8004ba:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004bc:	ff 45 fc             	incl   -0x4(%ebp)
  8004bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004c5:	7c da                	jl     8004a1 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004c7:	90                   	nop
  8004c8:	c9                   	leave  
  8004c9:	c3                   	ret    

008004ca <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004ca:	55                   	push   %ebp
  8004cb:	89 e5                	mov    %esp,%ebp
  8004cd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8004d0:	e8 56 17 00 00       	call   801c2b <sys_disable_interrupt>
		int i ;
		int NumsPerLine = 20 ;
  8004d5:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004e3:	eb 42                	jmp    800527 <PrintElements+0x5d>
		{
			if (i%NumsPerLine == 0)
  8004e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e8:	99                   	cltd   
  8004e9:	f7 7d f0             	idivl  -0x10(%ebp)
  8004ec:	89 d0                	mov    %edx,%eax
  8004ee:	85 c0                	test   %eax,%eax
  8004f0:	75 10                	jne    800502 <PrintElements+0x38>
				cprintf("\n");
  8004f2:	83 ec 0c             	sub    $0xc,%esp
  8004f5:	68 06 24 80 00       	push   $0x802406
  8004fa:	e8 be 04 00 00       	call   8009bd <cprintf>
  8004ff:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  800502:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800505:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050c:	8b 45 08             	mov    0x8(%ebp),%eax
  80050f:	01 d0                	add    %edx,%eax
  800511:	8b 00                	mov    (%eax),%eax
  800513:	83 ec 08             	sub    $0x8,%esp
  800516:	50                   	push   %eax
  800517:	68 08 24 80 00       	push   $0x802408
  80051c:	e8 9c 04 00 00       	call   8009bd <cprintf>
  800521:	83 c4 10             	add    $0x10,%esp
void PrintElements(int *Elements, int NumOfElements)
{
	sys_disable_interrupt();
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  800524:	ff 45 f4             	incl   -0xc(%ebp)
  800527:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052a:	48                   	dec    %eax
  80052b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80052e:	7f b5                	jg     8004e5 <PrintElements+0x1b>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800530:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800533:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053a:	8b 45 08             	mov    0x8(%ebp),%eax
  80053d:	01 d0                	add    %edx,%eax
  80053f:	8b 00                	mov    (%eax),%eax
  800541:	83 ec 08             	sub    $0x8,%esp
  800544:	50                   	push   %eax
  800545:	68 0d 24 80 00       	push   $0x80240d
  80054a:	e8 6e 04 00 00       	call   8009bd <cprintf>
  80054f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800552:	e8 ee 16 00 00       	call   801c45 <sys_enable_interrupt>
}
  800557:	90                   	nop
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	83 ec 18             	sub    $0x18,%esp
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
  80056e:	e8 ec 16 00 00       	call   801c5f <sys_cputc>
  800573:	83 c4 10             	add    $0x10,%esp
}
  800576:	90                   	nop
  800577:	c9                   	leave  
  800578:	c3                   	ret    

00800579 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800579:	55                   	push   %ebp
  80057a:	89 e5                	mov    %esp,%ebp
  80057c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80057f:	e8 a7 16 00 00       	call   801c2b <sys_disable_interrupt>
	char c = ch;
  800584:	8b 45 08             	mov    0x8(%ebp),%eax
  800587:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80058a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80058e:	83 ec 0c             	sub    $0xc,%esp
  800591:	50                   	push   %eax
  800592:	e8 c8 16 00 00       	call   801c5f <sys_cputc>
  800597:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80059a:	e8 a6 16 00 00       	call   801c45 <sys_enable_interrupt>
}
  80059f:	90                   	nop
  8005a0:	c9                   	leave  
  8005a1:	c3                   	ret    

008005a2 <getchar>:

int
getchar(void)
{
  8005a2:	55                   	push   %ebp
  8005a3:	89 e5                	mov    %esp,%ebp
  8005a5:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005af:	eb 08                	jmp    8005b9 <getchar+0x17>
	{
		c = sys_cgetc();
  8005b1:	e8 8d 14 00 00       	call   801a43 <sys_cgetc>
  8005b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005bd:	74 f2                	je     8005b1 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005c2:	c9                   	leave  
  8005c3:	c3                   	ret    

008005c4 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005c4:	55                   	push   %ebp
  8005c5:	89 e5                	mov    %esp,%ebp
  8005c7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005ca:	e8 5c 16 00 00       	call   801c2b <sys_disable_interrupt>
	int c=0;
  8005cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005d6:	eb 08                	jmp    8005e0 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005d8:	e8 66 14 00 00       	call   801a43 <sys_cgetc>
  8005dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005e4:	74 f2                	je     8005d8 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005e6:	e8 5a 16 00 00       	call   801c45 <sys_enable_interrupt>
	return c;
  8005eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005ee:	c9                   	leave  
  8005ef:	c3                   	ret    

008005f0 <iscons>:

int iscons(int fdnum)
{
  8005f0:	55                   	push   %ebp
  8005f1:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005f3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005f8:	5d                   	pop    %ebp
  8005f9:	c3                   	ret    

008005fa <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005fa:	55                   	push   %ebp
  8005fb:	89 e5                	mov    %esp,%ebp
  8005fd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800600:	e8 8b 14 00 00       	call   801a90 <sys_getenvindex>
  800605:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800608:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80060b:	89 d0                	mov    %edx,%eax
  80060d:	c1 e0 02             	shl    $0x2,%eax
  800610:	01 d0                	add    %edx,%eax
  800612:	01 c0                	add    %eax,%eax
  800614:	01 d0                	add    %edx,%eax
  800616:	01 c0                	add    %eax,%eax
  800618:	01 d0                	add    %edx,%eax
  80061a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800621:	01 d0                	add    %edx,%eax
  800623:	c1 e0 02             	shl    $0x2,%eax
  800626:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80062b:	a3 08 30 80 00       	mov    %eax,0x803008

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800630:	a1 08 30 80 00       	mov    0x803008,%eax
  800635:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80063b:	84 c0                	test   %al,%al
  80063d:	74 0f                	je     80064e <libmain+0x54>
		binaryname = myEnv->prog_name;
  80063f:	a1 08 30 80 00       	mov    0x803008,%eax
  800644:	05 f4 02 00 00       	add    $0x2f4,%eax
  800649:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80064e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800652:	7e 0a                	jle    80065e <libmain+0x64>
		binaryname = argv[0];
  800654:	8b 45 0c             	mov    0xc(%ebp),%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80065e:	83 ec 08             	sub    $0x8,%esp
  800661:	ff 75 0c             	pushl  0xc(%ebp)
  800664:	ff 75 08             	pushl  0x8(%ebp)
  800667:	e8 cc f9 ff ff       	call   800038 <_main>
  80066c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80066f:	e8 b7 15 00 00       	call   801c2b <sys_disable_interrupt>
	cprintf("**************************************\n");
  800674:	83 ec 0c             	sub    $0xc,%esp
  800677:	68 2c 24 80 00       	push   $0x80242c
  80067c:	e8 3c 03 00 00       	call   8009bd <cprintf>
  800681:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800684:	a1 08 30 80 00       	mov    0x803008,%eax
  800689:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80068f:	a1 08 30 80 00       	mov    0x803008,%eax
  800694:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80069a:	83 ec 04             	sub    $0x4,%esp
  80069d:	52                   	push   %edx
  80069e:	50                   	push   %eax
  80069f:	68 54 24 80 00       	push   $0x802454
  8006a4:	e8 14 03 00 00       	call   8009bd <cprintf>
  8006a9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006ac:	a1 08 30 80 00       	mov    0x803008,%eax
  8006b1:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8006b7:	83 ec 08             	sub    $0x8,%esp
  8006ba:	50                   	push   %eax
  8006bb:	68 79 24 80 00       	push   $0x802479
  8006c0:	e8 f8 02 00 00       	call   8009bd <cprintf>
  8006c5:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006c8:	83 ec 0c             	sub    $0xc,%esp
  8006cb:	68 2c 24 80 00       	push   $0x80242c
  8006d0:	e8 e8 02 00 00       	call   8009bd <cprintf>
  8006d5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006d8:	e8 68 15 00 00       	call   801c45 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006dd:	e8 19 00 00 00       	call   8006fb <exit>
}
  8006e2:	90                   	nop
  8006e3:	c9                   	leave  
  8006e4:	c3                   	ret    

008006e5 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006e5:	55                   	push   %ebp
  8006e6:	89 e5                	mov    %esp,%ebp
  8006e8:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006eb:	83 ec 0c             	sub    $0xc,%esp
  8006ee:	6a 00                	push   $0x0
  8006f0:	e8 67 13 00 00       	call   801a5c <sys_env_destroy>
  8006f5:	83 c4 10             	add    $0x10,%esp
}
  8006f8:	90                   	nop
  8006f9:	c9                   	leave  
  8006fa:	c3                   	ret    

008006fb <exit>:

void
exit(void)
{
  8006fb:	55                   	push   %ebp
  8006fc:	89 e5                	mov    %esp,%ebp
  8006fe:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800701:	e8 bc 13 00 00       	call   801ac2 <sys_env_exit>
}
  800706:	90                   	nop
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
  80070c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80070f:	8d 45 10             	lea    0x10(%ebp),%eax
  800712:	83 c0 04             	add    $0x4,%eax
  800715:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800718:	a1 18 30 80 00       	mov    0x803018,%eax
  80071d:	85 c0                	test   %eax,%eax
  80071f:	74 16                	je     800737 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800721:	a1 18 30 80 00       	mov    0x803018,%eax
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	50                   	push   %eax
  80072a:	68 90 24 80 00       	push   $0x802490
  80072f:	e8 89 02 00 00       	call   8009bd <cprintf>
  800734:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800737:	a1 00 30 80 00       	mov    0x803000,%eax
  80073c:	ff 75 0c             	pushl  0xc(%ebp)
  80073f:	ff 75 08             	pushl  0x8(%ebp)
  800742:	50                   	push   %eax
  800743:	68 95 24 80 00       	push   $0x802495
  800748:	e8 70 02 00 00       	call   8009bd <cprintf>
  80074d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800750:	8b 45 10             	mov    0x10(%ebp),%eax
  800753:	83 ec 08             	sub    $0x8,%esp
  800756:	ff 75 f4             	pushl  -0xc(%ebp)
  800759:	50                   	push   %eax
  80075a:	e8 f3 01 00 00       	call   800952 <vcprintf>
  80075f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800762:	83 ec 08             	sub    $0x8,%esp
  800765:	6a 00                	push   $0x0
  800767:	68 b1 24 80 00       	push   $0x8024b1
  80076c:	e8 e1 01 00 00       	call   800952 <vcprintf>
  800771:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800774:	e8 82 ff ff ff       	call   8006fb <exit>

	// should not return here
	while (1) ;
  800779:	eb fe                	jmp    800779 <_panic+0x70>

0080077b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80077b:	55                   	push   %ebp
  80077c:	89 e5                	mov    %esp,%ebp
  80077e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800781:	a1 08 30 80 00       	mov    0x803008,%eax
  800786:	8b 50 74             	mov    0x74(%eax),%edx
  800789:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078c:	39 c2                	cmp    %eax,%edx
  80078e:	74 14                	je     8007a4 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800790:	83 ec 04             	sub    $0x4,%esp
  800793:	68 b4 24 80 00       	push   $0x8024b4
  800798:	6a 26                	push   $0x26
  80079a:	68 00 25 80 00       	push   $0x802500
  80079f:	e8 65 ff ff ff       	call   800709 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007b2:	e9 c2 00 00 00       	jmp    800879 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c4:	01 d0                	add    %edx,%eax
  8007c6:	8b 00                	mov    (%eax),%eax
  8007c8:	85 c0                	test   %eax,%eax
  8007ca:	75 08                	jne    8007d4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007cc:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007cf:	e9 a2 00 00 00       	jmp    800876 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007db:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007e2:	eb 69                	jmp    80084d <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007e4:	a1 08 30 80 00       	mov    0x803008,%eax
  8007e9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007ef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007f2:	89 d0                	mov    %edx,%eax
  8007f4:	01 c0                	add    %eax,%eax
  8007f6:	01 d0                	add    %edx,%eax
  8007f8:	c1 e0 02             	shl    $0x2,%eax
  8007fb:	01 c8                	add    %ecx,%eax
  8007fd:	8a 40 04             	mov    0x4(%eax),%al
  800800:	84 c0                	test   %al,%al
  800802:	75 46                	jne    80084a <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800804:	a1 08 30 80 00       	mov    0x803008,%eax
  800809:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80080f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800812:	89 d0                	mov    %edx,%eax
  800814:	01 c0                	add    %eax,%eax
  800816:	01 d0                	add    %edx,%eax
  800818:	c1 e0 02             	shl    $0x2,%eax
  80081b:	01 c8                	add    %ecx,%eax
  80081d:	8b 00                	mov    (%eax),%eax
  80081f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800822:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800825:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80082a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80082c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80082f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	01 c8                	add    %ecx,%eax
  80083b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80083d:	39 c2                	cmp    %eax,%edx
  80083f:	75 09                	jne    80084a <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800841:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800848:	eb 12                	jmp    80085c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80084a:	ff 45 e8             	incl   -0x18(%ebp)
  80084d:	a1 08 30 80 00       	mov    0x803008,%eax
  800852:	8b 50 74             	mov    0x74(%eax),%edx
  800855:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800858:	39 c2                	cmp    %eax,%edx
  80085a:	77 88                	ja     8007e4 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80085c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800860:	75 14                	jne    800876 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800862:	83 ec 04             	sub    $0x4,%esp
  800865:	68 0c 25 80 00       	push   $0x80250c
  80086a:	6a 3a                	push   $0x3a
  80086c:	68 00 25 80 00       	push   $0x802500
  800871:	e8 93 fe ff ff       	call   800709 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800876:	ff 45 f0             	incl   -0x10(%ebp)
  800879:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80087c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80087f:	0f 8c 32 ff ff ff    	jl     8007b7 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800885:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80088c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800893:	eb 26                	jmp    8008bb <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800895:	a1 08 30 80 00       	mov    0x803008,%eax
  80089a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008a0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008a3:	89 d0                	mov    %edx,%eax
  8008a5:	01 c0                	add    %eax,%eax
  8008a7:	01 d0                	add    %edx,%eax
  8008a9:	c1 e0 02             	shl    $0x2,%eax
  8008ac:	01 c8                	add    %ecx,%eax
  8008ae:	8a 40 04             	mov    0x4(%eax),%al
  8008b1:	3c 01                	cmp    $0x1,%al
  8008b3:	75 03                	jne    8008b8 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008b5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b8:	ff 45 e0             	incl   -0x20(%ebp)
  8008bb:	a1 08 30 80 00       	mov    0x803008,%eax
  8008c0:	8b 50 74             	mov    0x74(%eax),%edx
  8008c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c6:	39 c2                	cmp    %eax,%edx
  8008c8:	77 cb                	ja     800895 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008cd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008d0:	74 14                	je     8008e6 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008d2:	83 ec 04             	sub    $0x4,%esp
  8008d5:	68 60 25 80 00       	push   $0x802560
  8008da:	6a 44                	push   $0x44
  8008dc:	68 00 25 80 00       	push   $0x802500
  8008e1:	e8 23 fe ff ff       	call   800709 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008e6:	90                   	nop
  8008e7:	c9                   	leave  
  8008e8:	c3                   	ret    

008008e9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008e9:	55                   	push   %ebp
  8008ea:	89 e5                	mov    %esp,%ebp
  8008ec:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f2:	8b 00                	mov    (%eax),%eax
  8008f4:	8d 48 01             	lea    0x1(%eax),%ecx
  8008f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008fa:	89 0a                	mov    %ecx,(%edx)
  8008fc:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ff:	88 d1                	mov    %dl,%cl
  800901:	8b 55 0c             	mov    0xc(%ebp),%edx
  800904:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800908:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090b:	8b 00                	mov    (%eax),%eax
  80090d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800912:	75 2c                	jne    800940 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800914:	a0 0c 30 80 00       	mov    0x80300c,%al
  800919:	0f b6 c0             	movzbl %al,%eax
  80091c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091f:	8b 12                	mov    (%edx),%edx
  800921:	89 d1                	mov    %edx,%ecx
  800923:	8b 55 0c             	mov    0xc(%ebp),%edx
  800926:	83 c2 08             	add    $0x8,%edx
  800929:	83 ec 04             	sub    $0x4,%esp
  80092c:	50                   	push   %eax
  80092d:	51                   	push   %ecx
  80092e:	52                   	push   %edx
  80092f:	e8 e6 10 00 00       	call   801a1a <sys_cputs>
  800934:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800937:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800940:	8b 45 0c             	mov    0xc(%ebp),%eax
  800943:	8b 40 04             	mov    0x4(%eax),%eax
  800946:	8d 50 01             	lea    0x1(%eax),%edx
  800949:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80094f:	90                   	nop
  800950:	c9                   	leave  
  800951:	c3                   	ret    

00800952 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800952:	55                   	push   %ebp
  800953:	89 e5                	mov    %esp,%ebp
  800955:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80095b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800962:	00 00 00 
	b.cnt = 0;
  800965:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80096c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80096f:	ff 75 0c             	pushl  0xc(%ebp)
  800972:	ff 75 08             	pushl  0x8(%ebp)
  800975:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80097b:	50                   	push   %eax
  80097c:	68 e9 08 80 00       	push   $0x8008e9
  800981:	e8 11 02 00 00       	call   800b97 <vprintfmt>
  800986:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800989:	a0 0c 30 80 00       	mov    0x80300c,%al
  80098e:	0f b6 c0             	movzbl %al,%eax
  800991:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800997:	83 ec 04             	sub    $0x4,%esp
  80099a:	50                   	push   %eax
  80099b:	52                   	push   %edx
  80099c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009a2:	83 c0 08             	add    $0x8,%eax
  8009a5:	50                   	push   %eax
  8009a6:	e8 6f 10 00 00       	call   801a1a <sys_cputs>
  8009ab:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009ae:	c6 05 0c 30 80 00 00 	movb   $0x0,0x80300c
	return b.cnt;
  8009b5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009bb:	c9                   	leave  
  8009bc:	c3                   	ret    

008009bd <cprintf>:

int cprintf(const char *fmt, ...) {
  8009bd:	55                   	push   %ebp
  8009be:	89 e5                	mov    %esp,%ebp
  8009c0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009c3:	c6 05 0c 30 80 00 01 	movb   $0x1,0x80300c
	va_start(ap, fmt);
  8009ca:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d3:	83 ec 08             	sub    $0x8,%esp
  8009d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d9:	50                   	push   %eax
  8009da:	e8 73 ff ff ff       	call   800952 <vcprintf>
  8009df:	83 c4 10             	add    $0x10,%esp
  8009e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e8:	c9                   	leave  
  8009e9:	c3                   	ret    

008009ea <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009ea:	55                   	push   %ebp
  8009eb:	89 e5                	mov    %esp,%ebp
  8009ed:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009f0:	e8 36 12 00 00       	call   801c2b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009f5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fe:	83 ec 08             	sub    $0x8,%esp
  800a01:	ff 75 f4             	pushl  -0xc(%ebp)
  800a04:	50                   	push   %eax
  800a05:	e8 48 ff ff ff       	call   800952 <vcprintf>
  800a0a:	83 c4 10             	add    $0x10,%esp
  800a0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a10:	e8 30 12 00 00       	call   801c45 <sys_enable_interrupt>
	return cnt;
  800a15:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a18:	c9                   	leave  
  800a19:	c3                   	ret    

00800a1a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a1a:	55                   	push   %ebp
  800a1b:	89 e5                	mov    %esp,%ebp
  800a1d:	53                   	push   %ebx
  800a1e:	83 ec 14             	sub    $0x14,%esp
  800a21:	8b 45 10             	mov    0x10(%ebp),%eax
  800a24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a27:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a2d:	8b 45 18             	mov    0x18(%ebp),%eax
  800a30:	ba 00 00 00 00       	mov    $0x0,%edx
  800a35:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a38:	77 55                	ja     800a8f <printnum+0x75>
  800a3a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a3d:	72 05                	jb     800a44 <printnum+0x2a>
  800a3f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a42:	77 4b                	ja     800a8f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a44:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a47:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a4a:	8b 45 18             	mov    0x18(%ebp),%eax
  800a4d:	ba 00 00 00 00       	mov    $0x0,%edx
  800a52:	52                   	push   %edx
  800a53:	50                   	push   %eax
  800a54:	ff 75 f4             	pushl  -0xc(%ebp)
  800a57:	ff 75 f0             	pushl  -0x10(%ebp)
  800a5a:	e8 ad 15 00 00       	call   80200c <__udivdi3>
  800a5f:	83 c4 10             	add    $0x10,%esp
  800a62:	83 ec 04             	sub    $0x4,%esp
  800a65:	ff 75 20             	pushl  0x20(%ebp)
  800a68:	53                   	push   %ebx
  800a69:	ff 75 18             	pushl  0x18(%ebp)
  800a6c:	52                   	push   %edx
  800a6d:	50                   	push   %eax
  800a6e:	ff 75 0c             	pushl  0xc(%ebp)
  800a71:	ff 75 08             	pushl  0x8(%ebp)
  800a74:	e8 a1 ff ff ff       	call   800a1a <printnum>
  800a79:	83 c4 20             	add    $0x20,%esp
  800a7c:	eb 1a                	jmp    800a98 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a7e:	83 ec 08             	sub    $0x8,%esp
  800a81:	ff 75 0c             	pushl  0xc(%ebp)
  800a84:	ff 75 20             	pushl  0x20(%ebp)
  800a87:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8a:	ff d0                	call   *%eax
  800a8c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a8f:	ff 4d 1c             	decl   0x1c(%ebp)
  800a92:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a96:	7f e6                	jg     800a7e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a98:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a9b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aa6:	53                   	push   %ebx
  800aa7:	51                   	push   %ecx
  800aa8:	52                   	push   %edx
  800aa9:	50                   	push   %eax
  800aaa:	e8 6d 16 00 00       	call   80211c <__umoddi3>
  800aaf:	83 c4 10             	add    $0x10,%esp
  800ab2:	05 d4 27 80 00       	add    $0x8027d4,%eax
  800ab7:	8a 00                	mov    (%eax),%al
  800ab9:	0f be c0             	movsbl %al,%eax
  800abc:	83 ec 08             	sub    $0x8,%esp
  800abf:	ff 75 0c             	pushl  0xc(%ebp)
  800ac2:	50                   	push   %eax
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	ff d0                	call   *%eax
  800ac8:	83 c4 10             	add    $0x10,%esp
}
  800acb:	90                   	nop
  800acc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800acf:	c9                   	leave  
  800ad0:	c3                   	ret    

00800ad1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ad1:	55                   	push   %ebp
  800ad2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ad4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ad8:	7e 1c                	jle    800af6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	8b 00                	mov    (%eax),%eax
  800adf:	8d 50 08             	lea    0x8(%eax),%edx
  800ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae5:	89 10                	mov    %edx,(%eax)
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	8b 00                	mov    (%eax),%eax
  800aec:	83 e8 08             	sub    $0x8,%eax
  800aef:	8b 50 04             	mov    0x4(%eax),%edx
  800af2:	8b 00                	mov    (%eax),%eax
  800af4:	eb 40                	jmp    800b36 <getuint+0x65>
	else if (lflag)
  800af6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800afa:	74 1e                	je     800b1a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	8b 00                	mov    (%eax),%eax
  800b01:	8d 50 04             	lea    0x4(%eax),%edx
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	89 10                	mov    %edx,(%eax)
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	8b 00                	mov    (%eax),%eax
  800b0e:	83 e8 04             	sub    $0x4,%eax
  800b11:	8b 00                	mov    (%eax),%eax
  800b13:	ba 00 00 00 00       	mov    $0x0,%edx
  800b18:	eb 1c                	jmp    800b36 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	8b 00                	mov    (%eax),%eax
  800b1f:	8d 50 04             	lea    0x4(%eax),%edx
  800b22:	8b 45 08             	mov    0x8(%ebp),%eax
  800b25:	89 10                	mov    %edx,(%eax)
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	8b 00                	mov    (%eax),%eax
  800b2c:	83 e8 04             	sub    $0x4,%eax
  800b2f:	8b 00                	mov    (%eax),%eax
  800b31:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b36:	5d                   	pop    %ebp
  800b37:	c3                   	ret    

00800b38 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b38:	55                   	push   %ebp
  800b39:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b3b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b3f:	7e 1c                	jle    800b5d <getint+0x25>
		return va_arg(*ap, long long);
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	8b 00                	mov    (%eax),%eax
  800b46:	8d 50 08             	lea    0x8(%eax),%edx
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	89 10                	mov    %edx,(%eax)
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	8b 00                	mov    (%eax),%eax
  800b53:	83 e8 08             	sub    $0x8,%eax
  800b56:	8b 50 04             	mov    0x4(%eax),%edx
  800b59:	8b 00                	mov    (%eax),%eax
  800b5b:	eb 38                	jmp    800b95 <getint+0x5d>
	else if (lflag)
  800b5d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b61:	74 1a                	je     800b7d <getint+0x45>
		return va_arg(*ap, long);
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	8b 00                	mov    (%eax),%eax
  800b68:	8d 50 04             	lea    0x4(%eax),%edx
  800b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6e:	89 10                	mov    %edx,(%eax)
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
  800b73:	8b 00                	mov    (%eax),%eax
  800b75:	83 e8 04             	sub    $0x4,%eax
  800b78:	8b 00                	mov    (%eax),%eax
  800b7a:	99                   	cltd   
  800b7b:	eb 18                	jmp    800b95 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	8b 00                	mov    (%eax),%eax
  800b82:	8d 50 04             	lea    0x4(%eax),%edx
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	89 10                	mov    %edx,(%eax)
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	8b 00                	mov    (%eax),%eax
  800b8f:	83 e8 04             	sub    $0x4,%eax
  800b92:	8b 00                	mov    (%eax),%eax
  800b94:	99                   	cltd   
}
  800b95:	5d                   	pop    %ebp
  800b96:	c3                   	ret    

00800b97 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b97:	55                   	push   %ebp
  800b98:	89 e5                	mov    %esp,%ebp
  800b9a:	56                   	push   %esi
  800b9b:	53                   	push   %ebx
  800b9c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b9f:	eb 17                	jmp    800bb8 <vprintfmt+0x21>
			if (ch == '\0')
  800ba1:	85 db                	test   %ebx,%ebx
  800ba3:	0f 84 af 03 00 00    	je     800f58 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ba9:	83 ec 08             	sub    $0x8,%esp
  800bac:	ff 75 0c             	pushl  0xc(%ebp)
  800baf:	53                   	push   %ebx
  800bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb3:	ff d0                	call   *%eax
  800bb5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbb:	8d 50 01             	lea    0x1(%eax),%edx
  800bbe:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc1:	8a 00                	mov    (%eax),%al
  800bc3:	0f b6 d8             	movzbl %al,%ebx
  800bc6:	83 fb 25             	cmp    $0x25,%ebx
  800bc9:	75 d6                	jne    800ba1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bcb:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bcf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bd6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bdd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800be4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800beb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bee:	8d 50 01             	lea    0x1(%eax),%edx
  800bf1:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf4:	8a 00                	mov    (%eax),%al
  800bf6:	0f b6 d8             	movzbl %al,%ebx
  800bf9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bfc:	83 f8 55             	cmp    $0x55,%eax
  800bff:	0f 87 2b 03 00 00    	ja     800f30 <vprintfmt+0x399>
  800c05:	8b 04 85 f8 27 80 00 	mov    0x8027f8(,%eax,4),%eax
  800c0c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c0e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c12:	eb d7                	jmp    800beb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c14:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c18:	eb d1                	jmp    800beb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c1a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c21:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c24:	89 d0                	mov    %edx,%eax
  800c26:	c1 e0 02             	shl    $0x2,%eax
  800c29:	01 d0                	add    %edx,%eax
  800c2b:	01 c0                	add    %eax,%eax
  800c2d:	01 d8                	add    %ebx,%eax
  800c2f:	83 e8 30             	sub    $0x30,%eax
  800c32:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c35:	8b 45 10             	mov    0x10(%ebp),%eax
  800c38:	8a 00                	mov    (%eax),%al
  800c3a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c3d:	83 fb 2f             	cmp    $0x2f,%ebx
  800c40:	7e 3e                	jle    800c80 <vprintfmt+0xe9>
  800c42:	83 fb 39             	cmp    $0x39,%ebx
  800c45:	7f 39                	jg     800c80 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c47:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c4a:	eb d5                	jmp    800c21 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4f:	83 c0 04             	add    $0x4,%eax
  800c52:	89 45 14             	mov    %eax,0x14(%ebp)
  800c55:	8b 45 14             	mov    0x14(%ebp),%eax
  800c58:	83 e8 04             	sub    $0x4,%eax
  800c5b:	8b 00                	mov    (%eax),%eax
  800c5d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c60:	eb 1f                	jmp    800c81 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c66:	79 83                	jns    800beb <vprintfmt+0x54>
				width = 0;
  800c68:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c6f:	e9 77 ff ff ff       	jmp    800beb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c74:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c7b:	e9 6b ff ff ff       	jmp    800beb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c80:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c81:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c85:	0f 89 60 ff ff ff    	jns    800beb <vprintfmt+0x54>
				width = precision, precision = -1;
  800c8b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c8e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c91:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c98:	e9 4e ff ff ff       	jmp    800beb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c9d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ca0:	e9 46 ff ff ff       	jmp    800beb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ca5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca8:	83 c0 04             	add    $0x4,%eax
  800cab:	89 45 14             	mov    %eax,0x14(%ebp)
  800cae:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb1:	83 e8 04             	sub    $0x4,%eax
  800cb4:	8b 00                	mov    (%eax),%eax
  800cb6:	83 ec 08             	sub    $0x8,%esp
  800cb9:	ff 75 0c             	pushl  0xc(%ebp)
  800cbc:	50                   	push   %eax
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	ff d0                	call   *%eax
  800cc2:	83 c4 10             	add    $0x10,%esp
			break;
  800cc5:	e9 89 02 00 00       	jmp    800f53 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cca:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccd:	83 c0 04             	add    $0x4,%eax
  800cd0:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd6:	83 e8 04             	sub    $0x4,%eax
  800cd9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cdb:	85 db                	test   %ebx,%ebx
  800cdd:	79 02                	jns    800ce1 <vprintfmt+0x14a>
				err = -err;
  800cdf:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ce1:	83 fb 64             	cmp    $0x64,%ebx
  800ce4:	7f 0b                	jg     800cf1 <vprintfmt+0x15a>
  800ce6:	8b 34 9d 40 26 80 00 	mov    0x802640(,%ebx,4),%esi
  800ced:	85 f6                	test   %esi,%esi
  800cef:	75 19                	jne    800d0a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cf1:	53                   	push   %ebx
  800cf2:	68 e5 27 80 00       	push   $0x8027e5
  800cf7:	ff 75 0c             	pushl  0xc(%ebp)
  800cfa:	ff 75 08             	pushl  0x8(%ebp)
  800cfd:	e8 5e 02 00 00       	call   800f60 <printfmt>
  800d02:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d05:	e9 49 02 00 00       	jmp    800f53 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d0a:	56                   	push   %esi
  800d0b:	68 ee 27 80 00       	push   $0x8027ee
  800d10:	ff 75 0c             	pushl  0xc(%ebp)
  800d13:	ff 75 08             	pushl  0x8(%ebp)
  800d16:	e8 45 02 00 00       	call   800f60 <printfmt>
  800d1b:	83 c4 10             	add    $0x10,%esp
			break;
  800d1e:	e9 30 02 00 00       	jmp    800f53 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d23:	8b 45 14             	mov    0x14(%ebp),%eax
  800d26:	83 c0 04             	add    $0x4,%eax
  800d29:	89 45 14             	mov    %eax,0x14(%ebp)
  800d2c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2f:	83 e8 04             	sub    $0x4,%eax
  800d32:	8b 30                	mov    (%eax),%esi
  800d34:	85 f6                	test   %esi,%esi
  800d36:	75 05                	jne    800d3d <vprintfmt+0x1a6>
				p = "(null)";
  800d38:	be f1 27 80 00       	mov    $0x8027f1,%esi
			if (width > 0 && padc != '-')
  800d3d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d41:	7e 6d                	jle    800db0 <vprintfmt+0x219>
  800d43:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d47:	74 67                	je     800db0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d49:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d4c:	83 ec 08             	sub    $0x8,%esp
  800d4f:	50                   	push   %eax
  800d50:	56                   	push   %esi
  800d51:	e8 12 05 00 00       	call   801268 <strnlen>
  800d56:	83 c4 10             	add    $0x10,%esp
  800d59:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d5c:	eb 16                	jmp    800d74 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d5e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d62:	83 ec 08             	sub    $0x8,%esp
  800d65:	ff 75 0c             	pushl  0xc(%ebp)
  800d68:	50                   	push   %eax
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	ff d0                	call   *%eax
  800d6e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d71:	ff 4d e4             	decl   -0x1c(%ebp)
  800d74:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d78:	7f e4                	jg     800d5e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d7a:	eb 34                	jmp    800db0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d7c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d80:	74 1c                	je     800d9e <vprintfmt+0x207>
  800d82:	83 fb 1f             	cmp    $0x1f,%ebx
  800d85:	7e 05                	jle    800d8c <vprintfmt+0x1f5>
  800d87:	83 fb 7e             	cmp    $0x7e,%ebx
  800d8a:	7e 12                	jle    800d9e <vprintfmt+0x207>
					putch('?', putdat);
  800d8c:	83 ec 08             	sub    $0x8,%esp
  800d8f:	ff 75 0c             	pushl  0xc(%ebp)
  800d92:	6a 3f                	push   $0x3f
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	ff d0                	call   *%eax
  800d99:	83 c4 10             	add    $0x10,%esp
  800d9c:	eb 0f                	jmp    800dad <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d9e:	83 ec 08             	sub    $0x8,%esp
  800da1:	ff 75 0c             	pushl  0xc(%ebp)
  800da4:	53                   	push   %ebx
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	ff d0                	call   *%eax
  800daa:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dad:	ff 4d e4             	decl   -0x1c(%ebp)
  800db0:	89 f0                	mov    %esi,%eax
  800db2:	8d 70 01             	lea    0x1(%eax),%esi
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	0f be d8             	movsbl %al,%ebx
  800dba:	85 db                	test   %ebx,%ebx
  800dbc:	74 24                	je     800de2 <vprintfmt+0x24b>
  800dbe:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc2:	78 b8                	js     800d7c <vprintfmt+0x1e5>
  800dc4:	ff 4d e0             	decl   -0x20(%ebp)
  800dc7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dcb:	79 af                	jns    800d7c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dcd:	eb 13                	jmp    800de2 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dcf:	83 ec 08             	sub    $0x8,%esp
  800dd2:	ff 75 0c             	pushl  0xc(%ebp)
  800dd5:	6a 20                	push   $0x20
  800dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dda:	ff d0                	call   *%eax
  800ddc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ddf:	ff 4d e4             	decl   -0x1c(%ebp)
  800de2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de6:	7f e7                	jg     800dcf <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800de8:	e9 66 01 00 00       	jmp    800f53 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ded:	83 ec 08             	sub    $0x8,%esp
  800df0:	ff 75 e8             	pushl  -0x18(%ebp)
  800df3:	8d 45 14             	lea    0x14(%ebp),%eax
  800df6:	50                   	push   %eax
  800df7:	e8 3c fd ff ff       	call   800b38 <getint>
  800dfc:	83 c4 10             	add    $0x10,%esp
  800dff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e02:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e05:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e08:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e0b:	85 d2                	test   %edx,%edx
  800e0d:	79 23                	jns    800e32 <vprintfmt+0x29b>
				putch('-', putdat);
  800e0f:	83 ec 08             	sub    $0x8,%esp
  800e12:	ff 75 0c             	pushl  0xc(%ebp)
  800e15:	6a 2d                	push   $0x2d
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	ff d0                	call   *%eax
  800e1c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e22:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e25:	f7 d8                	neg    %eax
  800e27:	83 d2 00             	adc    $0x0,%edx
  800e2a:	f7 da                	neg    %edx
  800e2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e32:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e39:	e9 bc 00 00 00       	jmp    800efa <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e3e:	83 ec 08             	sub    $0x8,%esp
  800e41:	ff 75 e8             	pushl  -0x18(%ebp)
  800e44:	8d 45 14             	lea    0x14(%ebp),%eax
  800e47:	50                   	push   %eax
  800e48:	e8 84 fc ff ff       	call   800ad1 <getuint>
  800e4d:	83 c4 10             	add    $0x10,%esp
  800e50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e53:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e56:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e5d:	e9 98 00 00 00       	jmp    800efa <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e62:	83 ec 08             	sub    $0x8,%esp
  800e65:	ff 75 0c             	pushl  0xc(%ebp)
  800e68:	6a 58                	push   $0x58
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	ff d0                	call   *%eax
  800e6f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e72:	83 ec 08             	sub    $0x8,%esp
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	6a 58                	push   $0x58
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	ff d0                	call   *%eax
  800e7f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e82:	83 ec 08             	sub    $0x8,%esp
  800e85:	ff 75 0c             	pushl  0xc(%ebp)
  800e88:	6a 58                	push   $0x58
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	ff d0                	call   *%eax
  800e8f:	83 c4 10             	add    $0x10,%esp
			break;
  800e92:	e9 bc 00 00 00       	jmp    800f53 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e97:	83 ec 08             	sub    $0x8,%esp
  800e9a:	ff 75 0c             	pushl  0xc(%ebp)
  800e9d:	6a 30                	push   $0x30
  800e9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea2:	ff d0                	call   *%eax
  800ea4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ea7:	83 ec 08             	sub    $0x8,%esp
  800eaa:	ff 75 0c             	pushl  0xc(%ebp)
  800ead:	6a 78                	push   $0x78
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	ff d0                	call   *%eax
  800eb4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eb7:	8b 45 14             	mov    0x14(%ebp),%eax
  800eba:	83 c0 04             	add    $0x4,%eax
  800ebd:	89 45 14             	mov    %eax,0x14(%ebp)
  800ec0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec3:	83 e8 04             	sub    $0x4,%eax
  800ec6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ec8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ecb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ed2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ed9:	eb 1f                	jmp    800efa <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800edb:	83 ec 08             	sub    $0x8,%esp
  800ede:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee4:	50                   	push   %eax
  800ee5:	e8 e7 fb ff ff       	call   800ad1 <getuint>
  800eea:	83 c4 10             	add    $0x10,%esp
  800eed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ef3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800efa:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800efe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f01:	83 ec 04             	sub    $0x4,%esp
  800f04:	52                   	push   %edx
  800f05:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f08:	50                   	push   %eax
  800f09:	ff 75 f4             	pushl  -0xc(%ebp)
  800f0c:	ff 75 f0             	pushl  -0x10(%ebp)
  800f0f:	ff 75 0c             	pushl  0xc(%ebp)
  800f12:	ff 75 08             	pushl  0x8(%ebp)
  800f15:	e8 00 fb ff ff       	call   800a1a <printnum>
  800f1a:	83 c4 20             	add    $0x20,%esp
			break;
  800f1d:	eb 34                	jmp    800f53 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f1f:	83 ec 08             	sub    $0x8,%esp
  800f22:	ff 75 0c             	pushl  0xc(%ebp)
  800f25:	53                   	push   %ebx
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	ff d0                	call   *%eax
  800f2b:	83 c4 10             	add    $0x10,%esp
			break;
  800f2e:	eb 23                	jmp    800f53 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f30:	83 ec 08             	sub    $0x8,%esp
  800f33:	ff 75 0c             	pushl  0xc(%ebp)
  800f36:	6a 25                	push   $0x25
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	ff d0                	call   *%eax
  800f3d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f40:	ff 4d 10             	decl   0x10(%ebp)
  800f43:	eb 03                	jmp    800f48 <vprintfmt+0x3b1>
  800f45:	ff 4d 10             	decl   0x10(%ebp)
  800f48:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4b:	48                   	dec    %eax
  800f4c:	8a 00                	mov    (%eax),%al
  800f4e:	3c 25                	cmp    $0x25,%al
  800f50:	75 f3                	jne    800f45 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f52:	90                   	nop
		}
	}
  800f53:	e9 47 fc ff ff       	jmp    800b9f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f58:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f59:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f5c:	5b                   	pop    %ebx
  800f5d:	5e                   	pop    %esi
  800f5e:	5d                   	pop    %ebp
  800f5f:	c3                   	ret    

00800f60 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f60:	55                   	push   %ebp
  800f61:	89 e5                	mov    %esp,%ebp
  800f63:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f66:	8d 45 10             	lea    0x10(%ebp),%eax
  800f69:	83 c0 04             	add    $0x4,%eax
  800f6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f72:	ff 75 f4             	pushl  -0xc(%ebp)
  800f75:	50                   	push   %eax
  800f76:	ff 75 0c             	pushl  0xc(%ebp)
  800f79:	ff 75 08             	pushl  0x8(%ebp)
  800f7c:	e8 16 fc ff ff       	call   800b97 <vprintfmt>
  800f81:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f84:	90                   	nop
  800f85:	c9                   	leave  
  800f86:	c3                   	ret    

00800f87 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f87:	55                   	push   %ebp
  800f88:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8d:	8b 40 08             	mov    0x8(%eax),%eax
  800f90:	8d 50 01             	lea    0x1(%eax),%edx
  800f93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f96:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9c:	8b 10                	mov    (%eax),%edx
  800f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa1:	8b 40 04             	mov    0x4(%eax),%eax
  800fa4:	39 c2                	cmp    %eax,%edx
  800fa6:	73 12                	jae    800fba <sprintputch+0x33>
		*b->buf++ = ch;
  800fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fab:	8b 00                	mov    (%eax),%eax
  800fad:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb3:	89 0a                	mov    %ecx,(%edx)
  800fb5:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb8:	88 10                	mov    %dl,(%eax)
}
  800fba:	90                   	nop
  800fbb:	5d                   	pop    %ebp
  800fbc:	c3                   	ret    

00800fbd <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fbd:	55                   	push   %ebp
  800fbe:	89 e5                	mov    %esp,%ebp
  800fc0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	01 d0                	add    %edx,%eax
  800fd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fde:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fe2:	74 06                	je     800fea <vsnprintf+0x2d>
  800fe4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe8:	7f 07                	jg     800ff1 <vsnprintf+0x34>
		return -E_INVAL;
  800fea:	b8 03 00 00 00       	mov    $0x3,%eax
  800fef:	eb 20                	jmp    801011 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ff1:	ff 75 14             	pushl  0x14(%ebp)
  800ff4:	ff 75 10             	pushl  0x10(%ebp)
  800ff7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ffa:	50                   	push   %eax
  800ffb:	68 87 0f 80 00       	push   $0x800f87
  801000:	e8 92 fb ff ff       	call   800b97 <vprintfmt>
  801005:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801008:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80100b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80100e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801011:	c9                   	leave  
  801012:	c3                   	ret    

00801013 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801013:	55                   	push   %ebp
  801014:	89 e5                	mov    %esp,%ebp
  801016:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801019:	8d 45 10             	lea    0x10(%ebp),%eax
  80101c:	83 c0 04             	add    $0x4,%eax
  80101f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801022:	8b 45 10             	mov    0x10(%ebp),%eax
  801025:	ff 75 f4             	pushl  -0xc(%ebp)
  801028:	50                   	push   %eax
  801029:	ff 75 0c             	pushl  0xc(%ebp)
  80102c:	ff 75 08             	pushl  0x8(%ebp)
  80102f:	e8 89 ff ff ff       	call   800fbd <vsnprintf>
  801034:	83 c4 10             	add    $0x10,%esp
  801037:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80103a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80103d:	c9                   	leave  
  80103e:	c3                   	ret    

0080103f <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80103f:	55                   	push   %ebp
  801040:	89 e5                	mov    %esp,%ebp
  801042:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801045:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801049:	74 13                	je     80105e <readline+0x1f>
		cprintf("%s", prompt);
  80104b:	83 ec 08             	sub    $0x8,%esp
  80104e:	ff 75 08             	pushl  0x8(%ebp)
  801051:	68 50 29 80 00       	push   $0x802950
  801056:	e8 62 f9 ff ff       	call   8009bd <cprintf>
  80105b:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80105e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801065:	83 ec 0c             	sub    $0xc,%esp
  801068:	6a 00                	push   $0x0
  80106a:	e8 81 f5 ff ff       	call   8005f0 <iscons>
  80106f:	83 c4 10             	add    $0x10,%esp
  801072:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801075:	e8 28 f5 ff ff       	call   8005a2 <getchar>
  80107a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80107d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801081:	79 22                	jns    8010a5 <readline+0x66>
			if (c != -E_EOF)
  801083:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801087:	0f 84 ad 00 00 00    	je     80113a <readline+0xfb>
				cprintf("read error: %e\n", c);
  80108d:	83 ec 08             	sub    $0x8,%esp
  801090:	ff 75 ec             	pushl  -0x14(%ebp)
  801093:	68 53 29 80 00       	push   $0x802953
  801098:	e8 20 f9 ff ff       	call   8009bd <cprintf>
  80109d:	83 c4 10             	add    $0x10,%esp
			return;
  8010a0:	e9 95 00 00 00       	jmp    80113a <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010a5:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010a9:	7e 34                	jle    8010df <readline+0xa0>
  8010ab:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010b2:	7f 2b                	jg     8010df <readline+0xa0>
			if (echoing)
  8010b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010b8:	74 0e                	je     8010c8 <readline+0x89>
				cputchar(c);
  8010ba:	83 ec 0c             	sub    $0xc,%esp
  8010bd:	ff 75 ec             	pushl  -0x14(%ebp)
  8010c0:	e8 95 f4 ff ff       	call   80055a <cputchar>
  8010c5:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010cb:	8d 50 01             	lea    0x1(%eax),%edx
  8010ce:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010d1:	89 c2                	mov    %eax,%edx
  8010d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d6:	01 d0                	add    %edx,%eax
  8010d8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010db:	88 10                	mov    %dl,(%eax)
  8010dd:	eb 56                	jmp    801135 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010df:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010e3:	75 1f                	jne    801104 <readline+0xc5>
  8010e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010e9:	7e 19                	jle    801104 <readline+0xc5>
			if (echoing)
  8010eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010ef:	74 0e                	je     8010ff <readline+0xc0>
				cputchar(c);
  8010f1:	83 ec 0c             	sub    $0xc,%esp
  8010f4:	ff 75 ec             	pushl  -0x14(%ebp)
  8010f7:	e8 5e f4 ff ff       	call   80055a <cputchar>
  8010fc:	83 c4 10             	add    $0x10,%esp

			i--;
  8010ff:	ff 4d f4             	decl   -0xc(%ebp)
  801102:	eb 31                	jmp    801135 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801104:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801108:	74 0a                	je     801114 <readline+0xd5>
  80110a:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80110e:	0f 85 61 ff ff ff    	jne    801075 <readline+0x36>
			if (echoing)
  801114:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801118:	74 0e                	je     801128 <readline+0xe9>
				cputchar(c);
  80111a:	83 ec 0c             	sub    $0xc,%esp
  80111d:	ff 75 ec             	pushl  -0x14(%ebp)
  801120:	e8 35 f4 ff ff       	call   80055a <cputchar>
  801125:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801128:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80112b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112e:	01 d0                	add    %edx,%eax
  801130:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801133:	eb 06                	jmp    80113b <readline+0xfc>
		}
	}
  801135:	e9 3b ff ff ff       	jmp    801075 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80113a:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80113b:	c9                   	leave  
  80113c:	c3                   	ret    

0080113d <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80113d:	55                   	push   %ebp
  80113e:	89 e5                	mov    %esp,%ebp
  801140:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801143:	e8 e3 0a 00 00       	call   801c2b <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801148:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80114c:	74 13                	je     801161 <atomic_readline+0x24>
		cprintf("%s", prompt);
  80114e:	83 ec 08             	sub    $0x8,%esp
  801151:	ff 75 08             	pushl  0x8(%ebp)
  801154:	68 50 29 80 00       	push   $0x802950
  801159:	e8 5f f8 ff ff       	call   8009bd <cprintf>
  80115e:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801161:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801168:	83 ec 0c             	sub    $0xc,%esp
  80116b:	6a 00                	push   $0x0
  80116d:	e8 7e f4 ff ff       	call   8005f0 <iscons>
  801172:	83 c4 10             	add    $0x10,%esp
  801175:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801178:	e8 25 f4 ff ff       	call   8005a2 <getchar>
  80117d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801180:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801184:	79 23                	jns    8011a9 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801186:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80118a:	74 13                	je     80119f <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80118c:	83 ec 08             	sub    $0x8,%esp
  80118f:	ff 75 ec             	pushl  -0x14(%ebp)
  801192:	68 53 29 80 00       	push   $0x802953
  801197:	e8 21 f8 ff ff       	call   8009bd <cprintf>
  80119c:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80119f:	e8 a1 0a 00 00       	call   801c45 <sys_enable_interrupt>
			return;
  8011a4:	e9 9a 00 00 00       	jmp    801243 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011a9:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011ad:	7e 34                	jle    8011e3 <atomic_readline+0xa6>
  8011af:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011b6:	7f 2b                	jg     8011e3 <atomic_readline+0xa6>
			if (echoing)
  8011b8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011bc:	74 0e                	je     8011cc <atomic_readline+0x8f>
				cputchar(c);
  8011be:	83 ec 0c             	sub    $0xc,%esp
  8011c1:	ff 75 ec             	pushl  -0x14(%ebp)
  8011c4:	e8 91 f3 ff ff       	call   80055a <cputchar>
  8011c9:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011cf:	8d 50 01             	lea    0x1(%eax),%edx
  8011d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011d5:	89 c2                	mov    %eax,%edx
  8011d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011da:	01 d0                	add    %edx,%eax
  8011dc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011df:	88 10                	mov    %dl,(%eax)
  8011e1:	eb 5b                	jmp    80123e <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011e3:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011e7:	75 1f                	jne    801208 <atomic_readline+0xcb>
  8011e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011ed:	7e 19                	jle    801208 <atomic_readline+0xcb>
			if (echoing)
  8011ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011f3:	74 0e                	je     801203 <atomic_readline+0xc6>
				cputchar(c);
  8011f5:	83 ec 0c             	sub    $0xc,%esp
  8011f8:	ff 75 ec             	pushl  -0x14(%ebp)
  8011fb:	e8 5a f3 ff ff       	call   80055a <cputchar>
  801200:	83 c4 10             	add    $0x10,%esp
			i--;
  801203:	ff 4d f4             	decl   -0xc(%ebp)
  801206:	eb 36                	jmp    80123e <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801208:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80120c:	74 0a                	je     801218 <atomic_readline+0xdb>
  80120e:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801212:	0f 85 60 ff ff ff    	jne    801178 <atomic_readline+0x3b>
			if (echoing)
  801218:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80121c:	74 0e                	je     80122c <atomic_readline+0xef>
				cputchar(c);
  80121e:	83 ec 0c             	sub    $0xc,%esp
  801221:	ff 75 ec             	pushl  -0x14(%ebp)
  801224:	e8 31 f3 ff ff       	call   80055a <cputchar>
  801229:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80122c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80122f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801232:	01 d0                	add    %edx,%eax
  801234:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801237:	e8 09 0a 00 00       	call   801c45 <sys_enable_interrupt>
			return;
  80123c:	eb 05                	jmp    801243 <atomic_readline+0x106>
		}
	}
  80123e:	e9 35 ff ff ff       	jmp    801178 <atomic_readline+0x3b>
}
  801243:	c9                   	leave  
  801244:	c3                   	ret    

00801245 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801245:	55                   	push   %ebp
  801246:	89 e5                	mov    %esp,%ebp
  801248:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80124b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801252:	eb 06                	jmp    80125a <strlen+0x15>
		n++;
  801254:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801257:	ff 45 08             	incl   0x8(%ebp)
  80125a:	8b 45 08             	mov    0x8(%ebp),%eax
  80125d:	8a 00                	mov    (%eax),%al
  80125f:	84 c0                	test   %al,%al
  801261:	75 f1                	jne    801254 <strlen+0xf>
		n++;
	return n;
  801263:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801266:	c9                   	leave  
  801267:	c3                   	ret    

00801268 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801268:	55                   	push   %ebp
  801269:	89 e5                	mov    %esp,%ebp
  80126b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80126e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801275:	eb 09                	jmp    801280 <strnlen+0x18>
		n++;
  801277:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80127a:	ff 45 08             	incl   0x8(%ebp)
  80127d:	ff 4d 0c             	decl   0xc(%ebp)
  801280:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801284:	74 09                	je     80128f <strnlen+0x27>
  801286:	8b 45 08             	mov    0x8(%ebp),%eax
  801289:	8a 00                	mov    (%eax),%al
  80128b:	84 c0                	test   %al,%al
  80128d:	75 e8                	jne    801277 <strnlen+0xf>
		n++;
	return n;
  80128f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801292:	c9                   	leave  
  801293:	c3                   	ret    

00801294 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801294:	55                   	push   %ebp
  801295:	89 e5                	mov    %esp,%ebp
  801297:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012a0:	90                   	nop
  8012a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a4:	8d 50 01             	lea    0x1(%eax),%edx
  8012a7:	89 55 08             	mov    %edx,0x8(%ebp)
  8012aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ad:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012b0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012b3:	8a 12                	mov    (%edx),%dl
  8012b5:	88 10                	mov    %dl,(%eax)
  8012b7:	8a 00                	mov    (%eax),%al
  8012b9:	84 c0                	test   %al,%al
  8012bb:	75 e4                	jne    8012a1 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012c0:	c9                   	leave  
  8012c1:	c3                   	ret    

008012c2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012c2:	55                   	push   %ebp
  8012c3:	89 e5                	mov    %esp,%ebp
  8012c5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012d5:	eb 1f                	jmp    8012f6 <strncpy+0x34>
		*dst++ = *src;
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	8d 50 01             	lea    0x1(%eax),%edx
  8012dd:	89 55 08             	mov    %edx,0x8(%ebp)
  8012e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e3:	8a 12                	mov    (%edx),%dl
  8012e5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ea:	8a 00                	mov    (%eax),%al
  8012ec:	84 c0                	test   %al,%al
  8012ee:	74 03                	je     8012f3 <strncpy+0x31>
			src++;
  8012f0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012f3:	ff 45 fc             	incl   -0x4(%ebp)
  8012f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012fc:	72 d9                	jb     8012d7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801301:	c9                   	leave  
  801302:	c3                   	ret    

00801303 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801303:	55                   	push   %ebp
  801304:	89 e5                	mov    %esp,%ebp
  801306:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801309:	8b 45 08             	mov    0x8(%ebp),%eax
  80130c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80130f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801313:	74 30                	je     801345 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801315:	eb 16                	jmp    80132d <strlcpy+0x2a>
			*dst++ = *src++;
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	8d 50 01             	lea    0x1(%eax),%edx
  80131d:	89 55 08             	mov    %edx,0x8(%ebp)
  801320:	8b 55 0c             	mov    0xc(%ebp),%edx
  801323:	8d 4a 01             	lea    0x1(%edx),%ecx
  801326:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801329:	8a 12                	mov    (%edx),%dl
  80132b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80132d:	ff 4d 10             	decl   0x10(%ebp)
  801330:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801334:	74 09                	je     80133f <strlcpy+0x3c>
  801336:	8b 45 0c             	mov    0xc(%ebp),%eax
  801339:	8a 00                	mov    (%eax),%al
  80133b:	84 c0                	test   %al,%al
  80133d:	75 d8                	jne    801317 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80133f:	8b 45 08             	mov    0x8(%ebp),%eax
  801342:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801345:	8b 55 08             	mov    0x8(%ebp),%edx
  801348:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80134b:	29 c2                	sub    %eax,%edx
  80134d:	89 d0                	mov    %edx,%eax
}
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801354:	eb 06                	jmp    80135c <strcmp+0xb>
		p++, q++;
  801356:	ff 45 08             	incl   0x8(%ebp)
  801359:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80135c:	8b 45 08             	mov    0x8(%ebp),%eax
  80135f:	8a 00                	mov    (%eax),%al
  801361:	84 c0                	test   %al,%al
  801363:	74 0e                	je     801373 <strcmp+0x22>
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	8a 10                	mov    (%eax),%dl
  80136a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136d:	8a 00                	mov    (%eax),%al
  80136f:	38 c2                	cmp    %al,%dl
  801371:	74 e3                	je     801356 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	0f b6 d0             	movzbl %al,%edx
  80137b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137e:	8a 00                	mov    (%eax),%al
  801380:	0f b6 c0             	movzbl %al,%eax
  801383:	29 c2                	sub    %eax,%edx
  801385:	89 d0                	mov    %edx,%eax
}
  801387:	5d                   	pop    %ebp
  801388:	c3                   	ret    

00801389 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801389:	55                   	push   %ebp
  80138a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80138c:	eb 09                	jmp    801397 <strncmp+0xe>
		n--, p++, q++;
  80138e:	ff 4d 10             	decl   0x10(%ebp)
  801391:	ff 45 08             	incl   0x8(%ebp)
  801394:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801397:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80139b:	74 17                	je     8013b4 <strncmp+0x2b>
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	84 c0                	test   %al,%al
  8013a4:	74 0e                	je     8013b4 <strncmp+0x2b>
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	8a 10                	mov    (%eax),%dl
  8013ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ae:	8a 00                	mov    (%eax),%al
  8013b0:	38 c2                	cmp    %al,%dl
  8013b2:	74 da                	je     80138e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b8:	75 07                	jne    8013c1 <strncmp+0x38>
		return 0;
  8013ba:	b8 00 00 00 00       	mov    $0x0,%eax
  8013bf:	eb 14                	jmp    8013d5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	0f b6 d0             	movzbl %al,%edx
  8013c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013cc:	8a 00                	mov    (%eax),%al
  8013ce:	0f b6 c0             	movzbl %al,%eax
  8013d1:	29 c2                	sub    %eax,%edx
  8013d3:	89 d0                	mov    %edx,%eax
}
  8013d5:	5d                   	pop    %ebp
  8013d6:	c3                   	ret    

008013d7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013d7:	55                   	push   %ebp
  8013d8:	89 e5                	mov    %esp,%ebp
  8013da:	83 ec 04             	sub    $0x4,%esp
  8013dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013e3:	eb 12                	jmp    8013f7 <strchr+0x20>
		if (*s == c)
  8013e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e8:	8a 00                	mov    (%eax),%al
  8013ea:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013ed:	75 05                	jne    8013f4 <strchr+0x1d>
			return (char *) s;
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	eb 11                	jmp    801405 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013f4:	ff 45 08             	incl   0x8(%ebp)
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	8a 00                	mov    (%eax),%al
  8013fc:	84 c0                	test   %al,%al
  8013fe:	75 e5                	jne    8013e5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801400:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801405:	c9                   	leave  
  801406:	c3                   	ret    

00801407 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801407:	55                   	push   %ebp
  801408:	89 e5                	mov    %esp,%ebp
  80140a:	83 ec 04             	sub    $0x4,%esp
  80140d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801410:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801413:	eb 0d                	jmp    801422 <strfind+0x1b>
		if (*s == c)
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
  801418:	8a 00                	mov    (%eax),%al
  80141a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80141d:	74 0e                	je     80142d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80141f:	ff 45 08             	incl   0x8(%ebp)
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	84 c0                	test   %al,%al
  801429:	75 ea                	jne    801415 <strfind+0xe>
  80142b:	eb 01                	jmp    80142e <strfind+0x27>
		if (*s == c)
			break;
  80142d:	90                   	nop
	return (char *) s;
  80142e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801431:	c9                   	leave  
  801432:	c3                   	ret    

00801433 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
  801436:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80143f:	8b 45 10             	mov    0x10(%ebp),%eax
  801442:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801445:	eb 0e                	jmp    801455 <memset+0x22>
		*p++ = c;
  801447:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80144a:	8d 50 01             	lea    0x1(%eax),%edx
  80144d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801450:	8b 55 0c             	mov    0xc(%ebp),%edx
  801453:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801455:	ff 4d f8             	decl   -0x8(%ebp)
  801458:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80145c:	79 e9                	jns    801447 <memset+0x14>
		*p++ = c;

	return v;
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801461:	c9                   	leave  
  801462:	c3                   	ret    

00801463 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
  801466:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801469:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801475:	eb 16                	jmp    80148d <memcpy+0x2a>
		*d++ = *s++;
  801477:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80147a:	8d 50 01             	lea    0x1(%eax),%edx
  80147d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801480:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801483:	8d 4a 01             	lea    0x1(%edx),%ecx
  801486:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801489:	8a 12                	mov    (%edx),%dl
  80148b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80148d:	8b 45 10             	mov    0x10(%ebp),%eax
  801490:	8d 50 ff             	lea    -0x1(%eax),%edx
  801493:	89 55 10             	mov    %edx,0x10(%ebp)
  801496:	85 c0                	test   %eax,%eax
  801498:	75 dd                	jne    801477 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80149d:	c9                   	leave  
  80149e:	c3                   	ret    

0080149f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80149f:	55                   	push   %ebp
  8014a0:	89 e5                	mov    %esp,%ebp
  8014a2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8014a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014b7:	73 50                	jae    801509 <memmove+0x6a>
  8014b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bf:	01 d0                	add    %edx,%eax
  8014c1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014c4:	76 43                	jbe    801509 <memmove+0x6a>
		s += n;
  8014c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c9:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8014cf:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014d2:	eb 10                	jmp    8014e4 <memmove+0x45>
			*--d = *--s;
  8014d4:	ff 4d f8             	decl   -0x8(%ebp)
  8014d7:	ff 4d fc             	decl   -0x4(%ebp)
  8014da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014dd:	8a 10                	mov    (%eax),%dl
  8014df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ea:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ed:	85 c0                	test   %eax,%eax
  8014ef:	75 e3                	jne    8014d4 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014f1:	eb 23                	jmp    801516 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f6:	8d 50 01             	lea    0x1(%eax),%edx
  8014f9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ff:	8d 4a 01             	lea    0x1(%edx),%ecx
  801502:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801505:	8a 12                	mov    (%edx),%dl
  801507:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801509:	8b 45 10             	mov    0x10(%ebp),%eax
  80150c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80150f:	89 55 10             	mov    %edx,0x10(%ebp)
  801512:	85 c0                	test   %eax,%eax
  801514:	75 dd                	jne    8014f3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801519:	c9                   	leave  
  80151a:	c3                   	ret    

0080151b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80151b:	55                   	push   %ebp
  80151c:	89 e5                	mov    %esp,%ebp
  80151e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801521:	8b 45 08             	mov    0x8(%ebp),%eax
  801524:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801527:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80152d:	eb 2a                	jmp    801559 <memcmp+0x3e>
		if (*s1 != *s2)
  80152f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801532:	8a 10                	mov    (%eax),%dl
  801534:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801537:	8a 00                	mov    (%eax),%al
  801539:	38 c2                	cmp    %al,%dl
  80153b:	74 16                	je     801553 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80153d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801540:	8a 00                	mov    (%eax),%al
  801542:	0f b6 d0             	movzbl %al,%edx
  801545:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801548:	8a 00                	mov    (%eax),%al
  80154a:	0f b6 c0             	movzbl %al,%eax
  80154d:	29 c2                	sub    %eax,%edx
  80154f:	89 d0                	mov    %edx,%eax
  801551:	eb 18                	jmp    80156b <memcmp+0x50>
		s1++, s2++;
  801553:	ff 45 fc             	incl   -0x4(%ebp)
  801556:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801559:	8b 45 10             	mov    0x10(%ebp),%eax
  80155c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80155f:	89 55 10             	mov    %edx,0x10(%ebp)
  801562:	85 c0                	test   %eax,%eax
  801564:	75 c9                	jne    80152f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801566:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
  801570:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801573:	8b 55 08             	mov    0x8(%ebp),%edx
  801576:	8b 45 10             	mov    0x10(%ebp),%eax
  801579:	01 d0                	add    %edx,%eax
  80157b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80157e:	eb 15                	jmp    801595 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801580:	8b 45 08             	mov    0x8(%ebp),%eax
  801583:	8a 00                	mov    (%eax),%al
  801585:	0f b6 d0             	movzbl %al,%edx
  801588:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158b:	0f b6 c0             	movzbl %al,%eax
  80158e:	39 c2                	cmp    %eax,%edx
  801590:	74 0d                	je     80159f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801592:	ff 45 08             	incl   0x8(%ebp)
  801595:	8b 45 08             	mov    0x8(%ebp),%eax
  801598:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80159b:	72 e3                	jb     801580 <memfind+0x13>
  80159d:	eb 01                	jmp    8015a0 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80159f:	90                   	nop
	return (void *) s;
  8015a0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015a3:	c9                   	leave  
  8015a4:	c3                   	ret    

008015a5 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015a5:	55                   	push   %ebp
  8015a6:	89 e5                	mov    %esp,%ebp
  8015a8:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015b2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015b9:	eb 03                	jmp    8015be <strtol+0x19>
		s++;
  8015bb:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015be:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c1:	8a 00                	mov    (%eax),%al
  8015c3:	3c 20                	cmp    $0x20,%al
  8015c5:	74 f4                	je     8015bb <strtol+0x16>
  8015c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ca:	8a 00                	mov    (%eax),%al
  8015cc:	3c 09                	cmp    $0x9,%al
  8015ce:	74 eb                	je     8015bb <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	8a 00                	mov    (%eax),%al
  8015d5:	3c 2b                	cmp    $0x2b,%al
  8015d7:	75 05                	jne    8015de <strtol+0x39>
		s++;
  8015d9:	ff 45 08             	incl   0x8(%ebp)
  8015dc:	eb 13                	jmp    8015f1 <strtol+0x4c>
	else if (*s == '-')
  8015de:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e1:	8a 00                	mov    (%eax),%al
  8015e3:	3c 2d                	cmp    $0x2d,%al
  8015e5:	75 0a                	jne    8015f1 <strtol+0x4c>
		s++, neg = 1;
  8015e7:	ff 45 08             	incl   0x8(%ebp)
  8015ea:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015f1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015f5:	74 06                	je     8015fd <strtol+0x58>
  8015f7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015fb:	75 20                	jne    80161d <strtol+0x78>
  8015fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801600:	8a 00                	mov    (%eax),%al
  801602:	3c 30                	cmp    $0x30,%al
  801604:	75 17                	jne    80161d <strtol+0x78>
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
  801609:	40                   	inc    %eax
  80160a:	8a 00                	mov    (%eax),%al
  80160c:	3c 78                	cmp    $0x78,%al
  80160e:	75 0d                	jne    80161d <strtol+0x78>
		s += 2, base = 16;
  801610:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801614:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80161b:	eb 28                	jmp    801645 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80161d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801621:	75 15                	jne    801638 <strtol+0x93>
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
  801626:	8a 00                	mov    (%eax),%al
  801628:	3c 30                	cmp    $0x30,%al
  80162a:	75 0c                	jne    801638 <strtol+0x93>
		s++, base = 8;
  80162c:	ff 45 08             	incl   0x8(%ebp)
  80162f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801636:	eb 0d                	jmp    801645 <strtol+0xa0>
	else if (base == 0)
  801638:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80163c:	75 07                	jne    801645 <strtol+0xa0>
		base = 10;
  80163e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
  801648:	8a 00                	mov    (%eax),%al
  80164a:	3c 2f                	cmp    $0x2f,%al
  80164c:	7e 19                	jle    801667 <strtol+0xc2>
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8a 00                	mov    (%eax),%al
  801653:	3c 39                	cmp    $0x39,%al
  801655:	7f 10                	jg     801667 <strtol+0xc2>
			dig = *s - '0';
  801657:	8b 45 08             	mov    0x8(%ebp),%eax
  80165a:	8a 00                	mov    (%eax),%al
  80165c:	0f be c0             	movsbl %al,%eax
  80165f:	83 e8 30             	sub    $0x30,%eax
  801662:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801665:	eb 42                	jmp    8016a9 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	8a 00                	mov    (%eax),%al
  80166c:	3c 60                	cmp    $0x60,%al
  80166e:	7e 19                	jle    801689 <strtol+0xe4>
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	8a 00                	mov    (%eax),%al
  801675:	3c 7a                	cmp    $0x7a,%al
  801677:	7f 10                	jg     801689 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	8a 00                	mov    (%eax),%al
  80167e:	0f be c0             	movsbl %al,%eax
  801681:	83 e8 57             	sub    $0x57,%eax
  801684:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801687:	eb 20                	jmp    8016a9 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
  80168c:	8a 00                	mov    (%eax),%al
  80168e:	3c 40                	cmp    $0x40,%al
  801690:	7e 39                	jle    8016cb <strtol+0x126>
  801692:	8b 45 08             	mov    0x8(%ebp),%eax
  801695:	8a 00                	mov    (%eax),%al
  801697:	3c 5a                	cmp    $0x5a,%al
  801699:	7f 30                	jg     8016cb <strtol+0x126>
			dig = *s - 'A' + 10;
  80169b:	8b 45 08             	mov    0x8(%ebp),%eax
  80169e:	8a 00                	mov    (%eax),%al
  8016a0:	0f be c0             	movsbl %al,%eax
  8016a3:	83 e8 37             	sub    $0x37,%eax
  8016a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016ac:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016af:	7d 19                	jge    8016ca <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016b1:	ff 45 08             	incl   0x8(%ebp)
  8016b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b7:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016bb:	89 c2                	mov    %eax,%edx
  8016bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c0:	01 d0                	add    %edx,%eax
  8016c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016c5:	e9 7b ff ff ff       	jmp    801645 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016ca:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016cf:	74 08                	je     8016d9 <strtol+0x134>
		*endptr = (char *) s;
  8016d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d4:	8b 55 08             	mov    0x8(%ebp),%edx
  8016d7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016d9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016dd:	74 07                	je     8016e6 <strtol+0x141>
  8016df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e2:	f7 d8                	neg    %eax
  8016e4:	eb 03                	jmp    8016e9 <strtol+0x144>
  8016e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016e9:	c9                   	leave  
  8016ea:	c3                   	ret    

008016eb <ltostr>:

void
ltostr(long value, char *str)
{
  8016eb:	55                   	push   %ebp
  8016ec:	89 e5                	mov    %esp,%ebp
  8016ee:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016f1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016f8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016ff:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801703:	79 13                	jns    801718 <ltostr+0x2d>
	{
		neg = 1;
  801705:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80170c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801712:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801715:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801718:	8b 45 08             	mov    0x8(%ebp),%eax
  80171b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801720:	99                   	cltd   
  801721:	f7 f9                	idiv   %ecx
  801723:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801726:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801729:	8d 50 01             	lea    0x1(%eax),%edx
  80172c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80172f:	89 c2                	mov    %eax,%edx
  801731:	8b 45 0c             	mov    0xc(%ebp),%eax
  801734:	01 d0                	add    %edx,%eax
  801736:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801739:	83 c2 30             	add    $0x30,%edx
  80173c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80173e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801741:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801746:	f7 e9                	imul   %ecx
  801748:	c1 fa 02             	sar    $0x2,%edx
  80174b:	89 c8                	mov    %ecx,%eax
  80174d:	c1 f8 1f             	sar    $0x1f,%eax
  801750:	29 c2                	sub    %eax,%edx
  801752:	89 d0                	mov    %edx,%eax
  801754:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801757:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80175a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80175f:	f7 e9                	imul   %ecx
  801761:	c1 fa 02             	sar    $0x2,%edx
  801764:	89 c8                	mov    %ecx,%eax
  801766:	c1 f8 1f             	sar    $0x1f,%eax
  801769:	29 c2                	sub    %eax,%edx
  80176b:	89 d0                	mov    %edx,%eax
  80176d:	c1 e0 02             	shl    $0x2,%eax
  801770:	01 d0                	add    %edx,%eax
  801772:	01 c0                	add    %eax,%eax
  801774:	29 c1                	sub    %eax,%ecx
  801776:	89 ca                	mov    %ecx,%edx
  801778:	85 d2                	test   %edx,%edx
  80177a:	75 9c                	jne    801718 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80177c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801783:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801786:	48                   	dec    %eax
  801787:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80178a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80178e:	74 3d                	je     8017cd <ltostr+0xe2>
		start = 1 ;
  801790:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801797:	eb 34                	jmp    8017cd <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801799:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80179c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179f:	01 d0                	add    %edx,%eax
  8017a1:	8a 00                	mov    (%eax),%al
  8017a3:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ac:	01 c2                	add    %eax,%edx
  8017ae:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b4:	01 c8                	add    %ecx,%eax
  8017b6:	8a 00                	mov    (%eax),%al
  8017b8:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017ba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c0:	01 c2                	add    %eax,%edx
  8017c2:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017c5:	88 02                	mov    %al,(%edx)
		start++ ;
  8017c7:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017ca:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017d0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017d3:	7c c4                	jl     801799 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017d5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017db:	01 d0                	add    %edx,%eax
  8017dd:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017e0:	90                   	nop
  8017e1:	c9                   	leave  
  8017e2:	c3                   	ret    

008017e3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017e3:	55                   	push   %ebp
  8017e4:	89 e5                	mov    %esp,%ebp
  8017e6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017e9:	ff 75 08             	pushl  0x8(%ebp)
  8017ec:	e8 54 fa ff ff       	call   801245 <strlen>
  8017f1:	83 c4 04             	add    $0x4,%esp
  8017f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017f7:	ff 75 0c             	pushl  0xc(%ebp)
  8017fa:	e8 46 fa ff ff       	call   801245 <strlen>
  8017ff:	83 c4 04             	add    $0x4,%esp
  801802:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801805:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80180c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801813:	eb 17                	jmp    80182c <strcconcat+0x49>
		final[s] = str1[s] ;
  801815:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801818:	8b 45 10             	mov    0x10(%ebp),%eax
  80181b:	01 c2                	add    %eax,%edx
  80181d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801820:	8b 45 08             	mov    0x8(%ebp),%eax
  801823:	01 c8                	add    %ecx,%eax
  801825:	8a 00                	mov    (%eax),%al
  801827:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801829:	ff 45 fc             	incl   -0x4(%ebp)
  80182c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80182f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801832:	7c e1                	jl     801815 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801834:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80183b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801842:	eb 1f                	jmp    801863 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801844:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801847:	8d 50 01             	lea    0x1(%eax),%edx
  80184a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80184d:	89 c2                	mov    %eax,%edx
  80184f:	8b 45 10             	mov    0x10(%ebp),%eax
  801852:	01 c2                	add    %eax,%edx
  801854:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801857:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185a:	01 c8                	add    %ecx,%eax
  80185c:	8a 00                	mov    (%eax),%al
  80185e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801860:	ff 45 f8             	incl   -0x8(%ebp)
  801863:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801866:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801869:	7c d9                	jl     801844 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80186b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80186e:	8b 45 10             	mov    0x10(%ebp),%eax
  801871:	01 d0                	add    %edx,%eax
  801873:	c6 00 00             	movb   $0x0,(%eax)
}
  801876:	90                   	nop
  801877:	c9                   	leave  
  801878:	c3                   	ret    

00801879 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80187c:	8b 45 14             	mov    0x14(%ebp),%eax
  80187f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801885:	8b 45 14             	mov    0x14(%ebp),%eax
  801888:	8b 00                	mov    (%eax),%eax
  80188a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801891:	8b 45 10             	mov    0x10(%ebp),%eax
  801894:	01 d0                	add    %edx,%eax
  801896:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80189c:	eb 0c                	jmp    8018aa <strsplit+0x31>
			*string++ = 0;
  80189e:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a1:	8d 50 01             	lea    0x1(%eax),%edx
  8018a4:	89 55 08             	mov    %edx,0x8(%ebp)
  8018a7:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	8a 00                	mov    (%eax),%al
  8018af:	84 c0                	test   %al,%al
  8018b1:	74 18                	je     8018cb <strsplit+0x52>
  8018b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b6:	8a 00                	mov    (%eax),%al
  8018b8:	0f be c0             	movsbl %al,%eax
  8018bb:	50                   	push   %eax
  8018bc:	ff 75 0c             	pushl  0xc(%ebp)
  8018bf:	e8 13 fb ff ff       	call   8013d7 <strchr>
  8018c4:	83 c4 08             	add    $0x8,%esp
  8018c7:	85 c0                	test   %eax,%eax
  8018c9:	75 d3                	jne    80189e <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8018cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ce:	8a 00                	mov    (%eax),%al
  8018d0:	84 c0                	test   %al,%al
  8018d2:	74 5a                	je     80192e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8018d7:	8b 00                	mov    (%eax),%eax
  8018d9:	83 f8 0f             	cmp    $0xf,%eax
  8018dc:	75 07                	jne    8018e5 <strsplit+0x6c>
		{
			return 0;
  8018de:	b8 00 00 00 00       	mov    $0x0,%eax
  8018e3:	eb 66                	jmp    80194b <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e8:	8b 00                	mov    (%eax),%eax
  8018ea:	8d 48 01             	lea    0x1(%eax),%ecx
  8018ed:	8b 55 14             	mov    0x14(%ebp),%edx
  8018f0:	89 0a                	mov    %ecx,(%edx)
  8018f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018fc:	01 c2                	add    %eax,%edx
  8018fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801901:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801903:	eb 03                	jmp    801908 <strsplit+0x8f>
			string++;
  801905:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801908:	8b 45 08             	mov    0x8(%ebp),%eax
  80190b:	8a 00                	mov    (%eax),%al
  80190d:	84 c0                	test   %al,%al
  80190f:	74 8b                	je     80189c <strsplit+0x23>
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	8a 00                	mov    (%eax),%al
  801916:	0f be c0             	movsbl %al,%eax
  801919:	50                   	push   %eax
  80191a:	ff 75 0c             	pushl  0xc(%ebp)
  80191d:	e8 b5 fa ff ff       	call   8013d7 <strchr>
  801922:	83 c4 08             	add    $0x8,%esp
  801925:	85 c0                	test   %eax,%eax
  801927:	74 dc                	je     801905 <strsplit+0x8c>
			string++;
	}
  801929:	e9 6e ff ff ff       	jmp    80189c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80192e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80192f:	8b 45 14             	mov    0x14(%ebp),%eax
  801932:	8b 00                	mov    (%eax),%eax
  801934:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80193b:	8b 45 10             	mov    0x10(%ebp),%eax
  80193e:	01 d0                	add    %edx,%eax
  801940:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801946:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80194b:	c9                   	leave  
  80194c:	c3                   	ret    

0080194d <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  80194d:	55                   	push   %ebp
  80194e:	89 e5                	mov    %esp,%ebp
  801950:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801953:	83 ec 04             	sub    $0x4,%esp
  801956:	68 64 29 80 00       	push   $0x802964
  80195b:	6a 19                	push   $0x19
  80195d:	68 89 29 80 00       	push   $0x802989
  801962:	e8 a2 ed ff ff       	call   800709 <_panic>

00801967 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801967:	55                   	push   %ebp
  801968:	89 e5                	mov    %esp,%ebp
  80196a:	83 ec 18             	sub    $0x18,%esp
  80196d:	8b 45 10             	mov    0x10(%ebp),%eax
  801970:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801973:	83 ec 04             	sub    $0x4,%esp
  801976:	68 98 29 80 00       	push   $0x802998
  80197b:	6a 30                	push   $0x30
  80197d:	68 89 29 80 00       	push   $0x802989
  801982:	e8 82 ed ff ff       	call   800709 <_panic>

00801987 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801987:	55                   	push   %ebp
  801988:	89 e5                	mov    %esp,%ebp
  80198a:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  80198d:	83 ec 04             	sub    $0x4,%esp
  801990:	68 b7 29 80 00       	push   $0x8029b7
  801995:	6a 36                	push   $0x36
  801997:	68 89 29 80 00       	push   $0x802989
  80199c:	e8 68 ed ff ff       	call   800709 <_panic>

008019a1 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
  8019a4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8019a7:	83 ec 04             	sub    $0x4,%esp
  8019aa:	68 d4 29 80 00       	push   $0x8029d4
  8019af:	6a 48                	push   $0x48
  8019b1:	68 89 29 80 00       	push   $0x802989
  8019b6:	e8 4e ed ff ff       	call   800709 <_panic>

008019bb <sfree>:

}


void sfree(void* virtual_address)
{
  8019bb:	55                   	push   %ebp
  8019bc:	89 e5                	mov    %esp,%ebp
  8019be:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8019c1:	83 ec 04             	sub    $0x4,%esp
  8019c4:	68 f7 29 80 00       	push   $0x8029f7
  8019c9:	6a 53                	push   $0x53
  8019cb:	68 89 29 80 00       	push   $0x802989
  8019d0:	e8 34 ed ff ff       	call   800709 <_panic>

008019d5 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8019d5:	55                   	push   %ebp
  8019d6:	89 e5                	mov    %esp,%ebp
  8019d8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8019db:	83 ec 04             	sub    $0x4,%esp
  8019de:	68 14 2a 80 00       	push   $0x802a14
  8019e3:	6a 6c                	push   $0x6c
  8019e5:	68 89 29 80 00       	push   $0x802989
  8019ea:	e8 1a ed ff ff       	call   800709 <_panic>

008019ef <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019ef:	55                   	push   %ebp
  8019f0:	89 e5                	mov    %esp,%ebp
  8019f2:	57                   	push   %edi
  8019f3:	56                   	push   %esi
  8019f4:	53                   	push   %ebx
  8019f5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a01:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a04:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a07:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a0a:	cd 30                	int    $0x30
  801a0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a12:	83 c4 10             	add    $0x10,%esp
  801a15:	5b                   	pop    %ebx
  801a16:	5e                   	pop    %esi
  801a17:	5f                   	pop    %edi
  801a18:	5d                   	pop    %ebp
  801a19:	c3                   	ret    

00801a1a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a1a:	55                   	push   %ebp
  801a1b:	89 e5                	mov    %esp,%ebp
  801a1d:	83 ec 04             	sub    $0x4,%esp
  801a20:	8b 45 10             	mov    0x10(%ebp),%eax
  801a23:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a26:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	52                   	push   %edx
  801a32:	ff 75 0c             	pushl  0xc(%ebp)
  801a35:	50                   	push   %eax
  801a36:	6a 00                	push   $0x0
  801a38:	e8 b2 ff ff ff       	call   8019ef <syscall>
  801a3d:	83 c4 18             	add    $0x18,%esp
}
  801a40:	90                   	nop
  801a41:	c9                   	leave  
  801a42:	c3                   	ret    

00801a43 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a43:	55                   	push   %ebp
  801a44:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 01                	push   $0x1
  801a52:	e8 98 ff ff ff       	call   8019ef <syscall>
  801a57:	83 c4 18             	add    $0x18,%esp
}
  801a5a:	c9                   	leave  
  801a5b:	c3                   	ret    

00801a5c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a5c:	55                   	push   %ebp
  801a5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	50                   	push   %eax
  801a6b:	6a 05                	push   $0x5
  801a6d:	e8 7d ff ff ff       	call   8019ef <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
}
  801a75:	c9                   	leave  
  801a76:	c3                   	ret    

00801a77 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a77:	55                   	push   %ebp
  801a78:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 02                	push   $0x2
  801a86:	e8 64 ff ff ff       	call   8019ef <syscall>
  801a8b:	83 c4 18             	add    $0x18,%esp
}
  801a8e:	c9                   	leave  
  801a8f:	c3                   	ret    

00801a90 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a90:	55                   	push   %ebp
  801a91:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 03                	push   $0x3
  801a9f:	e8 4b ff ff ff       	call   8019ef <syscall>
  801aa4:	83 c4 18             	add    $0x18,%esp
}
  801aa7:	c9                   	leave  
  801aa8:	c3                   	ret    

00801aa9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801aa9:	55                   	push   %ebp
  801aaa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 04                	push   $0x4
  801ab8:	e8 32 ff ff ff       	call   8019ef <syscall>
  801abd:	83 c4 18             	add    $0x18,%esp
}
  801ac0:	c9                   	leave  
  801ac1:	c3                   	ret    

00801ac2 <sys_env_exit>:


void sys_env_exit(void)
{
  801ac2:	55                   	push   %ebp
  801ac3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 06                	push   $0x6
  801ad1:	e8 19 ff ff ff       	call   8019ef <syscall>
  801ad6:	83 c4 18             	add    $0x18,%esp
}
  801ad9:	90                   	nop
  801ada:	c9                   	leave  
  801adb:	c3                   	ret    

00801adc <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801adc:	55                   	push   %ebp
  801add:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801adf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	52                   	push   %edx
  801aec:	50                   	push   %eax
  801aed:	6a 07                	push   $0x7
  801aef:	e8 fb fe ff ff       	call   8019ef <syscall>
  801af4:	83 c4 18             	add    $0x18,%esp
}
  801af7:	c9                   	leave  
  801af8:	c3                   	ret    

00801af9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801af9:	55                   	push   %ebp
  801afa:	89 e5                	mov    %esp,%ebp
  801afc:	56                   	push   %esi
  801afd:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801afe:	8b 75 18             	mov    0x18(%ebp),%esi
  801b01:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b04:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b07:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0d:	56                   	push   %esi
  801b0e:	53                   	push   %ebx
  801b0f:	51                   	push   %ecx
  801b10:	52                   	push   %edx
  801b11:	50                   	push   %eax
  801b12:	6a 08                	push   $0x8
  801b14:	e8 d6 fe ff ff       	call   8019ef <syscall>
  801b19:	83 c4 18             	add    $0x18,%esp
}
  801b1c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b1f:	5b                   	pop    %ebx
  801b20:	5e                   	pop    %esi
  801b21:	5d                   	pop    %ebp
  801b22:	c3                   	ret    

00801b23 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b23:	55                   	push   %ebp
  801b24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b26:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b29:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	52                   	push   %edx
  801b33:	50                   	push   %eax
  801b34:	6a 09                	push   $0x9
  801b36:	e8 b4 fe ff ff       	call   8019ef <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
}
  801b3e:	c9                   	leave  
  801b3f:	c3                   	ret    

00801b40 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b40:	55                   	push   %ebp
  801b41:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	ff 75 0c             	pushl  0xc(%ebp)
  801b4c:	ff 75 08             	pushl  0x8(%ebp)
  801b4f:	6a 0a                	push   $0xa
  801b51:	e8 99 fe ff ff       	call   8019ef <syscall>
  801b56:	83 c4 18             	add    $0x18,%esp
}
  801b59:	c9                   	leave  
  801b5a:	c3                   	ret    

00801b5b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b5b:	55                   	push   %ebp
  801b5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	6a 0b                	push   $0xb
  801b6a:	e8 80 fe ff ff       	call   8019ef <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
}
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 0c                	push   $0xc
  801b83:	e8 67 fe ff ff       	call   8019ef <syscall>
  801b88:	83 c4 18             	add    $0x18,%esp
}
  801b8b:	c9                   	leave  
  801b8c:	c3                   	ret    

00801b8d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b8d:	55                   	push   %ebp
  801b8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 0d                	push   $0xd
  801b9c:	e8 4e fe ff ff       	call   8019ef <syscall>
  801ba1:	83 c4 18             	add    $0x18,%esp
}
  801ba4:	c9                   	leave  
  801ba5:	c3                   	ret    

00801ba6 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ba6:	55                   	push   %ebp
  801ba7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	ff 75 0c             	pushl  0xc(%ebp)
  801bb2:	ff 75 08             	pushl  0x8(%ebp)
  801bb5:	6a 11                	push   $0x11
  801bb7:	e8 33 fe ff ff       	call   8019ef <syscall>
  801bbc:	83 c4 18             	add    $0x18,%esp
	return;
  801bbf:	90                   	nop
}
  801bc0:	c9                   	leave  
  801bc1:	c3                   	ret    

00801bc2 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801bc2:	55                   	push   %ebp
  801bc3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	ff 75 0c             	pushl  0xc(%ebp)
  801bce:	ff 75 08             	pushl  0x8(%ebp)
  801bd1:	6a 12                	push   $0x12
  801bd3:	e8 17 fe ff ff       	call   8019ef <syscall>
  801bd8:	83 c4 18             	add    $0x18,%esp
	return ;
  801bdb:	90                   	nop
}
  801bdc:	c9                   	leave  
  801bdd:	c3                   	ret    

00801bde <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801bde:	55                   	push   %ebp
  801bdf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 0e                	push   $0xe
  801bed:	e8 fd fd ff ff       	call   8019ef <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
}
  801bf5:	c9                   	leave  
  801bf6:	c3                   	ret    

00801bf7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bf7:	55                   	push   %ebp
  801bf8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	ff 75 08             	pushl  0x8(%ebp)
  801c05:	6a 0f                	push   $0xf
  801c07:	e8 e3 fd ff ff       	call   8019ef <syscall>
  801c0c:	83 c4 18             	add    $0x18,%esp
}
  801c0f:	c9                   	leave  
  801c10:	c3                   	ret    

00801c11 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c11:	55                   	push   %ebp
  801c12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 10                	push   $0x10
  801c20:	e8 ca fd ff ff       	call   8019ef <syscall>
  801c25:	83 c4 18             	add    $0x18,%esp
}
  801c28:	90                   	nop
  801c29:	c9                   	leave  
  801c2a:	c3                   	ret    

00801c2b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 14                	push   $0x14
  801c3a:	e8 b0 fd ff ff       	call   8019ef <syscall>
  801c3f:	83 c4 18             	add    $0x18,%esp
}
  801c42:	90                   	nop
  801c43:	c9                   	leave  
  801c44:	c3                   	ret    

00801c45 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c45:	55                   	push   %ebp
  801c46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 15                	push   $0x15
  801c54:	e8 96 fd ff ff       	call   8019ef <syscall>
  801c59:	83 c4 18             	add    $0x18,%esp
}
  801c5c:	90                   	nop
  801c5d:	c9                   	leave  
  801c5e:	c3                   	ret    

00801c5f <sys_cputc>:


void
sys_cputc(const char c)
{
  801c5f:	55                   	push   %ebp
  801c60:	89 e5                	mov    %esp,%ebp
  801c62:	83 ec 04             	sub    $0x4,%esp
  801c65:	8b 45 08             	mov    0x8(%ebp),%eax
  801c68:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c6b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	50                   	push   %eax
  801c78:	6a 16                	push   $0x16
  801c7a:	e8 70 fd ff ff       	call   8019ef <syscall>
  801c7f:	83 c4 18             	add    $0x18,%esp
}
  801c82:	90                   	nop
  801c83:	c9                   	leave  
  801c84:	c3                   	ret    

00801c85 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c85:	55                   	push   %ebp
  801c86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 17                	push   $0x17
  801c94:	e8 56 fd ff ff       	call   8019ef <syscall>
  801c99:	83 c4 18             	add    $0x18,%esp
}
  801c9c:	90                   	nop
  801c9d:	c9                   	leave  
  801c9e:	c3                   	ret    

00801c9f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c9f:	55                   	push   %ebp
  801ca0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	ff 75 0c             	pushl  0xc(%ebp)
  801cae:	50                   	push   %eax
  801caf:	6a 18                	push   $0x18
  801cb1:	e8 39 fd ff ff       	call   8019ef <syscall>
  801cb6:	83 c4 18             	add    $0x18,%esp
}
  801cb9:	c9                   	leave  
  801cba:	c3                   	ret    

00801cbb <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801cbb:	55                   	push   %ebp
  801cbc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	52                   	push   %edx
  801ccb:	50                   	push   %eax
  801ccc:	6a 1b                	push   $0x1b
  801cce:	e8 1c fd ff ff       	call   8019ef <syscall>
  801cd3:	83 c4 18             	add    $0x18,%esp
}
  801cd6:	c9                   	leave  
  801cd7:	c3                   	ret    

00801cd8 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cd8:	55                   	push   %ebp
  801cd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cdb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cde:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	52                   	push   %edx
  801ce8:	50                   	push   %eax
  801ce9:	6a 19                	push   $0x19
  801ceb:	e8 ff fc ff ff       	call   8019ef <syscall>
  801cf0:	83 c4 18             	add    $0x18,%esp
}
  801cf3:	90                   	nop
  801cf4:	c9                   	leave  
  801cf5:	c3                   	ret    

00801cf6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cf6:	55                   	push   %ebp
  801cf7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cf9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	52                   	push   %edx
  801d06:	50                   	push   %eax
  801d07:	6a 1a                	push   $0x1a
  801d09:	e8 e1 fc ff ff       	call   8019ef <syscall>
  801d0e:	83 c4 18             	add    $0x18,%esp
}
  801d11:	90                   	nop
  801d12:	c9                   	leave  
  801d13:	c3                   	ret    

00801d14 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d14:	55                   	push   %ebp
  801d15:	89 e5                	mov    %esp,%ebp
  801d17:	83 ec 04             	sub    $0x4,%esp
  801d1a:	8b 45 10             	mov    0x10(%ebp),%eax
  801d1d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d20:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d23:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d27:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2a:	6a 00                	push   $0x0
  801d2c:	51                   	push   %ecx
  801d2d:	52                   	push   %edx
  801d2e:	ff 75 0c             	pushl  0xc(%ebp)
  801d31:	50                   	push   %eax
  801d32:	6a 1c                	push   $0x1c
  801d34:	e8 b6 fc ff ff       	call   8019ef <syscall>
  801d39:	83 c4 18             	add    $0x18,%esp
}
  801d3c:	c9                   	leave  
  801d3d:	c3                   	ret    

00801d3e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d3e:	55                   	push   %ebp
  801d3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d41:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d44:	8b 45 08             	mov    0x8(%ebp),%eax
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 00                	push   $0x0
  801d4d:	52                   	push   %edx
  801d4e:	50                   	push   %eax
  801d4f:	6a 1d                	push   $0x1d
  801d51:	e8 99 fc ff ff       	call   8019ef <syscall>
  801d56:	83 c4 18             	add    $0x18,%esp
}
  801d59:	c9                   	leave  
  801d5a:	c3                   	ret    

00801d5b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d5b:	55                   	push   %ebp
  801d5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d5e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d61:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d64:	8b 45 08             	mov    0x8(%ebp),%eax
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	51                   	push   %ecx
  801d6c:	52                   	push   %edx
  801d6d:	50                   	push   %eax
  801d6e:	6a 1e                	push   $0x1e
  801d70:	e8 7a fc ff ff       	call   8019ef <syscall>
  801d75:	83 c4 18             	add    $0x18,%esp
}
  801d78:	c9                   	leave  
  801d79:	c3                   	ret    

00801d7a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d7a:	55                   	push   %ebp
  801d7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d80:	8b 45 08             	mov    0x8(%ebp),%eax
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	52                   	push   %edx
  801d8a:	50                   	push   %eax
  801d8b:	6a 1f                	push   $0x1f
  801d8d:	e8 5d fc ff ff       	call   8019ef <syscall>
  801d92:	83 c4 18             	add    $0x18,%esp
}
  801d95:	c9                   	leave  
  801d96:	c3                   	ret    

00801d97 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 20                	push   $0x20
  801da6:	e8 44 fc ff ff       	call   8019ef <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
}
  801dae:	c9                   	leave  
  801daf:	c3                   	ret    

00801db0 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801db0:	55                   	push   %ebp
  801db1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801db3:	8b 45 08             	mov    0x8(%ebp),%eax
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	ff 75 10             	pushl  0x10(%ebp)
  801dbd:	ff 75 0c             	pushl  0xc(%ebp)
  801dc0:	50                   	push   %eax
  801dc1:	6a 21                	push   $0x21
  801dc3:	e8 27 fc ff ff       	call   8019ef <syscall>
  801dc8:	83 c4 18             	add    $0x18,%esp
}
  801dcb:	c9                   	leave  
  801dcc:	c3                   	ret    

00801dcd <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801dcd:	55                   	push   %ebp
  801dce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	50                   	push   %eax
  801ddc:	6a 22                	push   $0x22
  801dde:	e8 0c fc ff ff       	call   8019ef <syscall>
  801de3:	83 c4 18             	add    $0x18,%esp
}
  801de6:	90                   	nop
  801de7:	c9                   	leave  
  801de8:	c3                   	ret    

00801de9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801de9:	55                   	push   %ebp
  801dea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801dec:	8b 45 08             	mov    0x8(%ebp),%eax
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	50                   	push   %eax
  801df8:	6a 23                	push   $0x23
  801dfa:	e8 f0 fb ff ff       	call   8019ef <syscall>
  801dff:	83 c4 18             	add    $0x18,%esp
}
  801e02:	90                   	nop
  801e03:	c9                   	leave  
  801e04:	c3                   	ret    

00801e05 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e05:	55                   	push   %ebp
  801e06:	89 e5                	mov    %esp,%ebp
  801e08:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e0b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e0e:	8d 50 04             	lea    0x4(%eax),%edx
  801e11:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	52                   	push   %edx
  801e1b:	50                   	push   %eax
  801e1c:	6a 24                	push   $0x24
  801e1e:	e8 cc fb ff ff       	call   8019ef <syscall>
  801e23:	83 c4 18             	add    $0x18,%esp
	return result;
  801e26:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e29:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e2c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e2f:	89 01                	mov    %eax,(%ecx)
  801e31:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e34:	8b 45 08             	mov    0x8(%ebp),%eax
  801e37:	c9                   	leave  
  801e38:	c2 04 00             	ret    $0x4

00801e3b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e3b:	55                   	push   %ebp
  801e3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	ff 75 10             	pushl  0x10(%ebp)
  801e45:	ff 75 0c             	pushl  0xc(%ebp)
  801e48:	ff 75 08             	pushl  0x8(%ebp)
  801e4b:	6a 13                	push   $0x13
  801e4d:	e8 9d fb ff ff       	call   8019ef <syscall>
  801e52:	83 c4 18             	add    $0x18,%esp
	return ;
  801e55:	90                   	nop
}
  801e56:	c9                   	leave  
  801e57:	c3                   	ret    

00801e58 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e58:	55                   	push   %ebp
  801e59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 25                	push   $0x25
  801e67:	e8 83 fb ff ff       	call   8019ef <syscall>
  801e6c:	83 c4 18             	add    $0x18,%esp
}
  801e6f:	c9                   	leave  
  801e70:	c3                   	ret    

00801e71 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e71:	55                   	push   %ebp
  801e72:	89 e5                	mov    %esp,%ebp
  801e74:	83 ec 04             	sub    $0x4,%esp
  801e77:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e7d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	50                   	push   %eax
  801e8a:	6a 26                	push   $0x26
  801e8c:	e8 5e fb ff ff       	call   8019ef <syscall>
  801e91:	83 c4 18             	add    $0x18,%esp
	return ;
  801e94:	90                   	nop
}
  801e95:	c9                   	leave  
  801e96:	c3                   	ret    

00801e97 <rsttst>:
void rsttst()
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 28                	push   $0x28
  801ea6:	e8 44 fb ff ff       	call   8019ef <syscall>
  801eab:	83 c4 18             	add    $0x18,%esp
	return ;
  801eae:	90                   	nop
}
  801eaf:	c9                   	leave  
  801eb0:	c3                   	ret    

00801eb1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801eb1:	55                   	push   %ebp
  801eb2:	89 e5                	mov    %esp,%ebp
  801eb4:	83 ec 04             	sub    $0x4,%esp
  801eb7:	8b 45 14             	mov    0x14(%ebp),%eax
  801eba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ebd:	8b 55 18             	mov    0x18(%ebp),%edx
  801ec0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ec4:	52                   	push   %edx
  801ec5:	50                   	push   %eax
  801ec6:	ff 75 10             	pushl  0x10(%ebp)
  801ec9:	ff 75 0c             	pushl  0xc(%ebp)
  801ecc:	ff 75 08             	pushl  0x8(%ebp)
  801ecf:	6a 27                	push   $0x27
  801ed1:	e8 19 fb ff ff       	call   8019ef <syscall>
  801ed6:	83 c4 18             	add    $0x18,%esp
	return ;
  801ed9:	90                   	nop
}
  801eda:	c9                   	leave  
  801edb:	c3                   	ret    

00801edc <chktst>:
void chktst(uint32 n)
{
  801edc:	55                   	push   %ebp
  801edd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	6a 00                	push   $0x0
  801ee7:	ff 75 08             	pushl  0x8(%ebp)
  801eea:	6a 29                	push   $0x29
  801eec:	e8 fe fa ff ff       	call   8019ef <syscall>
  801ef1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef4:	90                   	nop
}
  801ef5:	c9                   	leave  
  801ef6:	c3                   	ret    

00801ef7 <inctst>:

void inctst()
{
  801ef7:	55                   	push   %ebp
  801ef8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 2a                	push   $0x2a
  801f06:	e8 e4 fa ff ff       	call   8019ef <syscall>
  801f0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f0e:	90                   	nop
}
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <gettst>:
uint32 gettst()
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 2b                	push   $0x2b
  801f20:	e8 ca fa ff ff       	call   8019ef <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
}
  801f28:	c9                   	leave  
  801f29:	c3                   	ret    

00801f2a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f2a:	55                   	push   %ebp
  801f2b:	89 e5                	mov    %esp,%ebp
  801f2d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 2c                	push   $0x2c
  801f3c:	e8 ae fa ff ff       	call   8019ef <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
  801f44:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f47:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f4b:	75 07                	jne    801f54 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801f52:	eb 05                	jmp    801f59 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f54:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f59:	c9                   	leave  
  801f5a:	c3                   	ret    

00801f5b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f5b:	55                   	push   %ebp
  801f5c:	89 e5                	mov    %esp,%ebp
  801f5e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 2c                	push   $0x2c
  801f6d:	e8 7d fa ff ff       	call   8019ef <syscall>
  801f72:	83 c4 18             	add    $0x18,%esp
  801f75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f78:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f7c:	75 07                	jne    801f85 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801f83:	eb 05                	jmp    801f8a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f85:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f8a:	c9                   	leave  
  801f8b:	c3                   	ret    

00801f8c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
  801f8f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 2c                	push   $0x2c
  801f9e:	e8 4c fa ff ff       	call   8019ef <syscall>
  801fa3:	83 c4 18             	add    $0x18,%esp
  801fa6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801fa9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801fad:	75 07                	jne    801fb6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801faf:	b8 01 00 00 00       	mov    $0x1,%eax
  801fb4:	eb 05                	jmp    801fbb <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801fb6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fbb:	c9                   	leave  
  801fbc:	c3                   	ret    

00801fbd <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801fbd:	55                   	push   %ebp
  801fbe:	89 e5                	mov    %esp,%ebp
  801fc0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 2c                	push   $0x2c
  801fcf:	e8 1b fa ff ff       	call   8019ef <syscall>
  801fd4:	83 c4 18             	add    $0x18,%esp
  801fd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801fda:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801fde:	75 07                	jne    801fe7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801fe0:	b8 01 00 00 00       	mov    $0x1,%eax
  801fe5:	eb 05                	jmp    801fec <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801fe7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fec:	c9                   	leave  
  801fed:	c3                   	ret    

00801fee <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801fee:	55                   	push   %ebp
  801fef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	ff 75 08             	pushl  0x8(%ebp)
  801ffc:	6a 2d                	push   $0x2d
  801ffe:	e8 ec f9 ff ff       	call   8019ef <syscall>
  802003:	83 c4 18             	add    $0x18,%esp
	return ;
  802006:	90                   	nop
}
  802007:	c9                   	leave  
  802008:	c3                   	ret    
  802009:	66 90                	xchg   %ax,%ax
  80200b:	90                   	nop

0080200c <__udivdi3>:
  80200c:	55                   	push   %ebp
  80200d:	57                   	push   %edi
  80200e:	56                   	push   %esi
  80200f:	53                   	push   %ebx
  802010:	83 ec 1c             	sub    $0x1c,%esp
  802013:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802017:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80201b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80201f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802023:	89 ca                	mov    %ecx,%edx
  802025:	89 f8                	mov    %edi,%eax
  802027:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80202b:	85 f6                	test   %esi,%esi
  80202d:	75 2d                	jne    80205c <__udivdi3+0x50>
  80202f:	39 cf                	cmp    %ecx,%edi
  802031:	77 65                	ja     802098 <__udivdi3+0x8c>
  802033:	89 fd                	mov    %edi,%ebp
  802035:	85 ff                	test   %edi,%edi
  802037:	75 0b                	jne    802044 <__udivdi3+0x38>
  802039:	b8 01 00 00 00       	mov    $0x1,%eax
  80203e:	31 d2                	xor    %edx,%edx
  802040:	f7 f7                	div    %edi
  802042:	89 c5                	mov    %eax,%ebp
  802044:	31 d2                	xor    %edx,%edx
  802046:	89 c8                	mov    %ecx,%eax
  802048:	f7 f5                	div    %ebp
  80204a:	89 c1                	mov    %eax,%ecx
  80204c:	89 d8                	mov    %ebx,%eax
  80204e:	f7 f5                	div    %ebp
  802050:	89 cf                	mov    %ecx,%edi
  802052:	89 fa                	mov    %edi,%edx
  802054:	83 c4 1c             	add    $0x1c,%esp
  802057:	5b                   	pop    %ebx
  802058:	5e                   	pop    %esi
  802059:	5f                   	pop    %edi
  80205a:	5d                   	pop    %ebp
  80205b:	c3                   	ret    
  80205c:	39 ce                	cmp    %ecx,%esi
  80205e:	77 28                	ja     802088 <__udivdi3+0x7c>
  802060:	0f bd fe             	bsr    %esi,%edi
  802063:	83 f7 1f             	xor    $0x1f,%edi
  802066:	75 40                	jne    8020a8 <__udivdi3+0x9c>
  802068:	39 ce                	cmp    %ecx,%esi
  80206a:	72 0a                	jb     802076 <__udivdi3+0x6a>
  80206c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802070:	0f 87 9e 00 00 00    	ja     802114 <__udivdi3+0x108>
  802076:	b8 01 00 00 00       	mov    $0x1,%eax
  80207b:	89 fa                	mov    %edi,%edx
  80207d:	83 c4 1c             	add    $0x1c,%esp
  802080:	5b                   	pop    %ebx
  802081:	5e                   	pop    %esi
  802082:	5f                   	pop    %edi
  802083:	5d                   	pop    %ebp
  802084:	c3                   	ret    
  802085:	8d 76 00             	lea    0x0(%esi),%esi
  802088:	31 ff                	xor    %edi,%edi
  80208a:	31 c0                	xor    %eax,%eax
  80208c:	89 fa                	mov    %edi,%edx
  80208e:	83 c4 1c             	add    $0x1c,%esp
  802091:	5b                   	pop    %ebx
  802092:	5e                   	pop    %esi
  802093:	5f                   	pop    %edi
  802094:	5d                   	pop    %ebp
  802095:	c3                   	ret    
  802096:	66 90                	xchg   %ax,%ax
  802098:	89 d8                	mov    %ebx,%eax
  80209a:	f7 f7                	div    %edi
  80209c:	31 ff                	xor    %edi,%edi
  80209e:	89 fa                	mov    %edi,%edx
  8020a0:	83 c4 1c             	add    $0x1c,%esp
  8020a3:	5b                   	pop    %ebx
  8020a4:	5e                   	pop    %esi
  8020a5:	5f                   	pop    %edi
  8020a6:	5d                   	pop    %ebp
  8020a7:	c3                   	ret    
  8020a8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020ad:	89 eb                	mov    %ebp,%ebx
  8020af:	29 fb                	sub    %edi,%ebx
  8020b1:	89 f9                	mov    %edi,%ecx
  8020b3:	d3 e6                	shl    %cl,%esi
  8020b5:	89 c5                	mov    %eax,%ebp
  8020b7:	88 d9                	mov    %bl,%cl
  8020b9:	d3 ed                	shr    %cl,%ebp
  8020bb:	89 e9                	mov    %ebp,%ecx
  8020bd:	09 f1                	or     %esi,%ecx
  8020bf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020c3:	89 f9                	mov    %edi,%ecx
  8020c5:	d3 e0                	shl    %cl,%eax
  8020c7:	89 c5                	mov    %eax,%ebp
  8020c9:	89 d6                	mov    %edx,%esi
  8020cb:	88 d9                	mov    %bl,%cl
  8020cd:	d3 ee                	shr    %cl,%esi
  8020cf:	89 f9                	mov    %edi,%ecx
  8020d1:	d3 e2                	shl    %cl,%edx
  8020d3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020d7:	88 d9                	mov    %bl,%cl
  8020d9:	d3 e8                	shr    %cl,%eax
  8020db:	09 c2                	or     %eax,%edx
  8020dd:	89 d0                	mov    %edx,%eax
  8020df:	89 f2                	mov    %esi,%edx
  8020e1:	f7 74 24 0c          	divl   0xc(%esp)
  8020e5:	89 d6                	mov    %edx,%esi
  8020e7:	89 c3                	mov    %eax,%ebx
  8020e9:	f7 e5                	mul    %ebp
  8020eb:	39 d6                	cmp    %edx,%esi
  8020ed:	72 19                	jb     802108 <__udivdi3+0xfc>
  8020ef:	74 0b                	je     8020fc <__udivdi3+0xf0>
  8020f1:	89 d8                	mov    %ebx,%eax
  8020f3:	31 ff                	xor    %edi,%edi
  8020f5:	e9 58 ff ff ff       	jmp    802052 <__udivdi3+0x46>
  8020fa:	66 90                	xchg   %ax,%ax
  8020fc:	8b 54 24 08          	mov    0x8(%esp),%edx
  802100:	89 f9                	mov    %edi,%ecx
  802102:	d3 e2                	shl    %cl,%edx
  802104:	39 c2                	cmp    %eax,%edx
  802106:	73 e9                	jae    8020f1 <__udivdi3+0xe5>
  802108:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80210b:	31 ff                	xor    %edi,%edi
  80210d:	e9 40 ff ff ff       	jmp    802052 <__udivdi3+0x46>
  802112:	66 90                	xchg   %ax,%ax
  802114:	31 c0                	xor    %eax,%eax
  802116:	e9 37 ff ff ff       	jmp    802052 <__udivdi3+0x46>
  80211b:	90                   	nop

0080211c <__umoddi3>:
  80211c:	55                   	push   %ebp
  80211d:	57                   	push   %edi
  80211e:	56                   	push   %esi
  80211f:	53                   	push   %ebx
  802120:	83 ec 1c             	sub    $0x1c,%esp
  802123:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802127:	8b 74 24 34          	mov    0x34(%esp),%esi
  80212b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80212f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802133:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802137:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80213b:	89 f3                	mov    %esi,%ebx
  80213d:	89 fa                	mov    %edi,%edx
  80213f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802143:	89 34 24             	mov    %esi,(%esp)
  802146:	85 c0                	test   %eax,%eax
  802148:	75 1a                	jne    802164 <__umoddi3+0x48>
  80214a:	39 f7                	cmp    %esi,%edi
  80214c:	0f 86 a2 00 00 00    	jbe    8021f4 <__umoddi3+0xd8>
  802152:	89 c8                	mov    %ecx,%eax
  802154:	89 f2                	mov    %esi,%edx
  802156:	f7 f7                	div    %edi
  802158:	89 d0                	mov    %edx,%eax
  80215a:	31 d2                	xor    %edx,%edx
  80215c:	83 c4 1c             	add    $0x1c,%esp
  80215f:	5b                   	pop    %ebx
  802160:	5e                   	pop    %esi
  802161:	5f                   	pop    %edi
  802162:	5d                   	pop    %ebp
  802163:	c3                   	ret    
  802164:	39 f0                	cmp    %esi,%eax
  802166:	0f 87 ac 00 00 00    	ja     802218 <__umoddi3+0xfc>
  80216c:	0f bd e8             	bsr    %eax,%ebp
  80216f:	83 f5 1f             	xor    $0x1f,%ebp
  802172:	0f 84 ac 00 00 00    	je     802224 <__umoddi3+0x108>
  802178:	bf 20 00 00 00       	mov    $0x20,%edi
  80217d:	29 ef                	sub    %ebp,%edi
  80217f:	89 fe                	mov    %edi,%esi
  802181:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802185:	89 e9                	mov    %ebp,%ecx
  802187:	d3 e0                	shl    %cl,%eax
  802189:	89 d7                	mov    %edx,%edi
  80218b:	89 f1                	mov    %esi,%ecx
  80218d:	d3 ef                	shr    %cl,%edi
  80218f:	09 c7                	or     %eax,%edi
  802191:	89 e9                	mov    %ebp,%ecx
  802193:	d3 e2                	shl    %cl,%edx
  802195:	89 14 24             	mov    %edx,(%esp)
  802198:	89 d8                	mov    %ebx,%eax
  80219a:	d3 e0                	shl    %cl,%eax
  80219c:	89 c2                	mov    %eax,%edx
  80219e:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021a2:	d3 e0                	shl    %cl,%eax
  8021a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021a8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021ac:	89 f1                	mov    %esi,%ecx
  8021ae:	d3 e8                	shr    %cl,%eax
  8021b0:	09 d0                	or     %edx,%eax
  8021b2:	d3 eb                	shr    %cl,%ebx
  8021b4:	89 da                	mov    %ebx,%edx
  8021b6:	f7 f7                	div    %edi
  8021b8:	89 d3                	mov    %edx,%ebx
  8021ba:	f7 24 24             	mull   (%esp)
  8021bd:	89 c6                	mov    %eax,%esi
  8021bf:	89 d1                	mov    %edx,%ecx
  8021c1:	39 d3                	cmp    %edx,%ebx
  8021c3:	0f 82 87 00 00 00    	jb     802250 <__umoddi3+0x134>
  8021c9:	0f 84 91 00 00 00    	je     802260 <__umoddi3+0x144>
  8021cf:	8b 54 24 04          	mov    0x4(%esp),%edx
  8021d3:	29 f2                	sub    %esi,%edx
  8021d5:	19 cb                	sbb    %ecx,%ebx
  8021d7:	89 d8                	mov    %ebx,%eax
  8021d9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8021dd:	d3 e0                	shl    %cl,%eax
  8021df:	89 e9                	mov    %ebp,%ecx
  8021e1:	d3 ea                	shr    %cl,%edx
  8021e3:	09 d0                	or     %edx,%eax
  8021e5:	89 e9                	mov    %ebp,%ecx
  8021e7:	d3 eb                	shr    %cl,%ebx
  8021e9:	89 da                	mov    %ebx,%edx
  8021eb:	83 c4 1c             	add    $0x1c,%esp
  8021ee:	5b                   	pop    %ebx
  8021ef:	5e                   	pop    %esi
  8021f0:	5f                   	pop    %edi
  8021f1:	5d                   	pop    %ebp
  8021f2:	c3                   	ret    
  8021f3:	90                   	nop
  8021f4:	89 fd                	mov    %edi,%ebp
  8021f6:	85 ff                	test   %edi,%edi
  8021f8:	75 0b                	jne    802205 <__umoddi3+0xe9>
  8021fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ff:	31 d2                	xor    %edx,%edx
  802201:	f7 f7                	div    %edi
  802203:	89 c5                	mov    %eax,%ebp
  802205:	89 f0                	mov    %esi,%eax
  802207:	31 d2                	xor    %edx,%edx
  802209:	f7 f5                	div    %ebp
  80220b:	89 c8                	mov    %ecx,%eax
  80220d:	f7 f5                	div    %ebp
  80220f:	89 d0                	mov    %edx,%eax
  802211:	e9 44 ff ff ff       	jmp    80215a <__umoddi3+0x3e>
  802216:	66 90                	xchg   %ax,%ax
  802218:	89 c8                	mov    %ecx,%eax
  80221a:	89 f2                	mov    %esi,%edx
  80221c:	83 c4 1c             	add    $0x1c,%esp
  80221f:	5b                   	pop    %ebx
  802220:	5e                   	pop    %esi
  802221:	5f                   	pop    %edi
  802222:	5d                   	pop    %ebp
  802223:	c3                   	ret    
  802224:	3b 04 24             	cmp    (%esp),%eax
  802227:	72 06                	jb     80222f <__umoddi3+0x113>
  802229:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80222d:	77 0f                	ja     80223e <__umoddi3+0x122>
  80222f:	89 f2                	mov    %esi,%edx
  802231:	29 f9                	sub    %edi,%ecx
  802233:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802237:	89 14 24             	mov    %edx,(%esp)
  80223a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80223e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802242:	8b 14 24             	mov    (%esp),%edx
  802245:	83 c4 1c             	add    $0x1c,%esp
  802248:	5b                   	pop    %ebx
  802249:	5e                   	pop    %esi
  80224a:	5f                   	pop    %edi
  80224b:	5d                   	pop    %ebp
  80224c:	c3                   	ret    
  80224d:	8d 76 00             	lea    0x0(%esi),%esi
  802250:	2b 04 24             	sub    (%esp),%eax
  802253:	19 fa                	sbb    %edi,%edx
  802255:	89 d1                	mov    %edx,%ecx
  802257:	89 c6                	mov    %eax,%esi
  802259:	e9 71 ff ff ff       	jmp    8021cf <__umoddi3+0xb3>
  80225e:	66 90                	xchg   %ax,%ax
  802260:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802264:	72 ea                	jb     802250 <__umoddi3+0x134>
  802266:	89 d9                	mov    %ebx,%ecx
  802268:	e9 62 ff ff ff       	jmp    8021cf <__umoddi3+0xb3>
