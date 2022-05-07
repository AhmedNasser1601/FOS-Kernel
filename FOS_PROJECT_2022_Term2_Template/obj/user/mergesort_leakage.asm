
obj/user/mergesort_leakage:     file format elf32-i386


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
  800031:	e8 73 07 00 00       	call   8007a9 <libmain>
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
  800041:	e8 fb 1e 00 00       	call   801f41 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 a0 25 80 00       	push   $0x8025a0
  80004e:	e8 19 0b 00 00       	call   800b6c <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 a2 25 80 00       	push   $0x8025a2
  80005e:	e8 09 0b 00 00       	call   800b6c <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 b8 25 80 00       	push   $0x8025b8
  80006e:	e8 f9 0a 00 00       	call   800b6c <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 a2 25 80 00       	push   $0x8025a2
  80007e:	e8 e9 0a 00 00       	call   800b6c <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 a0 25 80 00       	push   $0x8025a0
  80008e:	e8 d9 0a 00 00       	call   800b6c <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 d0 25 80 00       	push   $0x8025d0
  8000a5:	e8 44 11 00 00       	call   8011ee <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 94 16 00 00       	call   801754 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 27 1a 00 00       	call   801afc <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 f0 25 80 00       	push   $0x8025f0
  8000e3:	e8 84 0a 00 00       	call   800b6c <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 12 26 80 00       	push   $0x802612
  8000f3:	e8 74 0a 00 00       	call   800b6c <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 20 26 80 00       	push   $0x802620
  800103:	e8 64 0a 00 00       	call   800b6c <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 2f 26 80 00       	push   $0x80262f
  800113:	e8 54 0a 00 00       	call   800b6c <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 3f 26 80 00       	push   $0x80263f
  800123:	e8 44 0a 00 00       	call   800b6c <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 21 06 00 00       	call   800751 <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 c9 05 00 00       	call   800709 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 bc 05 00 00       	call   800709 <cputchar>
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
  800162:	e8 f4 1d 00 00       	call   801f5b <sys_enable_interrupt>

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
  8001d7:	e8 65 1d 00 00       	call   801f41 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 48 26 80 00       	push   $0x802648
  8001e4:	e8 83 09 00 00       	call   800b6c <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 6a 1d 00 00       	call   801f5b <sys_enable_interrupt>

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
  80021a:	e8 99 06 00 00       	call   8008b8 <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 1d 1d 00 00       	call   801f41 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 b8 26 80 00       	push   $0x8026b8
  80022c:	e8 3b 09 00 00       	call   800b6c <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 ec 26 80 00       	push   $0x8026ec
  80023c:	e8 2b 09 00 00       	call   800b6c <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 20 27 80 00       	push   $0x802720
  80024c:	e8 1b 09 00 00       	call   800b6c <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 02 1d 00 00       	call   801f5b <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 50 1a 00 00       	call   801cb4 <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 d5 1c 00 00       	call   801f41 <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 52 27 80 00       	push   $0x802752
  80027a:	e8 ed 08 00 00       	call   800b6c <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 ca 04 00 00       	call   800751 <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 72 04 00 00       	call   800709 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 65 04 00 00       	call   800709 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 58 04 00 00       	call   800709 <cputchar>
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
  8002c0:	e8 96 1c 00 00       	call   801f5b <sys_enable_interrupt>

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
  800459:	e8 0e 07 00 00       	call   800b6c <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 70 27 80 00       	push   $0x802770
  80047b:	e8 ec 06 00 00       	call   800b6c <cprintf>
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
  8004a4:	68 75 27 80 00       	push   $0x802775
  8004a9:	e8 be 06 00 00       	call   800b6c <cprintf>
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

	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 ad 15 00 00       	call   801afc <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 98 15 00 00       	call   801afc <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

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

	//	int Left[5000] ;
	//	int Right[5000] ;

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
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  800706:	90                   	nop
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
  80070c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80070f:	8b 45 08             	mov    0x8(%ebp),%eax
  800712:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800715:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800719:	83 ec 0c             	sub    $0xc,%esp
  80071c:	50                   	push   %eax
  80071d:	e8 53 18 00 00       	call   801f75 <sys_cputc>
  800722:	83 c4 10             	add    $0x10,%esp
}
  800725:	90                   	nop
  800726:	c9                   	leave  
  800727:	c3                   	ret    

00800728 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800728:	55                   	push   %ebp
  800729:	89 e5                	mov    %esp,%ebp
  80072b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80072e:	e8 0e 18 00 00       	call   801f41 <sys_disable_interrupt>
	char c = ch;
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800739:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80073d:	83 ec 0c             	sub    $0xc,%esp
  800740:	50                   	push   %eax
  800741:	e8 2f 18 00 00       	call   801f75 <sys_cputc>
  800746:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800749:	e8 0d 18 00 00       	call   801f5b <sys_enable_interrupt>
}
  80074e:	90                   	nop
  80074f:	c9                   	leave  
  800750:	c3                   	ret    

00800751 <getchar>:

int
getchar(void)
{
  800751:	55                   	push   %ebp
  800752:	89 e5                	mov    %esp,%ebp
  800754:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800757:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80075e:	eb 08                	jmp    800768 <getchar+0x17>
	{
		c = sys_cgetc();
  800760:	e8 f4 15 00 00       	call   801d59 <sys_cgetc>
  800765:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800768:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80076c:	74 f2                	je     800760 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80076e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800771:	c9                   	leave  
  800772:	c3                   	ret    

00800773 <atomic_getchar>:

int
atomic_getchar(void)
{
  800773:	55                   	push   %ebp
  800774:	89 e5                	mov    %esp,%ebp
  800776:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800779:	e8 c3 17 00 00       	call   801f41 <sys_disable_interrupt>
	int c=0;
  80077e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800785:	eb 08                	jmp    80078f <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800787:	e8 cd 15 00 00       	call   801d59 <sys_cgetc>
  80078c:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80078f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800793:	74 f2                	je     800787 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800795:	e8 c1 17 00 00       	call   801f5b <sys_enable_interrupt>
	return c;
  80079a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80079d:	c9                   	leave  
  80079e:	c3                   	ret    

0080079f <iscons>:

int iscons(int fdnum)
{
  80079f:	55                   	push   %ebp
  8007a0:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007a2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007a7:	5d                   	pop    %ebp
  8007a8:	c3                   	ret    

008007a9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007a9:	55                   	push   %ebp
  8007aa:	89 e5                	mov    %esp,%ebp
  8007ac:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007af:	e8 f2 15 00 00       	call   801da6 <sys_getenvindex>
  8007b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ba:	89 d0                	mov    %edx,%eax
  8007bc:	c1 e0 02             	shl    $0x2,%eax
  8007bf:	01 d0                	add    %edx,%eax
  8007c1:	01 c0                	add    %eax,%eax
  8007c3:	01 d0                	add    %edx,%eax
  8007c5:	01 c0                	add    %eax,%eax
  8007c7:	01 d0                	add    %edx,%eax
  8007c9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007d0:	01 d0                	add    %edx,%eax
  8007d2:	c1 e0 02             	shl    $0x2,%eax
  8007d5:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007da:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007df:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e4:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8007ea:	84 c0                	test   %al,%al
  8007ec:	74 0f                	je     8007fd <libmain+0x54>
		binaryname = myEnv->prog_name;
  8007ee:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f3:	05 f4 02 00 00       	add    $0x2f4,%eax
  8007f8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800801:	7e 0a                	jle    80080d <libmain+0x64>
		binaryname = argv[0];
  800803:	8b 45 0c             	mov    0xc(%ebp),%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80080d:	83 ec 08             	sub    $0x8,%esp
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	ff 75 08             	pushl  0x8(%ebp)
  800816:	e8 1d f8 ff ff       	call   800038 <_main>
  80081b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80081e:	e8 1e 17 00 00       	call   801f41 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800823:	83 ec 0c             	sub    $0xc,%esp
  800826:	68 94 27 80 00       	push   $0x802794
  80082b:	e8 3c 03 00 00       	call   800b6c <cprintf>
  800830:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800833:	a1 24 30 80 00       	mov    0x803024,%eax
  800838:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80083e:	a1 24 30 80 00       	mov    0x803024,%eax
  800843:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800849:	83 ec 04             	sub    $0x4,%esp
  80084c:	52                   	push   %edx
  80084d:	50                   	push   %eax
  80084e:	68 bc 27 80 00       	push   $0x8027bc
  800853:	e8 14 03 00 00       	call   800b6c <cprintf>
  800858:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80085b:	a1 24 30 80 00       	mov    0x803024,%eax
  800860:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800866:	83 ec 08             	sub    $0x8,%esp
  800869:	50                   	push   %eax
  80086a:	68 e1 27 80 00       	push   $0x8027e1
  80086f:	e8 f8 02 00 00       	call   800b6c <cprintf>
  800874:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800877:	83 ec 0c             	sub    $0xc,%esp
  80087a:	68 94 27 80 00       	push   $0x802794
  80087f:	e8 e8 02 00 00       	call   800b6c <cprintf>
  800884:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800887:	e8 cf 16 00 00       	call   801f5b <sys_enable_interrupt>

	// exit gracefully
	exit();
  80088c:	e8 19 00 00 00       	call   8008aa <exit>
}
  800891:	90                   	nop
  800892:	c9                   	leave  
  800893:	c3                   	ret    

00800894 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800894:	55                   	push   %ebp
  800895:	89 e5                	mov    %esp,%ebp
  800897:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80089a:	83 ec 0c             	sub    $0xc,%esp
  80089d:	6a 00                	push   $0x0
  80089f:	e8 ce 14 00 00       	call   801d72 <sys_env_destroy>
  8008a4:	83 c4 10             	add    $0x10,%esp
}
  8008a7:	90                   	nop
  8008a8:	c9                   	leave  
  8008a9:	c3                   	ret    

008008aa <exit>:

void
exit(void)
{
  8008aa:	55                   	push   %ebp
  8008ab:	89 e5                	mov    %esp,%ebp
  8008ad:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008b0:	e8 23 15 00 00       	call   801dd8 <sys_env_exit>
}
  8008b5:	90                   	nop
  8008b6:	c9                   	leave  
  8008b7:	c3                   	ret    

008008b8 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008b8:	55                   	push   %ebp
  8008b9:	89 e5                	mov    %esp,%ebp
  8008bb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008be:	8d 45 10             	lea    0x10(%ebp),%eax
  8008c1:	83 c0 04             	add    $0x4,%eax
  8008c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008c7:	a1 38 30 80 00       	mov    0x803038,%eax
  8008cc:	85 c0                	test   %eax,%eax
  8008ce:	74 16                	je     8008e6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008d0:	a1 38 30 80 00       	mov    0x803038,%eax
  8008d5:	83 ec 08             	sub    $0x8,%esp
  8008d8:	50                   	push   %eax
  8008d9:	68 f8 27 80 00       	push   $0x8027f8
  8008de:	e8 89 02 00 00       	call   800b6c <cprintf>
  8008e3:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008e6:	a1 00 30 80 00       	mov    0x803000,%eax
  8008eb:	ff 75 0c             	pushl  0xc(%ebp)
  8008ee:	ff 75 08             	pushl  0x8(%ebp)
  8008f1:	50                   	push   %eax
  8008f2:	68 fd 27 80 00       	push   $0x8027fd
  8008f7:	e8 70 02 00 00       	call   800b6c <cprintf>
  8008fc:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8008ff:	8b 45 10             	mov    0x10(%ebp),%eax
  800902:	83 ec 08             	sub    $0x8,%esp
  800905:	ff 75 f4             	pushl  -0xc(%ebp)
  800908:	50                   	push   %eax
  800909:	e8 f3 01 00 00       	call   800b01 <vcprintf>
  80090e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800911:	83 ec 08             	sub    $0x8,%esp
  800914:	6a 00                	push   $0x0
  800916:	68 19 28 80 00       	push   $0x802819
  80091b:	e8 e1 01 00 00       	call   800b01 <vcprintf>
  800920:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800923:	e8 82 ff ff ff       	call   8008aa <exit>

	// should not return here
	while (1) ;
  800928:	eb fe                	jmp    800928 <_panic+0x70>

0080092a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80092a:	55                   	push   %ebp
  80092b:	89 e5                	mov    %esp,%ebp
  80092d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800930:	a1 24 30 80 00       	mov    0x803024,%eax
  800935:	8b 50 74             	mov    0x74(%eax),%edx
  800938:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093b:	39 c2                	cmp    %eax,%edx
  80093d:	74 14                	je     800953 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80093f:	83 ec 04             	sub    $0x4,%esp
  800942:	68 1c 28 80 00       	push   $0x80281c
  800947:	6a 26                	push   $0x26
  800949:	68 68 28 80 00       	push   $0x802868
  80094e:	e8 65 ff ff ff       	call   8008b8 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800953:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80095a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800961:	e9 c2 00 00 00       	jmp    800a28 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800966:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800969:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	01 d0                	add    %edx,%eax
  800975:	8b 00                	mov    (%eax),%eax
  800977:	85 c0                	test   %eax,%eax
  800979:	75 08                	jne    800983 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80097b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80097e:	e9 a2 00 00 00       	jmp    800a25 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800983:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80098a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800991:	eb 69                	jmp    8009fc <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800993:	a1 24 30 80 00       	mov    0x803024,%eax
  800998:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80099e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009a1:	89 d0                	mov    %edx,%eax
  8009a3:	01 c0                	add    %eax,%eax
  8009a5:	01 d0                	add    %edx,%eax
  8009a7:	c1 e0 02             	shl    $0x2,%eax
  8009aa:	01 c8                	add    %ecx,%eax
  8009ac:	8a 40 04             	mov    0x4(%eax),%al
  8009af:	84 c0                	test   %al,%al
  8009b1:	75 46                	jne    8009f9 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009b3:	a1 24 30 80 00       	mov    0x803024,%eax
  8009b8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009be:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009c1:	89 d0                	mov    %edx,%eax
  8009c3:	01 c0                	add    %eax,%eax
  8009c5:	01 d0                	add    %edx,%eax
  8009c7:	c1 e0 02             	shl    $0x2,%eax
  8009ca:	01 c8                	add    %ecx,%eax
  8009cc:	8b 00                	mov    (%eax),%eax
  8009ce:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009d1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009d4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009d9:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009de:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e8:	01 c8                	add    %ecx,%eax
  8009ea:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009ec:	39 c2                	cmp    %eax,%edx
  8009ee:	75 09                	jne    8009f9 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8009f0:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8009f7:	eb 12                	jmp    800a0b <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009f9:	ff 45 e8             	incl   -0x18(%ebp)
  8009fc:	a1 24 30 80 00       	mov    0x803024,%eax
  800a01:	8b 50 74             	mov    0x74(%eax),%edx
  800a04:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a07:	39 c2                	cmp    %eax,%edx
  800a09:	77 88                	ja     800993 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a0b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a0f:	75 14                	jne    800a25 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a11:	83 ec 04             	sub    $0x4,%esp
  800a14:	68 74 28 80 00       	push   $0x802874
  800a19:	6a 3a                	push   $0x3a
  800a1b:	68 68 28 80 00       	push   $0x802868
  800a20:	e8 93 fe ff ff       	call   8008b8 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a25:	ff 45 f0             	incl   -0x10(%ebp)
  800a28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a2b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a2e:	0f 8c 32 ff ff ff    	jl     800966 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a34:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a3b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a42:	eb 26                	jmp    800a6a <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a44:	a1 24 30 80 00       	mov    0x803024,%eax
  800a49:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a4f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a52:	89 d0                	mov    %edx,%eax
  800a54:	01 c0                	add    %eax,%eax
  800a56:	01 d0                	add    %edx,%eax
  800a58:	c1 e0 02             	shl    $0x2,%eax
  800a5b:	01 c8                	add    %ecx,%eax
  800a5d:	8a 40 04             	mov    0x4(%eax),%al
  800a60:	3c 01                	cmp    $0x1,%al
  800a62:	75 03                	jne    800a67 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a64:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a67:	ff 45 e0             	incl   -0x20(%ebp)
  800a6a:	a1 24 30 80 00       	mov    0x803024,%eax
  800a6f:	8b 50 74             	mov    0x74(%eax),%edx
  800a72:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a75:	39 c2                	cmp    %eax,%edx
  800a77:	77 cb                	ja     800a44 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a7c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a7f:	74 14                	je     800a95 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800a81:	83 ec 04             	sub    $0x4,%esp
  800a84:	68 c8 28 80 00       	push   $0x8028c8
  800a89:	6a 44                	push   $0x44
  800a8b:	68 68 28 80 00       	push   $0x802868
  800a90:	e8 23 fe ff ff       	call   8008b8 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a95:	90                   	nop
  800a96:	c9                   	leave  
  800a97:	c3                   	ret    

00800a98 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800a98:	55                   	push   %ebp
  800a99:	89 e5                	mov    %esp,%ebp
  800a9b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa1:	8b 00                	mov    (%eax),%eax
  800aa3:	8d 48 01             	lea    0x1(%eax),%ecx
  800aa6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa9:	89 0a                	mov    %ecx,(%edx)
  800aab:	8b 55 08             	mov    0x8(%ebp),%edx
  800aae:	88 d1                	mov    %dl,%cl
  800ab0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ab3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ab7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aba:	8b 00                	mov    (%eax),%eax
  800abc:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ac1:	75 2c                	jne    800aef <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ac3:	a0 28 30 80 00       	mov    0x803028,%al
  800ac8:	0f b6 c0             	movzbl %al,%eax
  800acb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ace:	8b 12                	mov    (%edx),%edx
  800ad0:	89 d1                	mov    %edx,%ecx
  800ad2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad5:	83 c2 08             	add    $0x8,%edx
  800ad8:	83 ec 04             	sub    $0x4,%esp
  800adb:	50                   	push   %eax
  800adc:	51                   	push   %ecx
  800add:	52                   	push   %edx
  800ade:	e8 4d 12 00 00       	call   801d30 <sys_cputs>
  800ae3:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ae6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800aef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af2:	8b 40 04             	mov    0x4(%eax),%eax
  800af5:	8d 50 01             	lea    0x1(%eax),%edx
  800af8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afb:	89 50 04             	mov    %edx,0x4(%eax)
}
  800afe:	90                   	nop
  800aff:	c9                   	leave  
  800b00:	c3                   	ret    

00800b01 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b01:	55                   	push   %ebp
  800b02:	89 e5                	mov    %esp,%ebp
  800b04:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b0a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b11:	00 00 00 
	b.cnt = 0;
  800b14:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b1b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b1e:	ff 75 0c             	pushl  0xc(%ebp)
  800b21:	ff 75 08             	pushl  0x8(%ebp)
  800b24:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b2a:	50                   	push   %eax
  800b2b:	68 98 0a 80 00       	push   $0x800a98
  800b30:	e8 11 02 00 00       	call   800d46 <vprintfmt>
  800b35:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b38:	a0 28 30 80 00       	mov    0x803028,%al
  800b3d:	0f b6 c0             	movzbl %al,%eax
  800b40:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b46:	83 ec 04             	sub    $0x4,%esp
  800b49:	50                   	push   %eax
  800b4a:	52                   	push   %edx
  800b4b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b51:	83 c0 08             	add    $0x8,%eax
  800b54:	50                   	push   %eax
  800b55:	e8 d6 11 00 00       	call   801d30 <sys_cputs>
  800b5a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b5d:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b64:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b6a:	c9                   	leave  
  800b6b:	c3                   	ret    

00800b6c <cprintf>:

int cprintf(const char *fmt, ...) {
  800b6c:	55                   	push   %ebp
  800b6d:	89 e5                	mov    %esp,%ebp
  800b6f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b72:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b79:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	83 ec 08             	sub    $0x8,%esp
  800b85:	ff 75 f4             	pushl  -0xc(%ebp)
  800b88:	50                   	push   %eax
  800b89:	e8 73 ff ff ff       	call   800b01 <vcprintf>
  800b8e:	83 c4 10             	add    $0x10,%esp
  800b91:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b94:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b97:	c9                   	leave  
  800b98:	c3                   	ret    

00800b99 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800b99:	55                   	push   %ebp
  800b9a:	89 e5                	mov    %esp,%ebp
  800b9c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b9f:	e8 9d 13 00 00       	call   801f41 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800ba4:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ba7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bad:	83 ec 08             	sub    $0x8,%esp
  800bb0:	ff 75 f4             	pushl  -0xc(%ebp)
  800bb3:	50                   	push   %eax
  800bb4:	e8 48 ff ff ff       	call   800b01 <vcprintf>
  800bb9:	83 c4 10             	add    $0x10,%esp
  800bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bbf:	e8 97 13 00 00       	call   801f5b <sys_enable_interrupt>
	return cnt;
  800bc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bc7:	c9                   	leave  
  800bc8:	c3                   	ret    

00800bc9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bc9:	55                   	push   %ebp
  800bca:	89 e5                	mov    %esp,%ebp
  800bcc:	53                   	push   %ebx
  800bcd:	83 ec 14             	sub    $0x14,%esp
  800bd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd6:	8b 45 14             	mov    0x14(%ebp),%eax
  800bd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bdc:	8b 45 18             	mov    0x18(%ebp),%eax
  800bdf:	ba 00 00 00 00       	mov    $0x0,%edx
  800be4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800be7:	77 55                	ja     800c3e <printnum+0x75>
  800be9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bec:	72 05                	jb     800bf3 <printnum+0x2a>
  800bee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bf1:	77 4b                	ja     800c3e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800bf3:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800bf6:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800bf9:	8b 45 18             	mov    0x18(%ebp),%eax
  800bfc:	ba 00 00 00 00       	mov    $0x0,%edx
  800c01:	52                   	push   %edx
  800c02:	50                   	push   %eax
  800c03:	ff 75 f4             	pushl  -0xc(%ebp)
  800c06:	ff 75 f0             	pushl  -0x10(%ebp)
  800c09:	e8 12 17 00 00       	call   802320 <__udivdi3>
  800c0e:	83 c4 10             	add    $0x10,%esp
  800c11:	83 ec 04             	sub    $0x4,%esp
  800c14:	ff 75 20             	pushl  0x20(%ebp)
  800c17:	53                   	push   %ebx
  800c18:	ff 75 18             	pushl  0x18(%ebp)
  800c1b:	52                   	push   %edx
  800c1c:	50                   	push   %eax
  800c1d:	ff 75 0c             	pushl  0xc(%ebp)
  800c20:	ff 75 08             	pushl  0x8(%ebp)
  800c23:	e8 a1 ff ff ff       	call   800bc9 <printnum>
  800c28:	83 c4 20             	add    $0x20,%esp
  800c2b:	eb 1a                	jmp    800c47 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c2d:	83 ec 08             	sub    $0x8,%esp
  800c30:	ff 75 0c             	pushl  0xc(%ebp)
  800c33:	ff 75 20             	pushl  0x20(%ebp)
  800c36:	8b 45 08             	mov    0x8(%ebp),%eax
  800c39:	ff d0                	call   *%eax
  800c3b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c3e:	ff 4d 1c             	decl   0x1c(%ebp)
  800c41:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c45:	7f e6                	jg     800c2d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c47:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c4a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c52:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c55:	53                   	push   %ebx
  800c56:	51                   	push   %ecx
  800c57:	52                   	push   %edx
  800c58:	50                   	push   %eax
  800c59:	e8 d2 17 00 00       	call   802430 <__umoddi3>
  800c5e:	83 c4 10             	add    $0x10,%esp
  800c61:	05 34 2b 80 00       	add    $0x802b34,%eax
  800c66:	8a 00                	mov    (%eax),%al
  800c68:	0f be c0             	movsbl %al,%eax
  800c6b:	83 ec 08             	sub    $0x8,%esp
  800c6e:	ff 75 0c             	pushl  0xc(%ebp)
  800c71:	50                   	push   %eax
  800c72:	8b 45 08             	mov    0x8(%ebp),%eax
  800c75:	ff d0                	call   *%eax
  800c77:	83 c4 10             	add    $0x10,%esp
}
  800c7a:	90                   	nop
  800c7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c7e:	c9                   	leave  
  800c7f:	c3                   	ret    

00800c80 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c80:	55                   	push   %ebp
  800c81:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c83:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c87:	7e 1c                	jle    800ca5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	8b 00                	mov    (%eax),%eax
  800c8e:	8d 50 08             	lea    0x8(%eax),%edx
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	89 10                	mov    %edx,(%eax)
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	8b 00                	mov    (%eax),%eax
  800c9b:	83 e8 08             	sub    $0x8,%eax
  800c9e:	8b 50 04             	mov    0x4(%eax),%edx
  800ca1:	8b 00                	mov    (%eax),%eax
  800ca3:	eb 40                	jmp    800ce5 <getuint+0x65>
	else if (lflag)
  800ca5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ca9:	74 1e                	je     800cc9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	8b 00                	mov    (%eax),%eax
  800cb0:	8d 50 04             	lea    0x4(%eax),%edx
  800cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb6:	89 10                	mov    %edx,(%eax)
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	8b 00                	mov    (%eax),%eax
  800cbd:	83 e8 04             	sub    $0x4,%eax
  800cc0:	8b 00                	mov    (%eax),%eax
  800cc2:	ba 00 00 00 00       	mov    $0x0,%edx
  800cc7:	eb 1c                	jmp    800ce5 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	8b 00                	mov    (%eax),%eax
  800cce:	8d 50 04             	lea    0x4(%eax),%edx
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	89 10                	mov    %edx,(%eax)
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	8b 00                	mov    (%eax),%eax
  800cdb:	83 e8 04             	sub    $0x4,%eax
  800cde:	8b 00                	mov    (%eax),%eax
  800ce0:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800ce5:	5d                   	pop    %ebp
  800ce6:	c3                   	ret    

00800ce7 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ce7:	55                   	push   %ebp
  800ce8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cea:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cee:	7e 1c                	jle    800d0c <getint+0x25>
		return va_arg(*ap, long long);
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	8b 00                	mov    (%eax),%eax
  800cf5:	8d 50 08             	lea    0x8(%eax),%edx
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	89 10                	mov    %edx,(%eax)
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	8b 00                	mov    (%eax),%eax
  800d02:	83 e8 08             	sub    $0x8,%eax
  800d05:	8b 50 04             	mov    0x4(%eax),%edx
  800d08:	8b 00                	mov    (%eax),%eax
  800d0a:	eb 38                	jmp    800d44 <getint+0x5d>
	else if (lflag)
  800d0c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d10:	74 1a                	je     800d2c <getint+0x45>
		return va_arg(*ap, long);
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
  800d15:	8b 00                	mov    (%eax),%eax
  800d17:	8d 50 04             	lea    0x4(%eax),%edx
  800d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1d:	89 10                	mov    %edx,(%eax)
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8b 00                	mov    (%eax),%eax
  800d24:	83 e8 04             	sub    $0x4,%eax
  800d27:	8b 00                	mov    (%eax),%eax
  800d29:	99                   	cltd   
  800d2a:	eb 18                	jmp    800d44 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8b 00                	mov    (%eax),%eax
  800d31:	8d 50 04             	lea    0x4(%eax),%edx
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
  800d37:	89 10                	mov    %edx,(%eax)
  800d39:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3c:	8b 00                	mov    (%eax),%eax
  800d3e:	83 e8 04             	sub    $0x4,%eax
  800d41:	8b 00                	mov    (%eax),%eax
  800d43:	99                   	cltd   
}
  800d44:	5d                   	pop    %ebp
  800d45:	c3                   	ret    

00800d46 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d46:	55                   	push   %ebp
  800d47:	89 e5                	mov    %esp,%ebp
  800d49:	56                   	push   %esi
  800d4a:	53                   	push   %ebx
  800d4b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d4e:	eb 17                	jmp    800d67 <vprintfmt+0x21>
			if (ch == '\0')
  800d50:	85 db                	test   %ebx,%ebx
  800d52:	0f 84 af 03 00 00    	je     801107 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d58:	83 ec 08             	sub    $0x8,%esp
  800d5b:	ff 75 0c             	pushl  0xc(%ebp)
  800d5e:	53                   	push   %ebx
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	ff d0                	call   *%eax
  800d64:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d67:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6a:	8d 50 01             	lea    0x1(%eax),%edx
  800d6d:	89 55 10             	mov    %edx,0x10(%ebp)
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	0f b6 d8             	movzbl %al,%ebx
  800d75:	83 fb 25             	cmp    $0x25,%ebx
  800d78:	75 d6                	jne    800d50 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d7a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d7e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d85:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d8c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d93:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9d:	8d 50 01             	lea    0x1(%eax),%edx
  800da0:	89 55 10             	mov    %edx,0x10(%ebp)
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	0f b6 d8             	movzbl %al,%ebx
  800da8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dab:	83 f8 55             	cmp    $0x55,%eax
  800dae:	0f 87 2b 03 00 00    	ja     8010df <vprintfmt+0x399>
  800db4:	8b 04 85 58 2b 80 00 	mov    0x802b58(,%eax,4),%eax
  800dbb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dbd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dc1:	eb d7                	jmp    800d9a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dc3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dc7:	eb d1                	jmp    800d9a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dc9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800dd0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dd3:	89 d0                	mov    %edx,%eax
  800dd5:	c1 e0 02             	shl    $0x2,%eax
  800dd8:	01 d0                	add    %edx,%eax
  800dda:	01 c0                	add    %eax,%eax
  800ddc:	01 d8                	add    %ebx,%eax
  800dde:	83 e8 30             	sub    $0x30,%eax
  800de1:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800de4:	8b 45 10             	mov    0x10(%ebp),%eax
  800de7:	8a 00                	mov    (%eax),%al
  800de9:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800dec:	83 fb 2f             	cmp    $0x2f,%ebx
  800def:	7e 3e                	jle    800e2f <vprintfmt+0xe9>
  800df1:	83 fb 39             	cmp    $0x39,%ebx
  800df4:	7f 39                	jg     800e2f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800df6:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800df9:	eb d5                	jmp    800dd0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800dfb:	8b 45 14             	mov    0x14(%ebp),%eax
  800dfe:	83 c0 04             	add    $0x4,%eax
  800e01:	89 45 14             	mov    %eax,0x14(%ebp)
  800e04:	8b 45 14             	mov    0x14(%ebp),%eax
  800e07:	83 e8 04             	sub    $0x4,%eax
  800e0a:	8b 00                	mov    (%eax),%eax
  800e0c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e0f:	eb 1f                	jmp    800e30 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e11:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e15:	79 83                	jns    800d9a <vprintfmt+0x54>
				width = 0;
  800e17:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e1e:	e9 77 ff ff ff       	jmp    800d9a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e23:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e2a:	e9 6b ff ff ff       	jmp    800d9a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e2f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e34:	0f 89 60 ff ff ff    	jns    800d9a <vprintfmt+0x54>
				width = precision, precision = -1;
  800e3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e3d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e40:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e47:	e9 4e ff ff ff       	jmp    800d9a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e4c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e4f:	e9 46 ff ff ff       	jmp    800d9a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e54:	8b 45 14             	mov    0x14(%ebp),%eax
  800e57:	83 c0 04             	add    $0x4,%eax
  800e5a:	89 45 14             	mov    %eax,0x14(%ebp)
  800e5d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e60:	83 e8 04             	sub    $0x4,%eax
  800e63:	8b 00                	mov    (%eax),%eax
  800e65:	83 ec 08             	sub    $0x8,%esp
  800e68:	ff 75 0c             	pushl  0xc(%ebp)
  800e6b:	50                   	push   %eax
  800e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6f:	ff d0                	call   *%eax
  800e71:	83 c4 10             	add    $0x10,%esp
			break;
  800e74:	e9 89 02 00 00       	jmp    801102 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e79:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7c:	83 c0 04             	add    $0x4,%eax
  800e7f:	89 45 14             	mov    %eax,0x14(%ebp)
  800e82:	8b 45 14             	mov    0x14(%ebp),%eax
  800e85:	83 e8 04             	sub    $0x4,%eax
  800e88:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e8a:	85 db                	test   %ebx,%ebx
  800e8c:	79 02                	jns    800e90 <vprintfmt+0x14a>
				err = -err;
  800e8e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e90:	83 fb 64             	cmp    $0x64,%ebx
  800e93:	7f 0b                	jg     800ea0 <vprintfmt+0x15a>
  800e95:	8b 34 9d a0 29 80 00 	mov    0x8029a0(,%ebx,4),%esi
  800e9c:	85 f6                	test   %esi,%esi
  800e9e:	75 19                	jne    800eb9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ea0:	53                   	push   %ebx
  800ea1:	68 45 2b 80 00       	push   $0x802b45
  800ea6:	ff 75 0c             	pushl  0xc(%ebp)
  800ea9:	ff 75 08             	pushl  0x8(%ebp)
  800eac:	e8 5e 02 00 00       	call   80110f <printfmt>
  800eb1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800eb4:	e9 49 02 00 00       	jmp    801102 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800eb9:	56                   	push   %esi
  800eba:	68 4e 2b 80 00       	push   $0x802b4e
  800ebf:	ff 75 0c             	pushl  0xc(%ebp)
  800ec2:	ff 75 08             	pushl  0x8(%ebp)
  800ec5:	e8 45 02 00 00       	call   80110f <printfmt>
  800eca:	83 c4 10             	add    $0x10,%esp
			break;
  800ecd:	e9 30 02 00 00       	jmp    801102 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ed2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed5:	83 c0 04             	add    $0x4,%eax
  800ed8:	89 45 14             	mov    %eax,0x14(%ebp)
  800edb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ede:	83 e8 04             	sub    $0x4,%eax
  800ee1:	8b 30                	mov    (%eax),%esi
  800ee3:	85 f6                	test   %esi,%esi
  800ee5:	75 05                	jne    800eec <vprintfmt+0x1a6>
				p = "(null)";
  800ee7:	be 51 2b 80 00       	mov    $0x802b51,%esi
			if (width > 0 && padc != '-')
  800eec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ef0:	7e 6d                	jle    800f5f <vprintfmt+0x219>
  800ef2:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ef6:	74 67                	je     800f5f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800ef8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800efb:	83 ec 08             	sub    $0x8,%esp
  800efe:	50                   	push   %eax
  800eff:	56                   	push   %esi
  800f00:	e8 12 05 00 00       	call   801417 <strnlen>
  800f05:	83 c4 10             	add    $0x10,%esp
  800f08:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f0b:	eb 16                	jmp    800f23 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f0d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f11:	83 ec 08             	sub    $0x8,%esp
  800f14:	ff 75 0c             	pushl  0xc(%ebp)
  800f17:	50                   	push   %eax
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	ff d0                	call   *%eax
  800f1d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f20:	ff 4d e4             	decl   -0x1c(%ebp)
  800f23:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f27:	7f e4                	jg     800f0d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f29:	eb 34                	jmp    800f5f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f2b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f2f:	74 1c                	je     800f4d <vprintfmt+0x207>
  800f31:	83 fb 1f             	cmp    $0x1f,%ebx
  800f34:	7e 05                	jle    800f3b <vprintfmt+0x1f5>
  800f36:	83 fb 7e             	cmp    $0x7e,%ebx
  800f39:	7e 12                	jle    800f4d <vprintfmt+0x207>
					putch('?', putdat);
  800f3b:	83 ec 08             	sub    $0x8,%esp
  800f3e:	ff 75 0c             	pushl  0xc(%ebp)
  800f41:	6a 3f                	push   $0x3f
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	ff d0                	call   *%eax
  800f48:	83 c4 10             	add    $0x10,%esp
  800f4b:	eb 0f                	jmp    800f5c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f4d:	83 ec 08             	sub    $0x8,%esp
  800f50:	ff 75 0c             	pushl  0xc(%ebp)
  800f53:	53                   	push   %ebx
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	ff d0                	call   *%eax
  800f59:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f5c:	ff 4d e4             	decl   -0x1c(%ebp)
  800f5f:	89 f0                	mov    %esi,%eax
  800f61:	8d 70 01             	lea    0x1(%eax),%esi
  800f64:	8a 00                	mov    (%eax),%al
  800f66:	0f be d8             	movsbl %al,%ebx
  800f69:	85 db                	test   %ebx,%ebx
  800f6b:	74 24                	je     800f91 <vprintfmt+0x24b>
  800f6d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f71:	78 b8                	js     800f2b <vprintfmt+0x1e5>
  800f73:	ff 4d e0             	decl   -0x20(%ebp)
  800f76:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f7a:	79 af                	jns    800f2b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f7c:	eb 13                	jmp    800f91 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f7e:	83 ec 08             	sub    $0x8,%esp
  800f81:	ff 75 0c             	pushl  0xc(%ebp)
  800f84:	6a 20                	push   $0x20
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	ff d0                	call   *%eax
  800f8b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f8e:	ff 4d e4             	decl   -0x1c(%ebp)
  800f91:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f95:	7f e7                	jg     800f7e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f97:	e9 66 01 00 00       	jmp    801102 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f9c:	83 ec 08             	sub    $0x8,%esp
  800f9f:	ff 75 e8             	pushl  -0x18(%ebp)
  800fa2:	8d 45 14             	lea    0x14(%ebp),%eax
  800fa5:	50                   	push   %eax
  800fa6:	e8 3c fd ff ff       	call   800ce7 <getint>
  800fab:	83 c4 10             	add    $0x10,%esp
  800fae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fb7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fba:	85 d2                	test   %edx,%edx
  800fbc:	79 23                	jns    800fe1 <vprintfmt+0x29b>
				putch('-', putdat);
  800fbe:	83 ec 08             	sub    $0x8,%esp
  800fc1:	ff 75 0c             	pushl  0xc(%ebp)
  800fc4:	6a 2d                	push   $0x2d
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	ff d0                	call   *%eax
  800fcb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fd1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd4:	f7 d8                	neg    %eax
  800fd6:	83 d2 00             	adc    $0x0,%edx
  800fd9:	f7 da                	neg    %edx
  800fdb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fde:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fe1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fe8:	e9 bc 00 00 00       	jmp    8010a9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800fed:	83 ec 08             	sub    $0x8,%esp
  800ff0:	ff 75 e8             	pushl  -0x18(%ebp)
  800ff3:	8d 45 14             	lea    0x14(%ebp),%eax
  800ff6:	50                   	push   %eax
  800ff7:	e8 84 fc ff ff       	call   800c80 <getuint>
  800ffc:	83 c4 10             	add    $0x10,%esp
  800fff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801002:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801005:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80100c:	e9 98 00 00 00       	jmp    8010a9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801011:	83 ec 08             	sub    $0x8,%esp
  801014:	ff 75 0c             	pushl  0xc(%ebp)
  801017:	6a 58                	push   $0x58
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
  80101c:	ff d0                	call   *%eax
  80101e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801021:	83 ec 08             	sub    $0x8,%esp
  801024:	ff 75 0c             	pushl  0xc(%ebp)
  801027:	6a 58                	push   $0x58
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	ff d0                	call   *%eax
  80102e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801031:	83 ec 08             	sub    $0x8,%esp
  801034:	ff 75 0c             	pushl  0xc(%ebp)
  801037:	6a 58                	push   $0x58
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	ff d0                	call   *%eax
  80103e:	83 c4 10             	add    $0x10,%esp
			break;
  801041:	e9 bc 00 00 00       	jmp    801102 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801046:	83 ec 08             	sub    $0x8,%esp
  801049:	ff 75 0c             	pushl  0xc(%ebp)
  80104c:	6a 30                	push   $0x30
  80104e:	8b 45 08             	mov    0x8(%ebp),%eax
  801051:	ff d0                	call   *%eax
  801053:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801056:	83 ec 08             	sub    $0x8,%esp
  801059:	ff 75 0c             	pushl  0xc(%ebp)
  80105c:	6a 78                	push   $0x78
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	ff d0                	call   *%eax
  801063:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801066:	8b 45 14             	mov    0x14(%ebp),%eax
  801069:	83 c0 04             	add    $0x4,%eax
  80106c:	89 45 14             	mov    %eax,0x14(%ebp)
  80106f:	8b 45 14             	mov    0x14(%ebp),%eax
  801072:	83 e8 04             	sub    $0x4,%eax
  801075:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801077:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80107a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801081:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801088:	eb 1f                	jmp    8010a9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80108a:	83 ec 08             	sub    $0x8,%esp
  80108d:	ff 75 e8             	pushl  -0x18(%ebp)
  801090:	8d 45 14             	lea    0x14(%ebp),%eax
  801093:	50                   	push   %eax
  801094:	e8 e7 fb ff ff       	call   800c80 <getuint>
  801099:	83 c4 10             	add    $0x10,%esp
  80109c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80109f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010a2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010a9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010b0:	83 ec 04             	sub    $0x4,%esp
  8010b3:	52                   	push   %edx
  8010b4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010b7:	50                   	push   %eax
  8010b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8010bb:	ff 75 f0             	pushl  -0x10(%ebp)
  8010be:	ff 75 0c             	pushl  0xc(%ebp)
  8010c1:	ff 75 08             	pushl  0x8(%ebp)
  8010c4:	e8 00 fb ff ff       	call   800bc9 <printnum>
  8010c9:	83 c4 20             	add    $0x20,%esp
			break;
  8010cc:	eb 34                	jmp    801102 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010ce:	83 ec 08             	sub    $0x8,%esp
  8010d1:	ff 75 0c             	pushl  0xc(%ebp)
  8010d4:	53                   	push   %ebx
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	ff d0                	call   *%eax
  8010da:	83 c4 10             	add    $0x10,%esp
			break;
  8010dd:	eb 23                	jmp    801102 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010df:	83 ec 08             	sub    $0x8,%esp
  8010e2:	ff 75 0c             	pushl  0xc(%ebp)
  8010e5:	6a 25                	push   $0x25
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	ff d0                	call   *%eax
  8010ec:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010ef:	ff 4d 10             	decl   0x10(%ebp)
  8010f2:	eb 03                	jmp    8010f7 <vprintfmt+0x3b1>
  8010f4:	ff 4d 10             	decl   0x10(%ebp)
  8010f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fa:	48                   	dec    %eax
  8010fb:	8a 00                	mov    (%eax),%al
  8010fd:	3c 25                	cmp    $0x25,%al
  8010ff:	75 f3                	jne    8010f4 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801101:	90                   	nop
		}
	}
  801102:	e9 47 fc ff ff       	jmp    800d4e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801107:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801108:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80110b:	5b                   	pop    %ebx
  80110c:	5e                   	pop    %esi
  80110d:	5d                   	pop    %ebp
  80110e:	c3                   	ret    

0080110f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80110f:	55                   	push   %ebp
  801110:	89 e5                	mov    %esp,%ebp
  801112:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801115:	8d 45 10             	lea    0x10(%ebp),%eax
  801118:	83 c0 04             	add    $0x4,%eax
  80111b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80111e:	8b 45 10             	mov    0x10(%ebp),%eax
  801121:	ff 75 f4             	pushl  -0xc(%ebp)
  801124:	50                   	push   %eax
  801125:	ff 75 0c             	pushl  0xc(%ebp)
  801128:	ff 75 08             	pushl  0x8(%ebp)
  80112b:	e8 16 fc ff ff       	call   800d46 <vprintfmt>
  801130:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801133:	90                   	nop
  801134:	c9                   	leave  
  801135:	c3                   	ret    

00801136 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801139:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113c:	8b 40 08             	mov    0x8(%eax),%eax
  80113f:	8d 50 01             	lea    0x1(%eax),%edx
  801142:	8b 45 0c             	mov    0xc(%ebp),%eax
  801145:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801148:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114b:	8b 10                	mov    (%eax),%edx
  80114d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801150:	8b 40 04             	mov    0x4(%eax),%eax
  801153:	39 c2                	cmp    %eax,%edx
  801155:	73 12                	jae    801169 <sprintputch+0x33>
		*b->buf++ = ch;
  801157:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115a:	8b 00                	mov    (%eax),%eax
  80115c:	8d 48 01             	lea    0x1(%eax),%ecx
  80115f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801162:	89 0a                	mov    %ecx,(%edx)
  801164:	8b 55 08             	mov    0x8(%ebp),%edx
  801167:	88 10                	mov    %dl,(%eax)
}
  801169:	90                   	nop
  80116a:	5d                   	pop    %ebp
  80116b:	c3                   	ret    

0080116c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80116c:	55                   	push   %ebp
  80116d:	89 e5                	mov    %esp,%ebp
  80116f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801178:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117e:	8b 45 08             	mov    0x8(%ebp),%eax
  801181:	01 d0                	add    %edx,%eax
  801183:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801186:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80118d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801191:	74 06                	je     801199 <vsnprintf+0x2d>
  801193:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801197:	7f 07                	jg     8011a0 <vsnprintf+0x34>
		return -E_INVAL;
  801199:	b8 03 00 00 00       	mov    $0x3,%eax
  80119e:	eb 20                	jmp    8011c0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011a0:	ff 75 14             	pushl  0x14(%ebp)
  8011a3:	ff 75 10             	pushl  0x10(%ebp)
  8011a6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011a9:	50                   	push   %eax
  8011aa:	68 36 11 80 00       	push   $0x801136
  8011af:	e8 92 fb ff ff       	call   800d46 <vprintfmt>
  8011b4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ba:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011c0:	c9                   	leave  
  8011c1:	c3                   	ret    

008011c2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011c2:	55                   	push   %ebp
  8011c3:	89 e5                	mov    %esp,%ebp
  8011c5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011c8:	8d 45 10             	lea    0x10(%ebp),%eax
  8011cb:	83 c0 04             	add    $0x4,%eax
  8011ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8011d7:	50                   	push   %eax
  8011d8:	ff 75 0c             	pushl  0xc(%ebp)
  8011db:	ff 75 08             	pushl  0x8(%ebp)
  8011de:	e8 89 ff ff ff       	call   80116c <vsnprintf>
  8011e3:	83 c4 10             	add    $0x10,%esp
  8011e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011ec:	c9                   	leave  
  8011ed:	c3                   	ret    

008011ee <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8011ee:	55                   	push   %ebp
  8011ef:	89 e5                	mov    %esp,%ebp
  8011f1:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8011f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011f8:	74 13                	je     80120d <readline+0x1f>
		cprintf("%s", prompt);
  8011fa:	83 ec 08             	sub    $0x8,%esp
  8011fd:	ff 75 08             	pushl  0x8(%ebp)
  801200:	68 b0 2c 80 00       	push   $0x802cb0
  801205:	e8 62 f9 ff ff       	call   800b6c <cprintf>
  80120a:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80120d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801214:	83 ec 0c             	sub    $0xc,%esp
  801217:	6a 00                	push   $0x0
  801219:	e8 81 f5 ff ff       	call   80079f <iscons>
  80121e:	83 c4 10             	add    $0x10,%esp
  801221:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801224:	e8 28 f5 ff ff       	call   800751 <getchar>
  801229:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80122c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801230:	79 22                	jns    801254 <readline+0x66>
			if (c != -E_EOF)
  801232:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801236:	0f 84 ad 00 00 00    	je     8012e9 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80123c:	83 ec 08             	sub    $0x8,%esp
  80123f:	ff 75 ec             	pushl  -0x14(%ebp)
  801242:	68 b3 2c 80 00       	push   $0x802cb3
  801247:	e8 20 f9 ff ff       	call   800b6c <cprintf>
  80124c:	83 c4 10             	add    $0x10,%esp
			return;
  80124f:	e9 95 00 00 00       	jmp    8012e9 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801254:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801258:	7e 34                	jle    80128e <readline+0xa0>
  80125a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801261:	7f 2b                	jg     80128e <readline+0xa0>
			if (echoing)
  801263:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801267:	74 0e                	je     801277 <readline+0x89>
				cputchar(c);
  801269:	83 ec 0c             	sub    $0xc,%esp
  80126c:	ff 75 ec             	pushl  -0x14(%ebp)
  80126f:	e8 95 f4 ff ff       	call   800709 <cputchar>
  801274:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801277:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80127a:	8d 50 01             	lea    0x1(%eax),%edx
  80127d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801280:	89 c2                	mov    %eax,%edx
  801282:	8b 45 0c             	mov    0xc(%ebp),%eax
  801285:	01 d0                	add    %edx,%eax
  801287:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80128a:	88 10                	mov    %dl,(%eax)
  80128c:	eb 56                	jmp    8012e4 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80128e:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801292:	75 1f                	jne    8012b3 <readline+0xc5>
  801294:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801298:	7e 19                	jle    8012b3 <readline+0xc5>
			if (echoing)
  80129a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80129e:	74 0e                	je     8012ae <readline+0xc0>
				cputchar(c);
  8012a0:	83 ec 0c             	sub    $0xc,%esp
  8012a3:	ff 75 ec             	pushl  -0x14(%ebp)
  8012a6:	e8 5e f4 ff ff       	call   800709 <cputchar>
  8012ab:	83 c4 10             	add    $0x10,%esp

			i--;
  8012ae:	ff 4d f4             	decl   -0xc(%ebp)
  8012b1:	eb 31                	jmp    8012e4 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012b3:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012b7:	74 0a                	je     8012c3 <readline+0xd5>
  8012b9:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012bd:	0f 85 61 ff ff ff    	jne    801224 <readline+0x36>
			if (echoing)
  8012c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012c7:	74 0e                	je     8012d7 <readline+0xe9>
				cputchar(c);
  8012c9:	83 ec 0c             	sub    $0xc,%esp
  8012cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8012cf:	e8 35 f4 ff ff       	call   800709 <cputchar>
  8012d4:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012dd:	01 d0                	add    %edx,%eax
  8012df:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8012e2:	eb 06                	jmp    8012ea <readline+0xfc>
		}
	}
  8012e4:	e9 3b ff ff ff       	jmp    801224 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8012e9:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
  8012ef:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8012f2:	e8 4a 0c 00 00       	call   801f41 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8012f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012fb:	74 13                	je     801310 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8012fd:	83 ec 08             	sub    $0x8,%esp
  801300:	ff 75 08             	pushl  0x8(%ebp)
  801303:	68 b0 2c 80 00       	push   $0x802cb0
  801308:	e8 5f f8 ff ff       	call   800b6c <cprintf>
  80130d:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801310:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801317:	83 ec 0c             	sub    $0xc,%esp
  80131a:	6a 00                	push   $0x0
  80131c:	e8 7e f4 ff ff       	call   80079f <iscons>
  801321:	83 c4 10             	add    $0x10,%esp
  801324:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801327:	e8 25 f4 ff ff       	call   800751 <getchar>
  80132c:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80132f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801333:	79 23                	jns    801358 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801335:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801339:	74 13                	je     80134e <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80133b:	83 ec 08             	sub    $0x8,%esp
  80133e:	ff 75 ec             	pushl  -0x14(%ebp)
  801341:	68 b3 2c 80 00       	push   $0x802cb3
  801346:	e8 21 f8 ff ff       	call   800b6c <cprintf>
  80134b:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80134e:	e8 08 0c 00 00       	call   801f5b <sys_enable_interrupt>
			return;
  801353:	e9 9a 00 00 00       	jmp    8013f2 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801358:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80135c:	7e 34                	jle    801392 <atomic_readline+0xa6>
  80135e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801365:	7f 2b                	jg     801392 <atomic_readline+0xa6>
			if (echoing)
  801367:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80136b:	74 0e                	je     80137b <atomic_readline+0x8f>
				cputchar(c);
  80136d:	83 ec 0c             	sub    $0xc,%esp
  801370:	ff 75 ec             	pushl  -0x14(%ebp)
  801373:	e8 91 f3 ff ff       	call   800709 <cputchar>
  801378:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80137b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80137e:	8d 50 01             	lea    0x1(%eax),%edx
  801381:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801384:	89 c2                	mov    %eax,%edx
  801386:	8b 45 0c             	mov    0xc(%ebp),%eax
  801389:	01 d0                	add    %edx,%eax
  80138b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80138e:	88 10                	mov    %dl,(%eax)
  801390:	eb 5b                	jmp    8013ed <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801392:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801396:	75 1f                	jne    8013b7 <atomic_readline+0xcb>
  801398:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80139c:	7e 19                	jle    8013b7 <atomic_readline+0xcb>
			if (echoing)
  80139e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013a2:	74 0e                	je     8013b2 <atomic_readline+0xc6>
				cputchar(c);
  8013a4:	83 ec 0c             	sub    $0xc,%esp
  8013a7:	ff 75 ec             	pushl  -0x14(%ebp)
  8013aa:	e8 5a f3 ff ff       	call   800709 <cputchar>
  8013af:	83 c4 10             	add    $0x10,%esp
			i--;
  8013b2:	ff 4d f4             	decl   -0xc(%ebp)
  8013b5:	eb 36                	jmp    8013ed <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013b7:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013bb:	74 0a                	je     8013c7 <atomic_readline+0xdb>
  8013bd:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013c1:	0f 85 60 ff ff ff    	jne    801327 <atomic_readline+0x3b>
			if (echoing)
  8013c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013cb:	74 0e                	je     8013db <atomic_readline+0xef>
				cputchar(c);
  8013cd:	83 ec 0c             	sub    $0xc,%esp
  8013d0:	ff 75 ec             	pushl  -0x14(%ebp)
  8013d3:	e8 31 f3 ff ff       	call   800709 <cputchar>
  8013d8:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013db:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e1:	01 d0                	add    %edx,%eax
  8013e3:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8013e6:	e8 70 0b 00 00       	call   801f5b <sys_enable_interrupt>
			return;
  8013eb:	eb 05                	jmp    8013f2 <atomic_readline+0x106>
		}
	}
  8013ed:	e9 35 ff ff ff       	jmp    801327 <atomic_readline+0x3b>
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
  8013f7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8013fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801401:	eb 06                	jmp    801409 <strlen+0x15>
		n++;
  801403:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801406:	ff 45 08             	incl   0x8(%ebp)
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
  80140c:	8a 00                	mov    (%eax),%al
  80140e:	84 c0                	test   %al,%al
  801410:	75 f1                	jne    801403 <strlen+0xf>
		n++;
	return n;
  801412:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801415:	c9                   	leave  
  801416:	c3                   	ret    

00801417 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801417:	55                   	push   %ebp
  801418:	89 e5                	mov    %esp,%ebp
  80141a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80141d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801424:	eb 09                	jmp    80142f <strnlen+0x18>
		n++;
  801426:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801429:	ff 45 08             	incl   0x8(%ebp)
  80142c:	ff 4d 0c             	decl   0xc(%ebp)
  80142f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801433:	74 09                	je     80143e <strnlen+0x27>
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	8a 00                	mov    (%eax),%al
  80143a:	84 c0                	test   %al,%al
  80143c:	75 e8                	jne    801426 <strnlen+0xf>
		n++;
	return n;
  80143e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801441:	c9                   	leave  
  801442:	c3                   	ret    

00801443 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
  801446:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801449:	8b 45 08             	mov    0x8(%ebp),%eax
  80144c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80144f:	90                   	nop
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8d 50 01             	lea    0x1(%eax),%edx
  801456:	89 55 08             	mov    %edx,0x8(%ebp)
  801459:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80145f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801462:	8a 12                	mov    (%edx),%dl
  801464:	88 10                	mov    %dl,(%eax)
  801466:	8a 00                	mov    (%eax),%al
  801468:	84 c0                	test   %al,%al
  80146a:	75 e4                	jne    801450 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80146c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80146f:	c9                   	leave  
  801470:	c3                   	ret    

00801471 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801471:	55                   	push   %ebp
  801472:	89 e5                	mov    %esp,%ebp
  801474:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801477:	8b 45 08             	mov    0x8(%ebp),%eax
  80147a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80147d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801484:	eb 1f                	jmp    8014a5 <strncpy+0x34>
		*dst++ = *src;
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	8d 50 01             	lea    0x1(%eax),%edx
  80148c:	89 55 08             	mov    %edx,0x8(%ebp)
  80148f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801492:	8a 12                	mov    (%edx),%dl
  801494:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801496:	8b 45 0c             	mov    0xc(%ebp),%eax
  801499:	8a 00                	mov    (%eax),%al
  80149b:	84 c0                	test   %al,%al
  80149d:	74 03                	je     8014a2 <strncpy+0x31>
			src++;
  80149f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014a2:	ff 45 fc             	incl   -0x4(%ebp)
  8014a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014a8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014ab:	72 d9                	jb     801486 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014b0:	c9                   	leave  
  8014b1:	c3                   	ret    

008014b2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014b2:	55                   	push   %ebp
  8014b3:	89 e5                	mov    %esp,%ebp
  8014b5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014c2:	74 30                	je     8014f4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014c4:	eb 16                	jmp    8014dc <strlcpy+0x2a>
			*dst++ = *src++;
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c9:	8d 50 01             	lea    0x1(%eax),%edx
  8014cc:	89 55 08             	mov    %edx,0x8(%ebp)
  8014cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014d5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014d8:	8a 12                	mov    (%edx),%dl
  8014da:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014dc:	ff 4d 10             	decl   0x10(%ebp)
  8014df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014e3:	74 09                	je     8014ee <strlcpy+0x3c>
  8014e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e8:	8a 00                	mov    (%eax),%al
  8014ea:	84 c0                	test   %al,%al
  8014ec:	75 d8                	jne    8014c6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8014ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8014f4:	8b 55 08             	mov    0x8(%ebp),%edx
  8014f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014fa:	29 c2                	sub    %eax,%edx
  8014fc:	89 d0                	mov    %edx,%eax
}
  8014fe:	c9                   	leave  
  8014ff:	c3                   	ret    

00801500 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801500:	55                   	push   %ebp
  801501:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801503:	eb 06                	jmp    80150b <strcmp+0xb>
		p++, q++;
  801505:	ff 45 08             	incl   0x8(%ebp)
  801508:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	8a 00                	mov    (%eax),%al
  801510:	84 c0                	test   %al,%al
  801512:	74 0e                	je     801522 <strcmp+0x22>
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	8a 10                	mov    (%eax),%dl
  801519:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151c:	8a 00                	mov    (%eax),%al
  80151e:	38 c2                	cmp    %al,%dl
  801520:	74 e3                	je     801505 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
  801525:	8a 00                	mov    (%eax),%al
  801527:	0f b6 d0             	movzbl %al,%edx
  80152a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152d:	8a 00                	mov    (%eax),%al
  80152f:	0f b6 c0             	movzbl %al,%eax
  801532:	29 c2                	sub    %eax,%edx
  801534:	89 d0                	mov    %edx,%eax
}
  801536:	5d                   	pop    %ebp
  801537:	c3                   	ret    

00801538 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801538:	55                   	push   %ebp
  801539:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80153b:	eb 09                	jmp    801546 <strncmp+0xe>
		n--, p++, q++;
  80153d:	ff 4d 10             	decl   0x10(%ebp)
  801540:	ff 45 08             	incl   0x8(%ebp)
  801543:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801546:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80154a:	74 17                	je     801563 <strncmp+0x2b>
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	8a 00                	mov    (%eax),%al
  801551:	84 c0                	test   %al,%al
  801553:	74 0e                	je     801563 <strncmp+0x2b>
  801555:	8b 45 08             	mov    0x8(%ebp),%eax
  801558:	8a 10                	mov    (%eax),%dl
  80155a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155d:	8a 00                	mov    (%eax),%al
  80155f:	38 c2                	cmp    %al,%dl
  801561:	74 da                	je     80153d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801563:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801567:	75 07                	jne    801570 <strncmp+0x38>
		return 0;
  801569:	b8 00 00 00 00       	mov    $0x0,%eax
  80156e:	eb 14                	jmp    801584 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801570:	8b 45 08             	mov    0x8(%ebp),%eax
  801573:	8a 00                	mov    (%eax),%al
  801575:	0f b6 d0             	movzbl %al,%edx
  801578:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157b:	8a 00                	mov    (%eax),%al
  80157d:	0f b6 c0             	movzbl %al,%eax
  801580:	29 c2                	sub    %eax,%edx
  801582:	89 d0                	mov    %edx,%eax
}
  801584:	5d                   	pop    %ebp
  801585:	c3                   	ret    

00801586 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
  801589:	83 ec 04             	sub    $0x4,%esp
  80158c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801592:	eb 12                	jmp    8015a6 <strchr+0x20>
		if (*s == c)
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
  801597:	8a 00                	mov    (%eax),%al
  801599:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80159c:	75 05                	jne    8015a3 <strchr+0x1d>
			return (char *) s;
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	eb 11                	jmp    8015b4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015a3:	ff 45 08             	incl   0x8(%ebp)
  8015a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a9:	8a 00                	mov    (%eax),%al
  8015ab:	84 c0                	test   %al,%al
  8015ad:	75 e5                	jne    801594 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015af:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
  8015b9:	83 ec 04             	sub    $0x4,%esp
  8015bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015c2:	eb 0d                	jmp    8015d1 <strfind+0x1b>
		if (*s == c)
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	8a 00                	mov    (%eax),%al
  8015c9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015cc:	74 0e                	je     8015dc <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015ce:	ff 45 08             	incl   0x8(%ebp)
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	8a 00                	mov    (%eax),%al
  8015d6:	84 c0                	test   %al,%al
  8015d8:	75 ea                	jne    8015c4 <strfind+0xe>
  8015da:	eb 01                	jmp    8015dd <strfind+0x27>
		if (*s == c)
			break;
  8015dc:	90                   	nop
	return (char *) s;
  8015dd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015e0:	c9                   	leave  
  8015e1:	c3                   	ret    

008015e2 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015e2:	55                   	push   %ebp
  8015e3:	89 e5                	mov    %esp,%ebp
  8015e5:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8015e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8015ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8015f4:	eb 0e                	jmp    801604 <memset+0x22>
		*p++ = c;
  8015f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f9:	8d 50 01             	lea    0x1(%eax),%edx
  8015fc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801602:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801604:	ff 4d f8             	decl   -0x8(%ebp)
  801607:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80160b:	79 e9                	jns    8015f6 <memset+0x14>
		*p++ = c;

	return v;
  80160d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801610:	c9                   	leave  
  801611:	c3                   	ret    

00801612 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801612:	55                   	push   %ebp
  801613:	89 e5                	mov    %esp,%ebp
  801615:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801618:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80161e:	8b 45 08             	mov    0x8(%ebp),%eax
  801621:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801624:	eb 16                	jmp    80163c <memcpy+0x2a>
		*d++ = *s++;
  801626:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801629:	8d 50 01             	lea    0x1(%eax),%edx
  80162c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80162f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801632:	8d 4a 01             	lea    0x1(%edx),%ecx
  801635:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801638:	8a 12                	mov    (%edx),%dl
  80163a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80163c:	8b 45 10             	mov    0x10(%ebp),%eax
  80163f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801642:	89 55 10             	mov    %edx,0x10(%ebp)
  801645:	85 c0                	test   %eax,%eax
  801647:	75 dd                	jne    801626 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801649:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80164c:	c9                   	leave  
  80164d:	c3                   	ret    

0080164e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80164e:	55                   	push   %ebp
  80164f:	89 e5                	mov    %esp,%ebp
  801651:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801654:	8b 45 0c             	mov    0xc(%ebp),%eax
  801657:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801660:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801663:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801666:	73 50                	jae    8016b8 <memmove+0x6a>
  801668:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80166b:	8b 45 10             	mov    0x10(%ebp),%eax
  80166e:	01 d0                	add    %edx,%eax
  801670:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801673:	76 43                	jbe    8016b8 <memmove+0x6a>
		s += n;
  801675:	8b 45 10             	mov    0x10(%ebp),%eax
  801678:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80167b:	8b 45 10             	mov    0x10(%ebp),%eax
  80167e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801681:	eb 10                	jmp    801693 <memmove+0x45>
			*--d = *--s;
  801683:	ff 4d f8             	decl   -0x8(%ebp)
  801686:	ff 4d fc             	decl   -0x4(%ebp)
  801689:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80168c:	8a 10                	mov    (%eax),%dl
  80168e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801691:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801693:	8b 45 10             	mov    0x10(%ebp),%eax
  801696:	8d 50 ff             	lea    -0x1(%eax),%edx
  801699:	89 55 10             	mov    %edx,0x10(%ebp)
  80169c:	85 c0                	test   %eax,%eax
  80169e:	75 e3                	jne    801683 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016a0:	eb 23                	jmp    8016c5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a5:	8d 50 01             	lea    0x1(%eax),%edx
  8016a8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ae:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016b1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016b4:	8a 12                	mov    (%edx),%dl
  8016b6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8016bb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016be:	89 55 10             	mov    %edx,0x10(%ebp)
  8016c1:	85 c0                	test   %eax,%eax
  8016c3:	75 dd                	jne    8016a2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016c8:	c9                   	leave  
  8016c9:	c3                   	ret    

008016ca <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016ca:	55                   	push   %ebp
  8016cb:	89 e5                	mov    %esp,%ebp
  8016cd:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016dc:	eb 2a                	jmp    801708 <memcmp+0x3e>
		if (*s1 != *s2)
  8016de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016e1:	8a 10                	mov    (%eax),%dl
  8016e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e6:	8a 00                	mov    (%eax),%al
  8016e8:	38 c2                	cmp    %al,%dl
  8016ea:	74 16                	je     801702 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8016ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016ef:	8a 00                	mov    (%eax),%al
  8016f1:	0f b6 d0             	movzbl %al,%edx
  8016f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f7:	8a 00                	mov    (%eax),%al
  8016f9:	0f b6 c0             	movzbl %al,%eax
  8016fc:	29 c2                	sub    %eax,%edx
  8016fe:	89 d0                	mov    %edx,%eax
  801700:	eb 18                	jmp    80171a <memcmp+0x50>
		s1++, s2++;
  801702:	ff 45 fc             	incl   -0x4(%ebp)
  801705:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801708:	8b 45 10             	mov    0x10(%ebp),%eax
  80170b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80170e:	89 55 10             	mov    %edx,0x10(%ebp)
  801711:	85 c0                	test   %eax,%eax
  801713:	75 c9                	jne    8016de <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801715:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80171a:	c9                   	leave  
  80171b:	c3                   	ret    

0080171c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80171c:	55                   	push   %ebp
  80171d:	89 e5                	mov    %esp,%ebp
  80171f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801722:	8b 55 08             	mov    0x8(%ebp),%edx
  801725:	8b 45 10             	mov    0x10(%ebp),%eax
  801728:	01 d0                	add    %edx,%eax
  80172a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80172d:	eb 15                	jmp    801744 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80172f:	8b 45 08             	mov    0x8(%ebp),%eax
  801732:	8a 00                	mov    (%eax),%al
  801734:	0f b6 d0             	movzbl %al,%edx
  801737:	8b 45 0c             	mov    0xc(%ebp),%eax
  80173a:	0f b6 c0             	movzbl %al,%eax
  80173d:	39 c2                	cmp    %eax,%edx
  80173f:	74 0d                	je     80174e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801741:	ff 45 08             	incl   0x8(%ebp)
  801744:	8b 45 08             	mov    0x8(%ebp),%eax
  801747:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80174a:	72 e3                	jb     80172f <memfind+0x13>
  80174c:	eb 01                	jmp    80174f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80174e:	90                   	nop
	return (void *) s;
  80174f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801752:	c9                   	leave  
  801753:	c3                   	ret    

00801754 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
  801757:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80175a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801761:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801768:	eb 03                	jmp    80176d <strtol+0x19>
		s++;
  80176a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	8a 00                	mov    (%eax),%al
  801772:	3c 20                	cmp    $0x20,%al
  801774:	74 f4                	je     80176a <strtol+0x16>
  801776:	8b 45 08             	mov    0x8(%ebp),%eax
  801779:	8a 00                	mov    (%eax),%al
  80177b:	3c 09                	cmp    $0x9,%al
  80177d:	74 eb                	je     80176a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
  801782:	8a 00                	mov    (%eax),%al
  801784:	3c 2b                	cmp    $0x2b,%al
  801786:	75 05                	jne    80178d <strtol+0x39>
		s++;
  801788:	ff 45 08             	incl   0x8(%ebp)
  80178b:	eb 13                	jmp    8017a0 <strtol+0x4c>
	else if (*s == '-')
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
  801790:	8a 00                	mov    (%eax),%al
  801792:	3c 2d                	cmp    $0x2d,%al
  801794:	75 0a                	jne    8017a0 <strtol+0x4c>
		s++, neg = 1;
  801796:	ff 45 08             	incl   0x8(%ebp)
  801799:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017a4:	74 06                	je     8017ac <strtol+0x58>
  8017a6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017aa:	75 20                	jne    8017cc <strtol+0x78>
  8017ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8017af:	8a 00                	mov    (%eax),%al
  8017b1:	3c 30                	cmp    $0x30,%al
  8017b3:	75 17                	jne    8017cc <strtol+0x78>
  8017b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b8:	40                   	inc    %eax
  8017b9:	8a 00                	mov    (%eax),%al
  8017bb:	3c 78                	cmp    $0x78,%al
  8017bd:	75 0d                	jne    8017cc <strtol+0x78>
		s += 2, base = 16;
  8017bf:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017c3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017ca:	eb 28                	jmp    8017f4 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017cc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017d0:	75 15                	jne    8017e7 <strtol+0x93>
  8017d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d5:	8a 00                	mov    (%eax),%al
  8017d7:	3c 30                	cmp    $0x30,%al
  8017d9:	75 0c                	jne    8017e7 <strtol+0x93>
		s++, base = 8;
  8017db:	ff 45 08             	incl   0x8(%ebp)
  8017de:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017e5:	eb 0d                	jmp    8017f4 <strtol+0xa0>
	else if (base == 0)
  8017e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017eb:	75 07                	jne    8017f4 <strtol+0xa0>
		base = 10;
  8017ed:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8017f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f7:	8a 00                	mov    (%eax),%al
  8017f9:	3c 2f                	cmp    $0x2f,%al
  8017fb:	7e 19                	jle    801816 <strtol+0xc2>
  8017fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801800:	8a 00                	mov    (%eax),%al
  801802:	3c 39                	cmp    $0x39,%al
  801804:	7f 10                	jg     801816 <strtol+0xc2>
			dig = *s - '0';
  801806:	8b 45 08             	mov    0x8(%ebp),%eax
  801809:	8a 00                	mov    (%eax),%al
  80180b:	0f be c0             	movsbl %al,%eax
  80180e:	83 e8 30             	sub    $0x30,%eax
  801811:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801814:	eb 42                	jmp    801858 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	8a 00                	mov    (%eax),%al
  80181b:	3c 60                	cmp    $0x60,%al
  80181d:	7e 19                	jle    801838 <strtol+0xe4>
  80181f:	8b 45 08             	mov    0x8(%ebp),%eax
  801822:	8a 00                	mov    (%eax),%al
  801824:	3c 7a                	cmp    $0x7a,%al
  801826:	7f 10                	jg     801838 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801828:	8b 45 08             	mov    0x8(%ebp),%eax
  80182b:	8a 00                	mov    (%eax),%al
  80182d:	0f be c0             	movsbl %al,%eax
  801830:	83 e8 57             	sub    $0x57,%eax
  801833:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801836:	eb 20                	jmp    801858 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801838:	8b 45 08             	mov    0x8(%ebp),%eax
  80183b:	8a 00                	mov    (%eax),%al
  80183d:	3c 40                	cmp    $0x40,%al
  80183f:	7e 39                	jle    80187a <strtol+0x126>
  801841:	8b 45 08             	mov    0x8(%ebp),%eax
  801844:	8a 00                	mov    (%eax),%al
  801846:	3c 5a                	cmp    $0x5a,%al
  801848:	7f 30                	jg     80187a <strtol+0x126>
			dig = *s - 'A' + 10;
  80184a:	8b 45 08             	mov    0x8(%ebp),%eax
  80184d:	8a 00                	mov    (%eax),%al
  80184f:	0f be c0             	movsbl %al,%eax
  801852:	83 e8 37             	sub    $0x37,%eax
  801855:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801858:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80185b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80185e:	7d 19                	jge    801879 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801860:	ff 45 08             	incl   0x8(%ebp)
  801863:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801866:	0f af 45 10          	imul   0x10(%ebp),%eax
  80186a:	89 c2                	mov    %eax,%edx
  80186c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80186f:	01 d0                	add    %edx,%eax
  801871:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801874:	e9 7b ff ff ff       	jmp    8017f4 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801879:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80187a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80187e:	74 08                	je     801888 <strtol+0x134>
		*endptr = (char *) s;
  801880:	8b 45 0c             	mov    0xc(%ebp),%eax
  801883:	8b 55 08             	mov    0x8(%ebp),%edx
  801886:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801888:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80188c:	74 07                	je     801895 <strtol+0x141>
  80188e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801891:	f7 d8                	neg    %eax
  801893:	eb 03                	jmp    801898 <strtol+0x144>
  801895:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801898:	c9                   	leave  
  801899:	c3                   	ret    

0080189a <ltostr>:

void
ltostr(long value, char *str)
{
  80189a:	55                   	push   %ebp
  80189b:	89 e5                	mov    %esp,%ebp
  80189d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018a7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018ae:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018b2:	79 13                	jns    8018c7 <ltostr+0x2d>
	{
		neg = 1;
  8018b4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018be:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018c1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018c4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ca:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018cf:	99                   	cltd   
  8018d0:	f7 f9                	idiv   %ecx
  8018d2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018d8:	8d 50 01             	lea    0x1(%eax),%edx
  8018db:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018de:	89 c2                	mov    %eax,%edx
  8018e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e3:	01 d0                	add    %edx,%eax
  8018e5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018e8:	83 c2 30             	add    $0x30,%edx
  8018eb:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8018ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018f0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8018f5:	f7 e9                	imul   %ecx
  8018f7:	c1 fa 02             	sar    $0x2,%edx
  8018fa:	89 c8                	mov    %ecx,%eax
  8018fc:	c1 f8 1f             	sar    $0x1f,%eax
  8018ff:	29 c2                	sub    %eax,%edx
  801901:	89 d0                	mov    %edx,%eax
  801903:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801906:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801909:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80190e:	f7 e9                	imul   %ecx
  801910:	c1 fa 02             	sar    $0x2,%edx
  801913:	89 c8                	mov    %ecx,%eax
  801915:	c1 f8 1f             	sar    $0x1f,%eax
  801918:	29 c2                	sub    %eax,%edx
  80191a:	89 d0                	mov    %edx,%eax
  80191c:	c1 e0 02             	shl    $0x2,%eax
  80191f:	01 d0                	add    %edx,%eax
  801921:	01 c0                	add    %eax,%eax
  801923:	29 c1                	sub    %eax,%ecx
  801925:	89 ca                	mov    %ecx,%edx
  801927:	85 d2                	test   %edx,%edx
  801929:	75 9c                	jne    8018c7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80192b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801932:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801935:	48                   	dec    %eax
  801936:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801939:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80193d:	74 3d                	je     80197c <ltostr+0xe2>
		start = 1 ;
  80193f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801946:	eb 34                	jmp    80197c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801948:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80194b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194e:	01 d0                	add    %edx,%eax
  801950:	8a 00                	mov    (%eax),%al
  801952:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801955:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801958:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195b:	01 c2                	add    %eax,%edx
  80195d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801960:	8b 45 0c             	mov    0xc(%ebp),%eax
  801963:	01 c8                	add    %ecx,%eax
  801965:	8a 00                	mov    (%eax),%al
  801967:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801969:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80196c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80196f:	01 c2                	add    %eax,%edx
  801971:	8a 45 eb             	mov    -0x15(%ebp),%al
  801974:	88 02                	mov    %al,(%edx)
		start++ ;
  801976:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801979:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80197c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80197f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801982:	7c c4                	jl     801948 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801984:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801987:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198a:	01 d0                	add    %edx,%eax
  80198c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80198f:	90                   	nop
  801990:	c9                   	leave  
  801991:	c3                   	ret    

00801992 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801992:	55                   	push   %ebp
  801993:	89 e5                	mov    %esp,%ebp
  801995:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801998:	ff 75 08             	pushl  0x8(%ebp)
  80199b:	e8 54 fa ff ff       	call   8013f4 <strlen>
  8019a0:	83 c4 04             	add    $0x4,%esp
  8019a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019a6:	ff 75 0c             	pushl  0xc(%ebp)
  8019a9:	e8 46 fa ff ff       	call   8013f4 <strlen>
  8019ae:	83 c4 04             	add    $0x4,%esp
  8019b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019c2:	eb 17                	jmp    8019db <strcconcat+0x49>
		final[s] = str1[s] ;
  8019c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ca:	01 c2                	add    %eax,%edx
  8019cc:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d2:	01 c8                	add    %ecx,%eax
  8019d4:	8a 00                	mov    (%eax),%al
  8019d6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019d8:	ff 45 fc             	incl   -0x4(%ebp)
  8019db:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019de:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019e1:	7c e1                	jl     8019c4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019ea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019f1:	eb 1f                	jmp    801a12 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8019f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019f6:	8d 50 01             	lea    0x1(%eax),%edx
  8019f9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8019fc:	89 c2                	mov    %eax,%edx
  8019fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801a01:	01 c2                	add    %eax,%edx
  801a03:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a06:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a09:	01 c8                	add    %ecx,%eax
  801a0b:	8a 00                	mov    (%eax),%al
  801a0d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a0f:	ff 45 f8             	incl   -0x8(%ebp)
  801a12:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a15:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a18:	7c d9                	jl     8019f3 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a1a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a1d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a20:	01 d0                	add    %edx,%eax
  801a22:	c6 00 00             	movb   $0x0,(%eax)
}
  801a25:	90                   	nop
  801a26:	c9                   	leave  
  801a27:	c3                   	ret    

00801a28 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a28:	55                   	push   %ebp
  801a29:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a2b:	8b 45 14             	mov    0x14(%ebp),%eax
  801a2e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a34:	8b 45 14             	mov    0x14(%ebp),%eax
  801a37:	8b 00                	mov    (%eax),%eax
  801a39:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a40:	8b 45 10             	mov    0x10(%ebp),%eax
  801a43:	01 d0                	add    %edx,%eax
  801a45:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a4b:	eb 0c                	jmp    801a59 <strsplit+0x31>
			*string++ = 0;
  801a4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a50:	8d 50 01             	lea    0x1(%eax),%edx
  801a53:	89 55 08             	mov    %edx,0x8(%ebp)
  801a56:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a59:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5c:	8a 00                	mov    (%eax),%al
  801a5e:	84 c0                	test   %al,%al
  801a60:	74 18                	je     801a7a <strsplit+0x52>
  801a62:	8b 45 08             	mov    0x8(%ebp),%eax
  801a65:	8a 00                	mov    (%eax),%al
  801a67:	0f be c0             	movsbl %al,%eax
  801a6a:	50                   	push   %eax
  801a6b:	ff 75 0c             	pushl  0xc(%ebp)
  801a6e:	e8 13 fb ff ff       	call   801586 <strchr>
  801a73:	83 c4 08             	add    $0x8,%esp
  801a76:	85 c0                	test   %eax,%eax
  801a78:	75 d3                	jne    801a4d <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7d:	8a 00                	mov    (%eax),%al
  801a7f:	84 c0                	test   %al,%al
  801a81:	74 5a                	je     801add <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801a83:	8b 45 14             	mov    0x14(%ebp),%eax
  801a86:	8b 00                	mov    (%eax),%eax
  801a88:	83 f8 0f             	cmp    $0xf,%eax
  801a8b:	75 07                	jne    801a94 <strsplit+0x6c>
		{
			return 0;
  801a8d:	b8 00 00 00 00       	mov    $0x0,%eax
  801a92:	eb 66                	jmp    801afa <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801a94:	8b 45 14             	mov    0x14(%ebp),%eax
  801a97:	8b 00                	mov    (%eax),%eax
  801a99:	8d 48 01             	lea    0x1(%eax),%ecx
  801a9c:	8b 55 14             	mov    0x14(%ebp),%edx
  801a9f:	89 0a                	mov    %ecx,(%edx)
  801aa1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801aa8:	8b 45 10             	mov    0x10(%ebp),%eax
  801aab:	01 c2                	add    %eax,%edx
  801aad:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ab2:	eb 03                	jmp    801ab7 <strsplit+0x8f>
			string++;
  801ab4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aba:	8a 00                	mov    (%eax),%al
  801abc:	84 c0                	test   %al,%al
  801abe:	74 8b                	je     801a4b <strsplit+0x23>
  801ac0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac3:	8a 00                	mov    (%eax),%al
  801ac5:	0f be c0             	movsbl %al,%eax
  801ac8:	50                   	push   %eax
  801ac9:	ff 75 0c             	pushl  0xc(%ebp)
  801acc:	e8 b5 fa ff ff       	call   801586 <strchr>
  801ad1:	83 c4 08             	add    $0x8,%esp
  801ad4:	85 c0                	test   %eax,%eax
  801ad6:	74 dc                	je     801ab4 <strsplit+0x8c>
			string++;
	}
  801ad8:	e9 6e ff ff ff       	jmp    801a4b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801add:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801ade:	8b 45 14             	mov    0x14(%ebp),%eax
  801ae1:	8b 00                	mov    (%eax),%eax
  801ae3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801aea:	8b 45 10             	mov    0x10(%ebp),%eax
  801aed:	01 d0                	add    %edx,%eax
  801aef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801af5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801afa:	c9                   	leave  
  801afb:	c3                   	ret    

00801afc <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801afc:	55                   	push   %ebp
  801afd:	89 e5                	mov    %esp,%ebp
  801aff:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801b02:	e8 9b 07 00 00       	call   8022a2 <sys_isUHeapPlacementStrategyNEXTFIT>
  801b07:	85 c0                	test   %eax,%eax
  801b09:	0f 84 64 01 00 00    	je     801c73 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801b0f:	8b 0d 2c 30 80 00    	mov    0x80302c,%ecx
  801b15:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801b1c:	8b 55 08             	mov    0x8(%ebp),%edx
  801b1f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b22:	01 d0                	add    %edx,%eax
  801b24:	48                   	dec    %eax
  801b25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801b28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b2b:	ba 00 00 00 00       	mov    $0x0,%edx
  801b30:	f7 75 e8             	divl   -0x18(%ebp)
  801b33:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b36:	29 d0                	sub    %edx,%eax
  801b38:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801b3f:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b45:	8b 45 08             	mov    0x8(%ebp),%eax
  801b48:	01 d0                	add    %edx,%eax
  801b4a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801b4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801b54:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b59:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b60:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801b63:	0f 83 0a 01 00 00    	jae    801c73 <malloc+0x177>
  801b69:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b6e:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b75:	85 c0                	test   %eax,%eax
  801b77:	0f 84 f6 00 00 00    	je     801c73 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801b7d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b84:	e9 dc 00 00 00       	jmp    801c65 <malloc+0x169>
				flag++;
  801b89:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801b8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b8f:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801b96:	85 c0                	test   %eax,%eax
  801b98:	74 07                	je     801ba1 <malloc+0xa5>
					flag=0;
  801b9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801ba1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801ba6:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801bad:	85 c0                	test   %eax,%eax
  801baf:	79 05                	jns    801bb6 <malloc+0xba>
  801bb1:	05 ff 0f 00 00       	add    $0xfff,%eax
  801bb6:	c1 f8 0c             	sar    $0xc,%eax
  801bb9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801bbc:	0f 85 a0 00 00 00    	jne    801c62 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801bc2:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801bc7:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801bce:	85 c0                	test   %eax,%eax
  801bd0:	79 05                	jns    801bd7 <malloc+0xdb>
  801bd2:	05 ff 0f 00 00       	add    $0xfff,%eax
  801bd7:	c1 f8 0c             	sar    $0xc,%eax
  801bda:	89 c2                	mov    %eax,%edx
  801bdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bdf:	29 d0                	sub    %edx,%eax
  801be1:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801be4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801be7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801bea:	eb 11                	jmp    801bfd <malloc+0x101>
						hFreeArr[j] = 1;
  801bec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bef:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801bf6:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801bfa:	ff 45 ec             	incl   -0x14(%ebp)
  801bfd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c00:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c03:	7e e7                	jle    801bec <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801c05:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c0a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801c0d:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801c13:	c1 e2 0c             	shl    $0xc,%edx
  801c16:	89 15 04 30 80 00    	mov    %edx,0x803004
  801c1c:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801c22:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801c29:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c2e:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801c35:	89 c2                	mov    %eax,%edx
  801c37:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c3c:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801c43:	83 ec 08             	sub    $0x8,%esp
  801c46:	52                   	push   %edx
  801c47:	50                   	push   %eax
  801c48:	e8 8b 02 00 00       	call   801ed8 <sys_allocateMem>
  801c4d:	83 c4 10             	add    $0x10,%esp

					idx++;
  801c50:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c55:	40                   	inc    %eax
  801c56:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*)startAdd;
  801c5b:	a1 04 30 80 00       	mov    0x803004,%eax
  801c60:	eb 16                	jmp    801c78 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801c62:	ff 45 f0             	incl   -0x10(%ebp)
  801c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c68:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c6d:	0f 86 16 ff ff ff    	jbe    801b89 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801c73:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c78:	c9                   	leave  
  801c79:	c3                   	ret    

00801c7a <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c7a:	55                   	push   %ebp
  801c7b:	89 e5                	mov    %esp,%ebp
  801c7d:	83 ec 18             	sub    $0x18,%esp
  801c80:	8b 45 10             	mov    0x10(%ebp),%eax
  801c83:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801c86:	83 ec 04             	sub    $0x4,%esp
  801c89:	68 c4 2c 80 00       	push   $0x802cc4
  801c8e:	6a 59                	push   $0x59
  801c90:	68 e3 2c 80 00       	push   $0x802ce3
  801c95:	e8 1e ec ff ff       	call   8008b8 <_panic>

00801c9a <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c9a:	55                   	push   %ebp
  801c9b:	89 e5                	mov    %esp,%ebp
  801c9d:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801ca0:	83 ec 04             	sub    $0x4,%esp
  801ca3:	68 ef 2c 80 00       	push   $0x802cef
  801ca8:	6a 5f                	push   $0x5f
  801caa:	68 e3 2c 80 00       	push   $0x802ce3
  801caf:	e8 04 ec ff ff       	call   8008b8 <_panic>

00801cb4 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801cb4:	55                   	push   %ebp
  801cb5:	89 e5                	mov    %esp,%ebp
  801cb7:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801cba:	83 ec 04             	sub    $0x4,%esp
  801cbd:	68 0c 2d 80 00       	push   $0x802d0c
  801cc2:	6a 70                	push   $0x70
  801cc4:	68 e3 2c 80 00       	push   $0x802ce3
  801cc9:	e8 ea eb ff ff       	call   8008b8 <_panic>

00801cce <sfree>:

}


void sfree(void* virtual_address)
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
  801cd1:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801cd4:	83 ec 04             	sub    $0x4,%esp
  801cd7:	68 2f 2d 80 00       	push   $0x802d2f
  801cdc:	6a 7b                	push   $0x7b
  801cde:	68 e3 2c 80 00       	push   $0x802ce3
  801ce3:	e8 d0 eb ff ff       	call   8008b8 <_panic>

00801ce8 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801ce8:	55                   	push   %ebp
  801ce9:	89 e5                	mov    %esp,%ebp
  801ceb:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801cee:	83 ec 04             	sub    $0x4,%esp
  801cf1:	68 4c 2d 80 00       	push   $0x802d4c
  801cf6:	68 93 00 00 00       	push   $0x93
  801cfb:	68 e3 2c 80 00       	push   $0x802ce3
  801d00:	e8 b3 eb ff ff       	call   8008b8 <_panic>

00801d05 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d05:	55                   	push   %ebp
  801d06:	89 e5                	mov    %esp,%ebp
  801d08:	57                   	push   %edi
  801d09:	56                   	push   %esi
  801d0a:	53                   	push   %ebx
  801d0b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d14:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d17:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d1a:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d1d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d20:	cd 30                	int    $0x30
  801d22:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d25:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d28:	83 c4 10             	add    $0x10,%esp
  801d2b:	5b                   	pop    %ebx
  801d2c:	5e                   	pop    %esi
  801d2d:	5f                   	pop    %edi
  801d2e:	5d                   	pop    %ebp
  801d2f:	c3                   	ret    

00801d30 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d30:	55                   	push   %ebp
  801d31:	89 e5                	mov    %esp,%ebp
  801d33:	83 ec 04             	sub    $0x4,%esp
  801d36:	8b 45 10             	mov    0x10(%ebp),%eax
  801d39:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d3c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d40:	8b 45 08             	mov    0x8(%ebp),%eax
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	52                   	push   %edx
  801d48:	ff 75 0c             	pushl  0xc(%ebp)
  801d4b:	50                   	push   %eax
  801d4c:	6a 00                	push   $0x0
  801d4e:	e8 b2 ff ff ff       	call   801d05 <syscall>
  801d53:	83 c4 18             	add    $0x18,%esp
}
  801d56:	90                   	nop
  801d57:	c9                   	leave  
  801d58:	c3                   	ret    

00801d59 <sys_cgetc>:

int
sys_cgetc(void)
{
  801d59:	55                   	push   %ebp
  801d5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	6a 00                	push   $0x0
  801d64:	6a 00                	push   $0x0
  801d66:	6a 01                	push   $0x1
  801d68:	e8 98 ff ff ff       	call   801d05 <syscall>
  801d6d:	83 c4 18             	add    $0x18,%esp
}
  801d70:	c9                   	leave  
  801d71:	c3                   	ret    

00801d72 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d72:	55                   	push   %ebp
  801d73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d75:	8b 45 08             	mov    0x8(%ebp),%eax
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 00                	push   $0x0
  801d80:	50                   	push   %eax
  801d81:	6a 05                	push   $0x5
  801d83:	e8 7d ff ff ff       	call   801d05 <syscall>
  801d88:	83 c4 18             	add    $0x18,%esp
}
  801d8b:	c9                   	leave  
  801d8c:	c3                   	ret    

00801d8d <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 02                	push   $0x2
  801d9c:	e8 64 ff ff ff       	call   801d05 <syscall>
  801da1:	83 c4 18             	add    $0x18,%esp
}
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 03                	push   $0x3
  801db5:	e8 4b ff ff ff       	call   801d05 <syscall>
  801dba:	83 c4 18             	add    $0x18,%esp
}
  801dbd:	c9                   	leave  
  801dbe:	c3                   	ret    

00801dbf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801dbf:	55                   	push   %ebp
  801dc0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 04                	push   $0x4
  801dce:	e8 32 ff ff ff       	call   801d05 <syscall>
  801dd3:	83 c4 18             	add    $0x18,%esp
}
  801dd6:	c9                   	leave  
  801dd7:	c3                   	ret    

00801dd8 <sys_env_exit>:


void sys_env_exit(void)
{
  801dd8:	55                   	push   %ebp
  801dd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 06                	push   $0x6
  801de7:	e8 19 ff ff ff       	call   801d05 <syscall>
  801dec:	83 c4 18             	add    $0x18,%esp
}
  801def:	90                   	nop
  801df0:	c9                   	leave  
  801df1:	c3                   	ret    

00801df2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801df2:	55                   	push   %ebp
  801df3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801df5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	52                   	push   %edx
  801e02:	50                   	push   %eax
  801e03:	6a 07                	push   $0x7
  801e05:	e8 fb fe ff ff       	call   801d05 <syscall>
  801e0a:	83 c4 18             	add    $0x18,%esp
}
  801e0d:	c9                   	leave  
  801e0e:	c3                   	ret    

00801e0f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e0f:	55                   	push   %ebp
  801e10:	89 e5                	mov    %esp,%ebp
  801e12:	56                   	push   %esi
  801e13:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e14:	8b 75 18             	mov    0x18(%ebp),%esi
  801e17:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e1a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e20:	8b 45 08             	mov    0x8(%ebp),%eax
  801e23:	56                   	push   %esi
  801e24:	53                   	push   %ebx
  801e25:	51                   	push   %ecx
  801e26:	52                   	push   %edx
  801e27:	50                   	push   %eax
  801e28:	6a 08                	push   $0x8
  801e2a:	e8 d6 fe ff ff       	call   801d05 <syscall>
  801e2f:	83 c4 18             	add    $0x18,%esp
}
  801e32:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e35:	5b                   	pop    %ebx
  801e36:	5e                   	pop    %esi
  801e37:	5d                   	pop    %ebp
  801e38:	c3                   	ret    

00801e39 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e39:	55                   	push   %ebp
  801e3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e42:	6a 00                	push   $0x0
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	52                   	push   %edx
  801e49:	50                   	push   %eax
  801e4a:	6a 09                	push   $0x9
  801e4c:	e8 b4 fe ff ff       	call   801d05 <syscall>
  801e51:	83 c4 18             	add    $0x18,%esp
}
  801e54:	c9                   	leave  
  801e55:	c3                   	ret    

00801e56 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e56:	55                   	push   %ebp
  801e57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	ff 75 0c             	pushl  0xc(%ebp)
  801e62:	ff 75 08             	pushl  0x8(%ebp)
  801e65:	6a 0a                	push   $0xa
  801e67:	e8 99 fe ff ff       	call   801d05 <syscall>
  801e6c:	83 c4 18             	add    $0x18,%esp
}
  801e6f:	c9                   	leave  
  801e70:	c3                   	ret    

00801e71 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e71:	55                   	push   %ebp
  801e72:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 0b                	push   $0xb
  801e80:	e8 80 fe ff ff       	call   801d05 <syscall>
  801e85:	83 c4 18             	add    $0x18,%esp
}
  801e88:	c9                   	leave  
  801e89:	c3                   	ret    

00801e8a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e8a:	55                   	push   %ebp
  801e8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	6a 0c                	push   $0xc
  801e99:	e8 67 fe ff ff       	call   801d05 <syscall>
  801e9e:	83 c4 18             	add    $0x18,%esp
}
  801ea1:	c9                   	leave  
  801ea2:	c3                   	ret    

00801ea3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ea3:	55                   	push   %ebp
  801ea4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 0d                	push   $0xd
  801eb2:	e8 4e fe ff ff       	call   801d05 <syscall>
  801eb7:	83 c4 18             	add    $0x18,%esp
}
  801eba:	c9                   	leave  
  801ebb:	c3                   	ret    

00801ebc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ebc:	55                   	push   %ebp
  801ebd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	ff 75 0c             	pushl  0xc(%ebp)
  801ec8:	ff 75 08             	pushl  0x8(%ebp)
  801ecb:	6a 11                	push   $0x11
  801ecd:	e8 33 fe ff ff       	call   801d05 <syscall>
  801ed2:	83 c4 18             	add    $0x18,%esp
	return;
  801ed5:	90                   	nop
}
  801ed6:	c9                   	leave  
  801ed7:	c3                   	ret    

00801ed8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801ed8:	55                   	push   %ebp
  801ed9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	ff 75 0c             	pushl  0xc(%ebp)
  801ee4:	ff 75 08             	pushl  0x8(%ebp)
  801ee7:	6a 12                	push   $0x12
  801ee9:	e8 17 fe ff ff       	call   801d05 <syscall>
  801eee:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef1:	90                   	nop
}
  801ef2:	c9                   	leave  
  801ef3:	c3                   	ret    

00801ef4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ef4:	55                   	push   %ebp
  801ef5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	6a 0e                	push   $0xe
  801f03:	e8 fd fd ff ff       	call   801d05 <syscall>
  801f08:	83 c4 18             	add    $0x18,%esp
}
  801f0b:	c9                   	leave  
  801f0c:	c3                   	ret    

00801f0d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f0d:	55                   	push   %ebp
  801f0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	ff 75 08             	pushl  0x8(%ebp)
  801f1b:	6a 0f                	push   $0xf
  801f1d:	e8 e3 fd ff ff       	call   801d05 <syscall>
  801f22:	83 c4 18             	add    $0x18,%esp
}
  801f25:	c9                   	leave  
  801f26:	c3                   	ret    

00801f27 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f27:	55                   	push   %ebp
  801f28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 10                	push   $0x10
  801f36:	e8 ca fd ff ff       	call   801d05 <syscall>
  801f3b:	83 c4 18             	add    $0x18,%esp
}
  801f3e:	90                   	nop
  801f3f:	c9                   	leave  
  801f40:	c3                   	ret    

00801f41 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f41:	55                   	push   %ebp
  801f42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 14                	push   $0x14
  801f50:	e8 b0 fd ff ff       	call   801d05 <syscall>
  801f55:	83 c4 18             	add    $0x18,%esp
}
  801f58:	90                   	nop
  801f59:	c9                   	leave  
  801f5a:	c3                   	ret    

00801f5b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f5b:	55                   	push   %ebp
  801f5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 15                	push   $0x15
  801f6a:	e8 96 fd ff ff       	call   801d05 <syscall>
  801f6f:	83 c4 18             	add    $0x18,%esp
}
  801f72:	90                   	nop
  801f73:	c9                   	leave  
  801f74:	c3                   	ret    

00801f75 <sys_cputc>:


void
sys_cputc(const char c)
{
  801f75:	55                   	push   %ebp
  801f76:	89 e5                	mov    %esp,%ebp
  801f78:	83 ec 04             	sub    $0x4,%esp
  801f7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f81:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	50                   	push   %eax
  801f8e:	6a 16                	push   $0x16
  801f90:	e8 70 fd ff ff       	call   801d05 <syscall>
  801f95:	83 c4 18             	add    $0x18,%esp
}
  801f98:	90                   	nop
  801f99:	c9                   	leave  
  801f9a:	c3                   	ret    

00801f9b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f9b:	55                   	push   %ebp
  801f9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 17                	push   $0x17
  801faa:	e8 56 fd ff ff       	call   801d05 <syscall>
  801faf:	83 c4 18             	add    $0x18,%esp
}
  801fb2:	90                   	nop
  801fb3:	c9                   	leave  
  801fb4:	c3                   	ret    

00801fb5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801fb5:	55                   	push   %ebp
  801fb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	ff 75 0c             	pushl  0xc(%ebp)
  801fc4:	50                   	push   %eax
  801fc5:	6a 18                	push   $0x18
  801fc7:	e8 39 fd ff ff       	call   801d05 <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
}
  801fcf:	c9                   	leave  
  801fd0:	c3                   	ret    

00801fd1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801fd1:	55                   	push   %ebp
  801fd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	52                   	push   %edx
  801fe1:	50                   	push   %eax
  801fe2:	6a 1b                	push   $0x1b
  801fe4:	e8 1c fd ff ff       	call   801d05 <syscall>
  801fe9:	83 c4 18             	add    $0x18,%esp
}
  801fec:	c9                   	leave  
  801fed:	c3                   	ret    

00801fee <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fee:	55                   	push   %ebp
  801fef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ff1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	52                   	push   %edx
  801ffe:	50                   	push   %eax
  801fff:	6a 19                	push   $0x19
  802001:	e8 ff fc ff ff       	call   801d05 <syscall>
  802006:	83 c4 18             	add    $0x18,%esp
}
  802009:	90                   	nop
  80200a:	c9                   	leave  
  80200b:	c3                   	ret    

0080200c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80200c:	55                   	push   %ebp
  80200d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80200f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802012:	8b 45 08             	mov    0x8(%ebp),%eax
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	52                   	push   %edx
  80201c:	50                   	push   %eax
  80201d:	6a 1a                	push   $0x1a
  80201f:	e8 e1 fc ff ff       	call   801d05 <syscall>
  802024:	83 c4 18             	add    $0x18,%esp
}
  802027:	90                   	nop
  802028:	c9                   	leave  
  802029:	c3                   	ret    

0080202a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80202a:	55                   	push   %ebp
  80202b:	89 e5                	mov    %esp,%ebp
  80202d:	83 ec 04             	sub    $0x4,%esp
  802030:	8b 45 10             	mov    0x10(%ebp),%eax
  802033:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802036:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802039:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80203d:	8b 45 08             	mov    0x8(%ebp),%eax
  802040:	6a 00                	push   $0x0
  802042:	51                   	push   %ecx
  802043:	52                   	push   %edx
  802044:	ff 75 0c             	pushl  0xc(%ebp)
  802047:	50                   	push   %eax
  802048:	6a 1c                	push   $0x1c
  80204a:	e8 b6 fc ff ff       	call   801d05 <syscall>
  80204f:	83 c4 18             	add    $0x18,%esp
}
  802052:	c9                   	leave  
  802053:	c3                   	ret    

00802054 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802054:	55                   	push   %ebp
  802055:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802057:	8b 55 0c             	mov    0xc(%ebp),%edx
  80205a:	8b 45 08             	mov    0x8(%ebp),%eax
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	6a 00                	push   $0x0
  802063:	52                   	push   %edx
  802064:	50                   	push   %eax
  802065:	6a 1d                	push   $0x1d
  802067:	e8 99 fc ff ff       	call   801d05 <syscall>
  80206c:	83 c4 18             	add    $0x18,%esp
}
  80206f:	c9                   	leave  
  802070:	c3                   	ret    

00802071 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802071:	55                   	push   %ebp
  802072:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802074:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802077:	8b 55 0c             	mov    0xc(%ebp),%edx
  80207a:	8b 45 08             	mov    0x8(%ebp),%eax
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	51                   	push   %ecx
  802082:	52                   	push   %edx
  802083:	50                   	push   %eax
  802084:	6a 1e                	push   $0x1e
  802086:	e8 7a fc ff ff       	call   801d05 <syscall>
  80208b:	83 c4 18             	add    $0x18,%esp
}
  80208e:	c9                   	leave  
  80208f:	c3                   	ret    

00802090 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802090:	55                   	push   %ebp
  802091:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802093:	8b 55 0c             	mov    0xc(%ebp),%edx
  802096:	8b 45 08             	mov    0x8(%ebp),%eax
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	52                   	push   %edx
  8020a0:	50                   	push   %eax
  8020a1:	6a 1f                	push   $0x1f
  8020a3:	e8 5d fc ff ff       	call   801d05 <syscall>
  8020a8:	83 c4 18             	add    $0x18,%esp
}
  8020ab:	c9                   	leave  
  8020ac:	c3                   	ret    

008020ad <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8020ad:	55                   	push   %ebp
  8020ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 20                	push   $0x20
  8020bc:	e8 44 fc ff ff       	call   801d05 <syscall>
  8020c1:	83 c4 18             	add    $0x18,%esp
}
  8020c4:	c9                   	leave  
  8020c5:	c3                   	ret    

008020c6 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8020c6:	55                   	push   %ebp
  8020c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8020c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	ff 75 10             	pushl  0x10(%ebp)
  8020d3:	ff 75 0c             	pushl  0xc(%ebp)
  8020d6:	50                   	push   %eax
  8020d7:	6a 21                	push   $0x21
  8020d9:	e8 27 fc ff ff       	call   801d05 <syscall>
  8020de:	83 c4 18             	add    $0x18,%esp
}
  8020e1:	c9                   	leave  
  8020e2:	c3                   	ret    

008020e3 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8020e3:	55                   	push   %ebp
  8020e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8020e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	50                   	push   %eax
  8020f2:	6a 22                	push   $0x22
  8020f4:	e8 0c fc ff ff       	call   801d05 <syscall>
  8020f9:	83 c4 18             	add    $0x18,%esp
}
  8020fc:	90                   	nop
  8020fd:	c9                   	leave  
  8020fe:	c3                   	ret    

008020ff <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8020ff:	55                   	push   %ebp
  802100:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802102:	8b 45 08             	mov    0x8(%ebp),%eax
  802105:	6a 00                	push   $0x0
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	6a 00                	push   $0x0
  80210d:	50                   	push   %eax
  80210e:	6a 23                	push   $0x23
  802110:	e8 f0 fb ff ff       	call   801d05 <syscall>
  802115:	83 c4 18             	add    $0x18,%esp
}
  802118:	90                   	nop
  802119:	c9                   	leave  
  80211a:	c3                   	ret    

0080211b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80211b:	55                   	push   %ebp
  80211c:	89 e5                	mov    %esp,%ebp
  80211e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802121:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802124:	8d 50 04             	lea    0x4(%eax),%edx
  802127:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	52                   	push   %edx
  802131:	50                   	push   %eax
  802132:	6a 24                	push   $0x24
  802134:	e8 cc fb ff ff       	call   801d05 <syscall>
  802139:	83 c4 18             	add    $0x18,%esp
	return result;
  80213c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80213f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802142:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802145:	89 01                	mov    %eax,(%ecx)
  802147:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80214a:	8b 45 08             	mov    0x8(%ebp),%eax
  80214d:	c9                   	leave  
  80214e:	c2 04 00             	ret    $0x4

00802151 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802151:	55                   	push   %ebp
  802152:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802154:	6a 00                	push   $0x0
  802156:	6a 00                	push   $0x0
  802158:	ff 75 10             	pushl  0x10(%ebp)
  80215b:	ff 75 0c             	pushl  0xc(%ebp)
  80215e:	ff 75 08             	pushl  0x8(%ebp)
  802161:	6a 13                	push   $0x13
  802163:	e8 9d fb ff ff       	call   801d05 <syscall>
  802168:	83 c4 18             	add    $0x18,%esp
	return ;
  80216b:	90                   	nop
}
  80216c:	c9                   	leave  
  80216d:	c3                   	ret    

0080216e <sys_rcr2>:
uint32 sys_rcr2()
{
  80216e:	55                   	push   %ebp
  80216f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802171:	6a 00                	push   $0x0
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 00                	push   $0x0
  802179:	6a 00                	push   $0x0
  80217b:	6a 25                	push   $0x25
  80217d:	e8 83 fb ff ff       	call   801d05 <syscall>
  802182:	83 c4 18             	add    $0x18,%esp
}
  802185:	c9                   	leave  
  802186:	c3                   	ret    

00802187 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802187:	55                   	push   %ebp
  802188:	89 e5                	mov    %esp,%ebp
  80218a:	83 ec 04             	sub    $0x4,%esp
  80218d:	8b 45 08             	mov    0x8(%ebp),%eax
  802190:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802193:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802197:	6a 00                	push   $0x0
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	50                   	push   %eax
  8021a0:	6a 26                	push   $0x26
  8021a2:	e8 5e fb ff ff       	call   801d05 <syscall>
  8021a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8021aa:	90                   	nop
}
  8021ab:	c9                   	leave  
  8021ac:	c3                   	ret    

008021ad <rsttst>:
void rsttst()
{
  8021ad:	55                   	push   %ebp
  8021ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	6a 28                	push   $0x28
  8021bc:	e8 44 fb ff ff       	call   801d05 <syscall>
  8021c1:	83 c4 18             	add    $0x18,%esp
	return ;
  8021c4:	90                   	nop
}
  8021c5:	c9                   	leave  
  8021c6:	c3                   	ret    

008021c7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8021c7:	55                   	push   %ebp
  8021c8:	89 e5                	mov    %esp,%ebp
  8021ca:	83 ec 04             	sub    $0x4,%esp
  8021cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8021d0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8021d3:	8b 55 18             	mov    0x18(%ebp),%edx
  8021d6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021da:	52                   	push   %edx
  8021db:	50                   	push   %eax
  8021dc:	ff 75 10             	pushl  0x10(%ebp)
  8021df:	ff 75 0c             	pushl  0xc(%ebp)
  8021e2:	ff 75 08             	pushl  0x8(%ebp)
  8021e5:	6a 27                	push   $0x27
  8021e7:	e8 19 fb ff ff       	call   801d05 <syscall>
  8021ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ef:	90                   	nop
}
  8021f0:	c9                   	leave  
  8021f1:	c3                   	ret    

008021f2 <chktst>:
void chktst(uint32 n)
{
  8021f2:	55                   	push   %ebp
  8021f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8021f5:	6a 00                	push   $0x0
  8021f7:	6a 00                	push   $0x0
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 00                	push   $0x0
  8021fd:	ff 75 08             	pushl  0x8(%ebp)
  802200:	6a 29                	push   $0x29
  802202:	e8 fe fa ff ff       	call   801d05 <syscall>
  802207:	83 c4 18             	add    $0x18,%esp
	return ;
  80220a:	90                   	nop
}
  80220b:	c9                   	leave  
  80220c:	c3                   	ret    

0080220d <inctst>:

void inctst()
{
  80220d:	55                   	push   %ebp
  80220e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	6a 00                	push   $0x0
  802218:	6a 00                	push   $0x0
  80221a:	6a 2a                	push   $0x2a
  80221c:	e8 e4 fa ff ff       	call   801d05 <syscall>
  802221:	83 c4 18             	add    $0x18,%esp
	return ;
  802224:	90                   	nop
}
  802225:	c9                   	leave  
  802226:	c3                   	ret    

00802227 <gettst>:
uint32 gettst()
{
  802227:	55                   	push   %ebp
  802228:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80222a:	6a 00                	push   $0x0
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 00                	push   $0x0
  802232:	6a 00                	push   $0x0
  802234:	6a 2b                	push   $0x2b
  802236:	e8 ca fa ff ff       	call   801d05 <syscall>
  80223b:	83 c4 18             	add    $0x18,%esp
}
  80223e:	c9                   	leave  
  80223f:	c3                   	ret    

00802240 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802240:	55                   	push   %ebp
  802241:	89 e5                	mov    %esp,%ebp
  802243:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 00                	push   $0x0
  80224e:	6a 00                	push   $0x0
  802250:	6a 2c                	push   $0x2c
  802252:	e8 ae fa ff ff       	call   801d05 <syscall>
  802257:	83 c4 18             	add    $0x18,%esp
  80225a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80225d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802261:	75 07                	jne    80226a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802263:	b8 01 00 00 00       	mov    $0x1,%eax
  802268:	eb 05                	jmp    80226f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80226a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80226f:	c9                   	leave  
  802270:	c3                   	ret    

00802271 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802271:	55                   	push   %ebp
  802272:	89 e5                	mov    %esp,%ebp
  802274:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802277:	6a 00                	push   $0x0
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	6a 2c                	push   $0x2c
  802283:	e8 7d fa ff ff       	call   801d05 <syscall>
  802288:	83 c4 18             	add    $0x18,%esp
  80228b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80228e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802292:	75 07                	jne    80229b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802294:	b8 01 00 00 00       	mov    $0x1,%eax
  802299:	eb 05                	jmp    8022a0 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80229b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022a0:	c9                   	leave  
  8022a1:	c3                   	ret    

008022a2 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8022a2:	55                   	push   %ebp
  8022a3:	89 e5                	mov    %esp,%ebp
  8022a5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022a8:	6a 00                	push   $0x0
  8022aa:	6a 00                	push   $0x0
  8022ac:	6a 00                	push   $0x0
  8022ae:	6a 00                	push   $0x0
  8022b0:	6a 00                	push   $0x0
  8022b2:	6a 2c                	push   $0x2c
  8022b4:	e8 4c fa ff ff       	call   801d05 <syscall>
  8022b9:	83 c4 18             	add    $0x18,%esp
  8022bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8022bf:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8022c3:	75 07                	jne    8022cc <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8022c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ca:	eb 05                	jmp    8022d1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8022cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022d1:	c9                   	leave  
  8022d2:	c3                   	ret    

008022d3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8022d3:	55                   	push   %ebp
  8022d4:	89 e5                	mov    %esp,%ebp
  8022d6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022d9:	6a 00                	push   $0x0
  8022db:	6a 00                	push   $0x0
  8022dd:	6a 00                	push   $0x0
  8022df:	6a 00                	push   $0x0
  8022e1:	6a 00                	push   $0x0
  8022e3:	6a 2c                	push   $0x2c
  8022e5:	e8 1b fa ff ff       	call   801d05 <syscall>
  8022ea:	83 c4 18             	add    $0x18,%esp
  8022ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8022f0:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8022f4:	75 07                	jne    8022fd <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8022f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8022fb:	eb 05                	jmp    802302 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8022fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802302:	c9                   	leave  
  802303:	c3                   	ret    

00802304 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802304:	55                   	push   %ebp
  802305:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802307:	6a 00                	push   $0x0
  802309:	6a 00                	push   $0x0
  80230b:	6a 00                	push   $0x0
  80230d:	6a 00                	push   $0x0
  80230f:	ff 75 08             	pushl  0x8(%ebp)
  802312:	6a 2d                	push   $0x2d
  802314:	e8 ec f9 ff ff       	call   801d05 <syscall>
  802319:	83 c4 18             	add    $0x18,%esp
	return ;
  80231c:	90                   	nop
}
  80231d:	c9                   	leave  
  80231e:	c3                   	ret    
  80231f:	90                   	nop

00802320 <__udivdi3>:
  802320:	55                   	push   %ebp
  802321:	57                   	push   %edi
  802322:	56                   	push   %esi
  802323:	53                   	push   %ebx
  802324:	83 ec 1c             	sub    $0x1c,%esp
  802327:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80232b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80232f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802333:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802337:	89 ca                	mov    %ecx,%edx
  802339:	89 f8                	mov    %edi,%eax
  80233b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80233f:	85 f6                	test   %esi,%esi
  802341:	75 2d                	jne    802370 <__udivdi3+0x50>
  802343:	39 cf                	cmp    %ecx,%edi
  802345:	77 65                	ja     8023ac <__udivdi3+0x8c>
  802347:	89 fd                	mov    %edi,%ebp
  802349:	85 ff                	test   %edi,%edi
  80234b:	75 0b                	jne    802358 <__udivdi3+0x38>
  80234d:	b8 01 00 00 00       	mov    $0x1,%eax
  802352:	31 d2                	xor    %edx,%edx
  802354:	f7 f7                	div    %edi
  802356:	89 c5                	mov    %eax,%ebp
  802358:	31 d2                	xor    %edx,%edx
  80235a:	89 c8                	mov    %ecx,%eax
  80235c:	f7 f5                	div    %ebp
  80235e:	89 c1                	mov    %eax,%ecx
  802360:	89 d8                	mov    %ebx,%eax
  802362:	f7 f5                	div    %ebp
  802364:	89 cf                	mov    %ecx,%edi
  802366:	89 fa                	mov    %edi,%edx
  802368:	83 c4 1c             	add    $0x1c,%esp
  80236b:	5b                   	pop    %ebx
  80236c:	5e                   	pop    %esi
  80236d:	5f                   	pop    %edi
  80236e:	5d                   	pop    %ebp
  80236f:	c3                   	ret    
  802370:	39 ce                	cmp    %ecx,%esi
  802372:	77 28                	ja     80239c <__udivdi3+0x7c>
  802374:	0f bd fe             	bsr    %esi,%edi
  802377:	83 f7 1f             	xor    $0x1f,%edi
  80237a:	75 40                	jne    8023bc <__udivdi3+0x9c>
  80237c:	39 ce                	cmp    %ecx,%esi
  80237e:	72 0a                	jb     80238a <__udivdi3+0x6a>
  802380:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802384:	0f 87 9e 00 00 00    	ja     802428 <__udivdi3+0x108>
  80238a:	b8 01 00 00 00       	mov    $0x1,%eax
  80238f:	89 fa                	mov    %edi,%edx
  802391:	83 c4 1c             	add    $0x1c,%esp
  802394:	5b                   	pop    %ebx
  802395:	5e                   	pop    %esi
  802396:	5f                   	pop    %edi
  802397:	5d                   	pop    %ebp
  802398:	c3                   	ret    
  802399:	8d 76 00             	lea    0x0(%esi),%esi
  80239c:	31 ff                	xor    %edi,%edi
  80239e:	31 c0                	xor    %eax,%eax
  8023a0:	89 fa                	mov    %edi,%edx
  8023a2:	83 c4 1c             	add    $0x1c,%esp
  8023a5:	5b                   	pop    %ebx
  8023a6:	5e                   	pop    %esi
  8023a7:	5f                   	pop    %edi
  8023a8:	5d                   	pop    %ebp
  8023a9:	c3                   	ret    
  8023aa:	66 90                	xchg   %ax,%ax
  8023ac:	89 d8                	mov    %ebx,%eax
  8023ae:	f7 f7                	div    %edi
  8023b0:	31 ff                	xor    %edi,%edi
  8023b2:	89 fa                	mov    %edi,%edx
  8023b4:	83 c4 1c             	add    $0x1c,%esp
  8023b7:	5b                   	pop    %ebx
  8023b8:	5e                   	pop    %esi
  8023b9:	5f                   	pop    %edi
  8023ba:	5d                   	pop    %ebp
  8023bb:	c3                   	ret    
  8023bc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023c1:	89 eb                	mov    %ebp,%ebx
  8023c3:	29 fb                	sub    %edi,%ebx
  8023c5:	89 f9                	mov    %edi,%ecx
  8023c7:	d3 e6                	shl    %cl,%esi
  8023c9:	89 c5                	mov    %eax,%ebp
  8023cb:	88 d9                	mov    %bl,%cl
  8023cd:	d3 ed                	shr    %cl,%ebp
  8023cf:	89 e9                	mov    %ebp,%ecx
  8023d1:	09 f1                	or     %esi,%ecx
  8023d3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023d7:	89 f9                	mov    %edi,%ecx
  8023d9:	d3 e0                	shl    %cl,%eax
  8023db:	89 c5                	mov    %eax,%ebp
  8023dd:	89 d6                	mov    %edx,%esi
  8023df:	88 d9                	mov    %bl,%cl
  8023e1:	d3 ee                	shr    %cl,%esi
  8023e3:	89 f9                	mov    %edi,%ecx
  8023e5:	d3 e2                	shl    %cl,%edx
  8023e7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023eb:	88 d9                	mov    %bl,%cl
  8023ed:	d3 e8                	shr    %cl,%eax
  8023ef:	09 c2                	or     %eax,%edx
  8023f1:	89 d0                	mov    %edx,%eax
  8023f3:	89 f2                	mov    %esi,%edx
  8023f5:	f7 74 24 0c          	divl   0xc(%esp)
  8023f9:	89 d6                	mov    %edx,%esi
  8023fb:	89 c3                	mov    %eax,%ebx
  8023fd:	f7 e5                	mul    %ebp
  8023ff:	39 d6                	cmp    %edx,%esi
  802401:	72 19                	jb     80241c <__udivdi3+0xfc>
  802403:	74 0b                	je     802410 <__udivdi3+0xf0>
  802405:	89 d8                	mov    %ebx,%eax
  802407:	31 ff                	xor    %edi,%edi
  802409:	e9 58 ff ff ff       	jmp    802366 <__udivdi3+0x46>
  80240e:	66 90                	xchg   %ax,%ax
  802410:	8b 54 24 08          	mov    0x8(%esp),%edx
  802414:	89 f9                	mov    %edi,%ecx
  802416:	d3 e2                	shl    %cl,%edx
  802418:	39 c2                	cmp    %eax,%edx
  80241a:	73 e9                	jae    802405 <__udivdi3+0xe5>
  80241c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80241f:	31 ff                	xor    %edi,%edi
  802421:	e9 40 ff ff ff       	jmp    802366 <__udivdi3+0x46>
  802426:	66 90                	xchg   %ax,%ax
  802428:	31 c0                	xor    %eax,%eax
  80242a:	e9 37 ff ff ff       	jmp    802366 <__udivdi3+0x46>
  80242f:	90                   	nop

00802430 <__umoddi3>:
  802430:	55                   	push   %ebp
  802431:	57                   	push   %edi
  802432:	56                   	push   %esi
  802433:	53                   	push   %ebx
  802434:	83 ec 1c             	sub    $0x1c,%esp
  802437:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80243b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80243f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802443:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802447:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80244b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80244f:	89 f3                	mov    %esi,%ebx
  802451:	89 fa                	mov    %edi,%edx
  802453:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802457:	89 34 24             	mov    %esi,(%esp)
  80245a:	85 c0                	test   %eax,%eax
  80245c:	75 1a                	jne    802478 <__umoddi3+0x48>
  80245e:	39 f7                	cmp    %esi,%edi
  802460:	0f 86 a2 00 00 00    	jbe    802508 <__umoddi3+0xd8>
  802466:	89 c8                	mov    %ecx,%eax
  802468:	89 f2                	mov    %esi,%edx
  80246a:	f7 f7                	div    %edi
  80246c:	89 d0                	mov    %edx,%eax
  80246e:	31 d2                	xor    %edx,%edx
  802470:	83 c4 1c             	add    $0x1c,%esp
  802473:	5b                   	pop    %ebx
  802474:	5e                   	pop    %esi
  802475:	5f                   	pop    %edi
  802476:	5d                   	pop    %ebp
  802477:	c3                   	ret    
  802478:	39 f0                	cmp    %esi,%eax
  80247a:	0f 87 ac 00 00 00    	ja     80252c <__umoddi3+0xfc>
  802480:	0f bd e8             	bsr    %eax,%ebp
  802483:	83 f5 1f             	xor    $0x1f,%ebp
  802486:	0f 84 ac 00 00 00    	je     802538 <__umoddi3+0x108>
  80248c:	bf 20 00 00 00       	mov    $0x20,%edi
  802491:	29 ef                	sub    %ebp,%edi
  802493:	89 fe                	mov    %edi,%esi
  802495:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802499:	89 e9                	mov    %ebp,%ecx
  80249b:	d3 e0                	shl    %cl,%eax
  80249d:	89 d7                	mov    %edx,%edi
  80249f:	89 f1                	mov    %esi,%ecx
  8024a1:	d3 ef                	shr    %cl,%edi
  8024a3:	09 c7                	or     %eax,%edi
  8024a5:	89 e9                	mov    %ebp,%ecx
  8024a7:	d3 e2                	shl    %cl,%edx
  8024a9:	89 14 24             	mov    %edx,(%esp)
  8024ac:	89 d8                	mov    %ebx,%eax
  8024ae:	d3 e0                	shl    %cl,%eax
  8024b0:	89 c2                	mov    %eax,%edx
  8024b2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024b6:	d3 e0                	shl    %cl,%eax
  8024b8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8024bc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024c0:	89 f1                	mov    %esi,%ecx
  8024c2:	d3 e8                	shr    %cl,%eax
  8024c4:	09 d0                	or     %edx,%eax
  8024c6:	d3 eb                	shr    %cl,%ebx
  8024c8:	89 da                	mov    %ebx,%edx
  8024ca:	f7 f7                	div    %edi
  8024cc:	89 d3                	mov    %edx,%ebx
  8024ce:	f7 24 24             	mull   (%esp)
  8024d1:	89 c6                	mov    %eax,%esi
  8024d3:	89 d1                	mov    %edx,%ecx
  8024d5:	39 d3                	cmp    %edx,%ebx
  8024d7:	0f 82 87 00 00 00    	jb     802564 <__umoddi3+0x134>
  8024dd:	0f 84 91 00 00 00    	je     802574 <__umoddi3+0x144>
  8024e3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024e7:	29 f2                	sub    %esi,%edx
  8024e9:	19 cb                	sbb    %ecx,%ebx
  8024eb:	89 d8                	mov    %ebx,%eax
  8024ed:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024f1:	d3 e0                	shl    %cl,%eax
  8024f3:	89 e9                	mov    %ebp,%ecx
  8024f5:	d3 ea                	shr    %cl,%edx
  8024f7:	09 d0                	or     %edx,%eax
  8024f9:	89 e9                	mov    %ebp,%ecx
  8024fb:	d3 eb                	shr    %cl,%ebx
  8024fd:	89 da                	mov    %ebx,%edx
  8024ff:	83 c4 1c             	add    $0x1c,%esp
  802502:	5b                   	pop    %ebx
  802503:	5e                   	pop    %esi
  802504:	5f                   	pop    %edi
  802505:	5d                   	pop    %ebp
  802506:	c3                   	ret    
  802507:	90                   	nop
  802508:	89 fd                	mov    %edi,%ebp
  80250a:	85 ff                	test   %edi,%edi
  80250c:	75 0b                	jne    802519 <__umoddi3+0xe9>
  80250e:	b8 01 00 00 00       	mov    $0x1,%eax
  802513:	31 d2                	xor    %edx,%edx
  802515:	f7 f7                	div    %edi
  802517:	89 c5                	mov    %eax,%ebp
  802519:	89 f0                	mov    %esi,%eax
  80251b:	31 d2                	xor    %edx,%edx
  80251d:	f7 f5                	div    %ebp
  80251f:	89 c8                	mov    %ecx,%eax
  802521:	f7 f5                	div    %ebp
  802523:	89 d0                	mov    %edx,%eax
  802525:	e9 44 ff ff ff       	jmp    80246e <__umoddi3+0x3e>
  80252a:	66 90                	xchg   %ax,%ax
  80252c:	89 c8                	mov    %ecx,%eax
  80252e:	89 f2                	mov    %esi,%edx
  802530:	83 c4 1c             	add    $0x1c,%esp
  802533:	5b                   	pop    %ebx
  802534:	5e                   	pop    %esi
  802535:	5f                   	pop    %edi
  802536:	5d                   	pop    %ebp
  802537:	c3                   	ret    
  802538:	3b 04 24             	cmp    (%esp),%eax
  80253b:	72 06                	jb     802543 <__umoddi3+0x113>
  80253d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802541:	77 0f                	ja     802552 <__umoddi3+0x122>
  802543:	89 f2                	mov    %esi,%edx
  802545:	29 f9                	sub    %edi,%ecx
  802547:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80254b:	89 14 24             	mov    %edx,(%esp)
  80254e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802552:	8b 44 24 04          	mov    0x4(%esp),%eax
  802556:	8b 14 24             	mov    (%esp),%edx
  802559:	83 c4 1c             	add    $0x1c,%esp
  80255c:	5b                   	pop    %ebx
  80255d:	5e                   	pop    %esi
  80255e:	5f                   	pop    %edi
  80255f:	5d                   	pop    %ebp
  802560:	c3                   	ret    
  802561:	8d 76 00             	lea    0x0(%esi),%esi
  802564:	2b 04 24             	sub    (%esp),%eax
  802567:	19 fa                	sbb    %edi,%edx
  802569:	89 d1                	mov    %edx,%ecx
  80256b:	89 c6                	mov    %eax,%esi
  80256d:	e9 71 ff ff ff       	jmp    8024e3 <__umoddi3+0xb3>
  802572:	66 90                	xchg   %ax,%ax
  802574:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802578:	72 ea                	jb     802564 <__umoddi3+0x134>
  80257a:	89 d9                	mov    %ebx,%ecx
  80257c:	e9 62 ff ff ff       	jmp    8024e3 <__umoddi3+0xb3>
