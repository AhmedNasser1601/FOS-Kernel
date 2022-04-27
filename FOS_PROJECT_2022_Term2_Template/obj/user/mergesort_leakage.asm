
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
  800041:	e8 94 1d 00 00       	call   801dda <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 20 24 80 00       	push   $0x802420
  80004e:	e8 19 0b 00 00       	call   800b6c <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 22 24 80 00       	push   $0x802422
  80005e:	e8 09 0b 00 00       	call   800b6c <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 38 24 80 00       	push   $0x802438
  80006e:	e8 f9 0a 00 00       	call   800b6c <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 22 24 80 00       	push   $0x802422
  80007e:	e8 e9 0a 00 00       	call   800b6c <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 20 24 80 00       	push   $0x802420
  80008e:	e8 d9 0a 00 00       	call   800b6c <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 50 24 80 00       	push   $0x802450
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
  8000de:	68 70 24 80 00       	push   $0x802470
  8000e3:	e8 84 0a 00 00       	call   800b6c <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 92 24 80 00       	push   $0x802492
  8000f3:	e8 74 0a 00 00       	call   800b6c <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 a0 24 80 00       	push   $0x8024a0
  800103:	e8 64 0a 00 00       	call   800b6c <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 af 24 80 00       	push   $0x8024af
  800113:	e8 54 0a 00 00       	call   800b6c <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 bf 24 80 00       	push   $0x8024bf
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
  800162:	e8 8d 1c 00 00       	call   801df4 <sys_enable_interrupt>

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
  8001d7:	e8 fe 1b 00 00       	call   801dda <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 c8 24 80 00       	push   $0x8024c8
  8001e4:	e8 83 09 00 00       	call   800b6c <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 03 1c 00 00       	call   801df4 <sys_enable_interrupt>

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
  80020e:	68 fc 24 80 00       	push   $0x8024fc
  800213:	6a 4a                	push   $0x4a
  800215:	68 1e 25 80 00       	push   $0x80251e
  80021a:	e8 99 06 00 00       	call   8008b8 <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 b6 1b 00 00       	call   801dda <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 38 25 80 00       	push   $0x802538
  80022c:	e8 3b 09 00 00       	call   800b6c <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 6c 25 80 00       	push   $0x80256c
  80023c:	e8 2b 09 00 00       	call   800b6c <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 a0 25 80 00       	push   $0x8025a0
  80024c:	e8 1b 09 00 00       	call   800b6c <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 9b 1b 00 00       	call   801df4 <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 ec 18 00 00       	call   801b50 <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 6e 1b 00 00       	call   801dda <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 d2 25 80 00       	push   $0x8025d2
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
  8002c0:	e8 2f 1b 00 00       	call   801df4 <sys_enable_interrupt>

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
  800454:	68 20 24 80 00       	push   $0x802420
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
  800476:	68 f0 25 80 00       	push   $0x8025f0
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
  8004a4:	68 f5 25 80 00       	push   $0x8025f5
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
  80071d:	e8 ec 16 00 00       	call   801e0e <sys_cputc>
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
  80072e:	e8 a7 16 00 00       	call   801dda <sys_disable_interrupt>
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
  800741:	e8 c8 16 00 00       	call   801e0e <sys_cputc>
  800746:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800749:	e8 a6 16 00 00       	call   801df4 <sys_enable_interrupt>
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
  800760:	e8 8d 14 00 00       	call   801bf2 <sys_cgetc>
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
  800779:	e8 5c 16 00 00       	call   801dda <sys_disable_interrupt>
	int c=0;
  80077e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800785:	eb 08                	jmp    80078f <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800787:	e8 66 14 00 00       	call   801bf2 <sys_cgetc>
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
  800795:	e8 5a 16 00 00       	call   801df4 <sys_enable_interrupt>
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
  8007af:	e8 8b 14 00 00       	call   801c3f <sys_getenvindex>
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
  8007da:	a3 08 30 80 00       	mov    %eax,0x803008

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007df:	a1 08 30 80 00       	mov    0x803008,%eax
  8007e4:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8007ea:	84 c0                	test   %al,%al
  8007ec:	74 0f                	je     8007fd <libmain+0x54>
		binaryname = myEnv->prog_name;
  8007ee:	a1 08 30 80 00       	mov    0x803008,%eax
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
  80081e:	e8 b7 15 00 00       	call   801dda <sys_disable_interrupt>
	cprintf("**************************************\n");
  800823:	83 ec 0c             	sub    $0xc,%esp
  800826:	68 14 26 80 00       	push   $0x802614
  80082b:	e8 3c 03 00 00       	call   800b6c <cprintf>
  800830:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800833:	a1 08 30 80 00       	mov    0x803008,%eax
  800838:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80083e:	a1 08 30 80 00       	mov    0x803008,%eax
  800843:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800849:	83 ec 04             	sub    $0x4,%esp
  80084c:	52                   	push   %edx
  80084d:	50                   	push   %eax
  80084e:	68 3c 26 80 00       	push   $0x80263c
  800853:	e8 14 03 00 00       	call   800b6c <cprintf>
  800858:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80085b:	a1 08 30 80 00       	mov    0x803008,%eax
  800860:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800866:	83 ec 08             	sub    $0x8,%esp
  800869:	50                   	push   %eax
  80086a:	68 61 26 80 00       	push   $0x802661
  80086f:	e8 f8 02 00 00       	call   800b6c <cprintf>
  800874:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800877:	83 ec 0c             	sub    $0xc,%esp
  80087a:	68 14 26 80 00       	push   $0x802614
  80087f:	e8 e8 02 00 00       	call   800b6c <cprintf>
  800884:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800887:	e8 68 15 00 00       	call   801df4 <sys_enable_interrupt>

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
  80089f:	e8 67 13 00 00       	call   801c0b <sys_env_destroy>
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
  8008b0:	e8 bc 13 00 00       	call   801c71 <sys_env_exit>
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
  8008c7:	a1 18 30 80 00       	mov    0x803018,%eax
  8008cc:	85 c0                	test   %eax,%eax
  8008ce:	74 16                	je     8008e6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008d0:	a1 18 30 80 00       	mov    0x803018,%eax
  8008d5:	83 ec 08             	sub    $0x8,%esp
  8008d8:	50                   	push   %eax
  8008d9:	68 78 26 80 00       	push   $0x802678
  8008de:	e8 89 02 00 00       	call   800b6c <cprintf>
  8008e3:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008e6:	a1 00 30 80 00       	mov    0x803000,%eax
  8008eb:	ff 75 0c             	pushl  0xc(%ebp)
  8008ee:	ff 75 08             	pushl  0x8(%ebp)
  8008f1:	50                   	push   %eax
  8008f2:	68 7d 26 80 00       	push   $0x80267d
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
  800916:	68 99 26 80 00       	push   $0x802699
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
  800930:	a1 08 30 80 00       	mov    0x803008,%eax
  800935:	8b 50 74             	mov    0x74(%eax),%edx
  800938:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093b:	39 c2                	cmp    %eax,%edx
  80093d:	74 14                	je     800953 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80093f:	83 ec 04             	sub    $0x4,%esp
  800942:	68 9c 26 80 00       	push   $0x80269c
  800947:	6a 26                	push   $0x26
  800949:	68 e8 26 80 00       	push   $0x8026e8
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
  800993:	a1 08 30 80 00       	mov    0x803008,%eax
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
  8009b3:	a1 08 30 80 00       	mov    0x803008,%eax
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
  8009fc:	a1 08 30 80 00       	mov    0x803008,%eax
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
  800a14:	68 f4 26 80 00       	push   $0x8026f4
  800a19:	6a 3a                	push   $0x3a
  800a1b:	68 e8 26 80 00       	push   $0x8026e8
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
  800a44:	a1 08 30 80 00       	mov    0x803008,%eax
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
  800a6a:	a1 08 30 80 00       	mov    0x803008,%eax
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
  800a84:	68 48 27 80 00       	push   $0x802748
  800a89:	6a 44                	push   $0x44
  800a8b:	68 e8 26 80 00       	push   $0x8026e8
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
  800ac3:	a0 0c 30 80 00       	mov    0x80300c,%al
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
  800ade:	e8 e6 10 00 00       	call   801bc9 <sys_cputs>
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
  800b38:	a0 0c 30 80 00       	mov    0x80300c,%al
  800b3d:	0f b6 c0             	movzbl %al,%eax
  800b40:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b46:	83 ec 04             	sub    $0x4,%esp
  800b49:	50                   	push   %eax
  800b4a:	52                   	push   %edx
  800b4b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b51:	83 c0 08             	add    $0x8,%eax
  800b54:	50                   	push   %eax
  800b55:	e8 6f 10 00 00       	call   801bc9 <sys_cputs>
  800b5a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b5d:	c6 05 0c 30 80 00 00 	movb   $0x0,0x80300c
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
  800b72:	c6 05 0c 30 80 00 01 	movb   $0x1,0x80300c
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
  800b9f:	e8 36 12 00 00       	call   801dda <sys_disable_interrupt>
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
  800bbf:	e8 30 12 00 00       	call   801df4 <sys_enable_interrupt>
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
  800c09:	e8 aa 15 00 00       	call   8021b8 <__udivdi3>
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
  800c59:	e8 6a 16 00 00       	call   8022c8 <__umoddi3>
  800c5e:	83 c4 10             	add    $0x10,%esp
  800c61:	05 b4 29 80 00       	add    $0x8029b4,%eax
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
  800db4:	8b 04 85 d8 29 80 00 	mov    0x8029d8(,%eax,4),%eax
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
  800e95:	8b 34 9d 20 28 80 00 	mov    0x802820(,%ebx,4),%esi
  800e9c:	85 f6                	test   %esi,%esi
  800e9e:	75 19                	jne    800eb9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ea0:	53                   	push   %ebx
  800ea1:	68 c5 29 80 00       	push   $0x8029c5
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
  800eba:	68 ce 29 80 00       	push   $0x8029ce
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
  800ee7:	be d1 29 80 00       	mov    $0x8029d1,%esi
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
  801200:	68 30 2b 80 00       	push   $0x802b30
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
  801242:	68 33 2b 80 00       	push   $0x802b33
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
  8012f2:	e8 e3 0a 00 00       	call   801dda <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8012f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012fb:	74 13                	je     801310 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8012fd:	83 ec 08             	sub    $0x8,%esp
  801300:	ff 75 08             	pushl  0x8(%ebp)
  801303:	68 30 2b 80 00       	push   $0x802b30
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
  801341:	68 33 2b 80 00       	push   $0x802b33
  801346:	e8 21 f8 ff ff       	call   800b6c <cprintf>
  80134b:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80134e:	e8 a1 0a 00 00       	call   801df4 <sys_enable_interrupt>
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
  8013e6:	e8 09 0a 00 00       	call   801df4 <sys_enable_interrupt>
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
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  801afc:	55                   	push   %ebp
  801afd:	89 e5                	mov    %esp,%ebp
  801aff:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801b02:	83 ec 04             	sub    $0x4,%esp
  801b05:	68 44 2b 80 00       	push   $0x802b44
  801b0a:	6a 19                	push   $0x19
  801b0c:	68 69 2b 80 00       	push   $0x802b69
  801b11:	e8 a2 ed ff ff       	call   8008b8 <_panic>

00801b16 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b16:	55                   	push   %ebp
  801b17:	89 e5                	mov    %esp,%ebp
  801b19:	83 ec 18             	sub    $0x18,%esp
  801b1c:	8b 45 10             	mov    0x10(%ebp),%eax
  801b1f:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801b22:	83 ec 04             	sub    $0x4,%esp
  801b25:	68 78 2b 80 00       	push   $0x802b78
  801b2a:	6a 30                	push   $0x30
  801b2c:	68 69 2b 80 00       	push   $0x802b69
  801b31:	e8 82 ed ff ff       	call   8008b8 <_panic>

00801b36 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b36:	55                   	push   %ebp
  801b37:	89 e5                	mov    %esp,%ebp
  801b39:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801b3c:	83 ec 04             	sub    $0x4,%esp
  801b3f:	68 97 2b 80 00       	push   $0x802b97
  801b44:	6a 36                	push   $0x36
  801b46:	68 69 2b 80 00       	push   $0x802b69
  801b4b:	e8 68 ed ff ff       	call   8008b8 <_panic>

00801b50 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b50:	55                   	push   %ebp
  801b51:	89 e5                	mov    %esp,%ebp
  801b53:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801b56:	83 ec 04             	sub    $0x4,%esp
  801b59:	68 b4 2b 80 00       	push   $0x802bb4
  801b5e:	6a 48                	push   $0x48
  801b60:	68 69 2b 80 00       	push   $0x802b69
  801b65:	e8 4e ed ff ff       	call   8008b8 <_panic>

00801b6a <sfree>:

}


void sfree(void* virtual_address)
{
  801b6a:	55                   	push   %ebp
  801b6b:	89 e5                	mov    %esp,%ebp
  801b6d:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801b70:	83 ec 04             	sub    $0x4,%esp
  801b73:	68 d7 2b 80 00       	push   $0x802bd7
  801b78:	6a 53                	push   $0x53
  801b7a:	68 69 2b 80 00       	push   $0x802b69
  801b7f:	e8 34 ed ff ff       	call   8008b8 <_panic>

00801b84 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b84:	55                   	push   %ebp
  801b85:	89 e5                	mov    %esp,%ebp
  801b87:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801b8a:	83 ec 04             	sub    $0x4,%esp
  801b8d:	68 f4 2b 80 00       	push   $0x802bf4
  801b92:	6a 6c                	push   $0x6c
  801b94:	68 69 2b 80 00       	push   $0x802b69
  801b99:	e8 1a ed ff ff       	call   8008b8 <_panic>

00801b9e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b9e:	55                   	push   %ebp
  801b9f:	89 e5                	mov    %esp,%ebp
  801ba1:	57                   	push   %edi
  801ba2:	56                   	push   %esi
  801ba3:	53                   	push   %ebx
  801ba4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  801baa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bb0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bb3:	8b 7d 18             	mov    0x18(%ebp),%edi
  801bb6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801bb9:	cd 30                	int    $0x30
  801bbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801bbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bc1:	83 c4 10             	add    $0x10,%esp
  801bc4:	5b                   	pop    %ebx
  801bc5:	5e                   	pop    %esi
  801bc6:	5f                   	pop    %edi
  801bc7:	5d                   	pop    %ebp
  801bc8:	c3                   	ret    

00801bc9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
  801bcc:	83 ec 04             	sub    $0x4,%esp
  801bcf:	8b 45 10             	mov    0x10(%ebp),%eax
  801bd2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801bd5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	52                   	push   %edx
  801be1:	ff 75 0c             	pushl  0xc(%ebp)
  801be4:	50                   	push   %eax
  801be5:	6a 00                	push   $0x0
  801be7:	e8 b2 ff ff ff       	call   801b9e <syscall>
  801bec:	83 c4 18             	add    $0x18,%esp
}
  801bef:	90                   	nop
  801bf0:	c9                   	leave  
  801bf1:	c3                   	ret    

00801bf2 <sys_cgetc>:

int
sys_cgetc(void)
{
  801bf2:	55                   	push   %ebp
  801bf3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 01                	push   $0x1
  801c01:	e8 98 ff ff ff       	call   801b9e <syscall>
  801c06:	83 c4 18             	add    $0x18,%esp
}
  801c09:	c9                   	leave  
  801c0a:	c3                   	ret    

00801c0b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c0b:	55                   	push   %ebp
  801c0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	50                   	push   %eax
  801c1a:	6a 05                	push   $0x5
  801c1c:	e8 7d ff ff ff       	call   801b9e <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
}
  801c24:	c9                   	leave  
  801c25:	c3                   	ret    

00801c26 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c26:	55                   	push   %ebp
  801c27:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 02                	push   $0x2
  801c35:	e8 64 ff ff ff       	call   801b9e <syscall>
  801c3a:	83 c4 18             	add    $0x18,%esp
}
  801c3d:	c9                   	leave  
  801c3e:	c3                   	ret    

00801c3f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 03                	push   $0x3
  801c4e:	e8 4b ff ff ff       	call   801b9e <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
}
  801c56:	c9                   	leave  
  801c57:	c3                   	ret    

00801c58 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c58:	55                   	push   %ebp
  801c59:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 04                	push   $0x4
  801c67:	e8 32 ff ff ff       	call   801b9e <syscall>
  801c6c:	83 c4 18             	add    $0x18,%esp
}
  801c6f:	c9                   	leave  
  801c70:	c3                   	ret    

00801c71 <sys_env_exit>:


void sys_env_exit(void)
{
  801c71:	55                   	push   %ebp
  801c72:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 06                	push   $0x6
  801c80:	e8 19 ff ff ff       	call   801b9e <syscall>
  801c85:	83 c4 18             	add    $0x18,%esp
}
  801c88:	90                   	nop
  801c89:	c9                   	leave  
  801c8a:	c3                   	ret    

00801c8b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c8b:	55                   	push   %ebp
  801c8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c91:	8b 45 08             	mov    0x8(%ebp),%eax
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	52                   	push   %edx
  801c9b:	50                   	push   %eax
  801c9c:	6a 07                	push   $0x7
  801c9e:	e8 fb fe ff ff       	call   801b9e <syscall>
  801ca3:	83 c4 18             	add    $0x18,%esp
}
  801ca6:	c9                   	leave  
  801ca7:	c3                   	ret    

00801ca8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ca8:	55                   	push   %ebp
  801ca9:	89 e5                	mov    %esp,%ebp
  801cab:	56                   	push   %esi
  801cac:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801cad:	8b 75 18             	mov    0x18(%ebp),%esi
  801cb0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cb3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbc:	56                   	push   %esi
  801cbd:	53                   	push   %ebx
  801cbe:	51                   	push   %ecx
  801cbf:	52                   	push   %edx
  801cc0:	50                   	push   %eax
  801cc1:	6a 08                	push   $0x8
  801cc3:	e8 d6 fe ff ff       	call   801b9e <syscall>
  801cc8:	83 c4 18             	add    $0x18,%esp
}
  801ccb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801cce:	5b                   	pop    %ebx
  801ccf:	5e                   	pop    %esi
  801cd0:	5d                   	pop    %ebp
  801cd1:	c3                   	ret    

00801cd2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801cd5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	52                   	push   %edx
  801ce2:	50                   	push   %eax
  801ce3:	6a 09                	push   $0x9
  801ce5:	e8 b4 fe ff ff       	call   801b9e <syscall>
  801cea:	83 c4 18             	add    $0x18,%esp
}
  801ced:	c9                   	leave  
  801cee:	c3                   	ret    

00801cef <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cef:	55                   	push   %ebp
  801cf0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	ff 75 0c             	pushl  0xc(%ebp)
  801cfb:	ff 75 08             	pushl  0x8(%ebp)
  801cfe:	6a 0a                	push   $0xa
  801d00:	e8 99 fe ff ff       	call   801b9e <syscall>
  801d05:	83 c4 18             	add    $0x18,%esp
}
  801d08:	c9                   	leave  
  801d09:	c3                   	ret    

00801d0a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d0a:	55                   	push   %ebp
  801d0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 0b                	push   $0xb
  801d19:	e8 80 fe ff ff       	call   801b9e <syscall>
  801d1e:	83 c4 18             	add    $0x18,%esp
}
  801d21:	c9                   	leave  
  801d22:	c3                   	ret    

00801d23 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d23:	55                   	push   %ebp
  801d24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 0c                	push   $0xc
  801d32:	e8 67 fe ff ff       	call   801b9e <syscall>
  801d37:	83 c4 18             	add    $0x18,%esp
}
  801d3a:	c9                   	leave  
  801d3b:	c3                   	ret    

00801d3c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 0d                	push   $0xd
  801d4b:	e8 4e fe ff ff       	call   801b9e <syscall>
  801d50:	83 c4 18             	add    $0x18,%esp
}
  801d53:	c9                   	leave  
  801d54:	c3                   	ret    

00801d55 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	ff 75 0c             	pushl  0xc(%ebp)
  801d61:	ff 75 08             	pushl  0x8(%ebp)
  801d64:	6a 11                	push   $0x11
  801d66:	e8 33 fe ff ff       	call   801b9e <syscall>
  801d6b:	83 c4 18             	add    $0x18,%esp
	return;
  801d6e:	90                   	nop
}
  801d6f:	c9                   	leave  
  801d70:	c3                   	ret    

00801d71 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d71:	55                   	push   %ebp
  801d72:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	ff 75 0c             	pushl  0xc(%ebp)
  801d7d:	ff 75 08             	pushl  0x8(%ebp)
  801d80:	6a 12                	push   $0x12
  801d82:	e8 17 fe ff ff       	call   801b9e <syscall>
  801d87:	83 c4 18             	add    $0x18,%esp
	return ;
  801d8a:	90                   	nop
}
  801d8b:	c9                   	leave  
  801d8c:	c3                   	ret    

00801d8d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 0e                	push   $0xe
  801d9c:	e8 fd fd ff ff       	call   801b9e <syscall>
  801da1:	83 c4 18             	add    $0x18,%esp
}
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	ff 75 08             	pushl  0x8(%ebp)
  801db4:	6a 0f                	push   $0xf
  801db6:	e8 e3 fd ff ff       	call   801b9e <syscall>
  801dbb:	83 c4 18             	add    $0x18,%esp
}
  801dbe:	c9                   	leave  
  801dbf:	c3                   	ret    

00801dc0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801dc0:	55                   	push   %ebp
  801dc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 10                	push   $0x10
  801dcf:	e8 ca fd ff ff       	call   801b9e <syscall>
  801dd4:	83 c4 18             	add    $0x18,%esp
}
  801dd7:	90                   	nop
  801dd8:	c9                   	leave  
  801dd9:	c3                   	ret    

00801dda <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801dda:	55                   	push   %ebp
  801ddb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 14                	push   $0x14
  801de9:	e8 b0 fd ff ff       	call   801b9e <syscall>
  801dee:	83 c4 18             	add    $0x18,%esp
}
  801df1:	90                   	nop
  801df2:	c9                   	leave  
  801df3:	c3                   	ret    

00801df4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 15                	push   $0x15
  801e03:	e8 96 fd ff ff       	call   801b9e <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
}
  801e0b:	90                   	nop
  801e0c:	c9                   	leave  
  801e0d:	c3                   	ret    

00801e0e <sys_cputc>:


void
sys_cputc(const char c)
{
  801e0e:	55                   	push   %ebp
  801e0f:	89 e5                	mov    %esp,%ebp
  801e11:	83 ec 04             	sub    $0x4,%esp
  801e14:	8b 45 08             	mov    0x8(%ebp),%eax
  801e17:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e1a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	50                   	push   %eax
  801e27:	6a 16                	push   $0x16
  801e29:	e8 70 fd ff ff       	call   801b9e <syscall>
  801e2e:	83 c4 18             	add    $0x18,%esp
}
  801e31:	90                   	nop
  801e32:	c9                   	leave  
  801e33:	c3                   	ret    

00801e34 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e34:	55                   	push   %ebp
  801e35:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 17                	push   $0x17
  801e43:	e8 56 fd ff ff       	call   801b9e <syscall>
  801e48:	83 c4 18             	add    $0x18,%esp
}
  801e4b:	90                   	nop
  801e4c:	c9                   	leave  
  801e4d:	c3                   	ret    

00801e4e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e4e:	55                   	push   %ebp
  801e4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e51:	8b 45 08             	mov    0x8(%ebp),%eax
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	ff 75 0c             	pushl  0xc(%ebp)
  801e5d:	50                   	push   %eax
  801e5e:	6a 18                	push   $0x18
  801e60:	e8 39 fd ff ff       	call   801b9e <syscall>
  801e65:	83 c4 18             	add    $0x18,%esp
}
  801e68:	c9                   	leave  
  801e69:	c3                   	ret    

00801e6a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e6a:	55                   	push   %ebp
  801e6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e70:	8b 45 08             	mov    0x8(%ebp),%eax
  801e73:	6a 00                	push   $0x0
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	52                   	push   %edx
  801e7a:	50                   	push   %eax
  801e7b:	6a 1b                	push   $0x1b
  801e7d:	e8 1c fd ff ff       	call   801b9e <syscall>
  801e82:	83 c4 18             	add    $0x18,%esp
}
  801e85:	c9                   	leave  
  801e86:	c3                   	ret    

00801e87 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e87:	55                   	push   %ebp
  801e88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	52                   	push   %edx
  801e97:	50                   	push   %eax
  801e98:	6a 19                	push   $0x19
  801e9a:	e8 ff fc ff ff       	call   801b9e <syscall>
  801e9f:	83 c4 18             	add    $0x18,%esp
}
  801ea2:	90                   	nop
  801ea3:	c9                   	leave  
  801ea4:	c3                   	ret    

00801ea5 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ea5:	55                   	push   %ebp
  801ea6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ea8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eab:	8b 45 08             	mov    0x8(%ebp),%eax
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	52                   	push   %edx
  801eb5:	50                   	push   %eax
  801eb6:	6a 1a                	push   $0x1a
  801eb8:	e8 e1 fc ff ff       	call   801b9e <syscall>
  801ebd:	83 c4 18             	add    $0x18,%esp
}
  801ec0:	90                   	nop
  801ec1:	c9                   	leave  
  801ec2:	c3                   	ret    

00801ec3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ec3:	55                   	push   %ebp
  801ec4:	89 e5                	mov    %esp,%ebp
  801ec6:	83 ec 04             	sub    $0x4,%esp
  801ec9:	8b 45 10             	mov    0x10(%ebp),%eax
  801ecc:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ecf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ed2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ed6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed9:	6a 00                	push   $0x0
  801edb:	51                   	push   %ecx
  801edc:	52                   	push   %edx
  801edd:	ff 75 0c             	pushl  0xc(%ebp)
  801ee0:	50                   	push   %eax
  801ee1:	6a 1c                	push   $0x1c
  801ee3:	e8 b6 fc ff ff       	call   801b9e <syscall>
  801ee8:	83 c4 18             	add    $0x18,%esp
}
  801eeb:	c9                   	leave  
  801eec:	c3                   	ret    

00801eed <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801eed:	55                   	push   %ebp
  801eee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ef0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	52                   	push   %edx
  801efd:	50                   	push   %eax
  801efe:	6a 1d                	push   $0x1d
  801f00:	e8 99 fc ff ff       	call   801b9e <syscall>
  801f05:	83 c4 18             	add    $0x18,%esp
}
  801f08:	c9                   	leave  
  801f09:	c3                   	ret    

00801f0a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f0a:	55                   	push   %ebp
  801f0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f0d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f10:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f13:	8b 45 08             	mov    0x8(%ebp),%eax
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	51                   	push   %ecx
  801f1b:	52                   	push   %edx
  801f1c:	50                   	push   %eax
  801f1d:	6a 1e                	push   $0x1e
  801f1f:	e8 7a fc ff ff       	call   801b9e <syscall>
  801f24:	83 c4 18             	add    $0x18,%esp
}
  801f27:	c9                   	leave  
  801f28:	c3                   	ret    

00801f29 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f29:	55                   	push   %ebp
  801f2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	52                   	push   %edx
  801f39:	50                   	push   %eax
  801f3a:	6a 1f                	push   $0x1f
  801f3c:	e8 5d fc ff ff       	call   801b9e <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
}
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 20                	push   $0x20
  801f55:	e8 44 fc ff ff       	call   801b9e <syscall>
  801f5a:	83 c4 18             	add    $0x18,%esp
}
  801f5d:	c9                   	leave  
  801f5e:	c3                   	ret    

00801f5f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801f5f:	55                   	push   %ebp
  801f60:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801f62:	8b 45 08             	mov    0x8(%ebp),%eax
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	ff 75 10             	pushl  0x10(%ebp)
  801f6c:	ff 75 0c             	pushl  0xc(%ebp)
  801f6f:	50                   	push   %eax
  801f70:	6a 21                	push   $0x21
  801f72:	e8 27 fc ff ff       	call   801b9e <syscall>
  801f77:	83 c4 18             	add    $0x18,%esp
}
  801f7a:	c9                   	leave  
  801f7b:	c3                   	ret    

00801f7c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f7c:	55                   	push   %ebp
  801f7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	6a 00                	push   $0x0
  801f8a:	50                   	push   %eax
  801f8b:	6a 22                	push   $0x22
  801f8d:	e8 0c fc ff ff       	call   801b9e <syscall>
  801f92:	83 c4 18             	add    $0x18,%esp
}
  801f95:	90                   	nop
  801f96:	c9                   	leave  
  801f97:	c3                   	ret    

00801f98 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f98:	55                   	push   %ebp
  801f99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	50                   	push   %eax
  801fa7:	6a 23                	push   $0x23
  801fa9:	e8 f0 fb ff ff       	call   801b9e <syscall>
  801fae:	83 c4 18             	add    $0x18,%esp
}
  801fb1:	90                   	nop
  801fb2:	c9                   	leave  
  801fb3:	c3                   	ret    

00801fb4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801fb4:	55                   	push   %ebp
  801fb5:	89 e5                	mov    %esp,%ebp
  801fb7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801fba:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fbd:	8d 50 04             	lea    0x4(%eax),%edx
  801fc0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	52                   	push   %edx
  801fca:	50                   	push   %eax
  801fcb:	6a 24                	push   $0x24
  801fcd:	e8 cc fb ff ff       	call   801b9e <syscall>
  801fd2:	83 c4 18             	add    $0x18,%esp
	return result;
  801fd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801fd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fdb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fde:	89 01                	mov    %eax,(%ecx)
  801fe0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe6:	c9                   	leave  
  801fe7:	c2 04 00             	ret    $0x4

00801fea <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fea:	55                   	push   %ebp
  801feb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	ff 75 10             	pushl  0x10(%ebp)
  801ff4:	ff 75 0c             	pushl  0xc(%ebp)
  801ff7:	ff 75 08             	pushl  0x8(%ebp)
  801ffa:	6a 13                	push   $0x13
  801ffc:	e8 9d fb ff ff       	call   801b9e <syscall>
  802001:	83 c4 18             	add    $0x18,%esp
	return ;
  802004:	90                   	nop
}
  802005:	c9                   	leave  
  802006:	c3                   	ret    

00802007 <sys_rcr2>:
uint32 sys_rcr2()
{
  802007:	55                   	push   %ebp
  802008:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 25                	push   $0x25
  802016:	e8 83 fb ff ff       	call   801b9e <syscall>
  80201b:	83 c4 18             	add    $0x18,%esp
}
  80201e:	c9                   	leave  
  80201f:	c3                   	ret    

00802020 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802020:	55                   	push   %ebp
  802021:	89 e5                	mov    %esp,%ebp
  802023:	83 ec 04             	sub    $0x4,%esp
  802026:	8b 45 08             	mov    0x8(%ebp),%eax
  802029:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80202c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	50                   	push   %eax
  802039:	6a 26                	push   $0x26
  80203b:	e8 5e fb ff ff       	call   801b9e <syscall>
  802040:	83 c4 18             	add    $0x18,%esp
	return ;
  802043:	90                   	nop
}
  802044:	c9                   	leave  
  802045:	c3                   	ret    

00802046 <rsttst>:
void rsttst()
{
  802046:	55                   	push   %ebp
  802047:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	6a 28                	push   $0x28
  802055:	e8 44 fb ff ff       	call   801b9e <syscall>
  80205a:	83 c4 18             	add    $0x18,%esp
	return ;
  80205d:	90                   	nop
}
  80205e:	c9                   	leave  
  80205f:	c3                   	ret    

00802060 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802060:	55                   	push   %ebp
  802061:	89 e5                	mov    %esp,%ebp
  802063:	83 ec 04             	sub    $0x4,%esp
  802066:	8b 45 14             	mov    0x14(%ebp),%eax
  802069:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80206c:	8b 55 18             	mov    0x18(%ebp),%edx
  80206f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802073:	52                   	push   %edx
  802074:	50                   	push   %eax
  802075:	ff 75 10             	pushl  0x10(%ebp)
  802078:	ff 75 0c             	pushl  0xc(%ebp)
  80207b:	ff 75 08             	pushl  0x8(%ebp)
  80207e:	6a 27                	push   $0x27
  802080:	e8 19 fb ff ff       	call   801b9e <syscall>
  802085:	83 c4 18             	add    $0x18,%esp
	return ;
  802088:	90                   	nop
}
  802089:	c9                   	leave  
  80208a:	c3                   	ret    

0080208b <chktst>:
void chktst(uint32 n)
{
  80208b:	55                   	push   %ebp
  80208c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	ff 75 08             	pushl  0x8(%ebp)
  802099:	6a 29                	push   $0x29
  80209b:	e8 fe fa ff ff       	call   801b9e <syscall>
  8020a0:	83 c4 18             	add    $0x18,%esp
	return ;
  8020a3:	90                   	nop
}
  8020a4:	c9                   	leave  
  8020a5:	c3                   	ret    

008020a6 <inctst>:

void inctst()
{
  8020a6:	55                   	push   %ebp
  8020a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 2a                	push   $0x2a
  8020b5:	e8 e4 fa ff ff       	call   801b9e <syscall>
  8020ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8020bd:	90                   	nop
}
  8020be:	c9                   	leave  
  8020bf:	c3                   	ret    

008020c0 <gettst>:
uint32 gettst()
{
  8020c0:	55                   	push   %ebp
  8020c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 2b                	push   $0x2b
  8020cf:	e8 ca fa ff ff       	call   801b9e <syscall>
  8020d4:	83 c4 18             	add    $0x18,%esp
}
  8020d7:	c9                   	leave  
  8020d8:	c3                   	ret    

008020d9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020d9:	55                   	push   %ebp
  8020da:	89 e5                	mov    %esp,%ebp
  8020dc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 2c                	push   $0x2c
  8020eb:	e8 ae fa ff ff       	call   801b9e <syscall>
  8020f0:	83 c4 18             	add    $0x18,%esp
  8020f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8020f6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8020fa:	75 07                	jne    802103 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020fc:	b8 01 00 00 00       	mov    $0x1,%eax
  802101:	eb 05                	jmp    802108 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802103:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802108:	c9                   	leave  
  802109:	c3                   	ret    

0080210a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80210a:	55                   	push   %ebp
  80210b:	89 e5                	mov    %esp,%ebp
  80210d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	6a 2c                	push   $0x2c
  80211c:	e8 7d fa ff ff       	call   801b9e <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
  802124:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802127:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80212b:	75 07                	jne    802134 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80212d:	b8 01 00 00 00       	mov    $0x1,%eax
  802132:	eb 05                	jmp    802139 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802134:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802139:	c9                   	leave  
  80213a:	c3                   	ret    

0080213b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80213b:	55                   	push   %ebp
  80213c:	89 e5                	mov    %esp,%ebp
  80213e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	6a 00                	push   $0x0
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 2c                	push   $0x2c
  80214d:	e8 4c fa ff ff       	call   801b9e <syscall>
  802152:	83 c4 18             	add    $0x18,%esp
  802155:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802158:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80215c:	75 07                	jne    802165 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80215e:	b8 01 00 00 00       	mov    $0x1,%eax
  802163:	eb 05                	jmp    80216a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802165:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80216a:	c9                   	leave  
  80216b:	c3                   	ret    

0080216c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80216c:	55                   	push   %ebp
  80216d:	89 e5                	mov    %esp,%ebp
  80216f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 2c                	push   $0x2c
  80217e:	e8 1b fa ff ff       	call   801b9e <syscall>
  802183:	83 c4 18             	add    $0x18,%esp
  802186:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802189:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80218d:	75 07                	jne    802196 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80218f:	b8 01 00 00 00       	mov    $0x1,%eax
  802194:	eb 05                	jmp    80219b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802196:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80219b:	c9                   	leave  
  80219c:	c3                   	ret    

0080219d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80219d:	55                   	push   %ebp
  80219e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	ff 75 08             	pushl  0x8(%ebp)
  8021ab:	6a 2d                	push   $0x2d
  8021ad:	e8 ec f9 ff ff       	call   801b9e <syscall>
  8021b2:	83 c4 18             	add    $0x18,%esp
	return ;
  8021b5:	90                   	nop
}
  8021b6:	c9                   	leave  
  8021b7:	c3                   	ret    

008021b8 <__udivdi3>:
  8021b8:	55                   	push   %ebp
  8021b9:	57                   	push   %edi
  8021ba:	56                   	push   %esi
  8021bb:	53                   	push   %ebx
  8021bc:	83 ec 1c             	sub    $0x1c,%esp
  8021bf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021c3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021cf:	89 ca                	mov    %ecx,%edx
  8021d1:	89 f8                	mov    %edi,%eax
  8021d3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021d7:	85 f6                	test   %esi,%esi
  8021d9:	75 2d                	jne    802208 <__udivdi3+0x50>
  8021db:	39 cf                	cmp    %ecx,%edi
  8021dd:	77 65                	ja     802244 <__udivdi3+0x8c>
  8021df:	89 fd                	mov    %edi,%ebp
  8021e1:	85 ff                	test   %edi,%edi
  8021e3:	75 0b                	jne    8021f0 <__udivdi3+0x38>
  8021e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ea:	31 d2                	xor    %edx,%edx
  8021ec:	f7 f7                	div    %edi
  8021ee:	89 c5                	mov    %eax,%ebp
  8021f0:	31 d2                	xor    %edx,%edx
  8021f2:	89 c8                	mov    %ecx,%eax
  8021f4:	f7 f5                	div    %ebp
  8021f6:	89 c1                	mov    %eax,%ecx
  8021f8:	89 d8                	mov    %ebx,%eax
  8021fa:	f7 f5                	div    %ebp
  8021fc:	89 cf                	mov    %ecx,%edi
  8021fe:	89 fa                	mov    %edi,%edx
  802200:	83 c4 1c             	add    $0x1c,%esp
  802203:	5b                   	pop    %ebx
  802204:	5e                   	pop    %esi
  802205:	5f                   	pop    %edi
  802206:	5d                   	pop    %ebp
  802207:	c3                   	ret    
  802208:	39 ce                	cmp    %ecx,%esi
  80220a:	77 28                	ja     802234 <__udivdi3+0x7c>
  80220c:	0f bd fe             	bsr    %esi,%edi
  80220f:	83 f7 1f             	xor    $0x1f,%edi
  802212:	75 40                	jne    802254 <__udivdi3+0x9c>
  802214:	39 ce                	cmp    %ecx,%esi
  802216:	72 0a                	jb     802222 <__udivdi3+0x6a>
  802218:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80221c:	0f 87 9e 00 00 00    	ja     8022c0 <__udivdi3+0x108>
  802222:	b8 01 00 00 00       	mov    $0x1,%eax
  802227:	89 fa                	mov    %edi,%edx
  802229:	83 c4 1c             	add    $0x1c,%esp
  80222c:	5b                   	pop    %ebx
  80222d:	5e                   	pop    %esi
  80222e:	5f                   	pop    %edi
  80222f:	5d                   	pop    %ebp
  802230:	c3                   	ret    
  802231:	8d 76 00             	lea    0x0(%esi),%esi
  802234:	31 ff                	xor    %edi,%edi
  802236:	31 c0                	xor    %eax,%eax
  802238:	89 fa                	mov    %edi,%edx
  80223a:	83 c4 1c             	add    $0x1c,%esp
  80223d:	5b                   	pop    %ebx
  80223e:	5e                   	pop    %esi
  80223f:	5f                   	pop    %edi
  802240:	5d                   	pop    %ebp
  802241:	c3                   	ret    
  802242:	66 90                	xchg   %ax,%ax
  802244:	89 d8                	mov    %ebx,%eax
  802246:	f7 f7                	div    %edi
  802248:	31 ff                	xor    %edi,%edi
  80224a:	89 fa                	mov    %edi,%edx
  80224c:	83 c4 1c             	add    $0x1c,%esp
  80224f:	5b                   	pop    %ebx
  802250:	5e                   	pop    %esi
  802251:	5f                   	pop    %edi
  802252:	5d                   	pop    %ebp
  802253:	c3                   	ret    
  802254:	bd 20 00 00 00       	mov    $0x20,%ebp
  802259:	89 eb                	mov    %ebp,%ebx
  80225b:	29 fb                	sub    %edi,%ebx
  80225d:	89 f9                	mov    %edi,%ecx
  80225f:	d3 e6                	shl    %cl,%esi
  802261:	89 c5                	mov    %eax,%ebp
  802263:	88 d9                	mov    %bl,%cl
  802265:	d3 ed                	shr    %cl,%ebp
  802267:	89 e9                	mov    %ebp,%ecx
  802269:	09 f1                	or     %esi,%ecx
  80226b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80226f:	89 f9                	mov    %edi,%ecx
  802271:	d3 e0                	shl    %cl,%eax
  802273:	89 c5                	mov    %eax,%ebp
  802275:	89 d6                	mov    %edx,%esi
  802277:	88 d9                	mov    %bl,%cl
  802279:	d3 ee                	shr    %cl,%esi
  80227b:	89 f9                	mov    %edi,%ecx
  80227d:	d3 e2                	shl    %cl,%edx
  80227f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802283:	88 d9                	mov    %bl,%cl
  802285:	d3 e8                	shr    %cl,%eax
  802287:	09 c2                	or     %eax,%edx
  802289:	89 d0                	mov    %edx,%eax
  80228b:	89 f2                	mov    %esi,%edx
  80228d:	f7 74 24 0c          	divl   0xc(%esp)
  802291:	89 d6                	mov    %edx,%esi
  802293:	89 c3                	mov    %eax,%ebx
  802295:	f7 e5                	mul    %ebp
  802297:	39 d6                	cmp    %edx,%esi
  802299:	72 19                	jb     8022b4 <__udivdi3+0xfc>
  80229b:	74 0b                	je     8022a8 <__udivdi3+0xf0>
  80229d:	89 d8                	mov    %ebx,%eax
  80229f:	31 ff                	xor    %edi,%edi
  8022a1:	e9 58 ff ff ff       	jmp    8021fe <__udivdi3+0x46>
  8022a6:	66 90                	xchg   %ax,%ax
  8022a8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022ac:	89 f9                	mov    %edi,%ecx
  8022ae:	d3 e2                	shl    %cl,%edx
  8022b0:	39 c2                	cmp    %eax,%edx
  8022b2:	73 e9                	jae    80229d <__udivdi3+0xe5>
  8022b4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022b7:	31 ff                	xor    %edi,%edi
  8022b9:	e9 40 ff ff ff       	jmp    8021fe <__udivdi3+0x46>
  8022be:	66 90                	xchg   %ax,%ax
  8022c0:	31 c0                	xor    %eax,%eax
  8022c2:	e9 37 ff ff ff       	jmp    8021fe <__udivdi3+0x46>
  8022c7:	90                   	nop

008022c8 <__umoddi3>:
  8022c8:	55                   	push   %ebp
  8022c9:	57                   	push   %edi
  8022ca:	56                   	push   %esi
  8022cb:	53                   	push   %ebx
  8022cc:	83 ec 1c             	sub    $0x1c,%esp
  8022cf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022d3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022db:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022df:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022e3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022e7:	89 f3                	mov    %esi,%ebx
  8022e9:	89 fa                	mov    %edi,%edx
  8022eb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022ef:	89 34 24             	mov    %esi,(%esp)
  8022f2:	85 c0                	test   %eax,%eax
  8022f4:	75 1a                	jne    802310 <__umoddi3+0x48>
  8022f6:	39 f7                	cmp    %esi,%edi
  8022f8:	0f 86 a2 00 00 00    	jbe    8023a0 <__umoddi3+0xd8>
  8022fe:	89 c8                	mov    %ecx,%eax
  802300:	89 f2                	mov    %esi,%edx
  802302:	f7 f7                	div    %edi
  802304:	89 d0                	mov    %edx,%eax
  802306:	31 d2                	xor    %edx,%edx
  802308:	83 c4 1c             	add    $0x1c,%esp
  80230b:	5b                   	pop    %ebx
  80230c:	5e                   	pop    %esi
  80230d:	5f                   	pop    %edi
  80230e:	5d                   	pop    %ebp
  80230f:	c3                   	ret    
  802310:	39 f0                	cmp    %esi,%eax
  802312:	0f 87 ac 00 00 00    	ja     8023c4 <__umoddi3+0xfc>
  802318:	0f bd e8             	bsr    %eax,%ebp
  80231b:	83 f5 1f             	xor    $0x1f,%ebp
  80231e:	0f 84 ac 00 00 00    	je     8023d0 <__umoddi3+0x108>
  802324:	bf 20 00 00 00       	mov    $0x20,%edi
  802329:	29 ef                	sub    %ebp,%edi
  80232b:	89 fe                	mov    %edi,%esi
  80232d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802331:	89 e9                	mov    %ebp,%ecx
  802333:	d3 e0                	shl    %cl,%eax
  802335:	89 d7                	mov    %edx,%edi
  802337:	89 f1                	mov    %esi,%ecx
  802339:	d3 ef                	shr    %cl,%edi
  80233b:	09 c7                	or     %eax,%edi
  80233d:	89 e9                	mov    %ebp,%ecx
  80233f:	d3 e2                	shl    %cl,%edx
  802341:	89 14 24             	mov    %edx,(%esp)
  802344:	89 d8                	mov    %ebx,%eax
  802346:	d3 e0                	shl    %cl,%eax
  802348:	89 c2                	mov    %eax,%edx
  80234a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80234e:	d3 e0                	shl    %cl,%eax
  802350:	89 44 24 04          	mov    %eax,0x4(%esp)
  802354:	8b 44 24 08          	mov    0x8(%esp),%eax
  802358:	89 f1                	mov    %esi,%ecx
  80235a:	d3 e8                	shr    %cl,%eax
  80235c:	09 d0                	or     %edx,%eax
  80235e:	d3 eb                	shr    %cl,%ebx
  802360:	89 da                	mov    %ebx,%edx
  802362:	f7 f7                	div    %edi
  802364:	89 d3                	mov    %edx,%ebx
  802366:	f7 24 24             	mull   (%esp)
  802369:	89 c6                	mov    %eax,%esi
  80236b:	89 d1                	mov    %edx,%ecx
  80236d:	39 d3                	cmp    %edx,%ebx
  80236f:	0f 82 87 00 00 00    	jb     8023fc <__umoddi3+0x134>
  802375:	0f 84 91 00 00 00    	je     80240c <__umoddi3+0x144>
  80237b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80237f:	29 f2                	sub    %esi,%edx
  802381:	19 cb                	sbb    %ecx,%ebx
  802383:	89 d8                	mov    %ebx,%eax
  802385:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802389:	d3 e0                	shl    %cl,%eax
  80238b:	89 e9                	mov    %ebp,%ecx
  80238d:	d3 ea                	shr    %cl,%edx
  80238f:	09 d0                	or     %edx,%eax
  802391:	89 e9                	mov    %ebp,%ecx
  802393:	d3 eb                	shr    %cl,%ebx
  802395:	89 da                	mov    %ebx,%edx
  802397:	83 c4 1c             	add    $0x1c,%esp
  80239a:	5b                   	pop    %ebx
  80239b:	5e                   	pop    %esi
  80239c:	5f                   	pop    %edi
  80239d:	5d                   	pop    %ebp
  80239e:	c3                   	ret    
  80239f:	90                   	nop
  8023a0:	89 fd                	mov    %edi,%ebp
  8023a2:	85 ff                	test   %edi,%edi
  8023a4:	75 0b                	jne    8023b1 <__umoddi3+0xe9>
  8023a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8023ab:	31 d2                	xor    %edx,%edx
  8023ad:	f7 f7                	div    %edi
  8023af:	89 c5                	mov    %eax,%ebp
  8023b1:	89 f0                	mov    %esi,%eax
  8023b3:	31 d2                	xor    %edx,%edx
  8023b5:	f7 f5                	div    %ebp
  8023b7:	89 c8                	mov    %ecx,%eax
  8023b9:	f7 f5                	div    %ebp
  8023bb:	89 d0                	mov    %edx,%eax
  8023bd:	e9 44 ff ff ff       	jmp    802306 <__umoddi3+0x3e>
  8023c2:	66 90                	xchg   %ax,%ax
  8023c4:	89 c8                	mov    %ecx,%eax
  8023c6:	89 f2                	mov    %esi,%edx
  8023c8:	83 c4 1c             	add    $0x1c,%esp
  8023cb:	5b                   	pop    %ebx
  8023cc:	5e                   	pop    %esi
  8023cd:	5f                   	pop    %edi
  8023ce:	5d                   	pop    %ebp
  8023cf:	c3                   	ret    
  8023d0:	3b 04 24             	cmp    (%esp),%eax
  8023d3:	72 06                	jb     8023db <__umoddi3+0x113>
  8023d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023d9:	77 0f                	ja     8023ea <__umoddi3+0x122>
  8023db:	89 f2                	mov    %esi,%edx
  8023dd:	29 f9                	sub    %edi,%ecx
  8023df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023e3:	89 14 24             	mov    %edx,(%esp)
  8023e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023ee:	8b 14 24             	mov    (%esp),%edx
  8023f1:	83 c4 1c             	add    $0x1c,%esp
  8023f4:	5b                   	pop    %ebx
  8023f5:	5e                   	pop    %esi
  8023f6:	5f                   	pop    %edi
  8023f7:	5d                   	pop    %ebp
  8023f8:	c3                   	ret    
  8023f9:	8d 76 00             	lea    0x0(%esi),%esi
  8023fc:	2b 04 24             	sub    (%esp),%eax
  8023ff:	19 fa                	sbb    %edi,%edx
  802401:	89 d1                	mov    %edx,%ecx
  802403:	89 c6                	mov    %eax,%esi
  802405:	e9 71 ff ff ff       	jmp    80237b <__umoddi3+0xb3>
  80240a:	66 90                	xchg   %ax,%ax
  80240c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802410:	72 ea                	jb     8023fc <__umoddi3+0x134>
  802412:	89 d9                	mov    %ebx,%ecx
  802414:	e9 62 ff ff ff       	jmp    80237b <__umoddi3+0xb3>
