
obj/user/quicksort_noleakage:     file format elf32-i386


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
  800031:	e8 fc 05 00 00       	call   800632 <libmain>
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
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 1d 1c 00 00       	call   801c63 <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 c0 22 80 00       	push   $0x8022c0
  80004e:	e8 a2 09 00 00       	call   8009f5 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 c2 22 80 00       	push   $0x8022c2
  80005e:	e8 92 09 00 00       	call   8009f5 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT    !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 db 22 80 00       	push   $0x8022db
  80006e:	e8 82 09 00 00       	call   8009f5 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 c2 22 80 00       	push   $0x8022c2
  80007e:	e8 72 09 00 00       	call   8009f5 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 c0 22 80 00       	push   $0x8022c0
  80008e:	e8 62 09 00 00       	call   8009f5 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 f4 22 80 00       	push   $0x8022f4
  8000a5:	e8 cd 0f 00 00       	call   801077 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 1d 15 00 00       	call   8015dd <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 b0 18 00 00       	call   801985 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 14 23 80 00       	push   $0x802314
  8000e3:	e8 0d 09 00 00       	call   8009f5 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 36 23 80 00       	push   $0x802336
  8000f3:	e8 fd 08 00 00       	call   8009f5 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 44 23 80 00       	push   $0x802344
  800103:	e8 ed 08 00 00       	call   8009f5 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 53 23 80 00       	push   $0x802353
  800113:	e8 dd 08 00 00       	call   8009f5 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 63 23 80 00       	push   $0x802363
  800123:	e8 cd 08 00 00       	call   8009f5 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  80012b:	e8 aa 04 00 00       	call   8005da <getchar>
  800130:	88 45 ef             	mov    %al,-0x11(%ebp)
		cputchar(Chose);
  800133:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 52 04 00 00       	call   800592 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 45 04 00 00       	call   800592 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp

		//2012: lock the interrupt
		sys_enable_interrupt();
  800150:	e8 28 1b 00 00       	call   801c7d <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800155:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800159:	83 f8 62             	cmp    $0x62,%eax
  80015c:	74 1d                	je     80017b <_main+0x143>
  80015e:	83 f8 63             	cmp    $0x63,%eax
  800161:	74 2b                	je     80018e <_main+0x156>
  800163:	83 f8 61             	cmp    $0x61,%eax
  800166:	75 39                	jne    8001a1 <_main+0x169>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800168:	83 ec 08             	sub    $0x8,%esp
  80016b:	ff 75 f4             	pushl  -0xc(%ebp)
  80016e:	ff 75 f0             	pushl  -0x10(%ebp)
  800171:	e8 e4 02 00 00       	call   80045a <InitializeAscending>
  800176:	83 c4 10             	add    $0x10,%esp
			break ;
  800179:	eb 37                	jmp    8001b2 <_main+0x17a>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80017b:	83 ec 08             	sub    $0x8,%esp
  80017e:	ff 75 f4             	pushl  -0xc(%ebp)
  800181:	ff 75 f0             	pushl  -0x10(%ebp)
  800184:	e8 02 03 00 00       	call   80048b <InitializeDescending>
  800189:	83 c4 10             	add    $0x10,%esp
			break ;
  80018c:	eb 24                	jmp    8001b2 <_main+0x17a>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80018e:	83 ec 08             	sub    $0x8,%esp
  800191:	ff 75 f4             	pushl  -0xc(%ebp)
  800194:	ff 75 f0             	pushl  -0x10(%ebp)
  800197:	e8 24 03 00 00       	call   8004c0 <InitializeSemiRandom>
  80019c:	83 c4 10             	add    $0x10,%esp
			break ;
  80019f:	eb 11                	jmp    8001b2 <_main+0x17a>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001a1:	83 ec 08             	sub    $0x8,%esp
  8001a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8001a7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001aa:	e8 11 03 00 00       	call   8004c0 <InitializeSemiRandom>
  8001af:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001b2:	83 ec 08             	sub    $0x8,%esp
  8001b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8001b8:	ff 75 f0             	pushl  -0x10(%ebp)
  8001bb:	e8 df 00 00 00       	call   80029f <QuickSort>
  8001c0:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001c3:	e8 9b 1a 00 00       	call   801c63 <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001c8:	83 ec 0c             	sub    $0xc,%esp
  8001cb:	68 6c 23 80 00       	push   $0x80236c
  8001d0:	e8 20 08 00 00       	call   8009f5 <cprintf>
  8001d5:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001d8:	e8 a0 1a 00 00       	call   801c7d <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001dd:	83 ec 08             	sub    $0x8,%esp
  8001e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8001e3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001e6:	e8 c5 01 00 00       	call   8003b0 <CheckSorted>
  8001eb:	83 c4 10             	add    $0x10,%esp
  8001ee:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001f1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001f5:	75 14                	jne    80020b <_main+0x1d3>
  8001f7:	83 ec 04             	sub    $0x4,%esp
  8001fa:	68 a0 23 80 00       	push   $0x8023a0
  8001ff:	6a 46                	push   $0x46
  800201:	68 c2 23 80 00       	push   $0x8023c2
  800206:	e8 36 05 00 00       	call   800741 <_panic>
		else
		{
			sys_disable_interrupt();
  80020b:	e8 53 1a 00 00       	call   801c63 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 e0 23 80 00       	push   $0x8023e0
  800218:	e8 d8 07 00 00       	call   8009f5 <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 14 24 80 00       	push   $0x802414
  800228:	e8 c8 07 00 00       	call   8009f5 <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	68 48 24 80 00       	push   $0x802448
  800238:	e8 b8 07 00 00       	call   8009f5 <cprintf>
  80023d:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800240:	e8 38 1a 00 00       	call   801c7d <sys_enable_interrupt>

		}

		free(Elements) ;
  800245:	83 ec 0c             	sub    $0xc,%esp
  800248:	ff 75 f0             	pushl  -0x10(%ebp)
  80024b:	e8 89 17 00 00       	call   8019d9 <free>
  800250:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800253:	e8 0b 1a 00 00       	call   801c63 <sys_disable_interrupt>

		cprintf("Do you want to repeat (y/n): ") ;
  800258:	83 ec 0c             	sub    $0xc,%esp
  80025b:	68 7a 24 80 00       	push   $0x80247a
  800260:	e8 90 07 00 00       	call   8009f5 <cprintf>
  800265:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  800268:	e8 6d 03 00 00       	call   8005da <getchar>
  80026d:	88 45 ef             	mov    %al,-0x11(%ebp)
		cputchar(Chose);
  800270:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800274:	83 ec 0c             	sub    $0xc,%esp
  800277:	50                   	push   %eax
  800278:	e8 15 03 00 00       	call   800592 <cputchar>
  80027d:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	6a 0a                	push   $0xa
  800285:	e8 08 03 00 00       	call   800592 <cputchar>
  80028a:	83 c4 10             	add    $0x10,%esp

		sys_enable_interrupt();
  80028d:	e8 eb 19 00 00       	call   801c7d <sys_enable_interrupt>

	} while (Chose == 'y');
  800292:	80 7d ef 79          	cmpb   $0x79,-0x11(%ebp)
  800296:	0f 84 a5 fd ff ff    	je     800041 <_main+0x9>

}
  80029c:	90                   	nop
  80029d:	c9                   	leave  
  80029e:	c3                   	ret    

0080029f <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  80029f:	55                   	push   %ebp
  8002a0:	89 e5                	mov    %esp,%ebp
  8002a2:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a8:	48                   	dec    %eax
  8002a9:	50                   	push   %eax
  8002aa:	6a 00                	push   $0x0
  8002ac:	ff 75 0c             	pushl  0xc(%ebp)
  8002af:	ff 75 08             	pushl  0x8(%ebp)
  8002b2:	e8 06 00 00 00       	call   8002bd <QSort>
  8002b7:	83 c4 10             	add    $0x10,%esp
}
  8002ba:	90                   	nop
  8002bb:	c9                   	leave  
  8002bc:	c3                   	ret    

008002bd <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002bd:	55                   	push   %ebp
  8002be:	89 e5                	mov    %esp,%ebp
  8002c0:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8002c6:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002c9:	0f 8d de 00 00 00    	jge    8003ad <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d2:	40                   	inc    %eax
  8002d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8002d9:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002dc:	e9 80 00 00 00       	jmp    800361 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002e1:	ff 45 f4             	incl   -0xc(%ebp)
  8002e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e7:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002ea:	7f 2b                	jg     800317 <QSort+0x5a>
  8002ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 d0                	add    %edx,%eax
  8002fb:	8b 10                	mov    (%eax),%edx
  8002fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800300:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800307:	8b 45 08             	mov    0x8(%ebp),%eax
  80030a:	01 c8                	add    %ecx,%eax
  80030c:	8b 00                	mov    (%eax),%eax
  80030e:	39 c2                	cmp    %eax,%edx
  800310:	7d cf                	jge    8002e1 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800312:	eb 03                	jmp    800317 <QSort+0x5a>
  800314:	ff 4d f0             	decl   -0x10(%ebp)
  800317:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80031d:	7e 26                	jle    800345 <QSort+0x88>
  80031f:	8b 45 10             	mov    0x10(%ebp),%eax
  800322:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800329:	8b 45 08             	mov    0x8(%ebp),%eax
  80032c:	01 d0                	add    %edx,%eax
  80032e:	8b 10                	mov    (%eax),%edx
  800330:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800333:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80033a:	8b 45 08             	mov    0x8(%ebp),%eax
  80033d:	01 c8                	add    %ecx,%eax
  80033f:	8b 00                	mov    (%eax),%eax
  800341:	39 c2                	cmp    %eax,%edx
  800343:	7e cf                	jle    800314 <QSort+0x57>

		if (i <= j)
  800345:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800348:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80034b:	7f 14                	jg     800361 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80034d:	83 ec 04             	sub    $0x4,%esp
  800350:	ff 75 f0             	pushl  -0x10(%ebp)
  800353:	ff 75 f4             	pushl  -0xc(%ebp)
  800356:	ff 75 08             	pushl  0x8(%ebp)
  800359:	e8 a9 00 00 00       	call   800407 <Swap>
  80035e:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800361:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800364:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800367:	0f 8e 77 ff ff ff    	jle    8002e4 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80036d:	83 ec 04             	sub    $0x4,%esp
  800370:	ff 75 f0             	pushl  -0x10(%ebp)
  800373:	ff 75 10             	pushl  0x10(%ebp)
  800376:	ff 75 08             	pushl  0x8(%ebp)
  800379:	e8 89 00 00 00       	call   800407 <Swap>
  80037e:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800381:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800384:	48                   	dec    %eax
  800385:	50                   	push   %eax
  800386:	ff 75 10             	pushl  0x10(%ebp)
  800389:	ff 75 0c             	pushl  0xc(%ebp)
  80038c:	ff 75 08             	pushl  0x8(%ebp)
  80038f:	e8 29 ff ff ff       	call   8002bd <QSort>
  800394:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800397:	ff 75 14             	pushl  0x14(%ebp)
  80039a:	ff 75 f4             	pushl  -0xc(%ebp)
  80039d:	ff 75 0c             	pushl  0xc(%ebp)
  8003a0:	ff 75 08             	pushl  0x8(%ebp)
  8003a3:	e8 15 ff ff ff       	call   8002bd <QSort>
  8003a8:	83 c4 10             	add    $0x10,%esp
  8003ab:	eb 01                	jmp    8003ae <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003ad:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003ae:	c9                   	leave  
  8003af:	c3                   	ret    

008003b0 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003b0:	55                   	push   %ebp
  8003b1:	89 e5                	mov    %esp,%ebp
  8003b3:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003b6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003bd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003c4:	eb 33                	jmp    8003f9 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d3:	01 d0                	add    %edx,%eax
  8003d5:	8b 10                	mov    (%eax),%edx
  8003d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003da:	40                   	inc    %eax
  8003db:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	01 c8                	add    %ecx,%eax
  8003e7:	8b 00                	mov    (%eax),%eax
  8003e9:	39 c2                	cmp    %eax,%edx
  8003eb:	7e 09                	jle    8003f6 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003f4:	eb 0c                	jmp    800402 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003f6:	ff 45 f8             	incl   -0x8(%ebp)
  8003f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003fc:	48                   	dec    %eax
  8003fd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800400:	7f c4                	jg     8003c6 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800402:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800405:	c9                   	leave  
  800406:	c3                   	ret    

00800407 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800407:	55                   	push   %ebp
  800408:	89 e5                	mov    %esp,%ebp
  80040a:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80040d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800410:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	01 d0                	add    %edx,%eax
  80041c:	8b 00                	mov    (%eax),%eax
  80041e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800421:	8b 45 0c             	mov    0xc(%ebp),%eax
  800424:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	01 c2                	add    %eax,%edx
  800430:	8b 45 10             	mov    0x10(%ebp),%eax
  800433:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 c8                	add    %ecx,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800443:	8b 45 10             	mov    0x10(%ebp),%eax
  800446:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	01 c2                	add    %eax,%edx
  800452:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800455:	89 02                	mov    %eax,(%edx)
}
  800457:	90                   	nop
  800458:	c9                   	leave  
  800459:	c3                   	ret    

0080045a <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80045a:	55                   	push   %ebp
  80045b:	89 e5                	mov    %esp,%ebp
  80045d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800460:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800467:	eb 17                	jmp    800480 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800469:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80046c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	01 c2                	add    %eax,%edx
  800478:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047b:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80047d:	ff 45 fc             	incl   -0x4(%ebp)
  800480:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800483:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800486:	7c e1                	jl     800469 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800488:	90                   	nop
  800489:	c9                   	leave  
  80048a:	c3                   	ret    

0080048b <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80048b:	55                   	push   %ebp
  80048c:	89 e5                	mov    %esp,%ebp
  80048e:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800491:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800498:	eb 1b                	jmp    8004b5 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  80049a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	01 c2                	add    %eax,%edx
  8004a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ac:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004af:	48                   	dec    %eax
  8004b0:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b2:	ff 45 fc             	incl   -0x4(%ebp)
  8004b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004bb:	7c dd                	jl     80049a <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004bd:	90                   	nop
  8004be:	c9                   	leave  
  8004bf:	c3                   	ret    

008004c0 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004c0:	55                   	push   %ebp
  8004c1:	89 e5                	mov    %esp,%ebp
  8004c3:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004c9:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004ce:	f7 e9                	imul   %ecx
  8004d0:	c1 f9 1f             	sar    $0x1f,%ecx
  8004d3:	89 d0                	mov    %edx,%eax
  8004d5:	29 c8                	sub    %ecx,%eax
  8004d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004e1:	eb 1e                	jmp    800501 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f6:	99                   	cltd   
  8004f7:	f7 7d f8             	idivl  -0x8(%ebp)
  8004fa:	89 d0                	mov    %edx,%eax
  8004fc:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fe:	ff 45 fc             	incl   -0x4(%ebp)
  800501:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800504:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800507:	7c da                	jl     8004e3 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800509:	90                   	nop
  80050a:	c9                   	leave  
  80050b:	c3                   	ret    

0080050c <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80050c:	55                   	push   %ebp
  80050d:	89 e5                	mov    %esp,%ebp
  80050f:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800512:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800519:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800520:	eb 42                	jmp    800564 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800522:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800525:	99                   	cltd   
  800526:	f7 7d f0             	idivl  -0x10(%ebp)
  800529:	89 d0                	mov    %edx,%eax
  80052b:	85 c0                	test   %eax,%eax
  80052d:	75 10                	jne    80053f <PrintElements+0x33>
			cprintf("\n");
  80052f:	83 ec 0c             	sub    $0xc,%esp
  800532:	68 c0 22 80 00       	push   $0x8022c0
  800537:	e8 b9 04 00 00       	call   8009f5 <cprintf>
  80053c:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  80053f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800542:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800549:	8b 45 08             	mov    0x8(%ebp),%eax
  80054c:	01 d0                	add    %edx,%eax
  80054e:	8b 00                	mov    (%eax),%eax
  800550:	83 ec 08             	sub    $0x8,%esp
  800553:	50                   	push   %eax
  800554:	68 98 24 80 00       	push   $0x802498
  800559:	e8 97 04 00 00       	call   8009f5 <cprintf>
  80055e:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800561:	ff 45 f4             	incl   -0xc(%ebp)
  800564:	8b 45 0c             	mov    0xc(%ebp),%eax
  800567:	48                   	dec    %eax
  800568:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80056b:	7f b5                	jg     800522 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80056d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800570:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800577:	8b 45 08             	mov    0x8(%ebp),%eax
  80057a:	01 d0                	add    %edx,%eax
  80057c:	8b 00                	mov    (%eax),%eax
  80057e:	83 ec 08             	sub    $0x8,%esp
  800581:	50                   	push   %eax
  800582:	68 9d 24 80 00       	push   $0x80249d
  800587:	e8 69 04 00 00       	call   8009f5 <cprintf>
  80058c:	83 c4 10             	add    $0x10,%esp

}
  80058f:	90                   	nop
  800590:	c9                   	leave  
  800591:	c3                   	ret    

00800592 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800592:	55                   	push   %ebp
  800593:	89 e5                	mov    %esp,%ebp
  800595:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800598:	8b 45 08             	mov    0x8(%ebp),%eax
  80059b:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80059e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005a2:	83 ec 0c             	sub    $0xc,%esp
  8005a5:	50                   	push   %eax
  8005a6:	e8 ec 16 00 00       	call   801c97 <sys_cputc>
  8005ab:	83 c4 10             	add    $0x10,%esp
}
  8005ae:	90                   	nop
  8005af:	c9                   	leave  
  8005b0:	c3                   	ret    

008005b1 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005b1:	55                   	push   %ebp
  8005b2:	89 e5                	mov    %esp,%ebp
  8005b4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005b7:	e8 a7 16 00 00       	call   801c63 <sys_disable_interrupt>
	char c = ch;
  8005bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bf:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005c2:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005c6:	83 ec 0c             	sub    $0xc,%esp
  8005c9:	50                   	push   %eax
  8005ca:	e8 c8 16 00 00       	call   801c97 <sys_cputc>
  8005cf:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005d2:	e8 a6 16 00 00       	call   801c7d <sys_enable_interrupt>
}
  8005d7:	90                   	nop
  8005d8:	c9                   	leave  
  8005d9:	c3                   	ret    

008005da <getchar>:

int
getchar(void)
{
  8005da:	55                   	push   %ebp
  8005db:	89 e5                	mov    %esp,%ebp
  8005dd:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005e7:	eb 08                	jmp    8005f1 <getchar+0x17>
	{
		c = sys_cgetc();
  8005e9:	e8 8d 14 00 00       	call   801a7b <sys_cgetc>
  8005ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005f5:	74 f2                	je     8005e9 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005fa:	c9                   	leave  
  8005fb:	c3                   	ret    

008005fc <atomic_getchar>:

int
atomic_getchar(void)
{
  8005fc:	55                   	push   %ebp
  8005fd:	89 e5                	mov    %esp,%ebp
  8005ff:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800602:	e8 5c 16 00 00       	call   801c63 <sys_disable_interrupt>
	int c=0;
  800607:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80060e:	eb 08                	jmp    800618 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800610:	e8 66 14 00 00       	call   801a7b <sys_cgetc>
  800615:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800618:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80061c:	74 f2                	je     800610 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  80061e:	e8 5a 16 00 00       	call   801c7d <sys_enable_interrupt>
	return c;
  800623:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800626:	c9                   	leave  
  800627:	c3                   	ret    

00800628 <iscons>:

int iscons(int fdnum)
{
  800628:	55                   	push   %ebp
  800629:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80062b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800630:	5d                   	pop    %ebp
  800631:	c3                   	ret    

00800632 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800632:	55                   	push   %ebp
  800633:	89 e5                	mov    %esp,%ebp
  800635:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800638:	e8 8b 14 00 00       	call   801ac8 <sys_getenvindex>
  80063d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800640:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800643:	89 d0                	mov    %edx,%eax
  800645:	c1 e0 02             	shl    $0x2,%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	01 c0                	add    %eax,%eax
  80064c:	01 d0                	add    %edx,%eax
  80064e:	01 c0                	add    %eax,%eax
  800650:	01 d0                	add    %edx,%eax
  800652:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800659:	01 d0                	add    %edx,%eax
  80065b:	c1 e0 02             	shl    $0x2,%eax
  80065e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800663:	a3 08 30 80 00       	mov    %eax,0x803008

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800668:	a1 08 30 80 00       	mov    0x803008,%eax
  80066d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800673:	84 c0                	test   %al,%al
  800675:	74 0f                	je     800686 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800677:	a1 08 30 80 00       	mov    0x803008,%eax
  80067c:	05 f4 02 00 00       	add    $0x2f4,%eax
  800681:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800686:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80068a:	7e 0a                	jle    800696 <libmain+0x64>
		binaryname = argv[0];
  80068c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80068f:	8b 00                	mov    (%eax),%eax
  800691:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800696:	83 ec 08             	sub    $0x8,%esp
  800699:	ff 75 0c             	pushl  0xc(%ebp)
  80069c:	ff 75 08             	pushl  0x8(%ebp)
  80069f:	e8 94 f9 ff ff       	call   800038 <_main>
  8006a4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006a7:	e8 b7 15 00 00       	call   801c63 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006ac:	83 ec 0c             	sub    $0xc,%esp
  8006af:	68 bc 24 80 00       	push   $0x8024bc
  8006b4:	e8 3c 03 00 00       	call   8009f5 <cprintf>
  8006b9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006bc:	a1 08 30 80 00       	mov    0x803008,%eax
  8006c1:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8006c7:	a1 08 30 80 00       	mov    0x803008,%eax
  8006cc:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006d2:	83 ec 04             	sub    $0x4,%esp
  8006d5:	52                   	push   %edx
  8006d6:	50                   	push   %eax
  8006d7:	68 e4 24 80 00       	push   $0x8024e4
  8006dc:	e8 14 03 00 00       	call   8009f5 <cprintf>
  8006e1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006e4:	a1 08 30 80 00       	mov    0x803008,%eax
  8006e9:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8006ef:	83 ec 08             	sub    $0x8,%esp
  8006f2:	50                   	push   %eax
  8006f3:	68 09 25 80 00       	push   $0x802509
  8006f8:	e8 f8 02 00 00       	call   8009f5 <cprintf>
  8006fd:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800700:	83 ec 0c             	sub    $0xc,%esp
  800703:	68 bc 24 80 00       	push   $0x8024bc
  800708:	e8 e8 02 00 00       	call   8009f5 <cprintf>
  80070d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800710:	e8 68 15 00 00       	call   801c7d <sys_enable_interrupt>

	// exit gracefully
	exit();
  800715:	e8 19 00 00 00       	call   800733 <exit>
}
  80071a:	90                   	nop
  80071b:	c9                   	leave  
  80071c:	c3                   	ret    

0080071d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80071d:	55                   	push   %ebp
  80071e:	89 e5                	mov    %esp,%ebp
  800720:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800723:	83 ec 0c             	sub    $0xc,%esp
  800726:	6a 00                	push   $0x0
  800728:	e8 67 13 00 00       	call   801a94 <sys_env_destroy>
  80072d:	83 c4 10             	add    $0x10,%esp
}
  800730:	90                   	nop
  800731:	c9                   	leave  
  800732:	c3                   	ret    

00800733 <exit>:

void
exit(void)
{
  800733:	55                   	push   %ebp
  800734:	89 e5                	mov    %esp,%ebp
  800736:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800739:	e8 bc 13 00 00       	call   801afa <sys_env_exit>
}
  80073e:	90                   	nop
  80073f:	c9                   	leave  
  800740:	c3                   	ret    

00800741 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800741:	55                   	push   %ebp
  800742:	89 e5                	mov    %esp,%ebp
  800744:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800747:	8d 45 10             	lea    0x10(%ebp),%eax
  80074a:	83 c0 04             	add    $0x4,%eax
  80074d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800750:	a1 18 30 80 00       	mov    0x803018,%eax
  800755:	85 c0                	test   %eax,%eax
  800757:	74 16                	je     80076f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800759:	a1 18 30 80 00       	mov    0x803018,%eax
  80075e:	83 ec 08             	sub    $0x8,%esp
  800761:	50                   	push   %eax
  800762:	68 20 25 80 00       	push   $0x802520
  800767:	e8 89 02 00 00       	call   8009f5 <cprintf>
  80076c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80076f:	a1 00 30 80 00       	mov    0x803000,%eax
  800774:	ff 75 0c             	pushl  0xc(%ebp)
  800777:	ff 75 08             	pushl  0x8(%ebp)
  80077a:	50                   	push   %eax
  80077b:	68 25 25 80 00       	push   $0x802525
  800780:	e8 70 02 00 00       	call   8009f5 <cprintf>
  800785:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800788:	8b 45 10             	mov    0x10(%ebp),%eax
  80078b:	83 ec 08             	sub    $0x8,%esp
  80078e:	ff 75 f4             	pushl  -0xc(%ebp)
  800791:	50                   	push   %eax
  800792:	e8 f3 01 00 00       	call   80098a <vcprintf>
  800797:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80079a:	83 ec 08             	sub    $0x8,%esp
  80079d:	6a 00                	push   $0x0
  80079f:	68 41 25 80 00       	push   $0x802541
  8007a4:	e8 e1 01 00 00       	call   80098a <vcprintf>
  8007a9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007ac:	e8 82 ff ff ff       	call   800733 <exit>

	// should not return here
	while (1) ;
  8007b1:	eb fe                	jmp    8007b1 <_panic+0x70>

008007b3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007b3:	55                   	push   %ebp
  8007b4:	89 e5                	mov    %esp,%ebp
  8007b6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007b9:	a1 08 30 80 00       	mov    0x803008,%eax
  8007be:	8b 50 74             	mov    0x74(%eax),%edx
  8007c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007c4:	39 c2                	cmp    %eax,%edx
  8007c6:	74 14                	je     8007dc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007c8:	83 ec 04             	sub    $0x4,%esp
  8007cb:	68 44 25 80 00       	push   $0x802544
  8007d0:	6a 26                	push   $0x26
  8007d2:	68 90 25 80 00       	push   $0x802590
  8007d7:	e8 65 ff ff ff       	call   800741 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007ea:	e9 c2 00 00 00       	jmp    8008b1 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fc:	01 d0                	add    %edx,%eax
  8007fe:	8b 00                	mov    (%eax),%eax
  800800:	85 c0                	test   %eax,%eax
  800802:	75 08                	jne    80080c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800804:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800807:	e9 a2 00 00 00       	jmp    8008ae <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80080c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800813:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80081a:	eb 69                	jmp    800885 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80081c:	a1 08 30 80 00       	mov    0x803008,%eax
  800821:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800827:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80082a:	89 d0                	mov    %edx,%eax
  80082c:	01 c0                	add    %eax,%eax
  80082e:	01 d0                	add    %edx,%eax
  800830:	c1 e0 02             	shl    $0x2,%eax
  800833:	01 c8                	add    %ecx,%eax
  800835:	8a 40 04             	mov    0x4(%eax),%al
  800838:	84 c0                	test   %al,%al
  80083a:	75 46                	jne    800882 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80083c:	a1 08 30 80 00       	mov    0x803008,%eax
  800841:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800847:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80084a:	89 d0                	mov    %edx,%eax
  80084c:	01 c0                	add    %eax,%eax
  80084e:	01 d0                	add    %edx,%eax
  800850:	c1 e0 02             	shl    $0x2,%eax
  800853:	01 c8                	add    %ecx,%eax
  800855:	8b 00                	mov    (%eax),%eax
  800857:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80085a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80085d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800862:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800864:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800867:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80086e:	8b 45 08             	mov    0x8(%ebp),%eax
  800871:	01 c8                	add    %ecx,%eax
  800873:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800875:	39 c2                	cmp    %eax,%edx
  800877:	75 09                	jne    800882 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800879:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800880:	eb 12                	jmp    800894 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800882:	ff 45 e8             	incl   -0x18(%ebp)
  800885:	a1 08 30 80 00       	mov    0x803008,%eax
  80088a:	8b 50 74             	mov    0x74(%eax),%edx
  80088d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800890:	39 c2                	cmp    %eax,%edx
  800892:	77 88                	ja     80081c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800894:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800898:	75 14                	jne    8008ae <CheckWSWithoutLastIndex+0xfb>
			panic(
  80089a:	83 ec 04             	sub    $0x4,%esp
  80089d:	68 9c 25 80 00       	push   $0x80259c
  8008a2:	6a 3a                	push   $0x3a
  8008a4:	68 90 25 80 00       	push   $0x802590
  8008a9:	e8 93 fe ff ff       	call   800741 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008ae:	ff 45 f0             	incl   -0x10(%ebp)
  8008b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008b7:	0f 8c 32 ff ff ff    	jl     8007ef <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008bd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008c4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008cb:	eb 26                	jmp    8008f3 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008cd:	a1 08 30 80 00       	mov    0x803008,%eax
  8008d2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008d8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008db:	89 d0                	mov    %edx,%eax
  8008dd:	01 c0                	add    %eax,%eax
  8008df:	01 d0                	add    %edx,%eax
  8008e1:	c1 e0 02             	shl    $0x2,%eax
  8008e4:	01 c8                	add    %ecx,%eax
  8008e6:	8a 40 04             	mov    0x4(%eax),%al
  8008e9:	3c 01                	cmp    $0x1,%al
  8008eb:	75 03                	jne    8008f0 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008ed:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008f0:	ff 45 e0             	incl   -0x20(%ebp)
  8008f3:	a1 08 30 80 00       	mov    0x803008,%eax
  8008f8:	8b 50 74             	mov    0x74(%eax),%edx
  8008fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008fe:	39 c2                	cmp    %eax,%edx
  800900:	77 cb                	ja     8008cd <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800902:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800905:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800908:	74 14                	je     80091e <CheckWSWithoutLastIndex+0x16b>
		panic(
  80090a:	83 ec 04             	sub    $0x4,%esp
  80090d:	68 f0 25 80 00       	push   $0x8025f0
  800912:	6a 44                	push   $0x44
  800914:	68 90 25 80 00       	push   $0x802590
  800919:	e8 23 fe ff ff       	call   800741 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80091e:	90                   	nop
  80091f:	c9                   	leave  
  800920:	c3                   	ret    

00800921 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800921:	55                   	push   %ebp
  800922:	89 e5                	mov    %esp,%ebp
  800924:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800927:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092a:	8b 00                	mov    (%eax),%eax
  80092c:	8d 48 01             	lea    0x1(%eax),%ecx
  80092f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800932:	89 0a                	mov    %ecx,(%edx)
  800934:	8b 55 08             	mov    0x8(%ebp),%edx
  800937:	88 d1                	mov    %dl,%cl
  800939:	8b 55 0c             	mov    0xc(%ebp),%edx
  80093c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800940:	8b 45 0c             	mov    0xc(%ebp),%eax
  800943:	8b 00                	mov    (%eax),%eax
  800945:	3d ff 00 00 00       	cmp    $0xff,%eax
  80094a:	75 2c                	jne    800978 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80094c:	a0 0c 30 80 00       	mov    0x80300c,%al
  800951:	0f b6 c0             	movzbl %al,%eax
  800954:	8b 55 0c             	mov    0xc(%ebp),%edx
  800957:	8b 12                	mov    (%edx),%edx
  800959:	89 d1                	mov    %edx,%ecx
  80095b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80095e:	83 c2 08             	add    $0x8,%edx
  800961:	83 ec 04             	sub    $0x4,%esp
  800964:	50                   	push   %eax
  800965:	51                   	push   %ecx
  800966:	52                   	push   %edx
  800967:	e8 e6 10 00 00       	call   801a52 <sys_cputs>
  80096c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80096f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800972:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800978:	8b 45 0c             	mov    0xc(%ebp),%eax
  80097b:	8b 40 04             	mov    0x4(%eax),%eax
  80097e:	8d 50 01             	lea    0x1(%eax),%edx
  800981:	8b 45 0c             	mov    0xc(%ebp),%eax
  800984:	89 50 04             	mov    %edx,0x4(%eax)
}
  800987:	90                   	nop
  800988:	c9                   	leave  
  800989:	c3                   	ret    

0080098a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80098a:	55                   	push   %ebp
  80098b:	89 e5                	mov    %esp,%ebp
  80098d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800993:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80099a:	00 00 00 
	b.cnt = 0;
  80099d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009a4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009a7:	ff 75 0c             	pushl  0xc(%ebp)
  8009aa:	ff 75 08             	pushl  0x8(%ebp)
  8009ad:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009b3:	50                   	push   %eax
  8009b4:	68 21 09 80 00       	push   $0x800921
  8009b9:	e8 11 02 00 00       	call   800bcf <vprintfmt>
  8009be:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009c1:	a0 0c 30 80 00       	mov    0x80300c,%al
  8009c6:	0f b6 c0             	movzbl %al,%eax
  8009c9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009cf:	83 ec 04             	sub    $0x4,%esp
  8009d2:	50                   	push   %eax
  8009d3:	52                   	push   %edx
  8009d4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009da:	83 c0 08             	add    $0x8,%eax
  8009dd:	50                   	push   %eax
  8009de:	e8 6f 10 00 00       	call   801a52 <sys_cputs>
  8009e3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009e6:	c6 05 0c 30 80 00 00 	movb   $0x0,0x80300c
	return b.cnt;
  8009ed:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009f3:	c9                   	leave  
  8009f4:	c3                   	ret    

008009f5 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009f5:	55                   	push   %ebp
  8009f6:	89 e5                	mov    %esp,%ebp
  8009f8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009fb:	c6 05 0c 30 80 00 01 	movb   $0x1,0x80300c
	va_start(ap, fmt);
  800a02:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a05:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a08:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0b:	83 ec 08             	sub    $0x8,%esp
  800a0e:	ff 75 f4             	pushl  -0xc(%ebp)
  800a11:	50                   	push   %eax
  800a12:	e8 73 ff ff ff       	call   80098a <vcprintf>
  800a17:	83 c4 10             	add    $0x10,%esp
  800a1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a20:	c9                   	leave  
  800a21:	c3                   	ret    

00800a22 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a22:	55                   	push   %ebp
  800a23:	89 e5                	mov    %esp,%ebp
  800a25:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a28:	e8 36 12 00 00       	call   801c63 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a2d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a30:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a33:	8b 45 08             	mov    0x8(%ebp),%eax
  800a36:	83 ec 08             	sub    $0x8,%esp
  800a39:	ff 75 f4             	pushl  -0xc(%ebp)
  800a3c:	50                   	push   %eax
  800a3d:	e8 48 ff ff ff       	call   80098a <vcprintf>
  800a42:	83 c4 10             	add    $0x10,%esp
  800a45:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a48:	e8 30 12 00 00       	call   801c7d <sys_enable_interrupt>
	return cnt;
  800a4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a50:	c9                   	leave  
  800a51:	c3                   	ret    

00800a52 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a52:	55                   	push   %ebp
  800a53:	89 e5                	mov    %esp,%ebp
  800a55:	53                   	push   %ebx
  800a56:	83 ec 14             	sub    $0x14,%esp
  800a59:	8b 45 10             	mov    0x10(%ebp),%eax
  800a5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a62:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a65:	8b 45 18             	mov    0x18(%ebp),%eax
  800a68:	ba 00 00 00 00       	mov    $0x0,%edx
  800a6d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a70:	77 55                	ja     800ac7 <printnum+0x75>
  800a72:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a75:	72 05                	jb     800a7c <printnum+0x2a>
  800a77:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a7a:	77 4b                	ja     800ac7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a7c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a7f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a82:	8b 45 18             	mov    0x18(%ebp),%eax
  800a85:	ba 00 00 00 00       	mov    $0x0,%edx
  800a8a:	52                   	push   %edx
  800a8b:	50                   	push   %eax
  800a8c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a8f:	ff 75 f0             	pushl  -0x10(%ebp)
  800a92:	e8 ad 15 00 00       	call   802044 <__udivdi3>
  800a97:	83 c4 10             	add    $0x10,%esp
  800a9a:	83 ec 04             	sub    $0x4,%esp
  800a9d:	ff 75 20             	pushl  0x20(%ebp)
  800aa0:	53                   	push   %ebx
  800aa1:	ff 75 18             	pushl  0x18(%ebp)
  800aa4:	52                   	push   %edx
  800aa5:	50                   	push   %eax
  800aa6:	ff 75 0c             	pushl  0xc(%ebp)
  800aa9:	ff 75 08             	pushl  0x8(%ebp)
  800aac:	e8 a1 ff ff ff       	call   800a52 <printnum>
  800ab1:	83 c4 20             	add    $0x20,%esp
  800ab4:	eb 1a                	jmp    800ad0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ab6:	83 ec 08             	sub    $0x8,%esp
  800ab9:	ff 75 0c             	pushl  0xc(%ebp)
  800abc:	ff 75 20             	pushl  0x20(%ebp)
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	ff d0                	call   *%eax
  800ac4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ac7:	ff 4d 1c             	decl   0x1c(%ebp)
  800aca:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ace:	7f e6                	jg     800ab6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ad0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ad3:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ad8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800adb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ade:	53                   	push   %ebx
  800adf:	51                   	push   %ecx
  800ae0:	52                   	push   %edx
  800ae1:	50                   	push   %eax
  800ae2:	e8 6d 16 00 00       	call   802154 <__umoddi3>
  800ae7:	83 c4 10             	add    $0x10,%esp
  800aea:	05 54 28 80 00       	add    $0x802854,%eax
  800aef:	8a 00                	mov    (%eax),%al
  800af1:	0f be c0             	movsbl %al,%eax
  800af4:	83 ec 08             	sub    $0x8,%esp
  800af7:	ff 75 0c             	pushl  0xc(%ebp)
  800afa:	50                   	push   %eax
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	ff d0                	call   *%eax
  800b00:	83 c4 10             	add    $0x10,%esp
}
  800b03:	90                   	nop
  800b04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b07:	c9                   	leave  
  800b08:	c3                   	ret    

00800b09 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b09:	55                   	push   %ebp
  800b0a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b0c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b10:	7e 1c                	jle    800b2e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	8d 50 08             	lea    0x8(%eax),%edx
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	89 10                	mov    %edx,(%eax)
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	83 e8 08             	sub    $0x8,%eax
  800b27:	8b 50 04             	mov    0x4(%eax),%edx
  800b2a:	8b 00                	mov    (%eax),%eax
  800b2c:	eb 40                	jmp    800b6e <getuint+0x65>
	else if (lflag)
  800b2e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b32:	74 1e                	je     800b52 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	8b 00                	mov    (%eax),%eax
  800b39:	8d 50 04             	lea    0x4(%eax),%edx
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	89 10                	mov    %edx,(%eax)
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	8b 00                	mov    (%eax),%eax
  800b46:	83 e8 04             	sub    $0x4,%eax
  800b49:	8b 00                	mov    (%eax),%eax
  800b4b:	ba 00 00 00 00       	mov    $0x0,%edx
  800b50:	eb 1c                	jmp    800b6e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	8b 00                	mov    (%eax),%eax
  800b57:	8d 50 04             	lea    0x4(%eax),%edx
  800b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5d:	89 10                	mov    %edx,(%eax)
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	8b 00                	mov    (%eax),%eax
  800b64:	83 e8 04             	sub    $0x4,%eax
  800b67:	8b 00                	mov    (%eax),%eax
  800b69:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b6e:	5d                   	pop    %ebp
  800b6f:	c3                   	ret    

00800b70 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b70:	55                   	push   %ebp
  800b71:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b73:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b77:	7e 1c                	jle    800b95 <getint+0x25>
		return va_arg(*ap, long long);
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	8b 00                	mov    (%eax),%eax
  800b7e:	8d 50 08             	lea    0x8(%eax),%edx
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	89 10                	mov    %edx,(%eax)
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	8b 00                	mov    (%eax),%eax
  800b8b:	83 e8 08             	sub    $0x8,%eax
  800b8e:	8b 50 04             	mov    0x4(%eax),%edx
  800b91:	8b 00                	mov    (%eax),%eax
  800b93:	eb 38                	jmp    800bcd <getint+0x5d>
	else if (lflag)
  800b95:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b99:	74 1a                	je     800bb5 <getint+0x45>
		return va_arg(*ap, long);
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	8b 00                	mov    (%eax),%eax
  800ba0:	8d 50 04             	lea    0x4(%eax),%edx
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	89 10                	mov    %edx,(%eax)
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	8b 00                	mov    (%eax),%eax
  800bad:	83 e8 04             	sub    $0x4,%eax
  800bb0:	8b 00                	mov    (%eax),%eax
  800bb2:	99                   	cltd   
  800bb3:	eb 18                	jmp    800bcd <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	8b 00                	mov    (%eax),%eax
  800bba:	8d 50 04             	lea    0x4(%eax),%edx
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	89 10                	mov    %edx,(%eax)
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	8b 00                	mov    (%eax),%eax
  800bc7:	83 e8 04             	sub    $0x4,%eax
  800bca:	8b 00                	mov    (%eax),%eax
  800bcc:	99                   	cltd   
}
  800bcd:	5d                   	pop    %ebp
  800bce:	c3                   	ret    

00800bcf <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bcf:	55                   	push   %ebp
  800bd0:	89 e5                	mov    %esp,%ebp
  800bd2:	56                   	push   %esi
  800bd3:	53                   	push   %ebx
  800bd4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bd7:	eb 17                	jmp    800bf0 <vprintfmt+0x21>
			if (ch == '\0')
  800bd9:	85 db                	test   %ebx,%ebx
  800bdb:	0f 84 af 03 00 00    	je     800f90 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800be1:	83 ec 08             	sub    $0x8,%esp
  800be4:	ff 75 0c             	pushl  0xc(%ebp)
  800be7:	53                   	push   %ebx
  800be8:	8b 45 08             	mov    0x8(%ebp),%eax
  800beb:	ff d0                	call   *%eax
  800bed:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bf0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf3:	8d 50 01             	lea    0x1(%eax),%edx
  800bf6:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf9:	8a 00                	mov    (%eax),%al
  800bfb:	0f b6 d8             	movzbl %al,%ebx
  800bfe:	83 fb 25             	cmp    $0x25,%ebx
  800c01:	75 d6                	jne    800bd9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c03:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c07:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c0e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c15:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c1c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c23:	8b 45 10             	mov    0x10(%ebp),%eax
  800c26:	8d 50 01             	lea    0x1(%eax),%edx
  800c29:	89 55 10             	mov    %edx,0x10(%ebp)
  800c2c:	8a 00                	mov    (%eax),%al
  800c2e:	0f b6 d8             	movzbl %al,%ebx
  800c31:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c34:	83 f8 55             	cmp    $0x55,%eax
  800c37:	0f 87 2b 03 00 00    	ja     800f68 <vprintfmt+0x399>
  800c3d:	8b 04 85 78 28 80 00 	mov    0x802878(,%eax,4),%eax
  800c44:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c46:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c4a:	eb d7                	jmp    800c23 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c4c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c50:	eb d1                	jmp    800c23 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c52:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c59:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c5c:	89 d0                	mov    %edx,%eax
  800c5e:	c1 e0 02             	shl    $0x2,%eax
  800c61:	01 d0                	add    %edx,%eax
  800c63:	01 c0                	add    %eax,%eax
  800c65:	01 d8                	add    %ebx,%eax
  800c67:	83 e8 30             	sub    $0x30,%eax
  800c6a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c75:	83 fb 2f             	cmp    $0x2f,%ebx
  800c78:	7e 3e                	jle    800cb8 <vprintfmt+0xe9>
  800c7a:	83 fb 39             	cmp    $0x39,%ebx
  800c7d:	7f 39                	jg     800cb8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c7f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c82:	eb d5                	jmp    800c59 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c84:	8b 45 14             	mov    0x14(%ebp),%eax
  800c87:	83 c0 04             	add    $0x4,%eax
  800c8a:	89 45 14             	mov    %eax,0x14(%ebp)
  800c8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c90:	83 e8 04             	sub    $0x4,%eax
  800c93:	8b 00                	mov    (%eax),%eax
  800c95:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c98:	eb 1f                	jmp    800cb9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c9a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c9e:	79 83                	jns    800c23 <vprintfmt+0x54>
				width = 0;
  800ca0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ca7:	e9 77 ff ff ff       	jmp    800c23 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800cac:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cb3:	e9 6b ff ff ff       	jmp    800c23 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cb8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cb9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cbd:	0f 89 60 ff ff ff    	jns    800c23 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cc6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cc9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cd0:	e9 4e ff ff ff       	jmp    800c23 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cd5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cd8:	e9 46 ff ff ff       	jmp    800c23 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cdd:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce0:	83 c0 04             	add    $0x4,%eax
  800ce3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce9:	83 e8 04             	sub    $0x4,%eax
  800cec:	8b 00                	mov    (%eax),%eax
  800cee:	83 ec 08             	sub    $0x8,%esp
  800cf1:	ff 75 0c             	pushl  0xc(%ebp)
  800cf4:	50                   	push   %eax
  800cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf8:	ff d0                	call   *%eax
  800cfa:	83 c4 10             	add    $0x10,%esp
			break;
  800cfd:	e9 89 02 00 00       	jmp    800f8b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d02:	8b 45 14             	mov    0x14(%ebp),%eax
  800d05:	83 c0 04             	add    $0x4,%eax
  800d08:	89 45 14             	mov    %eax,0x14(%ebp)
  800d0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0e:	83 e8 04             	sub    $0x4,%eax
  800d11:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d13:	85 db                	test   %ebx,%ebx
  800d15:	79 02                	jns    800d19 <vprintfmt+0x14a>
				err = -err;
  800d17:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d19:	83 fb 64             	cmp    $0x64,%ebx
  800d1c:	7f 0b                	jg     800d29 <vprintfmt+0x15a>
  800d1e:	8b 34 9d c0 26 80 00 	mov    0x8026c0(,%ebx,4),%esi
  800d25:	85 f6                	test   %esi,%esi
  800d27:	75 19                	jne    800d42 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d29:	53                   	push   %ebx
  800d2a:	68 65 28 80 00       	push   $0x802865
  800d2f:	ff 75 0c             	pushl  0xc(%ebp)
  800d32:	ff 75 08             	pushl  0x8(%ebp)
  800d35:	e8 5e 02 00 00       	call   800f98 <printfmt>
  800d3a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d3d:	e9 49 02 00 00       	jmp    800f8b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d42:	56                   	push   %esi
  800d43:	68 6e 28 80 00       	push   $0x80286e
  800d48:	ff 75 0c             	pushl  0xc(%ebp)
  800d4b:	ff 75 08             	pushl  0x8(%ebp)
  800d4e:	e8 45 02 00 00       	call   800f98 <printfmt>
  800d53:	83 c4 10             	add    $0x10,%esp
			break;
  800d56:	e9 30 02 00 00       	jmp    800f8b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d5b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d5e:	83 c0 04             	add    $0x4,%eax
  800d61:	89 45 14             	mov    %eax,0x14(%ebp)
  800d64:	8b 45 14             	mov    0x14(%ebp),%eax
  800d67:	83 e8 04             	sub    $0x4,%eax
  800d6a:	8b 30                	mov    (%eax),%esi
  800d6c:	85 f6                	test   %esi,%esi
  800d6e:	75 05                	jne    800d75 <vprintfmt+0x1a6>
				p = "(null)";
  800d70:	be 71 28 80 00       	mov    $0x802871,%esi
			if (width > 0 && padc != '-')
  800d75:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d79:	7e 6d                	jle    800de8 <vprintfmt+0x219>
  800d7b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d7f:	74 67                	je     800de8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d81:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d84:	83 ec 08             	sub    $0x8,%esp
  800d87:	50                   	push   %eax
  800d88:	56                   	push   %esi
  800d89:	e8 12 05 00 00       	call   8012a0 <strnlen>
  800d8e:	83 c4 10             	add    $0x10,%esp
  800d91:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d94:	eb 16                	jmp    800dac <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d96:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d9a:	83 ec 08             	sub    $0x8,%esp
  800d9d:	ff 75 0c             	pushl  0xc(%ebp)
  800da0:	50                   	push   %eax
  800da1:	8b 45 08             	mov    0x8(%ebp),%eax
  800da4:	ff d0                	call   *%eax
  800da6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800da9:	ff 4d e4             	decl   -0x1c(%ebp)
  800dac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800db0:	7f e4                	jg     800d96 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800db2:	eb 34                	jmp    800de8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800db4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800db8:	74 1c                	je     800dd6 <vprintfmt+0x207>
  800dba:	83 fb 1f             	cmp    $0x1f,%ebx
  800dbd:	7e 05                	jle    800dc4 <vprintfmt+0x1f5>
  800dbf:	83 fb 7e             	cmp    $0x7e,%ebx
  800dc2:	7e 12                	jle    800dd6 <vprintfmt+0x207>
					putch('?', putdat);
  800dc4:	83 ec 08             	sub    $0x8,%esp
  800dc7:	ff 75 0c             	pushl  0xc(%ebp)
  800dca:	6a 3f                	push   $0x3f
  800dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcf:	ff d0                	call   *%eax
  800dd1:	83 c4 10             	add    $0x10,%esp
  800dd4:	eb 0f                	jmp    800de5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800dd6:	83 ec 08             	sub    $0x8,%esp
  800dd9:	ff 75 0c             	pushl  0xc(%ebp)
  800ddc:	53                   	push   %ebx
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	ff d0                	call   *%eax
  800de2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800de5:	ff 4d e4             	decl   -0x1c(%ebp)
  800de8:	89 f0                	mov    %esi,%eax
  800dea:	8d 70 01             	lea    0x1(%eax),%esi
  800ded:	8a 00                	mov    (%eax),%al
  800def:	0f be d8             	movsbl %al,%ebx
  800df2:	85 db                	test   %ebx,%ebx
  800df4:	74 24                	je     800e1a <vprintfmt+0x24b>
  800df6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dfa:	78 b8                	js     800db4 <vprintfmt+0x1e5>
  800dfc:	ff 4d e0             	decl   -0x20(%ebp)
  800dff:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e03:	79 af                	jns    800db4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e05:	eb 13                	jmp    800e1a <vprintfmt+0x24b>
				putch(' ', putdat);
  800e07:	83 ec 08             	sub    $0x8,%esp
  800e0a:	ff 75 0c             	pushl  0xc(%ebp)
  800e0d:	6a 20                	push   $0x20
  800e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e12:	ff d0                	call   *%eax
  800e14:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e17:	ff 4d e4             	decl   -0x1c(%ebp)
  800e1a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e1e:	7f e7                	jg     800e07 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e20:	e9 66 01 00 00       	jmp    800f8b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e25:	83 ec 08             	sub    $0x8,%esp
  800e28:	ff 75 e8             	pushl  -0x18(%ebp)
  800e2b:	8d 45 14             	lea    0x14(%ebp),%eax
  800e2e:	50                   	push   %eax
  800e2f:	e8 3c fd ff ff       	call   800b70 <getint>
  800e34:	83 c4 10             	add    $0x10,%esp
  800e37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e3a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e40:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e43:	85 d2                	test   %edx,%edx
  800e45:	79 23                	jns    800e6a <vprintfmt+0x29b>
				putch('-', putdat);
  800e47:	83 ec 08             	sub    $0x8,%esp
  800e4a:	ff 75 0c             	pushl  0xc(%ebp)
  800e4d:	6a 2d                	push   $0x2d
  800e4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e52:	ff d0                	call   *%eax
  800e54:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e5d:	f7 d8                	neg    %eax
  800e5f:	83 d2 00             	adc    $0x0,%edx
  800e62:	f7 da                	neg    %edx
  800e64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e67:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e6a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e71:	e9 bc 00 00 00       	jmp    800f32 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 e8             	pushl  -0x18(%ebp)
  800e7c:	8d 45 14             	lea    0x14(%ebp),%eax
  800e7f:	50                   	push   %eax
  800e80:	e8 84 fc ff ff       	call   800b09 <getuint>
  800e85:	83 c4 10             	add    $0x10,%esp
  800e88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e8b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e8e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e95:	e9 98 00 00 00       	jmp    800f32 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e9a:	83 ec 08             	sub    $0x8,%esp
  800e9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ea0:	6a 58                	push   $0x58
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	ff d0                	call   *%eax
  800ea7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800eaa:	83 ec 08             	sub    $0x8,%esp
  800ead:	ff 75 0c             	pushl  0xc(%ebp)
  800eb0:	6a 58                	push   $0x58
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	ff d0                	call   *%eax
  800eb7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800eba:	83 ec 08             	sub    $0x8,%esp
  800ebd:	ff 75 0c             	pushl  0xc(%ebp)
  800ec0:	6a 58                	push   $0x58
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	ff d0                	call   *%eax
  800ec7:	83 c4 10             	add    $0x10,%esp
			break;
  800eca:	e9 bc 00 00 00       	jmp    800f8b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ecf:	83 ec 08             	sub    $0x8,%esp
  800ed2:	ff 75 0c             	pushl  0xc(%ebp)
  800ed5:	6a 30                	push   $0x30
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	ff d0                	call   *%eax
  800edc:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800edf:	83 ec 08             	sub    $0x8,%esp
  800ee2:	ff 75 0c             	pushl  0xc(%ebp)
  800ee5:	6a 78                	push   $0x78
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	ff d0                	call   *%eax
  800eec:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eef:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef2:	83 c0 04             	add    $0x4,%eax
  800ef5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ef8:	8b 45 14             	mov    0x14(%ebp),%eax
  800efb:	83 e8 04             	sub    $0x4,%eax
  800efe:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f00:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f03:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f0a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f11:	eb 1f                	jmp    800f32 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f13:	83 ec 08             	sub    $0x8,%esp
  800f16:	ff 75 e8             	pushl  -0x18(%ebp)
  800f19:	8d 45 14             	lea    0x14(%ebp),%eax
  800f1c:	50                   	push   %eax
  800f1d:	e8 e7 fb ff ff       	call   800b09 <getuint>
  800f22:	83 c4 10             	add    $0x10,%esp
  800f25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f28:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f2b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f32:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f36:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f39:	83 ec 04             	sub    $0x4,%esp
  800f3c:	52                   	push   %edx
  800f3d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f40:	50                   	push   %eax
  800f41:	ff 75 f4             	pushl  -0xc(%ebp)
  800f44:	ff 75 f0             	pushl  -0x10(%ebp)
  800f47:	ff 75 0c             	pushl  0xc(%ebp)
  800f4a:	ff 75 08             	pushl  0x8(%ebp)
  800f4d:	e8 00 fb ff ff       	call   800a52 <printnum>
  800f52:	83 c4 20             	add    $0x20,%esp
			break;
  800f55:	eb 34                	jmp    800f8b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f57:	83 ec 08             	sub    $0x8,%esp
  800f5a:	ff 75 0c             	pushl  0xc(%ebp)
  800f5d:	53                   	push   %ebx
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	ff d0                	call   *%eax
  800f63:	83 c4 10             	add    $0x10,%esp
			break;
  800f66:	eb 23                	jmp    800f8b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f68:	83 ec 08             	sub    $0x8,%esp
  800f6b:	ff 75 0c             	pushl  0xc(%ebp)
  800f6e:	6a 25                	push   $0x25
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	ff d0                	call   *%eax
  800f75:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f78:	ff 4d 10             	decl   0x10(%ebp)
  800f7b:	eb 03                	jmp    800f80 <vprintfmt+0x3b1>
  800f7d:	ff 4d 10             	decl   0x10(%ebp)
  800f80:	8b 45 10             	mov    0x10(%ebp),%eax
  800f83:	48                   	dec    %eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	3c 25                	cmp    $0x25,%al
  800f88:	75 f3                	jne    800f7d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f8a:	90                   	nop
		}
	}
  800f8b:	e9 47 fc ff ff       	jmp    800bd7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f90:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f91:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f94:	5b                   	pop    %ebx
  800f95:	5e                   	pop    %esi
  800f96:	5d                   	pop    %ebp
  800f97:	c3                   	ret    

00800f98 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f98:	55                   	push   %ebp
  800f99:	89 e5                	mov    %esp,%ebp
  800f9b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f9e:	8d 45 10             	lea    0x10(%ebp),%eax
  800fa1:	83 c0 04             	add    $0x4,%eax
  800fa4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fa7:	8b 45 10             	mov    0x10(%ebp),%eax
  800faa:	ff 75 f4             	pushl  -0xc(%ebp)
  800fad:	50                   	push   %eax
  800fae:	ff 75 0c             	pushl  0xc(%ebp)
  800fb1:	ff 75 08             	pushl  0x8(%ebp)
  800fb4:	e8 16 fc ff ff       	call   800bcf <vprintfmt>
  800fb9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fbc:	90                   	nop
  800fbd:	c9                   	leave  
  800fbe:	c3                   	ret    

00800fbf <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fbf:	55                   	push   %ebp
  800fc0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc5:	8b 40 08             	mov    0x8(%eax),%eax
  800fc8:	8d 50 01             	lea    0x1(%eax),%edx
  800fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fce:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd4:	8b 10                	mov    (%eax),%edx
  800fd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd9:	8b 40 04             	mov    0x4(%eax),%eax
  800fdc:	39 c2                	cmp    %eax,%edx
  800fde:	73 12                	jae    800ff2 <sprintputch+0x33>
		*b->buf++ = ch;
  800fe0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe3:	8b 00                	mov    (%eax),%eax
  800fe5:	8d 48 01             	lea    0x1(%eax),%ecx
  800fe8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800feb:	89 0a                	mov    %ecx,(%edx)
  800fed:	8b 55 08             	mov    0x8(%ebp),%edx
  800ff0:	88 10                	mov    %dl,(%eax)
}
  800ff2:	90                   	nop
  800ff3:	5d                   	pop    %ebp
  800ff4:	c3                   	ret    

00800ff5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ff5:	55                   	push   %ebp
  800ff6:	89 e5                	mov    %esp,%ebp
  800ff8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801001:	8b 45 0c             	mov    0xc(%ebp),%eax
  801004:	8d 50 ff             	lea    -0x1(%eax),%edx
  801007:	8b 45 08             	mov    0x8(%ebp),%eax
  80100a:	01 d0                	add    %edx,%eax
  80100c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80100f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801016:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80101a:	74 06                	je     801022 <vsnprintf+0x2d>
  80101c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801020:	7f 07                	jg     801029 <vsnprintf+0x34>
		return -E_INVAL;
  801022:	b8 03 00 00 00       	mov    $0x3,%eax
  801027:	eb 20                	jmp    801049 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801029:	ff 75 14             	pushl  0x14(%ebp)
  80102c:	ff 75 10             	pushl  0x10(%ebp)
  80102f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801032:	50                   	push   %eax
  801033:	68 bf 0f 80 00       	push   $0x800fbf
  801038:	e8 92 fb ff ff       	call   800bcf <vprintfmt>
  80103d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801040:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801043:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801046:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801049:	c9                   	leave  
  80104a:	c3                   	ret    

0080104b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80104b:	55                   	push   %ebp
  80104c:	89 e5                	mov    %esp,%ebp
  80104e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801051:	8d 45 10             	lea    0x10(%ebp),%eax
  801054:	83 c0 04             	add    $0x4,%eax
  801057:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80105a:	8b 45 10             	mov    0x10(%ebp),%eax
  80105d:	ff 75 f4             	pushl  -0xc(%ebp)
  801060:	50                   	push   %eax
  801061:	ff 75 0c             	pushl  0xc(%ebp)
  801064:	ff 75 08             	pushl  0x8(%ebp)
  801067:	e8 89 ff ff ff       	call   800ff5 <vsnprintf>
  80106c:	83 c4 10             	add    $0x10,%esp
  80106f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801072:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801075:	c9                   	leave  
  801076:	c3                   	ret    

00801077 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801077:	55                   	push   %ebp
  801078:	89 e5                	mov    %esp,%ebp
  80107a:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80107d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801081:	74 13                	je     801096 <readline+0x1f>
		cprintf("%s", prompt);
  801083:	83 ec 08             	sub    $0x8,%esp
  801086:	ff 75 08             	pushl  0x8(%ebp)
  801089:	68 d0 29 80 00       	push   $0x8029d0
  80108e:	e8 62 f9 ff ff       	call   8009f5 <cprintf>
  801093:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801096:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80109d:	83 ec 0c             	sub    $0xc,%esp
  8010a0:	6a 00                	push   $0x0
  8010a2:	e8 81 f5 ff ff       	call   800628 <iscons>
  8010a7:	83 c4 10             	add    $0x10,%esp
  8010aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010ad:	e8 28 f5 ff ff       	call   8005da <getchar>
  8010b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010b9:	79 22                	jns    8010dd <readline+0x66>
			if (c != -E_EOF)
  8010bb:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010bf:	0f 84 ad 00 00 00    	je     801172 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010c5:	83 ec 08             	sub    $0x8,%esp
  8010c8:	ff 75 ec             	pushl  -0x14(%ebp)
  8010cb:	68 d3 29 80 00       	push   $0x8029d3
  8010d0:	e8 20 f9 ff ff       	call   8009f5 <cprintf>
  8010d5:	83 c4 10             	add    $0x10,%esp
			return;
  8010d8:	e9 95 00 00 00       	jmp    801172 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010dd:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010e1:	7e 34                	jle    801117 <readline+0xa0>
  8010e3:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010ea:	7f 2b                	jg     801117 <readline+0xa0>
			if (echoing)
  8010ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010f0:	74 0e                	je     801100 <readline+0x89>
				cputchar(c);
  8010f2:	83 ec 0c             	sub    $0xc,%esp
  8010f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8010f8:	e8 95 f4 ff ff       	call   800592 <cputchar>
  8010fd:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801100:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801103:	8d 50 01             	lea    0x1(%eax),%edx
  801106:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801109:	89 c2                	mov    %eax,%edx
  80110b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110e:	01 d0                	add    %edx,%eax
  801110:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801113:	88 10                	mov    %dl,(%eax)
  801115:	eb 56                	jmp    80116d <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801117:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80111b:	75 1f                	jne    80113c <readline+0xc5>
  80111d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801121:	7e 19                	jle    80113c <readline+0xc5>
			if (echoing)
  801123:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801127:	74 0e                	je     801137 <readline+0xc0>
				cputchar(c);
  801129:	83 ec 0c             	sub    $0xc,%esp
  80112c:	ff 75 ec             	pushl  -0x14(%ebp)
  80112f:	e8 5e f4 ff ff       	call   800592 <cputchar>
  801134:	83 c4 10             	add    $0x10,%esp

			i--;
  801137:	ff 4d f4             	decl   -0xc(%ebp)
  80113a:	eb 31                	jmp    80116d <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80113c:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801140:	74 0a                	je     80114c <readline+0xd5>
  801142:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801146:	0f 85 61 ff ff ff    	jne    8010ad <readline+0x36>
			if (echoing)
  80114c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801150:	74 0e                	je     801160 <readline+0xe9>
				cputchar(c);
  801152:	83 ec 0c             	sub    $0xc,%esp
  801155:	ff 75 ec             	pushl  -0x14(%ebp)
  801158:	e8 35 f4 ff ff       	call   800592 <cputchar>
  80115d:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801160:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	01 d0                	add    %edx,%eax
  801168:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80116b:	eb 06                	jmp    801173 <readline+0xfc>
		}
	}
  80116d:	e9 3b ff ff ff       	jmp    8010ad <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801172:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801173:	c9                   	leave  
  801174:	c3                   	ret    

00801175 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801175:	55                   	push   %ebp
  801176:	89 e5                	mov    %esp,%ebp
  801178:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80117b:	e8 e3 0a 00 00       	call   801c63 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801180:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801184:	74 13                	je     801199 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801186:	83 ec 08             	sub    $0x8,%esp
  801189:	ff 75 08             	pushl  0x8(%ebp)
  80118c:	68 d0 29 80 00       	push   $0x8029d0
  801191:	e8 5f f8 ff ff       	call   8009f5 <cprintf>
  801196:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801199:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011a0:	83 ec 0c             	sub    $0xc,%esp
  8011a3:	6a 00                	push   $0x0
  8011a5:	e8 7e f4 ff ff       	call   800628 <iscons>
  8011aa:	83 c4 10             	add    $0x10,%esp
  8011ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011b0:	e8 25 f4 ff ff       	call   8005da <getchar>
  8011b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011bc:	79 23                	jns    8011e1 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011be:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011c2:	74 13                	je     8011d7 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011c4:	83 ec 08             	sub    $0x8,%esp
  8011c7:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ca:	68 d3 29 80 00       	push   $0x8029d3
  8011cf:	e8 21 f8 ff ff       	call   8009f5 <cprintf>
  8011d4:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011d7:	e8 a1 0a 00 00       	call   801c7d <sys_enable_interrupt>
			return;
  8011dc:	e9 9a 00 00 00       	jmp    80127b <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011e1:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011e5:	7e 34                	jle    80121b <atomic_readline+0xa6>
  8011e7:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011ee:	7f 2b                	jg     80121b <atomic_readline+0xa6>
			if (echoing)
  8011f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011f4:	74 0e                	je     801204 <atomic_readline+0x8f>
				cputchar(c);
  8011f6:	83 ec 0c             	sub    $0xc,%esp
  8011f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8011fc:	e8 91 f3 ff ff       	call   800592 <cputchar>
  801201:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801204:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801207:	8d 50 01             	lea    0x1(%eax),%edx
  80120a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80120d:	89 c2                	mov    %eax,%edx
  80120f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801212:	01 d0                	add    %edx,%eax
  801214:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801217:	88 10                	mov    %dl,(%eax)
  801219:	eb 5b                	jmp    801276 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80121b:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80121f:	75 1f                	jne    801240 <atomic_readline+0xcb>
  801221:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801225:	7e 19                	jle    801240 <atomic_readline+0xcb>
			if (echoing)
  801227:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80122b:	74 0e                	je     80123b <atomic_readline+0xc6>
				cputchar(c);
  80122d:	83 ec 0c             	sub    $0xc,%esp
  801230:	ff 75 ec             	pushl  -0x14(%ebp)
  801233:	e8 5a f3 ff ff       	call   800592 <cputchar>
  801238:	83 c4 10             	add    $0x10,%esp
			i--;
  80123b:	ff 4d f4             	decl   -0xc(%ebp)
  80123e:	eb 36                	jmp    801276 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801240:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801244:	74 0a                	je     801250 <atomic_readline+0xdb>
  801246:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80124a:	0f 85 60 ff ff ff    	jne    8011b0 <atomic_readline+0x3b>
			if (echoing)
  801250:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801254:	74 0e                	je     801264 <atomic_readline+0xef>
				cputchar(c);
  801256:	83 ec 0c             	sub    $0xc,%esp
  801259:	ff 75 ec             	pushl  -0x14(%ebp)
  80125c:	e8 31 f3 ff ff       	call   800592 <cputchar>
  801261:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801264:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801267:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126a:	01 d0                	add    %edx,%eax
  80126c:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80126f:	e8 09 0a 00 00       	call   801c7d <sys_enable_interrupt>
			return;
  801274:	eb 05                	jmp    80127b <atomic_readline+0x106>
		}
	}
  801276:	e9 35 ff ff ff       	jmp    8011b0 <atomic_readline+0x3b>
}
  80127b:	c9                   	leave  
  80127c:	c3                   	ret    

0080127d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80127d:	55                   	push   %ebp
  80127e:	89 e5                	mov    %esp,%ebp
  801280:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801283:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80128a:	eb 06                	jmp    801292 <strlen+0x15>
		n++;
  80128c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80128f:	ff 45 08             	incl   0x8(%ebp)
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	8a 00                	mov    (%eax),%al
  801297:	84 c0                	test   %al,%al
  801299:	75 f1                	jne    80128c <strlen+0xf>
		n++;
	return n;
  80129b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
  8012a3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012ad:	eb 09                	jmp    8012b8 <strnlen+0x18>
		n++;
  8012af:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012b2:	ff 45 08             	incl   0x8(%ebp)
  8012b5:	ff 4d 0c             	decl   0xc(%ebp)
  8012b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012bc:	74 09                	je     8012c7 <strnlen+0x27>
  8012be:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c1:	8a 00                	mov    (%eax),%al
  8012c3:	84 c0                	test   %al,%al
  8012c5:	75 e8                	jne    8012af <strnlen+0xf>
		n++;
	return n;
  8012c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012ca:	c9                   	leave  
  8012cb:	c3                   	ret    

008012cc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012cc:	55                   	push   %ebp
  8012cd:	89 e5                	mov    %esp,%ebp
  8012cf:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012d8:	90                   	nop
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	8d 50 01             	lea    0x1(%eax),%edx
  8012df:	89 55 08             	mov    %edx,0x8(%ebp)
  8012e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012e8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012eb:	8a 12                	mov    (%edx),%dl
  8012ed:	88 10                	mov    %dl,(%eax)
  8012ef:	8a 00                	mov    (%eax),%al
  8012f1:	84 c0                	test   %al,%al
  8012f3:	75 e4                	jne    8012d9 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012f8:	c9                   	leave  
  8012f9:	c3                   	ret    

008012fa <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012fa:	55                   	push   %ebp
  8012fb:	89 e5                	mov    %esp,%ebp
  8012fd:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801300:	8b 45 08             	mov    0x8(%ebp),%eax
  801303:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801306:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80130d:	eb 1f                	jmp    80132e <strncpy+0x34>
		*dst++ = *src;
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	8d 50 01             	lea    0x1(%eax),%edx
  801315:	89 55 08             	mov    %edx,0x8(%ebp)
  801318:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131b:	8a 12                	mov    (%edx),%dl
  80131d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80131f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801322:	8a 00                	mov    (%eax),%al
  801324:	84 c0                	test   %al,%al
  801326:	74 03                	je     80132b <strncpy+0x31>
			src++;
  801328:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80132b:	ff 45 fc             	incl   -0x4(%ebp)
  80132e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801331:	3b 45 10             	cmp    0x10(%ebp),%eax
  801334:	72 d9                	jb     80130f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801336:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801339:	c9                   	leave  
  80133a:	c3                   	ret    

0080133b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80133b:	55                   	push   %ebp
  80133c:	89 e5                	mov    %esp,%ebp
  80133e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801347:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80134b:	74 30                	je     80137d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80134d:	eb 16                	jmp    801365 <strlcpy+0x2a>
			*dst++ = *src++;
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	8d 50 01             	lea    0x1(%eax),%edx
  801355:	89 55 08             	mov    %edx,0x8(%ebp)
  801358:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80135e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801361:	8a 12                	mov    (%edx),%dl
  801363:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801365:	ff 4d 10             	decl   0x10(%ebp)
  801368:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80136c:	74 09                	je     801377 <strlcpy+0x3c>
  80136e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801371:	8a 00                	mov    (%eax),%al
  801373:	84 c0                	test   %al,%al
  801375:	75 d8                	jne    80134f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80137d:	8b 55 08             	mov    0x8(%ebp),%edx
  801380:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801383:	29 c2                	sub    %eax,%edx
  801385:	89 d0                	mov    %edx,%eax
}
  801387:	c9                   	leave  
  801388:	c3                   	ret    

00801389 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801389:	55                   	push   %ebp
  80138a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80138c:	eb 06                	jmp    801394 <strcmp+0xb>
		p++, q++;
  80138e:	ff 45 08             	incl   0x8(%ebp)
  801391:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	8a 00                	mov    (%eax),%al
  801399:	84 c0                	test   %al,%al
  80139b:	74 0e                	je     8013ab <strcmp+0x22>
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 10                	mov    (%eax),%dl
  8013a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a5:	8a 00                	mov    (%eax),%al
  8013a7:	38 c2                	cmp    %al,%dl
  8013a9:	74 e3                	je     80138e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8a 00                	mov    (%eax),%al
  8013b0:	0f b6 d0             	movzbl %al,%edx
  8013b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b6:	8a 00                	mov    (%eax),%al
  8013b8:	0f b6 c0             	movzbl %al,%eax
  8013bb:	29 c2                	sub    %eax,%edx
  8013bd:	89 d0                	mov    %edx,%eax
}
  8013bf:	5d                   	pop    %ebp
  8013c0:	c3                   	ret    

008013c1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013c1:	55                   	push   %ebp
  8013c2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013c4:	eb 09                	jmp    8013cf <strncmp+0xe>
		n--, p++, q++;
  8013c6:	ff 4d 10             	decl   0x10(%ebp)
  8013c9:	ff 45 08             	incl   0x8(%ebp)
  8013cc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013cf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d3:	74 17                	je     8013ec <strncmp+0x2b>
  8013d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d8:	8a 00                	mov    (%eax),%al
  8013da:	84 c0                	test   %al,%al
  8013dc:	74 0e                	je     8013ec <strncmp+0x2b>
  8013de:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e1:	8a 10                	mov    (%eax),%dl
  8013e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e6:	8a 00                	mov    (%eax),%al
  8013e8:	38 c2                	cmp    %al,%dl
  8013ea:	74 da                	je     8013c6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f0:	75 07                	jne    8013f9 <strncmp+0x38>
		return 0;
  8013f2:	b8 00 00 00 00       	mov    $0x0,%eax
  8013f7:	eb 14                	jmp    80140d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	8a 00                	mov    (%eax),%al
  8013fe:	0f b6 d0             	movzbl %al,%edx
  801401:	8b 45 0c             	mov    0xc(%ebp),%eax
  801404:	8a 00                	mov    (%eax),%al
  801406:	0f b6 c0             	movzbl %al,%eax
  801409:	29 c2                	sub    %eax,%edx
  80140b:	89 d0                	mov    %edx,%eax
}
  80140d:	5d                   	pop    %ebp
  80140e:	c3                   	ret    

0080140f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80140f:	55                   	push   %ebp
  801410:	89 e5                	mov    %esp,%ebp
  801412:	83 ec 04             	sub    $0x4,%esp
  801415:	8b 45 0c             	mov    0xc(%ebp),%eax
  801418:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80141b:	eb 12                	jmp    80142f <strchr+0x20>
		if (*s == c)
  80141d:	8b 45 08             	mov    0x8(%ebp),%eax
  801420:	8a 00                	mov    (%eax),%al
  801422:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801425:	75 05                	jne    80142c <strchr+0x1d>
			return (char *) s;
  801427:	8b 45 08             	mov    0x8(%ebp),%eax
  80142a:	eb 11                	jmp    80143d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80142c:	ff 45 08             	incl   0x8(%ebp)
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	84 c0                	test   %al,%al
  801436:	75 e5                	jne    80141d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801438:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80143d:	c9                   	leave  
  80143e:	c3                   	ret    

0080143f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80143f:	55                   	push   %ebp
  801440:	89 e5                	mov    %esp,%ebp
  801442:	83 ec 04             	sub    $0x4,%esp
  801445:	8b 45 0c             	mov    0xc(%ebp),%eax
  801448:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80144b:	eb 0d                	jmp    80145a <strfind+0x1b>
		if (*s == c)
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801455:	74 0e                	je     801465 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801457:	ff 45 08             	incl   0x8(%ebp)
  80145a:	8b 45 08             	mov    0x8(%ebp),%eax
  80145d:	8a 00                	mov    (%eax),%al
  80145f:	84 c0                	test   %al,%al
  801461:	75 ea                	jne    80144d <strfind+0xe>
  801463:	eb 01                	jmp    801466 <strfind+0x27>
		if (*s == c)
			break;
  801465:	90                   	nop
	return (char *) s;
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801469:	c9                   	leave  
  80146a:	c3                   	ret    

0080146b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80146b:	55                   	push   %ebp
  80146c:	89 e5                	mov    %esp,%ebp
  80146e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801471:	8b 45 08             	mov    0x8(%ebp),%eax
  801474:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801477:	8b 45 10             	mov    0x10(%ebp),%eax
  80147a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80147d:	eb 0e                	jmp    80148d <memset+0x22>
		*p++ = c;
  80147f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801482:	8d 50 01             	lea    0x1(%eax),%edx
  801485:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801488:	8b 55 0c             	mov    0xc(%ebp),%edx
  80148b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80148d:	ff 4d f8             	decl   -0x8(%ebp)
  801490:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801494:	79 e9                	jns    80147f <memset+0x14>
		*p++ = c;

	return v;
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801499:	c9                   	leave  
  80149a:	c3                   	ret    

0080149b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80149b:	55                   	push   %ebp
  80149c:	89 e5                	mov    %esp,%ebp
  80149e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014ad:	eb 16                	jmp    8014c5 <memcpy+0x2a>
		*d++ = *s++;
  8014af:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b2:	8d 50 01             	lea    0x1(%eax),%edx
  8014b5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014bb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014be:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014c1:	8a 12                	mov    (%edx),%dl
  8014c3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014cb:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ce:	85 c0                	test   %eax,%eax
  8014d0:	75 dd                	jne    8014af <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
  8014da:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8014dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014ef:	73 50                	jae    801541 <memmove+0x6a>
  8014f1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f7:	01 d0                	add    %edx,%eax
  8014f9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014fc:	76 43                	jbe    801541 <memmove+0x6a>
		s += n;
  8014fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801501:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801504:	8b 45 10             	mov    0x10(%ebp),%eax
  801507:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80150a:	eb 10                	jmp    80151c <memmove+0x45>
			*--d = *--s;
  80150c:	ff 4d f8             	decl   -0x8(%ebp)
  80150f:	ff 4d fc             	decl   -0x4(%ebp)
  801512:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801515:	8a 10                	mov    (%eax),%dl
  801517:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80151a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80151c:	8b 45 10             	mov    0x10(%ebp),%eax
  80151f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801522:	89 55 10             	mov    %edx,0x10(%ebp)
  801525:	85 c0                	test   %eax,%eax
  801527:	75 e3                	jne    80150c <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801529:	eb 23                	jmp    80154e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80152b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80152e:	8d 50 01             	lea    0x1(%eax),%edx
  801531:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801534:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801537:	8d 4a 01             	lea    0x1(%edx),%ecx
  80153a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80153d:	8a 12                	mov    (%edx),%dl
  80153f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801541:	8b 45 10             	mov    0x10(%ebp),%eax
  801544:	8d 50 ff             	lea    -0x1(%eax),%edx
  801547:	89 55 10             	mov    %edx,0x10(%ebp)
  80154a:	85 c0                	test   %eax,%eax
  80154c:	75 dd                	jne    80152b <memmove+0x54>
			*d++ = *s++;

	return dst;
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
  801556:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80155f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801562:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801565:	eb 2a                	jmp    801591 <memcmp+0x3e>
		if (*s1 != *s2)
  801567:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80156a:	8a 10                	mov    (%eax),%dl
  80156c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80156f:	8a 00                	mov    (%eax),%al
  801571:	38 c2                	cmp    %al,%dl
  801573:	74 16                	je     80158b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801575:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801578:	8a 00                	mov    (%eax),%al
  80157a:	0f b6 d0             	movzbl %al,%edx
  80157d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801580:	8a 00                	mov    (%eax),%al
  801582:	0f b6 c0             	movzbl %al,%eax
  801585:	29 c2                	sub    %eax,%edx
  801587:	89 d0                	mov    %edx,%eax
  801589:	eb 18                	jmp    8015a3 <memcmp+0x50>
		s1++, s2++;
  80158b:	ff 45 fc             	incl   -0x4(%ebp)
  80158e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801591:	8b 45 10             	mov    0x10(%ebp),%eax
  801594:	8d 50 ff             	lea    -0x1(%eax),%edx
  801597:	89 55 10             	mov    %edx,0x10(%ebp)
  80159a:	85 c0                	test   %eax,%eax
  80159c:	75 c9                	jne    801567 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80159e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a3:	c9                   	leave  
  8015a4:	c3                   	ret    

008015a5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015a5:	55                   	push   %ebp
  8015a6:	89 e5                	mov    %esp,%ebp
  8015a8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8015ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b1:	01 d0                	add    %edx,%eax
  8015b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015b6:	eb 15                	jmp    8015cd <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	8a 00                	mov    (%eax),%al
  8015bd:	0f b6 d0             	movzbl %al,%edx
  8015c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c3:	0f b6 c0             	movzbl %al,%eax
  8015c6:	39 c2                	cmp    %eax,%edx
  8015c8:	74 0d                	je     8015d7 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015ca:	ff 45 08             	incl   0x8(%ebp)
  8015cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015d3:	72 e3                	jb     8015b8 <memfind+0x13>
  8015d5:	eb 01                	jmp    8015d8 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015d7:	90                   	nop
	return (void *) s;
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
  8015e0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015ea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015f1:	eb 03                	jmp    8015f6 <strtol+0x19>
		s++;
  8015f3:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f9:	8a 00                	mov    (%eax),%al
  8015fb:	3c 20                	cmp    $0x20,%al
  8015fd:	74 f4                	je     8015f3 <strtol+0x16>
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801602:	8a 00                	mov    (%eax),%al
  801604:	3c 09                	cmp    $0x9,%al
  801606:	74 eb                	je     8015f3 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801608:	8b 45 08             	mov    0x8(%ebp),%eax
  80160b:	8a 00                	mov    (%eax),%al
  80160d:	3c 2b                	cmp    $0x2b,%al
  80160f:	75 05                	jne    801616 <strtol+0x39>
		s++;
  801611:	ff 45 08             	incl   0x8(%ebp)
  801614:	eb 13                	jmp    801629 <strtol+0x4c>
	else if (*s == '-')
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	8a 00                	mov    (%eax),%al
  80161b:	3c 2d                	cmp    $0x2d,%al
  80161d:	75 0a                	jne    801629 <strtol+0x4c>
		s++, neg = 1;
  80161f:	ff 45 08             	incl   0x8(%ebp)
  801622:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801629:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80162d:	74 06                	je     801635 <strtol+0x58>
  80162f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801633:	75 20                	jne    801655 <strtol+0x78>
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	8a 00                	mov    (%eax),%al
  80163a:	3c 30                	cmp    $0x30,%al
  80163c:	75 17                	jne    801655 <strtol+0x78>
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	40                   	inc    %eax
  801642:	8a 00                	mov    (%eax),%al
  801644:	3c 78                	cmp    $0x78,%al
  801646:	75 0d                	jne    801655 <strtol+0x78>
		s += 2, base = 16;
  801648:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80164c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801653:	eb 28                	jmp    80167d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801655:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801659:	75 15                	jne    801670 <strtol+0x93>
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	8a 00                	mov    (%eax),%al
  801660:	3c 30                	cmp    $0x30,%al
  801662:	75 0c                	jne    801670 <strtol+0x93>
		s++, base = 8;
  801664:	ff 45 08             	incl   0x8(%ebp)
  801667:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80166e:	eb 0d                	jmp    80167d <strtol+0xa0>
	else if (base == 0)
  801670:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801674:	75 07                	jne    80167d <strtol+0xa0>
		base = 10;
  801676:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80167d:	8b 45 08             	mov    0x8(%ebp),%eax
  801680:	8a 00                	mov    (%eax),%al
  801682:	3c 2f                	cmp    $0x2f,%al
  801684:	7e 19                	jle    80169f <strtol+0xc2>
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	8a 00                	mov    (%eax),%al
  80168b:	3c 39                	cmp    $0x39,%al
  80168d:	7f 10                	jg     80169f <strtol+0xc2>
			dig = *s - '0';
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	8a 00                	mov    (%eax),%al
  801694:	0f be c0             	movsbl %al,%eax
  801697:	83 e8 30             	sub    $0x30,%eax
  80169a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80169d:	eb 42                	jmp    8016e1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80169f:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a2:	8a 00                	mov    (%eax),%al
  8016a4:	3c 60                	cmp    $0x60,%al
  8016a6:	7e 19                	jle    8016c1 <strtol+0xe4>
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	8a 00                	mov    (%eax),%al
  8016ad:	3c 7a                	cmp    $0x7a,%al
  8016af:	7f 10                	jg     8016c1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b4:	8a 00                	mov    (%eax),%al
  8016b6:	0f be c0             	movsbl %al,%eax
  8016b9:	83 e8 57             	sub    $0x57,%eax
  8016bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016bf:	eb 20                	jmp    8016e1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c4:	8a 00                	mov    (%eax),%al
  8016c6:	3c 40                	cmp    $0x40,%al
  8016c8:	7e 39                	jle    801703 <strtol+0x126>
  8016ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cd:	8a 00                	mov    (%eax),%al
  8016cf:	3c 5a                	cmp    $0x5a,%al
  8016d1:	7f 30                	jg     801703 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d6:	8a 00                	mov    (%eax),%al
  8016d8:	0f be c0             	movsbl %al,%eax
  8016db:	83 e8 37             	sub    $0x37,%eax
  8016de:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016e4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016e7:	7d 19                	jge    801702 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016e9:	ff 45 08             	incl   0x8(%ebp)
  8016ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ef:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016f3:	89 c2                	mov    %eax,%edx
  8016f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016f8:	01 d0                	add    %edx,%eax
  8016fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016fd:	e9 7b ff ff ff       	jmp    80167d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801702:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801703:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801707:	74 08                	je     801711 <strtol+0x134>
		*endptr = (char *) s;
  801709:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170c:	8b 55 08             	mov    0x8(%ebp),%edx
  80170f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801711:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801715:	74 07                	je     80171e <strtol+0x141>
  801717:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171a:	f7 d8                	neg    %eax
  80171c:	eb 03                	jmp    801721 <strtol+0x144>
  80171e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <ltostr>:

void
ltostr(long value, char *str)
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
  801726:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801729:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801730:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801737:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80173b:	79 13                	jns    801750 <ltostr+0x2d>
	{
		neg = 1;
  80173d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801744:	8b 45 0c             	mov    0xc(%ebp),%eax
  801747:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80174a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80174d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801758:	99                   	cltd   
  801759:	f7 f9                	idiv   %ecx
  80175b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80175e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801761:	8d 50 01             	lea    0x1(%eax),%edx
  801764:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801767:	89 c2                	mov    %eax,%edx
  801769:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176c:	01 d0                	add    %edx,%eax
  80176e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801771:	83 c2 30             	add    $0x30,%edx
  801774:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801776:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801779:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80177e:	f7 e9                	imul   %ecx
  801780:	c1 fa 02             	sar    $0x2,%edx
  801783:	89 c8                	mov    %ecx,%eax
  801785:	c1 f8 1f             	sar    $0x1f,%eax
  801788:	29 c2                	sub    %eax,%edx
  80178a:	89 d0                	mov    %edx,%eax
  80178c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80178f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801792:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801797:	f7 e9                	imul   %ecx
  801799:	c1 fa 02             	sar    $0x2,%edx
  80179c:	89 c8                	mov    %ecx,%eax
  80179e:	c1 f8 1f             	sar    $0x1f,%eax
  8017a1:	29 c2                	sub    %eax,%edx
  8017a3:	89 d0                	mov    %edx,%eax
  8017a5:	c1 e0 02             	shl    $0x2,%eax
  8017a8:	01 d0                	add    %edx,%eax
  8017aa:	01 c0                	add    %eax,%eax
  8017ac:	29 c1                	sub    %eax,%ecx
  8017ae:	89 ca                	mov    %ecx,%edx
  8017b0:	85 d2                	test   %edx,%edx
  8017b2:	75 9c                	jne    801750 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017be:	48                   	dec    %eax
  8017bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017c2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017c6:	74 3d                	je     801805 <ltostr+0xe2>
		start = 1 ;
  8017c8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017cf:	eb 34                	jmp    801805 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d7:	01 d0                	add    %edx,%eax
  8017d9:	8a 00                	mov    (%eax),%al
  8017db:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e4:	01 c2                	add    %eax,%edx
  8017e6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ec:	01 c8                	add    %ecx,%eax
  8017ee:	8a 00                	mov    (%eax),%al
  8017f0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017f2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f8:	01 c2                	add    %eax,%edx
  8017fa:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017fd:	88 02                	mov    %al,(%edx)
		start++ ;
  8017ff:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801802:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801805:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801808:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80180b:	7c c4                	jl     8017d1 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80180d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801810:	8b 45 0c             	mov    0xc(%ebp),%eax
  801813:	01 d0                	add    %edx,%eax
  801815:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801818:	90                   	nop
  801819:	c9                   	leave  
  80181a:	c3                   	ret    

0080181b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80181b:	55                   	push   %ebp
  80181c:	89 e5                	mov    %esp,%ebp
  80181e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801821:	ff 75 08             	pushl  0x8(%ebp)
  801824:	e8 54 fa ff ff       	call   80127d <strlen>
  801829:	83 c4 04             	add    $0x4,%esp
  80182c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80182f:	ff 75 0c             	pushl  0xc(%ebp)
  801832:	e8 46 fa ff ff       	call   80127d <strlen>
  801837:	83 c4 04             	add    $0x4,%esp
  80183a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80183d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801844:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80184b:	eb 17                	jmp    801864 <strcconcat+0x49>
		final[s] = str1[s] ;
  80184d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801850:	8b 45 10             	mov    0x10(%ebp),%eax
  801853:	01 c2                	add    %eax,%edx
  801855:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801858:	8b 45 08             	mov    0x8(%ebp),%eax
  80185b:	01 c8                	add    %ecx,%eax
  80185d:	8a 00                	mov    (%eax),%al
  80185f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801861:	ff 45 fc             	incl   -0x4(%ebp)
  801864:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801867:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80186a:	7c e1                	jl     80184d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80186c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801873:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80187a:	eb 1f                	jmp    80189b <strcconcat+0x80>
		final[s++] = str2[i] ;
  80187c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80187f:	8d 50 01             	lea    0x1(%eax),%edx
  801882:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801885:	89 c2                	mov    %eax,%edx
  801887:	8b 45 10             	mov    0x10(%ebp),%eax
  80188a:	01 c2                	add    %eax,%edx
  80188c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80188f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801892:	01 c8                	add    %ecx,%eax
  801894:	8a 00                	mov    (%eax),%al
  801896:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801898:	ff 45 f8             	incl   -0x8(%ebp)
  80189b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80189e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018a1:	7c d9                	jl     80187c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a9:	01 d0                	add    %edx,%eax
  8018ab:	c6 00 00             	movb   $0x0,(%eax)
}
  8018ae:	90                   	nop
  8018af:	c9                   	leave  
  8018b0:	c3                   	ret    

008018b1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018b1:	55                   	push   %ebp
  8018b2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8018c0:	8b 00                	mov    (%eax),%eax
  8018c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cc:	01 d0                	add    %edx,%eax
  8018ce:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018d4:	eb 0c                	jmp    8018e2 <strsplit+0x31>
			*string++ = 0;
  8018d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d9:	8d 50 01             	lea    0x1(%eax),%edx
  8018dc:	89 55 08             	mov    %edx,0x8(%ebp)
  8018df:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e5:	8a 00                	mov    (%eax),%al
  8018e7:	84 c0                	test   %al,%al
  8018e9:	74 18                	je     801903 <strsplit+0x52>
  8018eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ee:	8a 00                	mov    (%eax),%al
  8018f0:	0f be c0             	movsbl %al,%eax
  8018f3:	50                   	push   %eax
  8018f4:	ff 75 0c             	pushl  0xc(%ebp)
  8018f7:	e8 13 fb ff ff       	call   80140f <strchr>
  8018fc:	83 c4 08             	add    $0x8,%esp
  8018ff:	85 c0                	test   %eax,%eax
  801901:	75 d3                	jne    8018d6 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801903:	8b 45 08             	mov    0x8(%ebp),%eax
  801906:	8a 00                	mov    (%eax),%al
  801908:	84 c0                	test   %al,%al
  80190a:	74 5a                	je     801966 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80190c:	8b 45 14             	mov    0x14(%ebp),%eax
  80190f:	8b 00                	mov    (%eax),%eax
  801911:	83 f8 0f             	cmp    $0xf,%eax
  801914:	75 07                	jne    80191d <strsplit+0x6c>
		{
			return 0;
  801916:	b8 00 00 00 00       	mov    $0x0,%eax
  80191b:	eb 66                	jmp    801983 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80191d:	8b 45 14             	mov    0x14(%ebp),%eax
  801920:	8b 00                	mov    (%eax),%eax
  801922:	8d 48 01             	lea    0x1(%eax),%ecx
  801925:	8b 55 14             	mov    0x14(%ebp),%edx
  801928:	89 0a                	mov    %ecx,(%edx)
  80192a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801931:	8b 45 10             	mov    0x10(%ebp),%eax
  801934:	01 c2                	add    %eax,%edx
  801936:	8b 45 08             	mov    0x8(%ebp),%eax
  801939:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80193b:	eb 03                	jmp    801940 <strsplit+0x8f>
			string++;
  80193d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801940:	8b 45 08             	mov    0x8(%ebp),%eax
  801943:	8a 00                	mov    (%eax),%al
  801945:	84 c0                	test   %al,%al
  801947:	74 8b                	je     8018d4 <strsplit+0x23>
  801949:	8b 45 08             	mov    0x8(%ebp),%eax
  80194c:	8a 00                	mov    (%eax),%al
  80194e:	0f be c0             	movsbl %al,%eax
  801951:	50                   	push   %eax
  801952:	ff 75 0c             	pushl  0xc(%ebp)
  801955:	e8 b5 fa ff ff       	call   80140f <strchr>
  80195a:	83 c4 08             	add    $0x8,%esp
  80195d:	85 c0                	test   %eax,%eax
  80195f:	74 dc                	je     80193d <strsplit+0x8c>
			string++;
	}
  801961:	e9 6e ff ff ff       	jmp    8018d4 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801966:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801967:	8b 45 14             	mov    0x14(%ebp),%eax
  80196a:	8b 00                	mov    (%eax),%eax
  80196c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801973:	8b 45 10             	mov    0x10(%ebp),%eax
  801976:	01 d0                	add    %edx,%eax
  801978:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80197e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801983:	c9                   	leave  
  801984:	c3                   	ret    

00801985 <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  801985:	55                   	push   %ebp
  801986:	89 e5                	mov    %esp,%ebp
  801988:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  80198b:	83 ec 04             	sub    $0x4,%esp
  80198e:	68 e4 29 80 00       	push   $0x8029e4
  801993:	6a 19                	push   $0x19
  801995:	68 09 2a 80 00       	push   $0x802a09
  80199a:	e8 a2 ed ff ff       	call   800741 <_panic>

0080199f <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80199f:	55                   	push   %ebp
  8019a0:	89 e5                	mov    %esp,%ebp
  8019a2:	83 ec 18             	sub    $0x18,%esp
  8019a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a8:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8019ab:	83 ec 04             	sub    $0x4,%esp
  8019ae:	68 18 2a 80 00       	push   $0x802a18
  8019b3:	6a 30                	push   $0x30
  8019b5:	68 09 2a 80 00       	push   $0x802a09
  8019ba:	e8 82 ed ff ff       	call   800741 <_panic>

008019bf <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8019bf:	55                   	push   %ebp
  8019c0:	89 e5                	mov    %esp,%ebp
  8019c2:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8019c5:	83 ec 04             	sub    $0x4,%esp
  8019c8:	68 37 2a 80 00       	push   $0x802a37
  8019cd:	6a 36                	push   $0x36
  8019cf:	68 09 2a 80 00       	push   $0x802a09
  8019d4:	e8 68 ed ff ff       	call   800741 <_panic>

008019d9 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
  8019dc:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8019df:	83 ec 04             	sub    $0x4,%esp
  8019e2:	68 54 2a 80 00       	push   $0x802a54
  8019e7:	6a 48                	push   $0x48
  8019e9:	68 09 2a 80 00       	push   $0x802a09
  8019ee:	e8 4e ed ff ff       	call   800741 <_panic>

008019f3 <sfree>:

}


void sfree(void* virtual_address)
{
  8019f3:	55                   	push   %ebp
  8019f4:	89 e5                	mov    %esp,%ebp
  8019f6:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8019f9:	83 ec 04             	sub    $0x4,%esp
  8019fc:	68 77 2a 80 00       	push   $0x802a77
  801a01:	6a 53                	push   $0x53
  801a03:	68 09 2a 80 00       	push   $0x802a09
  801a08:	e8 34 ed ff ff       	call   800741 <_panic>

00801a0d <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
  801a10:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801a13:	83 ec 04             	sub    $0x4,%esp
  801a16:	68 94 2a 80 00       	push   $0x802a94
  801a1b:	6a 6c                	push   $0x6c
  801a1d:	68 09 2a 80 00       	push   $0x802a09
  801a22:	e8 1a ed ff ff       	call   800741 <_panic>

00801a27 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
  801a2a:	57                   	push   %edi
  801a2b:	56                   	push   %esi
  801a2c:	53                   	push   %ebx
  801a2d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a30:	8b 45 08             	mov    0x8(%ebp),%eax
  801a33:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a36:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a39:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a3c:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a3f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a42:	cd 30                	int    $0x30
  801a44:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a47:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a4a:	83 c4 10             	add    $0x10,%esp
  801a4d:	5b                   	pop    %ebx
  801a4e:	5e                   	pop    %esi
  801a4f:	5f                   	pop    %edi
  801a50:	5d                   	pop    %ebp
  801a51:	c3                   	ret    

00801a52 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
  801a55:	83 ec 04             	sub    $0x4,%esp
  801a58:	8b 45 10             	mov    0x10(%ebp),%eax
  801a5b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a5e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a62:	8b 45 08             	mov    0x8(%ebp),%eax
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	52                   	push   %edx
  801a6a:	ff 75 0c             	pushl  0xc(%ebp)
  801a6d:	50                   	push   %eax
  801a6e:	6a 00                	push   $0x0
  801a70:	e8 b2 ff ff ff       	call   801a27 <syscall>
  801a75:	83 c4 18             	add    $0x18,%esp
}
  801a78:	90                   	nop
  801a79:	c9                   	leave  
  801a7a:	c3                   	ret    

00801a7b <sys_cgetc>:

int
sys_cgetc(void)
{
  801a7b:	55                   	push   %ebp
  801a7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	6a 01                	push   $0x1
  801a8a:	e8 98 ff ff ff       	call   801a27 <syscall>
  801a8f:	83 c4 18             	add    $0x18,%esp
}
  801a92:	c9                   	leave  
  801a93:	c3                   	ret    

00801a94 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a94:	55                   	push   %ebp
  801a95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a97:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	50                   	push   %eax
  801aa3:	6a 05                	push   $0x5
  801aa5:	e8 7d ff ff ff       	call   801a27 <syscall>
  801aaa:	83 c4 18             	add    $0x18,%esp
}
  801aad:	c9                   	leave  
  801aae:	c3                   	ret    

00801aaf <sys_getenvid>:

int32 sys_getenvid(void)
{
  801aaf:	55                   	push   %ebp
  801ab0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 02                	push   $0x2
  801abe:	e8 64 ff ff ff       	call   801a27 <syscall>
  801ac3:	83 c4 18             	add    $0x18,%esp
}
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 03                	push   $0x3
  801ad7:	e8 4b ff ff ff       	call   801a27 <syscall>
  801adc:	83 c4 18             	add    $0x18,%esp
}
  801adf:	c9                   	leave  
  801ae0:	c3                   	ret    

00801ae1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ae1:	55                   	push   %ebp
  801ae2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 04                	push   $0x4
  801af0:	e8 32 ff ff ff       	call   801a27 <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
}
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <sys_env_exit>:


void sys_env_exit(void)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 06                	push   $0x6
  801b09:	e8 19 ff ff ff       	call   801a27 <syscall>
  801b0e:	83 c4 18             	add    $0x18,%esp
}
  801b11:	90                   	nop
  801b12:	c9                   	leave  
  801b13:	c3                   	ret    

00801b14 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b14:	55                   	push   %ebp
  801b15:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	52                   	push   %edx
  801b24:	50                   	push   %eax
  801b25:	6a 07                	push   $0x7
  801b27:	e8 fb fe ff ff       	call   801a27 <syscall>
  801b2c:	83 c4 18             	add    $0x18,%esp
}
  801b2f:	c9                   	leave  
  801b30:	c3                   	ret    

00801b31 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b31:	55                   	push   %ebp
  801b32:	89 e5                	mov    %esp,%ebp
  801b34:	56                   	push   %esi
  801b35:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b36:	8b 75 18             	mov    0x18(%ebp),%esi
  801b39:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b3c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b3f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b42:	8b 45 08             	mov    0x8(%ebp),%eax
  801b45:	56                   	push   %esi
  801b46:	53                   	push   %ebx
  801b47:	51                   	push   %ecx
  801b48:	52                   	push   %edx
  801b49:	50                   	push   %eax
  801b4a:	6a 08                	push   $0x8
  801b4c:	e8 d6 fe ff ff       	call   801a27 <syscall>
  801b51:	83 c4 18             	add    $0x18,%esp
}
  801b54:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b57:	5b                   	pop    %ebx
  801b58:	5e                   	pop    %esi
  801b59:	5d                   	pop    %ebp
  801b5a:	c3                   	ret    

00801b5b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b5b:	55                   	push   %ebp
  801b5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b61:	8b 45 08             	mov    0x8(%ebp),%eax
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	6a 00                	push   $0x0
  801b6a:	52                   	push   %edx
  801b6b:	50                   	push   %eax
  801b6c:	6a 09                	push   $0x9
  801b6e:	e8 b4 fe ff ff       	call   801a27 <syscall>
  801b73:	83 c4 18             	add    $0x18,%esp
}
  801b76:	c9                   	leave  
  801b77:	c3                   	ret    

00801b78 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b78:	55                   	push   %ebp
  801b79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	ff 75 0c             	pushl  0xc(%ebp)
  801b84:	ff 75 08             	pushl  0x8(%ebp)
  801b87:	6a 0a                	push   $0xa
  801b89:	e8 99 fe ff ff       	call   801a27 <syscall>
  801b8e:	83 c4 18             	add    $0x18,%esp
}
  801b91:	c9                   	leave  
  801b92:	c3                   	ret    

00801b93 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b93:	55                   	push   %ebp
  801b94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 0b                	push   $0xb
  801ba2:	e8 80 fe ff ff       	call   801a27 <syscall>
  801ba7:	83 c4 18             	add    $0x18,%esp
}
  801baa:	c9                   	leave  
  801bab:	c3                   	ret    

00801bac <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801bac:	55                   	push   %ebp
  801bad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 0c                	push   $0xc
  801bbb:	e8 67 fe ff ff       	call   801a27 <syscall>
  801bc0:	83 c4 18             	add    $0x18,%esp
}
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 0d                	push   $0xd
  801bd4:	e8 4e fe ff ff       	call   801a27 <syscall>
  801bd9:	83 c4 18             	add    $0x18,%esp
}
  801bdc:	c9                   	leave  
  801bdd:	c3                   	ret    

00801bde <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801bde:	55                   	push   %ebp
  801bdf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	ff 75 0c             	pushl  0xc(%ebp)
  801bea:	ff 75 08             	pushl  0x8(%ebp)
  801bed:	6a 11                	push   $0x11
  801bef:	e8 33 fe ff ff       	call   801a27 <syscall>
  801bf4:	83 c4 18             	add    $0x18,%esp
	return;
  801bf7:	90                   	nop
}
  801bf8:	c9                   	leave  
  801bf9:	c3                   	ret    

00801bfa <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801bfa:	55                   	push   %ebp
  801bfb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	ff 75 0c             	pushl  0xc(%ebp)
  801c06:	ff 75 08             	pushl  0x8(%ebp)
  801c09:	6a 12                	push   $0x12
  801c0b:	e8 17 fe ff ff       	call   801a27 <syscall>
  801c10:	83 c4 18             	add    $0x18,%esp
	return ;
  801c13:	90                   	nop
}
  801c14:	c9                   	leave  
  801c15:	c3                   	ret    

00801c16 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c16:	55                   	push   %ebp
  801c17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 0e                	push   $0xe
  801c25:	e8 fd fd ff ff       	call   801a27 <syscall>
  801c2a:	83 c4 18             	add    $0x18,%esp
}
  801c2d:	c9                   	leave  
  801c2e:	c3                   	ret    

00801c2f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c2f:	55                   	push   %ebp
  801c30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	ff 75 08             	pushl  0x8(%ebp)
  801c3d:	6a 0f                	push   $0xf
  801c3f:	e8 e3 fd ff ff       	call   801a27 <syscall>
  801c44:	83 c4 18             	add    $0x18,%esp
}
  801c47:	c9                   	leave  
  801c48:	c3                   	ret    

00801c49 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c49:	55                   	push   %ebp
  801c4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 10                	push   $0x10
  801c58:	e8 ca fd ff ff       	call   801a27 <syscall>
  801c5d:	83 c4 18             	add    $0x18,%esp
}
  801c60:	90                   	nop
  801c61:	c9                   	leave  
  801c62:	c3                   	ret    

00801c63 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c63:	55                   	push   %ebp
  801c64:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 14                	push   $0x14
  801c72:	e8 b0 fd ff ff       	call   801a27 <syscall>
  801c77:	83 c4 18             	add    $0x18,%esp
}
  801c7a:	90                   	nop
  801c7b:	c9                   	leave  
  801c7c:	c3                   	ret    

00801c7d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c7d:	55                   	push   %ebp
  801c7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c80:	6a 00                	push   $0x0
  801c82:	6a 00                	push   $0x0
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 15                	push   $0x15
  801c8c:	e8 96 fd ff ff       	call   801a27 <syscall>
  801c91:	83 c4 18             	add    $0x18,%esp
}
  801c94:	90                   	nop
  801c95:	c9                   	leave  
  801c96:	c3                   	ret    

00801c97 <sys_cputc>:


void
sys_cputc(const char c)
{
  801c97:	55                   	push   %ebp
  801c98:	89 e5                	mov    %esp,%ebp
  801c9a:	83 ec 04             	sub    $0x4,%esp
  801c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ca3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	50                   	push   %eax
  801cb0:	6a 16                	push   $0x16
  801cb2:	e8 70 fd ff ff       	call   801a27 <syscall>
  801cb7:	83 c4 18             	add    $0x18,%esp
}
  801cba:	90                   	nop
  801cbb:	c9                   	leave  
  801cbc:	c3                   	ret    

00801cbd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cbd:	55                   	push   %ebp
  801cbe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 17                	push   $0x17
  801ccc:	e8 56 fd ff ff       	call   801a27 <syscall>
  801cd1:	83 c4 18             	add    $0x18,%esp
}
  801cd4:	90                   	nop
  801cd5:	c9                   	leave  
  801cd6:	c3                   	ret    

00801cd7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cd7:	55                   	push   %ebp
  801cd8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801cda:	8b 45 08             	mov    0x8(%ebp),%eax
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	ff 75 0c             	pushl  0xc(%ebp)
  801ce6:	50                   	push   %eax
  801ce7:	6a 18                	push   $0x18
  801ce9:	e8 39 fd ff ff       	call   801a27 <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
}
  801cf1:	c9                   	leave  
  801cf2:	c3                   	ret    

00801cf3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801cf3:	55                   	push   %ebp
  801cf4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cf6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	52                   	push   %edx
  801d03:	50                   	push   %eax
  801d04:	6a 1b                	push   $0x1b
  801d06:	e8 1c fd ff ff       	call   801a27 <syscall>
  801d0b:	83 c4 18             	add    $0x18,%esp
}
  801d0e:	c9                   	leave  
  801d0f:	c3                   	ret    

00801d10 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d10:	55                   	push   %ebp
  801d11:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d16:	8b 45 08             	mov    0x8(%ebp),%eax
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	52                   	push   %edx
  801d20:	50                   	push   %eax
  801d21:	6a 19                	push   $0x19
  801d23:	e8 ff fc ff ff       	call   801a27 <syscall>
  801d28:	83 c4 18             	add    $0x18,%esp
}
  801d2b:	90                   	nop
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d34:	8b 45 08             	mov    0x8(%ebp),%eax
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	52                   	push   %edx
  801d3e:	50                   	push   %eax
  801d3f:	6a 1a                	push   $0x1a
  801d41:	e8 e1 fc ff ff       	call   801a27 <syscall>
  801d46:	83 c4 18             	add    $0x18,%esp
}
  801d49:	90                   	nop
  801d4a:	c9                   	leave  
  801d4b:	c3                   	ret    

00801d4c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d4c:	55                   	push   %ebp
  801d4d:	89 e5                	mov    %esp,%ebp
  801d4f:	83 ec 04             	sub    $0x4,%esp
  801d52:	8b 45 10             	mov    0x10(%ebp),%eax
  801d55:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d58:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d5b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d62:	6a 00                	push   $0x0
  801d64:	51                   	push   %ecx
  801d65:	52                   	push   %edx
  801d66:	ff 75 0c             	pushl  0xc(%ebp)
  801d69:	50                   	push   %eax
  801d6a:	6a 1c                	push   $0x1c
  801d6c:	e8 b6 fc ff ff       	call   801a27 <syscall>
  801d71:	83 c4 18             	add    $0x18,%esp
}
  801d74:	c9                   	leave  
  801d75:	c3                   	ret    

00801d76 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d76:	55                   	push   %ebp
  801d77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d79:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	52                   	push   %edx
  801d86:	50                   	push   %eax
  801d87:	6a 1d                	push   $0x1d
  801d89:	e8 99 fc ff ff       	call   801a27 <syscall>
  801d8e:	83 c4 18             	add    $0x18,%esp
}
  801d91:	c9                   	leave  
  801d92:	c3                   	ret    

00801d93 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d93:	55                   	push   %ebp
  801d94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d96:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d99:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	51                   	push   %ecx
  801da4:	52                   	push   %edx
  801da5:	50                   	push   %eax
  801da6:	6a 1e                	push   $0x1e
  801da8:	e8 7a fc ff ff       	call   801a27 <syscall>
  801dad:	83 c4 18             	add    $0x18,%esp
}
  801db0:	c9                   	leave  
  801db1:	c3                   	ret    

00801db2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801db2:	55                   	push   %ebp
  801db3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801db5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	52                   	push   %edx
  801dc2:	50                   	push   %eax
  801dc3:	6a 1f                	push   $0x1f
  801dc5:	e8 5d fc ff ff       	call   801a27 <syscall>
  801dca:	83 c4 18             	add    $0x18,%esp
}
  801dcd:	c9                   	leave  
  801dce:	c3                   	ret    

00801dcf <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801dcf:	55                   	push   %ebp
  801dd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 20                	push   $0x20
  801dde:	e8 44 fc ff ff       	call   801a27 <syscall>
  801de3:	83 c4 18             	add    $0x18,%esp
}
  801de6:	c9                   	leave  
  801de7:	c3                   	ret    

00801de8 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801deb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	ff 75 10             	pushl  0x10(%ebp)
  801df5:	ff 75 0c             	pushl  0xc(%ebp)
  801df8:	50                   	push   %eax
  801df9:	6a 21                	push   $0x21
  801dfb:	e8 27 fc ff ff       	call   801a27 <syscall>
  801e00:	83 c4 18             	add    $0x18,%esp
}
  801e03:	c9                   	leave  
  801e04:	c3                   	ret    

00801e05 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e05:	55                   	push   %ebp
  801e06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e08:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	50                   	push   %eax
  801e14:	6a 22                	push   $0x22
  801e16:	e8 0c fc ff ff       	call   801a27 <syscall>
  801e1b:	83 c4 18             	add    $0x18,%esp
}
  801e1e:	90                   	nop
  801e1f:	c9                   	leave  
  801e20:	c3                   	ret    

00801e21 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e21:	55                   	push   %ebp
  801e22:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e24:	8b 45 08             	mov    0x8(%ebp),%eax
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	50                   	push   %eax
  801e30:	6a 23                	push   $0x23
  801e32:	e8 f0 fb ff ff       	call   801a27 <syscall>
  801e37:	83 c4 18             	add    $0x18,%esp
}
  801e3a:	90                   	nop
  801e3b:	c9                   	leave  
  801e3c:	c3                   	ret    

00801e3d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e3d:	55                   	push   %ebp
  801e3e:	89 e5                	mov    %esp,%ebp
  801e40:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e43:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e46:	8d 50 04             	lea    0x4(%eax),%edx
  801e49:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	52                   	push   %edx
  801e53:	50                   	push   %eax
  801e54:	6a 24                	push   $0x24
  801e56:	e8 cc fb ff ff       	call   801a27 <syscall>
  801e5b:	83 c4 18             	add    $0x18,%esp
	return result;
  801e5e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e61:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e64:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e67:	89 01                	mov    %eax,(%ecx)
  801e69:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6f:	c9                   	leave  
  801e70:	c2 04 00             	ret    $0x4

00801e73 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e73:	55                   	push   %ebp
  801e74:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	ff 75 10             	pushl  0x10(%ebp)
  801e7d:	ff 75 0c             	pushl  0xc(%ebp)
  801e80:	ff 75 08             	pushl  0x8(%ebp)
  801e83:	6a 13                	push   $0x13
  801e85:	e8 9d fb ff ff       	call   801a27 <syscall>
  801e8a:	83 c4 18             	add    $0x18,%esp
	return ;
  801e8d:	90                   	nop
}
  801e8e:	c9                   	leave  
  801e8f:	c3                   	ret    

00801e90 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e90:	55                   	push   %ebp
  801e91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 25                	push   $0x25
  801e9f:	e8 83 fb ff ff       	call   801a27 <syscall>
  801ea4:	83 c4 18             	add    $0x18,%esp
}
  801ea7:	c9                   	leave  
  801ea8:	c3                   	ret    

00801ea9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ea9:	55                   	push   %ebp
  801eaa:	89 e5                	mov    %esp,%ebp
  801eac:	83 ec 04             	sub    $0x4,%esp
  801eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801eb5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 00                	push   $0x0
  801ec1:	50                   	push   %eax
  801ec2:	6a 26                	push   $0x26
  801ec4:	e8 5e fb ff ff       	call   801a27 <syscall>
  801ec9:	83 c4 18             	add    $0x18,%esp
	return ;
  801ecc:	90                   	nop
}
  801ecd:	c9                   	leave  
  801ece:	c3                   	ret    

00801ecf <rsttst>:
void rsttst()
{
  801ecf:	55                   	push   %ebp
  801ed0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 00                	push   $0x0
  801edc:	6a 28                	push   $0x28
  801ede:	e8 44 fb ff ff       	call   801a27 <syscall>
  801ee3:	83 c4 18             	add    $0x18,%esp
	return ;
  801ee6:	90                   	nop
}
  801ee7:	c9                   	leave  
  801ee8:	c3                   	ret    

00801ee9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ee9:	55                   	push   %ebp
  801eea:	89 e5                	mov    %esp,%ebp
  801eec:	83 ec 04             	sub    $0x4,%esp
  801eef:	8b 45 14             	mov    0x14(%ebp),%eax
  801ef2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ef5:	8b 55 18             	mov    0x18(%ebp),%edx
  801ef8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801efc:	52                   	push   %edx
  801efd:	50                   	push   %eax
  801efe:	ff 75 10             	pushl  0x10(%ebp)
  801f01:	ff 75 0c             	pushl  0xc(%ebp)
  801f04:	ff 75 08             	pushl  0x8(%ebp)
  801f07:	6a 27                	push   $0x27
  801f09:	e8 19 fb ff ff       	call   801a27 <syscall>
  801f0e:	83 c4 18             	add    $0x18,%esp
	return ;
  801f11:	90                   	nop
}
  801f12:	c9                   	leave  
  801f13:	c3                   	ret    

00801f14 <chktst>:
void chktst(uint32 n)
{
  801f14:	55                   	push   %ebp
  801f15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	ff 75 08             	pushl  0x8(%ebp)
  801f22:	6a 29                	push   $0x29
  801f24:	e8 fe fa ff ff       	call   801a27 <syscall>
  801f29:	83 c4 18             	add    $0x18,%esp
	return ;
  801f2c:	90                   	nop
}
  801f2d:	c9                   	leave  
  801f2e:	c3                   	ret    

00801f2f <inctst>:

void inctst()
{
  801f2f:	55                   	push   %ebp
  801f30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 2a                	push   $0x2a
  801f3e:	e8 e4 fa ff ff       	call   801a27 <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
	return ;
  801f46:	90                   	nop
}
  801f47:	c9                   	leave  
  801f48:	c3                   	ret    

00801f49 <gettst>:
uint32 gettst()
{
  801f49:	55                   	push   %ebp
  801f4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 2b                	push   $0x2b
  801f58:	e8 ca fa ff ff       	call   801a27 <syscall>
  801f5d:	83 c4 18             	add    $0x18,%esp
}
  801f60:	c9                   	leave  
  801f61:	c3                   	ret    

00801f62 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f62:	55                   	push   %ebp
  801f63:	89 e5                	mov    %esp,%ebp
  801f65:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 00                	push   $0x0
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 2c                	push   $0x2c
  801f74:	e8 ae fa ff ff       	call   801a27 <syscall>
  801f79:	83 c4 18             	add    $0x18,%esp
  801f7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f7f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f83:	75 07                	jne    801f8c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f85:	b8 01 00 00 00       	mov    $0x1,%eax
  801f8a:	eb 05                	jmp    801f91 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f8c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f91:	c9                   	leave  
  801f92:	c3                   	ret    

00801f93 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f93:	55                   	push   %ebp
  801f94:	89 e5                	mov    %esp,%ebp
  801f96:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 2c                	push   $0x2c
  801fa5:	e8 7d fa ff ff       	call   801a27 <syscall>
  801faa:	83 c4 18             	add    $0x18,%esp
  801fad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801fb0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801fb4:	75 07                	jne    801fbd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801fb6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fbb:	eb 05                	jmp    801fc2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801fbd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801fc4:	55                   	push   %ebp
  801fc5:	89 e5                	mov    %esp,%ebp
  801fc7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 2c                	push   $0x2c
  801fd6:	e8 4c fa ff ff       	call   801a27 <syscall>
  801fdb:	83 c4 18             	add    $0x18,%esp
  801fde:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801fe1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801fe5:	75 07                	jne    801fee <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801fe7:	b8 01 00 00 00       	mov    $0x1,%eax
  801fec:	eb 05                	jmp    801ff3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801fee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ff3:	c9                   	leave  
  801ff4:	c3                   	ret    

00801ff5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ff5:	55                   	push   %ebp
  801ff6:	89 e5                	mov    %esp,%ebp
  801ff8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 2c                	push   $0x2c
  802007:	e8 1b fa ff ff       	call   801a27 <syscall>
  80200c:	83 c4 18             	add    $0x18,%esp
  80200f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802012:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802016:	75 07                	jne    80201f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802018:	b8 01 00 00 00       	mov    $0x1,%eax
  80201d:	eb 05                	jmp    802024 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80201f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802024:	c9                   	leave  
  802025:	c3                   	ret    

00802026 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802026:	55                   	push   %ebp
  802027:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	ff 75 08             	pushl  0x8(%ebp)
  802034:	6a 2d                	push   $0x2d
  802036:	e8 ec f9 ff ff       	call   801a27 <syscall>
  80203b:	83 c4 18             	add    $0x18,%esp
	return ;
  80203e:	90                   	nop
}
  80203f:	c9                   	leave  
  802040:	c3                   	ret    
  802041:	66 90                	xchg   %ax,%ax
  802043:	90                   	nop

00802044 <__udivdi3>:
  802044:	55                   	push   %ebp
  802045:	57                   	push   %edi
  802046:	56                   	push   %esi
  802047:	53                   	push   %ebx
  802048:	83 ec 1c             	sub    $0x1c,%esp
  80204b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80204f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802053:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802057:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80205b:	89 ca                	mov    %ecx,%edx
  80205d:	89 f8                	mov    %edi,%eax
  80205f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802063:	85 f6                	test   %esi,%esi
  802065:	75 2d                	jne    802094 <__udivdi3+0x50>
  802067:	39 cf                	cmp    %ecx,%edi
  802069:	77 65                	ja     8020d0 <__udivdi3+0x8c>
  80206b:	89 fd                	mov    %edi,%ebp
  80206d:	85 ff                	test   %edi,%edi
  80206f:	75 0b                	jne    80207c <__udivdi3+0x38>
  802071:	b8 01 00 00 00       	mov    $0x1,%eax
  802076:	31 d2                	xor    %edx,%edx
  802078:	f7 f7                	div    %edi
  80207a:	89 c5                	mov    %eax,%ebp
  80207c:	31 d2                	xor    %edx,%edx
  80207e:	89 c8                	mov    %ecx,%eax
  802080:	f7 f5                	div    %ebp
  802082:	89 c1                	mov    %eax,%ecx
  802084:	89 d8                	mov    %ebx,%eax
  802086:	f7 f5                	div    %ebp
  802088:	89 cf                	mov    %ecx,%edi
  80208a:	89 fa                	mov    %edi,%edx
  80208c:	83 c4 1c             	add    $0x1c,%esp
  80208f:	5b                   	pop    %ebx
  802090:	5e                   	pop    %esi
  802091:	5f                   	pop    %edi
  802092:	5d                   	pop    %ebp
  802093:	c3                   	ret    
  802094:	39 ce                	cmp    %ecx,%esi
  802096:	77 28                	ja     8020c0 <__udivdi3+0x7c>
  802098:	0f bd fe             	bsr    %esi,%edi
  80209b:	83 f7 1f             	xor    $0x1f,%edi
  80209e:	75 40                	jne    8020e0 <__udivdi3+0x9c>
  8020a0:	39 ce                	cmp    %ecx,%esi
  8020a2:	72 0a                	jb     8020ae <__udivdi3+0x6a>
  8020a4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020a8:	0f 87 9e 00 00 00    	ja     80214c <__udivdi3+0x108>
  8020ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8020b3:	89 fa                	mov    %edi,%edx
  8020b5:	83 c4 1c             	add    $0x1c,%esp
  8020b8:	5b                   	pop    %ebx
  8020b9:	5e                   	pop    %esi
  8020ba:	5f                   	pop    %edi
  8020bb:	5d                   	pop    %ebp
  8020bc:	c3                   	ret    
  8020bd:	8d 76 00             	lea    0x0(%esi),%esi
  8020c0:	31 ff                	xor    %edi,%edi
  8020c2:	31 c0                	xor    %eax,%eax
  8020c4:	89 fa                	mov    %edi,%edx
  8020c6:	83 c4 1c             	add    $0x1c,%esp
  8020c9:	5b                   	pop    %ebx
  8020ca:	5e                   	pop    %esi
  8020cb:	5f                   	pop    %edi
  8020cc:	5d                   	pop    %ebp
  8020cd:	c3                   	ret    
  8020ce:	66 90                	xchg   %ax,%ax
  8020d0:	89 d8                	mov    %ebx,%eax
  8020d2:	f7 f7                	div    %edi
  8020d4:	31 ff                	xor    %edi,%edi
  8020d6:	89 fa                	mov    %edi,%edx
  8020d8:	83 c4 1c             	add    $0x1c,%esp
  8020db:	5b                   	pop    %ebx
  8020dc:	5e                   	pop    %esi
  8020dd:	5f                   	pop    %edi
  8020de:	5d                   	pop    %ebp
  8020df:	c3                   	ret    
  8020e0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020e5:	89 eb                	mov    %ebp,%ebx
  8020e7:	29 fb                	sub    %edi,%ebx
  8020e9:	89 f9                	mov    %edi,%ecx
  8020eb:	d3 e6                	shl    %cl,%esi
  8020ed:	89 c5                	mov    %eax,%ebp
  8020ef:	88 d9                	mov    %bl,%cl
  8020f1:	d3 ed                	shr    %cl,%ebp
  8020f3:	89 e9                	mov    %ebp,%ecx
  8020f5:	09 f1                	or     %esi,%ecx
  8020f7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020fb:	89 f9                	mov    %edi,%ecx
  8020fd:	d3 e0                	shl    %cl,%eax
  8020ff:	89 c5                	mov    %eax,%ebp
  802101:	89 d6                	mov    %edx,%esi
  802103:	88 d9                	mov    %bl,%cl
  802105:	d3 ee                	shr    %cl,%esi
  802107:	89 f9                	mov    %edi,%ecx
  802109:	d3 e2                	shl    %cl,%edx
  80210b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80210f:	88 d9                	mov    %bl,%cl
  802111:	d3 e8                	shr    %cl,%eax
  802113:	09 c2                	or     %eax,%edx
  802115:	89 d0                	mov    %edx,%eax
  802117:	89 f2                	mov    %esi,%edx
  802119:	f7 74 24 0c          	divl   0xc(%esp)
  80211d:	89 d6                	mov    %edx,%esi
  80211f:	89 c3                	mov    %eax,%ebx
  802121:	f7 e5                	mul    %ebp
  802123:	39 d6                	cmp    %edx,%esi
  802125:	72 19                	jb     802140 <__udivdi3+0xfc>
  802127:	74 0b                	je     802134 <__udivdi3+0xf0>
  802129:	89 d8                	mov    %ebx,%eax
  80212b:	31 ff                	xor    %edi,%edi
  80212d:	e9 58 ff ff ff       	jmp    80208a <__udivdi3+0x46>
  802132:	66 90                	xchg   %ax,%ax
  802134:	8b 54 24 08          	mov    0x8(%esp),%edx
  802138:	89 f9                	mov    %edi,%ecx
  80213a:	d3 e2                	shl    %cl,%edx
  80213c:	39 c2                	cmp    %eax,%edx
  80213e:	73 e9                	jae    802129 <__udivdi3+0xe5>
  802140:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802143:	31 ff                	xor    %edi,%edi
  802145:	e9 40 ff ff ff       	jmp    80208a <__udivdi3+0x46>
  80214a:	66 90                	xchg   %ax,%ax
  80214c:	31 c0                	xor    %eax,%eax
  80214e:	e9 37 ff ff ff       	jmp    80208a <__udivdi3+0x46>
  802153:	90                   	nop

00802154 <__umoddi3>:
  802154:	55                   	push   %ebp
  802155:	57                   	push   %edi
  802156:	56                   	push   %esi
  802157:	53                   	push   %ebx
  802158:	83 ec 1c             	sub    $0x1c,%esp
  80215b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80215f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802163:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802167:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80216b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80216f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802173:	89 f3                	mov    %esi,%ebx
  802175:	89 fa                	mov    %edi,%edx
  802177:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80217b:	89 34 24             	mov    %esi,(%esp)
  80217e:	85 c0                	test   %eax,%eax
  802180:	75 1a                	jne    80219c <__umoddi3+0x48>
  802182:	39 f7                	cmp    %esi,%edi
  802184:	0f 86 a2 00 00 00    	jbe    80222c <__umoddi3+0xd8>
  80218a:	89 c8                	mov    %ecx,%eax
  80218c:	89 f2                	mov    %esi,%edx
  80218e:	f7 f7                	div    %edi
  802190:	89 d0                	mov    %edx,%eax
  802192:	31 d2                	xor    %edx,%edx
  802194:	83 c4 1c             	add    $0x1c,%esp
  802197:	5b                   	pop    %ebx
  802198:	5e                   	pop    %esi
  802199:	5f                   	pop    %edi
  80219a:	5d                   	pop    %ebp
  80219b:	c3                   	ret    
  80219c:	39 f0                	cmp    %esi,%eax
  80219e:	0f 87 ac 00 00 00    	ja     802250 <__umoddi3+0xfc>
  8021a4:	0f bd e8             	bsr    %eax,%ebp
  8021a7:	83 f5 1f             	xor    $0x1f,%ebp
  8021aa:	0f 84 ac 00 00 00    	je     80225c <__umoddi3+0x108>
  8021b0:	bf 20 00 00 00       	mov    $0x20,%edi
  8021b5:	29 ef                	sub    %ebp,%edi
  8021b7:	89 fe                	mov    %edi,%esi
  8021b9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021bd:	89 e9                	mov    %ebp,%ecx
  8021bf:	d3 e0                	shl    %cl,%eax
  8021c1:	89 d7                	mov    %edx,%edi
  8021c3:	89 f1                	mov    %esi,%ecx
  8021c5:	d3 ef                	shr    %cl,%edi
  8021c7:	09 c7                	or     %eax,%edi
  8021c9:	89 e9                	mov    %ebp,%ecx
  8021cb:	d3 e2                	shl    %cl,%edx
  8021cd:	89 14 24             	mov    %edx,(%esp)
  8021d0:	89 d8                	mov    %ebx,%eax
  8021d2:	d3 e0                	shl    %cl,%eax
  8021d4:	89 c2                	mov    %eax,%edx
  8021d6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021da:	d3 e0                	shl    %cl,%eax
  8021dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021e0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021e4:	89 f1                	mov    %esi,%ecx
  8021e6:	d3 e8                	shr    %cl,%eax
  8021e8:	09 d0                	or     %edx,%eax
  8021ea:	d3 eb                	shr    %cl,%ebx
  8021ec:	89 da                	mov    %ebx,%edx
  8021ee:	f7 f7                	div    %edi
  8021f0:	89 d3                	mov    %edx,%ebx
  8021f2:	f7 24 24             	mull   (%esp)
  8021f5:	89 c6                	mov    %eax,%esi
  8021f7:	89 d1                	mov    %edx,%ecx
  8021f9:	39 d3                	cmp    %edx,%ebx
  8021fb:	0f 82 87 00 00 00    	jb     802288 <__umoddi3+0x134>
  802201:	0f 84 91 00 00 00    	je     802298 <__umoddi3+0x144>
  802207:	8b 54 24 04          	mov    0x4(%esp),%edx
  80220b:	29 f2                	sub    %esi,%edx
  80220d:	19 cb                	sbb    %ecx,%ebx
  80220f:	89 d8                	mov    %ebx,%eax
  802211:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802215:	d3 e0                	shl    %cl,%eax
  802217:	89 e9                	mov    %ebp,%ecx
  802219:	d3 ea                	shr    %cl,%edx
  80221b:	09 d0                	or     %edx,%eax
  80221d:	89 e9                	mov    %ebp,%ecx
  80221f:	d3 eb                	shr    %cl,%ebx
  802221:	89 da                	mov    %ebx,%edx
  802223:	83 c4 1c             	add    $0x1c,%esp
  802226:	5b                   	pop    %ebx
  802227:	5e                   	pop    %esi
  802228:	5f                   	pop    %edi
  802229:	5d                   	pop    %ebp
  80222a:	c3                   	ret    
  80222b:	90                   	nop
  80222c:	89 fd                	mov    %edi,%ebp
  80222e:	85 ff                	test   %edi,%edi
  802230:	75 0b                	jne    80223d <__umoddi3+0xe9>
  802232:	b8 01 00 00 00       	mov    $0x1,%eax
  802237:	31 d2                	xor    %edx,%edx
  802239:	f7 f7                	div    %edi
  80223b:	89 c5                	mov    %eax,%ebp
  80223d:	89 f0                	mov    %esi,%eax
  80223f:	31 d2                	xor    %edx,%edx
  802241:	f7 f5                	div    %ebp
  802243:	89 c8                	mov    %ecx,%eax
  802245:	f7 f5                	div    %ebp
  802247:	89 d0                	mov    %edx,%eax
  802249:	e9 44 ff ff ff       	jmp    802192 <__umoddi3+0x3e>
  80224e:	66 90                	xchg   %ax,%ax
  802250:	89 c8                	mov    %ecx,%eax
  802252:	89 f2                	mov    %esi,%edx
  802254:	83 c4 1c             	add    $0x1c,%esp
  802257:	5b                   	pop    %ebx
  802258:	5e                   	pop    %esi
  802259:	5f                   	pop    %edi
  80225a:	5d                   	pop    %ebp
  80225b:	c3                   	ret    
  80225c:	3b 04 24             	cmp    (%esp),%eax
  80225f:	72 06                	jb     802267 <__umoddi3+0x113>
  802261:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802265:	77 0f                	ja     802276 <__umoddi3+0x122>
  802267:	89 f2                	mov    %esi,%edx
  802269:	29 f9                	sub    %edi,%ecx
  80226b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80226f:	89 14 24             	mov    %edx,(%esp)
  802272:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802276:	8b 44 24 04          	mov    0x4(%esp),%eax
  80227a:	8b 14 24             	mov    (%esp),%edx
  80227d:	83 c4 1c             	add    $0x1c,%esp
  802280:	5b                   	pop    %ebx
  802281:	5e                   	pop    %esi
  802282:	5f                   	pop    %edi
  802283:	5d                   	pop    %ebp
  802284:	c3                   	ret    
  802285:	8d 76 00             	lea    0x0(%esi),%esi
  802288:	2b 04 24             	sub    (%esp),%eax
  80228b:	19 fa                	sbb    %edi,%edx
  80228d:	89 d1                	mov    %edx,%ecx
  80228f:	89 c6                	mov    %eax,%esi
  802291:	e9 71 ff ff ff       	jmp    802207 <__umoddi3+0xb3>
  802296:	66 90                	xchg   %ax,%ax
  802298:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80229c:	72 ea                	jb     802288 <__umoddi3+0x134>
  80229e:	89 d9                	mov    %ebx,%ecx
  8022a0:	e9 62 ff ff ff       	jmp    802207 <__umoddi3+0xb3>