
obj/user/mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 8f 07 00 00       	call   8007c5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

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
  800041:	e8 17 1f 00 00       	call   801f5d <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 a0 25 80 00       	push   $0x8025a0
  80004e:	e8 35 0b 00 00       	call   800b88 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 a2 25 80 00       	push   $0x8025a2
  80005e:	e8 25 0b 00 00       	call   800b88 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 b8 25 80 00       	push   $0x8025b8
  80006e:	e8 15 0b 00 00       	call   800b88 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 a2 25 80 00       	push   $0x8025a2
  80007e:	e8 05 0b 00 00       	call   800b88 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 a0 25 80 00       	push   $0x8025a0
  80008e:	e8 f5 0a 00 00       	call   800b88 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 d0 25 80 00       	push   $0x8025d0
  8000a5:	e8 60 11 00 00       	call   80120a <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 b0 16 00 00       	call   801770 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 43 1a 00 00       	call   801b18 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 f0 25 80 00       	push   $0x8025f0
  8000e3:	e8 a0 0a 00 00       	call   800b88 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 12 26 80 00       	push   $0x802612
  8000f3:	e8 90 0a 00 00       	call   800b88 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 20 26 80 00       	push   $0x802620
  800103:	e8 80 0a 00 00       	call   800b88 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 2f 26 80 00       	push   $0x80262f
  800113:	e8 70 0a 00 00       	call   800b88 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 3f 26 80 00       	push   $0x80263f
  800123:	e8 60 0a 00 00       	call   800b88 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 3d 06 00 00       	call   80076d <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 e5 05 00 00       	call   800725 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 d8 05 00 00       	call   800725 <cputchar>
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
  800162:	e8 10 1e 00 00       	call   801f77 <sys_enable_interrupt>

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
  800183:	e8 f4 01 00 00       	call   80037c <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 12 02 00 00       	call   8003ad <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 34 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 21 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 e0 02 00 00       	call   8004b4 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d7:	e8 81 1d 00 00       	call   801f5d <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 48 26 80 00       	push   $0x802648
  8001e4:	e8 9f 09 00 00       	call   800b88 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 86 1d 00 00       	call   801f77 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 d3 00 00 00       	call   8002d2 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 7c 26 80 00       	push   $0x80267c
  800213:	6a 4a                	push   $0x4a
  800215:	68 9e 26 80 00       	push   $0x80269e
  80021a:	e8 b5 06 00 00       	call   8008d4 <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 39 1d 00 00       	call   801f5d <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 bc 26 80 00       	push   $0x8026bc
  80022c:	e8 57 09 00 00       	call   800b88 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 f0 26 80 00       	push   $0x8026f0
  80023c:	e8 47 09 00 00       	call   800b88 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 24 27 80 00       	push   $0x802724
  80024c:	e8 37 09 00 00       	call   800b88 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 1e 1d 00 00       	call   801f77 <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 6c 1a 00 00       	call   801cd0 <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 f1 1c 00 00       	call   801f5d <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 56 27 80 00       	push   $0x802756
  80027a:	e8 09 09 00 00       	call   800b88 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 e6 04 00 00       	call   80076d <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 8e 04 00 00       	call   800725 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 81 04 00 00       	call   800725 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 74 04 00 00       	call   800725 <cputchar>
  8002b1:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002b4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b8:	74 06                	je     8002c0 <_main+0x288>
  8002ba:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002be:	75 b2                	jne    800272 <_main+0x23a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002c0:	e8 b2 1c 00 00       	call   801f77 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002c5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002c9:	0f 84 72 fd ff ff    	je     800041 <_main+0x9>

}
  8002cf:	90                   	nop
  8002d0:	c9                   	leave  
  8002d1:	c3                   	ret    

008002d2 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002d2:	55                   	push   %ebp
  8002d3:	89 e5                	mov    %esp,%ebp
  8002d5:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002d8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002e6:	eb 33                	jmp    80031b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f5:	01 d0                	add    %edx,%eax
  8002f7:	8b 10                	mov    (%eax),%edx
  8002f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002fc:	40                   	inc    %eax
  8002fd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800304:	8b 45 08             	mov    0x8(%ebp),%eax
  800307:	01 c8                	add    %ecx,%eax
  800309:	8b 00                	mov    (%eax),%eax
  80030b:	39 c2                	cmp    %eax,%edx
  80030d:	7e 09                	jle    800318 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80030f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800316:	eb 0c                	jmp    800324 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800318:	ff 45 f8             	incl   -0x8(%ebp)
  80031b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031e:	48                   	dec    %eax
  80031f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800322:	7f c4                	jg     8002e8 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800324:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800327:	c9                   	leave  
  800328:	c3                   	ret    

00800329 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80032f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 d0                	add    %edx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800343:	8b 45 0c             	mov    0xc(%ebp),%eax
  800346:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034d:	8b 45 08             	mov    0x8(%ebp),%eax
  800350:	01 c2                	add    %eax,%edx
  800352:	8b 45 10             	mov    0x10(%ebp),%eax
  800355:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035c:	8b 45 08             	mov    0x8(%ebp),%eax
  80035f:	01 c8                	add    %ecx,%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800365:	8b 45 10             	mov    0x10(%ebp),%eax
  800368:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036f:	8b 45 08             	mov    0x8(%ebp),%eax
  800372:	01 c2                	add    %eax,%edx
  800374:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800377:	89 02                	mov    %eax,(%edx)
}
  800379:	90                   	nop
  80037a:	c9                   	leave  
  80037b:	c3                   	ret    

0080037c <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80037c:	55                   	push   %ebp
  80037d:	89 e5                	mov    %esp,%ebp
  80037f:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800382:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800389:	eb 17                	jmp    8003a2 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80038b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	01 c2                	add    %eax,%edx
  80039a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80039d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80039f:	ff 45 fc             	incl   -0x4(%ebp)
  8003a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003a8:	7c e1                	jl     80038b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003aa:	90                   	nop
  8003ab:	c9                   	leave  
  8003ac:	c3                   	ret    

008003ad <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003ad:	55                   	push   %ebp
  8003ae:	89 e5                	mov    %esp,%ebp
  8003b0:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ba:	eb 1b                	jmp    8003d7 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	01 c2                	add    %eax,%edx
  8003cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ce:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003d1:	48                   	dec    %eax
  8003d2:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003d4:	ff 45 fc             	incl   -0x4(%ebp)
  8003d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003da:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003dd:	7c dd                	jl     8003bc <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003df:	90                   	nop
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003eb:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003f0:	f7 e9                	imul   %ecx
  8003f2:	c1 f9 1f             	sar    $0x1f,%ecx
  8003f5:	89 d0                	mov    %edx,%eax
  8003f7:	29 c8                	sub    %ecx,%eax
  8003f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800403:	eb 1e                	jmp    800423 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800405:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800408:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040f:	8b 45 08             	mov    0x8(%ebp),%eax
  800412:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	99                   	cltd   
  800419:	f7 7d f8             	idivl  -0x8(%ebp)
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800420:	ff 45 fc             	incl   -0x4(%ebp)
  800423:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800426:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800429:	7c da                	jl     800405 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80042b:	90                   	nop
  80042c:	c9                   	leave  
  80042d:	c3                   	ret    

0080042e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
  800431:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800434:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80043b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800442:	eb 42                	jmp    800486 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800444:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800447:	99                   	cltd   
  800448:	f7 7d f0             	idivl  -0x10(%ebp)
  80044b:	89 d0                	mov    %edx,%eax
  80044d:	85 c0                	test   %eax,%eax
  80044f:	75 10                	jne    800461 <PrintElements+0x33>
			cprintf("\n");
  800451:	83 ec 0c             	sub    $0xc,%esp
  800454:	68 a0 25 80 00       	push   $0x8025a0
  800459:	e8 2a 07 00 00       	call   800b88 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 74 27 80 00       	push   $0x802774
  80047b:	e8 08 07 00 00       	call   800b88 <cprintf>
  800480:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800483:	ff 45 f4             	incl   -0xc(%ebp)
  800486:	8b 45 0c             	mov    0xc(%ebp),%eax
  800489:	48                   	dec    %eax
  80048a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80048d:	7f b5                	jg     800444 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80048f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800492:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	01 d0                	add    %edx,%eax
  80049e:	8b 00                	mov    (%eax),%eax
  8004a0:	83 ec 08             	sub    $0x8,%esp
  8004a3:	50                   	push   %eax
  8004a4:	68 79 27 80 00       	push   $0x802779
  8004a9:	e8 da 06 00 00       	call   800b88 <cprintf>
  8004ae:	83 c4 10             	add    $0x10,%esp

}
  8004b1:	90                   	nop
  8004b2:	c9                   	leave  
  8004b3:	c3                   	ret    

008004b4 <MSort>:


void MSort(int* A, int p, int r)
{
  8004b4:	55                   	push   %ebp
  8004b5:	89 e5                	mov    %esp,%ebp
  8004b7:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004c0:	7d 54                	jge    800516 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c8:	01 d0                	add    %edx,%eax
  8004ca:	89 c2                	mov    %eax,%edx
  8004cc:	c1 ea 1f             	shr    $0x1f,%edx
  8004cf:	01 d0                	add    %edx,%eax
  8004d1:	d1 f8                	sar    %eax
  8004d3:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004d6:	83 ec 04             	sub    $0x4,%esp
  8004d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004dc:	ff 75 0c             	pushl  0xc(%ebp)
  8004df:	ff 75 08             	pushl  0x8(%ebp)
  8004e2:	e8 cd ff ff ff       	call   8004b4 <MSort>
  8004e7:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004ed:	40                   	inc    %eax
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	ff 75 10             	pushl  0x10(%ebp)
  8004f4:	50                   	push   %eax
  8004f5:	ff 75 08             	pushl  0x8(%ebp)
  8004f8:	e8 b7 ff ff ff       	call   8004b4 <MSort>
  8004fd:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800500:	ff 75 10             	pushl  0x10(%ebp)
  800503:	ff 75 f4             	pushl  -0xc(%ebp)
  800506:	ff 75 0c             	pushl  0xc(%ebp)
  800509:	ff 75 08             	pushl  0x8(%ebp)
  80050c:	e8 08 00 00 00       	call   800519 <Merge>
  800511:	83 c4 10             	add    $0x10,%esp
  800514:	eb 01                	jmp    800517 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800516:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800517:	c9                   	leave  
  800518:	c3                   	ret    

00800519 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800519:	55                   	push   %ebp
  80051a:	89 e5                	mov    %esp,%ebp
  80051c:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80051f:	8b 45 10             	mov    0x10(%ebp),%eax
  800522:	2b 45 0c             	sub    0xc(%ebp),%eax
  800525:	40                   	inc    %eax
  800526:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800529:	8b 45 14             	mov    0x14(%ebp),%eax
  80052c:	2b 45 10             	sub    0x10(%ebp),%eax
  80052f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800532:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800539:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	//cprintf("allocate LEFT\n");
	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 c9 15 00 00       	call   801b18 <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 b4 15 00 00       	call   801b18 <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80056a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800571:	eb 2f                	jmp    8005a2 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800573:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800576:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80057d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800580:	01 c2                	add    %eax,%edx
  800582:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800585:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800588:	01 c8                	add    %ecx,%eax
  80058a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80058f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	01 c8                	add    %ecx,%eax
  80059b:	8b 00                	mov    (%eax),%eax
  80059d:	89 02                	mov    %eax,(%edx)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80059f:	ff 45 ec             	incl   -0x14(%ebp)
  8005a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005a5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005a8:	7c c9                	jl     800573 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005aa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005b1:	eb 2a                	jmp    8005dd <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005c0:	01 c2                	add    %eax,%edx
  8005c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005c8:	01 c8                	add    %ecx,%eax
  8005ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	01 c8                	add    %ecx,%eax
  8005d6:	8b 00                	mov    (%eax),%eax
  8005d8:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005da:	ff 45 e8             	incl   -0x18(%ebp)
  8005dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005e0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005e3:	7c ce                	jl     8005b3 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005eb:	e9 0a 01 00 00       	jmp    8006fa <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005f6:	0f 8d 95 00 00 00    	jge    800691 <Merge+0x178>
  8005fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ff:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800602:	0f 8d 89 00 00 00    	jge    800691 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800608:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800612:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	8b 10                	mov    (%eax),%edx
  800619:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800623:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800626:	01 c8                	add    %ecx,%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	39 c2                	cmp    %eax,%edx
  80062c:	7d 33                	jge    800661 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80062e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800631:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800636:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063d:	8b 45 08             	mov    0x8(%ebp),%eax
  800640:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800643:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800646:	8d 50 01             	lea    0x1(%eax),%edx
  800649:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80064c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800653:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800656:	01 d0                	add    %edx,%eax
  800658:	8b 00                	mov    (%eax),%eax
  80065a:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80065c:	e9 96 00 00 00       	jmp    8006f7 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800661:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800664:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800669:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800676:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800679:	8d 50 01             	lea    0x1(%eax),%edx
  80067c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80067f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800686:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800689:	01 d0                	add    %edx,%eax
  80068b:	8b 00                	mov    (%eax),%eax
  80068d:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80068f:	eb 66                	jmp    8006f7 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800694:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800697:	7d 30                	jge    8006c9 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  800699:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80069c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006b1:	8d 50 01             	lea    0x1(%eax),%edx
  8006b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006c1:	01 d0                	add    %edx,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	89 01                	mov    %eax,(%ecx)
  8006c7:	eb 2e                	jmp    8006f7 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006cc:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e1:	8d 50 01             	lea    0x1(%eax),%edx
  8006e4:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006f1:	01 d0                	add    %edx,%eax
  8006f3:	8b 00                	mov    (%eax),%eax
  8006f5:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006f7:	ff 45 e4             	incl   -0x1c(%ebp)
  8006fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006fd:	3b 45 14             	cmp    0x14(%ebp),%eax
  800700:	0f 8e ea fe ff ff    	jle    8005f0 <Merge+0xd7>
			A[k - 1] = Right[rightIndex++];
		}
	}

	//cprintf("free LEFT\n");
	free(Left);
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	ff 75 d8             	pushl  -0x28(%ebp)
  80070c:	e8 bf 15 00 00       	call   801cd0 <free>
  800711:	83 c4 10             	add    $0x10,%esp
	//cprintf("free RIGHT\n");
	free(Right);
  800714:	83 ec 0c             	sub    $0xc,%esp
  800717:	ff 75 d4             	pushl  -0x2c(%ebp)
  80071a:	e8 b1 15 00 00       	call   801cd0 <free>
  80071f:	83 c4 10             	add    $0x10,%esp

}
  800722:	90                   	nop
  800723:	c9                   	leave  
  800724:	c3                   	ret    

00800725 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800725:	55                   	push   %ebp
  800726:	89 e5                	mov    %esp,%ebp
  800728:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800731:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800735:	83 ec 0c             	sub    $0xc,%esp
  800738:	50                   	push   %eax
  800739:	e8 53 18 00 00       	call   801f91 <sys_cputc>
  80073e:	83 c4 10             	add    $0x10,%esp
}
  800741:	90                   	nop
  800742:	c9                   	leave  
  800743:	c3                   	ret    

00800744 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800744:	55                   	push   %ebp
  800745:	89 e5                	mov    %esp,%ebp
  800747:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80074a:	e8 0e 18 00 00       	call   801f5d <sys_disable_interrupt>
	char c = ch;
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800755:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800759:	83 ec 0c             	sub    $0xc,%esp
  80075c:	50                   	push   %eax
  80075d:	e8 2f 18 00 00       	call   801f91 <sys_cputc>
  800762:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800765:	e8 0d 18 00 00       	call   801f77 <sys_enable_interrupt>
}
  80076a:	90                   	nop
  80076b:	c9                   	leave  
  80076c:	c3                   	ret    

0080076d <getchar>:

int
getchar(void)
{
  80076d:	55                   	push   %ebp
  80076e:	89 e5                	mov    %esp,%ebp
  800770:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800773:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80077a:	eb 08                	jmp    800784 <getchar+0x17>
	{
		c = sys_cgetc();
  80077c:	e8 f4 15 00 00       	call   801d75 <sys_cgetc>
  800781:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800784:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800788:	74 f2                	je     80077c <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80078a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80078d:	c9                   	leave  
  80078e:	c3                   	ret    

0080078f <atomic_getchar>:

int
atomic_getchar(void)
{
  80078f:	55                   	push   %ebp
  800790:	89 e5                	mov    %esp,%ebp
  800792:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800795:	e8 c3 17 00 00       	call   801f5d <sys_disable_interrupt>
	int c=0;
  80079a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007a1:	eb 08                	jmp    8007ab <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007a3:	e8 cd 15 00 00       	call   801d75 <sys_cgetc>
  8007a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8007ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007af:	74 f2                	je     8007a3 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007b1:	e8 c1 17 00 00       	call   801f77 <sys_enable_interrupt>
	return c;
  8007b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007b9:	c9                   	leave  
  8007ba:	c3                   	ret    

008007bb <iscons>:

int iscons(int fdnum)
{
  8007bb:	55                   	push   %ebp
  8007bc:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007be:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007c3:	5d                   	pop    %ebp
  8007c4:	c3                   	ret    

008007c5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007c5:	55                   	push   %ebp
  8007c6:	89 e5                	mov    %esp,%ebp
  8007c8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007cb:	e8 f2 15 00 00       	call   801dc2 <sys_getenvindex>
  8007d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d6:	89 d0                	mov    %edx,%eax
  8007d8:	c1 e0 02             	shl    $0x2,%eax
  8007db:	01 d0                	add    %edx,%eax
  8007dd:	01 c0                	add    %eax,%eax
  8007df:	01 d0                	add    %edx,%eax
  8007e1:	01 c0                	add    %eax,%eax
  8007e3:	01 d0                	add    %edx,%eax
  8007e5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007ec:	01 d0                	add    %edx,%eax
  8007ee:	c1 e0 02             	shl    $0x2,%eax
  8007f1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007f6:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007fb:	a1 24 30 80 00       	mov    0x803024,%eax
  800800:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800806:	84 c0                	test   %al,%al
  800808:	74 0f                	je     800819 <libmain+0x54>
		binaryname = myEnv->prog_name;
  80080a:	a1 24 30 80 00       	mov    0x803024,%eax
  80080f:	05 f4 02 00 00       	add    $0x2f4,%eax
  800814:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800819:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80081d:	7e 0a                	jle    800829 <libmain+0x64>
		binaryname = argv[0];
  80081f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800829:	83 ec 08             	sub    $0x8,%esp
  80082c:	ff 75 0c             	pushl  0xc(%ebp)
  80082f:	ff 75 08             	pushl  0x8(%ebp)
  800832:	e8 01 f8 ff ff       	call   800038 <_main>
  800837:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80083a:	e8 1e 17 00 00       	call   801f5d <sys_disable_interrupt>
	cprintf("**************************************\n");
  80083f:	83 ec 0c             	sub    $0xc,%esp
  800842:	68 98 27 80 00       	push   $0x802798
  800847:	e8 3c 03 00 00       	call   800b88 <cprintf>
  80084c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80084f:	a1 24 30 80 00       	mov    0x803024,%eax
  800854:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80085a:	a1 24 30 80 00       	mov    0x803024,%eax
  80085f:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800865:	83 ec 04             	sub    $0x4,%esp
  800868:	52                   	push   %edx
  800869:	50                   	push   %eax
  80086a:	68 c0 27 80 00       	push   $0x8027c0
  80086f:	e8 14 03 00 00       	call   800b88 <cprintf>
  800874:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800877:	a1 24 30 80 00       	mov    0x803024,%eax
  80087c:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800882:	83 ec 08             	sub    $0x8,%esp
  800885:	50                   	push   %eax
  800886:	68 e5 27 80 00       	push   $0x8027e5
  80088b:	e8 f8 02 00 00       	call   800b88 <cprintf>
  800890:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800893:	83 ec 0c             	sub    $0xc,%esp
  800896:	68 98 27 80 00       	push   $0x802798
  80089b:	e8 e8 02 00 00       	call   800b88 <cprintf>
  8008a0:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008a3:	e8 cf 16 00 00       	call   801f77 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008a8:	e8 19 00 00 00       	call   8008c6 <exit>
}
  8008ad:	90                   	nop
  8008ae:	c9                   	leave  
  8008af:	c3                   	ret    

008008b0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008b0:	55                   	push   %ebp
  8008b1:	89 e5                	mov    %esp,%ebp
  8008b3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008b6:	83 ec 0c             	sub    $0xc,%esp
  8008b9:	6a 00                	push   $0x0
  8008bb:	e8 ce 14 00 00       	call   801d8e <sys_env_destroy>
  8008c0:	83 c4 10             	add    $0x10,%esp
}
  8008c3:	90                   	nop
  8008c4:	c9                   	leave  
  8008c5:	c3                   	ret    

008008c6 <exit>:

void
exit(void)
{
  8008c6:	55                   	push   %ebp
  8008c7:	89 e5                	mov    %esp,%ebp
  8008c9:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008cc:	e8 23 15 00 00       	call   801df4 <sys_env_exit>
}
  8008d1:	90                   	nop
  8008d2:	c9                   	leave  
  8008d3:	c3                   	ret    

008008d4 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008d4:	55                   	push   %ebp
  8008d5:	89 e5                	mov    %esp,%ebp
  8008d7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008da:	8d 45 10             	lea    0x10(%ebp),%eax
  8008dd:	83 c0 04             	add    $0x4,%eax
  8008e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008e3:	a1 38 30 80 00       	mov    0x803038,%eax
  8008e8:	85 c0                	test   %eax,%eax
  8008ea:	74 16                	je     800902 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008ec:	a1 38 30 80 00       	mov    0x803038,%eax
  8008f1:	83 ec 08             	sub    $0x8,%esp
  8008f4:	50                   	push   %eax
  8008f5:	68 fc 27 80 00       	push   $0x8027fc
  8008fa:	e8 89 02 00 00       	call   800b88 <cprintf>
  8008ff:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800902:	a1 00 30 80 00       	mov    0x803000,%eax
  800907:	ff 75 0c             	pushl  0xc(%ebp)
  80090a:	ff 75 08             	pushl  0x8(%ebp)
  80090d:	50                   	push   %eax
  80090e:	68 01 28 80 00       	push   $0x802801
  800913:	e8 70 02 00 00       	call   800b88 <cprintf>
  800918:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80091b:	8b 45 10             	mov    0x10(%ebp),%eax
  80091e:	83 ec 08             	sub    $0x8,%esp
  800921:	ff 75 f4             	pushl  -0xc(%ebp)
  800924:	50                   	push   %eax
  800925:	e8 f3 01 00 00       	call   800b1d <vcprintf>
  80092a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80092d:	83 ec 08             	sub    $0x8,%esp
  800930:	6a 00                	push   $0x0
  800932:	68 1d 28 80 00       	push   $0x80281d
  800937:	e8 e1 01 00 00       	call   800b1d <vcprintf>
  80093c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80093f:	e8 82 ff ff ff       	call   8008c6 <exit>

	// should not return here
	while (1) ;
  800944:	eb fe                	jmp    800944 <_panic+0x70>

00800946 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800946:	55                   	push   %ebp
  800947:	89 e5                	mov    %esp,%ebp
  800949:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80094c:	a1 24 30 80 00       	mov    0x803024,%eax
  800951:	8b 50 74             	mov    0x74(%eax),%edx
  800954:	8b 45 0c             	mov    0xc(%ebp),%eax
  800957:	39 c2                	cmp    %eax,%edx
  800959:	74 14                	je     80096f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80095b:	83 ec 04             	sub    $0x4,%esp
  80095e:	68 20 28 80 00       	push   $0x802820
  800963:	6a 26                	push   $0x26
  800965:	68 6c 28 80 00       	push   $0x80286c
  80096a:	e8 65 ff ff ff       	call   8008d4 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80096f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800976:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80097d:	e9 c2 00 00 00       	jmp    800a44 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800982:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800985:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80098c:	8b 45 08             	mov    0x8(%ebp),%eax
  80098f:	01 d0                	add    %edx,%eax
  800991:	8b 00                	mov    (%eax),%eax
  800993:	85 c0                	test   %eax,%eax
  800995:	75 08                	jne    80099f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800997:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80099a:	e9 a2 00 00 00       	jmp    800a41 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80099f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009a6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009ad:	eb 69                	jmp    800a18 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009af:	a1 24 30 80 00       	mov    0x803024,%eax
  8009b4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009ba:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009bd:	89 d0                	mov    %edx,%eax
  8009bf:	01 c0                	add    %eax,%eax
  8009c1:	01 d0                	add    %edx,%eax
  8009c3:	c1 e0 02             	shl    $0x2,%eax
  8009c6:	01 c8                	add    %ecx,%eax
  8009c8:	8a 40 04             	mov    0x4(%eax),%al
  8009cb:	84 c0                	test   %al,%al
  8009cd:	75 46                	jne    800a15 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009cf:	a1 24 30 80 00       	mov    0x803024,%eax
  8009d4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009da:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009dd:	89 d0                	mov    %edx,%eax
  8009df:	01 c0                	add    %eax,%eax
  8009e1:	01 d0                	add    %edx,%eax
  8009e3:	c1 e0 02             	shl    $0x2,%eax
  8009e6:	01 c8                	add    %ecx,%eax
  8009e8:	8b 00                	mov    (%eax),%eax
  8009ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009ed:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009f5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009fa:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	01 c8                	add    %ecx,%eax
  800a06:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a08:	39 c2                	cmp    %eax,%edx
  800a0a:	75 09                	jne    800a15 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800a0c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a13:	eb 12                	jmp    800a27 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a15:	ff 45 e8             	incl   -0x18(%ebp)
  800a18:	a1 24 30 80 00       	mov    0x803024,%eax
  800a1d:	8b 50 74             	mov    0x74(%eax),%edx
  800a20:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a23:	39 c2                	cmp    %eax,%edx
  800a25:	77 88                	ja     8009af <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a27:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a2b:	75 14                	jne    800a41 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a2d:	83 ec 04             	sub    $0x4,%esp
  800a30:	68 78 28 80 00       	push   $0x802878
  800a35:	6a 3a                	push   $0x3a
  800a37:	68 6c 28 80 00       	push   $0x80286c
  800a3c:	e8 93 fe ff ff       	call   8008d4 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a41:	ff 45 f0             	incl   -0x10(%ebp)
  800a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a47:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a4a:	0f 8c 32 ff ff ff    	jl     800982 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a57:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a5e:	eb 26                	jmp    800a86 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a60:	a1 24 30 80 00       	mov    0x803024,%eax
  800a65:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a6b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a6e:	89 d0                	mov    %edx,%eax
  800a70:	01 c0                	add    %eax,%eax
  800a72:	01 d0                	add    %edx,%eax
  800a74:	c1 e0 02             	shl    $0x2,%eax
  800a77:	01 c8                	add    %ecx,%eax
  800a79:	8a 40 04             	mov    0x4(%eax),%al
  800a7c:	3c 01                	cmp    $0x1,%al
  800a7e:	75 03                	jne    800a83 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a80:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a83:	ff 45 e0             	incl   -0x20(%ebp)
  800a86:	a1 24 30 80 00       	mov    0x803024,%eax
  800a8b:	8b 50 74             	mov    0x74(%eax),%edx
  800a8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a91:	39 c2                	cmp    %eax,%edx
  800a93:	77 cb                	ja     800a60 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a98:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a9b:	74 14                	je     800ab1 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800a9d:	83 ec 04             	sub    $0x4,%esp
  800aa0:	68 cc 28 80 00       	push   $0x8028cc
  800aa5:	6a 44                	push   $0x44
  800aa7:	68 6c 28 80 00       	push   $0x80286c
  800aac:	e8 23 fe ff ff       	call   8008d4 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ab1:	90                   	nop
  800ab2:	c9                   	leave  
  800ab3:	c3                   	ret    

00800ab4 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ab4:	55                   	push   %ebp
  800ab5:	89 e5                	mov    %esp,%ebp
  800ab7:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800aba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abd:	8b 00                	mov    (%eax),%eax
  800abf:	8d 48 01             	lea    0x1(%eax),%ecx
  800ac2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac5:	89 0a                	mov    %ecx,(%edx)
  800ac7:	8b 55 08             	mov    0x8(%ebp),%edx
  800aca:	88 d1                	mov    %dl,%cl
  800acc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800acf:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ad3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad6:	8b 00                	mov    (%eax),%eax
  800ad8:	3d ff 00 00 00       	cmp    $0xff,%eax
  800add:	75 2c                	jne    800b0b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800adf:	a0 28 30 80 00       	mov    0x803028,%al
  800ae4:	0f b6 c0             	movzbl %al,%eax
  800ae7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aea:	8b 12                	mov    (%edx),%edx
  800aec:	89 d1                	mov    %edx,%ecx
  800aee:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af1:	83 c2 08             	add    $0x8,%edx
  800af4:	83 ec 04             	sub    $0x4,%esp
  800af7:	50                   	push   %eax
  800af8:	51                   	push   %ecx
  800af9:	52                   	push   %edx
  800afa:	e8 4d 12 00 00       	call   801d4c <sys_cputs>
  800aff:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b05:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0e:	8b 40 04             	mov    0x4(%eax),%eax
  800b11:	8d 50 01             	lea    0x1(%eax),%edx
  800b14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b17:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b1a:	90                   	nop
  800b1b:	c9                   	leave  
  800b1c:	c3                   	ret    

00800b1d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b1d:	55                   	push   %ebp
  800b1e:	89 e5                	mov    %esp,%ebp
  800b20:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b26:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b2d:	00 00 00 
	b.cnt = 0;
  800b30:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b37:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b3a:	ff 75 0c             	pushl  0xc(%ebp)
  800b3d:	ff 75 08             	pushl  0x8(%ebp)
  800b40:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b46:	50                   	push   %eax
  800b47:	68 b4 0a 80 00       	push   $0x800ab4
  800b4c:	e8 11 02 00 00       	call   800d62 <vprintfmt>
  800b51:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b54:	a0 28 30 80 00       	mov    0x803028,%al
  800b59:	0f b6 c0             	movzbl %al,%eax
  800b5c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b62:	83 ec 04             	sub    $0x4,%esp
  800b65:	50                   	push   %eax
  800b66:	52                   	push   %edx
  800b67:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b6d:	83 c0 08             	add    $0x8,%eax
  800b70:	50                   	push   %eax
  800b71:	e8 d6 11 00 00       	call   801d4c <sys_cputs>
  800b76:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b79:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b80:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b86:	c9                   	leave  
  800b87:	c3                   	ret    

00800b88 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b88:	55                   	push   %ebp
  800b89:	89 e5                	mov    %esp,%ebp
  800b8b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b8e:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b95:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b98:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	83 ec 08             	sub    $0x8,%esp
  800ba1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba4:	50                   	push   %eax
  800ba5:	e8 73 ff ff ff       	call   800b1d <vcprintf>
  800baa:	83 c4 10             	add    $0x10,%esp
  800bad:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bb3:	c9                   	leave  
  800bb4:	c3                   	ret    

00800bb5 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bb5:	55                   	push   %ebp
  800bb6:	89 e5                	mov    %esp,%ebp
  800bb8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bbb:	e8 9d 13 00 00       	call   801f5d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bc0:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	83 ec 08             	sub    $0x8,%esp
  800bcc:	ff 75 f4             	pushl  -0xc(%ebp)
  800bcf:	50                   	push   %eax
  800bd0:	e8 48 ff ff ff       	call   800b1d <vcprintf>
  800bd5:	83 c4 10             	add    $0x10,%esp
  800bd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bdb:	e8 97 13 00 00       	call   801f77 <sys_enable_interrupt>
	return cnt;
  800be0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800be3:	c9                   	leave  
  800be4:	c3                   	ret    

00800be5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800be5:	55                   	push   %ebp
  800be6:	89 e5                	mov    %esp,%ebp
  800be8:	53                   	push   %ebx
  800be9:	83 ec 14             	sub    $0x14,%esp
  800bec:	8b 45 10             	mov    0x10(%ebp),%eax
  800bef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf2:	8b 45 14             	mov    0x14(%ebp),%eax
  800bf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bf8:	8b 45 18             	mov    0x18(%ebp),%eax
  800bfb:	ba 00 00 00 00       	mov    $0x0,%edx
  800c00:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c03:	77 55                	ja     800c5a <printnum+0x75>
  800c05:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c08:	72 05                	jb     800c0f <printnum+0x2a>
  800c0a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c0d:	77 4b                	ja     800c5a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c0f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c12:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c15:	8b 45 18             	mov    0x18(%ebp),%eax
  800c18:	ba 00 00 00 00       	mov    $0x0,%edx
  800c1d:	52                   	push   %edx
  800c1e:	50                   	push   %eax
  800c1f:	ff 75 f4             	pushl  -0xc(%ebp)
  800c22:	ff 75 f0             	pushl  -0x10(%ebp)
  800c25:	e8 12 17 00 00       	call   80233c <__udivdi3>
  800c2a:	83 c4 10             	add    $0x10,%esp
  800c2d:	83 ec 04             	sub    $0x4,%esp
  800c30:	ff 75 20             	pushl  0x20(%ebp)
  800c33:	53                   	push   %ebx
  800c34:	ff 75 18             	pushl  0x18(%ebp)
  800c37:	52                   	push   %edx
  800c38:	50                   	push   %eax
  800c39:	ff 75 0c             	pushl  0xc(%ebp)
  800c3c:	ff 75 08             	pushl  0x8(%ebp)
  800c3f:	e8 a1 ff ff ff       	call   800be5 <printnum>
  800c44:	83 c4 20             	add    $0x20,%esp
  800c47:	eb 1a                	jmp    800c63 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c49:	83 ec 08             	sub    $0x8,%esp
  800c4c:	ff 75 0c             	pushl  0xc(%ebp)
  800c4f:	ff 75 20             	pushl  0x20(%ebp)
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	ff d0                	call   *%eax
  800c57:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c5a:	ff 4d 1c             	decl   0x1c(%ebp)
  800c5d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c61:	7f e6                	jg     800c49 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c63:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c66:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c71:	53                   	push   %ebx
  800c72:	51                   	push   %ecx
  800c73:	52                   	push   %edx
  800c74:	50                   	push   %eax
  800c75:	e8 d2 17 00 00       	call   80244c <__umoddi3>
  800c7a:	83 c4 10             	add    $0x10,%esp
  800c7d:	05 34 2b 80 00       	add    $0x802b34,%eax
  800c82:	8a 00                	mov    (%eax),%al
  800c84:	0f be c0             	movsbl %al,%eax
  800c87:	83 ec 08             	sub    $0x8,%esp
  800c8a:	ff 75 0c             	pushl  0xc(%ebp)
  800c8d:	50                   	push   %eax
  800c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c91:	ff d0                	call   *%eax
  800c93:	83 c4 10             	add    $0x10,%esp
}
  800c96:	90                   	nop
  800c97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c9a:	c9                   	leave  
  800c9b:	c3                   	ret    

00800c9c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c9c:	55                   	push   %ebp
  800c9d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c9f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ca3:	7e 1c                	jle    800cc1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca8:	8b 00                	mov    (%eax),%eax
  800caa:	8d 50 08             	lea    0x8(%eax),%edx
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	89 10                	mov    %edx,(%eax)
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8b 00                	mov    (%eax),%eax
  800cb7:	83 e8 08             	sub    $0x8,%eax
  800cba:	8b 50 04             	mov    0x4(%eax),%edx
  800cbd:	8b 00                	mov    (%eax),%eax
  800cbf:	eb 40                	jmp    800d01 <getuint+0x65>
	else if (lflag)
  800cc1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cc5:	74 1e                	je     800ce5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cca:	8b 00                	mov    (%eax),%eax
  800ccc:	8d 50 04             	lea    0x4(%eax),%edx
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	89 10                	mov    %edx,(%eax)
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8b 00                	mov    (%eax),%eax
  800cd9:	83 e8 04             	sub    $0x4,%eax
  800cdc:	8b 00                	mov    (%eax),%eax
  800cde:	ba 00 00 00 00       	mov    $0x0,%edx
  800ce3:	eb 1c                	jmp    800d01 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8b 00                	mov    (%eax),%eax
  800cea:	8d 50 04             	lea    0x4(%eax),%edx
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	89 10                	mov    %edx,(%eax)
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	8b 00                	mov    (%eax),%eax
  800cf7:	83 e8 04             	sub    $0x4,%eax
  800cfa:	8b 00                	mov    (%eax),%eax
  800cfc:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d01:	5d                   	pop    %ebp
  800d02:	c3                   	ret    

00800d03 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d03:	55                   	push   %ebp
  800d04:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d06:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d0a:	7e 1c                	jle    800d28 <getint+0x25>
		return va_arg(*ap, long long);
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	8b 00                	mov    (%eax),%eax
  800d11:	8d 50 08             	lea    0x8(%eax),%edx
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	89 10                	mov    %edx,(%eax)
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8b 00                	mov    (%eax),%eax
  800d1e:	83 e8 08             	sub    $0x8,%eax
  800d21:	8b 50 04             	mov    0x4(%eax),%edx
  800d24:	8b 00                	mov    (%eax),%eax
  800d26:	eb 38                	jmp    800d60 <getint+0x5d>
	else if (lflag)
  800d28:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d2c:	74 1a                	je     800d48 <getint+0x45>
		return va_arg(*ap, long);
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	8b 00                	mov    (%eax),%eax
  800d33:	8d 50 04             	lea    0x4(%eax),%edx
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	89 10                	mov    %edx,(%eax)
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8b 00                	mov    (%eax),%eax
  800d40:	83 e8 04             	sub    $0x4,%eax
  800d43:	8b 00                	mov    (%eax),%eax
  800d45:	99                   	cltd   
  800d46:	eb 18                	jmp    800d60 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8b 00                	mov    (%eax),%eax
  800d4d:	8d 50 04             	lea    0x4(%eax),%edx
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	89 10                	mov    %edx,(%eax)
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8b 00                	mov    (%eax),%eax
  800d5a:	83 e8 04             	sub    $0x4,%eax
  800d5d:	8b 00                	mov    (%eax),%eax
  800d5f:	99                   	cltd   
}
  800d60:	5d                   	pop    %ebp
  800d61:	c3                   	ret    

00800d62 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d62:	55                   	push   %ebp
  800d63:	89 e5                	mov    %esp,%ebp
  800d65:	56                   	push   %esi
  800d66:	53                   	push   %ebx
  800d67:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d6a:	eb 17                	jmp    800d83 <vprintfmt+0x21>
			if (ch == '\0')
  800d6c:	85 db                	test   %ebx,%ebx
  800d6e:	0f 84 af 03 00 00    	je     801123 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d74:	83 ec 08             	sub    $0x8,%esp
  800d77:	ff 75 0c             	pushl  0xc(%ebp)
  800d7a:	53                   	push   %ebx
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	ff d0                	call   *%eax
  800d80:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d83:	8b 45 10             	mov    0x10(%ebp),%eax
  800d86:	8d 50 01             	lea    0x1(%eax),%edx
  800d89:	89 55 10             	mov    %edx,0x10(%ebp)
  800d8c:	8a 00                	mov    (%eax),%al
  800d8e:	0f b6 d8             	movzbl %al,%ebx
  800d91:	83 fb 25             	cmp    $0x25,%ebx
  800d94:	75 d6                	jne    800d6c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d96:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d9a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800da1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800da8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800daf:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800db6:	8b 45 10             	mov    0x10(%ebp),%eax
  800db9:	8d 50 01             	lea    0x1(%eax),%edx
  800dbc:	89 55 10             	mov    %edx,0x10(%ebp)
  800dbf:	8a 00                	mov    (%eax),%al
  800dc1:	0f b6 d8             	movzbl %al,%ebx
  800dc4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dc7:	83 f8 55             	cmp    $0x55,%eax
  800dca:	0f 87 2b 03 00 00    	ja     8010fb <vprintfmt+0x399>
  800dd0:	8b 04 85 58 2b 80 00 	mov    0x802b58(,%eax,4),%eax
  800dd7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dd9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ddd:	eb d7                	jmp    800db6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ddf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800de3:	eb d1                	jmp    800db6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800de5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800dec:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800def:	89 d0                	mov    %edx,%eax
  800df1:	c1 e0 02             	shl    $0x2,%eax
  800df4:	01 d0                	add    %edx,%eax
  800df6:	01 c0                	add    %eax,%eax
  800df8:	01 d8                	add    %ebx,%eax
  800dfa:	83 e8 30             	sub    $0x30,%eax
  800dfd:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e00:	8b 45 10             	mov    0x10(%ebp),%eax
  800e03:	8a 00                	mov    (%eax),%al
  800e05:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e08:	83 fb 2f             	cmp    $0x2f,%ebx
  800e0b:	7e 3e                	jle    800e4b <vprintfmt+0xe9>
  800e0d:	83 fb 39             	cmp    $0x39,%ebx
  800e10:	7f 39                	jg     800e4b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e12:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e15:	eb d5                	jmp    800dec <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e17:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1a:	83 c0 04             	add    $0x4,%eax
  800e1d:	89 45 14             	mov    %eax,0x14(%ebp)
  800e20:	8b 45 14             	mov    0x14(%ebp),%eax
  800e23:	83 e8 04             	sub    $0x4,%eax
  800e26:	8b 00                	mov    (%eax),%eax
  800e28:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e2b:	eb 1f                	jmp    800e4c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e2d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e31:	79 83                	jns    800db6 <vprintfmt+0x54>
				width = 0;
  800e33:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e3a:	e9 77 ff ff ff       	jmp    800db6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e3f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e46:	e9 6b ff ff ff       	jmp    800db6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e4b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e4c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e50:	0f 89 60 ff ff ff    	jns    800db6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e56:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e59:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e5c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e63:	e9 4e ff ff ff       	jmp    800db6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e68:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e6b:	e9 46 ff ff ff       	jmp    800db6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e70:	8b 45 14             	mov    0x14(%ebp),%eax
  800e73:	83 c0 04             	add    $0x4,%eax
  800e76:	89 45 14             	mov    %eax,0x14(%ebp)
  800e79:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7c:	83 e8 04             	sub    $0x4,%eax
  800e7f:	8b 00                	mov    (%eax),%eax
  800e81:	83 ec 08             	sub    $0x8,%esp
  800e84:	ff 75 0c             	pushl  0xc(%ebp)
  800e87:	50                   	push   %eax
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	ff d0                	call   *%eax
  800e8d:	83 c4 10             	add    $0x10,%esp
			break;
  800e90:	e9 89 02 00 00       	jmp    80111e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e95:	8b 45 14             	mov    0x14(%ebp),%eax
  800e98:	83 c0 04             	add    $0x4,%eax
  800e9b:	89 45 14             	mov    %eax,0x14(%ebp)
  800e9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea1:	83 e8 04             	sub    $0x4,%eax
  800ea4:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ea6:	85 db                	test   %ebx,%ebx
  800ea8:	79 02                	jns    800eac <vprintfmt+0x14a>
				err = -err;
  800eaa:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800eac:	83 fb 64             	cmp    $0x64,%ebx
  800eaf:	7f 0b                	jg     800ebc <vprintfmt+0x15a>
  800eb1:	8b 34 9d a0 29 80 00 	mov    0x8029a0(,%ebx,4),%esi
  800eb8:	85 f6                	test   %esi,%esi
  800eba:	75 19                	jne    800ed5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ebc:	53                   	push   %ebx
  800ebd:	68 45 2b 80 00       	push   $0x802b45
  800ec2:	ff 75 0c             	pushl  0xc(%ebp)
  800ec5:	ff 75 08             	pushl  0x8(%ebp)
  800ec8:	e8 5e 02 00 00       	call   80112b <printfmt>
  800ecd:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ed0:	e9 49 02 00 00       	jmp    80111e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ed5:	56                   	push   %esi
  800ed6:	68 4e 2b 80 00       	push   $0x802b4e
  800edb:	ff 75 0c             	pushl  0xc(%ebp)
  800ede:	ff 75 08             	pushl  0x8(%ebp)
  800ee1:	e8 45 02 00 00       	call   80112b <printfmt>
  800ee6:	83 c4 10             	add    $0x10,%esp
			break;
  800ee9:	e9 30 02 00 00       	jmp    80111e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800eee:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef1:	83 c0 04             	add    $0x4,%eax
  800ef4:	89 45 14             	mov    %eax,0x14(%ebp)
  800ef7:	8b 45 14             	mov    0x14(%ebp),%eax
  800efa:	83 e8 04             	sub    $0x4,%eax
  800efd:	8b 30                	mov    (%eax),%esi
  800eff:	85 f6                	test   %esi,%esi
  800f01:	75 05                	jne    800f08 <vprintfmt+0x1a6>
				p = "(null)";
  800f03:	be 51 2b 80 00       	mov    $0x802b51,%esi
			if (width > 0 && padc != '-')
  800f08:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f0c:	7e 6d                	jle    800f7b <vprintfmt+0x219>
  800f0e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f12:	74 67                	je     800f7b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f14:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f17:	83 ec 08             	sub    $0x8,%esp
  800f1a:	50                   	push   %eax
  800f1b:	56                   	push   %esi
  800f1c:	e8 12 05 00 00       	call   801433 <strnlen>
  800f21:	83 c4 10             	add    $0x10,%esp
  800f24:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f27:	eb 16                	jmp    800f3f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f29:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f2d:	83 ec 08             	sub    $0x8,%esp
  800f30:	ff 75 0c             	pushl  0xc(%ebp)
  800f33:	50                   	push   %eax
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	ff d0                	call   *%eax
  800f39:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f3c:	ff 4d e4             	decl   -0x1c(%ebp)
  800f3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f43:	7f e4                	jg     800f29 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f45:	eb 34                	jmp    800f7b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f47:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f4b:	74 1c                	je     800f69 <vprintfmt+0x207>
  800f4d:	83 fb 1f             	cmp    $0x1f,%ebx
  800f50:	7e 05                	jle    800f57 <vprintfmt+0x1f5>
  800f52:	83 fb 7e             	cmp    $0x7e,%ebx
  800f55:	7e 12                	jle    800f69 <vprintfmt+0x207>
					putch('?', putdat);
  800f57:	83 ec 08             	sub    $0x8,%esp
  800f5a:	ff 75 0c             	pushl  0xc(%ebp)
  800f5d:	6a 3f                	push   $0x3f
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	ff d0                	call   *%eax
  800f64:	83 c4 10             	add    $0x10,%esp
  800f67:	eb 0f                	jmp    800f78 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f69:	83 ec 08             	sub    $0x8,%esp
  800f6c:	ff 75 0c             	pushl  0xc(%ebp)
  800f6f:	53                   	push   %ebx
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	ff d0                	call   *%eax
  800f75:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f78:	ff 4d e4             	decl   -0x1c(%ebp)
  800f7b:	89 f0                	mov    %esi,%eax
  800f7d:	8d 70 01             	lea    0x1(%eax),%esi
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	0f be d8             	movsbl %al,%ebx
  800f85:	85 db                	test   %ebx,%ebx
  800f87:	74 24                	je     800fad <vprintfmt+0x24b>
  800f89:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f8d:	78 b8                	js     800f47 <vprintfmt+0x1e5>
  800f8f:	ff 4d e0             	decl   -0x20(%ebp)
  800f92:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f96:	79 af                	jns    800f47 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f98:	eb 13                	jmp    800fad <vprintfmt+0x24b>
				putch(' ', putdat);
  800f9a:	83 ec 08             	sub    $0x8,%esp
  800f9d:	ff 75 0c             	pushl  0xc(%ebp)
  800fa0:	6a 20                	push   $0x20
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	ff d0                	call   *%eax
  800fa7:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800faa:	ff 4d e4             	decl   -0x1c(%ebp)
  800fad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fb1:	7f e7                	jg     800f9a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fb3:	e9 66 01 00 00       	jmp    80111e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fb8:	83 ec 08             	sub    $0x8,%esp
  800fbb:	ff 75 e8             	pushl  -0x18(%ebp)
  800fbe:	8d 45 14             	lea    0x14(%ebp),%eax
  800fc1:	50                   	push   %eax
  800fc2:	e8 3c fd ff ff       	call   800d03 <getint>
  800fc7:	83 c4 10             	add    $0x10,%esp
  800fca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fcd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fd3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd6:	85 d2                	test   %edx,%edx
  800fd8:	79 23                	jns    800ffd <vprintfmt+0x29b>
				putch('-', putdat);
  800fda:	83 ec 08             	sub    $0x8,%esp
  800fdd:	ff 75 0c             	pushl  0xc(%ebp)
  800fe0:	6a 2d                	push   $0x2d
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	ff d0                	call   *%eax
  800fe7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ff0:	f7 d8                	neg    %eax
  800ff2:	83 d2 00             	adc    $0x0,%edx
  800ff5:	f7 da                	neg    %edx
  800ff7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ffa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ffd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801004:	e9 bc 00 00 00       	jmp    8010c5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801009:	83 ec 08             	sub    $0x8,%esp
  80100c:	ff 75 e8             	pushl  -0x18(%ebp)
  80100f:	8d 45 14             	lea    0x14(%ebp),%eax
  801012:	50                   	push   %eax
  801013:	e8 84 fc ff ff       	call   800c9c <getuint>
  801018:	83 c4 10             	add    $0x10,%esp
  80101b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80101e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801021:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801028:	e9 98 00 00 00       	jmp    8010c5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80102d:	83 ec 08             	sub    $0x8,%esp
  801030:	ff 75 0c             	pushl  0xc(%ebp)
  801033:	6a 58                	push   $0x58
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	ff d0                	call   *%eax
  80103a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80103d:	83 ec 08             	sub    $0x8,%esp
  801040:	ff 75 0c             	pushl  0xc(%ebp)
  801043:	6a 58                	push   $0x58
  801045:	8b 45 08             	mov    0x8(%ebp),%eax
  801048:	ff d0                	call   *%eax
  80104a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80104d:	83 ec 08             	sub    $0x8,%esp
  801050:	ff 75 0c             	pushl  0xc(%ebp)
  801053:	6a 58                	push   $0x58
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	ff d0                	call   *%eax
  80105a:	83 c4 10             	add    $0x10,%esp
			break;
  80105d:	e9 bc 00 00 00       	jmp    80111e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801062:	83 ec 08             	sub    $0x8,%esp
  801065:	ff 75 0c             	pushl  0xc(%ebp)
  801068:	6a 30                	push   $0x30
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	ff d0                	call   *%eax
  80106f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801072:	83 ec 08             	sub    $0x8,%esp
  801075:	ff 75 0c             	pushl  0xc(%ebp)
  801078:	6a 78                	push   $0x78
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	ff d0                	call   *%eax
  80107f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801082:	8b 45 14             	mov    0x14(%ebp),%eax
  801085:	83 c0 04             	add    $0x4,%eax
  801088:	89 45 14             	mov    %eax,0x14(%ebp)
  80108b:	8b 45 14             	mov    0x14(%ebp),%eax
  80108e:	83 e8 04             	sub    $0x4,%eax
  801091:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801093:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801096:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80109d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010a4:	eb 1f                	jmp    8010c5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010a6:	83 ec 08             	sub    $0x8,%esp
  8010a9:	ff 75 e8             	pushl  -0x18(%ebp)
  8010ac:	8d 45 14             	lea    0x14(%ebp),%eax
  8010af:	50                   	push   %eax
  8010b0:	e8 e7 fb ff ff       	call   800c9c <getuint>
  8010b5:	83 c4 10             	add    $0x10,%esp
  8010b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010be:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010c5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010cc:	83 ec 04             	sub    $0x4,%esp
  8010cf:	52                   	push   %edx
  8010d0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010d3:	50                   	push   %eax
  8010d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d7:	ff 75 f0             	pushl  -0x10(%ebp)
  8010da:	ff 75 0c             	pushl  0xc(%ebp)
  8010dd:	ff 75 08             	pushl  0x8(%ebp)
  8010e0:	e8 00 fb ff ff       	call   800be5 <printnum>
  8010e5:	83 c4 20             	add    $0x20,%esp
			break;
  8010e8:	eb 34                	jmp    80111e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010ea:	83 ec 08             	sub    $0x8,%esp
  8010ed:	ff 75 0c             	pushl  0xc(%ebp)
  8010f0:	53                   	push   %ebx
  8010f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f4:	ff d0                	call   *%eax
  8010f6:	83 c4 10             	add    $0x10,%esp
			break;
  8010f9:	eb 23                	jmp    80111e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010fb:	83 ec 08             	sub    $0x8,%esp
  8010fe:	ff 75 0c             	pushl  0xc(%ebp)
  801101:	6a 25                	push   $0x25
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	ff d0                	call   *%eax
  801108:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80110b:	ff 4d 10             	decl   0x10(%ebp)
  80110e:	eb 03                	jmp    801113 <vprintfmt+0x3b1>
  801110:	ff 4d 10             	decl   0x10(%ebp)
  801113:	8b 45 10             	mov    0x10(%ebp),%eax
  801116:	48                   	dec    %eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	3c 25                	cmp    $0x25,%al
  80111b:	75 f3                	jne    801110 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80111d:	90                   	nop
		}
	}
  80111e:	e9 47 fc ff ff       	jmp    800d6a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801123:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801124:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801127:	5b                   	pop    %ebx
  801128:	5e                   	pop    %esi
  801129:	5d                   	pop    %ebp
  80112a:	c3                   	ret    

0080112b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80112b:	55                   	push   %ebp
  80112c:	89 e5                	mov    %esp,%ebp
  80112e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801131:	8d 45 10             	lea    0x10(%ebp),%eax
  801134:	83 c0 04             	add    $0x4,%eax
  801137:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80113a:	8b 45 10             	mov    0x10(%ebp),%eax
  80113d:	ff 75 f4             	pushl  -0xc(%ebp)
  801140:	50                   	push   %eax
  801141:	ff 75 0c             	pushl  0xc(%ebp)
  801144:	ff 75 08             	pushl  0x8(%ebp)
  801147:	e8 16 fc ff ff       	call   800d62 <vprintfmt>
  80114c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80114f:	90                   	nop
  801150:	c9                   	leave  
  801151:	c3                   	ret    

00801152 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801152:	55                   	push   %ebp
  801153:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801155:	8b 45 0c             	mov    0xc(%ebp),%eax
  801158:	8b 40 08             	mov    0x8(%eax),%eax
  80115b:	8d 50 01             	lea    0x1(%eax),%edx
  80115e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801161:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801164:	8b 45 0c             	mov    0xc(%ebp),%eax
  801167:	8b 10                	mov    (%eax),%edx
  801169:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116c:	8b 40 04             	mov    0x4(%eax),%eax
  80116f:	39 c2                	cmp    %eax,%edx
  801171:	73 12                	jae    801185 <sprintputch+0x33>
		*b->buf++ = ch;
  801173:	8b 45 0c             	mov    0xc(%ebp),%eax
  801176:	8b 00                	mov    (%eax),%eax
  801178:	8d 48 01             	lea    0x1(%eax),%ecx
  80117b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80117e:	89 0a                	mov    %ecx,(%edx)
  801180:	8b 55 08             	mov    0x8(%ebp),%edx
  801183:	88 10                	mov    %dl,(%eax)
}
  801185:	90                   	nop
  801186:	5d                   	pop    %ebp
  801187:	c3                   	ret    

00801188 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
  80118b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80118e:	8b 45 08             	mov    0x8(%ebp),%eax
  801191:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801194:	8b 45 0c             	mov    0xc(%ebp),%eax
  801197:	8d 50 ff             	lea    -0x1(%eax),%edx
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	01 d0                	add    %edx,%eax
  80119f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011a9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ad:	74 06                	je     8011b5 <vsnprintf+0x2d>
  8011af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011b3:	7f 07                	jg     8011bc <vsnprintf+0x34>
		return -E_INVAL;
  8011b5:	b8 03 00 00 00       	mov    $0x3,%eax
  8011ba:	eb 20                	jmp    8011dc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011bc:	ff 75 14             	pushl  0x14(%ebp)
  8011bf:	ff 75 10             	pushl  0x10(%ebp)
  8011c2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011c5:	50                   	push   %eax
  8011c6:	68 52 11 80 00       	push   $0x801152
  8011cb:	e8 92 fb ff ff       	call   800d62 <vprintfmt>
  8011d0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011d6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011dc:	c9                   	leave  
  8011dd:	c3                   	ret    

008011de <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011de:	55                   	push   %ebp
  8011df:	89 e5                	mov    %esp,%ebp
  8011e1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011e4:	8d 45 10             	lea    0x10(%ebp),%eax
  8011e7:	83 c0 04             	add    $0x4,%eax
  8011ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8011f3:	50                   	push   %eax
  8011f4:	ff 75 0c             	pushl  0xc(%ebp)
  8011f7:	ff 75 08             	pushl  0x8(%ebp)
  8011fa:	e8 89 ff ff ff       	call   801188 <vsnprintf>
  8011ff:	83 c4 10             	add    $0x10,%esp
  801202:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801205:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801208:	c9                   	leave  
  801209:	c3                   	ret    

0080120a <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80120a:	55                   	push   %ebp
  80120b:	89 e5                	mov    %esp,%ebp
  80120d:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801210:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801214:	74 13                	je     801229 <readline+0x1f>
		cprintf("%s", prompt);
  801216:	83 ec 08             	sub    $0x8,%esp
  801219:	ff 75 08             	pushl  0x8(%ebp)
  80121c:	68 b0 2c 80 00       	push   $0x802cb0
  801221:	e8 62 f9 ff ff       	call   800b88 <cprintf>
  801226:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801229:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801230:	83 ec 0c             	sub    $0xc,%esp
  801233:	6a 00                	push   $0x0
  801235:	e8 81 f5 ff ff       	call   8007bb <iscons>
  80123a:	83 c4 10             	add    $0x10,%esp
  80123d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801240:	e8 28 f5 ff ff       	call   80076d <getchar>
  801245:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801248:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80124c:	79 22                	jns    801270 <readline+0x66>
			if (c != -E_EOF)
  80124e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801252:	0f 84 ad 00 00 00    	je     801305 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801258:	83 ec 08             	sub    $0x8,%esp
  80125b:	ff 75 ec             	pushl  -0x14(%ebp)
  80125e:	68 b3 2c 80 00       	push   $0x802cb3
  801263:	e8 20 f9 ff ff       	call   800b88 <cprintf>
  801268:	83 c4 10             	add    $0x10,%esp
			return;
  80126b:	e9 95 00 00 00       	jmp    801305 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801270:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801274:	7e 34                	jle    8012aa <readline+0xa0>
  801276:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80127d:	7f 2b                	jg     8012aa <readline+0xa0>
			if (echoing)
  80127f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801283:	74 0e                	je     801293 <readline+0x89>
				cputchar(c);
  801285:	83 ec 0c             	sub    $0xc,%esp
  801288:	ff 75 ec             	pushl  -0x14(%ebp)
  80128b:	e8 95 f4 ff ff       	call   800725 <cputchar>
  801290:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801293:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801296:	8d 50 01             	lea    0x1(%eax),%edx
  801299:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80129c:	89 c2                	mov    %eax,%edx
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	01 d0                	add    %edx,%eax
  8012a3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a6:	88 10                	mov    %dl,(%eax)
  8012a8:	eb 56                	jmp    801300 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012aa:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012ae:	75 1f                	jne    8012cf <readline+0xc5>
  8012b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012b4:	7e 19                	jle    8012cf <readline+0xc5>
			if (echoing)
  8012b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012ba:	74 0e                	je     8012ca <readline+0xc0>
				cputchar(c);
  8012bc:	83 ec 0c             	sub    $0xc,%esp
  8012bf:	ff 75 ec             	pushl  -0x14(%ebp)
  8012c2:	e8 5e f4 ff ff       	call   800725 <cputchar>
  8012c7:	83 c4 10             	add    $0x10,%esp

			i--;
  8012ca:	ff 4d f4             	decl   -0xc(%ebp)
  8012cd:	eb 31                	jmp    801300 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012cf:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012d3:	74 0a                	je     8012df <readline+0xd5>
  8012d5:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012d9:	0f 85 61 ff ff ff    	jne    801240 <readline+0x36>
			if (echoing)
  8012df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012e3:	74 0e                	je     8012f3 <readline+0xe9>
				cputchar(c);
  8012e5:	83 ec 0c             	sub    $0xc,%esp
  8012e8:	ff 75 ec             	pushl  -0x14(%ebp)
  8012eb:	e8 35 f4 ff ff       	call   800725 <cputchar>
  8012f0:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f9:	01 d0                	add    %edx,%eax
  8012fb:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8012fe:	eb 06                	jmp    801306 <readline+0xfc>
		}
	}
  801300:	e9 3b ff ff ff       	jmp    801240 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801305:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80130e:	e8 4a 0c 00 00       	call   801f5d <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801313:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801317:	74 13                	je     80132c <atomic_readline+0x24>
		cprintf("%s", prompt);
  801319:	83 ec 08             	sub    $0x8,%esp
  80131c:	ff 75 08             	pushl  0x8(%ebp)
  80131f:	68 b0 2c 80 00       	push   $0x802cb0
  801324:	e8 5f f8 ff ff       	call   800b88 <cprintf>
  801329:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80132c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801333:	83 ec 0c             	sub    $0xc,%esp
  801336:	6a 00                	push   $0x0
  801338:	e8 7e f4 ff ff       	call   8007bb <iscons>
  80133d:	83 c4 10             	add    $0x10,%esp
  801340:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801343:	e8 25 f4 ff ff       	call   80076d <getchar>
  801348:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80134b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80134f:	79 23                	jns    801374 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801351:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801355:	74 13                	je     80136a <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801357:	83 ec 08             	sub    $0x8,%esp
  80135a:	ff 75 ec             	pushl  -0x14(%ebp)
  80135d:	68 b3 2c 80 00       	push   $0x802cb3
  801362:	e8 21 f8 ff ff       	call   800b88 <cprintf>
  801367:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80136a:	e8 08 0c 00 00       	call   801f77 <sys_enable_interrupt>
			return;
  80136f:	e9 9a 00 00 00       	jmp    80140e <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801374:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801378:	7e 34                	jle    8013ae <atomic_readline+0xa6>
  80137a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801381:	7f 2b                	jg     8013ae <atomic_readline+0xa6>
			if (echoing)
  801383:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801387:	74 0e                	je     801397 <atomic_readline+0x8f>
				cputchar(c);
  801389:	83 ec 0c             	sub    $0xc,%esp
  80138c:	ff 75 ec             	pushl  -0x14(%ebp)
  80138f:	e8 91 f3 ff ff       	call   800725 <cputchar>
  801394:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801397:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80139a:	8d 50 01             	lea    0x1(%eax),%edx
  80139d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013a0:	89 c2                	mov    %eax,%edx
  8013a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a5:	01 d0                	add    %edx,%eax
  8013a7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013aa:	88 10                	mov    %dl,(%eax)
  8013ac:	eb 5b                	jmp    801409 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013ae:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013b2:	75 1f                	jne    8013d3 <atomic_readline+0xcb>
  8013b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013b8:	7e 19                	jle    8013d3 <atomic_readline+0xcb>
			if (echoing)
  8013ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013be:	74 0e                	je     8013ce <atomic_readline+0xc6>
				cputchar(c);
  8013c0:	83 ec 0c             	sub    $0xc,%esp
  8013c3:	ff 75 ec             	pushl  -0x14(%ebp)
  8013c6:	e8 5a f3 ff ff       	call   800725 <cputchar>
  8013cb:	83 c4 10             	add    $0x10,%esp
			i--;
  8013ce:	ff 4d f4             	decl   -0xc(%ebp)
  8013d1:	eb 36                	jmp    801409 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013d3:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013d7:	74 0a                	je     8013e3 <atomic_readline+0xdb>
  8013d9:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013dd:	0f 85 60 ff ff ff    	jne    801343 <atomic_readline+0x3b>
			if (echoing)
  8013e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013e7:	74 0e                	je     8013f7 <atomic_readline+0xef>
				cputchar(c);
  8013e9:	83 ec 0c             	sub    $0xc,%esp
  8013ec:	ff 75 ec             	pushl  -0x14(%ebp)
  8013ef:	e8 31 f3 ff ff       	call   800725 <cputchar>
  8013f4:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fd:	01 d0                	add    %edx,%eax
  8013ff:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801402:	e8 70 0b 00 00       	call   801f77 <sys_enable_interrupt>
			return;
  801407:	eb 05                	jmp    80140e <atomic_readline+0x106>
		}
	}
  801409:	e9 35 ff ff ff       	jmp    801343 <atomic_readline+0x3b>
}
  80140e:	c9                   	leave  
  80140f:	c3                   	ret    

00801410 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801410:	55                   	push   %ebp
  801411:	89 e5                	mov    %esp,%ebp
  801413:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801416:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80141d:	eb 06                	jmp    801425 <strlen+0x15>
		n++;
  80141f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801422:	ff 45 08             	incl   0x8(%ebp)
  801425:	8b 45 08             	mov    0x8(%ebp),%eax
  801428:	8a 00                	mov    (%eax),%al
  80142a:	84 c0                	test   %al,%al
  80142c:	75 f1                	jne    80141f <strlen+0xf>
		n++;
	return n;
  80142e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801431:	c9                   	leave  
  801432:	c3                   	ret    

00801433 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
  801436:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801439:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801440:	eb 09                	jmp    80144b <strnlen+0x18>
		n++;
  801442:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801445:	ff 45 08             	incl   0x8(%ebp)
  801448:	ff 4d 0c             	decl   0xc(%ebp)
  80144b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80144f:	74 09                	je     80145a <strnlen+0x27>
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
  801454:	8a 00                	mov    (%eax),%al
  801456:	84 c0                	test   %al,%al
  801458:	75 e8                	jne    801442 <strnlen+0xf>
		n++;
	return n;
  80145a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80145d:	c9                   	leave  
  80145e:	c3                   	ret    

0080145f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80145f:	55                   	push   %ebp
  801460:	89 e5                	mov    %esp,%ebp
  801462:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801465:	8b 45 08             	mov    0x8(%ebp),%eax
  801468:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80146b:	90                   	nop
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	8d 50 01             	lea    0x1(%eax),%edx
  801472:	89 55 08             	mov    %edx,0x8(%ebp)
  801475:	8b 55 0c             	mov    0xc(%ebp),%edx
  801478:	8d 4a 01             	lea    0x1(%edx),%ecx
  80147b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80147e:	8a 12                	mov    (%edx),%dl
  801480:	88 10                	mov    %dl,(%eax)
  801482:	8a 00                	mov    (%eax),%al
  801484:	84 c0                	test   %al,%al
  801486:	75 e4                	jne    80146c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801488:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80148b:	c9                   	leave  
  80148c:	c3                   	ret    

0080148d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80148d:	55                   	push   %ebp
  80148e:	89 e5                	mov    %esp,%ebp
  801490:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801493:	8b 45 08             	mov    0x8(%ebp),%eax
  801496:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801499:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014a0:	eb 1f                	jmp    8014c1 <strncpy+0x34>
		*dst++ = *src;
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	8d 50 01             	lea    0x1(%eax),%edx
  8014a8:	89 55 08             	mov    %edx,0x8(%ebp)
  8014ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ae:	8a 12                	mov    (%edx),%dl
  8014b0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b5:	8a 00                	mov    (%eax),%al
  8014b7:	84 c0                	test   %al,%al
  8014b9:	74 03                	je     8014be <strncpy+0x31>
			src++;
  8014bb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014be:	ff 45 fc             	incl   -0x4(%ebp)
  8014c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014c7:	72 d9                	jb     8014a2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014cc:	c9                   	leave  
  8014cd:	c3                   	ret    

008014ce <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014ce:	55                   	push   %ebp
  8014cf:	89 e5                	mov    %esp,%ebp
  8014d1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014de:	74 30                	je     801510 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014e0:	eb 16                	jmp    8014f8 <strlcpy+0x2a>
			*dst++ = *src++;
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	8d 50 01             	lea    0x1(%eax),%edx
  8014e8:	89 55 08             	mov    %edx,0x8(%ebp)
  8014eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ee:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014f1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014f4:	8a 12                	mov    (%edx),%dl
  8014f6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014f8:	ff 4d 10             	decl   0x10(%ebp)
  8014fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ff:	74 09                	je     80150a <strlcpy+0x3c>
  801501:	8b 45 0c             	mov    0xc(%ebp),%eax
  801504:	8a 00                	mov    (%eax),%al
  801506:	84 c0                	test   %al,%al
  801508:	75 d8                	jne    8014e2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80150a:	8b 45 08             	mov    0x8(%ebp),%eax
  80150d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801510:	8b 55 08             	mov    0x8(%ebp),%edx
  801513:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801516:	29 c2                	sub    %eax,%edx
  801518:	89 d0                	mov    %edx,%eax
}
  80151a:	c9                   	leave  
  80151b:	c3                   	ret    

0080151c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80151c:	55                   	push   %ebp
  80151d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80151f:	eb 06                	jmp    801527 <strcmp+0xb>
		p++, q++;
  801521:	ff 45 08             	incl   0x8(%ebp)
  801524:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801527:	8b 45 08             	mov    0x8(%ebp),%eax
  80152a:	8a 00                	mov    (%eax),%al
  80152c:	84 c0                	test   %al,%al
  80152e:	74 0e                	je     80153e <strcmp+0x22>
  801530:	8b 45 08             	mov    0x8(%ebp),%eax
  801533:	8a 10                	mov    (%eax),%dl
  801535:	8b 45 0c             	mov    0xc(%ebp),%eax
  801538:	8a 00                	mov    (%eax),%al
  80153a:	38 c2                	cmp    %al,%dl
  80153c:	74 e3                	je     801521 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80153e:	8b 45 08             	mov    0x8(%ebp),%eax
  801541:	8a 00                	mov    (%eax),%al
  801543:	0f b6 d0             	movzbl %al,%edx
  801546:	8b 45 0c             	mov    0xc(%ebp),%eax
  801549:	8a 00                	mov    (%eax),%al
  80154b:	0f b6 c0             	movzbl %al,%eax
  80154e:	29 c2                	sub    %eax,%edx
  801550:	89 d0                	mov    %edx,%eax
}
  801552:	5d                   	pop    %ebp
  801553:	c3                   	ret    

00801554 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801554:	55                   	push   %ebp
  801555:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801557:	eb 09                	jmp    801562 <strncmp+0xe>
		n--, p++, q++;
  801559:	ff 4d 10             	decl   0x10(%ebp)
  80155c:	ff 45 08             	incl   0x8(%ebp)
  80155f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801562:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801566:	74 17                	je     80157f <strncmp+0x2b>
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	8a 00                	mov    (%eax),%al
  80156d:	84 c0                	test   %al,%al
  80156f:	74 0e                	je     80157f <strncmp+0x2b>
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
  801574:	8a 10                	mov    (%eax),%dl
  801576:	8b 45 0c             	mov    0xc(%ebp),%eax
  801579:	8a 00                	mov    (%eax),%al
  80157b:	38 c2                	cmp    %al,%dl
  80157d:	74 da                	je     801559 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80157f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801583:	75 07                	jne    80158c <strncmp+0x38>
		return 0;
  801585:	b8 00 00 00 00       	mov    $0x0,%eax
  80158a:	eb 14                	jmp    8015a0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	8a 00                	mov    (%eax),%al
  801591:	0f b6 d0             	movzbl %al,%edx
  801594:	8b 45 0c             	mov    0xc(%ebp),%eax
  801597:	8a 00                	mov    (%eax),%al
  801599:	0f b6 c0             	movzbl %al,%eax
  80159c:	29 c2                	sub    %eax,%edx
  80159e:	89 d0                	mov    %edx,%eax
}
  8015a0:	5d                   	pop    %ebp
  8015a1:	c3                   	ret    

008015a2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015a2:	55                   	push   %ebp
  8015a3:	89 e5                	mov    %esp,%ebp
  8015a5:	83 ec 04             	sub    $0x4,%esp
  8015a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ab:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015ae:	eb 12                	jmp    8015c2 <strchr+0x20>
		if (*s == c)
  8015b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b3:	8a 00                	mov    (%eax),%al
  8015b5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015b8:	75 05                	jne    8015bf <strchr+0x1d>
			return (char *) s;
  8015ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bd:	eb 11                	jmp    8015d0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015bf:	ff 45 08             	incl   0x8(%ebp)
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	8a 00                	mov    (%eax),%al
  8015c7:	84 c0                	test   %al,%al
  8015c9:	75 e5                	jne    8015b0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d0:	c9                   	leave  
  8015d1:	c3                   	ret    

008015d2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015d2:	55                   	push   %ebp
  8015d3:	89 e5                	mov    %esp,%ebp
  8015d5:	83 ec 04             	sub    $0x4,%esp
  8015d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015db:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015de:	eb 0d                	jmp    8015ed <strfind+0x1b>
		if (*s == c)
  8015e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e3:	8a 00                	mov    (%eax),%al
  8015e5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015e8:	74 0e                	je     8015f8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015ea:	ff 45 08             	incl   0x8(%ebp)
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	8a 00                	mov    (%eax),%al
  8015f2:	84 c0                	test   %al,%al
  8015f4:	75 ea                	jne    8015e0 <strfind+0xe>
  8015f6:	eb 01                	jmp    8015f9 <strfind+0x27>
		if (*s == c)
			break;
  8015f8:	90                   	nop
	return (char *) s;
  8015f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015fc:	c9                   	leave  
  8015fd:	c3                   	ret    

008015fe <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015fe:	55                   	push   %ebp
  8015ff:	89 e5                	mov    %esp,%ebp
  801601:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801604:	8b 45 08             	mov    0x8(%ebp),%eax
  801607:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80160a:	8b 45 10             	mov    0x10(%ebp),%eax
  80160d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801610:	eb 0e                	jmp    801620 <memset+0x22>
		*p++ = c;
  801612:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801615:	8d 50 01             	lea    0x1(%eax),%edx
  801618:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80161b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80161e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801620:	ff 4d f8             	decl   -0x8(%ebp)
  801623:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801627:	79 e9                	jns    801612 <memset+0x14>
		*p++ = c;

	return v;
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
  801631:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801634:	8b 45 0c             	mov    0xc(%ebp),%eax
  801637:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80163a:	8b 45 08             	mov    0x8(%ebp),%eax
  80163d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801640:	eb 16                	jmp    801658 <memcpy+0x2a>
		*d++ = *s++;
  801642:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801645:	8d 50 01             	lea    0x1(%eax),%edx
  801648:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80164b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80164e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801651:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801654:	8a 12                	mov    (%edx),%dl
  801656:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801658:	8b 45 10             	mov    0x10(%ebp),%eax
  80165b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80165e:	89 55 10             	mov    %edx,0x10(%ebp)
  801661:	85 c0                	test   %eax,%eax
  801663:	75 dd                	jne    801642 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801665:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801668:	c9                   	leave  
  801669:	c3                   	ret    

0080166a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80166a:	55                   	push   %ebp
  80166b:	89 e5                	mov    %esp,%ebp
  80166d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801670:	8b 45 0c             	mov    0xc(%ebp),%eax
  801673:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80167c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80167f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801682:	73 50                	jae    8016d4 <memmove+0x6a>
  801684:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801687:	8b 45 10             	mov    0x10(%ebp),%eax
  80168a:	01 d0                	add    %edx,%eax
  80168c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80168f:	76 43                	jbe    8016d4 <memmove+0x6a>
		s += n;
  801691:	8b 45 10             	mov    0x10(%ebp),%eax
  801694:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801697:	8b 45 10             	mov    0x10(%ebp),%eax
  80169a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80169d:	eb 10                	jmp    8016af <memmove+0x45>
			*--d = *--s;
  80169f:	ff 4d f8             	decl   -0x8(%ebp)
  8016a2:	ff 4d fc             	decl   -0x4(%ebp)
  8016a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a8:	8a 10                	mov    (%eax),%dl
  8016aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ad:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016af:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016b5:	89 55 10             	mov    %edx,0x10(%ebp)
  8016b8:	85 c0                	test   %eax,%eax
  8016ba:	75 e3                	jne    80169f <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016bc:	eb 23                	jmp    8016e1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c1:	8d 50 01             	lea    0x1(%eax),%edx
  8016c4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016c7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ca:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016cd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016d0:	8a 12                	mov    (%edx),%dl
  8016d2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016da:	89 55 10             	mov    %edx,0x10(%ebp)
  8016dd:	85 c0                	test   %eax,%eax
  8016df:	75 dd                	jne    8016be <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016e4:	c9                   	leave  
  8016e5:	c3                   	ret    

008016e6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016e6:	55                   	push   %ebp
  8016e7:	89 e5                	mov    %esp,%ebp
  8016e9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016f8:	eb 2a                	jmp    801724 <memcmp+0x3e>
		if (*s1 != *s2)
  8016fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016fd:	8a 10                	mov    (%eax),%dl
  8016ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801702:	8a 00                	mov    (%eax),%al
  801704:	38 c2                	cmp    %al,%dl
  801706:	74 16                	je     80171e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801708:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80170b:	8a 00                	mov    (%eax),%al
  80170d:	0f b6 d0             	movzbl %al,%edx
  801710:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801713:	8a 00                	mov    (%eax),%al
  801715:	0f b6 c0             	movzbl %al,%eax
  801718:	29 c2                	sub    %eax,%edx
  80171a:	89 d0                	mov    %edx,%eax
  80171c:	eb 18                	jmp    801736 <memcmp+0x50>
		s1++, s2++;
  80171e:	ff 45 fc             	incl   -0x4(%ebp)
  801721:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801724:	8b 45 10             	mov    0x10(%ebp),%eax
  801727:	8d 50 ff             	lea    -0x1(%eax),%edx
  80172a:	89 55 10             	mov    %edx,0x10(%ebp)
  80172d:	85 c0                	test   %eax,%eax
  80172f:	75 c9                	jne    8016fa <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801731:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
  80173b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80173e:	8b 55 08             	mov    0x8(%ebp),%edx
  801741:	8b 45 10             	mov    0x10(%ebp),%eax
  801744:	01 d0                	add    %edx,%eax
  801746:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801749:	eb 15                	jmp    801760 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80174b:	8b 45 08             	mov    0x8(%ebp),%eax
  80174e:	8a 00                	mov    (%eax),%al
  801750:	0f b6 d0             	movzbl %al,%edx
  801753:	8b 45 0c             	mov    0xc(%ebp),%eax
  801756:	0f b6 c0             	movzbl %al,%eax
  801759:	39 c2                	cmp    %eax,%edx
  80175b:	74 0d                	je     80176a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80175d:	ff 45 08             	incl   0x8(%ebp)
  801760:	8b 45 08             	mov    0x8(%ebp),%eax
  801763:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801766:	72 e3                	jb     80174b <memfind+0x13>
  801768:	eb 01                	jmp    80176b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80176a:	90                   	nop
	return (void *) s;
  80176b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
  801773:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801776:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80177d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801784:	eb 03                	jmp    801789 <strtol+0x19>
		s++;
  801786:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801789:	8b 45 08             	mov    0x8(%ebp),%eax
  80178c:	8a 00                	mov    (%eax),%al
  80178e:	3c 20                	cmp    $0x20,%al
  801790:	74 f4                	je     801786 <strtol+0x16>
  801792:	8b 45 08             	mov    0x8(%ebp),%eax
  801795:	8a 00                	mov    (%eax),%al
  801797:	3c 09                	cmp    $0x9,%al
  801799:	74 eb                	je     801786 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80179b:	8b 45 08             	mov    0x8(%ebp),%eax
  80179e:	8a 00                	mov    (%eax),%al
  8017a0:	3c 2b                	cmp    $0x2b,%al
  8017a2:	75 05                	jne    8017a9 <strtol+0x39>
		s++;
  8017a4:	ff 45 08             	incl   0x8(%ebp)
  8017a7:	eb 13                	jmp    8017bc <strtol+0x4c>
	else if (*s == '-')
  8017a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ac:	8a 00                	mov    (%eax),%al
  8017ae:	3c 2d                	cmp    $0x2d,%al
  8017b0:	75 0a                	jne    8017bc <strtol+0x4c>
		s++, neg = 1;
  8017b2:	ff 45 08             	incl   0x8(%ebp)
  8017b5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017bc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017c0:	74 06                	je     8017c8 <strtol+0x58>
  8017c2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017c6:	75 20                	jne    8017e8 <strtol+0x78>
  8017c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cb:	8a 00                	mov    (%eax),%al
  8017cd:	3c 30                	cmp    $0x30,%al
  8017cf:	75 17                	jne    8017e8 <strtol+0x78>
  8017d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d4:	40                   	inc    %eax
  8017d5:	8a 00                	mov    (%eax),%al
  8017d7:	3c 78                	cmp    $0x78,%al
  8017d9:	75 0d                	jne    8017e8 <strtol+0x78>
		s += 2, base = 16;
  8017db:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017df:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017e6:	eb 28                	jmp    801810 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017ec:	75 15                	jne    801803 <strtol+0x93>
  8017ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f1:	8a 00                	mov    (%eax),%al
  8017f3:	3c 30                	cmp    $0x30,%al
  8017f5:	75 0c                	jne    801803 <strtol+0x93>
		s++, base = 8;
  8017f7:	ff 45 08             	incl   0x8(%ebp)
  8017fa:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801801:	eb 0d                	jmp    801810 <strtol+0xa0>
	else if (base == 0)
  801803:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801807:	75 07                	jne    801810 <strtol+0xa0>
		base = 10;
  801809:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801810:	8b 45 08             	mov    0x8(%ebp),%eax
  801813:	8a 00                	mov    (%eax),%al
  801815:	3c 2f                	cmp    $0x2f,%al
  801817:	7e 19                	jle    801832 <strtol+0xc2>
  801819:	8b 45 08             	mov    0x8(%ebp),%eax
  80181c:	8a 00                	mov    (%eax),%al
  80181e:	3c 39                	cmp    $0x39,%al
  801820:	7f 10                	jg     801832 <strtol+0xc2>
			dig = *s - '0';
  801822:	8b 45 08             	mov    0x8(%ebp),%eax
  801825:	8a 00                	mov    (%eax),%al
  801827:	0f be c0             	movsbl %al,%eax
  80182a:	83 e8 30             	sub    $0x30,%eax
  80182d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801830:	eb 42                	jmp    801874 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801832:	8b 45 08             	mov    0x8(%ebp),%eax
  801835:	8a 00                	mov    (%eax),%al
  801837:	3c 60                	cmp    $0x60,%al
  801839:	7e 19                	jle    801854 <strtol+0xe4>
  80183b:	8b 45 08             	mov    0x8(%ebp),%eax
  80183e:	8a 00                	mov    (%eax),%al
  801840:	3c 7a                	cmp    $0x7a,%al
  801842:	7f 10                	jg     801854 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801844:	8b 45 08             	mov    0x8(%ebp),%eax
  801847:	8a 00                	mov    (%eax),%al
  801849:	0f be c0             	movsbl %al,%eax
  80184c:	83 e8 57             	sub    $0x57,%eax
  80184f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801852:	eb 20                	jmp    801874 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801854:	8b 45 08             	mov    0x8(%ebp),%eax
  801857:	8a 00                	mov    (%eax),%al
  801859:	3c 40                	cmp    $0x40,%al
  80185b:	7e 39                	jle    801896 <strtol+0x126>
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	8a 00                	mov    (%eax),%al
  801862:	3c 5a                	cmp    $0x5a,%al
  801864:	7f 30                	jg     801896 <strtol+0x126>
			dig = *s - 'A' + 10;
  801866:	8b 45 08             	mov    0x8(%ebp),%eax
  801869:	8a 00                	mov    (%eax),%al
  80186b:	0f be c0             	movsbl %al,%eax
  80186e:	83 e8 37             	sub    $0x37,%eax
  801871:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801874:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801877:	3b 45 10             	cmp    0x10(%ebp),%eax
  80187a:	7d 19                	jge    801895 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80187c:	ff 45 08             	incl   0x8(%ebp)
  80187f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801882:	0f af 45 10          	imul   0x10(%ebp),%eax
  801886:	89 c2                	mov    %eax,%edx
  801888:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80188b:	01 d0                	add    %edx,%eax
  80188d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801890:	e9 7b ff ff ff       	jmp    801810 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801895:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801896:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80189a:	74 08                	je     8018a4 <strtol+0x134>
		*endptr = (char *) s;
  80189c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80189f:	8b 55 08             	mov    0x8(%ebp),%edx
  8018a2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018a4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018a8:	74 07                	je     8018b1 <strtol+0x141>
  8018aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ad:	f7 d8                	neg    %eax
  8018af:	eb 03                	jmp    8018b4 <strtol+0x144>
  8018b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018b4:	c9                   	leave  
  8018b5:	c3                   	ret    

008018b6 <ltostr>:

void
ltostr(long value, char *str)
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
  8018b9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018ca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018ce:	79 13                	jns    8018e3 <ltostr+0x2d>
	{
		neg = 1;
  8018d0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018da:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018dd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018e0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018eb:	99                   	cltd   
  8018ec:	f7 f9                	idiv   %ecx
  8018ee:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018f4:	8d 50 01             	lea    0x1(%eax),%edx
  8018f7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018fa:	89 c2                	mov    %eax,%edx
  8018fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ff:	01 d0                	add    %edx,%eax
  801901:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801904:	83 c2 30             	add    $0x30,%edx
  801907:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801909:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80190c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801911:	f7 e9                	imul   %ecx
  801913:	c1 fa 02             	sar    $0x2,%edx
  801916:	89 c8                	mov    %ecx,%eax
  801918:	c1 f8 1f             	sar    $0x1f,%eax
  80191b:	29 c2                	sub    %eax,%edx
  80191d:	89 d0                	mov    %edx,%eax
  80191f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801922:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801925:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80192a:	f7 e9                	imul   %ecx
  80192c:	c1 fa 02             	sar    $0x2,%edx
  80192f:	89 c8                	mov    %ecx,%eax
  801931:	c1 f8 1f             	sar    $0x1f,%eax
  801934:	29 c2                	sub    %eax,%edx
  801936:	89 d0                	mov    %edx,%eax
  801938:	c1 e0 02             	shl    $0x2,%eax
  80193b:	01 d0                	add    %edx,%eax
  80193d:	01 c0                	add    %eax,%eax
  80193f:	29 c1                	sub    %eax,%ecx
  801941:	89 ca                	mov    %ecx,%edx
  801943:	85 d2                	test   %edx,%edx
  801945:	75 9c                	jne    8018e3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801947:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80194e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801951:	48                   	dec    %eax
  801952:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801955:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801959:	74 3d                	je     801998 <ltostr+0xe2>
		start = 1 ;
  80195b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801962:	eb 34                	jmp    801998 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801964:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801967:	8b 45 0c             	mov    0xc(%ebp),%eax
  80196a:	01 d0                	add    %edx,%eax
  80196c:	8a 00                	mov    (%eax),%al
  80196e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801971:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801974:	8b 45 0c             	mov    0xc(%ebp),%eax
  801977:	01 c2                	add    %eax,%edx
  801979:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80197c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80197f:	01 c8                	add    %ecx,%eax
  801981:	8a 00                	mov    (%eax),%al
  801983:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801985:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801988:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198b:	01 c2                	add    %eax,%edx
  80198d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801990:	88 02                	mov    %al,(%edx)
		start++ ;
  801992:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801995:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801998:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80199b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80199e:	7c c4                	jl     801964 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019a0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a6:	01 d0                	add    %edx,%eax
  8019a8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019ab:	90                   	nop
  8019ac:	c9                   	leave  
  8019ad:	c3                   	ret    

008019ae <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019ae:	55                   	push   %ebp
  8019af:	89 e5                	mov    %esp,%ebp
  8019b1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019b4:	ff 75 08             	pushl  0x8(%ebp)
  8019b7:	e8 54 fa ff ff       	call   801410 <strlen>
  8019bc:	83 c4 04             	add    $0x4,%esp
  8019bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019c2:	ff 75 0c             	pushl  0xc(%ebp)
  8019c5:	e8 46 fa ff ff       	call   801410 <strlen>
  8019ca:	83 c4 04             	add    $0x4,%esp
  8019cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019de:	eb 17                	jmp    8019f7 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e6:	01 c2                	add    %eax,%edx
  8019e8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ee:	01 c8                	add    %ecx,%eax
  8019f0:	8a 00                	mov    (%eax),%al
  8019f2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019f4:	ff 45 fc             	incl   -0x4(%ebp)
  8019f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019fa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019fd:	7c e1                	jl     8019e0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019ff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a06:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a0d:	eb 1f                	jmp    801a2e <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a12:	8d 50 01             	lea    0x1(%eax),%edx
  801a15:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a18:	89 c2                	mov    %eax,%edx
  801a1a:	8b 45 10             	mov    0x10(%ebp),%eax
  801a1d:	01 c2                	add    %eax,%edx
  801a1f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a22:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a25:	01 c8                	add    %ecx,%eax
  801a27:	8a 00                	mov    (%eax),%al
  801a29:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a2b:	ff 45 f8             	incl   -0x8(%ebp)
  801a2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a31:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a34:	7c d9                	jl     801a0f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a36:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a39:	8b 45 10             	mov    0x10(%ebp),%eax
  801a3c:	01 d0                	add    %edx,%eax
  801a3e:	c6 00 00             	movb   $0x0,(%eax)
}
  801a41:	90                   	nop
  801a42:	c9                   	leave  
  801a43:	c3                   	ret    

00801a44 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a44:	55                   	push   %ebp
  801a45:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a47:	8b 45 14             	mov    0x14(%ebp),%eax
  801a4a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a50:	8b 45 14             	mov    0x14(%ebp),%eax
  801a53:	8b 00                	mov    (%eax),%eax
  801a55:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a5c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a5f:	01 d0                	add    %edx,%eax
  801a61:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a67:	eb 0c                	jmp    801a75 <strsplit+0x31>
			*string++ = 0;
  801a69:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6c:	8d 50 01             	lea    0x1(%eax),%edx
  801a6f:	89 55 08             	mov    %edx,0x8(%ebp)
  801a72:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a75:	8b 45 08             	mov    0x8(%ebp),%eax
  801a78:	8a 00                	mov    (%eax),%al
  801a7a:	84 c0                	test   %al,%al
  801a7c:	74 18                	je     801a96 <strsplit+0x52>
  801a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a81:	8a 00                	mov    (%eax),%al
  801a83:	0f be c0             	movsbl %al,%eax
  801a86:	50                   	push   %eax
  801a87:	ff 75 0c             	pushl  0xc(%ebp)
  801a8a:	e8 13 fb ff ff       	call   8015a2 <strchr>
  801a8f:	83 c4 08             	add    $0x8,%esp
  801a92:	85 c0                	test   %eax,%eax
  801a94:	75 d3                	jne    801a69 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801a96:	8b 45 08             	mov    0x8(%ebp),%eax
  801a99:	8a 00                	mov    (%eax),%al
  801a9b:	84 c0                	test   %al,%al
  801a9d:	74 5a                	je     801af9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801a9f:	8b 45 14             	mov    0x14(%ebp),%eax
  801aa2:	8b 00                	mov    (%eax),%eax
  801aa4:	83 f8 0f             	cmp    $0xf,%eax
  801aa7:	75 07                	jne    801ab0 <strsplit+0x6c>
		{
			return 0;
  801aa9:	b8 00 00 00 00       	mov    $0x0,%eax
  801aae:	eb 66                	jmp    801b16 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801ab0:	8b 45 14             	mov    0x14(%ebp),%eax
  801ab3:	8b 00                	mov    (%eax),%eax
  801ab5:	8d 48 01             	lea    0x1(%eax),%ecx
  801ab8:	8b 55 14             	mov    0x14(%ebp),%edx
  801abb:	89 0a                	mov    %ecx,(%edx)
  801abd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ac4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac7:	01 c2                	add    %eax,%edx
  801ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  801acc:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ace:	eb 03                	jmp    801ad3 <strsplit+0x8f>
			string++;
  801ad0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad6:	8a 00                	mov    (%eax),%al
  801ad8:	84 c0                	test   %al,%al
  801ada:	74 8b                	je     801a67 <strsplit+0x23>
  801adc:	8b 45 08             	mov    0x8(%ebp),%eax
  801adf:	8a 00                	mov    (%eax),%al
  801ae1:	0f be c0             	movsbl %al,%eax
  801ae4:	50                   	push   %eax
  801ae5:	ff 75 0c             	pushl  0xc(%ebp)
  801ae8:	e8 b5 fa ff ff       	call   8015a2 <strchr>
  801aed:	83 c4 08             	add    $0x8,%esp
  801af0:	85 c0                	test   %eax,%eax
  801af2:	74 dc                	je     801ad0 <strsplit+0x8c>
			string++;
	}
  801af4:	e9 6e ff ff ff       	jmp    801a67 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801af9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801afa:	8b 45 14             	mov    0x14(%ebp),%eax
  801afd:	8b 00                	mov    (%eax),%eax
  801aff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b06:	8b 45 10             	mov    0x10(%ebp),%eax
  801b09:	01 d0                	add    %edx,%eax
  801b0b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b11:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b16:	c9                   	leave  
  801b17:	c3                   	ret    

00801b18 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801b18:	55                   	push   %ebp
  801b19:	89 e5                	mov    %esp,%ebp
  801b1b:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801b1e:	e8 9b 07 00 00       	call   8022be <sys_isUHeapPlacementStrategyNEXTFIT>
  801b23:	85 c0                	test   %eax,%eax
  801b25:	0f 84 64 01 00 00    	je     801c8f <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801b2b:	8b 0d 2c 30 80 00    	mov    0x80302c,%ecx
  801b31:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801b38:	8b 55 08             	mov    0x8(%ebp),%edx
  801b3b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b3e:	01 d0                	add    %edx,%eax
  801b40:	48                   	dec    %eax
  801b41:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801b44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b47:	ba 00 00 00 00       	mov    $0x0,%edx
  801b4c:	f7 75 e8             	divl   -0x18(%ebp)
  801b4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b52:	29 d0                	sub    %edx,%eax
  801b54:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801b5b:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b61:	8b 45 08             	mov    0x8(%ebp),%eax
  801b64:	01 d0                	add    %edx,%eax
  801b66:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801b69:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801b70:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b75:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b7c:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801b7f:	0f 83 0a 01 00 00    	jae    801c8f <malloc+0x177>
  801b85:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b8a:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b91:	85 c0                	test   %eax,%eax
  801b93:	0f 84 f6 00 00 00    	je     801c8f <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801b99:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ba0:	e9 dc 00 00 00       	jmp    801c81 <malloc+0x169>
				flag++;
  801ba5:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801ba8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bab:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801bb2:	85 c0                	test   %eax,%eax
  801bb4:	74 07                	je     801bbd <malloc+0xa5>
					flag=0;
  801bb6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801bbd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801bc2:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801bc9:	85 c0                	test   %eax,%eax
  801bcb:	79 05                	jns    801bd2 <malloc+0xba>
  801bcd:	05 ff 0f 00 00       	add    $0xfff,%eax
  801bd2:	c1 f8 0c             	sar    $0xc,%eax
  801bd5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801bd8:	0f 85 a0 00 00 00    	jne    801c7e <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801bde:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801be3:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801bea:	85 c0                	test   %eax,%eax
  801bec:	79 05                	jns    801bf3 <malloc+0xdb>
  801bee:	05 ff 0f 00 00       	add    $0xfff,%eax
  801bf3:	c1 f8 0c             	sar    $0xc,%eax
  801bf6:	89 c2                	mov    %eax,%edx
  801bf8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bfb:	29 d0                	sub    %edx,%eax
  801bfd:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801c00:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c03:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801c06:	eb 11                	jmp    801c19 <malloc+0x101>
						hFreeArr[j] = 1;
  801c08:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c0b:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801c12:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801c16:	ff 45 ec             	incl   -0x14(%ebp)
  801c19:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c1c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c1f:	7e e7                	jle    801c08 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801c21:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c26:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801c29:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801c2f:	c1 e2 0c             	shl    $0xc,%edx
  801c32:	89 15 04 30 80 00    	mov    %edx,0x803004
  801c38:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801c3e:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801c45:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c4a:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801c51:	89 c2                	mov    %eax,%edx
  801c53:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c58:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801c5f:	83 ec 08             	sub    $0x8,%esp
  801c62:	52                   	push   %edx
  801c63:	50                   	push   %eax
  801c64:	e8 8b 02 00 00       	call   801ef4 <sys_allocateMem>
  801c69:	83 c4 10             	add    $0x10,%esp

					idx++;
  801c6c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c71:	40                   	inc    %eax
  801c72:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*)startAdd;
  801c77:	a1 04 30 80 00       	mov    0x803004,%eax
  801c7c:	eb 16                	jmp    801c94 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801c7e:	ff 45 f0             	incl   -0x10(%ebp)
  801c81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c84:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c89:	0f 86 16 ff ff ff    	jbe    801ba5 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801c8f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c94:	c9                   	leave  
  801c95:	c3                   	ret    

00801c96 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c96:	55                   	push   %ebp
  801c97:	89 e5                	mov    %esp,%ebp
  801c99:	83 ec 18             	sub    $0x18,%esp
  801c9c:	8b 45 10             	mov    0x10(%ebp),%eax
  801c9f:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801ca2:	83 ec 04             	sub    $0x4,%esp
  801ca5:	68 c4 2c 80 00       	push   $0x802cc4
  801caa:	6a 59                	push   $0x59
  801cac:	68 e3 2c 80 00       	push   $0x802ce3
  801cb1:	e8 1e ec ff ff       	call   8008d4 <_panic>

00801cb6 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
  801cb9:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801cbc:	83 ec 04             	sub    $0x4,%esp
  801cbf:	68 ef 2c 80 00       	push   $0x802cef
  801cc4:	6a 5f                	push   $0x5f
  801cc6:	68 e3 2c 80 00       	push   $0x802ce3
  801ccb:	e8 04 ec ff ff       	call   8008d4 <_panic>

00801cd0 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801cd0:	55                   	push   %ebp
  801cd1:	89 e5                	mov    %esp,%ebp
  801cd3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801cd6:	83 ec 04             	sub    $0x4,%esp
  801cd9:	68 0c 2d 80 00       	push   $0x802d0c
  801cde:	6a 70                	push   $0x70
  801ce0:	68 e3 2c 80 00       	push   $0x802ce3
  801ce5:	e8 ea eb ff ff       	call   8008d4 <_panic>

00801cea <sfree>:

}


void sfree(void* virtual_address)
{
  801cea:	55                   	push   %ebp
  801ceb:	89 e5                	mov    %esp,%ebp
  801ced:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801cf0:	83 ec 04             	sub    $0x4,%esp
  801cf3:	68 2f 2d 80 00       	push   $0x802d2f
  801cf8:	6a 7b                	push   $0x7b
  801cfa:	68 e3 2c 80 00       	push   $0x802ce3
  801cff:	e8 d0 eb ff ff       	call   8008d4 <_panic>

00801d04 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801d04:	55                   	push   %ebp
  801d05:	89 e5                	mov    %esp,%ebp
  801d07:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801d0a:	83 ec 04             	sub    $0x4,%esp
  801d0d:	68 4c 2d 80 00       	push   $0x802d4c
  801d12:	68 93 00 00 00       	push   $0x93
  801d17:	68 e3 2c 80 00       	push   $0x802ce3
  801d1c:	e8 b3 eb ff ff       	call   8008d4 <_panic>

00801d21 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d21:	55                   	push   %ebp
  801d22:	89 e5                	mov    %esp,%ebp
  801d24:	57                   	push   %edi
  801d25:	56                   	push   %esi
  801d26:	53                   	push   %ebx
  801d27:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d30:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d33:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d36:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d39:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d3c:	cd 30                	int    $0x30
  801d3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d41:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d44:	83 c4 10             	add    $0x10,%esp
  801d47:	5b                   	pop    %ebx
  801d48:	5e                   	pop    %esi
  801d49:	5f                   	pop    %edi
  801d4a:	5d                   	pop    %ebp
  801d4b:	c3                   	ret    

00801d4c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d4c:	55                   	push   %ebp
  801d4d:	89 e5                	mov    %esp,%ebp
  801d4f:	83 ec 04             	sub    $0x4,%esp
  801d52:	8b 45 10             	mov    0x10(%ebp),%eax
  801d55:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d58:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	52                   	push   %edx
  801d64:	ff 75 0c             	pushl  0xc(%ebp)
  801d67:	50                   	push   %eax
  801d68:	6a 00                	push   $0x0
  801d6a:	e8 b2 ff ff ff       	call   801d21 <syscall>
  801d6f:	83 c4 18             	add    $0x18,%esp
}
  801d72:	90                   	nop
  801d73:	c9                   	leave  
  801d74:	c3                   	ret    

00801d75 <sys_cgetc>:

int
sys_cgetc(void)
{
  801d75:	55                   	push   %ebp
  801d76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 00                	push   $0x0
  801d80:	6a 00                	push   $0x0
  801d82:	6a 01                	push   $0x1
  801d84:	e8 98 ff ff ff       	call   801d21 <syscall>
  801d89:	83 c4 18             	add    $0x18,%esp
}
  801d8c:	c9                   	leave  
  801d8d:	c3                   	ret    

00801d8e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d8e:	55                   	push   %ebp
  801d8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d91:	8b 45 08             	mov    0x8(%ebp),%eax
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	50                   	push   %eax
  801d9d:	6a 05                	push   $0x5
  801d9f:	e8 7d ff ff ff       	call   801d21 <syscall>
  801da4:	83 c4 18             	add    $0x18,%esp
}
  801da7:	c9                   	leave  
  801da8:	c3                   	ret    

00801da9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801da9:	55                   	push   %ebp
  801daa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	6a 00                	push   $0x0
  801db6:	6a 02                	push   $0x2
  801db8:	e8 64 ff ff ff       	call   801d21 <syscall>
  801dbd:	83 c4 18             	add    $0x18,%esp
}
  801dc0:	c9                   	leave  
  801dc1:	c3                   	ret    

00801dc2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801dc2:	55                   	push   %ebp
  801dc3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 03                	push   $0x3
  801dd1:	e8 4b ff ff ff       	call   801d21 <syscall>
  801dd6:	83 c4 18             	add    $0x18,%esp
}
  801dd9:	c9                   	leave  
  801dda:	c3                   	ret    

00801ddb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ddb:	55                   	push   %ebp
  801ddc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 00                	push   $0x0
  801de6:	6a 00                	push   $0x0
  801de8:	6a 04                	push   $0x4
  801dea:	e8 32 ff ff ff       	call   801d21 <syscall>
  801def:	83 c4 18             	add    $0x18,%esp
}
  801df2:	c9                   	leave  
  801df3:	c3                   	ret    

00801df4 <sys_env_exit>:


void sys_env_exit(void)
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 06                	push   $0x6
  801e03:	e8 19 ff ff ff       	call   801d21 <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
}
  801e0b:	90                   	nop
  801e0c:	c9                   	leave  
  801e0d:	c3                   	ret    

00801e0e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e0e:	55                   	push   %ebp
  801e0f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e14:	8b 45 08             	mov    0x8(%ebp),%eax
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	52                   	push   %edx
  801e1e:	50                   	push   %eax
  801e1f:	6a 07                	push   $0x7
  801e21:	e8 fb fe ff ff       	call   801d21 <syscall>
  801e26:	83 c4 18             	add    $0x18,%esp
}
  801e29:	c9                   	leave  
  801e2a:	c3                   	ret    

00801e2b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e2b:	55                   	push   %ebp
  801e2c:	89 e5                	mov    %esp,%ebp
  801e2e:	56                   	push   %esi
  801e2f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e30:	8b 75 18             	mov    0x18(%ebp),%esi
  801e33:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e36:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e39:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3f:	56                   	push   %esi
  801e40:	53                   	push   %ebx
  801e41:	51                   	push   %ecx
  801e42:	52                   	push   %edx
  801e43:	50                   	push   %eax
  801e44:	6a 08                	push   $0x8
  801e46:	e8 d6 fe ff ff       	call   801d21 <syscall>
  801e4b:	83 c4 18             	add    $0x18,%esp
}
  801e4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e51:	5b                   	pop    %ebx
  801e52:	5e                   	pop    %esi
  801e53:	5d                   	pop    %ebp
  801e54:	c3                   	ret    

00801e55 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e58:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	52                   	push   %edx
  801e65:	50                   	push   %eax
  801e66:	6a 09                	push   $0x9
  801e68:	e8 b4 fe ff ff       	call   801d21 <syscall>
  801e6d:	83 c4 18             	add    $0x18,%esp
}
  801e70:	c9                   	leave  
  801e71:	c3                   	ret    

00801e72 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e72:	55                   	push   %ebp
  801e73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	ff 75 0c             	pushl  0xc(%ebp)
  801e7e:	ff 75 08             	pushl  0x8(%ebp)
  801e81:	6a 0a                	push   $0xa
  801e83:	e8 99 fe ff ff       	call   801d21 <syscall>
  801e88:	83 c4 18             	add    $0x18,%esp
}
  801e8b:	c9                   	leave  
  801e8c:	c3                   	ret    

00801e8d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e8d:	55                   	push   %ebp
  801e8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 0b                	push   $0xb
  801e9c:	e8 80 fe ff ff       	call   801d21 <syscall>
  801ea1:	83 c4 18             	add    $0x18,%esp
}
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 0c                	push   $0xc
  801eb5:	e8 67 fe ff ff       	call   801d21 <syscall>
  801eba:	83 c4 18             	add    $0x18,%esp
}
  801ebd:	c9                   	leave  
  801ebe:	c3                   	ret    

00801ebf <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ebf:	55                   	push   %ebp
  801ec0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 0d                	push   $0xd
  801ece:	e8 4e fe ff ff       	call   801d21 <syscall>
  801ed3:	83 c4 18             	add    $0x18,%esp
}
  801ed6:	c9                   	leave  
  801ed7:	c3                   	ret    

00801ed8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ed8:	55                   	push   %ebp
  801ed9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	ff 75 0c             	pushl  0xc(%ebp)
  801ee4:	ff 75 08             	pushl  0x8(%ebp)
  801ee7:	6a 11                	push   $0x11
  801ee9:	e8 33 fe ff ff       	call   801d21 <syscall>
  801eee:	83 c4 18             	add    $0x18,%esp
	return;
  801ef1:	90                   	nop
}
  801ef2:	c9                   	leave  
  801ef3:	c3                   	ret    

00801ef4 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801ef4:	55                   	push   %ebp
  801ef5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	ff 75 0c             	pushl  0xc(%ebp)
  801f00:	ff 75 08             	pushl  0x8(%ebp)
  801f03:	6a 12                	push   $0x12
  801f05:	e8 17 fe ff ff       	call   801d21 <syscall>
  801f0a:	83 c4 18             	add    $0x18,%esp
	return ;
  801f0d:	90                   	nop
}
  801f0e:	c9                   	leave  
  801f0f:	c3                   	ret    

00801f10 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f10:	55                   	push   %ebp
  801f11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 0e                	push   $0xe
  801f1f:	e8 fd fd ff ff       	call   801d21 <syscall>
  801f24:	83 c4 18             	add    $0x18,%esp
}
  801f27:	c9                   	leave  
  801f28:	c3                   	ret    

00801f29 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f29:	55                   	push   %ebp
  801f2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	ff 75 08             	pushl  0x8(%ebp)
  801f37:	6a 0f                	push   $0xf
  801f39:	e8 e3 fd ff ff       	call   801d21 <syscall>
  801f3e:	83 c4 18             	add    $0x18,%esp
}
  801f41:	c9                   	leave  
  801f42:	c3                   	ret    

00801f43 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f43:	55                   	push   %ebp
  801f44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 10                	push   $0x10
  801f52:	e8 ca fd ff ff       	call   801d21 <syscall>
  801f57:	83 c4 18             	add    $0x18,%esp
}
  801f5a:	90                   	nop
  801f5b:	c9                   	leave  
  801f5c:	c3                   	ret    

00801f5d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f5d:	55                   	push   %ebp
  801f5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 14                	push   $0x14
  801f6c:	e8 b0 fd ff ff       	call   801d21 <syscall>
  801f71:	83 c4 18             	add    $0x18,%esp
}
  801f74:	90                   	nop
  801f75:	c9                   	leave  
  801f76:	c3                   	ret    

00801f77 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f77:	55                   	push   %ebp
  801f78:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 15                	push   $0x15
  801f86:	e8 96 fd ff ff       	call   801d21 <syscall>
  801f8b:	83 c4 18             	add    $0x18,%esp
}
  801f8e:	90                   	nop
  801f8f:	c9                   	leave  
  801f90:	c3                   	ret    

00801f91 <sys_cputc>:


void
sys_cputc(const char c)
{
  801f91:	55                   	push   %ebp
  801f92:	89 e5                	mov    %esp,%ebp
  801f94:	83 ec 04             	sub    $0x4,%esp
  801f97:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f9d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 00                	push   $0x0
  801fa7:	6a 00                	push   $0x0
  801fa9:	50                   	push   %eax
  801faa:	6a 16                	push   $0x16
  801fac:	e8 70 fd ff ff       	call   801d21 <syscall>
  801fb1:	83 c4 18             	add    $0x18,%esp
}
  801fb4:	90                   	nop
  801fb5:	c9                   	leave  
  801fb6:	c3                   	ret    

00801fb7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801fb7:	55                   	push   %ebp
  801fb8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 17                	push   $0x17
  801fc6:	e8 56 fd ff ff       	call   801d21 <syscall>
  801fcb:	83 c4 18             	add    $0x18,%esp
}
  801fce:	90                   	nop
  801fcf:	c9                   	leave  
  801fd0:	c3                   	ret    

00801fd1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801fd1:	55                   	push   %ebp
  801fd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	ff 75 0c             	pushl  0xc(%ebp)
  801fe0:	50                   	push   %eax
  801fe1:	6a 18                	push   $0x18
  801fe3:	e8 39 fd ff ff       	call   801d21 <syscall>
  801fe8:	83 c4 18             	add    $0x18,%esp
}
  801feb:	c9                   	leave  
  801fec:	c3                   	ret    

00801fed <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801fed:	55                   	push   %ebp
  801fee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ff0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 00                	push   $0x0
  801ffc:	52                   	push   %edx
  801ffd:	50                   	push   %eax
  801ffe:	6a 1b                	push   $0x1b
  802000:	e8 1c fd ff ff       	call   801d21 <syscall>
  802005:	83 c4 18             	add    $0x18,%esp
}
  802008:	c9                   	leave  
  802009:	c3                   	ret    

0080200a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80200a:	55                   	push   %ebp
  80200b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80200d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802010:	8b 45 08             	mov    0x8(%ebp),%eax
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	52                   	push   %edx
  80201a:	50                   	push   %eax
  80201b:	6a 19                	push   $0x19
  80201d:	e8 ff fc ff ff       	call   801d21 <syscall>
  802022:	83 c4 18             	add    $0x18,%esp
}
  802025:	90                   	nop
  802026:	c9                   	leave  
  802027:	c3                   	ret    

00802028 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802028:	55                   	push   %ebp
  802029:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80202b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80202e:	8b 45 08             	mov    0x8(%ebp),%eax
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	6a 00                	push   $0x0
  802037:	52                   	push   %edx
  802038:	50                   	push   %eax
  802039:	6a 1a                	push   $0x1a
  80203b:	e8 e1 fc ff ff       	call   801d21 <syscall>
  802040:	83 c4 18             	add    $0x18,%esp
}
  802043:	90                   	nop
  802044:	c9                   	leave  
  802045:	c3                   	ret    

00802046 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802046:	55                   	push   %ebp
  802047:	89 e5                	mov    %esp,%ebp
  802049:	83 ec 04             	sub    $0x4,%esp
  80204c:	8b 45 10             	mov    0x10(%ebp),%eax
  80204f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802052:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802055:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802059:	8b 45 08             	mov    0x8(%ebp),%eax
  80205c:	6a 00                	push   $0x0
  80205e:	51                   	push   %ecx
  80205f:	52                   	push   %edx
  802060:	ff 75 0c             	pushl  0xc(%ebp)
  802063:	50                   	push   %eax
  802064:	6a 1c                	push   $0x1c
  802066:	e8 b6 fc ff ff       	call   801d21 <syscall>
  80206b:	83 c4 18             	add    $0x18,%esp
}
  80206e:	c9                   	leave  
  80206f:	c3                   	ret    

00802070 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802070:	55                   	push   %ebp
  802071:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802073:	8b 55 0c             	mov    0xc(%ebp),%edx
  802076:	8b 45 08             	mov    0x8(%ebp),%eax
  802079:	6a 00                	push   $0x0
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	52                   	push   %edx
  802080:	50                   	push   %eax
  802081:	6a 1d                	push   $0x1d
  802083:	e8 99 fc ff ff       	call   801d21 <syscall>
  802088:	83 c4 18             	add    $0x18,%esp
}
  80208b:	c9                   	leave  
  80208c:	c3                   	ret    

0080208d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80208d:	55                   	push   %ebp
  80208e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802090:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802093:	8b 55 0c             	mov    0xc(%ebp),%edx
  802096:	8b 45 08             	mov    0x8(%ebp),%eax
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	51                   	push   %ecx
  80209e:	52                   	push   %edx
  80209f:	50                   	push   %eax
  8020a0:	6a 1e                	push   $0x1e
  8020a2:	e8 7a fc ff ff       	call   801d21 <syscall>
  8020a7:	83 c4 18             	add    $0x18,%esp
}
  8020aa:	c9                   	leave  
  8020ab:	c3                   	ret    

008020ac <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020ac:	55                   	push   %ebp
  8020ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8020af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	52                   	push   %edx
  8020bc:	50                   	push   %eax
  8020bd:	6a 1f                	push   $0x1f
  8020bf:	e8 5d fc ff ff       	call   801d21 <syscall>
  8020c4:	83 c4 18             	add    $0x18,%esp
}
  8020c7:	c9                   	leave  
  8020c8:	c3                   	ret    

008020c9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8020c9:	55                   	push   %ebp
  8020ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 20                	push   $0x20
  8020d8:	e8 44 fc ff ff       	call   801d21 <syscall>
  8020dd:	83 c4 18             	add    $0x18,%esp
}
  8020e0:	c9                   	leave  
  8020e1:	c3                   	ret    

008020e2 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8020e2:	55                   	push   %ebp
  8020e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8020e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 00                	push   $0x0
  8020ec:	ff 75 10             	pushl  0x10(%ebp)
  8020ef:	ff 75 0c             	pushl  0xc(%ebp)
  8020f2:	50                   	push   %eax
  8020f3:	6a 21                	push   $0x21
  8020f5:	e8 27 fc ff ff       	call   801d21 <syscall>
  8020fa:	83 c4 18             	add    $0x18,%esp
}
  8020fd:	c9                   	leave  
  8020fe:	c3                   	ret    

008020ff <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8020ff:	55                   	push   %ebp
  802100:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802102:	8b 45 08             	mov    0x8(%ebp),%eax
  802105:	6a 00                	push   $0x0
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	6a 00                	push   $0x0
  80210d:	50                   	push   %eax
  80210e:	6a 22                	push   $0x22
  802110:	e8 0c fc ff ff       	call   801d21 <syscall>
  802115:	83 c4 18             	add    $0x18,%esp
}
  802118:	90                   	nop
  802119:	c9                   	leave  
  80211a:	c3                   	ret    

0080211b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80211b:	55                   	push   %ebp
  80211c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80211e:	8b 45 08             	mov    0x8(%ebp),%eax
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	50                   	push   %eax
  80212a:	6a 23                	push   $0x23
  80212c:	e8 f0 fb ff ff       	call   801d21 <syscall>
  802131:	83 c4 18             	add    $0x18,%esp
}
  802134:	90                   	nop
  802135:	c9                   	leave  
  802136:	c3                   	ret    

00802137 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802137:	55                   	push   %ebp
  802138:	89 e5                	mov    %esp,%ebp
  80213a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80213d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802140:	8d 50 04             	lea    0x4(%eax),%edx
  802143:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	52                   	push   %edx
  80214d:	50                   	push   %eax
  80214e:	6a 24                	push   $0x24
  802150:	e8 cc fb ff ff       	call   801d21 <syscall>
  802155:	83 c4 18             	add    $0x18,%esp
	return result;
  802158:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80215b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80215e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802161:	89 01                	mov    %eax,(%ecx)
  802163:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802166:	8b 45 08             	mov    0x8(%ebp),%eax
  802169:	c9                   	leave  
  80216a:	c2 04 00             	ret    $0x4

0080216d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	ff 75 10             	pushl  0x10(%ebp)
  802177:	ff 75 0c             	pushl  0xc(%ebp)
  80217a:	ff 75 08             	pushl  0x8(%ebp)
  80217d:	6a 13                	push   $0x13
  80217f:	e8 9d fb ff ff       	call   801d21 <syscall>
  802184:	83 c4 18             	add    $0x18,%esp
	return ;
  802187:	90                   	nop
}
  802188:	c9                   	leave  
  802189:	c3                   	ret    

0080218a <sys_rcr2>:
uint32 sys_rcr2()
{
  80218a:	55                   	push   %ebp
  80218b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	6a 00                	push   $0x0
  802197:	6a 25                	push   $0x25
  802199:	e8 83 fb ff ff       	call   801d21 <syscall>
  80219e:	83 c4 18             	add    $0x18,%esp
}
  8021a1:	c9                   	leave  
  8021a2:	c3                   	ret    

008021a3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021a3:	55                   	push   %ebp
  8021a4:	89 e5                	mov    %esp,%ebp
  8021a6:	83 ec 04             	sub    $0x4,%esp
  8021a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ac:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8021af:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 00                	push   $0x0
  8021b7:	6a 00                	push   $0x0
  8021b9:	6a 00                	push   $0x0
  8021bb:	50                   	push   %eax
  8021bc:	6a 26                	push   $0x26
  8021be:	e8 5e fb ff ff       	call   801d21 <syscall>
  8021c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8021c6:	90                   	nop
}
  8021c7:	c9                   	leave  
  8021c8:	c3                   	ret    

008021c9 <rsttst>:
void rsttst()
{
  8021c9:	55                   	push   %ebp
  8021ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8021cc:	6a 00                	push   $0x0
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 28                	push   $0x28
  8021d8:	e8 44 fb ff ff       	call   801d21 <syscall>
  8021dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e0:	90                   	nop
}
  8021e1:	c9                   	leave  
  8021e2:	c3                   	ret    

008021e3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8021e3:	55                   	push   %ebp
  8021e4:	89 e5                	mov    %esp,%ebp
  8021e6:	83 ec 04             	sub    $0x4,%esp
  8021e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8021ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8021ef:	8b 55 18             	mov    0x18(%ebp),%edx
  8021f2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021f6:	52                   	push   %edx
  8021f7:	50                   	push   %eax
  8021f8:	ff 75 10             	pushl  0x10(%ebp)
  8021fb:	ff 75 0c             	pushl  0xc(%ebp)
  8021fe:	ff 75 08             	pushl  0x8(%ebp)
  802201:	6a 27                	push   $0x27
  802203:	e8 19 fb ff ff       	call   801d21 <syscall>
  802208:	83 c4 18             	add    $0x18,%esp
	return ;
  80220b:	90                   	nop
}
  80220c:	c9                   	leave  
  80220d:	c3                   	ret    

0080220e <chktst>:
void chktst(uint32 n)
{
  80220e:	55                   	push   %ebp
  80220f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802211:	6a 00                	push   $0x0
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	ff 75 08             	pushl  0x8(%ebp)
  80221c:	6a 29                	push   $0x29
  80221e:	e8 fe fa ff ff       	call   801d21 <syscall>
  802223:	83 c4 18             	add    $0x18,%esp
	return ;
  802226:	90                   	nop
}
  802227:	c9                   	leave  
  802228:	c3                   	ret    

00802229 <inctst>:

void inctst()
{
  802229:	55                   	push   %ebp
  80222a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 00                	push   $0x0
  802232:	6a 00                	push   $0x0
  802234:	6a 00                	push   $0x0
  802236:	6a 2a                	push   $0x2a
  802238:	e8 e4 fa ff ff       	call   801d21 <syscall>
  80223d:	83 c4 18             	add    $0x18,%esp
	return ;
  802240:	90                   	nop
}
  802241:	c9                   	leave  
  802242:	c3                   	ret    

00802243 <gettst>:
uint32 gettst()
{
  802243:	55                   	push   %ebp
  802244:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 00                	push   $0x0
  80224e:	6a 00                	push   $0x0
  802250:	6a 2b                	push   $0x2b
  802252:	e8 ca fa ff ff       	call   801d21 <syscall>
  802257:	83 c4 18             	add    $0x18,%esp
}
  80225a:	c9                   	leave  
  80225b:	c3                   	ret    

0080225c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80225c:	55                   	push   %ebp
  80225d:	89 e5                	mov    %esp,%ebp
  80225f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802262:	6a 00                	push   $0x0
  802264:	6a 00                	push   $0x0
  802266:	6a 00                	push   $0x0
  802268:	6a 00                	push   $0x0
  80226a:	6a 00                	push   $0x0
  80226c:	6a 2c                	push   $0x2c
  80226e:	e8 ae fa ff ff       	call   801d21 <syscall>
  802273:	83 c4 18             	add    $0x18,%esp
  802276:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802279:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80227d:	75 07                	jne    802286 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80227f:	b8 01 00 00 00       	mov    $0x1,%eax
  802284:	eb 05                	jmp    80228b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802286:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80228b:	c9                   	leave  
  80228c:	c3                   	ret    

0080228d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80228d:	55                   	push   %ebp
  80228e:	89 e5                	mov    %esp,%ebp
  802290:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802293:	6a 00                	push   $0x0
  802295:	6a 00                	push   $0x0
  802297:	6a 00                	push   $0x0
  802299:	6a 00                	push   $0x0
  80229b:	6a 00                	push   $0x0
  80229d:	6a 2c                	push   $0x2c
  80229f:	e8 7d fa ff ff       	call   801d21 <syscall>
  8022a4:	83 c4 18             	add    $0x18,%esp
  8022a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022aa:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8022ae:	75 07                	jne    8022b7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8022b0:	b8 01 00 00 00       	mov    $0x1,%eax
  8022b5:	eb 05                	jmp    8022bc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8022b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022bc:	c9                   	leave  
  8022bd:	c3                   	ret    

008022be <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8022be:	55                   	push   %ebp
  8022bf:	89 e5                	mov    %esp,%ebp
  8022c1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 00                	push   $0x0
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 00                	push   $0x0
  8022cc:	6a 00                	push   $0x0
  8022ce:	6a 2c                	push   $0x2c
  8022d0:	e8 4c fa ff ff       	call   801d21 <syscall>
  8022d5:	83 c4 18             	add    $0x18,%esp
  8022d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8022db:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8022df:	75 07                	jne    8022e8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8022e1:	b8 01 00 00 00       	mov    $0x1,%eax
  8022e6:	eb 05                	jmp    8022ed <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8022e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022ed:	c9                   	leave  
  8022ee:	c3                   	ret    

008022ef <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8022ef:	55                   	push   %ebp
  8022f0:	89 e5                	mov    %esp,%ebp
  8022f2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022f5:	6a 00                	push   $0x0
  8022f7:	6a 00                	push   $0x0
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 00                	push   $0x0
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 2c                	push   $0x2c
  802301:	e8 1b fa ff ff       	call   801d21 <syscall>
  802306:	83 c4 18             	add    $0x18,%esp
  802309:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80230c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802310:	75 07                	jne    802319 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802312:	b8 01 00 00 00       	mov    $0x1,%eax
  802317:	eb 05                	jmp    80231e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802319:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80231e:	c9                   	leave  
  80231f:	c3                   	ret    

00802320 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802320:	55                   	push   %ebp
  802321:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802323:	6a 00                	push   $0x0
  802325:	6a 00                	push   $0x0
  802327:	6a 00                	push   $0x0
  802329:	6a 00                	push   $0x0
  80232b:	ff 75 08             	pushl  0x8(%ebp)
  80232e:	6a 2d                	push   $0x2d
  802330:	e8 ec f9 ff ff       	call   801d21 <syscall>
  802335:	83 c4 18             	add    $0x18,%esp
	return ;
  802338:	90                   	nop
}
  802339:	c9                   	leave  
  80233a:	c3                   	ret    
  80233b:	90                   	nop

0080233c <__udivdi3>:
  80233c:	55                   	push   %ebp
  80233d:	57                   	push   %edi
  80233e:	56                   	push   %esi
  80233f:	53                   	push   %ebx
  802340:	83 ec 1c             	sub    $0x1c,%esp
  802343:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802347:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80234b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80234f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802353:	89 ca                	mov    %ecx,%edx
  802355:	89 f8                	mov    %edi,%eax
  802357:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80235b:	85 f6                	test   %esi,%esi
  80235d:	75 2d                	jne    80238c <__udivdi3+0x50>
  80235f:	39 cf                	cmp    %ecx,%edi
  802361:	77 65                	ja     8023c8 <__udivdi3+0x8c>
  802363:	89 fd                	mov    %edi,%ebp
  802365:	85 ff                	test   %edi,%edi
  802367:	75 0b                	jne    802374 <__udivdi3+0x38>
  802369:	b8 01 00 00 00       	mov    $0x1,%eax
  80236e:	31 d2                	xor    %edx,%edx
  802370:	f7 f7                	div    %edi
  802372:	89 c5                	mov    %eax,%ebp
  802374:	31 d2                	xor    %edx,%edx
  802376:	89 c8                	mov    %ecx,%eax
  802378:	f7 f5                	div    %ebp
  80237a:	89 c1                	mov    %eax,%ecx
  80237c:	89 d8                	mov    %ebx,%eax
  80237e:	f7 f5                	div    %ebp
  802380:	89 cf                	mov    %ecx,%edi
  802382:	89 fa                	mov    %edi,%edx
  802384:	83 c4 1c             	add    $0x1c,%esp
  802387:	5b                   	pop    %ebx
  802388:	5e                   	pop    %esi
  802389:	5f                   	pop    %edi
  80238a:	5d                   	pop    %ebp
  80238b:	c3                   	ret    
  80238c:	39 ce                	cmp    %ecx,%esi
  80238e:	77 28                	ja     8023b8 <__udivdi3+0x7c>
  802390:	0f bd fe             	bsr    %esi,%edi
  802393:	83 f7 1f             	xor    $0x1f,%edi
  802396:	75 40                	jne    8023d8 <__udivdi3+0x9c>
  802398:	39 ce                	cmp    %ecx,%esi
  80239a:	72 0a                	jb     8023a6 <__udivdi3+0x6a>
  80239c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8023a0:	0f 87 9e 00 00 00    	ja     802444 <__udivdi3+0x108>
  8023a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8023ab:	89 fa                	mov    %edi,%edx
  8023ad:	83 c4 1c             	add    $0x1c,%esp
  8023b0:	5b                   	pop    %ebx
  8023b1:	5e                   	pop    %esi
  8023b2:	5f                   	pop    %edi
  8023b3:	5d                   	pop    %ebp
  8023b4:	c3                   	ret    
  8023b5:	8d 76 00             	lea    0x0(%esi),%esi
  8023b8:	31 ff                	xor    %edi,%edi
  8023ba:	31 c0                	xor    %eax,%eax
  8023bc:	89 fa                	mov    %edi,%edx
  8023be:	83 c4 1c             	add    $0x1c,%esp
  8023c1:	5b                   	pop    %ebx
  8023c2:	5e                   	pop    %esi
  8023c3:	5f                   	pop    %edi
  8023c4:	5d                   	pop    %ebp
  8023c5:	c3                   	ret    
  8023c6:	66 90                	xchg   %ax,%ax
  8023c8:	89 d8                	mov    %ebx,%eax
  8023ca:	f7 f7                	div    %edi
  8023cc:	31 ff                	xor    %edi,%edi
  8023ce:	89 fa                	mov    %edi,%edx
  8023d0:	83 c4 1c             	add    $0x1c,%esp
  8023d3:	5b                   	pop    %ebx
  8023d4:	5e                   	pop    %esi
  8023d5:	5f                   	pop    %edi
  8023d6:	5d                   	pop    %ebp
  8023d7:	c3                   	ret    
  8023d8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023dd:	89 eb                	mov    %ebp,%ebx
  8023df:	29 fb                	sub    %edi,%ebx
  8023e1:	89 f9                	mov    %edi,%ecx
  8023e3:	d3 e6                	shl    %cl,%esi
  8023e5:	89 c5                	mov    %eax,%ebp
  8023e7:	88 d9                	mov    %bl,%cl
  8023e9:	d3 ed                	shr    %cl,%ebp
  8023eb:	89 e9                	mov    %ebp,%ecx
  8023ed:	09 f1                	or     %esi,%ecx
  8023ef:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023f3:	89 f9                	mov    %edi,%ecx
  8023f5:	d3 e0                	shl    %cl,%eax
  8023f7:	89 c5                	mov    %eax,%ebp
  8023f9:	89 d6                	mov    %edx,%esi
  8023fb:	88 d9                	mov    %bl,%cl
  8023fd:	d3 ee                	shr    %cl,%esi
  8023ff:	89 f9                	mov    %edi,%ecx
  802401:	d3 e2                	shl    %cl,%edx
  802403:	8b 44 24 08          	mov    0x8(%esp),%eax
  802407:	88 d9                	mov    %bl,%cl
  802409:	d3 e8                	shr    %cl,%eax
  80240b:	09 c2                	or     %eax,%edx
  80240d:	89 d0                	mov    %edx,%eax
  80240f:	89 f2                	mov    %esi,%edx
  802411:	f7 74 24 0c          	divl   0xc(%esp)
  802415:	89 d6                	mov    %edx,%esi
  802417:	89 c3                	mov    %eax,%ebx
  802419:	f7 e5                	mul    %ebp
  80241b:	39 d6                	cmp    %edx,%esi
  80241d:	72 19                	jb     802438 <__udivdi3+0xfc>
  80241f:	74 0b                	je     80242c <__udivdi3+0xf0>
  802421:	89 d8                	mov    %ebx,%eax
  802423:	31 ff                	xor    %edi,%edi
  802425:	e9 58 ff ff ff       	jmp    802382 <__udivdi3+0x46>
  80242a:	66 90                	xchg   %ax,%ax
  80242c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802430:	89 f9                	mov    %edi,%ecx
  802432:	d3 e2                	shl    %cl,%edx
  802434:	39 c2                	cmp    %eax,%edx
  802436:	73 e9                	jae    802421 <__udivdi3+0xe5>
  802438:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80243b:	31 ff                	xor    %edi,%edi
  80243d:	e9 40 ff ff ff       	jmp    802382 <__udivdi3+0x46>
  802442:	66 90                	xchg   %ax,%ax
  802444:	31 c0                	xor    %eax,%eax
  802446:	e9 37 ff ff ff       	jmp    802382 <__udivdi3+0x46>
  80244b:	90                   	nop

0080244c <__umoddi3>:
  80244c:	55                   	push   %ebp
  80244d:	57                   	push   %edi
  80244e:	56                   	push   %esi
  80244f:	53                   	push   %ebx
  802450:	83 ec 1c             	sub    $0x1c,%esp
  802453:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802457:	8b 74 24 34          	mov    0x34(%esp),%esi
  80245b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80245f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802463:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802467:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80246b:	89 f3                	mov    %esi,%ebx
  80246d:	89 fa                	mov    %edi,%edx
  80246f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802473:	89 34 24             	mov    %esi,(%esp)
  802476:	85 c0                	test   %eax,%eax
  802478:	75 1a                	jne    802494 <__umoddi3+0x48>
  80247a:	39 f7                	cmp    %esi,%edi
  80247c:	0f 86 a2 00 00 00    	jbe    802524 <__umoddi3+0xd8>
  802482:	89 c8                	mov    %ecx,%eax
  802484:	89 f2                	mov    %esi,%edx
  802486:	f7 f7                	div    %edi
  802488:	89 d0                	mov    %edx,%eax
  80248a:	31 d2                	xor    %edx,%edx
  80248c:	83 c4 1c             	add    $0x1c,%esp
  80248f:	5b                   	pop    %ebx
  802490:	5e                   	pop    %esi
  802491:	5f                   	pop    %edi
  802492:	5d                   	pop    %ebp
  802493:	c3                   	ret    
  802494:	39 f0                	cmp    %esi,%eax
  802496:	0f 87 ac 00 00 00    	ja     802548 <__umoddi3+0xfc>
  80249c:	0f bd e8             	bsr    %eax,%ebp
  80249f:	83 f5 1f             	xor    $0x1f,%ebp
  8024a2:	0f 84 ac 00 00 00    	je     802554 <__umoddi3+0x108>
  8024a8:	bf 20 00 00 00       	mov    $0x20,%edi
  8024ad:	29 ef                	sub    %ebp,%edi
  8024af:	89 fe                	mov    %edi,%esi
  8024b1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8024b5:	89 e9                	mov    %ebp,%ecx
  8024b7:	d3 e0                	shl    %cl,%eax
  8024b9:	89 d7                	mov    %edx,%edi
  8024bb:	89 f1                	mov    %esi,%ecx
  8024bd:	d3 ef                	shr    %cl,%edi
  8024bf:	09 c7                	or     %eax,%edi
  8024c1:	89 e9                	mov    %ebp,%ecx
  8024c3:	d3 e2                	shl    %cl,%edx
  8024c5:	89 14 24             	mov    %edx,(%esp)
  8024c8:	89 d8                	mov    %ebx,%eax
  8024ca:	d3 e0                	shl    %cl,%eax
  8024cc:	89 c2                	mov    %eax,%edx
  8024ce:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024d2:	d3 e0                	shl    %cl,%eax
  8024d4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8024d8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024dc:	89 f1                	mov    %esi,%ecx
  8024de:	d3 e8                	shr    %cl,%eax
  8024e0:	09 d0                	or     %edx,%eax
  8024e2:	d3 eb                	shr    %cl,%ebx
  8024e4:	89 da                	mov    %ebx,%edx
  8024e6:	f7 f7                	div    %edi
  8024e8:	89 d3                	mov    %edx,%ebx
  8024ea:	f7 24 24             	mull   (%esp)
  8024ed:	89 c6                	mov    %eax,%esi
  8024ef:	89 d1                	mov    %edx,%ecx
  8024f1:	39 d3                	cmp    %edx,%ebx
  8024f3:	0f 82 87 00 00 00    	jb     802580 <__umoddi3+0x134>
  8024f9:	0f 84 91 00 00 00    	je     802590 <__umoddi3+0x144>
  8024ff:	8b 54 24 04          	mov    0x4(%esp),%edx
  802503:	29 f2                	sub    %esi,%edx
  802505:	19 cb                	sbb    %ecx,%ebx
  802507:	89 d8                	mov    %ebx,%eax
  802509:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80250d:	d3 e0                	shl    %cl,%eax
  80250f:	89 e9                	mov    %ebp,%ecx
  802511:	d3 ea                	shr    %cl,%edx
  802513:	09 d0                	or     %edx,%eax
  802515:	89 e9                	mov    %ebp,%ecx
  802517:	d3 eb                	shr    %cl,%ebx
  802519:	89 da                	mov    %ebx,%edx
  80251b:	83 c4 1c             	add    $0x1c,%esp
  80251e:	5b                   	pop    %ebx
  80251f:	5e                   	pop    %esi
  802520:	5f                   	pop    %edi
  802521:	5d                   	pop    %ebp
  802522:	c3                   	ret    
  802523:	90                   	nop
  802524:	89 fd                	mov    %edi,%ebp
  802526:	85 ff                	test   %edi,%edi
  802528:	75 0b                	jne    802535 <__umoddi3+0xe9>
  80252a:	b8 01 00 00 00       	mov    $0x1,%eax
  80252f:	31 d2                	xor    %edx,%edx
  802531:	f7 f7                	div    %edi
  802533:	89 c5                	mov    %eax,%ebp
  802535:	89 f0                	mov    %esi,%eax
  802537:	31 d2                	xor    %edx,%edx
  802539:	f7 f5                	div    %ebp
  80253b:	89 c8                	mov    %ecx,%eax
  80253d:	f7 f5                	div    %ebp
  80253f:	89 d0                	mov    %edx,%eax
  802541:	e9 44 ff ff ff       	jmp    80248a <__umoddi3+0x3e>
  802546:	66 90                	xchg   %ax,%ax
  802548:	89 c8                	mov    %ecx,%eax
  80254a:	89 f2                	mov    %esi,%edx
  80254c:	83 c4 1c             	add    $0x1c,%esp
  80254f:	5b                   	pop    %ebx
  802550:	5e                   	pop    %esi
  802551:	5f                   	pop    %edi
  802552:	5d                   	pop    %ebp
  802553:	c3                   	ret    
  802554:	3b 04 24             	cmp    (%esp),%eax
  802557:	72 06                	jb     80255f <__umoddi3+0x113>
  802559:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80255d:	77 0f                	ja     80256e <__umoddi3+0x122>
  80255f:	89 f2                	mov    %esi,%edx
  802561:	29 f9                	sub    %edi,%ecx
  802563:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802567:	89 14 24             	mov    %edx,(%esp)
  80256a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80256e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802572:	8b 14 24             	mov    (%esp),%edx
  802575:	83 c4 1c             	add    $0x1c,%esp
  802578:	5b                   	pop    %ebx
  802579:	5e                   	pop    %esi
  80257a:	5f                   	pop    %edi
  80257b:	5d                   	pop    %ebp
  80257c:	c3                   	ret    
  80257d:	8d 76 00             	lea    0x0(%esi),%esi
  802580:	2b 04 24             	sub    (%esp),%eax
  802583:	19 fa                	sbb    %edi,%edx
  802585:	89 d1                	mov    %edx,%ecx
  802587:	89 c6                	mov    %eax,%esi
  802589:	e9 71 ff ff ff       	jmp    8024ff <__umoddi3+0xb3>
  80258e:	66 90                	xchg   %ax,%ax
  802590:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802594:	72 ea                	jb     802580 <__umoddi3+0x134>
  802596:	89 d9                	mov    %ebx,%ecx
  802598:	e9 62 ff ff ff       	jmp    8024ff <__umoddi3+0xb3>
