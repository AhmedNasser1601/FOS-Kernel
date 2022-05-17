
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
  800041:	e8 da 1e 00 00       	call   801f20 <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 80 25 80 00       	push   $0x802580
  80004e:	e8 c5 09 00 00       	call   800a18 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 82 25 80 00       	push   $0x802582
  80005e:	e8 b5 09 00 00       	call   800a18 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT   !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 9b 25 80 00       	push   $0x80259b
  80006e:	e8 a5 09 00 00       	call   800a18 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 82 25 80 00       	push   $0x802582
  80007e:	e8 95 09 00 00       	call   800a18 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 80 25 80 00       	push   $0x802580
  80008e:	e8 85 09 00 00       	call   800a18 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 b4 25 80 00       	push   $0x8025b4
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
  8000d0:	e8 b8 1a 00 00       	call   801b8d <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 d4 25 80 00       	push   $0x8025d4
  8000e3:	e8 30 09 00 00       	call   800a18 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 f6 25 80 00       	push   $0x8025f6
  8000f3:	e8 20 09 00 00       	call   800a18 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 04 26 80 00       	push   $0x802604
  800103:	e8 10 09 00 00       	call   800a18 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 13 26 80 00       	push   $0x802613
  800113:	e8 00 09 00 00       	call   800a18 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 23 26 80 00       	push   $0x802623
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
  800162:	e8 d3 1d 00 00       	call   801f3a <sys_enable_interrupt>

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
  8001d5:	e8 46 1d 00 00       	call   801f20 <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 2c 26 80 00       	push   $0x80262c
  8001e2:	e8 31 08 00 00       	call   800a18 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ea:	e8 4b 1d 00 00       	call   801f3a <sys_enable_interrupt>

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
  80020c:	68 60 26 80 00       	push   $0x802660
  800211:	6a 48                	push   $0x48
  800213:	68 82 26 80 00       	push   $0x802682
  800218:	e8 47 05 00 00       	call   800764 <_panic>
		else
		{
			sys_disable_interrupt();
  80021d:	e8 fe 1c 00 00       	call   801f20 <sys_disable_interrupt>
			cprintf("\n===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 98 26 80 00       	push   $0x802698
  80022a:	e8 e9 07 00 00       	call   800a18 <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 cc 26 80 00       	push   $0x8026cc
  80023a:	e8 d9 07 00 00       	call   800a18 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 00 27 80 00       	push   $0x802700
  80024a:	e8 c9 07 00 00       	call   800a18 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800252:	e8 e3 1c 00 00       	call   801f3a <sys_enable_interrupt>
		}

		sys_disable_interrupt();
  800257:	e8 c4 1c 00 00       	call   801f20 <sys_disable_interrupt>
			Chose = 0 ;
  80025c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800260:	eb 42                	jmp    8002a4 <_main+0x26c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800262:	83 ec 0c             	sub    $0xc,%esp
  800265:	68 32 27 80 00       	push   $0x802732
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
  8002b0:	e8 85 1c 00 00       	call   801f3a <sys_enable_interrupt>

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
  800555:	68 80 25 80 00       	push   $0x802580
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
  800577:	68 50 27 80 00       	push   $0x802750
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
  8005a5:	68 55 27 80 00       	push   $0x802755
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
  8005c9:	e8 86 19 00 00       	call   801f54 <sys_cputc>
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
  8005da:	e8 41 19 00 00       	call   801f20 <sys_disable_interrupt>
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
  8005ed:	e8 62 19 00 00       	call   801f54 <sys_cputc>
  8005f2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005f5:	e8 40 19 00 00       	call   801f3a <sys_enable_interrupt>
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
  80060c:	e8 27 17 00 00       	call   801d38 <sys_cgetc>
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
  800625:	e8 f6 18 00 00       	call   801f20 <sys_disable_interrupt>
	int c=0;
  80062a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800631:	eb 08                	jmp    80063b <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800633:	e8 00 17 00 00       	call   801d38 <sys_cgetc>
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
  800641:	e8 f4 18 00 00       	call   801f3a <sys_enable_interrupt>
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
  80065b:	e8 25 17 00 00       	call   801d85 <sys_getenvindex>
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
  800686:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80068b:	a1 24 30 80 00       	mov    0x803024,%eax
  800690:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800696:	84 c0                	test   %al,%al
  800698:	74 0f                	je     8006a9 <libmain+0x54>
		binaryname = myEnv->prog_name;
  80069a:	a1 24 30 80 00       	mov    0x803024,%eax
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
  8006ca:	e8 51 18 00 00       	call   801f20 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006cf:	83 ec 0c             	sub    $0xc,%esp
  8006d2:	68 74 27 80 00       	push   $0x802774
  8006d7:	e8 3c 03 00 00       	call   800a18 <cprintf>
  8006dc:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006df:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e4:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8006ea:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ef:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006f5:	83 ec 04             	sub    $0x4,%esp
  8006f8:	52                   	push   %edx
  8006f9:	50                   	push   %eax
  8006fa:	68 9c 27 80 00       	push   $0x80279c
  8006ff:	e8 14 03 00 00       	call   800a18 <cprintf>
  800704:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800707:	a1 24 30 80 00       	mov    0x803024,%eax
  80070c:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800712:	83 ec 08             	sub    $0x8,%esp
  800715:	50                   	push   %eax
  800716:	68 c1 27 80 00       	push   $0x8027c1
  80071b:	e8 f8 02 00 00       	call   800a18 <cprintf>
  800720:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800723:	83 ec 0c             	sub    $0xc,%esp
  800726:	68 74 27 80 00       	push   $0x802774
  80072b:	e8 e8 02 00 00       	call   800a18 <cprintf>
  800730:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800733:	e8 02 18 00 00       	call   801f3a <sys_enable_interrupt>

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
  80074b:	e8 01 16 00 00       	call   801d51 <sys_env_destroy>
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
  80075c:	e8 56 16 00 00       	call   801db7 <sys_env_exit>
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
  800773:	a1 48 30 88 00       	mov    0x883048,%eax
  800778:	85 c0                	test   %eax,%eax
  80077a:	74 16                	je     800792 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80077c:	a1 48 30 88 00       	mov    0x883048,%eax
  800781:	83 ec 08             	sub    $0x8,%esp
  800784:	50                   	push   %eax
  800785:	68 d8 27 80 00       	push   $0x8027d8
  80078a:	e8 89 02 00 00       	call   800a18 <cprintf>
  80078f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800792:	a1 00 30 80 00       	mov    0x803000,%eax
  800797:	ff 75 0c             	pushl  0xc(%ebp)
  80079a:	ff 75 08             	pushl  0x8(%ebp)
  80079d:	50                   	push   %eax
  80079e:	68 dd 27 80 00       	push   $0x8027dd
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
  8007c2:	68 f9 27 80 00       	push   $0x8027f9
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
  8007dc:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e1:	8b 50 74             	mov    0x74(%eax),%edx
  8007e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e7:	39 c2                	cmp    %eax,%edx
  8007e9:	74 14                	je     8007ff <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007eb:	83 ec 04             	sub    $0x4,%esp
  8007ee:	68 fc 27 80 00       	push   $0x8027fc
  8007f3:	6a 26                	push   $0x26
  8007f5:	68 48 28 80 00       	push   $0x802848
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
  80083f:	a1 24 30 80 00       	mov    0x803024,%eax
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
  80085f:	a1 24 30 80 00       	mov    0x803024,%eax
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
  8008a8:	a1 24 30 80 00       	mov    0x803024,%eax
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
  8008c0:	68 54 28 80 00       	push   $0x802854
  8008c5:	6a 3a                	push   $0x3a
  8008c7:	68 48 28 80 00       	push   $0x802848
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
  8008f0:	a1 24 30 80 00       	mov    0x803024,%eax
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
  800916:	a1 24 30 80 00       	mov    0x803024,%eax
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
  800930:	68 a8 28 80 00       	push   $0x8028a8
  800935:	6a 44                	push   $0x44
  800937:	68 48 28 80 00       	push   $0x802848
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
  80096f:	a0 28 30 80 00       	mov    0x803028,%al
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
  80098a:	e8 80 13 00 00       	call   801d0f <sys_cputs>
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
  8009e4:	a0 28 30 80 00       	mov    0x803028,%al
  8009e9:	0f b6 c0             	movzbl %al,%eax
  8009ec:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009f2:	83 ec 04             	sub    $0x4,%esp
  8009f5:	50                   	push   %eax
  8009f6:	52                   	push   %edx
  8009f7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009fd:	83 c0 08             	add    $0x8,%eax
  800a00:	50                   	push   %eax
  800a01:	e8 09 13 00 00       	call   801d0f <sys_cputs>
  800a06:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a09:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
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
  800a1e:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
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
  800a4b:	e8 d0 14 00 00       	call   801f20 <sys_disable_interrupt>
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
  800a6b:	e8 ca 14 00 00       	call   801f3a <sys_enable_interrupt>
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
  800ab5:	e8 46 18 00 00       	call   802300 <__udivdi3>
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
  800b05:	e8 06 19 00 00       	call   802410 <__umoddi3>
  800b0a:	83 c4 10             	add    $0x10,%esp
  800b0d:	05 14 2b 80 00       	add    $0x802b14,%eax
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
  800c60:	8b 04 85 38 2b 80 00 	mov    0x802b38(,%eax,4),%eax
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
  800d41:	8b 34 9d 80 29 80 00 	mov    0x802980(,%ebx,4),%esi
  800d48:	85 f6                	test   %esi,%esi
  800d4a:	75 19                	jne    800d65 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d4c:	53                   	push   %ebx
  800d4d:	68 25 2b 80 00       	push   $0x802b25
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
  800d66:	68 2e 2b 80 00       	push   $0x802b2e
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
  800d93:	be 31 2b 80 00       	mov    $0x802b31,%esi
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
  8010ac:	68 90 2c 80 00       	push   $0x802c90
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
  8010ee:	68 93 2c 80 00       	push   $0x802c93
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
  80119e:	e8 7d 0d 00 00       	call   801f20 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011a7:	74 13                	je     8011bc <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011a9:	83 ec 08             	sub    $0x8,%esp
  8011ac:	ff 75 08             	pushl  0x8(%ebp)
  8011af:	68 90 2c 80 00       	push   $0x802c90
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
  8011ed:	68 93 2c 80 00       	push   $0x802c93
  8011f2:	e8 21 f8 ff ff       	call   800a18 <cprintf>
  8011f7:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011fa:	e8 3b 0d 00 00       	call   801f3a <sys_enable_interrupt>
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
  801292:	e8 a3 0c 00 00       	call   801f3a <sys_enable_interrupt>
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

008019a8 <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
  8019ab:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  8019ae:	a1 04 30 80 00       	mov    0x803004,%eax
  8019b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8019b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  8019bd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8019c4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  8019cb:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  8019d2:	e9 f9 00 00 00       	jmp    801ad0 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  8019d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019da:	05 00 00 00 80       	add    $0x80000000,%eax
  8019df:	c1 e8 0c             	shr    $0xc,%eax
  8019e2:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8019e9:	85 c0                	test   %eax,%eax
  8019eb:	75 1c                	jne    801a09 <nextFitAlgo+0x61>
  8019ed:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8019f1:	74 16                	je     801a09 <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  8019f3:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  8019fa:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801a01:	ff 4d e0             	decl   -0x20(%ebp)
  801a04:	e9 90 00 00 00       	jmp    801a99 <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  801a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a0c:	05 00 00 00 80       	add    $0x80000000,%eax
  801a11:	c1 e8 0c             	shr    $0xc,%eax
  801a14:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801a1b:	85 c0                	test   %eax,%eax
  801a1d:	75 26                	jne    801a45 <nextFitAlgo+0x9d>
  801a1f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801a23:	75 20                	jne    801a45 <nextFitAlgo+0x9d>
			flag = 1;
  801a25:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  801a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a2f:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  801a32:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801a39:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801a40:	ff 4d e0             	decl   -0x20(%ebp)
  801a43:	eb 54                	jmp    801a99 <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  801a45:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a48:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a4b:	72 11                	jb     801a5e <nextFitAlgo+0xb6>
				startAdd = tmp;
  801a4d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a50:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  801a55:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  801a5c:	eb 7c                	jmp    801ada <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  801a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a61:	05 00 00 00 80       	add    $0x80000000,%eax
  801a66:	c1 e8 0c             	shr    $0xc,%eax
  801a69:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801a70:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  801a73:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a76:	05 00 00 00 80       	add    $0x80000000,%eax
  801a7b:	c1 e8 0c             	shr    $0xc,%eax
  801a7e:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801a85:	c1 e0 0c             	shl    $0xc,%eax
  801a88:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  801a8b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a92:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  801a99:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a9c:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a9f:	72 11                	jb     801ab2 <nextFitAlgo+0x10a>
			startAdd = tmp;
  801aa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801aa4:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  801aa9:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  801ab0:	eb 28                	jmp    801ada <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  801ab2:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  801ab9:	76 15                	jbe    801ad0 <nextFitAlgo+0x128>
			flag = newSize = 0;
  801abb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ac2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  801ac9:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  801ad0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801ad4:	0f 85 fd fe ff ff    	jne    8019d7 <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  801ada:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801ade:	75 1a                	jne    801afa <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  801ae0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae3:	3b 45 08             	cmp    0x8(%ebp),%eax
  801ae6:	73 0a                	jae    801af2 <nextFitAlgo+0x14a>
  801ae8:	b8 00 00 00 00       	mov    $0x0,%eax
  801aed:	e9 99 00 00 00       	jmp    801b8b <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  801af2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801af5:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  801afa:	a1 04 30 80 00       	mov    0x803004,%eax
  801aff:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  801b02:	a1 04 30 80 00       	mov    0x803004,%eax
  801b07:	05 00 00 00 80       	add    $0x80000000,%eax
  801b0c:	c1 e8 0c             	shr    $0xc,%eax
  801b0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  801b12:	8b 45 08             	mov    0x8(%ebp),%eax
  801b15:	c1 e8 0c             	shr    $0xc,%eax
  801b18:	89 c2                	mov    %eax,%edx
  801b1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b1d:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  801b24:	a1 04 30 80 00       	mov    0x803004,%eax
  801b29:	83 ec 08             	sub    $0x8,%esp
  801b2c:	ff 75 08             	pushl  0x8(%ebp)
  801b2f:	50                   	push   %eax
  801b30:	e8 82 03 00 00       	call   801eb7 <sys_allocateMem>
  801b35:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  801b38:	a1 04 30 80 00       	mov    0x803004,%eax
  801b3d:	05 00 00 00 80       	add    $0x80000000,%eax
  801b42:	c1 e8 0c             	shr    $0xc,%eax
  801b45:	89 c2                	mov    %eax,%edx
  801b47:	a1 04 30 80 00       	mov    0x803004,%eax
  801b4c:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  801b53:	a1 04 30 80 00       	mov    0x803004,%eax
  801b58:	05 00 00 00 80       	add    $0x80000000,%eax
  801b5d:	c1 e8 0c             	shr    $0xc,%eax
  801b60:	89 c2                	mov    %eax,%edx
  801b62:	8b 45 08             	mov    0x8(%ebp),%eax
  801b65:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  801b6c:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b72:	8b 45 08             	mov    0x8(%ebp),%eax
  801b75:	01 d0                	add    %edx,%eax
  801b77:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  801b7c:	76 0a                	jbe    801b88 <nextFitAlgo+0x1e0>
  801b7e:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  801b85:	00 00 80 

	return (void*)returnHolder;
  801b88:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  801b8b:	c9                   	leave  
  801b8c:	c3                   	ret    

00801b8d <malloc>:

void* malloc(uint32 size) {
  801b8d:	55                   	push   %ebp
  801b8e:	89 e5                	mov    %esp,%ebp
  801b90:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  801b93:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  801b9a:	8b 55 08             	mov    0x8(%ebp),%edx
  801b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ba0:	01 d0                	add    %edx,%eax
  801ba2:	48                   	dec    %eax
  801ba3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ba6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ba9:	ba 00 00 00 00       	mov    $0x0,%edx
  801bae:	f7 75 f4             	divl   -0xc(%ebp)
  801bb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bb4:	29 d0                	sub    %edx,%eax
  801bb6:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801bb9:	e8 c3 06 00 00       	call   802281 <sys_isUHeapPlacementStrategyNEXTFIT>
  801bbe:	85 c0                	test   %eax,%eax
  801bc0:	74 10                	je     801bd2 <malloc+0x45>
		return nextFitAlgo(size);
  801bc2:	83 ec 0c             	sub    $0xc,%esp
  801bc5:	ff 75 08             	pushl  0x8(%ebp)
  801bc8:	e8 db fd ff ff       	call   8019a8 <nextFitAlgo>
  801bcd:	83 c4 10             	add    $0x10,%esp
  801bd0:	eb 0a                	jmp    801bdc <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  801bd2:	e8 79 06 00 00       	call   802250 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  801bd7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bdc:	c9                   	leave  
  801bdd:	c3                   	ret    

00801bde <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801bde:	55                   	push   %ebp
  801bdf:	89 e5                	mov    %esp,%ebp
  801be1:	83 ec 18             	sub    $0x18,%esp
  801be4:	8b 45 10             	mov    0x10(%ebp),%eax
  801be7:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801bea:	83 ec 04             	sub    $0x4,%esp
  801bed:	68 a4 2c 80 00       	push   $0x802ca4
  801bf2:	6a 7e                	push   $0x7e
  801bf4:	68 c3 2c 80 00       	push   $0x802cc3
  801bf9:	e8 66 eb ff ff       	call   800764 <_panic>

00801bfe <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801bfe:	55                   	push   %ebp
  801bff:	89 e5                	mov    %esp,%ebp
  801c01:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801c04:	83 ec 04             	sub    $0x4,%esp
  801c07:	68 cf 2c 80 00       	push   $0x802ccf
  801c0c:	68 84 00 00 00       	push   $0x84
  801c11:	68 c3 2c 80 00       	push   $0x802cc3
  801c16:	e8 49 eb ff ff       	call   800764 <_panic>

00801c1b <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801c1b:	55                   	push   %ebp
  801c1c:	89 e5                	mov    %esp,%ebp
  801c1e:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801c21:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c28:	eb 61                	jmp    801c8b <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  801c2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c2d:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  801c34:	8b 45 08             	mov    0x8(%ebp),%eax
  801c37:	39 c2                	cmp    %eax,%edx
  801c39:	75 4d                	jne    801c88 <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  801c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3e:	05 00 00 00 80       	add    $0x80000000,%eax
  801c43:	c1 e8 0c             	shr    $0xc,%eax
  801c46:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801c49:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c4c:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  801c53:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  801c56:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c59:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  801c60:	00 00 00 00 
  801c64:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c67:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  801c6e:	00 00 00 00 
  801c72:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c75:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  801c7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c7f:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  801c86:	eb 0d                	jmp    801c95 <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801c88:	ff 45 f0             	incl   -0x10(%ebp)
  801c8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c8e:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c93:	76 95                	jbe    801c2a <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  801c95:	8b 45 08             	mov    0x8(%ebp),%eax
  801c98:	83 ec 08             	sub    $0x8,%esp
  801c9b:	ff 75 f4             	pushl  -0xc(%ebp)
  801c9e:	50                   	push   %eax
  801c9f:	e8 f7 01 00 00       	call   801e9b <sys_freeMem>
  801ca4:	83 c4 10             	add    $0x10,%esp
}
  801ca7:	90                   	nop
  801ca8:	c9                   	leave  
  801ca9:	c3                   	ret    

00801caa <sfree>:


void sfree(void* virtual_address)
{
  801caa:	55                   	push   %ebp
  801cab:	89 e5                	mov    %esp,%ebp
  801cad:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801cb0:	83 ec 04             	sub    $0x4,%esp
  801cb3:	68 eb 2c 80 00       	push   $0x802ceb
  801cb8:	68 ac 00 00 00       	push   $0xac
  801cbd:	68 c3 2c 80 00       	push   $0x802cc3
  801cc2:	e8 9d ea ff ff       	call   800764 <_panic>

00801cc7 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801cc7:	55                   	push   %ebp
  801cc8:	89 e5                	mov    %esp,%ebp
  801cca:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801ccd:	83 ec 04             	sub    $0x4,%esp
  801cd0:	68 08 2d 80 00       	push   $0x802d08
  801cd5:	68 c4 00 00 00       	push   $0xc4
  801cda:	68 c3 2c 80 00       	push   $0x802cc3
  801cdf:	e8 80 ea ff ff       	call   800764 <_panic>

00801ce4 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ce4:	55                   	push   %ebp
  801ce5:	89 e5                	mov    %esp,%ebp
  801ce7:	57                   	push   %edi
  801ce8:	56                   	push   %esi
  801ce9:	53                   	push   %ebx
  801cea:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ced:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cf3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cf6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cf9:	8b 7d 18             	mov    0x18(%ebp),%edi
  801cfc:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cff:	cd 30                	int    $0x30
  801d01:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d04:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d07:	83 c4 10             	add    $0x10,%esp
  801d0a:	5b                   	pop    %ebx
  801d0b:	5e                   	pop    %esi
  801d0c:	5f                   	pop    %edi
  801d0d:	5d                   	pop    %ebp
  801d0e:	c3                   	ret    

00801d0f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d0f:	55                   	push   %ebp
  801d10:	89 e5                	mov    %esp,%ebp
  801d12:	83 ec 04             	sub    $0x4,%esp
  801d15:	8b 45 10             	mov    0x10(%ebp),%eax
  801d18:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d1b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	52                   	push   %edx
  801d27:	ff 75 0c             	pushl  0xc(%ebp)
  801d2a:	50                   	push   %eax
  801d2b:	6a 00                	push   $0x0
  801d2d:	e8 b2 ff ff ff       	call   801ce4 <syscall>
  801d32:	83 c4 18             	add    $0x18,%esp
}
  801d35:	90                   	nop
  801d36:	c9                   	leave  
  801d37:	c3                   	ret    

00801d38 <sys_cgetc>:

int
sys_cgetc(void)
{
  801d38:	55                   	push   %ebp
  801d39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 01                	push   $0x1
  801d47:	e8 98 ff ff ff       	call   801ce4 <syscall>
  801d4c:	83 c4 18             	add    $0x18,%esp
}
  801d4f:	c9                   	leave  
  801d50:	c3                   	ret    

00801d51 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d54:	8b 45 08             	mov    0x8(%ebp),%eax
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	50                   	push   %eax
  801d60:	6a 05                	push   $0x5
  801d62:	e8 7d ff ff ff       	call   801ce4 <syscall>
  801d67:	83 c4 18             	add    $0x18,%esp
}
  801d6a:	c9                   	leave  
  801d6b:	c3                   	ret    

00801d6c <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d6c:	55                   	push   %ebp
  801d6d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 02                	push   $0x2
  801d7b:	e8 64 ff ff ff       	call   801ce4 <syscall>
  801d80:	83 c4 18             	add    $0x18,%esp
}
  801d83:	c9                   	leave  
  801d84:	c3                   	ret    

00801d85 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d85:	55                   	push   %ebp
  801d86:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d88:	6a 00                	push   $0x0
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 03                	push   $0x3
  801d94:	e8 4b ff ff ff       	call   801ce4 <syscall>
  801d99:	83 c4 18             	add    $0x18,%esp
}
  801d9c:	c9                   	leave  
  801d9d:	c3                   	ret    

00801d9e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d9e:	55                   	push   %ebp
  801d9f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	6a 00                	push   $0x0
  801dab:	6a 04                	push   $0x4
  801dad:	e8 32 ff ff ff       	call   801ce4 <syscall>
  801db2:	83 c4 18             	add    $0x18,%esp
}
  801db5:	c9                   	leave  
  801db6:	c3                   	ret    

00801db7 <sys_env_exit>:


void sys_env_exit(void)
{
  801db7:	55                   	push   %ebp
  801db8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 06                	push   $0x6
  801dc6:	e8 19 ff ff ff       	call   801ce4 <syscall>
  801dcb:	83 c4 18             	add    $0x18,%esp
}
  801dce:	90                   	nop
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801dd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	52                   	push   %edx
  801de1:	50                   	push   %eax
  801de2:	6a 07                	push   $0x7
  801de4:	e8 fb fe ff ff       	call   801ce4 <syscall>
  801de9:	83 c4 18             	add    $0x18,%esp
}
  801dec:	c9                   	leave  
  801ded:	c3                   	ret    

00801dee <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801dee:	55                   	push   %ebp
  801def:	89 e5                	mov    %esp,%ebp
  801df1:	56                   	push   %esi
  801df2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801df3:	8b 75 18             	mov    0x18(%ebp),%esi
  801df6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801df9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dfc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dff:	8b 45 08             	mov    0x8(%ebp),%eax
  801e02:	56                   	push   %esi
  801e03:	53                   	push   %ebx
  801e04:	51                   	push   %ecx
  801e05:	52                   	push   %edx
  801e06:	50                   	push   %eax
  801e07:	6a 08                	push   $0x8
  801e09:	e8 d6 fe ff ff       	call   801ce4 <syscall>
  801e0e:	83 c4 18             	add    $0x18,%esp
}
  801e11:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e14:	5b                   	pop    %ebx
  801e15:	5e                   	pop    %esi
  801e16:	5d                   	pop    %ebp
  801e17:	c3                   	ret    

00801e18 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e18:	55                   	push   %ebp
  801e19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	52                   	push   %edx
  801e28:	50                   	push   %eax
  801e29:	6a 09                	push   $0x9
  801e2b:	e8 b4 fe ff ff       	call   801ce4 <syscall>
  801e30:	83 c4 18             	add    $0x18,%esp
}
  801e33:	c9                   	leave  
  801e34:	c3                   	ret    

00801e35 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e35:	55                   	push   %ebp
  801e36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	ff 75 0c             	pushl  0xc(%ebp)
  801e41:	ff 75 08             	pushl  0x8(%ebp)
  801e44:	6a 0a                	push   $0xa
  801e46:	e8 99 fe ff ff       	call   801ce4 <syscall>
  801e4b:	83 c4 18             	add    $0x18,%esp
}
  801e4e:	c9                   	leave  
  801e4f:	c3                   	ret    

00801e50 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e50:	55                   	push   %ebp
  801e51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 0b                	push   $0xb
  801e5f:	e8 80 fe ff ff       	call   801ce4 <syscall>
  801e64:	83 c4 18             	add    $0x18,%esp
}
  801e67:	c9                   	leave  
  801e68:	c3                   	ret    

00801e69 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e69:	55                   	push   %ebp
  801e6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 0c                	push   $0xc
  801e78:	e8 67 fe ff ff       	call   801ce4 <syscall>
  801e7d:	83 c4 18             	add    $0x18,%esp
}
  801e80:	c9                   	leave  
  801e81:	c3                   	ret    

00801e82 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e82:	55                   	push   %ebp
  801e83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 00                	push   $0x0
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 0d                	push   $0xd
  801e91:	e8 4e fe ff ff       	call   801ce4 <syscall>
  801e96:	83 c4 18             	add    $0x18,%esp
}
  801e99:	c9                   	leave  
  801e9a:	c3                   	ret    

00801e9b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e9b:	55                   	push   %ebp
  801e9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	ff 75 0c             	pushl  0xc(%ebp)
  801ea7:	ff 75 08             	pushl  0x8(%ebp)
  801eaa:	6a 11                	push   $0x11
  801eac:	e8 33 fe ff ff       	call   801ce4 <syscall>
  801eb1:	83 c4 18             	add    $0x18,%esp
	return;
  801eb4:	90                   	nop
}
  801eb5:	c9                   	leave  
  801eb6:	c3                   	ret    

00801eb7 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801eb7:	55                   	push   %ebp
  801eb8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	ff 75 0c             	pushl  0xc(%ebp)
  801ec3:	ff 75 08             	pushl  0x8(%ebp)
  801ec6:	6a 12                	push   $0x12
  801ec8:	e8 17 fe ff ff       	call   801ce4 <syscall>
  801ecd:	83 c4 18             	add    $0x18,%esp
	return ;
  801ed0:	90                   	nop
}
  801ed1:	c9                   	leave  
  801ed2:	c3                   	ret    

00801ed3 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ed3:	55                   	push   %ebp
  801ed4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 00                	push   $0x0
  801edc:	6a 00                	push   $0x0
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 0e                	push   $0xe
  801ee2:	e8 fd fd ff ff       	call   801ce4 <syscall>
  801ee7:	83 c4 18             	add    $0x18,%esp
}
  801eea:	c9                   	leave  
  801eeb:	c3                   	ret    

00801eec <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801eec:	55                   	push   %ebp
  801eed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 00                	push   $0x0
  801ef7:	ff 75 08             	pushl  0x8(%ebp)
  801efa:	6a 0f                	push   $0xf
  801efc:	e8 e3 fd ff ff       	call   801ce4 <syscall>
  801f01:	83 c4 18             	add    $0x18,%esp
}
  801f04:	c9                   	leave  
  801f05:	c3                   	ret    

00801f06 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f06:	55                   	push   %ebp
  801f07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f09:	6a 00                	push   $0x0
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	6a 00                	push   $0x0
  801f13:	6a 10                	push   $0x10
  801f15:	e8 ca fd ff ff       	call   801ce4 <syscall>
  801f1a:	83 c4 18             	add    $0x18,%esp
}
  801f1d:	90                   	nop
  801f1e:	c9                   	leave  
  801f1f:	c3                   	ret    

00801f20 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f20:	55                   	push   %ebp
  801f21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 14                	push   $0x14
  801f2f:	e8 b0 fd ff ff       	call   801ce4 <syscall>
  801f34:	83 c4 18             	add    $0x18,%esp
}
  801f37:	90                   	nop
  801f38:	c9                   	leave  
  801f39:	c3                   	ret    

00801f3a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f3a:	55                   	push   %ebp
  801f3b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 00                	push   $0x0
  801f41:	6a 00                	push   $0x0
  801f43:	6a 00                	push   $0x0
  801f45:	6a 00                	push   $0x0
  801f47:	6a 15                	push   $0x15
  801f49:	e8 96 fd ff ff       	call   801ce4 <syscall>
  801f4e:	83 c4 18             	add    $0x18,%esp
}
  801f51:	90                   	nop
  801f52:	c9                   	leave  
  801f53:	c3                   	ret    

00801f54 <sys_cputc>:


void
sys_cputc(const char c)
{
  801f54:	55                   	push   %ebp
  801f55:	89 e5                	mov    %esp,%ebp
  801f57:	83 ec 04             	sub    $0x4,%esp
  801f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f60:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 00                	push   $0x0
  801f6c:	50                   	push   %eax
  801f6d:	6a 16                	push   $0x16
  801f6f:	e8 70 fd ff ff       	call   801ce4 <syscall>
  801f74:	83 c4 18             	add    $0x18,%esp
}
  801f77:	90                   	nop
  801f78:	c9                   	leave  
  801f79:	c3                   	ret    

00801f7a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f7a:	55                   	push   %ebp
  801f7b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	6a 00                	push   $0x0
  801f87:	6a 17                	push   $0x17
  801f89:	e8 56 fd ff ff       	call   801ce4 <syscall>
  801f8e:	83 c4 18             	add    $0x18,%esp
}
  801f91:	90                   	nop
  801f92:	c9                   	leave  
  801f93:	c3                   	ret    

00801f94 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f94:	55                   	push   %ebp
  801f95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f97:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	ff 75 0c             	pushl  0xc(%ebp)
  801fa3:	50                   	push   %eax
  801fa4:	6a 18                	push   $0x18
  801fa6:	e8 39 fd ff ff       	call   801ce4 <syscall>
  801fab:	83 c4 18             	add    $0x18,%esp
}
  801fae:	c9                   	leave  
  801faf:	c3                   	ret    

00801fb0 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801fb0:	55                   	push   %ebp
  801fb1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fb3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	52                   	push   %edx
  801fc0:	50                   	push   %eax
  801fc1:	6a 1b                	push   $0x1b
  801fc3:	e8 1c fd ff ff       	call   801ce4 <syscall>
  801fc8:	83 c4 18             	add    $0x18,%esp
}
  801fcb:	c9                   	leave  
  801fcc:	c3                   	ret    

00801fcd <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fcd:	55                   	push   %ebp
  801fce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	52                   	push   %edx
  801fdd:	50                   	push   %eax
  801fde:	6a 19                	push   $0x19
  801fe0:	e8 ff fc ff ff       	call   801ce4 <syscall>
  801fe5:	83 c4 18             	add    $0x18,%esp
}
  801fe8:	90                   	nop
  801fe9:	c9                   	leave  
  801fea:	c3                   	ret    

00801feb <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801feb:	55                   	push   %ebp
  801fec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fee:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 00                	push   $0x0
  801ffa:	52                   	push   %edx
  801ffb:	50                   	push   %eax
  801ffc:	6a 1a                	push   $0x1a
  801ffe:	e8 e1 fc ff ff       	call   801ce4 <syscall>
  802003:	83 c4 18             	add    $0x18,%esp
}
  802006:	90                   	nop
  802007:	c9                   	leave  
  802008:	c3                   	ret    

00802009 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802009:	55                   	push   %ebp
  80200a:	89 e5                	mov    %esp,%ebp
  80200c:	83 ec 04             	sub    $0x4,%esp
  80200f:	8b 45 10             	mov    0x10(%ebp),%eax
  802012:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802015:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802018:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80201c:	8b 45 08             	mov    0x8(%ebp),%eax
  80201f:	6a 00                	push   $0x0
  802021:	51                   	push   %ecx
  802022:	52                   	push   %edx
  802023:	ff 75 0c             	pushl  0xc(%ebp)
  802026:	50                   	push   %eax
  802027:	6a 1c                	push   $0x1c
  802029:	e8 b6 fc ff ff       	call   801ce4 <syscall>
  80202e:	83 c4 18             	add    $0x18,%esp
}
  802031:	c9                   	leave  
  802032:	c3                   	ret    

00802033 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802033:	55                   	push   %ebp
  802034:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802036:	8b 55 0c             	mov    0xc(%ebp),%edx
  802039:	8b 45 08             	mov    0x8(%ebp),%eax
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	52                   	push   %edx
  802043:	50                   	push   %eax
  802044:	6a 1d                	push   $0x1d
  802046:	e8 99 fc ff ff       	call   801ce4 <syscall>
  80204b:	83 c4 18             	add    $0x18,%esp
}
  80204e:	c9                   	leave  
  80204f:	c3                   	ret    

00802050 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802050:	55                   	push   %ebp
  802051:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802053:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802056:	8b 55 0c             	mov    0xc(%ebp),%edx
  802059:	8b 45 08             	mov    0x8(%ebp),%eax
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	51                   	push   %ecx
  802061:	52                   	push   %edx
  802062:	50                   	push   %eax
  802063:	6a 1e                	push   $0x1e
  802065:	e8 7a fc ff ff       	call   801ce4 <syscall>
  80206a:	83 c4 18             	add    $0x18,%esp
}
  80206d:	c9                   	leave  
  80206e:	c3                   	ret    

0080206f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80206f:	55                   	push   %ebp
  802070:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802072:	8b 55 0c             	mov    0xc(%ebp),%edx
  802075:	8b 45 08             	mov    0x8(%ebp),%eax
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	52                   	push   %edx
  80207f:	50                   	push   %eax
  802080:	6a 1f                	push   $0x1f
  802082:	e8 5d fc ff ff       	call   801ce4 <syscall>
  802087:	83 c4 18             	add    $0x18,%esp
}
  80208a:	c9                   	leave  
  80208b:	c3                   	ret    

0080208c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80208c:	55                   	push   %ebp
  80208d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	6a 00                	push   $0x0
  802099:	6a 20                	push   $0x20
  80209b:	e8 44 fc ff ff       	call   801ce4 <syscall>
  8020a0:	83 c4 18             	add    $0x18,%esp
}
  8020a3:	c9                   	leave  
  8020a4:	c3                   	ret    

008020a5 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8020a5:	55                   	push   %ebp
  8020a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8020a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	ff 75 10             	pushl  0x10(%ebp)
  8020b2:	ff 75 0c             	pushl  0xc(%ebp)
  8020b5:	50                   	push   %eax
  8020b6:	6a 21                	push   $0x21
  8020b8:	e8 27 fc ff ff       	call   801ce4 <syscall>
  8020bd:	83 c4 18             	add    $0x18,%esp
}
  8020c0:	c9                   	leave  
  8020c1:	c3                   	ret    

008020c2 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8020c2:	55                   	push   %ebp
  8020c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8020c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c8:	6a 00                	push   $0x0
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	50                   	push   %eax
  8020d1:	6a 22                	push   $0x22
  8020d3:	e8 0c fc ff ff       	call   801ce4 <syscall>
  8020d8:	83 c4 18             	add    $0x18,%esp
}
  8020db:	90                   	nop
  8020dc:	c9                   	leave  
  8020dd:	c3                   	ret    

008020de <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8020de:	55                   	push   %ebp
  8020df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8020e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 00                	push   $0x0
  8020ec:	50                   	push   %eax
  8020ed:	6a 23                	push   $0x23
  8020ef:	e8 f0 fb ff ff       	call   801ce4 <syscall>
  8020f4:	83 c4 18             	add    $0x18,%esp
}
  8020f7:	90                   	nop
  8020f8:	c9                   	leave  
  8020f9:	c3                   	ret    

008020fa <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8020fa:	55                   	push   %ebp
  8020fb:	89 e5                	mov    %esp,%ebp
  8020fd:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802100:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802103:	8d 50 04             	lea    0x4(%eax),%edx
  802106:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802109:	6a 00                	push   $0x0
  80210b:	6a 00                	push   $0x0
  80210d:	6a 00                	push   $0x0
  80210f:	52                   	push   %edx
  802110:	50                   	push   %eax
  802111:	6a 24                	push   $0x24
  802113:	e8 cc fb ff ff       	call   801ce4 <syscall>
  802118:	83 c4 18             	add    $0x18,%esp
	return result;
  80211b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80211e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802121:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802124:	89 01                	mov    %eax,(%ecx)
  802126:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802129:	8b 45 08             	mov    0x8(%ebp),%eax
  80212c:	c9                   	leave  
  80212d:	c2 04 00             	ret    $0x4

00802130 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802130:	55                   	push   %ebp
  802131:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802133:	6a 00                	push   $0x0
  802135:	6a 00                	push   $0x0
  802137:	ff 75 10             	pushl  0x10(%ebp)
  80213a:	ff 75 0c             	pushl  0xc(%ebp)
  80213d:	ff 75 08             	pushl  0x8(%ebp)
  802140:	6a 13                	push   $0x13
  802142:	e8 9d fb ff ff       	call   801ce4 <syscall>
  802147:	83 c4 18             	add    $0x18,%esp
	return ;
  80214a:	90                   	nop
}
  80214b:	c9                   	leave  
  80214c:	c3                   	ret    

0080214d <sys_rcr2>:
uint32 sys_rcr2()
{
  80214d:	55                   	push   %ebp
  80214e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802150:	6a 00                	push   $0x0
  802152:	6a 00                	push   $0x0
  802154:	6a 00                	push   $0x0
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 25                	push   $0x25
  80215c:	e8 83 fb ff ff       	call   801ce4 <syscall>
  802161:	83 c4 18             	add    $0x18,%esp
}
  802164:	c9                   	leave  
  802165:	c3                   	ret    

00802166 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802166:	55                   	push   %ebp
  802167:	89 e5                	mov    %esp,%ebp
  802169:	83 ec 04             	sub    $0x4,%esp
  80216c:	8b 45 08             	mov    0x8(%ebp),%eax
  80216f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802172:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	50                   	push   %eax
  80217f:	6a 26                	push   $0x26
  802181:	e8 5e fb ff ff       	call   801ce4 <syscall>
  802186:	83 c4 18             	add    $0x18,%esp
	return ;
  802189:	90                   	nop
}
  80218a:	c9                   	leave  
  80218b:	c3                   	ret    

0080218c <rsttst>:
void rsttst()
{
  80218c:	55                   	push   %ebp
  80218d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	6a 00                	push   $0x0
  802197:	6a 00                	push   $0x0
  802199:	6a 28                	push   $0x28
  80219b:	e8 44 fb ff ff       	call   801ce4 <syscall>
  8021a0:	83 c4 18             	add    $0x18,%esp
	return ;
  8021a3:	90                   	nop
}
  8021a4:	c9                   	leave  
  8021a5:	c3                   	ret    

008021a6 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8021a6:	55                   	push   %ebp
  8021a7:	89 e5                	mov    %esp,%ebp
  8021a9:	83 ec 04             	sub    $0x4,%esp
  8021ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8021af:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8021b2:	8b 55 18             	mov    0x18(%ebp),%edx
  8021b5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021b9:	52                   	push   %edx
  8021ba:	50                   	push   %eax
  8021bb:	ff 75 10             	pushl  0x10(%ebp)
  8021be:	ff 75 0c             	pushl  0xc(%ebp)
  8021c1:	ff 75 08             	pushl  0x8(%ebp)
  8021c4:	6a 27                	push   $0x27
  8021c6:	e8 19 fb ff ff       	call   801ce4 <syscall>
  8021cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ce:	90                   	nop
}
  8021cf:	c9                   	leave  
  8021d0:	c3                   	ret    

008021d1 <chktst>:
void chktst(uint32 n)
{
  8021d1:	55                   	push   %ebp
  8021d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 00                	push   $0x0
  8021dc:	ff 75 08             	pushl  0x8(%ebp)
  8021df:	6a 29                	push   $0x29
  8021e1:	e8 fe fa ff ff       	call   801ce4 <syscall>
  8021e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e9:	90                   	nop
}
  8021ea:	c9                   	leave  
  8021eb:	c3                   	ret    

008021ec <inctst>:

void inctst()
{
  8021ec:	55                   	push   %ebp
  8021ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 00                	push   $0x0
  8021f3:	6a 00                	push   $0x0
  8021f5:	6a 00                	push   $0x0
  8021f7:	6a 00                	push   $0x0
  8021f9:	6a 2a                	push   $0x2a
  8021fb:	e8 e4 fa ff ff       	call   801ce4 <syscall>
  802200:	83 c4 18             	add    $0x18,%esp
	return ;
  802203:	90                   	nop
}
  802204:	c9                   	leave  
  802205:	c3                   	ret    

00802206 <gettst>:
uint32 gettst()
{
  802206:	55                   	push   %ebp
  802207:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802209:	6a 00                	push   $0x0
  80220b:	6a 00                	push   $0x0
  80220d:	6a 00                	push   $0x0
  80220f:	6a 00                	push   $0x0
  802211:	6a 00                	push   $0x0
  802213:	6a 2b                	push   $0x2b
  802215:	e8 ca fa ff ff       	call   801ce4 <syscall>
  80221a:	83 c4 18             	add    $0x18,%esp
}
  80221d:	c9                   	leave  
  80221e:	c3                   	ret    

0080221f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80221f:	55                   	push   %ebp
  802220:	89 e5                	mov    %esp,%ebp
  802222:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802225:	6a 00                	push   $0x0
  802227:	6a 00                	push   $0x0
  802229:	6a 00                	push   $0x0
  80222b:	6a 00                	push   $0x0
  80222d:	6a 00                	push   $0x0
  80222f:	6a 2c                	push   $0x2c
  802231:	e8 ae fa ff ff       	call   801ce4 <syscall>
  802236:	83 c4 18             	add    $0x18,%esp
  802239:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80223c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802240:	75 07                	jne    802249 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802242:	b8 01 00 00 00       	mov    $0x1,%eax
  802247:	eb 05                	jmp    80224e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802249:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80224e:	c9                   	leave  
  80224f:	c3                   	ret    

00802250 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802250:	55                   	push   %ebp
  802251:	89 e5                	mov    %esp,%ebp
  802253:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802256:	6a 00                	push   $0x0
  802258:	6a 00                	push   $0x0
  80225a:	6a 00                	push   $0x0
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	6a 2c                	push   $0x2c
  802262:	e8 7d fa ff ff       	call   801ce4 <syscall>
  802267:	83 c4 18             	add    $0x18,%esp
  80226a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80226d:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802271:	75 07                	jne    80227a <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802273:	b8 01 00 00 00       	mov    $0x1,%eax
  802278:	eb 05                	jmp    80227f <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80227a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80227f:	c9                   	leave  
  802280:	c3                   	ret    

00802281 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802281:	55                   	push   %ebp
  802282:	89 e5                	mov    %esp,%ebp
  802284:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802287:	6a 00                	push   $0x0
  802289:	6a 00                	push   $0x0
  80228b:	6a 00                	push   $0x0
  80228d:	6a 00                	push   $0x0
  80228f:	6a 00                	push   $0x0
  802291:	6a 2c                	push   $0x2c
  802293:	e8 4c fa ff ff       	call   801ce4 <syscall>
  802298:	83 c4 18             	add    $0x18,%esp
  80229b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80229e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8022a2:	75 07                	jne    8022ab <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8022a4:	b8 01 00 00 00       	mov    $0x1,%eax
  8022a9:	eb 05                	jmp    8022b0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8022ab:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022b0:	c9                   	leave  
  8022b1:	c3                   	ret    

008022b2 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8022b2:	55                   	push   %ebp
  8022b3:	89 e5                	mov    %esp,%ebp
  8022b5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022b8:	6a 00                	push   $0x0
  8022ba:	6a 00                	push   $0x0
  8022bc:	6a 00                	push   $0x0
  8022be:	6a 00                	push   $0x0
  8022c0:	6a 00                	push   $0x0
  8022c2:	6a 2c                	push   $0x2c
  8022c4:	e8 1b fa ff ff       	call   801ce4 <syscall>
  8022c9:	83 c4 18             	add    $0x18,%esp
  8022cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8022cf:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8022d3:	75 07                	jne    8022dc <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8022d5:	b8 01 00 00 00       	mov    $0x1,%eax
  8022da:	eb 05                	jmp    8022e1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8022dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022e1:	c9                   	leave  
  8022e2:	c3                   	ret    

008022e3 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8022e3:	55                   	push   %ebp
  8022e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 00                	push   $0x0
  8022ea:	6a 00                	push   $0x0
  8022ec:	6a 00                	push   $0x0
  8022ee:	ff 75 08             	pushl  0x8(%ebp)
  8022f1:	6a 2d                	push   $0x2d
  8022f3:	e8 ec f9 ff ff       	call   801ce4 <syscall>
  8022f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8022fb:	90                   	nop
}
  8022fc:	c9                   	leave  
  8022fd:	c3                   	ret    
  8022fe:	66 90                	xchg   %ax,%ax

00802300 <__udivdi3>:
  802300:	55                   	push   %ebp
  802301:	57                   	push   %edi
  802302:	56                   	push   %esi
  802303:	53                   	push   %ebx
  802304:	83 ec 1c             	sub    $0x1c,%esp
  802307:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80230b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80230f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802313:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802317:	89 ca                	mov    %ecx,%edx
  802319:	89 f8                	mov    %edi,%eax
  80231b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80231f:	85 f6                	test   %esi,%esi
  802321:	75 2d                	jne    802350 <__udivdi3+0x50>
  802323:	39 cf                	cmp    %ecx,%edi
  802325:	77 65                	ja     80238c <__udivdi3+0x8c>
  802327:	89 fd                	mov    %edi,%ebp
  802329:	85 ff                	test   %edi,%edi
  80232b:	75 0b                	jne    802338 <__udivdi3+0x38>
  80232d:	b8 01 00 00 00       	mov    $0x1,%eax
  802332:	31 d2                	xor    %edx,%edx
  802334:	f7 f7                	div    %edi
  802336:	89 c5                	mov    %eax,%ebp
  802338:	31 d2                	xor    %edx,%edx
  80233a:	89 c8                	mov    %ecx,%eax
  80233c:	f7 f5                	div    %ebp
  80233e:	89 c1                	mov    %eax,%ecx
  802340:	89 d8                	mov    %ebx,%eax
  802342:	f7 f5                	div    %ebp
  802344:	89 cf                	mov    %ecx,%edi
  802346:	89 fa                	mov    %edi,%edx
  802348:	83 c4 1c             	add    $0x1c,%esp
  80234b:	5b                   	pop    %ebx
  80234c:	5e                   	pop    %esi
  80234d:	5f                   	pop    %edi
  80234e:	5d                   	pop    %ebp
  80234f:	c3                   	ret    
  802350:	39 ce                	cmp    %ecx,%esi
  802352:	77 28                	ja     80237c <__udivdi3+0x7c>
  802354:	0f bd fe             	bsr    %esi,%edi
  802357:	83 f7 1f             	xor    $0x1f,%edi
  80235a:	75 40                	jne    80239c <__udivdi3+0x9c>
  80235c:	39 ce                	cmp    %ecx,%esi
  80235e:	72 0a                	jb     80236a <__udivdi3+0x6a>
  802360:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802364:	0f 87 9e 00 00 00    	ja     802408 <__udivdi3+0x108>
  80236a:	b8 01 00 00 00       	mov    $0x1,%eax
  80236f:	89 fa                	mov    %edi,%edx
  802371:	83 c4 1c             	add    $0x1c,%esp
  802374:	5b                   	pop    %ebx
  802375:	5e                   	pop    %esi
  802376:	5f                   	pop    %edi
  802377:	5d                   	pop    %ebp
  802378:	c3                   	ret    
  802379:	8d 76 00             	lea    0x0(%esi),%esi
  80237c:	31 ff                	xor    %edi,%edi
  80237e:	31 c0                	xor    %eax,%eax
  802380:	89 fa                	mov    %edi,%edx
  802382:	83 c4 1c             	add    $0x1c,%esp
  802385:	5b                   	pop    %ebx
  802386:	5e                   	pop    %esi
  802387:	5f                   	pop    %edi
  802388:	5d                   	pop    %ebp
  802389:	c3                   	ret    
  80238a:	66 90                	xchg   %ax,%ax
  80238c:	89 d8                	mov    %ebx,%eax
  80238e:	f7 f7                	div    %edi
  802390:	31 ff                	xor    %edi,%edi
  802392:	89 fa                	mov    %edi,%edx
  802394:	83 c4 1c             	add    $0x1c,%esp
  802397:	5b                   	pop    %ebx
  802398:	5e                   	pop    %esi
  802399:	5f                   	pop    %edi
  80239a:	5d                   	pop    %ebp
  80239b:	c3                   	ret    
  80239c:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023a1:	89 eb                	mov    %ebp,%ebx
  8023a3:	29 fb                	sub    %edi,%ebx
  8023a5:	89 f9                	mov    %edi,%ecx
  8023a7:	d3 e6                	shl    %cl,%esi
  8023a9:	89 c5                	mov    %eax,%ebp
  8023ab:	88 d9                	mov    %bl,%cl
  8023ad:	d3 ed                	shr    %cl,%ebp
  8023af:	89 e9                	mov    %ebp,%ecx
  8023b1:	09 f1                	or     %esi,%ecx
  8023b3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023b7:	89 f9                	mov    %edi,%ecx
  8023b9:	d3 e0                	shl    %cl,%eax
  8023bb:	89 c5                	mov    %eax,%ebp
  8023bd:	89 d6                	mov    %edx,%esi
  8023bf:	88 d9                	mov    %bl,%cl
  8023c1:	d3 ee                	shr    %cl,%esi
  8023c3:	89 f9                	mov    %edi,%ecx
  8023c5:	d3 e2                	shl    %cl,%edx
  8023c7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023cb:	88 d9                	mov    %bl,%cl
  8023cd:	d3 e8                	shr    %cl,%eax
  8023cf:	09 c2                	or     %eax,%edx
  8023d1:	89 d0                	mov    %edx,%eax
  8023d3:	89 f2                	mov    %esi,%edx
  8023d5:	f7 74 24 0c          	divl   0xc(%esp)
  8023d9:	89 d6                	mov    %edx,%esi
  8023db:	89 c3                	mov    %eax,%ebx
  8023dd:	f7 e5                	mul    %ebp
  8023df:	39 d6                	cmp    %edx,%esi
  8023e1:	72 19                	jb     8023fc <__udivdi3+0xfc>
  8023e3:	74 0b                	je     8023f0 <__udivdi3+0xf0>
  8023e5:	89 d8                	mov    %ebx,%eax
  8023e7:	31 ff                	xor    %edi,%edi
  8023e9:	e9 58 ff ff ff       	jmp    802346 <__udivdi3+0x46>
  8023ee:	66 90                	xchg   %ax,%ax
  8023f0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023f4:	89 f9                	mov    %edi,%ecx
  8023f6:	d3 e2                	shl    %cl,%edx
  8023f8:	39 c2                	cmp    %eax,%edx
  8023fa:	73 e9                	jae    8023e5 <__udivdi3+0xe5>
  8023fc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023ff:	31 ff                	xor    %edi,%edi
  802401:	e9 40 ff ff ff       	jmp    802346 <__udivdi3+0x46>
  802406:	66 90                	xchg   %ax,%ax
  802408:	31 c0                	xor    %eax,%eax
  80240a:	e9 37 ff ff ff       	jmp    802346 <__udivdi3+0x46>
  80240f:	90                   	nop

00802410 <__umoddi3>:
  802410:	55                   	push   %ebp
  802411:	57                   	push   %edi
  802412:	56                   	push   %esi
  802413:	53                   	push   %ebx
  802414:	83 ec 1c             	sub    $0x1c,%esp
  802417:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80241b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80241f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802423:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802427:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80242b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80242f:	89 f3                	mov    %esi,%ebx
  802431:	89 fa                	mov    %edi,%edx
  802433:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802437:	89 34 24             	mov    %esi,(%esp)
  80243a:	85 c0                	test   %eax,%eax
  80243c:	75 1a                	jne    802458 <__umoddi3+0x48>
  80243e:	39 f7                	cmp    %esi,%edi
  802440:	0f 86 a2 00 00 00    	jbe    8024e8 <__umoddi3+0xd8>
  802446:	89 c8                	mov    %ecx,%eax
  802448:	89 f2                	mov    %esi,%edx
  80244a:	f7 f7                	div    %edi
  80244c:	89 d0                	mov    %edx,%eax
  80244e:	31 d2                	xor    %edx,%edx
  802450:	83 c4 1c             	add    $0x1c,%esp
  802453:	5b                   	pop    %ebx
  802454:	5e                   	pop    %esi
  802455:	5f                   	pop    %edi
  802456:	5d                   	pop    %ebp
  802457:	c3                   	ret    
  802458:	39 f0                	cmp    %esi,%eax
  80245a:	0f 87 ac 00 00 00    	ja     80250c <__umoddi3+0xfc>
  802460:	0f bd e8             	bsr    %eax,%ebp
  802463:	83 f5 1f             	xor    $0x1f,%ebp
  802466:	0f 84 ac 00 00 00    	je     802518 <__umoddi3+0x108>
  80246c:	bf 20 00 00 00       	mov    $0x20,%edi
  802471:	29 ef                	sub    %ebp,%edi
  802473:	89 fe                	mov    %edi,%esi
  802475:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802479:	89 e9                	mov    %ebp,%ecx
  80247b:	d3 e0                	shl    %cl,%eax
  80247d:	89 d7                	mov    %edx,%edi
  80247f:	89 f1                	mov    %esi,%ecx
  802481:	d3 ef                	shr    %cl,%edi
  802483:	09 c7                	or     %eax,%edi
  802485:	89 e9                	mov    %ebp,%ecx
  802487:	d3 e2                	shl    %cl,%edx
  802489:	89 14 24             	mov    %edx,(%esp)
  80248c:	89 d8                	mov    %ebx,%eax
  80248e:	d3 e0                	shl    %cl,%eax
  802490:	89 c2                	mov    %eax,%edx
  802492:	8b 44 24 08          	mov    0x8(%esp),%eax
  802496:	d3 e0                	shl    %cl,%eax
  802498:	89 44 24 04          	mov    %eax,0x4(%esp)
  80249c:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024a0:	89 f1                	mov    %esi,%ecx
  8024a2:	d3 e8                	shr    %cl,%eax
  8024a4:	09 d0                	or     %edx,%eax
  8024a6:	d3 eb                	shr    %cl,%ebx
  8024a8:	89 da                	mov    %ebx,%edx
  8024aa:	f7 f7                	div    %edi
  8024ac:	89 d3                	mov    %edx,%ebx
  8024ae:	f7 24 24             	mull   (%esp)
  8024b1:	89 c6                	mov    %eax,%esi
  8024b3:	89 d1                	mov    %edx,%ecx
  8024b5:	39 d3                	cmp    %edx,%ebx
  8024b7:	0f 82 87 00 00 00    	jb     802544 <__umoddi3+0x134>
  8024bd:	0f 84 91 00 00 00    	je     802554 <__umoddi3+0x144>
  8024c3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024c7:	29 f2                	sub    %esi,%edx
  8024c9:	19 cb                	sbb    %ecx,%ebx
  8024cb:	89 d8                	mov    %ebx,%eax
  8024cd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024d1:	d3 e0                	shl    %cl,%eax
  8024d3:	89 e9                	mov    %ebp,%ecx
  8024d5:	d3 ea                	shr    %cl,%edx
  8024d7:	09 d0                	or     %edx,%eax
  8024d9:	89 e9                	mov    %ebp,%ecx
  8024db:	d3 eb                	shr    %cl,%ebx
  8024dd:	89 da                	mov    %ebx,%edx
  8024df:	83 c4 1c             	add    $0x1c,%esp
  8024e2:	5b                   	pop    %ebx
  8024e3:	5e                   	pop    %esi
  8024e4:	5f                   	pop    %edi
  8024e5:	5d                   	pop    %ebp
  8024e6:	c3                   	ret    
  8024e7:	90                   	nop
  8024e8:	89 fd                	mov    %edi,%ebp
  8024ea:	85 ff                	test   %edi,%edi
  8024ec:	75 0b                	jne    8024f9 <__umoddi3+0xe9>
  8024ee:	b8 01 00 00 00       	mov    $0x1,%eax
  8024f3:	31 d2                	xor    %edx,%edx
  8024f5:	f7 f7                	div    %edi
  8024f7:	89 c5                	mov    %eax,%ebp
  8024f9:	89 f0                	mov    %esi,%eax
  8024fb:	31 d2                	xor    %edx,%edx
  8024fd:	f7 f5                	div    %ebp
  8024ff:	89 c8                	mov    %ecx,%eax
  802501:	f7 f5                	div    %ebp
  802503:	89 d0                	mov    %edx,%eax
  802505:	e9 44 ff ff ff       	jmp    80244e <__umoddi3+0x3e>
  80250a:	66 90                	xchg   %ax,%ax
  80250c:	89 c8                	mov    %ecx,%eax
  80250e:	89 f2                	mov    %esi,%edx
  802510:	83 c4 1c             	add    $0x1c,%esp
  802513:	5b                   	pop    %ebx
  802514:	5e                   	pop    %esi
  802515:	5f                   	pop    %edi
  802516:	5d                   	pop    %ebp
  802517:	c3                   	ret    
  802518:	3b 04 24             	cmp    (%esp),%eax
  80251b:	72 06                	jb     802523 <__umoddi3+0x113>
  80251d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802521:	77 0f                	ja     802532 <__umoddi3+0x122>
  802523:	89 f2                	mov    %esi,%edx
  802525:	29 f9                	sub    %edi,%ecx
  802527:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80252b:	89 14 24             	mov    %edx,(%esp)
  80252e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802532:	8b 44 24 04          	mov    0x4(%esp),%eax
  802536:	8b 14 24             	mov    (%esp),%edx
  802539:	83 c4 1c             	add    $0x1c,%esp
  80253c:	5b                   	pop    %ebx
  80253d:	5e                   	pop    %esi
  80253e:	5f                   	pop    %edi
  80253f:	5d                   	pop    %ebp
  802540:	c3                   	ret    
  802541:	8d 76 00             	lea    0x0(%esi),%esi
  802544:	2b 04 24             	sub    (%esp),%eax
  802547:	19 fa                	sbb    %edi,%edx
  802549:	89 d1                	mov    %edx,%ecx
  80254b:	89 c6                	mov    %eax,%esi
  80254d:	e9 71 ff ff ff       	jmp    8024c3 <__umoddi3+0xb3>
  802552:	66 90                	xchg   %ax,%ax
  802554:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802558:	72 ea                	jb     802544 <__umoddi3+0x134>
  80255a:	89 d9                	mov    %ebx,%ecx
  80255c:	e9 62 ff ff ff       	jmp    8024c3 <__umoddi3+0xb3>
