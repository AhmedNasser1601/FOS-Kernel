
obj/user/quicksort_heap:     file format elf32-i386


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
  800031:	e8 1f 06 00 00       	call   800655 <libmain>
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
  800041:	e8 40 1c 00 00       	call   801c86 <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 e0 22 80 00       	push   $0x8022e0
  80004e:	e8 c5 09 00 00       	call   800a18 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 e2 22 80 00       	push   $0x8022e2
  80005e:	e8 b5 09 00 00       	call   800a18 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT   !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 fb 22 80 00       	push   $0x8022fb
  80006e:	e8 a5 09 00 00       	call   800a18 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 e2 22 80 00       	push   $0x8022e2
  80007e:	e8 95 09 00 00       	call   800a18 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 e0 22 80 00       	push   $0x8022e0
  80008e:	e8 85 09 00 00       	call   800a18 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 14 23 80 00       	push   $0x802314
  8000a5:	e8 f0 0f 00 00       	call   80109a <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 40 15 00 00       	call   801600 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 d3 18 00 00       	call   8019a8 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 34 23 80 00       	push   $0x802334
  8000e3:	e8 30 09 00 00       	call   800a18 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 56 23 80 00       	push   $0x802356
  8000f3:	e8 20 09 00 00       	call   800a18 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 64 23 80 00       	push   $0x802364
  800103:	e8 10 09 00 00       	call   800a18 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 73 23 80 00       	push   $0x802373
  800113:	e8 00 09 00 00       	call   800a18 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 83 23 80 00       	push   $0x802383
  800123:	e8 f0 08 00 00       	call   800a18 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 cd 04 00 00       	call   8005fd <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 75 04 00 00       	call   8005b5 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 68 04 00 00       	call   8005b5 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>
		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 39 1b 00 00       	call   801ca0 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 f5 02 00 00       	call   80047d <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 13 03 00 00       	call   8004ae <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 35 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 22 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	e8 f0 00 00 00       	call   8002c2 <QuickSort>
  8001d2:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d5:	e8 ac 1a 00 00       	call   801c86 <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 8c 23 80 00       	push   $0x80238c
  8001e2:	e8 31 08 00 00       	call   800a18 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ea:	e8 b1 1a 00 00       	call   801ca0 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f8:	e8 d6 01 00 00       	call   8003d3 <CheckSorted>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800203:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 c0 23 80 00       	push   $0x8023c0
  800211:	6a 48                	push   $0x48
  800213:	68 e2 23 80 00       	push   $0x8023e2
  800218:	e8 47 05 00 00       	call   800764 <_panic>
		else
		{
			sys_disable_interrupt();
  80021d:	e8 64 1a 00 00       	call   801c86 <sys_disable_interrupt>
			cprintf("\n===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 f8 23 80 00       	push   $0x8023f8
  80022a:	e8 e9 07 00 00       	call   800a18 <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 2c 24 80 00       	push   $0x80242c
  80023a:	e8 d9 07 00 00       	call   800a18 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 60 24 80 00       	push   $0x802460
  80024a:	e8 c9 07 00 00       	call   800a18 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800252:	e8 49 1a 00 00       	call   801ca0 <sys_enable_interrupt>
		}

		sys_disable_interrupt();
  800257:	e8 2a 1a 00 00       	call   801c86 <sys_disable_interrupt>
			Chose = 0 ;
  80025c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800260:	eb 42                	jmp    8002a4 <_main+0x26c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800262:	83 ec 0c             	sub    $0xc,%esp
  800265:	68 92 24 80 00       	push   $0x802492
  80026a:	e8 a9 07 00 00       	call   800a18 <cprintf>
  80026f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800272:	e8 86 03 00 00       	call   8005fd <getchar>
  800277:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80027a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80027e:	83 ec 0c             	sub    $0xc,%esp
  800281:	50                   	push   %eax
  800282:	e8 2e 03 00 00       	call   8005b5 <cputchar>
  800287:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028a:	83 ec 0c             	sub    $0xc,%esp
  80028d:	6a 0a                	push   $0xa
  80028f:	e8 21 03 00 00       	call   8005b5 <cputchar>
  800294:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800297:	83 ec 0c             	sub    $0xc,%esp
  80029a:	6a 0a                	push   $0xa
  80029c:	e8 14 03 00 00       	call   8005b5 <cputchar>
  8002a1:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
		}

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002a8:	74 06                	je     8002b0 <_main+0x278>
  8002aa:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002ae:	75 b2                	jne    800262 <_main+0x22a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b0:	e8 eb 19 00 00       	call   801ca0 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b9:	0f 84 82 fd ff ff    	je     800041 <_main+0x9>

}
  8002bf:	90                   	nop
  8002c0:	c9                   	leave  
  8002c1:	c3                   	ret    

008002c2 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002c2:	55                   	push   %ebp
  8002c3:	89 e5                	mov    %esp,%ebp
  8002c5:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002cb:	48                   	dec    %eax
  8002cc:	50                   	push   %eax
  8002cd:	6a 00                	push   $0x0
  8002cf:	ff 75 0c             	pushl  0xc(%ebp)
  8002d2:	ff 75 08             	pushl  0x8(%ebp)
  8002d5:	e8 06 00 00 00       	call   8002e0 <QSort>
  8002da:	83 c4 10             	add    $0x10,%esp
}
  8002dd:	90                   	nop
  8002de:	c9                   	leave  
  8002df:	c3                   	ret    

008002e0 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002e0:	55                   	push   %ebp
  8002e1:	89 e5                	mov    %esp,%ebp
  8002e3:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e9:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002ec:	0f 8d de 00 00 00    	jge    8003d0 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f5:	40                   	inc    %eax
  8002f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8002fc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002ff:	e9 80 00 00 00       	jmp    800384 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800304:	ff 45 f4             	incl   -0xc(%ebp)
  800307:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80030a:	3b 45 14             	cmp    0x14(%ebp),%eax
  80030d:	7f 2b                	jg     80033a <QSort+0x5a>
  80030f:	8b 45 10             	mov    0x10(%ebp),%eax
  800312:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 d0                	add    %edx,%eax
  80031e:	8b 10                	mov    (%eax),%edx
  800320:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800323:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80032a:	8b 45 08             	mov    0x8(%ebp),%eax
  80032d:	01 c8                	add    %ecx,%eax
  80032f:	8b 00                	mov    (%eax),%eax
  800331:	39 c2                	cmp    %eax,%edx
  800333:	7d cf                	jge    800304 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800335:	eb 03                	jmp    80033a <QSort+0x5a>
  800337:	ff 4d f0             	decl   -0x10(%ebp)
  80033a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800340:	7e 26                	jle    800368 <QSort+0x88>
  800342:	8b 45 10             	mov    0x10(%ebp),%eax
  800345:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 d0                	add    %edx,%eax
  800351:	8b 10                	mov    (%eax),%edx
  800353:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800356:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035d:	8b 45 08             	mov    0x8(%ebp),%eax
  800360:	01 c8                	add    %ecx,%eax
  800362:	8b 00                	mov    (%eax),%eax
  800364:	39 c2                	cmp    %eax,%edx
  800366:	7e cf                	jle    800337 <QSort+0x57>

		if (i <= j)
  800368:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80036e:	7f 14                	jg     800384 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800370:	83 ec 04             	sub    $0x4,%esp
  800373:	ff 75 f0             	pushl  -0x10(%ebp)
  800376:	ff 75 f4             	pushl  -0xc(%ebp)
  800379:	ff 75 08             	pushl  0x8(%ebp)
  80037c:	e8 a9 00 00 00       	call   80042a <Swap>
  800381:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800384:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800387:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80038a:	0f 8e 77 ff ff ff    	jle    800307 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800390:	83 ec 04             	sub    $0x4,%esp
  800393:	ff 75 f0             	pushl  -0x10(%ebp)
  800396:	ff 75 10             	pushl  0x10(%ebp)
  800399:	ff 75 08             	pushl  0x8(%ebp)
  80039c:	e8 89 00 00 00       	call   80042a <Swap>
  8003a1:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a7:	48                   	dec    %eax
  8003a8:	50                   	push   %eax
  8003a9:	ff 75 10             	pushl  0x10(%ebp)
  8003ac:	ff 75 0c             	pushl  0xc(%ebp)
  8003af:	ff 75 08             	pushl  0x8(%ebp)
  8003b2:	e8 29 ff ff ff       	call   8002e0 <QSort>
  8003b7:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003ba:	ff 75 14             	pushl  0x14(%ebp)
  8003bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c0:	ff 75 0c             	pushl  0xc(%ebp)
  8003c3:	ff 75 08             	pushl  0x8(%ebp)
  8003c6:	e8 15 ff ff ff       	call   8002e0 <QSort>
  8003cb:	83 c4 10             	add    $0x10,%esp
  8003ce:	eb 01                	jmp    8003d1 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003d0:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003d1:	c9                   	leave  
  8003d2:	c3                   	ret    

008003d3 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003d3:	55                   	push   %ebp
  8003d4:	89 e5                	mov    %esp,%ebp
  8003d6:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003d9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003e7:	eb 33                	jmp    80041c <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f6:	01 d0                	add    %edx,%eax
  8003f8:	8b 10                	mov    (%eax),%edx
  8003fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003fd:	40                   	inc    %eax
  8003fe:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	01 c8                	add    %ecx,%eax
  80040a:	8b 00                	mov    (%eax),%eax
  80040c:	39 c2                	cmp    %eax,%edx
  80040e:	7e 09                	jle    800419 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800417:	eb 0c                	jmp    800425 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800419:	ff 45 f8             	incl   -0x8(%ebp)
  80041c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041f:	48                   	dec    %eax
  800420:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800423:	7f c4                	jg     8003e9 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800425:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800428:	c9                   	leave  
  800429:	c3                   	ret    

0080042a <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80042a:	55                   	push   %ebp
  80042b:	89 e5                	mov    %esp,%ebp
  80042d:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800430:	8b 45 0c             	mov    0xc(%ebp),%eax
  800433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 d0                	add    %edx,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800444:	8b 45 0c             	mov    0xc(%ebp),%eax
  800447:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	01 c2                	add    %eax,%edx
  800453:	8b 45 10             	mov    0x10(%ebp),%eax
  800456:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 c8                	add    %ecx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800466:	8b 45 10             	mov    0x10(%ebp),%eax
  800469:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	01 c2                	add    %eax,%edx
  800475:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800478:	89 02                	mov    %eax,(%edx)
}
  80047a:	90                   	nop
  80047b:	c9                   	leave  
  80047c:	c3                   	ret    

0080047d <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80047d:	55                   	push   %ebp
  80047e:	89 e5                	mov    %esp,%ebp
  800480:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800483:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80048a:	eb 17                	jmp    8004a3 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80048c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800496:	8b 45 08             	mov    0x8(%ebp),%eax
  800499:	01 c2                	add    %eax,%edx
  80049b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049e:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a0:	ff 45 fc             	incl   -0x4(%ebp)
  8004a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004a9:	7c e1                	jl     80048c <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004ab:	90                   	nop
  8004ac:	c9                   	leave  
  8004ad:	c3                   	ret    

008004ae <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004ae:	55                   	push   %ebp
  8004af:	89 e5                	mov    %esp,%ebp
  8004b1:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004bb:	eb 1b                	jmp    8004d8 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ca:	01 c2                	add    %eax,%edx
  8004cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cf:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004d2:	48                   	dec    %eax
  8004d3:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d5:	ff 45 fc             	incl   -0x4(%ebp)
  8004d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004db:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004de:	7c dd                	jl     8004bd <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004e0:	90                   	nop
  8004e1:	c9                   	leave  
  8004e2:	c3                   	ret    

008004e3 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004e3:	55                   	push   %ebp
  8004e4:	89 e5                	mov    %esp,%ebp
  8004e6:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004ec:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004f1:	f7 e9                	imul   %ecx
  8004f3:	c1 f9 1f             	sar    $0x1f,%ecx
  8004f6:	89 d0                	mov    %edx,%eax
  8004f8:	29 c8                	sub    %ecx,%eax
  8004fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800504:	eb 1e                	jmp    800524 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800506:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800509:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800516:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800519:	99                   	cltd   
  80051a:	f7 7d f8             	idivl  -0x8(%ebp)
  80051d:	89 d0                	mov    %edx,%eax
  80051f:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800521:	ff 45 fc             	incl   -0x4(%ebp)
  800524:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800527:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80052a:	7c da                	jl     800506 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80052c:	90                   	nop
  80052d:	c9                   	leave  
  80052e:	c3                   	ret    

0080052f <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80052f:	55                   	push   %ebp
  800530:	89 e5                	mov    %esp,%ebp
  800532:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800535:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80053c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800543:	eb 42                	jmp    800587 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800545:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800548:	99                   	cltd   
  800549:	f7 7d f0             	idivl  -0x10(%ebp)
  80054c:	89 d0                	mov    %edx,%eax
  80054e:	85 c0                	test   %eax,%eax
  800550:	75 10                	jne    800562 <PrintElements+0x33>
			cprintf("\n");
  800552:	83 ec 0c             	sub    $0xc,%esp
  800555:	68 e0 22 80 00       	push   $0x8022e0
  80055a:	e8 b9 04 00 00       	call   800a18 <cprintf>
  80055f:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800562:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800565:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056c:	8b 45 08             	mov    0x8(%ebp),%eax
  80056f:	01 d0                	add    %edx,%eax
  800571:	8b 00                	mov    (%eax),%eax
  800573:	83 ec 08             	sub    $0x8,%esp
  800576:	50                   	push   %eax
  800577:	68 b0 24 80 00       	push   $0x8024b0
  80057c:	e8 97 04 00 00       	call   800a18 <cprintf>
  800581:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800584:	ff 45 f4             	incl   -0xc(%ebp)
  800587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058a:	48                   	dec    %eax
  80058b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80058e:	7f b5                	jg     800545 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800590:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800593:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059a:	8b 45 08             	mov    0x8(%ebp),%eax
  80059d:	01 d0                	add    %edx,%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	83 ec 08             	sub    $0x8,%esp
  8005a4:	50                   	push   %eax
  8005a5:	68 b5 24 80 00       	push   $0x8024b5
  8005aa:	e8 69 04 00 00       	call   800a18 <cprintf>
  8005af:	83 c4 10             	add    $0x10,%esp

}
  8005b2:	90                   	nop
  8005b3:	c9                   	leave  
  8005b4:	c3                   	ret    

008005b5 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005b5:	55                   	push   %ebp
  8005b6:	89 e5                	mov    %esp,%ebp
  8005b8:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005c1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005c5:	83 ec 0c             	sub    $0xc,%esp
  8005c8:	50                   	push   %eax
  8005c9:	e8 ec 16 00 00       	call   801cba <sys_cputc>
  8005ce:	83 c4 10             	add    $0x10,%esp
}
  8005d1:	90                   	nop
  8005d2:	c9                   	leave  
  8005d3:	c3                   	ret    

008005d4 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005d4:	55                   	push   %ebp
  8005d5:	89 e5                	mov    %esp,%ebp
  8005d7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005da:	e8 a7 16 00 00       	call   801c86 <sys_disable_interrupt>
	char c = ch;
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005e5:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005e9:	83 ec 0c             	sub    $0xc,%esp
  8005ec:	50                   	push   %eax
  8005ed:	e8 c8 16 00 00       	call   801cba <sys_cputc>
  8005f2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005f5:	e8 a6 16 00 00       	call   801ca0 <sys_enable_interrupt>
}
  8005fa:	90                   	nop
  8005fb:	c9                   	leave  
  8005fc:	c3                   	ret    

008005fd <getchar>:

int
getchar(void)
{
  8005fd:	55                   	push   %ebp
  8005fe:	89 e5                	mov    %esp,%ebp
  800600:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800603:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80060a:	eb 08                	jmp    800614 <getchar+0x17>
	{
		c = sys_cgetc();
  80060c:	e8 8d 14 00 00       	call   801a9e <sys_cgetc>
  800611:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800614:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800618:	74 f2                	je     80060c <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80061a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80061d:	c9                   	leave  
  80061e:	c3                   	ret    

0080061f <atomic_getchar>:

int
atomic_getchar(void)
{
  80061f:	55                   	push   %ebp
  800620:	89 e5                	mov    %esp,%ebp
  800622:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800625:	e8 5c 16 00 00       	call   801c86 <sys_disable_interrupt>
	int c=0;
  80062a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800631:	eb 08                	jmp    80063b <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800633:	e8 66 14 00 00       	call   801a9e <sys_cgetc>
  800638:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80063b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80063f:	74 f2                	je     800633 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800641:	e8 5a 16 00 00       	call   801ca0 <sys_enable_interrupt>
	return c;
  800646:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800649:	c9                   	leave  
  80064a:	c3                   	ret    

0080064b <iscons>:

int iscons(int fdnum)
{
  80064b:	55                   	push   %ebp
  80064c:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80064e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800653:	5d                   	pop    %ebp
  800654:	c3                   	ret    

00800655 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800655:	55                   	push   %ebp
  800656:	89 e5                	mov    %esp,%ebp
  800658:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80065b:	e8 8b 14 00 00       	call   801aeb <sys_getenvindex>
  800660:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800663:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800666:	89 d0                	mov    %edx,%eax
  800668:	c1 e0 02             	shl    $0x2,%eax
  80066b:	01 d0                	add    %edx,%eax
  80066d:	01 c0                	add    %eax,%eax
  80066f:	01 d0                	add    %edx,%eax
  800671:	01 c0                	add    %eax,%eax
  800673:	01 d0                	add    %edx,%eax
  800675:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80067c:	01 d0                	add    %edx,%eax
  80067e:	c1 e0 02             	shl    $0x2,%eax
  800681:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800686:	a3 08 30 80 00       	mov    %eax,0x803008

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80068b:	a1 08 30 80 00       	mov    0x803008,%eax
  800690:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800696:	84 c0                	test   %al,%al
  800698:	74 0f                	je     8006a9 <libmain+0x54>
		binaryname = myEnv->prog_name;
  80069a:	a1 08 30 80 00       	mov    0x803008,%eax
  80069f:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006a4:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006a9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006ad:	7e 0a                	jle    8006b9 <libmain+0x64>
		binaryname = argv[0];
  8006af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006b2:	8b 00                	mov    (%eax),%eax
  8006b4:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006b9:	83 ec 08             	sub    $0x8,%esp
  8006bc:	ff 75 0c             	pushl  0xc(%ebp)
  8006bf:	ff 75 08             	pushl  0x8(%ebp)
  8006c2:	e8 71 f9 ff ff       	call   800038 <_main>
  8006c7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006ca:	e8 b7 15 00 00       	call   801c86 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006cf:	83 ec 0c             	sub    $0xc,%esp
  8006d2:	68 d4 24 80 00       	push   $0x8024d4
  8006d7:	e8 3c 03 00 00       	call   800a18 <cprintf>
  8006dc:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006df:	a1 08 30 80 00       	mov    0x803008,%eax
  8006e4:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8006ea:	a1 08 30 80 00       	mov    0x803008,%eax
  8006ef:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006f5:	83 ec 04             	sub    $0x4,%esp
  8006f8:	52                   	push   %edx
  8006f9:	50                   	push   %eax
  8006fa:	68 fc 24 80 00       	push   $0x8024fc
  8006ff:	e8 14 03 00 00       	call   800a18 <cprintf>
  800704:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800707:	a1 08 30 80 00       	mov    0x803008,%eax
  80070c:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800712:	83 ec 08             	sub    $0x8,%esp
  800715:	50                   	push   %eax
  800716:	68 21 25 80 00       	push   $0x802521
  80071b:	e8 f8 02 00 00       	call   800a18 <cprintf>
  800720:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800723:	83 ec 0c             	sub    $0xc,%esp
  800726:	68 d4 24 80 00       	push   $0x8024d4
  80072b:	e8 e8 02 00 00       	call   800a18 <cprintf>
  800730:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800733:	e8 68 15 00 00       	call   801ca0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800738:	e8 19 00 00 00       	call   800756 <exit>
}
  80073d:	90                   	nop
  80073e:	c9                   	leave  
  80073f:	c3                   	ret    

00800740 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800740:	55                   	push   %ebp
  800741:	89 e5                	mov    %esp,%ebp
  800743:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800746:	83 ec 0c             	sub    $0xc,%esp
  800749:	6a 00                	push   $0x0
  80074b:	e8 67 13 00 00       	call   801ab7 <sys_env_destroy>
  800750:	83 c4 10             	add    $0x10,%esp
}
  800753:	90                   	nop
  800754:	c9                   	leave  
  800755:	c3                   	ret    

00800756 <exit>:

void
exit(void)
{
  800756:	55                   	push   %ebp
  800757:	89 e5                	mov    %esp,%ebp
  800759:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80075c:	e8 bc 13 00 00       	call   801b1d <sys_env_exit>
}
  800761:	90                   	nop
  800762:	c9                   	leave  
  800763:	c3                   	ret    

00800764 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800764:	55                   	push   %ebp
  800765:	89 e5                	mov    %esp,%ebp
  800767:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80076a:	8d 45 10             	lea    0x10(%ebp),%eax
  80076d:	83 c0 04             	add    $0x4,%eax
  800770:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800773:	a1 18 30 80 00       	mov    0x803018,%eax
  800778:	85 c0                	test   %eax,%eax
  80077a:	74 16                	je     800792 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80077c:	a1 18 30 80 00       	mov    0x803018,%eax
  800781:	83 ec 08             	sub    $0x8,%esp
  800784:	50                   	push   %eax
  800785:	68 38 25 80 00       	push   $0x802538
  80078a:	e8 89 02 00 00       	call   800a18 <cprintf>
  80078f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800792:	a1 00 30 80 00       	mov    0x803000,%eax
  800797:	ff 75 0c             	pushl  0xc(%ebp)
  80079a:	ff 75 08             	pushl  0x8(%ebp)
  80079d:	50                   	push   %eax
  80079e:	68 3d 25 80 00       	push   $0x80253d
  8007a3:	e8 70 02 00 00       	call   800a18 <cprintf>
  8007a8:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ae:	83 ec 08             	sub    $0x8,%esp
  8007b1:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b4:	50                   	push   %eax
  8007b5:	e8 f3 01 00 00       	call   8009ad <vcprintf>
  8007ba:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007bd:	83 ec 08             	sub    $0x8,%esp
  8007c0:	6a 00                	push   $0x0
  8007c2:	68 59 25 80 00       	push   $0x802559
  8007c7:	e8 e1 01 00 00       	call   8009ad <vcprintf>
  8007cc:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007cf:	e8 82 ff ff ff       	call   800756 <exit>

	// should not return here
	while (1) ;
  8007d4:	eb fe                	jmp    8007d4 <_panic+0x70>

008007d6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007d6:	55                   	push   %ebp
  8007d7:	89 e5                	mov    %esp,%ebp
  8007d9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007dc:	a1 08 30 80 00       	mov    0x803008,%eax
  8007e1:	8b 50 74             	mov    0x74(%eax),%edx
  8007e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e7:	39 c2                	cmp    %eax,%edx
  8007e9:	74 14                	je     8007ff <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007eb:	83 ec 04             	sub    $0x4,%esp
  8007ee:	68 5c 25 80 00       	push   $0x80255c
  8007f3:	6a 26                	push   $0x26
  8007f5:	68 a8 25 80 00       	push   $0x8025a8
  8007fa:	e8 65 ff ff ff       	call   800764 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800806:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80080d:	e9 c2 00 00 00       	jmp    8008d4 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800812:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800815:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80081c:	8b 45 08             	mov    0x8(%ebp),%eax
  80081f:	01 d0                	add    %edx,%eax
  800821:	8b 00                	mov    (%eax),%eax
  800823:	85 c0                	test   %eax,%eax
  800825:	75 08                	jne    80082f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800827:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80082a:	e9 a2 00 00 00       	jmp    8008d1 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80082f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800836:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80083d:	eb 69                	jmp    8008a8 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80083f:	a1 08 30 80 00       	mov    0x803008,%eax
  800844:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80084a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80084d:	89 d0                	mov    %edx,%eax
  80084f:	01 c0                	add    %eax,%eax
  800851:	01 d0                	add    %edx,%eax
  800853:	c1 e0 02             	shl    $0x2,%eax
  800856:	01 c8                	add    %ecx,%eax
  800858:	8a 40 04             	mov    0x4(%eax),%al
  80085b:	84 c0                	test   %al,%al
  80085d:	75 46                	jne    8008a5 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80085f:	a1 08 30 80 00       	mov    0x803008,%eax
  800864:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80086a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80086d:	89 d0                	mov    %edx,%eax
  80086f:	01 c0                	add    %eax,%eax
  800871:	01 d0                	add    %edx,%eax
  800873:	c1 e0 02             	shl    $0x2,%eax
  800876:	01 c8                	add    %ecx,%eax
  800878:	8b 00                	mov    (%eax),%eax
  80087a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80087d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800880:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800885:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800887:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80088a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800891:	8b 45 08             	mov    0x8(%ebp),%eax
  800894:	01 c8                	add    %ecx,%eax
  800896:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800898:	39 c2                	cmp    %eax,%edx
  80089a:	75 09                	jne    8008a5 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80089c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008a3:	eb 12                	jmp    8008b7 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a5:	ff 45 e8             	incl   -0x18(%ebp)
  8008a8:	a1 08 30 80 00       	mov    0x803008,%eax
  8008ad:	8b 50 74             	mov    0x74(%eax),%edx
  8008b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008b3:	39 c2                	cmp    %eax,%edx
  8008b5:	77 88                	ja     80083f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008b7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008bb:	75 14                	jne    8008d1 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8008bd:	83 ec 04             	sub    $0x4,%esp
  8008c0:	68 b4 25 80 00       	push   $0x8025b4
  8008c5:	6a 3a                	push   $0x3a
  8008c7:	68 a8 25 80 00       	push   $0x8025a8
  8008cc:	e8 93 fe ff ff       	call   800764 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008d1:	ff 45 f0             	incl   -0x10(%ebp)
  8008d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008da:	0f 8c 32 ff ff ff    	jl     800812 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008e0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008e7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008ee:	eb 26                	jmp    800916 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008f0:	a1 08 30 80 00       	mov    0x803008,%eax
  8008f5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008fb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008fe:	89 d0                	mov    %edx,%eax
  800900:	01 c0                	add    %eax,%eax
  800902:	01 d0                	add    %edx,%eax
  800904:	c1 e0 02             	shl    $0x2,%eax
  800907:	01 c8                	add    %ecx,%eax
  800909:	8a 40 04             	mov    0x4(%eax),%al
  80090c:	3c 01                	cmp    $0x1,%al
  80090e:	75 03                	jne    800913 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800910:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800913:	ff 45 e0             	incl   -0x20(%ebp)
  800916:	a1 08 30 80 00       	mov    0x803008,%eax
  80091b:	8b 50 74             	mov    0x74(%eax),%edx
  80091e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800921:	39 c2                	cmp    %eax,%edx
  800923:	77 cb                	ja     8008f0 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800925:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800928:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80092b:	74 14                	je     800941 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80092d:	83 ec 04             	sub    $0x4,%esp
  800930:	68 08 26 80 00       	push   $0x802608
  800935:	6a 44                	push   $0x44
  800937:	68 a8 25 80 00       	push   $0x8025a8
  80093c:	e8 23 fe ff ff       	call   800764 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800941:	90                   	nop
  800942:	c9                   	leave  
  800943:	c3                   	ret    

00800944 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800944:	55                   	push   %ebp
  800945:	89 e5                	mov    %esp,%ebp
  800947:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80094a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094d:	8b 00                	mov    (%eax),%eax
  80094f:	8d 48 01             	lea    0x1(%eax),%ecx
  800952:	8b 55 0c             	mov    0xc(%ebp),%edx
  800955:	89 0a                	mov    %ecx,(%edx)
  800957:	8b 55 08             	mov    0x8(%ebp),%edx
  80095a:	88 d1                	mov    %dl,%cl
  80095c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80095f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800963:	8b 45 0c             	mov    0xc(%ebp),%eax
  800966:	8b 00                	mov    (%eax),%eax
  800968:	3d ff 00 00 00       	cmp    $0xff,%eax
  80096d:	75 2c                	jne    80099b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80096f:	a0 0c 30 80 00       	mov    0x80300c,%al
  800974:	0f b6 c0             	movzbl %al,%eax
  800977:	8b 55 0c             	mov    0xc(%ebp),%edx
  80097a:	8b 12                	mov    (%edx),%edx
  80097c:	89 d1                	mov    %edx,%ecx
  80097e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800981:	83 c2 08             	add    $0x8,%edx
  800984:	83 ec 04             	sub    $0x4,%esp
  800987:	50                   	push   %eax
  800988:	51                   	push   %ecx
  800989:	52                   	push   %edx
  80098a:	e8 e6 10 00 00       	call   801a75 <sys_cputs>
  80098f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800992:	8b 45 0c             	mov    0xc(%ebp),%eax
  800995:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80099b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099e:	8b 40 04             	mov    0x4(%eax),%eax
  8009a1:	8d 50 01             	lea    0x1(%eax),%edx
  8009a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a7:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009aa:	90                   	nop
  8009ab:	c9                   	leave  
  8009ac:	c3                   	ret    

008009ad <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009ad:	55                   	push   %ebp
  8009ae:	89 e5                	mov    %esp,%ebp
  8009b0:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009b6:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009bd:	00 00 00 
	b.cnt = 0;
  8009c0:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009c7:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009ca:	ff 75 0c             	pushl  0xc(%ebp)
  8009cd:	ff 75 08             	pushl  0x8(%ebp)
  8009d0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009d6:	50                   	push   %eax
  8009d7:	68 44 09 80 00       	push   $0x800944
  8009dc:	e8 11 02 00 00       	call   800bf2 <vprintfmt>
  8009e1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009e4:	a0 0c 30 80 00       	mov    0x80300c,%al
  8009e9:	0f b6 c0             	movzbl %al,%eax
  8009ec:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009f2:	83 ec 04             	sub    $0x4,%esp
  8009f5:	50                   	push   %eax
  8009f6:	52                   	push   %edx
  8009f7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009fd:	83 c0 08             	add    $0x8,%eax
  800a00:	50                   	push   %eax
  800a01:	e8 6f 10 00 00       	call   801a75 <sys_cputs>
  800a06:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a09:	c6 05 0c 30 80 00 00 	movb   $0x0,0x80300c
	return b.cnt;
  800a10:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a16:	c9                   	leave  
  800a17:	c3                   	ret    

00800a18 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a18:	55                   	push   %ebp
  800a19:	89 e5                	mov    %esp,%ebp
  800a1b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a1e:	c6 05 0c 30 80 00 01 	movb   $0x1,0x80300c
	va_start(ap, fmt);
  800a25:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a28:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2e:	83 ec 08             	sub    $0x8,%esp
  800a31:	ff 75 f4             	pushl  -0xc(%ebp)
  800a34:	50                   	push   %eax
  800a35:	e8 73 ff ff ff       	call   8009ad <vcprintf>
  800a3a:	83 c4 10             	add    $0x10,%esp
  800a3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a40:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a43:	c9                   	leave  
  800a44:	c3                   	ret    

00800a45 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a45:	55                   	push   %ebp
  800a46:	89 e5                	mov    %esp,%ebp
  800a48:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a4b:	e8 36 12 00 00       	call   801c86 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a50:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a53:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	83 ec 08             	sub    $0x8,%esp
  800a5c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a5f:	50                   	push   %eax
  800a60:	e8 48 ff ff ff       	call   8009ad <vcprintf>
  800a65:	83 c4 10             	add    $0x10,%esp
  800a68:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a6b:	e8 30 12 00 00       	call   801ca0 <sys_enable_interrupt>
	return cnt;
  800a70:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a73:	c9                   	leave  
  800a74:	c3                   	ret    

00800a75 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a75:	55                   	push   %ebp
  800a76:	89 e5                	mov    %esp,%ebp
  800a78:	53                   	push   %ebx
  800a79:	83 ec 14             	sub    $0x14,%esp
  800a7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a82:	8b 45 14             	mov    0x14(%ebp),%eax
  800a85:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a88:	8b 45 18             	mov    0x18(%ebp),%eax
  800a8b:	ba 00 00 00 00       	mov    $0x0,%edx
  800a90:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a93:	77 55                	ja     800aea <printnum+0x75>
  800a95:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a98:	72 05                	jb     800a9f <printnum+0x2a>
  800a9a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a9d:	77 4b                	ja     800aea <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a9f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800aa2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800aa5:	8b 45 18             	mov    0x18(%ebp),%eax
  800aa8:	ba 00 00 00 00       	mov    $0x0,%edx
  800aad:	52                   	push   %edx
  800aae:	50                   	push   %eax
  800aaf:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab2:	ff 75 f0             	pushl  -0x10(%ebp)
  800ab5:	e8 aa 15 00 00       	call   802064 <__udivdi3>
  800aba:	83 c4 10             	add    $0x10,%esp
  800abd:	83 ec 04             	sub    $0x4,%esp
  800ac0:	ff 75 20             	pushl  0x20(%ebp)
  800ac3:	53                   	push   %ebx
  800ac4:	ff 75 18             	pushl  0x18(%ebp)
  800ac7:	52                   	push   %edx
  800ac8:	50                   	push   %eax
  800ac9:	ff 75 0c             	pushl  0xc(%ebp)
  800acc:	ff 75 08             	pushl  0x8(%ebp)
  800acf:	e8 a1 ff ff ff       	call   800a75 <printnum>
  800ad4:	83 c4 20             	add    $0x20,%esp
  800ad7:	eb 1a                	jmp    800af3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ad9:	83 ec 08             	sub    $0x8,%esp
  800adc:	ff 75 0c             	pushl  0xc(%ebp)
  800adf:	ff 75 20             	pushl  0x20(%ebp)
  800ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae5:	ff d0                	call   *%eax
  800ae7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800aea:	ff 4d 1c             	decl   0x1c(%ebp)
  800aed:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800af1:	7f e6                	jg     800ad9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800af3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800af6:	bb 00 00 00 00       	mov    $0x0,%ebx
  800afb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800afe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b01:	53                   	push   %ebx
  800b02:	51                   	push   %ecx
  800b03:	52                   	push   %edx
  800b04:	50                   	push   %eax
  800b05:	e8 6a 16 00 00       	call   802174 <__umoddi3>
  800b0a:	83 c4 10             	add    $0x10,%esp
  800b0d:	05 74 28 80 00       	add    $0x802874,%eax
  800b12:	8a 00                	mov    (%eax),%al
  800b14:	0f be c0             	movsbl %al,%eax
  800b17:	83 ec 08             	sub    $0x8,%esp
  800b1a:	ff 75 0c             	pushl  0xc(%ebp)
  800b1d:	50                   	push   %eax
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	ff d0                	call   *%eax
  800b23:	83 c4 10             	add    $0x10,%esp
}
  800b26:	90                   	nop
  800b27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b2a:	c9                   	leave  
  800b2b:	c3                   	ret    

00800b2c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b2c:	55                   	push   %ebp
  800b2d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b2f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b33:	7e 1c                	jle    800b51 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b35:	8b 45 08             	mov    0x8(%ebp),%eax
  800b38:	8b 00                	mov    (%eax),%eax
  800b3a:	8d 50 08             	lea    0x8(%eax),%edx
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	89 10                	mov    %edx,(%eax)
  800b42:	8b 45 08             	mov    0x8(%ebp),%eax
  800b45:	8b 00                	mov    (%eax),%eax
  800b47:	83 e8 08             	sub    $0x8,%eax
  800b4a:	8b 50 04             	mov    0x4(%eax),%edx
  800b4d:	8b 00                	mov    (%eax),%eax
  800b4f:	eb 40                	jmp    800b91 <getuint+0x65>
	else if (lflag)
  800b51:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b55:	74 1e                	je     800b75 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	8d 50 04             	lea    0x4(%eax),%edx
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	89 10                	mov    %edx,(%eax)
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	8b 00                	mov    (%eax),%eax
  800b69:	83 e8 04             	sub    $0x4,%eax
  800b6c:	8b 00                	mov    (%eax),%eax
  800b6e:	ba 00 00 00 00       	mov    $0x0,%edx
  800b73:	eb 1c                	jmp    800b91 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	8b 00                	mov    (%eax),%eax
  800b7a:	8d 50 04             	lea    0x4(%eax),%edx
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	89 10                	mov    %edx,(%eax)
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	8b 00                	mov    (%eax),%eax
  800b87:	83 e8 04             	sub    $0x4,%eax
  800b8a:	8b 00                	mov    (%eax),%eax
  800b8c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b91:	5d                   	pop    %ebp
  800b92:	c3                   	ret    

00800b93 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b93:	55                   	push   %ebp
  800b94:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b96:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b9a:	7e 1c                	jle    800bb8 <getint+0x25>
		return va_arg(*ap, long long);
  800b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9f:	8b 00                	mov    (%eax),%eax
  800ba1:	8d 50 08             	lea    0x8(%eax),%edx
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	89 10                	mov    %edx,(%eax)
  800ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bac:	8b 00                	mov    (%eax),%eax
  800bae:	83 e8 08             	sub    $0x8,%eax
  800bb1:	8b 50 04             	mov    0x4(%eax),%edx
  800bb4:	8b 00                	mov    (%eax),%eax
  800bb6:	eb 38                	jmp    800bf0 <getint+0x5d>
	else if (lflag)
  800bb8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bbc:	74 1a                	je     800bd8 <getint+0x45>
		return va_arg(*ap, long);
  800bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc1:	8b 00                	mov    (%eax),%eax
  800bc3:	8d 50 04             	lea    0x4(%eax),%edx
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	89 10                	mov    %edx,(%eax)
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	8b 00                	mov    (%eax),%eax
  800bd0:	83 e8 04             	sub    $0x4,%eax
  800bd3:	8b 00                	mov    (%eax),%eax
  800bd5:	99                   	cltd   
  800bd6:	eb 18                	jmp    800bf0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	8b 00                	mov    (%eax),%eax
  800bdd:	8d 50 04             	lea    0x4(%eax),%edx
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	89 10                	mov    %edx,(%eax)
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
  800be8:	8b 00                	mov    (%eax),%eax
  800bea:	83 e8 04             	sub    $0x4,%eax
  800bed:	8b 00                	mov    (%eax),%eax
  800bef:	99                   	cltd   
}
  800bf0:	5d                   	pop    %ebp
  800bf1:	c3                   	ret    

00800bf2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bf2:	55                   	push   %ebp
  800bf3:	89 e5                	mov    %esp,%ebp
  800bf5:	56                   	push   %esi
  800bf6:	53                   	push   %ebx
  800bf7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bfa:	eb 17                	jmp    800c13 <vprintfmt+0x21>
			if (ch == '\0')
  800bfc:	85 db                	test   %ebx,%ebx
  800bfe:	0f 84 af 03 00 00    	je     800fb3 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c04:	83 ec 08             	sub    $0x8,%esp
  800c07:	ff 75 0c             	pushl  0xc(%ebp)
  800c0a:	53                   	push   %ebx
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0e:	ff d0                	call   *%eax
  800c10:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c13:	8b 45 10             	mov    0x10(%ebp),%eax
  800c16:	8d 50 01             	lea    0x1(%eax),%edx
  800c19:	89 55 10             	mov    %edx,0x10(%ebp)
  800c1c:	8a 00                	mov    (%eax),%al
  800c1e:	0f b6 d8             	movzbl %al,%ebx
  800c21:	83 fb 25             	cmp    $0x25,%ebx
  800c24:	75 d6                	jne    800bfc <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c26:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c2a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c31:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c38:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c3f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c46:	8b 45 10             	mov    0x10(%ebp),%eax
  800c49:	8d 50 01             	lea    0x1(%eax),%edx
  800c4c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c4f:	8a 00                	mov    (%eax),%al
  800c51:	0f b6 d8             	movzbl %al,%ebx
  800c54:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c57:	83 f8 55             	cmp    $0x55,%eax
  800c5a:	0f 87 2b 03 00 00    	ja     800f8b <vprintfmt+0x399>
  800c60:	8b 04 85 98 28 80 00 	mov    0x802898(,%eax,4),%eax
  800c67:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c69:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c6d:	eb d7                	jmp    800c46 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c6f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c73:	eb d1                	jmp    800c46 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c75:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c7c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c7f:	89 d0                	mov    %edx,%eax
  800c81:	c1 e0 02             	shl    $0x2,%eax
  800c84:	01 d0                	add    %edx,%eax
  800c86:	01 c0                	add    %eax,%eax
  800c88:	01 d8                	add    %ebx,%eax
  800c8a:	83 e8 30             	sub    $0x30,%eax
  800c8d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c90:	8b 45 10             	mov    0x10(%ebp),%eax
  800c93:	8a 00                	mov    (%eax),%al
  800c95:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c98:	83 fb 2f             	cmp    $0x2f,%ebx
  800c9b:	7e 3e                	jle    800cdb <vprintfmt+0xe9>
  800c9d:	83 fb 39             	cmp    $0x39,%ebx
  800ca0:	7f 39                	jg     800cdb <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ca2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ca5:	eb d5                	jmp    800c7c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ca7:	8b 45 14             	mov    0x14(%ebp),%eax
  800caa:	83 c0 04             	add    $0x4,%eax
  800cad:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb3:	83 e8 04             	sub    $0x4,%eax
  800cb6:	8b 00                	mov    (%eax),%eax
  800cb8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cbb:	eb 1f                	jmp    800cdc <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cbd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cc1:	79 83                	jns    800c46 <vprintfmt+0x54>
				width = 0;
  800cc3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cca:	e9 77 ff ff ff       	jmp    800c46 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ccf:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cd6:	e9 6b ff ff ff       	jmp    800c46 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cdb:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cdc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ce0:	0f 89 60 ff ff ff    	jns    800c46 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ce6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ce9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cec:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cf3:	e9 4e ff ff ff       	jmp    800c46 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cf8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cfb:	e9 46 ff ff ff       	jmp    800c46 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d00:	8b 45 14             	mov    0x14(%ebp),%eax
  800d03:	83 c0 04             	add    $0x4,%eax
  800d06:	89 45 14             	mov    %eax,0x14(%ebp)
  800d09:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0c:	83 e8 04             	sub    $0x4,%eax
  800d0f:	8b 00                	mov    (%eax),%eax
  800d11:	83 ec 08             	sub    $0x8,%esp
  800d14:	ff 75 0c             	pushl  0xc(%ebp)
  800d17:	50                   	push   %eax
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	ff d0                	call   *%eax
  800d1d:	83 c4 10             	add    $0x10,%esp
			break;
  800d20:	e9 89 02 00 00       	jmp    800fae <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d25:	8b 45 14             	mov    0x14(%ebp),%eax
  800d28:	83 c0 04             	add    $0x4,%eax
  800d2b:	89 45 14             	mov    %eax,0x14(%ebp)
  800d2e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d31:	83 e8 04             	sub    $0x4,%eax
  800d34:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d36:	85 db                	test   %ebx,%ebx
  800d38:	79 02                	jns    800d3c <vprintfmt+0x14a>
				err = -err;
  800d3a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d3c:	83 fb 64             	cmp    $0x64,%ebx
  800d3f:	7f 0b                	jg     800d4c <vprintfmt+0x15a>
  800d41:	8b 34 9d e0 26 80 00 	mov    0x8026e0(,%ebx,4),%esi
  800d48:	85 f6                	test   %esi,%esi
  800d4a:	75 19                	jne    800d65 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d4c:	53                   	push   %ebx
  800d4d:	68 85 28 80 00       	push   $0x802885
  800d52:	ff 75 0c             	pushl  0xc(%ebp)
  800d55:	ff 75 08             	pushl  0x8(%ebp)
  800d58:	e8 5e 02 00 00       	call   800fbb <printfmt>
  800d5d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d60:	e9 49 02 00 00       	jmp    800fae <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d65:	56                   	push   %esi
  800d66:	68 8e 28 80 00       	push   $0x80288e
  800d6b:	ff 75 0c             	pushl  0xc(%ebp)
  800d6e:	ff 75 08             	pushl  0x8(%ebp)
  800d71:	e8 45 02 00 00       	call   800fbb <printfmt>
  800d76:	83 c4 10             	add    $0x10,%esp
			break;
  800d79:	e9 30 02 00 00       	jmp    800fae <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d81:	83 c0 04             	add    $0x4,%eax
  800d84:	89 45 14             	mov    %eax,0x14(%ebp)
  800d87:	8b 45 14             	mov    0x14(%ebp),%eax
  800d8a:	83 e8 04             	sub    $0x4,%eax
  800d8d:	8b 30                	mov    (%eax),%esi
  800d8f:	85 f6                	test   %esi,%esi
  800d91:	75 05                	jne    800d98 <vprintfmt+0x1a6>
				p = "(null)";
  800d93:	be 91 28 80 00       	mov    $0x802891,%esi
			if (width > 0 && padc != '-')
  800d98:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d9c:	7e 6d                	jle    800e0b <vprintfmt+0x219>
  800d9e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800da2:	74 67                	je     800e0b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800da4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800da7:	83 ec 08             	sub    $0x8,%esp
  800daa:	50                   	push   %eax
  800dab:	56                   	push   %esi
  800dac:	e8 12 05 00 00       	call   8012c3 <strnlen>
  800db1:	83 c4 10             	add    $0x10,%esp
  800db4:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800db7:	eb 16                	jmp    800dcf <vprintfmt+0x1dd>
					putch(padc, putdat);
  800db9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dbd:	83 ec 08             	sub    $0x8,%esp
  800dc0:	ff 75 0c             	pushl  0xc(%ebp)
  800dc3:	50                   	push   %eax
  800dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc7:	ff d0                	call   *%eax
  800dc9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dcc:	ff 4d e4             	decl   -0x1c(%ebp)
  800dcf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dd3:	7f e4                	jg     800db9 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dd5:	eb 34                	jmp    800e0b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800dd7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ddb:	74 1c                	je     800df9 <vprintfmt+0x207>
  800ddd:	83 fb 1f             	cmp    $0x1f,%ebx
  800de0:	7e 05                	jle    800de7 <vprintfmt+0x1f5>
  800de2:	83 fb 7e             	cmp    $0x7e,%ebx
  800de5:	7e 12                	jle    800df9 <vprintfmt+0x207>
					putch('?', putdat);
  800de7:	83 ec 08             	sub    $0x8,%esp
  800dea:	ff 75 0c             	pushl  0xc(%ebp)
  800ded:	6a 3f                	push   $0x3f
  800def:	8b 45 08             	mov    0x8(%ebp),%eax
  800df2:	ff d0                	call   *%eax
  800df4:	83 c4 10             	add    $0x10,%esp
  800df7:	eb 0f                	jmp    800e08 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800df9:	83 ec 08             	sub    $0x8,%esp
  800dfc:	ff 75 0c             	pushl  0xc(%ebp)
  800dff:	53                   	push   %ebx
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	ff d0                	call   *%eax
  800e05:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e08:	ff 4d e4             	decl   -0x1c(%ebp)
  800e0b:	89 f0                	mov    %esi,%eax
  800e0d:	8d 70 01             	lea    0x1(%eax),%esi
  800e10:	8a 00                	mov    (%eax),%al
  800e12:	0f be d8             	movsbl %al,%ebx
  800e15:	85 db                	test   %ebx,%ebx
  800e17:	74 24                	je     800e3d <vprintfmt+0x24b>
  800e19:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e1d:	78 b8                	js     800dd7 <vprintfmt+0x1e5>
  800e1f:	ff 4d e0             	decl   -0x20(%ebp)
  800e22:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e26:	79 af                	jns    800dd7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e28:	eb 13                	jmp    800e3d <vprintfmt+0x24b>
				putch(' ', putdat);
  800e2a:	83 ec 08             	sub    $0x8,%esp
  800e2d:	ff 75 0c             	pushl  0xc(%ebp)
  800e30:	6a 20                	push   $0x20
  800e32:	8b 45 08             	mov    0x8(%ebp),%eax
  800e35:	ff d0                	call   *%eax
  800e37:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e3a:	ff 4d e4             	decl   -0x1c(%ebp)
  800e3d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e41:	7f e7                	jg     800e2a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e43:	e9 66 01 00 00       	jmp    800fae <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e48:	83 ec 08             	sub    $0x8,%esp
  800e4b:	ff 75 e8             	pushl  -0x18(%ebp)
  800e4e:	8d 45 14             	lea    0x14(%ebp),%eax
  800e51:	50                   	push   %eax
  800e52:	e8 3c fd ff ff       	call   800b93 <getint>
  800e57:	83 c4 10             	add    $0x10,%esp
  800e5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e63:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e66:	85 d2                	test   %edx,%edx
  800e68:	79 23                	jns    800e8d <vprintfmt+0x29b>
				putch('-', putdat);
  800e6a:	83 ec 08             	sub    $0x8,%esp
  800e6d:	ff 75 0c             	pushl  0xc(%ebp)
  800e70:	6a 2d                	push   $0x2d
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	ff d0                	call   *%eax
  800e77:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e80:	f7 d8                	neg    %eax
  800e82:	83 d2 00             	adc    $0x0,%edx
  800e85:	f7 da                	neg    %edx
  800e87:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e8a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e8d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e94:	e9 bc 00 00 00       	jmp    800f55 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e99:	83 ec 08             	sub    $0x8,%esp
  800e9c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e9f:	8d 45 14             	lea    0x14(%ebp),%eax
  800ea2:	50                   	push   %eax
  800ea3:	e8 84 fc ff ff       	call   800b2c <getuint>
  800ea8:	83 c4 10             	add    $0x10,%esp
  800eab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eae:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800eb1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800eb8:	e9 98 00 00 00       	jmp    800f55 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ebd:	83 ec 08             	sub    $0x8,%esp
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	6a 58                	push   $0x58
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	ff d0                	call   *%eax
  800eca:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ecd:	83 ec 08             	sub    $0x8,%esp
  800ed0:	ff 75 0c             	pushl  0xc(%ebp)
  800ed3:	6a 58                	push   $0x58
  800ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed8:	ff d0                	call   *%eax
  800eda:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800edd:	83 ec 08             	sub    $0x8,%esp
  800ee0:	ff 75 0c             	pushl  0xc(%ebp)
  800ee3:	6a 58                	push   $0x58
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee8:	ff d0                	call   *%eax
  800eea:	83 c4 10             	add    $0x10,%esp
			break;
  800eed:	e9 bc 00 00 00       	jmp    800fae <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ef2:	83 ec 08             	sub    $0x8,%esp
  800ef5:	ff 75 0c             	pushl  0xc(%ebp)
  800ef8:	6a 30                	push   $0x30
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
  800efd:	ff d0                	call   *%eax
  800eff:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f02:	83 ec 08             	sub    $0x8,%esp
  800f05:	ff 75 0c             	pushl  0xc(%ebp)
  800f08:	6a 78                	push   $0x78
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	ff d0                	call   *%eax
  800f0f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f12:	8b 45 14             	mov    0x14(%ebp),%eax
  800f15:	83 c0 04             	add    $0x4,%eax
  800f18:	89 45 14             	mov    %eax,0x14(%ebp)
  800f1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1e:	83 e8 04             	sub    $0x4,%eax
  800f21:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f2d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f34:	eb 1f                	jmp    800f55 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f36:	83 ec 08             	sub    $0x8,%esp
  800f39:	ff 75 e8             	pushl  -0x18(%ebp)
  800f3c:	8d 45 14             	lea    0x14(%ebp),%eax
  800f3f:	50                   	push   %eax
  800f40:	e8 e7 fb ff ff       	call   800b2c <getuint>
  800f45:	83 c4 10             	add    $0x10,%esp
  800f48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f4b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f4e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f55:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f59:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f5c:	83 ec 04             	sub    $0x4,%esp
  800f5f:	52                   	push   %edx
  800f60:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f63:	50                   	push   %eax
  800f64:	ff 75 f4             	pushl  -0xc(%ebp)
  800f67:	ff 75 f0             	pushl  -0x10(%ebp)
  800f6a:	ff 75 0c             	pushl  0xc(%ebp)
  800f6d:	ff 75 08             	pushl  0x8(%ebp)
  800f70:	e8 00 fb ff ff       	call   800a75 <printnum>
  800f75:	83 c4 20             	add    $0x20,%esp
			break;
  800f78:	eb 34                	jmp    800fae <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f7a:	83 ec 08             	sub    $0x8,%esp
  800f7d:	ff 75 0c             	pushl  0xc(%ebp)
  800f80:	53                   	push   %ebx
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	ff d0                	call   *%eax
  800f86:	83 c4 10             	add    $0x10,%esp
			break;
  800f89:	eb 23                	jmp    800fae <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f8b:	83 ec 08             	sub    $0x8,%esp
  800f8e:	ff 75 0c             	pushl  0xc(%ebp)
  800f91:	6a 25                	push   $0x25
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	ff d0                	call   *%eax
  800f98:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f9b:	ff 4d 10             	decl   0x10(%ebp)
  800f9e:	eb 03                	jmp    800fa3 <vprintfmt+0x3b1>
  800fa0:	ff 4d 10             	decl   0x10(%ebp)
  800fa3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa6:	48                   	dec    %eax
  800fa7:	8a 00                	mov    (%eax),%al
  800fa9:	3c 25                	cmp    $0x25,%al
  800fab:	75 f3                	jne    800fa0 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fad:	90                   	nop
		}
	}
  800fae:	e9 47 fc ff ff       	jmp    800bfa <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fb3:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fb4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fb7:	5b                   	pop    %ebx
  800fb8:	5e                   	pop    %esi
  800fb9:	5d                   	pop    %ebp
  800fba:	c3                   	ret    

00800fbb <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fbb:	55                   	push   %ebp
  800fbc:	89 e5                	mov    %esp,%ebp
  800fbe:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fc1:	8d 45 10             	lea    0x10(%ebp),%eax
  800fc4:	83 c0 04             	add    $0x4,%eax
  800fc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fca:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcd:	ff 75 f4             	pushl  -0xc(%ebp)
  800fd0:	50                   	push   %eax
  800fd1:	ff 75 0c             	pushl  0xc(%ebp)
  800fd4:	ff 75 08             	pushl  0x8(%ebp)
  800fd7:	e8 16 fc ff ff       	call   800bf2 <vprintfmt>
  800fdc:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fdf:	90                   	nop
  800fe0:	c9                   	leave  
  800fe1:	c3                   	ret    

00800fe2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fe2:	55                   	push   %ebp
  800fe3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fe5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe8:	8b 40 08             	mov    0x8(%eax),%eax
  800feb:	8d 50 01             	lea    0x1(%eax),%edx
  800fee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ff4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff7:	8b 10                	mov    (%eax),%edx
  800ff9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffc:	8b 40 04             	mov    0x4(%eax),%eax
  800fff:	39 c2                	cmp    %eax,%edx
  801001:	73 12                	jae    801015 <sprintputch+0x33>
		*b->buf++ = ch;
  801003:	8b 45 0c             	mov    0xc(%ebp),%eax
  801006:	8b 00                	mov    (%eax),%eax
  801008:	8d 48 01             	lea    0x1(%eax),%ecx
  80100b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80100e:	89 0a                	mov    %ecx,(%edx)
  801010:	8b 55 08             	mov    0x8(%ebp),%edx
  801013:	88 10                	mov    %dl,(%eax)
}
  801015:	90                   	nop
  801016:	5d                   	pop    %ebp
  801017:	c3                   	ret    

00801018 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801018:	55                   	push   %ebp
  801019:	89 e5                	mov    %esp,%ebp
  80101b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80101e:	8b 45 08             	mov    0x8(%ebp),%eax
  801021:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801024:	8b 45 0c             	mov    0xc(%ebp),%eax
  801027:	8d 50 ff             	lea    -0x1(%eax),%edx
  80102a:	8b 45 08             	mov    0x8(%ebp),%eax
  80102d:	01 d0                	add    %edx,%eax
  80102f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801032:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801039:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80103d:	74 06                	je     801045 <vsnprintf+0x2d>
  80103f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801043:	7f 07                	jg     80104c <vsnprintf+0x34>
		return -E_INVAL;
  801045:	b8 03 00 00 00       	mov    $0x3,%eax
  80104a:	eb 20                	jmp    80106c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80104c:	ff 75 14             	pushl  0x14(%ebp)
  80104f:	ff 75 10             	pushl  0x10(%ebp)
  801052:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801055:	50                   	push   %eax
  801056:	68 e2 0f 80 00       	push   $0x800fe2
  80105b:	e8 92 fb ff ff       	call   800bf2 <vprintfmt>
  801060:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801063:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801066:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801069:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80106c:	c9                   	leave  
  80106d:	c3                   	ret    

0080106e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80106e:	55                   	push   %ebp
  80106f:	89 e5                	mov    %esp,%ebp
  801071:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801074:	8d 45 10             	lea    0x10(%ebp),%eax
  801077:	83 c0 04             	add    $0x4,%eax
  80107a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80107d:	8b 45 10             	mov    0x10(%ebp),%eax
  801080:	ff 75 f4             	pushl  -0xc(%ebp)
  801083:	50                   	push   %eax
  801084:	ff 75 0c             	pushl  0xc(%ebp)
  801087:	ff 75 08             	pushl  0x8(%ebp)
  80108a:	e8 89 ff ff ff       	call   801018 <vsnprintf>
  80108f:	83 c4 10             	add    $0x10,%esp
  801092:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801095:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801098:	c9                   	leave  
  801099:	c3                   	ret    

0080109a <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80109a:	55                   	push   %ebp
  80109b:	89 e5                	mov    %esp,%ebp
  80109d:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010a4:	74 13                	je     8010b9 <readline+0x1f>
		cprintf("%s", prompt);
  8010a6:	83 ec 08             	sub    $0x8,%esp
  8010a9:	ff 75 08             	pushl  0x8(%ebp)
  8010ac:	68 f0 29 80 00       	push   $0x8029f0
  8010b1:	e8 62 f9 ff ff       	call   800a18 <cprintf>
  8010b6:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010c0:	83 ec 0c             	sub    $0xc,%esp
  8010c3:	6a 00                	push   $0x0
  8010c5:	e8 81 f5 ff ff       	call   80064b <iscons>
  8010ca:	83 c4 10             	add    $0x10,%esp
  8010cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010d0:	e8 28 f5 ff ff       	call   8005fd <getchar>
  8010d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010dc:	79 22                	jns    801100 <readline+0x66>
			if (c != -E_EOF)
  8010de:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010e2:	0f 84 ad 00 00 00    	je     801195 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010e8:	83 ec 08             	sub    $0x8,%esp
  8010eb:	ff 75 ec             	pushl  -0x14(%ebp)
  8010ee:	68 f3 29 80 00       	push   $0x8029f3
  8010f3:	e8 20 f9 ff ff       	call   800a18 <cprintf>
  8010f8:	83 c4 10             	add    $0x10,%esp
			return;
  8010fb:	e9 95 00 00 00       	jmp    801195 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801100:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801104:	7e 34                	jle    80113a <readline+0xa0>
  801106:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80110d:	7f 2b                	jg     80113a <readline+0xa0>
			if (echoing)
  80110f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801113:	74 0e                	je     801123 <readline+0x89>
				cputchar(c);
  801115:	83 ec 0c             	sub    $0xc,%esp
  801118:	ff 75 ec             	pushl  -0x14(%ebp)
  80111b:	e8 95 f4 ff ff       	call   8005b5 <cputchar>
  801120:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801123:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801126:	8d 50 01             	lea    0x1(%eax),%edx
  801129:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80112c:	89 c2                	mov    %eax,%edx
  80112e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801131:	01 d0                	add    %edx,%eax
  801133:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801136:	88 10                	mov    %dl,(%eax)
  801138:	eb 56                	jmp    801190 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80113a:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80113e:	75 1f                	jne    80115f <readline+0xc5>
  801140:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801144:	7e 19                	jle    80115f <readline+0xc5>
			if (echoing)
  801146:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80114a:	74 0e                	je     80115a <readline+0xc0>
				cputchar(c);
  80114c:	83 ec 0c             	sub    $0xc,%esp
  80114f:	ff 75 ec             	pushl  -0x14(%ebp)
  801152:	e8 5e f4 ff ff       	call   8005b5 <cputchar>
  801157:	83 c4 10             	add    $0x10,%esp

			i--;
  80115a:	ff 4d f4             	decl   -0xc(%ebp)
  80115d:	eb 31                	jmp    801190 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80115f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801163:	74 0a                	je     80116f <readline+0xd5>
  801165:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801169:	0f 85 61 ff ff ff    	jne    8010d0 <readline+0x36>
			if (echoing)
  80116f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801173:	74 0e                	je     801183 <readline+0xe9>
				cputchar(c);
  801175:	83 ec 0c             	sub    $0xc,%esp
  801178:	ff 75 ec             	pushl  -0x14(%ebp)
  80117b:	e8 35 f4 ff ff       	call   8005b5 <cputchar>
  801180:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801183:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801186:	8b 45 0c             	mov    0xc(%ebp),%eax
  801189:	01 d0                	add    %edx,%eax
  80118b:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80118e:	eb 06                	jmp    801196 <readline+0xfc>
		}
	}
  801190:	e9 3b ff ff ff       	jmp    8010d0 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801195:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801196:	c9                   	leave  
  801197:	c3                   	ret    

00801198 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801198:	55                   	push   %ebp
  801199:	89 e5                	mov    %esp,%ebp
  80119b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80119e:	e8 e3 0a 00 00       	call   801c86 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011a7:	74 13                	je     8011bc <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011a9:	83 ec 08             	sub    $0x8,%esp
  8011ac:	ff 75 08             	pushl  0x8(%ebp)
  8011af:	68 f0 29 80 00       	push   $0x8029f0
  8011b4:	e8 5f f8 ff ff       	call   800a18 <cprintf>
  8011b9:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011c3:	83 ec 0c             	sub    $0xc,%esp
  8011c6:	6a 00                	push   $0x0
  8011c8:	e8 7e f4 ff ff       	call   80064b <iscons>
  8011cd:	83 c4 10             	add    $0x10,%esp
  8011d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011d3:	e8 25 f4 ff ff       	call   8005fd <getchar>
  8011d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011df:	79 23                	jns    801204 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011e1:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011e5:	74 13                	je     8011fa <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011e7:	83 ec 08             	sub    $0x8,%esp
  8011ea:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ed:	68 f3 29 80 00       	push   $0x8029f3
  8011f2:	e8 21 f8 ff ff       	call   800a18 <cprintf>
  8011f7:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011fa:	e8 a1 0a 00 00       	call   801ca0 <sys_enable_interrupt>
			return;
  8011ff:	e9 9a 00 00 00       	jmp    80129e <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801204:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801208:	7e 34                	jle    80123e <atomic_readline+0xa6>
  80120a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801211:	7f 2b                	jg     80123e <atomic_readline+0xa6>
			if (echoing)
  801213:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801217:	74 0e                	je     801227 <atomic_readline+0x8f>
				cputchar(c);
  801219:	83 ec 0c             	sub    $0xc,%esp
  80121c:	ff 75 ec             	pushl  -0x14(%ebp)
  80121f:	e8 91 f3 ff ff       	call   8005b5 <cputchar>
  801224:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801227:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80122a:	8d 50 01             	lea    0x1(%eax),%edx
  80122d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801230:	89 c2                	mov    %eax,%edx
  801232:	8b 45 0c             	mov    0xc(%ebp),%eax
  801235:	01 d0                	add    %edx,%eax
  801237:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80123a:	88 10                	mov    %dl,(%eax)
  80123c:	eb 5b                	jmp    801299 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80123e:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801242:	75 1f                	jne    801263 <atomic_readline+0xcb>
  801244:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801248:	7e 19                	jle    801263 <atomic_readline+0xcb>
			if (echoing)
  80124a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80124e:	74 0e                	je     80125e <atomic_readline+0xc6>
				cputchar(c);
  801250:	83 ec 0c             	sub    $0xc,%esp
  801253:	ff 75 ec             	pushl  -0x14(%ebp)
  801256:	e8 5a f3 ff ff       	call   8005b5 <cputchar>
  80125b:	83 c4 10             	add    $0x10,%esp
			i--;
  80125e:	ff 4d f4             	decl   -0xc(%ebp)
  801261:	eb 36                	jmp    801299 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801263:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801267:	74 0a                	je     801273 <atomic_readline+0xdb>
  801269:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80126d:	0f 85 60 ff ff ff    	jne    8011d3 <atomic_readline+0x3b>
			if (echoing)
  801273:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801277:	74 0e                	je     801287 <atomic_readline+0xef>
				cputchar(c);
  801279:	83 ec 0c             	sub    $0xc,%esp
  80127c:	ff 75 ec             	pushl  -0x14(%ebp)
  80127f:	e8 31 f3 ff ff       	call   8005b5 <cputchar>
  801284:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801287:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80128a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128d:	01 d0                	add    %edx,%eax
  80128f:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801292:	e8 09 0a 00 00       	call   801ca0 <sys_enable_interrupt>
			return;
  801297:	eb 05                	jmp    80129e <atomic_readline+0x106>
		}
	}
  801299:	e9 35 ff ff ff       	jmp    8011d3 <atomic_readline+0x3b>
}
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
  8012a3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012ad:	eb 06                	jmp    8012b5 <strlen+0x15>
		n++;
  8012af:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012b2:	ff 45 08             	incl   0x8(%ebp)
  8012b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b8:	8a 00                	mov    (%eax),%al
  8012ba:	84 c0                	test   %al,%al
  8012bc:	75 f1                	jne    8012af <strlen+0xf>
		n++;
	return n;
  8012be:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012c1:	c9                   	leave  
  8012c2:	c3                   	ret    

008012c3 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012c3:	55                   	push   %ebp
  8012c4:	89 e5                	mov    %esp,%ebp
  8012c6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012d0:	eb 09                	jmp    8012db <strnlen+0x18>
		n++;
  8012d2:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012d5:	ff 45 08             	incl   0x8(%ebp)
  8012d8:	ff 4d 0c             	decl   0xc(%ebp)
  8012db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012df:	74 09                	je     8012ea <strnlen+0x27>
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	8a 00                	mov    (%eax),%al
  8012e6:	84 c0                	test   %al,%al
  8012e8:	75 e8                	jne    8012d2 <strnlen+0xf>
		n++;
	return n;
  8012ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012ed:	c9                   	leave  
  8012ee:	c3                   	ret    

008012ef <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012ef:	55                   	push   %ebp
  8012f0:	89 e5                	mov    %esp,%ebp
  8012f2:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012fb:	90                   	nop
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	8d 50 01             	lea    0x1(%eax),%edx
  801302:	89 55 08             	mov    %edx,0x8(%ebp)
  801305:	8b 55 0c             	mov    0xc(%ebp),%edx
  801308:	8d 4a 01             	lea    0x1(%edx),%ecx
  80130b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80130e:	8a 12                	mov    (%edx),%dl
  801310:	88 10                	mov    %dl,(%eax)
  801312:	8a 00                	mov    (%eax),%al
  801314:	84 c0                	test   %al,%al
  801316:	75 e4                	jne    8012fc <strcpy+0xd>
		/* do nothing */;
	return ret;
  801318:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
  801320:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801329:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801330:	eb 1f                	jmp    801351 <strncpy+0x34>
		*dst++ = *src;
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	8d 50 01             	lea    0x1(%eax),%edx
  801338:	89 55 08             	mov    %edx,0x8(%ebp)
  80133b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133e:	8a 12                	mov    (%edx),%dl
  801340:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801342:	8b 45 0c             	mov    0xc(%ebp),%eax
  801345:	8a 00                	mov    (%eax),%al
  801347:	84 c0                	test   %al,%al
  801349:	74 03                	je     80134e <strncpy+0x31>
			src++;
  80134b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80134e:	ff 45 fc             	incl   -0x4(%ebp)
  801351:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801354:	3b 45 10             	cmp    0x10(%ebp),%eax
  801357:	72 d9                	jb     801332 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801359:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
  801361:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801364:	8b 45 08             	mov    0x8(%ebp),%eax
  801367:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80136a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80136e:	74 30                	je     8013a0 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801370:	eb 16                	jmp    801388 <strlcpy+0x2a>
			*dst++ = *src++;
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	8d 50 01             	lea    0x1(%eax),%edx
  801378:	89 55 08             	mov    %edx,0x8(%ebp)
  80137b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801381:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801384:	8a 12                	mov    (%edx),%dl
  801386:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801388:	ff 4d 10             	decl   0x10(%ebp)
  80138b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80138f:	74 09                	je     80139a <strlcpy+0x3c>
  801391:	8b 45 0c             	mov    0xc(%ebp),%eax
  801394:	8a 00                	mov    (%eax),%al
  801396:	84 c0                	test   %al,%al
  801398:	75 d8                	jne    801372 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013a0:	8b 55 08             	mov    0x8(%ebp),%edx
  8013a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a6:	29 c2                	sub    %eax,%edx
  8013a8:	89 d0                	mov    %edx,%eax
}
  8013aa:	c9                   	leave  
  8013ab:	c3                   	ret    

008013ac <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013ac:	55                   	push   %ebp
  8013ad:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013af:	eb 06                	jmp    8013b7 <strcmp+0xb>
		p++, q++;
  8013b1:	ff 45 08             	incl   0x8(%ebp)
  8013b4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	8a 00                	mov    (%eax),%al
  8013bc:	84 c0                	test   %al,%al
  8013be:	74 0e                	je     8013ce <strcmp+0x22>
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	8a 10                	mov    (%eax),%dl
  8013c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c8:	8a 00                	mov    (%eax),%al
  8013ca:	38 c2                	cmp    %al,%dl
  8013cc:	74 e3                	je     8013b1 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	8a 00                	mov    (%eax),%al
  8013d3:	0f b6 d0             	movzbl %al,%edx
  8013d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	0f b6 c0             	movzbl %al,%eax
  8013de:	29 c2                	sub    %eax,%edx
  8013e0:	89 d0                	mov    %edx,%eax
}
  8013e2:	5d                   	pop    %ebp
  8013e3:	c3                   	ret    

008013e4 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013e4:	55                   	push   %ebp
  8013e5:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013e7:	eb 09                	jmp    8013f2 <strncmp+0xe>
		n--, p++, q++;
  8013e9:	ff 4d 10             	decl   0x10(%ebp)
  8013ec:	ff 45 08             	incl   0x8(%ebp)
  8013ef:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013f2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f6:	74 17                	je     80140f <strncmp+0x2b>
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	8a 00                	mov    (%eax),%al
  8013fd:	84 c0                	test   %al,%al
  8013ff:	74 0e                	je     80140f <strncmp+0x2b>
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	8a 10                	mov    (%eax),%dl
  801406:	8b 45 0c             	mov    0xc(%ebp),%eax
  801409:	8a 00                	mov    (%eax),%al
  80140b:	38 c2                	cmp    %al,%dl
  80140d:	74 da                	je     8013e9 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80140f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801413:	75 07                	jne    80141c <strncmp+0x38>
		return 0;
  801415:	b8 00 00 00 00       	mov    $0x0,%eax
  80141a:	eb 14                	jmp    801430 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80141c:	8b 45 08             	mov    0x8(%ebp),%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	0f b6 d0             	movzbl %al,%edx
  801424:	8b 45 0c             	mov    0xc(%ebp),%eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	0f b6 c0             	movzbl %al,%eax
  80142c:	29 c2                	sub    %eax,%edx
  80142e:	89 d0                	mov    %edx,%eax
}
  801430:	5d                   	pop    %ebp
  801431:	c3                   	ret    

00801432 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
  801435:	83 ec 04             	sub    $0x4,%esp
  801438:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80143e:	eb 12                	jmp    801452 <strchr+0x20>
		if (*s == c)
  801440:	8b 45 08             	mov    0x8(%ebp),%eax
  801443:	8a 00                	mov    (%eax),%al
  801445:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801448:	75 05                	jne    80144f <strchr+0x1d>
			return (char *) s;
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	eb 11                	jmp    801460 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80144f:	ff 45 08             	incl   0x8(%ebp)
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	8a 00                	mov    (%eax),%al
  801457:	84 c0                	test   %al,%al
  801459:	75 e5                	jne    801440 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80145b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801460:	c9                   	leave  
  801461:	c3                   	ret    

00801462 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801462:	55                   	push   %ebp
  801463:	89 e5                	mov    %esp,%ebp
  801465:	83 ec 04             	sub    $0x4,%esp
  801468:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80146e:	eb 0d                	jmp    80147d <strfind+0x1b>
		if (*s == c)
  801470:	8b 45 08             	mov    0x8(%ebp),%eax
  801473:	8a 00                	mov    (%eax),%al
  801475:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801478:	74 0e                	je     801488 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80147a:	ff 45 08             	incl   0x8(%ebp)
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	8a 00                	mov    (%eax),%al
  801482:	84 c0                	test   %al,%al
  801484:	75 ea                	jne    801470 <strfind+0xe>
  801486:	eb 01                	jmp    801489 <strfind+0x27>
		if (*s == c)
			break;
  801488:	90                   	nop
	return (char *) s;
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
  801491:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
  801497:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80149a:	8b 45 10             	mov    0x10(%ebp),%eax
  80149d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014a0:	eb 0e                	jmp    8014b0 <memset+0x22>
		*p++ = c;
  8014a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014a5:	8d 50 01             	lea    0x1(%eax),%edx
  8014a8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ae:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014b0:	ff 4d f8             	decl   -0x8(%ebp)
  8014b3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014b7:	79 e9                	jns    8014a2 <memset+0x14>
		*p++ = c;

	return v;
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014bc:	c9                   	leave  
  8014bd:	c3                   	ret    

008014be <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014be:	55                   	push   %ebp
  8014bf:	89 e5                	mov    %esp,%ebp
  8014c1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014d0:	eb 16                	jmp    8014e8 <memcpy+0x2a>
		*d++ = *s++;
  8014d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d5:	8d 50 01             	lea    0x1(%eax),%edx
  8014d8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014db:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014de:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014e1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014e4:	8a 12                	mov    (%edx),%dl
  8014e6:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014eb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ee:	89 55 10             	mov    %edx,0x10(%ebp)
  8014f1:	85 c0                	test   %eax,%eax
  8014f3:	75 dd                	jne    8014d2 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014f5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
  8014fd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801500:	8b 45 0c             	mov    0xc(%ebp),%eax
  801503:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801506:	8b 45 08             	mov    0x8(%ebp),%eax
  801509:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80150c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801512:	73 50                	jae    801564 <memmove+0x6a>
  801514:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801517:	8b 45 10             	mov    0x10(%ebp),%eax
  80151a:	01 d0                	add    %edx,%eax
  80151c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80151f:	76 43                	jbe    801564 <memmove+0x6a>
		s += n;
  801521:	8b 45 10             	mov    0x10(%ebp),%eax
  801524:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801527:	8b 45 10             	mov    0x10(%ebp),%eax
  80152a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80152d:	eb 10                	jmp    80153f <memmove+0x45>
			*--d = *--s;
  80152f:	ff 4d f8             	decl   -0x8(%ebp)
  801532:	ff 4d fc             	decl   -0x4(%ebp)
  801535:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801538:	8a 10                	mov    (%eax),%dl
  80153a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80153f:	8b 45 10             	mov    0x10(%ebp),%eax
  801542:	8d 50 ff             	lea    -0x1(%eax),%edx
  801545:	89 55 10             	mov    %edx,0x10(%ebp)
  801548:	85 c0                	test   %eax,%eax
  80154a:	75 e3                	jne    80152f <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80154c:	eb 23                	jmp    801571 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80154e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801551:	8d 50 01             	lea    0x1(%eax),%edx
  801554:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801557:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80155a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80155d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801560:	8a 12                	mov    (%edx),%dl
  801562:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801564:	8b 45 10             	mov    0x10(%ebp),%eax
  801567:	8d 50 ff             	lea    -0x1(%eax),%edx
  80156a:	89 55 10             	mov    %edx,0x10(%ebp)
  80156d:	85 c0                	test   %eax,%eax
  80156f:	75 dd                	jne    80154e <memmove+0x54>
			*d++ = *s++;

	return dst;
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801574:	c9                   	leave  
  801575:	c3                   	ret    

00801576 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801576:	55                   	push   %ebp
  801577:	89 e5                	mov    %esp,%ebp
  801579:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80157c:	8b 45 08             	mov    0x8(%ebp),%eax
  80157f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801582:	8b 45 0c             	mov    0xc(%ebp),%eax
  801585:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801588:	eb 2a                	jmp    8015b4 <memcmp+0x3e>
		if (*s1 != *s2)
  80158a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80158d:	8a 10                	mov    (%eax),%dl
  80158f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801592:	8a 00                	mov    (%eax),%al
  801594:	38 c2                	cmp    %al,%dl
  801596:	74 16                	je     8015ae <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801598:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80159b:	8a 00                	mov    (%eax),%al
  80159d:	0f b6 d0             	movzbl %al,%edx
  8015a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a3:	8a 00                	mov    (%eax),%al
  8015a5:	0f b6 c0             	movzbl %al,%eax
  8015a8:	29 c2                	sub    %eax,%edx
  8015aa:	89 d0                	mov    %edx,%eax
  8015ac:	eb 18                	jmp    8015c6 <memcmp+0x50>
		s1++, s2++;
  8015ae:	ff 45 fc             	incl   -0x4(%ebp)
  8015b1:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015ba:	89 55 10             	mov    %edx,0x10(%ebp)
  8015bd:	85 c0                	test   %eax,%eax
  8015bf:	75 c9                	jne    80158a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
  8015cb:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015ce:	8b 55 08             	mov    0x8(%ebp),%edx
  8015d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d4:	01 d0                	add    %edx,%eax
  8015d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015d9:	eb 15                	jmp    8015f0 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	8a 00                	mov    (%eax),%al
  8015e0:	0f b6 d0             	movzbl %al,%edx
  8015e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e6:	0f b6 c0             	movzbl %al,%eax
  8015e9:	39 c2                	cmp    %eax,%edx
  8015eb:	74 0d                	je     8015fa <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015ed:	ff 45 08             	incl   0x8(%ebp)
  8015f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015f6:	72 e3                	jb     8015db <memfind+0x13>
  8015f8:	eb 01                	jmp    8015fb <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015fa:	90                   	nop
	return (void *) s;
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015fe:	c9                   	leave  
  8015ff:	c3                   	ret    

00801600 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801600:	55                   	push   %ebp
  801601:	89 e5                	mov    %esp,%ebp
  801603:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801606:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80160d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801614:	eb 03                	jmp    801619 <strtol+0x19>
		s++;
  801616:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801619:	8b 45 08             	mov    0x8(%ebp),%eax
  80161c:	8a 00                	mov    (%eax),%al
  80161e:	3c 20                	cmp    $0x20,%al
  801620:	74 f4                	je     801616 <strtol+0x16>
  801622:	8b 45 08             	mov    0x8(%ebp),%eax
  801625:	8a 00                	mov    (%eax),%al
  801627:	3c 09                	cmp    $0x9,%al
  801629:	74 eb                	je     801616 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80162b:	8b 45 08             	mov    0x8(%ebp),%eax
  80162e:	8a 00                	mov    (%eax),%al
  801630:	3c 2b                	cmp    $0x2b,%al
  801632:	75 05                	jne    801639 <strtol+0x39>
		s++;
  801634:	ff 45 08             	incl   0x8(%ebp)
  801637:	eb 13                	jmp    80164c <strtol+0x4c>
	else if (*s == '-')
  801639:	8b 45 08             	mov    0x8(%ebp),%eax
  80163c:	8a 00                	mov    (%eax),%al
  80163e:	3c 2d                	cmp    $0x2d,%al
  801640:	75 0a                	jne    80164c <strtol+0x4c>
		s++, neg = 1;
  801642:	ff 45 08             	incl   0x8(%ebp)
  801645:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80164c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801650:	74 06                	je     801658 <strtol+0x58>
  801652:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801656:	75 20                	jne    801678 <strtol+0x78>
  801658:	8b 45 08             	mov    0x8(%ebp),%eax
  80165b:	8a 00                	mov    (%eax),%al
  80165d:	3c 30                	cmp    $0x30,%al
  80165f:	75 17                	jne    801678 <strtol+0x78>
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	40                   	inc    %eax
  801665:	8a 00                	mov    (%eax),%al
  801667:	3c 78                	cmp    $0x78,%al
  801669:	75 0d                	jne    801678 <strtol+0x78>
		s += 2, base = 16;
  80166b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80166f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801676:	eb 28                	jmp    8016a0 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801678:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80167c:	75 15                	jne    801693 <strtol+0x93>
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	8a 00                	mov    (%eax),%al
  801683:	3c 30                	cmp    $0x30,%al
  801685:	75 0c                	jne    801693 <strtol+0x93>
		s++, base = 8;
  801687:	ff 45 08             	incl   0x8(%ebp)
  80168a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801691:	eb 0d                	jmp    8016a0 <strtol+0xa0>
	else if (base == 0)
  801693:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801697:	75 07                	jne    8016a0 <strtol+0xa0>
		base = 10;
  801699:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	8a 00                	mov    (%eax),%al
  8016a5:	3c 2f                	cmp    $0x2f,%al
  8016a7:	7e 19                	jle    8016c2 <strtol+0xc2>
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	8a 00                	mov    (%eax),%al
  8016ae:	3c 39                	cmp    $0x39,%al
  8016b0:	7f 10                	jg     8016c2 <strtol+0xc2>
			dig = *s - '0';
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	0f be c0             	movsbl %al,%eax
  8016ba:	83 e8 30             	sub    $0x30,%eax
  8016bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016c0:	eb 42                	jmp    801704 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c5:	8a 00                	mov    (%eax),%al
  8016c7:	3c 60                	cmp    $0x60,%al
  8016c9:	7e 19                	jle    8016e4 <strtol+0xe4>
  8016cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ce:	8a 00                	mov    (%eax),%al
  8016d0:	3c 7a                	cmp    $0x7a,%al
  8016d2:	7f 10                	jg     8016e4 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	8a 00                	mov    (%eax),%al
  8016d9:	0f be c0             	movsbl %al,%eax
  8016dc:	83 e8 57             	sub    $0x57,%eax
  8016df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016e2:	eb 20                	jmp    801704 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	8a 00                	mov    (%eax),%al
  8016e9:	3c 40                	cmp    $0x40,%al
  8016eb:	7e 39                	jle    801726 <strtol+0x126>
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	8a 00                	mov    (%eax),%al
  8016f2:	3c 5a                	cmp    $0x5a,%al
  8016f4:	7f 30                	jg     801726 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	8a 00                	mov    (%eax),%al
  8016fb:	0f be c0             	movsbl %al,%eax
  8016fe:	83 e8 37             	sub    $0x37,%eax
  801701:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801704:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801707:	3b 45 10             	cmp    0x10(%ebp),%eax
  80170a:	7d 19                	jge    801725 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80170c:	ff 45 08             	incl   0x8(%ebp)
  80170f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801712:	0f af 45 10          	imul   0x10(%ebp),%eax
  801716:	89 c2                	mov    %eax,%edx
  801718:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80171b:	01 d0                	add    %edx,%eax
  80171d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801720:	e9 7b ff ff ff       	jmp    8016a0 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801725:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801726:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80172a:	74 08                	je     801734 <strtol+0x134>
		*endptr = (char *) s;
  80172c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172f:	8b 55 08             	mov    0x8(%ebp),%edx
  801732:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801734:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801738:	74 07                	je     801741 <strtol+0x141>
  80173a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80173d:	f7 d8                	neg    %eax
  80173f:	eb 03                	jmp    801744 <strtol+0x144>
  801741:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801744:	c9                   	leave  
  801745:	c3                   	ret    

00801746 <ltostr>:

void
ltostr(long value, char *str)
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
  801749:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80174c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801753:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80175a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80175e:	79 13                	jns    801773 <ltostr+0x2d>
	{
		neg = 1;
  801760:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801767:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80176d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801770:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
  801776:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80177b:	99                   	cltd   
  80177c:	f7 f9                	idiv   %ecx
  80177e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801781:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801784:	8d 50 01             	lea    0x1(%eax),%edx
  801787:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80178a:	89 c2                	mov    %eax,%edx
  80178c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178f:	01 d0                	add    %edx,%eax
  801791:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801794:	83 c2 30             	add    $0x30,%edx
  801797:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801799:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80179c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017a1:	f7 e9                	imul   %ecx
  8017a3:	c1 fa 02             	sar    $0x2,%edx
  8017a6:	89 c8                	mov    %ecx,%eax
  8017a8:	c1 f8 1f             	sar    $0x1f,%eax
  8017ab:	29 c2                	sub    %eax,%edx
  8017ad:	89 d0                	mov    %edx,%eax
  8017af:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017b2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017b5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017ba:	f7 e9                	imul   %ecx
  8017bc:	c1 fa 02             	sar    $0x2,%edx
  8017bf:	89 c8                	mov    %ecx,%eax
  8017c1:	c1 f8 1f             	sar    $0x1f,%eax
  8017c4:	29 c2                	sub    %eax,%edx
  8017c6:	89 d0                	mov    %edx,%eax
  8017c8:	c1 e0 02             	shl    $0x2,%eax
  8017cb:	01 d0                	add    %edx,%eax
  8017cd:	01 c0                	add    %eax,%eax
  8017cf:	29 c1                	sub    %eax,%ecx
  8017d1:	89 ca                	mov    %ecx,%edx
  8017d3:	85 d2                	test   %edx,%edx
  8017d5:	75 9c                	jne    801773 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017e1:	48                   	dec    %eax
  8017e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017e5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017e9:	74 3d                	je     801828 <ltostr+0xe2>
		start = 1 ;
  8017eb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017f2:	eb 34                	jmp    801828 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fa:	01 d0                	add    %edx,%eax
  8017fc:	8a 00                	mov    (%eax),%al
  8017fe:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801801:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801804:	8b 45 0c             	mov    0xc(%ebp),%eax
  801807:	01 c2                	add    %eax,%edx
  801809:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80180c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180f:	01 c8                	add    %ecx,%eax
  801811:	8a 00                	mov    (%eax),%al
  801813:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801815:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801818:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181b:	01 c2                	add    %eax,%edx
  80181d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801820:	88 02                	mov    %al,(%edx)
		start++ ;
  801822:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801825:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801828:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80182b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80182e:	7c c4                	jl     8017f4 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801830:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801833:	8b 45 0c             	mov    0xc(%ebp),%eax
  801836:	01 d0                	add    %edx,%eax
  801838:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80183b:	90                   	nop
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
  801841:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801844:	ff 75 08             	pushl  0x8(%ebp)
  801847:	e8 54 fa ff ff       	call   8012a0 <strlen>
  80184c:	83 c4 04             	add    $0x4,%esp
  80184f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801852:	ff 75 0c             	pushl  0xc(%ebp)
  801855:	e8 46 fa ff ff       	call   8012a0 <strlen>
  80185a:	83 c4 04             	add    $0x4,%esp
  80185d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801860:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801867:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80186e:	eb 17                	jmp    801887 <strcconcat+0x49>
		final[s] = str1[s] ;
  801870:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801873:	8b 45 10             	mov    0x10(%ebp),%eax
  801876:	01 c2                	add    %eax,%edx
  801878:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80187b:	8b 45 08             	mov    0x8(%ebp),%eax
  80187e:	01 c8                	add    %ecx,%eax
  801880:	8a 00                	mov    (%eax),%al
  801882:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801884:	ff 45 fc             	incl   -0x4(%ebp)
  801887:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80188a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80188d:	7c e1                	jl     801870 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80188f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801896:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80189d:	eb 1f                	jmp    8018be <strcconcat+0x80>
		final[s++] = str2[i] ;
  80189f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018a2:	8d 50 01             	lea    0x1(%eax),%edx
  8018a5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018a8:	89 c2                	mov    %eax,%edx
  8018aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ad:	01 c2                	add    %eax,%edx
  8018af:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b5:	01 c8                	add    %ecx,%eax
  8018b7:	8a 00                	mov    (%eax),%al
  8018b9:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018bb:	ff 45 f8             	incl   -0x8(%ebp)
  8018be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018c1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018c4:	7c d9                	jl     80189f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018c6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cc:	01 d0                	add    %edx,%eax
  8018ce:	c6 00 00             	movb   $0x0,(%eax)
}
  8018d1:	90                   	nop
  8018d2:	c9                   	leave  
  8018d3:	c3                   	ret    

008018d4 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018d4:	55                   	push   %ebp
  8018d5:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8018da:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e3:	8b 00                	mov    (%eax),%eax
  8018e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ef:	01 d0                	add    %edx,%eax
  8018f1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018f7:	eb 0c                	jmp    801905 <strsplit+0x31>
			*string++ = 0;
  8018f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fc:	8d 50 01             	lea    0x1(%eax),%edx
  8018ff:	89 55 08             	mov    %edx,0x8(%ebp)
  801902:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801905:	8b 45 08             	mov    0x8(%ebp),%eax
  801908:	8a 00                	mov    (%eax),%al
  80190a:	84 c0                	test   %al,%al
  80190c:	74 18                	je     801926 <strsplit+0x52>
  80190e:	8b 45 08             	mov    0x8(%ebp),%eax
  801911:	8a 00                	mov    (%eax),%al
  801913:	0f be c0             	movsbl %al,%eax
  801916:	50                   	push   %eax
  801917:	ff 75 0c             	pushl  0xc(%ebp)
  80191a:	e8 13 fb ff ff       	call   801432 <strchr>
  80191f:	83 c4 08             	add    $0x8,%esp
  801922:	85 c0                	test   %eax,%eax
  801924:	75 d3                	jne    8018f9 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801926:	8b 45 08             	mov    0x8(%ebp),%eax
  801929:	8a 00                	mov    (%eax),%al
  80192b:	84 c0                	test   %al,%al
  80192d:	74 5a                	je     801989 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80192f:	8b 45 14             	mov    0x14(%ebp),%eax
  801932:	8b 00                	mov    (%eax),%eax
  801934:	83 f8 0f             	cmp    $0xf,%eax
  801937:	75 07                	jne    801940 <strsplit+0x6c>
		{
			return 0;
  801939:	b8 00 00 00 00       	mov    $0x0,%eax
  80193e:	eb 66                	jmp    8019a6 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801940:	8b 45 14             	mov    0x14(%ebp),%eax
  801943:	8b 00                	mov    (%eax),%eax
  801945:	8d 48 01             	lea    0x1(%eax),%ecx
  801948:	8b 55 14             	mov    0x14(%ebp),%edx
  80194b:	89 0a                	mov    %ecx,(%edx)
  80194d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801954:	8b 45 10             	mov    0x10(%ebp),%eax
  801957:	01 c2                	add    %eax,%edx
  801959:	8b 45 08             	mov    0x8(%ebp),%eax
  80195c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80195e:	eb 03                	jmp    801963 <strsplit+0x8f>
			string++;
  801960:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	8a 00                	mov    (%eax),%al
  801968:	84 c0                	test   %al,%al
  80196a:	74 8b                	je     8018f7 <strsplit+0x23>
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	8a 00                	mov    (%eax),%al
  801971:	0f be c0             	movsbl %al,%eax
  801974:	50                   	push   %eax
  801975:	ff 75 0c             	pushl  0xc(%ebp)
  801978:	e8 b5 fa ff ff       	call   801432 <strchr>
  80197d:	83 c4 08             	add    $0x8,%esp
  801980:	85 c0                	test   %eax,%eax
  801982:	74 dc                	je     801960 <strsplit+0x8c>
			string++;
	}
  801984:	e9 6e ff ff ff       	jmp    8018f7 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801989:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80198a:	8b 45 14             	mov    0x14(%ebp),%eax
  80198d:	8b 00                	mov    (%eax),%eax
  80198f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801996:	8b 45 10             	mov    0x10(%ebp),%eax
  801999:	01 d0                	add    %edx,%eax
  80199b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019a1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
  8019ab:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8019ae:	83 ec 04             	sub    $0x4,%esp
  8019b1:	68 04 2a 80 00       	push   $0x802a04
  8019b6:	6a 19                	push   $0x19
  8019b8:	68 29 2a 80 00       	push   $0x802a29
  8019bd:	e8 a2 ed ff ff       	call   800764 <_panic>

008019c2 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019c2:	55                   	push   %ebp
  8019c3:	89 e5                	mov    %esp,%ebp
  8019c5:	83 ec 18             	sub    $0x18,%esp
  8019c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8019cb:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8019ce:	83 ec 04             	sub    $0x4,%esp
  8019d1:	68 38 2a 80 00       	push   $0x802a38
  8019d6:	6a 30                	push   $0x30
  8019d8:	68 29 2a 80 00       	push   $0x802a29
  8019dd:	e8 82 ed ff ff       	call   800764 <_panic>

008019e2 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8019e2:	55                   	push   %ebp
  8019e3:	89 e5                	mov    %esp,%ebp
  8019e5:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8019e8:	83 ec 04             	sub    $0x4,%esp
  8019eb:	68 57 2a 80 00       	push   $0x802a57
  8019f0:	6a 36                	push   $0x36
  8019f2:	68 29 2a 80 00       	push   $0x802a29
  8019f7:	e8 68 ed ff ff       	call   800764 <_panic>

008019fc <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
  8019ff:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801a02:	83 ec 04             	sub    $0x4,%esp
  801a05:	68 74 2a 80 00       	push   $0x802a74
  801a0a:	6a 48                	push   $0x48
  801a0c:	68 29 2a 80 00       	push   $0x802a29
  801a11:	e8 4e ed ff ff       	call   800764 <_panic>

00801a16 <sfree>:

}


void sfree(void* virtual_address)
{
  801a16:	55                   	push   %ebp
  801a17:	89 e5                	mov    %esp,%ebp
  801a19:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801a1c:	83 ec 04             	sub    $0x4,%esp
  801a1f:	68 97 2a 80 00       	push   $0x802a97
  801a24:	6a 53                	push   $0x53
  801a26:	68 29 2a 80 00       	push   $0x802a29
  801a2b:	e8 34 ed ff ff       	call   800764 <_panic>

00801a30 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801a30:	55                   	push   %ebp
  801a31:	89 e5                	mov    %esp,%ebp
  801a33:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801a36:	83 ec 04             	sub    $0x4,%esp
  801a39:	68 b4 2a 80 00       	push   $0x802ab4
  801a3e:	6a 6c                	push   $0x6c
  801a40:	68 29 2a 80 00       	push   $0x802a29
  801a45:	e8 1a ed ff ff       	call   800764 <_panic>

00801a4a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a4a:	55                   	push   %ebp
  801a4b:	89 e5                	mov    %esp,%ebp
  801a4d:	57                   	push   %edi
  801a4e:	56                   	push   %esi
  801a4f:	53                   	push   %ebx
  801a50:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a53:	8b 45 08             	mov    0x8(%ebp),%eax
  801a56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a59:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a5c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a5f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a62:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a65:	cd 30                	int    $0x30
  801a67:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a6d:	83 c4 10             	add    $0x10,%esp
  801a70:	5b                   	pop    %ebx
  801a71:	5e                   	pop    %esi
  801a72:	5f                   	pop    %edi
  801a73:	5d                   	pop    %ebp
  801a74:	c3                   	ret    

00801a75 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a75:	55                   	push   %ebp
  801a76:	89 e5                	mov    %esp,%ebp
  801a78:	83 ec 04             	sub    $0x4,%esp
  801a7b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a81:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a85:	8b 45 08             	mov    0x8(%ebp),%eax
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	52                   	push   %edx
  801a8d:	ff 75 0c             	pushl  0xc(%ebp)
  801a90:	50                   	push   %eax
  801a91:	6a 00                	push   $0x0
  801a93:	e8 b2 ff ff ff       	call   801a4a <syscall>
  801a98:	83 c4 18             	add    $0x18,%esp
}
  801a9b:	90                   	nop
  801a9c:	c9                   	leave  
  801a9d:	c3                   	ret    

00801a9e <sys_cgetc>:

int
sys_cgetc(void)
{
  801a9e:	55                   	push   %ebp
  801a9f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 01                	push   $0x1
  801aad:	e8 98 ff ff ff       	call   801a4a <syscall>
  801ab2:	83 c4 18             	add    $0x18,%esp
}
  801ab5:	c9                   	leave  
  801ab6:	c3                   	ret    

00801ab7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ab7:	55                   	push   %ebp
  801ab8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801aba:	8b 45 08             	mov    0x8(%ebp),%eax
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	50                   	push   %eax
  801ac6:	6a 05                	push   $0x5
  801ac8:	e8 7d ff ff ff       	call   801a4a <syscall>
  801acd:	83 c4 18             	add    $0x18,%esp
}
  801ad0:	c9                   	leave  
  801ad1:	c3                   	ret    

00801ad2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ad2:	55                   	push   %ebp
  801ad3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 02                	push   $0x2
  801ae1:	e8 64 ff ff ff       	call   801a4a <syscall>
  801ae6:	83 c4 18             	add    $0x18,%esp
}
  801ae9:	c9                   	leave  
  801aea:	c3                   	ret    

00801aeb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801aeb:	55                   	push   %ebp
  801aec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 03                	push   $0x3
  801afa:	e8 4b ff ff ff       	call   801a4a <syscall>
  801aff:	83 c4 18             	add    $0x18,%esp
}
  801b02:	c9                   	leave  
  801b03:	c3                   	ret    

00801b04 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b04:	55                   	push   %ebp
  801b05:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 04                	push   $0x4
  801b13:	e8 32 ff ff ff       	call   801a4a <syscall>
  801b18:	83 c4 18             	add    $0x18,%esp
}
  801b1b:	c9                   	leave  
  801b1c:	c3                   	ret    

00801b1d <sys_env_exit>:


void sys_env_exit(void)
{
  801b1d:	55                   	push   %ebp
  801b1e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 06                	push   $0x6
  801b2c:	e8 19 ff ff ff       	call   801a4a <syscall>
  801b31:	83 c4 18             	add    $0x18,%esp
}
  801b34:	90                   	nop
  801b35:	c9                   	leave  
  801b36:	c3                   	ret    

00801b37 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b37:	55                   	push   %ebp
  801b38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	52                   	push   %edx
  801b47:	50                   	push   %eax
  801b48:	6a 07                	push   $0x7
  801b4a:	e8 fb fe ff ff       	call   801a4a <syscall>
  801b4f:	83 c4 18             	add    $0x18,%esp
}
  801b52:	c9                   	leave  
  801b53:	c3                   	ret    

00801b54 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b54:	55                   	push   %ebp
  801b55:	89 e5                	mov    %esp,%ebp
  801b57:	56                   	push   %esi
  801b58:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b59:	8b 75 18             	mov    0x18(%ebp),%esi
  801b5c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b5f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b62:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b65:	8b 45 08             	mov    0x8(%ebp),%eax
  801b68:	56                   	push   %esi
  801b69:	53                   	push   %ebx
  801b6a:	51                   	push   %ecx
  801b6b:	52                   	push   %edx
  801b6c:	50                   	push   %eax
  801b6d:	6a 08                	push   $0x8
  801b6f:	e8 d6 fe ff ff       	call   801a4a <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b7a:	5b                   	pop    %ebx
  801b7b:	5e                   	pop    %esi
  801b7c:	5d                   	pop    %ebp
  801b7d:	c3                   	ret    

00801b7e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b7e:	55                   	push   %ebp
  801b7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b81:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b84:	8b 45 08             	mov    0x8(%ebp),%eax
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	52                   	push   %edx
  801b8e:	50                   	push   %eax
  801b8f:	6a 09                	push   $0x9
  801b91:	e8 b4 fe ff ff       	call   801a4a <syscall>
  801b96:	83 c4 18             	add    $0x18,%esp
}
  801b99:	c9                   	leave  
  801b9a:	c3                   	ret    

00801b9b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b9b:	55                   	push   %ebp
  801b9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	ff 75 0c             	pushl  0xc(%ebp)
  801ba7:	ff 75 08             	pushl  0x8(%ebp)
  801baa:	6a 0a                	push   $0xa
  801bac:	e8 99 fe ff ff       	call   801a4a <syscall>
  801bb1:	83 c4 18             	add    $0x18,%esp
}
  801bb4:	c9                   	leave  
  801bb5:	c3                   	ret    

00801bb6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801bb6:	55                   	push   %ebp
  801bb7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 0b                	push   $0xb
  801bc5:	e8 80 fe ff ff       	call   801a4a <syscall>
  801bca:	83 c4 18             	add    $0x18,%esp
}
  801bcd:	c9                   	leave  
  801bce:	c3                   	ret    

00801bcf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801bcf:	55                   	push   %ebp
  801bd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 0c                	push   $0xc
  801bde:	e8 67 fe ff ff       	call   801a4a <syscall>
  801be3:	83 c4 18             	add    $0x18,%esp
}
  801be6:	c9                   	leave  
  801be7:	c3                   	ret    

00801be8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801be8:	55                   	push   %ebp
  801be9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 0d                	push   $0xd
  801bf7:	e8 4e fe ff ff       	call   801a4a <syscall>
  801bfc:	83 c4 18             	add    $0x18,%esp
}
  801bff:	c9                   	leave  
  801c00:	c3                   	ret    

00801c01 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c01:	55                   	push   %ebp
  801c02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	ff 75 0c             	pushl  0xc(%ebp)
  801c0d:	ff 75 08             	pushl  0x8(%ebp)
  801c10:	6a 11                	push   $0x11
  801c12:	e8 33 fe ff ff       	call   801a4a <syscall>
  801c17:	83 c4 18             	add    $0x18,%esp
	return;
  801c1a:	90                   	nop
}
  801c1b:	c9                   	leave  
  801c1c:	c3                   	ret    

00801c1d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c1d:	55                   	push   %ebp
  801c1e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	6a 00                	push   $0x0
  801c26:	ff 75 0c             	pushl  0xc(%ebp)
  801c29:	ff 75 08             	pushl  0x8(%ebp)
  801c2c:	6a 12                	push   $0x12
  801c2e:	e8 17 fe ff ff       	call   801a4a <syscall>
  801c33:	83 c4 18             	add    $0x18,%esp
	return ;
  801c36:	90                   	nop
}
  801c37:	c9                   	leave  
  801c38:	c3                   	ret    

00801c39 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c39:	55                   	push   %ebp
  801c3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 0e                	push   $0xe
  801c48:	e8 fd fd ff ff       	call   801a4a <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
}
  801c50:	c9                   	leave  
  801c51:	c3                   	ret    

00801c52 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c52:	55                   	push   %ebp
  801c53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	ff 75 08             	pushl  0x8(%ebp)
  801c60:	6a 0f                	push   $0xf
  801c62:	e8 e3 fd ff ff       	call   801a4a <syscall>
  801c67:	83 c4 18             	add    $0x18,%esp
}
  801c6a:	c9                   	leave  
  801c6b:	c3                   	ret    

00801c6c <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c6c:	55                   	push   %ebp
  801c6d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 10                	push   $0x10
  801c7b:	e8 ca fd ff ff       	call   801a4a <syscall>
  801c80:	83 c4 18             	add    $0x18,%esp
}
  801c83:	90                   	nop
  801c84:	c9                   	leave  
  801c85:	c3                   	ret    

00801c86 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c86:	55                   	push   %ebp
  801c87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 14                	push   $0x14
  801c95:	e8 b0 fd ff ff       	call   801a4a <syscall>
  801c9a:	83 c4 18             	add    $0x18,%esp
}
  801c9d:	90                   	nop
  801c9e:	c9                   	leave  
  801c9f:	c3                   	ret    

00801ca0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ca0:	55                   	push   %ebp
  801ca1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 15                	push   $0x15
  801caf:	e8 96 fd ff ff       	call   801a4a <syscall>
  801cb4:	83 c4 18             	add    $0x18,%esp
}
  801cb7:	90                   	nop
  801cb8:	c9                   	leave  
  801cb9:	c3                   	ret    

00801cba <sys_cputc>:


void
sys_cputc(const char c)
{
  801cba:	55                   	push   %ebp
  801cbb:	89 e5                	mov    %esp,%ebp
  801cbd:	83 ec 04             	sub    $0x4,%esp
  801cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801cc6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	50                   	push   %eax
  801cd3:	6a 16                	push   $0x16
  801cd5:	e8 70 fd ff ff       	call   801a4a <syscall>
  801cda:	83 c4 18             	add    $0x18,%esp
}
  801cdd:	90                   	nop
  801cde:	c9                   	leave  
  801cdf:	c3                   	ret    

00801ce0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ce0:	55                   	push   %ebp
  801ce1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 17                	push   $0x17
  801cef:	e8 56 fd ff ff       	call   801a4a <syscall>
  801cf4:	83 c4 18             	add    $0x18,%esp
}
  801cf7:	90                   	nop
  801cf8:	c9                   	leave  
  801cf9:	c3                   	ret    

00801cfa <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cfa:	55                   	push   %ebp
  801cfb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	ff 75 0c             	pushl  0xc(%ebp)
  801d09:	50                   	push   %eax
  801d0a:	6a 18                	push   $0x18
  801d0c:	e8 39 fd ff ff       	call   801a4a <syscall>
  801d11:	83 c4 18             	add    $0x18,%esp
}
  801d14:	c9                   	leave  
  801d15:	c3                   	ret    

00801d16 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d16:	55                   	push   %ebp
  801d17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d19:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	52                   	push   %edx
  801d26:	50                   	push   %eax
  801d27:	6a 1b                	push   $0x1b
  801d29:	e8 1c fd ff ff       	call   801a4a <syscall>
  801d2e:	83 c4 18             	add    $0x18,%esp
}
  801d31:	c9                   	leave  
  801d32:	c3                   	ret    

00801d33 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d33:	55                   	push   %ebp
  801d34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d36:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d39:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	52                   	push   %edx
  801d43:	50                   	push   %eax
  801d44:	6a 19                	push   $0x19
  801d46:	e8 ff fc ff ff       	call   801a4a <syscall>
  801d4b:	83 c4 18             	add    $0x18,%esp
}
  801d4e:	90                   	nop
  801d4f:	c9                   	leave  
  801d50:	c3                   	ret    

00801d51 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d57:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	52                   	push   %edx
  801d61:	50                   	push   %eax
  801d62:	6a 1a                	push   $0x1a
  801d64:	e8 e1 fc ff ff       	call   801a4a <syscall>
  801d69:	83 c4 18             	add    $0x18,%esp
}
  801d6c:	90                   	nop
  801d6d:	c9                   	leave  
  801d6e:	c3                   	ret    

00801d6f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d6f:	55                   	push   %ebp
  801d70:	89 e5                	mov    %esp,%ebp
  801d72:	83 ec 04             	sub    $0x4,%esp
  801d75:	8b 45 10             	mov    0x10(%ebp),%eax
  801d78:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d7b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d7e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d82:	8b 45 08             	mov    0x8(%ebp),%eax
  801d85:	6a 00                	push   $0x0
  801d87:	51                   	push   %ecx
  801d88:	52                   	push   %edx
  801d89:	ff 75 0c             	pushl  0xc(%ebp)
  801d8c:	50                   	push   %eax
  801d8d:	6a 1c                	push   $0x1c
  801d8f:	e8 b6 fc ff ff       	call   801a4a <syscall>
  801d94:	83 c4 18             	add    $0x18,%esp
}
  801d97:	c9                   	leave  
  801d98:	c3                   	ret    

00801d99 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d99:	55                   	push   %ebp
  801d9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	52                   	push   %edx
  801da9:	50                   	push   %eax
  801daa:	6a 1d                	push   $0x1d
  801dac:	e8 99 fc ff ff       	call   801a4a <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
}
  801db4:	c9                   	leave  
  801db5:	c3                   	ret    

00801db6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801db9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dbc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	51                   	push   %ecx
  801dc7:	52                   	push   %edx
  801dc8:	50                   	push   %eax
  801dc9:	6a 1e                	push   $0x1e
  801dcb:	e8 7a fc ff ff       	call   801a4a <syscall>
  801dd0:	83 c4 18             	add    $0x18,%esp
}
  801dd3:	c9                   	leave  
  801dd4:	c3                   	ret    

00801dd5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801dd5:	55                   	push   %ebp
  801dd6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801dd8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	52                   	push   %edx
  801de5:	50                   	push   %eax
  801de6:	6a 1f                	push   $0x1f
  801de8:	e8 5d fc ff ff       	call   801a4a <syscall>
  801ded:	83 c4 18             	add    $0x18,%esp
}
  801df0:	c9                   	leave  
  801df1:	c3                   	ret    

00801df2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801df2:	55                   	push   %ebp
  801df3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 20                	push   $0x20
  801e01:	e8 44 fc ff ff       	call   801a4a <syscall>
  801e06:	83 c4 18             	add    $0x18,%esp
}
  801e09:	c9                   	leave  
  801e0a:	c3                   	ret    

00801e0b <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801e0b:	55                   	push   %ebp
  801e0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	ff 75 10             	pushl  0x10(%ebp)
  801e18:	ff 75 0c             	pushl  0xc(%ebp)
  801e1b:	50                   	push   %eax
  801e1c:	6a 21                	push   $0x21
  801e1e:	e8 27 fc ff ff       	call   801a4a <syscall>
  801e23:	83 c4 18             	add    $0x18,%esp
}
  801e26:	c9                   	leave  
  801e27:	c3                   	ret    

00801e28 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e28:	55                   	push   %ebp
  801e29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	50                   	push   %eax
  801e37:	6a 22                	push   $0x22
  801e39:	e8 0c fc ff ff       	call   801a4a <syscall>
  801e3e:	83 c4 18             	add    $0x18,%esp
}
  801e41:	90                   	nop
  801e42:	c9                   	leave  
  801e43:	c3                   	ret    

00801e44 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e44:	55                   	push   %ebp
  801e45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e47:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	50                   	push   %eax
  801e53:	6a 23                	push   $0x23
  801e55:	e8 f0 fb ff ff       	call   801a4a <syscall>
  801e5a:	83 c4 18             	add    $0x18,%esp
}
  801e5d:	90                   	nop
  801e5e:	c9                   	leave  
  801e5f:	c3                   	ret    

00801e60 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e60:	55                   	push   %ebp
  801e61:	89 e5                	mov    %esp,%ebp
  801e63:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e66:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e69:	8d 50 04             	lea    0x4(%eax),%edx
  801e6c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 00                	push   $0x0
  801e75:	52                   	push   %edx
  801e76:	50                   	push   %eax
  801e77:	6a 24                	push   $0x24
  801e79:	e8 cc fb ff ff       	call   801a4a <syscall>
  801e7e:	83 c4 18             	add    $0x18,%esp
	return result;
  801e81:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e84:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e87:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e8a:	89 01                	mov    %eax,(%ecx)
  801e8c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e92:	c9                   	leave  
  801e93:	c2 04 00             	ret    $0x4

00801e96 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e96:	55                   	push   %ebp
  801e97:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	ff 75 10             	pushl  0x10(%ebp)
  801ea0:	ff 75 0c             	pushl  0xc(%ebp)
  801ea3:	ff 75 08             	pushl  0x8(%ebp)
  801ea6:	6a 13                	push   $0x13
  801ea8:	e8 9d fb ff ff       	call   801a4a <syscall>
  801ead:	83 c4 18             	add    $0x18,%esp
	return ;
  801eb0:	90                   	nop
}
  801eb1:	c9                   	leave  
  801eb2:	c3                   	ret    

00801eb3 <sys_rcr2>:
uint32 sys_rcr2()
{
  801eb3:	55                   	push   %ebp
  801eb4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 25                	push   $0x25
  801ec2:	e8 83 fb ff ff       	call   801a4a <syscall>
  801ec7:	83 c4 18             	add    $0x18,%esp
}
  801eca:	c9                   	leave  
  801ecb:	c3                   	ret    

00801ecc <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ecc:	55                   	push   %ebp
  801ecd:	89 e5                	mov    %esp,%ebp
  801ecf:	83 ec 04             	sub    $0x4,%esp
  801ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ed8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801edc:	6a 00                	push   $0x0
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	50                   	push   %eax
  801ee5:	6a 26                	push   $0x26
  801ee7:	e8 5e fb ff ff       	call   801a4a <syscall>
  801eec:	83 c4 18             	add    $0x18,%esp
	return ;
  801eef:	90                   	nop
}
  801ef0:	c9                   	leave  
  801ef1:	c3                   	ret    

00801ef2 <rsttst>:
void rsttst()
{
  801ef2:	55                   	push   %ebp
  801ef3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 28                	push   $0x28
  801f01:	e8 44 fb ff ff       	call   801a4a <syscall>
  801f06:	83 c4 18             	add    $0x18,%esp
	return ;
  801f09:	90                   	nop
}
  801f0a:	c9                   	leave  
  801f0b:	c3                   	ret    

00801f0c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f0c:	55                   	push   %ebp
  801f0d:	89 e5                	mov    %esp,%ebp
  801f0f:	83 ec 04             	sub    $0x4,%esp
  801f12:	8b 45 14             	mov    0x14(%ebp),%eax
  801f15:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f18:	8b 55 18             	mov    0x18(%ebp),%edx
  801f1b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f1f:	52                   	push   %edx
  801f20:	50                   	push   %eax
  801f21:	ff 75 10             	pushl  0x10(%ebp)
  801f24:	ff 75 0c             	pushl  0xc(%ebp)
  801f27:	ff 75 08             	pushl  0x8(%ebp)
  801f2a:	6a 27                	push   $0x27
  801f2c:	e8 19 fb ff ff       	call   801a4a <syscall>
  801f31:	83 c4 18             	add    $0x18,%esp
	return ;
  801f34:	90                   	nop
}
  801f35:	c9                   	leave  
  801f36:	c3                   	ret    

00801f37 <chktst>:
void chktst(uint32 n)
{
  801f37:	55                   	push   %ebp
  801f38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	6a 00                	push   $0x0
  801f42:	ff 75 08             	pushl  0x8(%ebp)
  801f45:	6a 29                	push   $0x29
  801f47:	e8 fe fa ff ff       	call   801a4a <syscall>
  801f4c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f4f:	90                   	nop
}
  801f50:	c9                   	leave  
  801f51:	c3                   	ret    

00801f52 <inctst>:

void inctst()
{
  801f52:	55                   	push   %ebp
  801f53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 2a                	push   $0x2a
  801f61:	e8 e4 fa ff ff       	call   801a4a <syscall>
  801f66:	83 c4 18             	add    $0x18,%esp
	return ;
  801f69:	90                   	nop
}
  801f6a:	c9                   	leave  
  801f6b:	c3                   	ret    

00801f6c <gettst>:
uint32 gettst()
{
  801f6c:	55                   	push   %ebp
  801f6d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 00                	push   $0x0
  801f73:	6a 00                	push   $0x0
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 2b                	push   $0x2b
  801f7b:	e8 ca fa ff ff       	call   801a4a <syscall>
  801f80:	83 c4 18             	add    $0x18,%esp
}
  801f83:	c9                   	leave  
  801f84:	c3                   	ret    

00801f85 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f85:	55                   	push   %ebp
  801f86:	89 e5                	mov    %esp,%ebp
  801f88:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 2c                	push   $0x2c
  801f97:	e8 ae fa ff ff       	call   801a4a <syscall>
  801f9c:	83 c4 18             	add    $0x18,%esp
  801f9f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801fa2:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801fa6:	75 07                	jne    801faf <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801fa8:	b8 01 00 00 00       	mov    $0x1,%eax
  801fad:	eb 05                	jmp    801fb4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801faf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fb4:	c9                   	leave  
  801fb5:	c3                   	ret    

00801fb6 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801fb6:	55                   	push   %ebp
  801fb7:	89 e5                	mov    %esp,%ebp
  801fb9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 2c                	push   $0x2c
  801fc8:	e8 7d fa ff ff       	call   801a4a <syscall>
  801fcd:	83 c4 18             	add    $0x18,%esp
  801fd0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801fd3:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801fd7:	75 07                	jne    801fe0 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801fd9:	b8 01 00 00 00       	mov    $0x1,%eax
  801fde:	eb 05                	jmp    801fe5 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801fe0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fe5:	c9                   	leave  
  801fe6:	c3                   	ret    

00801fe7 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801fe7:	55                   	push   %ebp
  801fe8:	89 e5                	mov    %esp,%ebp
  801fea:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 2c                	push   $0x2c
  801ff9:	e8 4c fa ff ff       	call   801a4a <syscall>
  801ffe:	83 c4 18             	add    $0x18,%esp
  802001:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802004:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802008:	75 07                	jne    802011 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80200a:	b8 01 00 00 00       	mov    $0x1,%eax
  80200f:	eb 05                	jmp    802016 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802011:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802016:	c9                   	leave  
  802017:	c3                   	ret    

00802018 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802018:	55                   	push   %ebp
  802019:	89 e5                	mov    %esp,%ebp
  80201b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 2c                	push   $0x2c
  80202a:	e8 1b fa ff ff       	call   801a4a <syscall>
  80202f:	83 c4 18             	add    $0x18,%esp
  802032:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802035:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802039:	75 07                	jne    802042 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80203b:	b8 01 00 00 00       	mov    $0x1,%eax
  802040:	eb 05                	jmp    802047 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802042:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802047:	c9                   	leave  
  802048:	c3                   	ret    

00802049 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802049:	55                   	push   %ebp
  80204a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	6a 00                	push   $0x0
  802054:	ff 75 08             	pushl  0x8(%ebp)
  802057:	6a 2d                	push   $0x2d
  802059:	e8 ec f9 ff ff       	call   801a4a <syscall>
  80205e:	83 c4 18             	add    $0x18,%esp
	return ;
  802061:	90                   	nop
}
  802062:	c9                   	leave  
  802063:	c3                   	ret    

00802064 <__udivdi3>:
  802064:	55                   	push   %ebp
  802065:	57                   	push   %edi
  802066:	56                   	push   %esi
  802067:	53                   	push   %ebx
  802068:	83 ec 1c             	sub    $0x1c,%esp
  80206b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80206f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802073:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802077:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80207b:	89 ca                	mov    %ecx,%edx
  80207d:	89 f8                	mov    %edi,%eax
  80207f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802083:	85 f6                	test   %esi,%esi
  802085:	75 2d                	jne    8020b4 <__udivdi3+0x50>
  802087:	39 cf                	cmp    %ecx,%edi
  802089:	77 65                	ja     8020f0 <__udivdi3+0x8c>
  80208b:	89 fd                	mov    %edi,%ebp
  80208d:	85 ff                	test   %edi,%edi
  80208f:	75 0b                	jne    80209c <__udivdi3+0x38>
  802091:	b8 01 00 00 00       	mov    $0x1,%eax
  802096:	31 d2                	xor    %edx,%edx
  802098:	f7 f7                	div    %edi
  80209a:	89 c5                	mov    %eax,%ebp
  80209c:	31 d2                	xor    %edx,%edx
  80209e:	89 c8                	mov    %ecx,%eax
  8020a0:	f7 f5                	div    %ebp
  8020a2:	89 c1                	mov    %eax,%ecx
  8020a4:	89 d8                	mov    %ebx,%eax
  8020a6:	f7 f5                	div    %ebp
  8020a8:	89 cf                	mov    %ecx,%edi
  8020aa:	89 fa                	mov    %edi,%edx
  8020ac:	83 c4 1c             	add    $0x1c,%esp
  8020af:	5b                   	pop    %ebx
  8020b0:	5e                   	pop    %esi
  8020b1:	5f                   	pop    %edi
  8020b2:	5d                   	pop    %ebp
  8020b3:	c3                   	ret    
  8020b4:	39 ce                	cmp    %ecx,%esi
  8020b6:	77 28                	ja     8020e0 <__udivdi3+0x7c>
  8020b8:	0f bd fe             	bsr    %esi,%edi
  8020bb:	83 f7 1f             	xor    $0x1f,%edi
  8020be:	75 40                	jne    802100 <__udivdi3+0x9c>
  8020c0:	39 ce                	cmp    %ecx,%esi
  8020c2:	72 0a                	jb     8020ce <__udivdi3+0x6a>
  8020c4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020c8:	0f 87 9e 00 00 00    	ja     80216c <__udivdi3+0x108>
  8020ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8020d3:	89 fa                	mov    %edi,%edx
  8020d5:	83 c4 1c             	add    $0x1c,%esp
  8020d8:	5b                   	pop    %ebx
  8020d9:	5e                   	pop    %esi
  8020da:	5f                   	pop    %edi
  8020db:	5d                   	pop    %ebp
  8020dc:	c3                   	ret    
  8020dd:	8d 76 00             	lea    0x0(%esi),%esi
  8020e0:	31 ff                	xor    %edi,%edi
  8020e2:	31 c0                	xor    %eax,%eax
  8020e4:	89 fa                	mov    %edi,%edx
  8020e6:	83 c4 1c             	add    $0x1c,%esp
  8020e9:	5b                   	pop    %ebx
  8020ea:	5e                   	pop    %esi
  8020eb:	5f                   	pop    %edi
  8020ec:	5d                   	pop    %ebp
  8020ed:	c3                   	ret    
  8020ee:	66 90                	xchg   %ax,%ax
  8020f0:	89 d8                	mov    %ebx,%eax
  8020f2:	f7 f7                	div    %edi
  8020f4:	31 ff                	xor    %edi,%edi
  8020f6:	89 fa                	mov    %edi,%edx
  8020f8:	83 c4 1c             	add    $0x1c,%esp
  8020fb:	5b                   	pop    %ebx
  8020fc:	5e                   	pop    %esi
  8020fd:	5f                   	pop    %edi
  8020fe:	5d                   	pop    %ebp
  8020ff:	c3                   	ret    
  802100:	bd 20 00 00 00       	mov    $0x20,%ebp
  802105:	89 eb                	mov    %ebp,%ebx
  802107:	29 fb                	sub    %edi,%ebx
  802109:	89 f9                	mov    %edi,%ecx
  80210b:	d3 e6                	shl    %cl,%esi
  80210d:	89 c5                	mov    %eax,%ebp
  80210f:	88 d9                	mov    %bl,%cl
  802111:	d3 ed                	shr    %cl,%ebp
  802113:	89 e9                	mov    %ebp,%ecx
  802115:	09 f1                	or     %esi,%ecx
  802117:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80211b:	89 f9                	mov    %edi,%ecx
  80211d:	d3 e0                	shl    %cl,%eax
  80211f:	89 c5                	mov    %eax,%ebp
  802121:	89 d6                	mov    %edx,%esi
  802123:	88 d9                	mov    %bl,%cl
  802125:	d3 ee                	shr    %cl,%esi
  802127:	89 f9                	mov    %edi,%ecx
  802129:	d3 e2                	shl    %cl,%edx
  80212b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80212f:	88 d9                	mov    %bl,%cl
  802131:	d3 e8                	shr    %cl,%eax
  802133:	09 c2                	or     %eax,%edx
  802135:	89 d0                	mov    %edx,%eax
  802137:	89 f2                	mov    %esi,%edx
  802139:	f7 74 24 0c          	divl   0xc(%esp)
  80213d:	89 d6                	mov    %edx,%esi
  80213f:	89 c3                	mov    %eax,%ebx
  802141:	f7 e5                	mul    %ebp
  802143:	39 d6                	cmp    %edx,%esi
  802145:	72 19                	jb     802160 <__udivdi3+0xfc>
  802147:	74 0b                	je     802154 <__udivdi3+0xf0>
  802149:	89 d8                	mov    %ebx,%eax
  80214b:	31 ff                	xor    %edi,%edi
  80214d:	e9 58 ff ff ff       	jmp    8020aa <__udivdi3+0x46>
  802152:	66 90                	xchg   %ax,%ax
  802154:	8b 54 24 08          	mov    0x8(%esp),%edx
  802158:	89 f9                	mov    %edi,%ecx
  80215a:	d3 e2                	shl    %cl,%edx
  80215c:	39 c2                	cmp    %eax,%edx
  80215e:	73 e9                	jae    802149 <__udivdi3+0xe5>
  802160:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802163:	31 ff                	xor    %edi,%edi
  802165:	e9 40 ff ff ff       	jmp    8020aa <__udivdi3+0x46>
  80216a:	66 90                	xchg   %ax,%ax
  80216c:	31 c0                	xor    %eax,%eax
  80216e:	e9 37 ff ff ff       	jmp    8020aa <__udivdi3+0x46>
  802173:	90                   	nop

00802174 <__umoddi3>:
  802174:	55                   	push   %ebp
  802175:	57                   	push   %edi
  802176:	56                   	push   %esi
  802177:	53                   	push   %ebx
  802178:	83 ec 1c             	sub    $0x1c,%esp
  80217b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80217f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802183:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802187:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80218b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80218f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802193:	89 f3                	mov    %esi,%ebx
  802195:	89 fa                	mov    %edi,%edx
  802197:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80219b:	89 34 24             	mov    %esi,(%esp)
  80219e:	85 c0                	test   %eax,%eax
  8021a0:	75 1a                	jne    8021bc <__umoddi3+0x48>
  8021a2:	39 f7                	cmp    %esi,%edi
  8021a4:	0f 86 a2 00 00 00    	jbe    80224c <__umoddi3+0xd8>
  8021aa:	89 c8                	mov    %ecx,%eax
  8021ac:	89 f2                	mov    %esi,%edx
  8021ae:	f7 f7                	div    %edi
  8021b0:	89 d0                	mov    %edx,%eax
  8021b2:	31 d2                	xor    %edx,%edx
  8021b4:	83 c4 1c             	add    $0x1c,%esp
  8021b7:	5b                   	pop    %ebx
  8021b8:	5e                   	pop    %esi
  8021b9:	5f                   	pop    %edi
  8021ba:	5d                   	pop    %ebp
  8021bb:	c3                   	ret    
  8021bc:	39 f0                	cmp    %esi,%eax
  8021be:	0f 87 ac 00 00 00    	ja     802270 <__umoddi3+0xfc>
  8021c4:	0f bd e8             	bsr    %eax,%ebp
  8021c7:	83 f5 1f             	xor    $0x1f,%ebp
  8021ca:	0f 84 ac 00 00 00    	je     80227c <__umoddi3+0x108>
  8021d0:	bf 20 00 00 00       	mov    $0x20,%edi
  8021d5:	29 ef                	sub    %ebp,%edi
  8021d7:	89 fe                	mov    %edi,%esi
  8021d9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021dd:	89 e9                	mov    %ebp,%ecx
  8021df:	d3 e0                	shl    %cl,%eax
  8021e1:	89 d7                	mov    %edx,%edi
  8021e3:	89 f1                	mov    %esi,%ecx
  8021e5:	d3 ef                	shr    %cl,%edi
  8021e7:	09 c7                	or     %eax,%edi
  8021e9:	89 e9                	mov    %ebp,%ecx
  8021eb:	d3 e2                	shl    %cl,%edx
  8021ed:	89 14 24             	mov    %edx,(%esp)
  8021f0:	89 d8                	mov    %ebx,%eax
  8021f2:	d3 e0                	shl    %cl,%eax
  8021f4:	89 c2                	mov    %eax,%edx
  8021f6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021fa:	d3 e0                	shl    %cl,%eax
  8021fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  802200:	8b 44 24 08          	mov    0x8(%esp),%eax
  802204:	89 f1                	mov    %esi,%ecx
  802206:	d3 e8                	shr    %cl,%eax
  802208:	09 d0                	or     %edx,%eax
  80220a:	d3 eb                	shr    %cl,%ebx
  80220c:	89 da                	mov    %ebx,%edx
  80220e:	f7 f7                	div    %edi
  802210:	89 d3                	mov    %edx,%ebx
  802212:	f7 24 24             	mull   (%esp)
  802215:	89 c6                	mov    %eax,%esi
  802217:	89 d1                	mov    %edx,%ecx
  802219:	39 d3                	cmp    %edx,%ebx
  80221b:	0f 82 87 00 00 00    	jb     8022a8 <__umoddi3+0x134>
  802221:	0f 84 91 00 00 00    	je     8022b8 <__umoddi3+0x144>
  802227:	8b 54 24 04          	mov    0x4(%esp),%edx
  80222b:	29 f2                	sub    %esi,%edx
  80222d:	19 cb                	sbb    %ecx,%ebx
  80222f:	89 d8                	mov    %ebx,%eax
  802231:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802235:	d3 e0                	shl    %cl,%eax
  802237:	89 e9                	mov    %ebp,%ecx
  802239:	d3 ea                	shr    %cl,%edx
  80223b:	09 d0                	or     %edx,%eax
  80223d:	89 e9                	mov    %ebp,%ecx
  80223f:	d3 eb                	shr    %cl,%ebx
  802241:	89 da                	mov    %ebx,%edx
  802243:	83 c4 1c             	add    $0x1c,%esp
  802246:	5b                   	pop    %ebx
  802247:	5e                   	pop    %esi
  802248:	5f                   	pop    %edi
  802249:	5d                   	pop    %ebp
  80224a:	c3                   	ret    
  80224b:	90                   	nop
  80224c:	89 fd                	mov    %edi,%ebp
  80224e:	85 ff                	test   %edi,%edi
  802250:	75 0b                	jne    80225d <__umoddi3+0xe9>
  802252:	b8 01 00 00 00       	mov    $0x1,%eax
  802257:	31 d2                	xor    %edx,%edx
  802259:	f7 f7                	div    %edi
  80225b:	89 c5                	mov    %eax,%ebp
  80225d:	89 f0                	mov    %esi,%eax
  80225f:	31 d2                	xor    %edx,%edx
  802261:	f7 f5                	div    %ebp
  802263:	89 c8                	mov    %ecx,%eax
  802265:	f7 f5                	div    %ebp
  802267:	89 d0                	mov    %edx,%eax
  802269:	e9 44 ff ff ff       	jmp    8021b2 <__umoddi3+0x3e>
  80226e:	66 90                	xchg   %ax,%ax
  802270:	89 c8                	mov    %ecx,%eax
  802272:	89 f2                	mov    %esi,%edx
  802274:	83 c4 1c             	add    $0x1c,%esp
  802277:	5b                   	pop    %ebx
  802278:	5e                   	pop    %esi
  802279:	5f                   	pop    %edi
  80227a:	5d                   	pop    %ebp
  80227b:	c3                   	ret    
  80227c:	3b 04 24             	cmp    (%esp),%eax
  80227f:	72 06                	jb     802287 <__umoddi3+0x113>
  802281:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802285:	77 0f                	ja     802296 <__umoddi3+0x122>
  802287:	89 f2                	mov    %esi,%edx
  802289:	29 f9                	sub    %edi,%ecx
  80228b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80228f:	89 14 24             	mov    %edx,(%esp)
  802292:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802296:	8b 44 24 04          	mov    0x4(%esp),%eax
  80229a:	8b 14 24             	mov    (%esp),%edx
  80229d:	83 c4 1c             	add    $0x1c,%esp
  8022a0:	5b                   	pop    %ebx
  8022a1:	5e                   	pop    %esi
  8022a2:	5f                   	pop    %edi
  8022a3:	5d                   	pop    %ebp
  8022a4:	c3                   	ret    
  8022a5:	8d 76 00             	lea    0x0(%esi),%esi
  8022a8:	2b 04 24             	sub    (%esp),%eax
  8022ab:	19 fa                	sbb    %edi,%edx
  8022ad:	89 d1                	mov    %edx,%ecx
  8022af:	89 c6                	mov    %eax,%esi
  8022b1:	e9 71 ff ff ff       	jmp    802227 <__umoddi3+0xb3>
  8022b6:	66 90                	xchg   %ax,%ax
  8022b8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8022bc:	72 ea                	jb     8022a8 <__umoddi3+0x134>
  8022be:	89 d9                	mov    %ebx,%ecx
  8022c0:	e9 62 ff ff ff       	jmp    802227 <__umoddi3+0xb3>
