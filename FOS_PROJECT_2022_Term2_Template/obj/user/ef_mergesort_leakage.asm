
obj/user/ef_mergesort_leakage:     file format elf32-i386


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
  800031:	e8 a8 07 00 00       	call   8007de <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	char Line[255] ;
	char Chose ;
	int numOfRep = 0;
  800041:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	do
	{
		numOfRep++ ;
  800048:	ff 45 f0             	incl   -0x10(%ebp)
		//2012: lock the interrupt
		sys_disable_interrupt();
  80004b:	e8 b6 1d 00 00       	call   801e06 <sys_disable_interrupt>

		cprintf("\n");
  800050:	83 ec 0c             	sub    $0xc,%esp
  800053:	68 60 24 80 00       	push   $0x802460
  800058:	e8 44 0b 00 00       	call   800ba1 <cprintf>
  80005d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	68 62 24 80 00       	push   $0x802462
  800068:	e8 34 0b 00 00       	call   800ba1 <cprintf>
  80006d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	68 78 24 80 00       	push   $0x802478
  800078:	e8 24 0b 00 00       	call   800ba1 <cprintf>
  80007d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 62 24 80 00       	push   $0x802462
  800088:	e8 14 0b 00 00       	call   800ba1 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	68 60 24 80 00       	push   $0x802460
  800098:	e8 04 0b 00 00       	call   800ba1 <cprintf>
  80009d:	83 c4 10             	add    $0x10,%esp
		cprintf("Enter the number of elements: ");
  8000a0:	83 ec 0c             	sub    $0xc,%esp
  8000a3:	68 90 24 80 00       	push   $0x802490
  8000a8:	e8 f4 0a 00 00       	call   800ba1 <cprintf>
  8000ad:	83 c4 10             	add    $0x10,%esp

		int NumOfElements ;

		if (numOfRep == 1)
  8000b0:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  8000b4:	75 09                	jne    8000bf <_main+0x87>
			NumOfElements = 32;
  8000b6:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%ebp)
  8000bd:	eb 0d                	jmp    8000cc <_main+0x94>
		else if (numOfRep == 2)
  8000bf:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8000c3:	75 07                	jne    8000cc <_main+0x94>
			NumOfElements = 32;
  8000c5:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%ebp)

		cprintf("%d\n", NumOfElements) ;
  8000cc:	83 ec 08             	sub    $0x8,%esp
  8000cf:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d2:	68 af 24 80 00       	push   $0x8024af
  8000d7:	e8 c5 0a 00 00       	call   800ba1 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e2:	c1 e0 02             	shl    $0x2,%eax
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	50                   	push   %eax
  8000e9:	e8 3d 18 00 00       	call   80192b <malloc>
  8000ee:	83 c4 10             	add    $0x10,%esp
  8000f1:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	68 b4 24 80 00       	push   $0x8024b4
  8000fc:	e8 a0 0a 00 00       	call   800ba1 <cprintf>
  800101:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	68 d6 24 80 00       	push   $0x8024d6
  80010c:	e8 90 0a 00 00       	call   800ba1 <cprintf>
  800111:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	68 e4 24 80 00       	push   $0x8024e4
  80011c:	e8 80 0a 00 00       	call   800ba1 <cprintf>
  800121:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800124:	83 ec 0c             	sub    $0xc,%esp
  800127:	68 f3 24 80 00       	push   $0x8024f3
  80012c:	e8 70 0a 00 00       	call   800ba1 <cprintf>
  800131:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	68 03 25 80 00       	push   $0x802503
  80013c:	e8 60 0a 00 00       	call   800ba1 <cprintf>
  800141:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  800144:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  800148:	75 06                	jne    800150 <_main+0x118>
				Chose = 'a' ;
  80014a:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
  80014e:	eb 0a                	jmp    80015a <_main+0x122>
			else if (numOfRep == 2)
  800150:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  800154:	75 04                	jne    80015a <_main+0x122>
				Chose = 'c' ;
  800156:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
			cputchar(Chose);
  80015a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80015e:	83 ec 0c             	sub    $0xc,%esp
  800161:	50                   	push   %eax
  800162:	e8 d7 05 00 00       	call   80073e <cputchar>
  800167:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80016a:	83 ec 0c             	sub    $0xc,%esp
  80016d:	6a 0a                	push   $0xa
  80016f:	e8 ca 05 00 00       	call   80073e <cputchar>
  800174:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800177:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80017b:	74 0c                	je     800189 <_main+0x151>
  80017d:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800181:	74 06                	je     800189 <_main+0x151>
  800183:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800187:	75 ab                	jne    800134 <_main+0xfc>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800189:	e8 92 1c 00 00       	call   801e20 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  80018e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800192:	83 f8 62             	cmp    $0x62,%eax
  800195:	74 1d                	je     8001b4 <_main+0x17c>
  800197:	83 f8 63             	cmp    $0x63,%eax
  80019a:	74 2b                	je     8001c7 <_main+0x18f>
  80019c:	83 f8 61             	cmp    $0x61,%eax
  80019f:	75 39                	jne    8001da <_main+0x1a2>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  8001a1:	83 ec 08             	sub    $0x8,%esp
  8001a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001aa:	e8 02 02 00 00       	call   8003b1 <InitializeAscending>
  8001af:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b2:	eb 37                	jmp    8001eb <_main+0x1b3>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b4:	83 ec 08             	sub    $0x8,%esp
  8001b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ba:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bd:	e8 20 02 00 00       	call   8003e2 <InitializeDescending>
  8001c2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c5:	eb 24                	jmp    8001eb <_main+0x1b3>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	ff 75 e8             	pushl  -0x18(%ebp)
  8001d0:	e8 42 02 00 00       	call   800417 <InitializeSemiRandom>
  8001d5:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d8:	eb 11                	jmp    8001eb <_main+0x1b3>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001da:	83 ec 08             	sub    $0x8,%esp
  8001dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e0:	ff 75 e8             	pushl  -0x18(%ebp)
  8001e3:	e8 2f 02 00 00       	call   800417 <InitializeSemiRandom>
  8001e8:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001eb:	83 ec 04             	sub    $0x4,%esp
  8001ee:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f1:	6a 01                	push   $0x1
  8001f3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001f6:	e8 ee 02 00 00       	call   8004e9 <MSort>
  8001fb:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001fe:	e8 03 1c 00 00       	call   801e06 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  800203:	83 ec 0c             	sub    $0xc,%esp
  800206:	68 0c 25 80 00       	push   $0x80250c
  80020b:	e8 91 09 00 00       	call   800ba1 <cprintf>
  800210:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  800213:	e8 08 1c 00 00       	call   801e20 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	ff 75 ec             	pushl  -0x14(%ebp)
  80021e:	ff 75 e8             	pushl  -0x18(%ebp)
  800221:	e8 e1 00 00 00       	call   800307 <CheckSorted>
  800226:	83 c4 10             	add    $0x10,%esp
  800229:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80022c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800230:	75 14                	jne    800246 <_main+0x20e>
  800232:	83 ec 04             	sub    $0x4,%esp
  800235:	68 40 25 80 00       	push   $0x802540
  80023a:	6a 58                	push   $0x58
  80023c:	68 62 25 80 00       	push   $0x802562
  800241:	e8 a7 06 00 00       	call   8008ed <_panic>
		else
		{
			sys_disable_interrupt();
  800246:	e8 bb 1b 00 00       	call   801e06 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  80024b:	83 ec 0c             	sub    $0xc,%esp
  80024e:	68 80 25 80 00       	push   $0x802580
  800253:	e8 49 09 00 00       	call   800ba1 <cprintf>
  800258:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80025b:	83 ec 0c             	sub    $0xc,%esp
  80025e:	68 b4 25 80 00       	push   $0x8025b4
  800263:	e8 39 09 00 00       	call   800ba1 <cprintf>
  800268:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	68 e8 25 80 00       	push   $0x8025e8
  800273:	e8 29 09 00 00       	call   800ba1 <cprintf>
  800278:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80027b:	e8 a0 1b 00 00       	call   801e20 <sys_enable_interrupt>
		}

		free(Elements) ;
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	ff 75 e8             	pushl  -0x18(%ebp)
  800286:	e8 58 18 00 00       	call   801ae3 <free>
  80028b:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  80028e:	e8 73 1b 00 00       	call   801e06 <sys_disable_interrupt>
		Chose = 0 ;
  800293:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  800297:	eb 50                	jmp    8002e9 <_main+0x2b1>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	68 1a 26 80 00       	push   $0x80261a
  8002a1:	e8 fb 08 00 00       	call   800ba1 <cprintf>
  8002a6:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  8002a9:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  8002ad:	75 06                	jne    8002b5 <_main+0x27d>
				Chose = 'y' ;
  8002af:	c6 45 f7 79          	movb   $0x79,-0x9(%ebp)
  8002b3:	eb 0a                	jmp    8002bf <_main+0x287>
			else if (numOfRep == 2)
  8002b5:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8002b9:	75 04                	jne    8002bf <_main+0x287>
				Chose = 'n' ;
  8002bb:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
			cputchar(Chose);
  8002bf:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8002c3:	83 ec 0c             	sub    $0xc,%esp
  8002c6:	50                   	push   %eax
  8002c7:	e8 72 04 00 00       	call   80073e <cputchar>
  8002cc:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002cf:	83 ec 0c             	sub    $0xc,%esp
  8002d2:	6a 0a                	push   $0xa
  8002d4:	e8 65 04 00 00       	call   80073e <cputchar>
  8002d9:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002dc:	83 ec 0c             	sub    $0xc,%esp
  8002df:	6a 0a                	push   $0xa
  8002e1:	e8 58 04 00 00       	call   80073e <cputchar>
  8002e6:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  8002e9:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002ed:	74 06                	je     8002f5 <_main+0x2bd>
  8002ef:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002f3:	75 a4                	jne    800299 <_main+0x261>
				Chose = 'n' ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
		sys_enable_interrupt();
  8002f5:	e8 26 1b 00 00       	call   801e20 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002fa:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002fe:	0f 84 44 fd ff ff    	je     800048 <_main+0x10>
}
  800304:	90                   	nop
  800305:	c9                   	leave  
  800306:	c3                   	ret    

00800307 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800307:	55                   	push   %ebp
  800308:	89 e5                	mov    %esp,%ebp
  80030a:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80030d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800314:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80031b:	eb 33                	jmp    800350 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80031d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800320:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800327:	8b 45 08             	mov    0x8(%ebp),%eax
  80032a:	01 d0                	add    %edx,%eax
  80032c:	8b 10                	mov    (%eax),%edx
  80032e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800331:	40                   	inc    %eax
  800332:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 c8                	add    %ecx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	39 c2                	cmp    %eax,%edx
  800342:	7e 09                	jle    80034d <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800344:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80034b:	eb 0c                	jmp    800359 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80034d:	ff 45 f8             	incl   -0x8(%ebp)
  800350:	8b 45 0c             	mov    0xc(%ebp),%eax
  800353:	48                   	dec    %eax
  800354:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800357:	7f c4                	jg     80031d <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800359:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80035c:	c9                   	leave  
  80035d:	c3                   	ret    

0080035e <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80035e:	55                   	push   %ebp
  80035f:	89 e5                	mov    %esp,%ebp
  800361:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800364:	8b 45 0c             	mov    0xc(%ebp),%eax
  800367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	01 d0                	add    %edx,%eax
  800373:	8b 00                	mov    (%eax),%eax
  800375:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800378:	8b 45 0c             	mov    0xc(%ebp),%eax
  80037b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800382:	8b 45 08             	mov    0x8(%ebp),%eax
  800385:	01 c2                	add    %eax,%edx
  800387:	8b 45 10             	mov    0x10(%ebp),%eax
  80038a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800391:	8b 45 08             	mov    0x8(%ebp),%eax
  800394:	01 c8                	add    %ecx,%eax
  800396:	8b 00                	mov    (%eax),%eax
  800398:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80039a:	8b 45 10             	mov    0x10(%ebp),%eax
  80039d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a7:	01 c2                	add    %eax,%edx
  8003a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003ac:	89 02                	mov    %eax,(%edx)
}
  8003ae:	90                   	nop
  8003af:	c9                   	leave  
  8003b0:	c3                   	ret    

008003b1 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003b1:	55                   	push   %ebp
  8003b2:	89 e5                	mov    %esp,%ebp
  8003b4:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003be:	eb 17                	jmp    8003d7 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8003c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cd:	01 c2                	add    %eax,%edx
  8003cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003d2:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003d4:	ff 45 fc             	incl   -0x4(%ebp)
  8003d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003da:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003dd:	7c e1                	jl     8003c0 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003df:	90                   	nop
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ef:	eb 1b                	jmp    80040c <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	01 c2                	add    %eax,%edx
  800400:	8b 45 0c             	mov    0xc(%ebp),%eax
  800403:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800406:	48                   	dec    %eax
  800407:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800409:	ff 45 fc             	incl   -0x4(%ebp)
  80040c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800412:	7c dd                	jl     8003f1 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800414:	90                   	nop
  800415:	c9                   	leave  
  800416:	c3                   	ret    

00800417 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800417:	55                   	push   %ebp
  800418:	89 e5                	mov    %esp,%ebp
  80041a:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80041d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800420:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800425:	f7 e9                	imul   %ecx
  800427:	c1 f9 1f             	sar    $0x1f,%ecx
  80042a:	89 d0                	mov    %edx,%eax
  80042c:	29 c8                	sub    %ecx,%eax
  80042e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800431:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800438:	eb 1e                	jmp    800458 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80043a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800444:	8b 45 08             	mov    0x8(%ebp),%eax
  800447:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80044a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80044d:	99                   	cltd   
  80044e:	f7 7d f8             	idivl  -0x8(%ebp)
  800451:	89 d0                	mov    %edx,%eax
  800453:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800455:	ff 45 fc             	incl   -0x4(%ebp)
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80045e:	7c da                	jl     80043a <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800460:	90                   	nop
  800461:	c9                   	leave  
  800462:	c3                   	ret    

00800463 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800463:	55                   	push   %ebp
  800464:	89 e5                	mov    %esp,%ebp
  800466:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800469:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800470:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800477:	eb 42                	jmp    8004bb <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800479:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80047c:	99                   	cltd   
  80047d:	f7 7d f0             	idivl  -0x10(%ebp)
  800480:	89 d0                	mov    %edx,%eax
  800482:	85 c0                	test   %eax,%eax
  800484:	75 10                	jne    800496 <PrintElements+0x33>
			cprintf("\n");
  800486:	83 ec 0c             	sub    $0xc,%esp
  800489:	68 60 24 80 00       	push   $0x802460
  80048e:	e8 0e 07 00 00       	call   800ba1 <cprintf>
  800493:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800496:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800499:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a3:	01 d0                	add    %edx,%eax
  8004a5:	8b 00                	mov    (%eax),%eax
  8004a7:	83 ec 08             	sub    $0x8,%esp
  8004aa:	50                   	push   %eax
  8004ab:	68 38 26 80 00       	push   $0x802638
  8004b0:	e8 ec 06 00 00       	call   800ba1 <cprintf>
  8004b5:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004b8:	ff 45 f4             	incl   -0xc(%ebp)
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	48                   	dec    %eax
  8004bf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8004c2:	7f b5                	jg     800479 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8004c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d1:	01 d0                	add    %edx,%eax
  8004d3:	8b 00                	mov    (%eax),%eax
  8004d5:	83 ec 08             	sub    $0x8,%esp
  8004d8:	50                   	push   %eax
  8004d9:	68 af 24 80 00       	push   $0x8024af
  8004de:	e8 be 06 00 00       	call   800ba1 <cprintf>
  8004e3:	83 c4 10             	add    $0x10,%esp

}
  8004e6:	90                   	nop
  8004e7:	c9                   	leave  
  8004e8:	c3                   	ret    

008004e9 <MSort>:


void MSort(int* A, int p, int r)
{
  8004e9:	55                   	push   %ebp
  8004ea:	89 e5                	mov    %esp,%ebp
  8004ec:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004f5:	7d 54                	jge    80054b <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fd:	01 d0                	add    %edx,%eax
  8004ff:	89 c2                	mov    %eax,%edx
  800501:	c1 ea 1f             	shr    $0x1f,%edx
  800504:	01 d0                	add    %edx,%eax
  800506:	d1 f8                	sar    %eax
  800508:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  80050b:	83 ec 04             	sub    $0x4,%esp
  80050e:	ff 75 f4             	pushl  -0xc(%ebp)
  800511:	ff 75 0c             	pushl  0xc(%ebp)
  800514:	ff 75 08             	pushl  0x8(%ebp)
  800517:	e8 cd ff ff ff       	call   8004e9 <MSort>
  80051c:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  80051f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800522:	40                   	inc    %eax
  800523:	83 ec 04             	sub    $0x4,%esp
  800526:	ff 75 10             	pushl  0x10(%ebp)
  800529:	50                   	push   %eax
  80052a:	ff 75 08             	pushl  0x8(%ebp)
  80052d:	e8 b7 ff ff ff       	call   8004e9 <MSort>
  800532:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800535:	ff 75 10             	pushl  0x10(%ebp)
  800538:	ff 75 f4             	pushl  -0xc(%ebp)
  80053b:	ff 75 0c             	pushl  0xc(%ebp)
  80053e:	ff 75 08             	pushl  0x8(%ebp)
  800541:	e8 08 00 00 00       	call   80054e <Merge>
  800546:	83 c4 10             	add    $0x10,%esp
  800549:	eb 01                	jmp    80054c <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  80054b:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  80054c:	c9                   	leave  
  80054d:	c3                   	ret    

0080054e <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80054e:	55                   	push   %ebp
  80054f:	89 e5                	mov    %esp,%ebp
  800551:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800554:	8b 45 10             	mov    0x10(%ebp),%eax
  800557:	2b 45 0c             	sub    0xc(%ebp),%eax
  80055a:	40                   	inc    %eax
  80055b:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80055e:	8b 45 14             	mov    0x14(%ebp),%eax
  800561:	2b 45 10             	sub    0x10(%ebp),%eax
  800564:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800567:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80056e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800575:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800578:	c1 e0 02             	shl    $0x2,%eax
  80057b:	83 ec 0c             	sub    $0xc,%esp
  80057e:	50                   	push   %eax
  80057f:	e8 a7 13 00 00       	call   80192b <malloc>
  800584:	83 c4 10             	add    $0x10,%esp
  800587:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  80058a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80058d:	c1 e0 02             	shl    $0x2,%eax
  800590:	83 ec 0c             	sub    $0xc,%esp
  800593:	50                   	push   %eax
  800594:	e8 92 13 00 00       	call   80192b <malloc>
  800599:	83 c4 10             	add    $0x10,%esp
  80059c:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80059f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8005a6:	eb 2f                	jmp    8005d7 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8005a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005b5:	01 c2                	add    %eax,%edx
  8005b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005bd:	01 c8                	add    %ecx,%eax
  8005bf:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8005c4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ce:	01 c8                	add    %ecx,%eax
  8005d0:	8b 00                	mov    (%eax),%eax
  8005d2:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8005d4:	ff 45 ec             	incl   -0x14(%ebp)
  8005d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005da:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005dd:	7c c9                	jl     8005a8 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005df:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005e6:	eb 2a                	jmp    800612 <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005f5:	01 c2                	add    %eax,%edx
  8005f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005fd:	01 c8                	add    %ecx,%eax
  8005ff:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	01 c8                	add    %ecx,%eax
  80060b:	8b 00                	mov    (%eax),%eax
  80060d:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80060f:	ff 45 e8             	incl   -0x18(%ebp)
  800612:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800615:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800618:	7c ce                	jl     8005e8 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  80061a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800620:	e9 0a 01 00 00       	jmp    80072f <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  800625:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800628:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80062b:	0f 8d 95 00 00 00    	jge    8006c6 <Merge+0x178>
  800631:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800634:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800637:	0f 8d 89 00 00 00    	jge    8006c6 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80063d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800640:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800647:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80064a:	01 d0                	add    %edx,%eax
  80064c:	8b 10                	mov    (%eax),%edx
  80064e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800651:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800658:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80065b:	01 c8                	add    %ecx,%eax
  80065d:	8b 00                	mov    (%eax),%eax
  80065f:	39 c2                	cmp    %eax,%edx
  800661:	7d 33                	jge    800696 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800663:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800666:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80066b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800678:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80067b:	8d 50 01             	lea    0x1(%eax),%edx
  80067e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800681:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800688:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80068b:	01 d0                	add    %edx,%eax
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800691:	e9 96 00 00 00       	jmp    80072c <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800696:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800699:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80069e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ae:	8d 50 01             	lea    0x1(%eax),%edx
  8006b1:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006bb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006be:	01 d0                	add    %edx,%eax
  8006c0:	8b 00                	mov    (%eax),%eax
  8006c2:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8006c4:	eb 66                	jmp    80072c <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  8006c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006c9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8006cc:	7d 30                	jge    8006fe <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  8006ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006d1:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006e6:	8d 50 01             	lea    0x1(%eax),%edx
  8006e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006f6:	01 d0                	add    %edx,%eax
  8006f8:	8b 00                	mov    (%eax),%eax
  8006fa:	89 01                	mov    %eax,(%ecx)
  8006fc:	eb 2e                	jmp    80072c <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800701:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800706:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80070d:	8b 45 08             	mov    0x8(%ebp),%eax
  800710:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800713:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800716:	8d 50 01             	lea    0x1(%eax),%edx
  800719:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80071c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800723:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800726:	01 d0                	add    %edx,%eax
  800728:	8b 00                	mov    (%eax),%eax
  80072a:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  80072c:	ff 45 e4             	incl   -0x1c(%ebp)
  80072f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800732:	3b 45 14             	cmp    0x14(%ebp),%eax
  800735:	0f 8e ea fe ff ff    	jle    800625 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  80073b:	90                   	nop
  80073c:	c9                   	leave  
  80073d:	c3                   	ret    

0080073e <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80073e:	55                   	push   %ebp
  80073f:	89 e5                	mov    %esp,%ebp
  800741:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80074a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80074e:	83 ec 0c             	sub    $0xc,%esp
  800751:	50                   	push   %eax
  800752:	e8 e3 16 00 00       	call   801e3a <sys_cputc>
  800757:	83 c4 10             	add    $0x10,%esp
}
  80075a:	90                   	nop
  80075b:	c9                   	leave  
  80075c:	c3                   	ret    

0080075d <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80075d:	55                   	push   %ebp
  80075e:	89 e5                	mov    %esp,%ebp
  800760:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800763:	e8 9e 16 00 00       	call   801e06 <sys_disable_interrupt>
	char c = ch;
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80076e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800772:	83 ec 0c             	sub    $0xc,%esp
  800775:	50                   	push   %eax
  800776:	e8 bf 16 00 00       	call   801e3a <sys_cputc>
  80077b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80077e:	e8 9d 16 00 00       	call   801e20 <sys_enable_interrupt>
}
  800783:	90                   	nop
  800784:	c9                   	leave  
  800785:	c3                   	ret    

00800786 <getchar>:

int
getchar(void)
{
  800786:	55                   	push   %ebp
  800787:	89 e5                	mov    %esp,%ebp
  800789:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80078c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800793:	eb 08                	jmp    80079d <getchar+0x17>
	{
		c = sys_cgetc();
  800795:	e8 84 14 00 00       	call   801c1e <sys_cgetc>
  80079a:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80079d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007a1:	74 f2                	je     800795 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8007a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007a6:	c9                   	leave  
  8007a7:	c3                   	ret    

008007a8 <atomic_getchar>:

int
atomic_getchar(void)
{
  8007a8:	55                   	push   %ebp
  8007a9:	89 e5                	mov    %esp,%ebp
  8007ab:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007ae:	e8 53 16 00 00       	call   801e06 <sys_disable_interrupt>
	int c=0;
  8007b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007ba:	eb 08                	jmp    8007c4 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007bc:	e8 5d 14 00 00       	call   801c1e <sys_cgetc>
  8007c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8007c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007c8:	74 f2                	je     8007bc <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007ca:	e8 51 16 00 00       	call   801e20 <sys_enable_interrupt>
	return c;
  8007cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007d2:	c9                   	leave  
  8007d3:	c3                   	ret    

008007d4 <iscons>:

int iscons(int fdnum)
{
  8007d4:	55                   	push   %ebp
  8007d5:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007d7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007dc:	5d                   	pop    %ebp
  8007dd:	c3                   	ret    

008007de <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007de:	55                   	push   %ebp
  8007df:	89 e5                	mov    %esp,%ebp
  8007e1:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007e4:	e8 82 14 00 00       	call   801c6b <sys_getenvindex>
  8007e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ef:	89 d0                	mov    %edx,%eax
  8007f1:	c1 e0 02             	shl    $0x2,%eax
  8007f4:	01 d0                	add    %edx,%eax
  8007f6:	01 c0                	add    %eax,%eax
  8007f8:	01 d0                	add    %edx,%eax
  8007fa:	01 c0                	add    %eax,%eax
  8007fc:	01 d0                	add    %edx,%eax
  8007fe:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800805:	01 d0                	add    %edx,%eax
  800807:	c1 e0 02             	shl    $0x2,%eax
  80080a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80080f:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800814:	a1 24 30 80 00       	mov    0x803024,%eax
  800819:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80081f:	84 c0                	test   %al,%al
  800821:	74 0f                	je     800832 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800823:	a1 24 30 80 00       	mov    0x803024,%eax
  800828:	05 f4 02 00 00       	add    $0x2f4,%eax
  80082d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800832:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800836:	7e 0a                	jle    800842 <libmain+0x64>
		binaryname = argv[0];
  800838:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083b:	8b 00                	mov    (%eax),%eax
  80083d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800842:	83 ec 08             	sub    $0x8,%esp
  800845:	ff 75 0c             	pushl  0xc(%ebp)
  800848:	ff 75 08             	pushl  0x8(%ebp)
  80084b:	e8 e8 f7 ff ff       	call   800038 <_main>
  800850:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800853:	e8 ae 15 00 00       	call   801e06 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800858:	83 ec 0c             	sub    $0xc,%esp
  80085b:	68 58 26 80 00       	push   $0x802658
  800860:	e8 3c 03 00 00       	call   800ba1 <cprintf>
  800865:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800868:	a1 24 30 80 00       	mov    0x803024,%eax
  80086d:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800873:	a1 24 30 80 00       	mov    0x803024,%eax
  800878:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80087e:	83 ec 04             	sub    $0x4,%esp
  800881:	52                   	push   %edx
  800882:	50                   	push   %eax
  800883:	68 80 26 80 00       	push   $0x802680
  800888:	e8 14 03 00 00       	call   800ba1 <cprintf>
  80088d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800890:	a1 24 30 80 00       	mov    0x803024,%eax
  800895:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80089b:	83 ec 08             	sub    $0x8,%esp
  80089e:	50                   	push   %eax
  80089f:	68 a5 26 80 00       	push   $0x8026a5
  8008a4:	e8 f8 02 00 00       	call   800ba1 <cprintf>
  8008a9:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8008ac:	83 ec 0c             	sub    $0xc,%esp
  8008af:	68 58 26 80 00       	push   $0x802658
  8008b4:	e8 e8 02 00 00       	call   800ba1 <cprintf>
  8008b9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008bc:	e8 5f 15 00 00       	call   801e20 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008c1:	e8 19 00 00 00       	call   8008df <exit>
}
  8008c6:	90                   	nop
  8008c7:	c9                   	leave  
  8008c8:	c3                   	ret    

008008c9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008c9:	55                   	push   %ebp
  8008ca:	89 e5                	mov    %esp,%ebp
  8008cc:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008cf:	83 ec 0c             	sub    $0xc,%esp
  8008d2:	6a 00                	push   $0x0
  8008d4:	e8 5e 13 00 00       	call   801c37 <sys_env_destroy>
  8008d9:	83 c4 10             	add    $0x10,%esp
}
  8008dc:	90                   	nop
  8008dd:	c9                   	leave  
  8008de:	c3                   	ret    

008008df <exit>:

void
exit(void)
{
  8008df:	55                   	push   %ebp
  8008e0:	89 e5                	mov    %esp,%ebp
  8008e2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008e5:	e8 b3 13 00 00       	call   801c9d <sys_env_exit>
}
  8008ea:	90                   	nop
  8008eb:	c9                   	leave  
  8008ec:	c3                   	ret    

008008ed <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008ed:	55                   	push   %ebp
  8008ee:	89 e5                	mov    %esp,%ebp
  8008f0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008f3:	8d 45 10             	lea    0x10(%ebp),%eax
  8008f6:	83 c0 04             	add    $0x4,%eax
  8008f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008fc:	a1 38 30 80 00       	mov    0x803038,%eax
  800901:	85 c0                	test   %eax,%eax
  800903:	74 16                	je     80091b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800905:	a1 38 30 80 00       	mov    0x803038,%eax
  80090a:	83 ec 08             	sub    $0x8,%esp
  80090d:	50                   	push   %eax
  80090e:	68 bc 26 80 00       	push   $0x8026bc
  800913:	e8 89 02 00 00       	call   800ba1 <cprintf>
  800918:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80091b:	a1 00 30 80 00       	mov    0x803000,%eax
  800920:	ff 75 0c             	pushl  0xc(%ebp)
  800923:	ff 75 08             	pushl  0x8(%ebp)
  800926:	50                   	push   %eax
  800927:	68 c1 26 80 00       	push   $0x8026c1
  80092c:	e8 70 02 00 00       	call   800ba1 <cprintf>
  800931:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800934:	8b 45 10             	mov    0x10(%ebp),%eax
  800937:	83 ec 08             	sub    $0x8,%esp
  80093a:	ff 75 f4             	pushl  -0xc(%ebp)
  80093d:	50                   	push   %eax
  80093e:	e8 f3 01 00 00       	call   800b36 <vcprintf>
  800943:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800946:	83 ec 08             	sub    $0x8,%esp
  800949:	6a 00                	push   $0x0
  80094b:	68 dd 26 80 00       	push   $0x8026dd
  800950:	e8 e1 01 00 00       	call   800b36 <vcprintf>
  800955:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800958:	e8 82 ff ff ff       	call   8008df <exit>

	// should not return here
	while (1) ;
  80095d:	eb fe                	jmp    80095d <_panic+0x70>

0080095f <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80095f:	55                   	push   %ebp
  800960:	89 e5                	mov    %esp,%ebp
  800962:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800965:	a1 24 30 80 00       	mov    0x803024,%eax
  80096a:	8b 50 74             	mov    0x74(%eax),%edx
  80096d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800970:	39 c2                	cmp    %eax,%edx
  800972:	74 14                	je     800988 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800974:	83 ec 04             	sub    $0x4,%esp
  800977:	68 e0 26 80 00       	push   $0x8026e0
  80097c:	6a 26                	push   $0x26
  80097e:	68 2c 27 80 00       	push   $0x80272c
  800983:	e8 65 ff ff ff       	call   8008ed <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800988:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80098f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800996:	e9 c2 00 00 00       	jmp    800a5d <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80099b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80099e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a8:	01 d0                	add    %edx,%eax
  8009aa:	8b 00                	mov    (%eax),%eax
  8009ac:	85 c0                	test   %eax,%eax
  8009ae:	75 08                	jne    8009b8 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009b0:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009b3:	e9 a2 00 00 00       	jmp    800a5a <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8009b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009bf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009c6:	eb 69                	jmp    800a31 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009c8:	a1 24 30 80 00       	mov    0x803024,%eax
  8009cd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009d3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009d6:	89 d0                	mov    %edx,%eax
  8009d8:	01 c0                	add    %eax,%eax
  8009da:	01 d0                	add    %edx,%eax
  8009dc:	c1 e0 02             	shl    $0x2,%eax
  8009df:	01 c8                	add    %ecx,%eax
  8009e1:	8a 40 04             	mov    0x4(%eax),%al
  8009e4:	84 c0                	test   %al,%al
  8009e6:	75 46                	jne    800a2e <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009e8:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ed:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009f3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009f6:	89 d0                	mov    %edx,%eax
  8009f8:	01 c0                	add    %eax,%eax
  8009fa:	01 d0                	add    %edx,%eax
  8009fc:	c1 e0 02             	shl    $0x2,%eax
  8009ff:	01 c8                	add    %ecx,%eax
  800a01:	8b 00                	mov    (%eax),%eax
  800a03:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a06:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a09:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a0e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a10:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a13:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1d:	01 c8                	add    %ecx,%eax
  800a1f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a21:	39 c2                	cmp    %eax,%edx
  800a23:	75 09                	jne    800a2e <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800a25:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a2c:	eb 12                	jmp    800a40 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a2e:	ff 45 e8             	incl   -0x18(%ebp)
  800a31:	a1 24 30 80 00       	mov    0x803024,%eax
  800a36:	8b 50 74             	mov    0x74(%eax),%edx
  800a39:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a3c:	39 c2                	cmp    %eax,%edx
  800a3e:	77 88                	ja     8009c8 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a40:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a44:	75 14                	jne    800a5a <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a46:	83 ec 04             	sub    $0x4,%esp
  800a49:	68 38 27 80 00       	push   $0x802738
  800a4e:	6a 3a                	push   $0x3a
  800a50:	68 2c 27 80 00       	push   $0x80272c
  800a55:	e8 93 fe ff ff       	call   8008ed <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a5a:	ff 45 f0             	incl   -0x10(%ebp)
  800a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a60:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a63:	0f 8c 32 ff ff ff    	jl     80099b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a69:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a70:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a77:	eb 26                	jmp    800a9f <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a79:	a1 24 30 80 00       	mov    0x803024,%eax
  800a7e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a84:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a87:	89 d0                	mov    %edx,%eax
  800a89:	01 c0                	add    %eax,%eax
  800a8b:	01 d0                	add    %edx,%eax
  800a8d:	c1 e0 02             	shl    $0x2,%eax
  800a90:	01 c8                	add    %ecx,%eax
  800a92:	8a 40 04             	mov    0x4(%eax),%al
  800a95:	3c 01                	cmp    $0x1,%al
  800a97:	75 03                	jne    800a9c <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a99:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a9c:	ff 45 e0             	incl   -0x20(%ebp)
  800a9f:	a1 24 30 80 00       	mov    0x803024,%eax
  800aa4:	8b 50 74             	mov    0x74(%eax),%edx
  800aa7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aaa:	39 c2                	cmp    %eax,%edx
  800aac:	77 cb                	ja     800a79 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800aae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ab1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ab4:	74 14                	je     800aca <CheckWSWithoutLastIndex+0x16b>
		panic(
  800ab6:	83 ec 04             	sub    $0x4,%esp
  800ab9:	68 8c 27 80 00       	push   $0x80278c
  800abe:	6a 44                	push   $0x44
  800ac0:	68 2c 27 80 00       	push   $0x80272c
  800ac5:	e8 23 fe ff ff       	call   8008ed <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aca:	90                   	nop
  800acb:	c9                   	leave  
  800acc:	c3                   	ret    

00800acd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800acd:	55                   	push   %ebp
  800ace:	89 e5                	mov    %esp,%ebp
  800ad0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ad3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad6:	8b 00                	mov    (%eax),%eax
  800ad8:	8d 48 01             	lea    0x1(%eax),%ecx
  800adb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ade:	89 0a                	mov    %ecx,(%edx)
  800ae0:	8b 55 08             	mov    0x8(%ebp),%edx
  800ae3:	88 d1                	mov    %dl,%cl
  800ae5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800aec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aef:	8b 00                	mov    (%eax),%eax
  800af1:	3d ff 00 00 00       	cmp    $0xff,%eax
  800af6:	75 2c                	jne    800b24 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800af8:	a0 28 30 80 00       	mov    0x803028,%al
  800afd:	0f b6 c0             	movzbl %al,%eax
  800b00:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b03:	8b 12                	mov    (%edx),%edx
  800b05:	89 d1                	mov    %edx,%ecx
  800b07:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0a:	83 c2 08             	add    $0x8,%edx
  800b0d:	83 ec 04             	sub    $0x4,%esp
  800b10:	50                   	push   %eax
  800b11:	51                   	push   %ecx
  800b12:	52                   	push   %edx
  800b13:	e8 dd 10 00 00       	call   801bf5 <sys_cputs>
  800b18:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b27:	8b 40 04             	mov    0x4(%eax),%eax
  800b2a:	8d 50 01             	lea    0x1(%eax),%edx
  800b2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b30:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b33:	90                   	nop
  800b34:	c9                   	leave  
  800b35:	c3                   	ret    

00800b36 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b36:	55                   	push   %ebp
  800b37:	89 e5                	mov    %esp,%ebp
  800b39:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b3f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b46:	00 00 00 
	b.cnt = 0;
  800b49:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b50:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b53:	ff 75 0c             	pushl  0xc(%ebp)
  800b56:	ff 75 08             	pushl  0x8(%ebp)
  800b59:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b5f:	50                   	push   %eax
  800b60:	68 cd 0a 80 00       	push   $0x800acd
  800b65:	e8 11 02 00 00       	call   800d7b <vprintfmt>
  800b6a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b6d:	a0 28 30 80 00       	mov    0x803028,%al
  800b72:	0f b6 c0             	movzbl %al,%eax
  800b75:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b7b:	83 ec 04             	sub    $0x4,%esp
  800b7e:	50                   	push   %eax
  800b7f:	52                   	push   %edx
  800b80:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b86:	83 c0 08             	add    $0x8,%eax
  800b89:	50                   	push   %eax
  800b8a:	e8 66 10 00 00       	call   801bf5 <sys_cputs>
  800b8f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b92:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b99:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b9f:	c9                   	leave  
  800ba0:	c3                   	ret    

00800ba1 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ba1:	55                   	push   %ebp
  800ba2:	89 e5                	mov    %esp,%ebp
  800ba4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ba7:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800bae:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	83 ec 08             	sub    $0x8,%esp
  800bba:	ff 75 f4             	pushl  -0xc(%ebp)
  800bbd:	50                   	push   %eax
  800bbe:	e8 73 ff ff ff       	call   800b36 <vcprintf>
  800bc3:	83 c4 10             	add    $0x10,%esp
  800bc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bcc:	c9                   	leave  
  800bcd:	c3                   	ret    

00800bce <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bce:	55                   	push   %ebp
  800bcf:	89 e5                	mov    %esp,%ebp
  800bd1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bd4:	e8 2d 12 00 00       	call   801e06 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bd9:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bdc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	83 ec 08             	sub    $0x8,%esp
  800be5:	ff 75 f4             	pushl  -0xc(%ebp)
  800be8:	50                   	push   %eax
  800be9:	e8 48 ff ff ff       	call   800b36 <vcprintf>
  800bee:	83 c4 10             	add    $0x10,%esp
  800bf1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bf4:	e8 27 12 00 00       	call   801e20 <sys_enable_interrupt>
	return cnt;
  800bf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bfc:	c9                   	leave  
  800bfd:	c3                   	ret    

00800bfe <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bfe:	55                   	push   %ebp
  800bff:	89 e5                	mov    %esp,%ebp
  800c01:	53                   	push   %ebx
  800c02:	83 ec 14             	sub    $0x14,%esp
  800c05:	8b 45 10             	mov    0x10(%ebp),%eax
  800c08:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c11:	8b 45 18             	mov    0x18(%ebp),%eax
  800c14:	ba 00 00 00 00       	mov    $0x0,%edx
  800c19:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c1c:	77 55                	ja     800c73 <printnum+0x75>
  800c1e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c21:	72 05                	jb     800c28 <printnum+0x2a>
  800c23:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c26:	77 4b                	ja     800c73 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c28:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c2b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c2e:	8b 45 18             	mov    0x18(%ebp),%eax
  800c31:	ba 00 00 00 00       	mov    $0x0,%edx
  800c36:	52                   	push   %edx
  800c37:	50                   	push   %eax
  800c38:	ff 75 f4             	pushl  -0xc(%ebp)
  800c3b:	ff 75 f0             	pushl  -0x10(%ebp)
  800c3e:	e8 a1 15 00 00       	call   8021e4 <__udivdi3>
  800c43:	83 c4 10             	add    $0x10,%esp
  800c46:	83 ec 04             	sub    $0x4,%esp
  800c49:	ff 75 20             	pushl  0x20(%ebp)
  800c4c:	53                   	push   %ebx
  800c4d:	ff 75 18             	pushl  0x18(%ebp)
  800c50:	52                   	push   %edx
  800c51:	50                   	push   %eax
  800c52:	ff 75 0c             	pushl  0xc(%ebp)
  800c55:	ff 75 08             	pushl  0x8(%ebp)
  800c58:	e8 a1 ff ff ff       	call   800bfe <printnum>
  800c5d:	83 c4 20             	add    $0x20,%esp
  800c60:	eb 1a                	jmp    800c7c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c62:	83 ec 08             	sub    $0x8,%esp
  800c65:	ff 75 0c             	pushl  0xc(%ebp)
  800c68:	ff 75 20             	pushl  0x20(%ebp)
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	ff d0                	call   *%eax
  800c70:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c73:	ff 4d 1c             	decl   0x1c(%ebp)
  800c76:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c7a:	7f e6                	jg     800c62 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c7c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c7f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c84:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c87:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c8a:	53                   	push   %ebx
  800c8b:	51                   	push   %ecx
  800c8c:	52                   	push   %edx
  800c8d:	50                   	push   %eax
  800c8e:	e8 61 16 00 00       	call   8022f4 <__umoddi3>
  800c93:	83 c4 10             	add    $0x10,%esp
  800c96:	05 f4 29 80 00       	add    $0x8029f4,%eax
  800c9b:	8a 00                	mov    (%eax),%al
  800c9d:	0f be c0             	movsbl %al,%eax
  800ca0:	83 ec 08             	sub    $0x8,%esp
  800ca3:	ff 75 0c             	pushl  0xc(%ebp)
  800ca6:	50                   	push   %eax
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	ff d0                	call   *%eax
  800cac:	83 c4 10             	add    $0x10,%esp
}
  800caf:	90                   	nop
  800cb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cb3:	c9                   	leave  
  800cb4:	c3                   	ret    

00800cb5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800cb5:	55                   	push   %ebp
  800cb6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cb8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cbc:	7e 1c                	jle    800cda <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	8b 00                	mov    (%eax),%eax
  800cc3:	8d 50 08             	lea    0x8(%eax),%edx
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	89 10                	mov    %edx,(%eax)
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8b 00                	mov    (%eax),%eax
  800cd0:	83 e8 08             	sub    $0x8,%eax
  800cd3:	8b 50 04             	mov    0x4(%eax),%edx
  800cd6:	8b 00                	mov    (%eax),%eax
  800cd8:	eb 40                	jmp    800d1a <getuint+0x65>
	else if (lflag)
  800cda:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cde:	74 1e                	je     800cfe <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	8b 00                	mov    (%eax),%eax
  800ce5:	8d 50 04             	lea    0x4(%eax),%edx
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	89 10                	mov    %edx,(%eax)
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	8b 00                	mov    (%eax),%eax
  800cf2:	83 e8 04             	sub    $0x4,%eax
  800cf5:	8b 00                	mov    (%eax),%eax
  800cf7:	ba 00 00 00 00       	mov    $0x0,%edx
  800cfc:	eb 1c                	jmp    800d1a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8b 00                	mov    (%eax),%eax
  800d03:	8d 50 04             	lea    0x4(%eax),%edx
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	89 10                	mov    %edx,(%eax)
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8b 00                	mov    (%eax),%eax
  800d10:	83 e8 04             	sub    $0x4,%eax
  800d13:	8b 00                	mov    (%eax),%eax
  800d15:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d1a:	5d                   	pop    %ebp
  800d1b:	c3                   	ret    

00800d1c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d1c:	55                   	push   %ebp
  800d1d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d1f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d23:	7e 1c                	jle    800d41 <getint+0x25>
		return va_arg(*ap, long long);
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	8b 00                	mov    (%eax),%eax
  800d2a:	8d 50 08             	lea    0x8(%eax),%edx
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	89 10                	mov    %edx,(%eax)
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8b 00                	mov    (%eax),%eax
  800d37:	83 e8 08             	sub    $0x8,%eax
  800d3a:	8b 50 04             	mov    0x4(%eax),%edx
  800d3d:	8b 00                	mov    (%eax),%eax
  800d3f:	eb 38                	jmp    800d79 <getint+0x5d>
	else if (lflag)
  800d41:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d45:	74 1a                	je     800d61 <getint+0x45>
		return va_arg(*ap, long);
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	8b 00                	mov    (%eax),%eax
  800d4c:	8d 50 04             	lea    0x4(%eax),%edx
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	89 10                	mov    %edx,(%eax)
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8b 00                	mov    (%eax),%eax
  800d59:	83 e8 04             	sub    $0x4,%eax
  800d5c:	8b 00                	mov    (%eax),%eax
  800d5e:	99                   	cltd   
  800d5f:	eb 18                	jmp    800d79 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8b 00                	mov    (%eax),%eax
  800d66:	8d 50 04             	lea    0x4(%eax),%edx
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	89 10                	mov    %edx,(%eax)
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	8b 00                	mov    (%eax),%eax
  800d73:	83 e8 04             	sub    $0x4,%eax
  800d76:	8b 00                	mov    (%eax),%eax
  800d78:	99                   	cltd   
}
  800d79:	5d                   	pop    %ebp
  800d7a:	c3                   	ret    

00800d7b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d7b:	55                   	push   %ebp
  800d7c:	89 e5                	mov    %esp,%ebp
  800d7e:	56                   	push   %esi
  800d7f:	53                   	push   %ebx
  800d80:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d83:	eb 17                	jmp    800d9c <vprintfmt+0x21>
			if (ch == '\0')
  800d85:	85 db                	test   %ebx,%ebx
  800d87:	0f 84 af 03 00 00    	je     80113c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d8d:	83 ec 08             	sub    $0x8,%esp
  800d90:	ff 75 0c             	pushl  0xc(%ebp)
  800d93:	53                   	push   %ebx
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	ff d0                	call   *%eax
  800d99:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d9c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9f:	8d 50 01             	lea    0x1(%eax),%edx
  800da2:	89 55 10             	mov    %edx,0x10(%ebp)
  800da5:	8a 00                	mov    (%eax),%al
  800da7:	0f b6 d8             	movzbl %al,%ebx
  800daa:	83 fb 25             	cmp    $0x25,%ebx
  800dad:	75 d6                	jne    800d85 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800daf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800db3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800dba:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800dc1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dc8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dcf:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd2:	8d 50 01             	lea    0x1(%eax),%edx
  800dd5:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	0f b6 d8             	movzbl %al,%ebx
  800ddd:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800de0:	83 f8 55             	cmp    $0x55,%eax
  800de3:	0f 87 2b 03 00 00    	ja     801114 <vprintfmt+0x399>
  800de9:	8b 04 85 18 2a 80 00 	mov    0x802a18(,%eax,4),%eax
  800df0:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800df2:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800df6:	eb d7                	jmp    800dcf <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800df8:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dfc:	eb d1                	jmp    800dcf <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dfe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e05:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e08:	89 d0                	mov    %edx,%eax
  800e0a:	c1 e0 02             	shl    $0x2,%eax
  800e0d:	01 d0                	add    %edx,%eax
  800e0f:	01 c0                	add    %eax,%eax
  800e11:	01 d8                	add    %ebx,%eax
  800e13:	83 e8 30             	sub    $0x30,%eax
  800e16:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e19:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1c:	8a 00                	mov    (%eax),%al
  800e1e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e21:	83 fb 2f             	cmp    $0x2f,%ebx
  800e24:	7e 3e                	jle    800e64 <vprintfmt+0xe9>
  800e26:	83 fb 39             	cmp    $0x39,%ebx
  800e29:	7f 39                	jg     800e64 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e2b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e2e:	eb d5                	jmp    800e05 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e30:	8b 45 14             	mov    0x14(%ebp),%eax
  800e33:	83 c0 04             	add    $0x4,%eax
  800e36:	89 45 14             	mov    %eax,0x14(%ebp)
  800e39:	8b 45 14             	mov    0x14(%ebp),%eax
  800e3c:	83 e8 04             	sub    $0x4,%eax
  800e3f:	8b 00                	mov    (%eax),%eax
  800e41:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e44:	eb 1f                	jmp    800e65 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e46:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4a:	79 83                	jns    800dcf <vprintfmt+0x54>
				width = 0;
  800e4c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e53:	e9 77 ff ff ff       	jmp    800dcf <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e58:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e5f:	e9 6b ff ff ff       	jmp    800dcf <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e64:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e65:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e69:	0f 89 60 ff ff ff    	jns    800dcf <vprintfmt+0x54>
				width = precision, precision = -1;
  800e6f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e72:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e75:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e7c:	e9 4e ff ff ff       	jmp    800dcf <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e81:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e84:	e9 46 ff ff ff       	jmp    800dcf <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e89:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8c:	83 c0 04             	add    $0x4,%eax
  800e8f:	89 45 14             	mov    %eax,0x14(%ebp)
  800e92:	8b 45 14             	mov    0x14(%ebp),%eax
  800e95:	83 e8 04             	sub    $0x4,%eax
  800e98:	8b 00                	mov    (%eax),%eax
  800e9a:	83 ec 08             	sub    $0x8,%esp
  800e9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ea0:	50                   	push   %eax
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	ff d0                	call   *%eax
  800ea6:	83 c4 10             	add    $0x10,%esp
			break;
  800ea9:	e9 89 02 00 00       	jmp    801137 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800eae:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb1:	83 c0 04             	add    $0x4,%eax
  800eb4:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb7:	8b 45 14             	mov    0x14(%ebp),%eax
  800eba:	83 e8 04             	sub    $0x4,%eax
  800ebd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ebf:	85 db                	test   %ebx,%ebx
  800ec1:	79 02                	jns    800ec5 <vprintfmt+0x14a>
				err = -err;
  800ec3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ec5:	83 fb 64             	cmp    $0x64,%ebx
  800ec8:	7f 0b                	jg     800ed5 <vprintfmt+0x15a>
  800eca:	8b 34 9d 60 28 80 00 	mov    0x802860(,%ebx,4),%esi
  800ed1:	85 f6                	test   %esi,%esi
  800ed3:	75 19                	jne    800eee <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ed5:	53                   	push   %ebx
  800ed6:	68 05 2a 80 00       	push   $0x802a05
  800edb:	ff 75 0c             	pushl  0xc(%ebp)
  800ede:	ff 75 08             	pushl  0x8(%ebp)
  800ee1:	e8 5e 02 00 00       	call   801144 <printfmt>
  800ee6:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ee9:	e9 49 02 00 00       	jmp    801137 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800eee:	56                   	push   %esi
  800eef:	68 0e 2a 80 00       	push   $0x802a0e
  800ef4:	ff 75 0c             	pushl  0xc(%ebp)
  800ef7:	ff 75 08             	pushl  0x8(%ebp)
  800efa:	e8 45 02 00 00       	call   801144 <printfmt>
  800eff:	83 c4 10             	add    $0x10,%esp
			break;
  800f02:	e9 30 02 00 00       	jmp    801137 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f07:	8b 45 14             	mov    0x14(%ebp),%eax
  800f0a:	83 c0 04             	add    $0x4,%eax
  800f0d:	89 45 14             	mov    %eax,0x14(%ebp)
  800f10:	8b 45 14             	mov    0x14(%ebp),%eax
  800f13:	83 e8 04             	sub    $0x4,%eax
  800f16:	8b 30                	mov    (%eax),%esi
  800f18:	85 f6                	test   %esi,%esi
  800f1a:	75 05                	jne    800f21 <vprintfmt+0x1a6>
				p = "(null)";
  800f1c:	be 11 2a 80 00       	mov    $0x802a11,%esi
			if (width > 0 && padc != '-')
  800f21:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f25:	7e 6d                	jle    800f94 <vprintfmt+0x219>
  800f27:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f2b:	74 67                	je     800f94 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f30:	83 ec 08             	sub    $0x8,%esp
  800f33:	50                   	push   %eax
  800f34:	56                   	push   %esi
  800f35:	e8 0c 03 00 00       	call   801246 <strnlen>
  800f3a:	83 c4 10             	add    $0x10,%esp
  800f3d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f40:	eb 16                	jmp    800f58 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f42:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f46:	83 ec 08             	sub    $0x8,%esp
  800f49:	ff 75 0c             	pushl  0xc(%ebp)
  800f4c:	50                   	push   %eax
  800f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f50:	ff d0                	call   *%eax
  800f52:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f55:	ff 4d e4             	decl   -0x1c(%ebp)
  800f58:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f5c:	7f e4                	jg     800f42 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f5e:	eb 34                	jmp    800f94 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f60:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f64:	74 1c                	je     800f82 <vprintfmt+0x207>
  800f66:	83 fb 1f             	cmp    $0x1f,%ebx
  800f69:	7e 05                	jle    800f70 <vprintfmt+0x1f5>
  800f6b:	83 fb 7e             	cmp    $0x7e,%ebx
  800f6e:	7e 12                	jle    800f82 <vprintfmt+0x207>
					putch('?', putdat);
  800f70:	83 ec 08             	sub    $0x8,%esp
  800f73:	ff 75 0c             	pushl  0xc(%ebp)
  800f76:	6a 3f                	push   $0x3f
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	ff d0                	call   *%eax
  800f7d:	83 c4 10             	add    $0x10,%esp
  800f80:	eb 0f                	jmp    800f91 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f82:	83 ec 08             	sub    $0x8,%esp
  800f85:	ff 75 0c             	pushl  0xc(%ebp)
  800f88:	53                   	push   %ebx
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	ff d0                	call   *%eax
  800f8e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f91:	ff 4d e4             	decl   -0x1c(%ebp)
  800f94:	89 f0                	mov    %esi,%eax
  800f96:	8d 70 01             	lea    0x1(%eax),%esi
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	0f be d8             	movsbl %al,%ebx
  800f9e:	85 db                	test   %ebx,%ebx
  800fa0:	74 24                	je     800fc6 <vprintfmt+0x24b>
  800fa2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fa6:	78 b8                	js     800f60 <vprintfmt+0x1e5>
  800fa8:	ff 4d e0             	decl   -0x20(%ebp)
  800fab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800faf:	79 af                	jns    800f60 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fb1:	eb 13                	jmp    800fc6 <vprintfmt+0x24b>
				putch(' ', putdat);
  800fb3:	83 ec 08             	sub    $0x8,%esp
  800fb6:	ff 75 0c             	pushl  0xc(%ebp)
  800fb9:	6a 20                	push   $0x20
  800fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbe:	ff d0                	call   *%eax
  800fc0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fc3:	ff 4d e4             	decl   -0x1c(%ebp)
  800fc6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fca:	7f e7                	jg     800fb3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fcc:	e9 66 01 00 00       	jmp    801137 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fd1:	83 ec 08             	sub    $0x8,%esp
  800fd4:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd7:	8d 45 14             	lea    0x14(%ebp),%eax
  800fda:	50                   	push   %eax
  800fdb:	e8 3c fd ff ff       	call   800d1c <getint>
  800fe0:	83 c4 10             	add    $0x10,%esp
  800fe3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fe9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fef:	85 d2                	test   %edx,%edx
  800ff1:	79 23                	jns    801016 <vprintfmt+0x29b>
				putch('-', putdat);
  800ff3:	83 ec 08             	sub    $0x8,%esp
  800ff6:	ff 75 0c             	pushl  0xc(%ebp)
  800ff9:	6a 2d                	push   $0x2d
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	ff d0                	call   *%eax
  801000:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801003:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801006:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801009:	f7 d8                	neg    %eax
  80100b:	83 d2 00             	adc    $0x0,%edx
  80100e:	f7 da                	neg    %edx
  801010:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801013:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801016:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80101d:	e9 bc 00 00 00       	jmp    8010de <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801022:	83 ec 08             	sub    $0x8,%esp
  801025:	ff 75 e8             	pushl  -0x18(%ebp)
  801028:	8d 45 14             	lea    0x14(%ebp),%eax
  80102b:	50                   	push   %eax
  80102c:	e8 84 fc ff ff       	call   800cb5 <getuint>
  801031:	83 c4 10             	add    $0x10,%esp
  801034:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801037:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80103a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801041:	e9 98 00 00 00       	jmp    8010de <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801046:	83 ec 08             	sub    $0x8,%esp
  801049:	ff 75 0c             	pushl  0xc(%ebp)
  80104c:	6a 58                	push   $0x58
  80104e:	8b 45 08             	mov    0x8(%ebp),%eax
  801051:	ff d0                	call   *%eax
  801053:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801056:	83 ec 08             	sub    $0x8,%esp
  801059:	ff 75 0c             	pushl  0xc(%ebp)
  80105c:	6a 58                	push   $0x58
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	ff d0                	call   *%eax
  801063:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801066:	83 ec 08             	sub    $0x8,%esp
  801069:	ff 75 0c             	pushl  0xc(%ebp)
  80106c:	6a 58                	push   $0x58
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	ff d0                	call   *%eax
  801073:	83 c4 10             	add    $0x10,%esp
			break;
  801076:	e9 bc 00 00 00       	jmp    801137 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80107b:	83 ec 08             	sub    $0x8,%esp
  80107e:	ff 75 0c             	pushl  0xc(%ebp)
  801081:	6a 30                	push   $0x30
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	ff d0                	call   *%eax
  801088:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80108b:	83 ec 08             	sub    $0x8,%esp
  80108e:	ff 75 0c             	pushl  0xc(%ebp)
  801091:	6a 78                	push   $0x78
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	ff d0                	call   *%eax
  801098:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80109b:	8b 45 14             	mov    0x14(%ebp),%eax
  80109e:	83 c0 04             	add    $0x4,%eax
  8010a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8010a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a7:	83 e8 04             	sub    $0x4,%eax
  8010aa:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8010ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010b6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010bd:	eb 1f                	jmp    8010de <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010bf:	83 ec 08             	sub    $0x8,%esp
  8010c2:	ff 75 e8             	pushl  -0x18(%ebp)
  8010c5:	8d 45 14             	lea    0x14(%ebp),%eax
  8010c8:	50                   	push   %eax
  8010c9:	e8 e7 fb ff ff       	call   800cb5 <getuint>
  8010ce:	83 c4 10             	add    $0x10,%esp
  8010d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010d4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010d7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010de:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010e5:	83 ec 04             	sub    $0x4,%esp
  8010e8:	52                   	push   %edx
  8010e9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010ec:	50                   	push   %eax
  8010ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8010f0:	ff 75 f0             	pushl  -0x10(%ebp)
  8010f3:	ff 75 0c             	pushl  0xc(%ebp)
  8010f6:	ff 75 08             	pushl  0x8(%ebp)
  8010f9:	e8 00 fb ff ff       	call   800bfe <printnum>
  8010fe:	83 c4 20             	add    $0x20,%esp
			break;
  801101:	eb 34                	jmp    801137 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801103:	83 ec 08             	sub    $0x8,%esp
  801106:	ff 75 0c             	pushl  0xc(%ebp)
  801109:	53                   	push   %ebx
  80110a:	8b 45 08             	mov    0x8(%ebp),%eax
  80110d:	ff d0                	call   *%eax
  80110f:	83 c4 10             	add    $0x10,%esp
			break;
  801112:	eb 23                	jmp    801137 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801114:	83 ec 08             	sub    $0x8,%esp
  801117:	ff 75 0c             	pushl  0xc(%ebp)
  80111a:	6a 25                	push   $0x25
  80111c:	8b 45 08             	mov    0x8(%ebp),%eax
  80111f:	ff d0                	call   *%eax
  801121:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801124:	ff 4d 10             	decl   0x10(%ebp)
  801127:	eb 03                	jmp    80112c <vprintfmt+0x3b1>
  801129:	ff 4d 10             	decl   0x10(%ebp)
  80112c:	8b 45 10             	mov    0x10(%ebp),%eax
  80112f:	48                   	dec    %eax
  801130:	8a 00                	mov    (%eax),%al
  801132:	3c 25                	cmp    $0x25,%al
  801134:	75 f3                	jne    801129 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801136:	90                   	nop
		}
	}
  801137:	e9 47 fc ff ff       	jmp    800d83 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80113c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80113d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801140:	5b                   	pop    %ebx
  801141:	5e                   	pop    %esi
  801142:	5d                   	pop    %ebp
  801143:	c3                   	ret    

00801144 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
  801147:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80114a:	8d 45 10             	lea    0x10(%ebp),%eax
  80114d:	83 c0 04             	add    $0x4,%eax
  801150:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801153:	8b 45 10             	mov    0x10(%ebp),%eax
  801156:	ff 75 f4             	pushl  -0xc(%ebp)
  801159:	50                   	push   %eax
  80115a:	ff 75 0c             	pushl  0xc(%ebp)
  80115d:	ff 75 08             	pushl  0x8(%ebp)
  801160:	e8 16 fc ff ff       	call   800d7b <vprintfmt>
  801165:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801168:	90                   	nop
  801169:	c9                   	leave  
  80116a:	c3                   	ret    

0080116b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80116b:	55                   	push   %ebp
  80116c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80116e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801171:	8b 40 08             	mov    0x8(%eax),%eax
  801174:	8d 50 01             	lea    0x1(%eax),%edx
  801177:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80117d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801180:	8b 10                	mov    (%eax),%edx
  801182:	8b 45 0c             	mov    0xc(%ebp),%eax
  801185:	8b 40 04             	mov    0x4(%eax),%eax
  801188:	39 c2                	cmp    %eax,%edx
  80118a:	73 12                	jae    80119e <sprintputch+0x33>
		*b->buf++ = ch;
  80118c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118f:	8b 00                	mov    (%eax),%eax
  801191:	8d 48 01             	lea    0x1(%eax),%ecx
  801194:	8b 55 0c             	mov    0xc(%ebp),%edx
  801197:	89 0a                	mov    %ecx,(%edx)
  801199:	8b 55 08             	mov    0x8(%ebp),%edx
  80119c:	88 10                	mov    %dl,(%eax)
}
  80119e:	90                   	nop
  80119f:	5d                   	pop    %ebp
  8011a0:	c3                   	ret    

008011a1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8011a1:	55                   	push   %ebp
  8011a2:	89 e5                	mov    %esp,%ebp
  8011a4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b6:	01 d0                	add    %edx,%eax
  8011b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011c2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c6:	74 06                	je     8011ce <vsnprintf+0x2d>
  8011c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011cc:	7f 07                	jg     8011d5 <vsnprintf+0x34>
		return -E_INVAL;
  8011ce:	b8 03 00 00 00       	mov    $0x3,%eax
  8011d3:	eb 20                	jmp    8011f5 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011d5:	ff 75 14             	pushl  0x14(%ebp)
  8011d8:	ff 75 10             	pushl  0x10(%ebp)
  8011db:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011de:	50                   	push   %eax
  8011df:	68 6b 11 80 00       	push   $0x80116b
  8011e4:	e8 92 fb ff ff       	call   800d7b <vprintfmt>
  8011e9:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ef:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011f5:	c9                   	leave  
  8011f6:	c3                   	ret    

008011f7 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011f7:	55                   	push   %ebp
  8011f8:	89 e5                	mov    %esp,%ebp
  8011fa:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011fd:	8d 45 10             	lea    0x10(%ebp),%eax
  801200:	83 c0 04             	add    $0x4,%eax
  801203:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801206:	8b 45 10             	mov    0x10(%ebp),%eax
  801209:	ff 75 f4             	pushl  -0xc(%ebp)
  80120c:	50                   	push   %eax
  80120d:	ff 75 0c             	pushl  0xc(%ebp)
  801210:	ff 75 08             	pushl  0x8(%ebp)
  801213:	e8 89 ff ff ff       	call   8011a1 <vsnprintf>
  801218:	83 c4 10             	add    $0x10,%esp
  80121b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80121e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801221:	c9                   	leave  
  801222:	c3                   	ret    

00801223 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801223:	55                   	push   %ebp
  801224:	89 e5                	mov    %esp,%ebp
  801226:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801229:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801230:	eb 06                	jmp    801238 <strlen+0x15>
		n++;
  801232:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801235:	ff 45 08             	incl   0x8(%ebp)
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
  80123b:	8a 00                	mov    (%eax),%al
  80123d:	84 c0                	test   %al,%al
  80123f:	75 f1                	jne    801232 <strlen+0xf>
		n++;
	return n;
  801241:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801244:	c9                   	leave  
  801245:	c3                   	ret    

00801246 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801246:	55                   	push   %ebp
  801247:	89 e5                	mov    %esp,%ebp
  801249:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80124c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801253:	eb 09                	jmp    80125e <strnlen+0x18>
		n++;
  801255:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801258:	ff 45 08             	incl   0x8(%ebp)
  80125b:	ff 4d 0c             	decl   0xc(%ebp)
  80125e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801262:	74 09                	je     80126d <strnlen+0x27>
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
  801267:	8a 00                	mov    (%eax),%al
  801269:	84 c0                	test   %al,%al
  80126b:	75 e8                	jne    801255 <strnlen+0xf>
		n++;
	return n;
  80126d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801270:	c9                   	leave  
  801271:	c3                   	ret    

00801272 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801272:	55                   	push   %ebp
  801273:	89 e5                	mov    %esp,%ebp
  801275:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80127e:	90                   	nop
  80127f:	8b 45 08             	mov    0x8(%ebp),%eax
  801282:	8d 50 01             	lea    0x1(%eax),%edx
  801285:	89 55 08             	mov    %edx,0x8(%ebp)
  801288:	8b 55 0c             	mov    0xc(%ebp),%edx
  80128b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80128e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801291:	8a 12                	mov    (%edx),%dl
  801293:	88 10                	mov    %dl,(%eax)
  801295:	8a 00                	mov    (%eax),%al
  801297:	84 c0                	test   %al,%al
  801299:	75 e4                	jne    80127f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80129b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
  8012a3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b3:	eb 1f                	jmp    8012d4 <strncpy+0x34>
		*dst++ = *src;
  8012b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b8:	8d 50 01             	lea    0x1(%eax),%edx
  8012bb:	89 55 08             	mov    %edx,0x8(%ebp)
  8012be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c1:	8a 12                	mov    (%edx),%dl
  8012c3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c8:	8a 00                	mov    (%eax),%al
  8012ca:	84 c0                	test   %al,%al
  8012cc:	74 03                	je     8012d1 <strncpy+0x31>
			src++;
  8012ce:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012d1:	ff 45 fc             	incl   -0x4(%ebp)
  8012d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012da:	72 d9                	jb     8012b5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012df:	c9                   	leave  
  8012e0:	c3                   	ret    

008012e1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012e1:	55                   	push   %ebp
  8012e2:	89 e5                	mov    %esp,%ebp
  8012e4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012ed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012f1:	74 30                	je     801323 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012f3:	eb 16                	jmp    80130b <strlcpy+0x2a>
			*dst++ = *src++;
  8012f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f8:	8d 50 01             	lea    0x1(%eax),%edx
  8012fb:	89 55 08             	mov    %edx,0x8(%ebp)
  8012fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801301:	8d 4a 01             	lea    0x1(%edx),%ecx
  801304:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801307:	8a 12                	mov    (%edx),%dl
  801309:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80130b:	ff 4d 10             	decl   0x10(%ebp)
  80130e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801312:	74 09                	je     80131d <strlcpy+0x3c>
  801314:	8b 45 0c             	mov    0xc(%ebp),%eax
  801317:	8a 00                	mov    (%eax),%al
  801319:	84 c0                	test   %al,%al
  80131b:	75 d8                	jne    8012f5 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801323:	8b 55 08             	mov    0x8(%ebp),%edx
  801326:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801329:	29 c2                	sub    %eax,%edx
  80132b:	89 d0                	mov    %edx,%eax
}
  80132d:	c9                   	leave  
  80132e:	c3                   	ret    

0080132f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80132f:	55                   	push   %ebp
  801330:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801332:	eb 06                	jmp    80133a <strcmp+0xb>
		p++, q++;
  801334:	ff 45 08             	incl   0x8(%ebp)
  801337:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	8a 00                	mov    (%eax),%al
  80133f:	84 c0                	test   %al,%al
  801341:	74 0e                	je     801351 <strcmp+0x22>
  801343:	8b 45 08             	mov    0x8(%ebp),%eax
  801346:	8a 10                	mov    (%eax),%dl
  801348:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134b:	8a 00                	mov    (%eax),%al
  80134d:	38 c2                	cmp    %al,%dl
  80134f:	74 e3                	je     801334 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801351:	8b 45 08             	mov    0x8(%ebp),%eax
  801354:	8a 00                	mov    (%eax),%al
  801356:	0f b6 d0             	movzbl %al,%edx
  801359:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135c:	8a 00                	mov    (%eax),%al
  80135e:	0f b6 c0             	movzbl %al,%eax
  801361:	29 c2                	sub    %eax,%edx
  801363:	89 d0                	mov    %edx,%eax
}
  801365:	5d                   	pop    %ebp
  801366:	c3                   	ret    

00801367 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801367:	55                   	push   %ebp
  801368:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80136a:	eb 09                	jmp    801375 <strncmp+0xe>
		n--, p++, q++;
  80136c:	ff 4d 10             	decl   0x10(%ebp)
  80136f:	ff 45 08             	incl   0x8(%ebp)
  801372:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801375:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801379:	74 17                	je     801392 <strncmp+0x2b>
  80137b:	8b 45 08             	mov    0x8(%ebp),%eax
  80137e:	8a 00                	mov    (%eax),%al
  801380:	84 c0                	test   %al,%al
  801382:	74 0e                	je     801392 <strncmp+0x2b>
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	8a 10                	mov    (%eax),%dl
  801389:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138c:	8a 00                	mov    (%eax),%al
  80138e:	38 c2                	cmp    %al,%dl
  801390:	74 da                	je     80136c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801392:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801396:	75 07                	jne    80139f <strncmp+0x38>
		return 0;
  801398:	b8 00 00 00 00       	mov    $0x0,%eax
  80139d:	eb 14                	jmp    8013b3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80139f:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a2:	8a 00                	mov    (%eax),%al
  8013a4:	0f b6 d0             	movzbl %al,%edx
  8013a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	0f b6 c0             	movzbl %al,%eax
  8013af:	29 c2                	sub    %eax,%edx
  8013b1:	89 d0                	mov    %edx,%eax
}
  8013b3:	5d                   	pop    %ebp
  8013b4:	c3                   	ret    

008013b5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013b5:	55                   	push   %ebp
  8013b6:	89 e5                	mov    %esp,%ebp
  8013b8:	83 ec 04             	sub    $0x4,%esp
  8013bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013be:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013c1:	eb 12                	jmp    8013d5 <strchr+0x20>
		if (*s == c)
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	8a 00                	mov    (%eax),%al
  8013c8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013cb:	75 05                	jne    8013d2 <strchr+0x1d>
			return (char *) s;
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	eb 11                	jmp    8013e3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013d2:	ff 45 08             	incl   0x8(%ebp)
  8013d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d8:	8a 00                	mov    (%eax),%al
  8013da:	84 c0                	test   %al,%al
  8013dc:	75 e5                	jne    8013c3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013de:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
  8013e8:	83 ec 04             	sub    $0x4,%esp
  8013eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ee:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013f1:	eb 0d                	jmp    801400 <strfind+0x1b>
		if (*s == c)
  8013f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f6:	8a 00                	mov    (%eax),%al
  8013f8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013fb:	74 0e                	je     80140b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013fd:	ff 45 08             	incl   0x8(%ebp)
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	8a 00                	mov    (%eax),%al
  801405:	84 c0                	test   %al,%al
  801407:	75 ea                	jne    8013f3 <strfind+0xe>
  801409:	eb 01                	jmp    80140c <strfind+0x27>
		if (*s == c)
			break;
  80140b:	90                   	nop
	return (char *) s;
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
  801414:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80141d:	8b 45 10             	mov    0x10(%ebp),%eax
  801420:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801423:	eb 0e                	jmp    801433 <memset+0x22>
		*p++ = c;
  801425:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801428:	8d 50 01             	lea    0x1(%eax),%edx
  80142b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80142e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801431:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801433:	ff 4d f8             	decl   -0x8(%ebp)
  801436:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80143a:	79 e9                	jns    801425 <memset+0x14>
		*p++ = c;

	return v;
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80143f:	c9                   	leave  
  801440:	c3                   	ret    

00801441 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801441:	55                   	push   %ebp
  801442:	89 e5                	mov    %esp,%ebp
  801444:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801447:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801453:	eb 16                	jmp    80146b <memcpy+0x2a>
		*d++ = *s++;
  801455:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801458:	8d 50 01             	lea    0x1(%eax),%edx
  80145b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80145e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801461:	8d 4a 01             	lea    0x1(%edx),%ecx
  801464:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801467:	8a 12                	mov    (%edx),%dl
  801469:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80146b:	8b 45 10             	mov    0x10(%ebp),%eax
  80146e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801471:	89 55 10             	mov    %edx,0x10(%ebp)
  801474:	85 c0                	test   %eax,%eax
  801476:	75 dd                	jne    801455 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
  801480:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801483:	8b 45 0c             	mov    0xc(%ebp),%eax
  801486:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80148f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801492:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801495:	73 50                	jae    8014e7 <memmove+0x6a>
  801497:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80149a:	8b 45 10             	mov    0x10(%ebp),%eax
  80149d:	01 d0                	add    %edx,%eax
  80149f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014a2:	76 43                	jbe    8014e7 <memmove+0x6a>
		s += n;
  8014a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ad:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014b0:	eb 10                	jmp    8014c2 <memmove+0x45>
			*--d = *--s;
  8014b2:	ff 4d f8             	decl   -0x8(%ebp)
  8014b5:	ff 4d fc             	decl   -0x4(%ebp)
  8014b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014bb:	8a 10                	mov    (%eax),%dl
  8014bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014c8:	89 55 10             	mov    %edx,0x10(%ebp)
  8014cb:	85 c0                	test   %eax,%eax
  8014cd:	75 e3                	jne    8014b2 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014cf:	eb 23                	jmp    8014f4 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d4:	8d 50 01             	lea    0x1(%eax),%edx
  8014d7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014da:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014dd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014e0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014e3:	8a 12                	mov    (%edx),%dl
  8014e5:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ea:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ed:	89 55 10             	mov    %edx,0x10(%ebp)
  8014f0:	85 c0                	test   %eax,%eax
  8014f2:	75 dd                	jne    8014d1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f7:	c9                   	leave  
  8014f8:	c3                   	ret    

008014f9 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014f9:	55                   	push   %ebp
  8014fa:	89 e5                	mov    %esp,%ebp
  8014fc:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801502:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801505:	8b 45 0c             	mov    0xc(%ebp),%eax
  801508:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80150b:	eb 2a                	jmp    801537 <memcmp+0x3e>
		if (*s1 != *s2)
  80150d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801510:	8a 10                	mov    (%eax),%dl
  801512:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801515:	8a 00                	mov    (%eax),%al
  801517:	38 c2                	cmp    %al,%dl
  801519:	74 16                	je     801531 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80151b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80151e:	8a 00                	mov    (%eax),%al
  801520:	0f b6 d0             	movzbl %al,%edx
  801523:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801526:	8a 00                	mov    (%eax),%al
  801528:	0f b6 c0             	movzbl %al,%eax
  80152b:	29 c2                	sub    %eax,%edx
  80152d:	89 d0                	mov    %edx,%eax
  80152f:	eb 18                	jmp    801549 <memcmp+0x50>
		s1++, s2++;
  801531:	ff 45 fc             	incl   -0x4(%ebp)
  801534:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801537:	8b 45 10             	mov    0x10(%ebp),%eax
  80153a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80153d:	89 55 10             	mov    %edx,0x10(%ebp)
  801540:	85 c0                	test   %eax,%eax
  801542:	75 c9                	jne    80150d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801544:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801549:	c9                   	leave  
  80154a:	c3                   	ret    

0080154b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80154b:	55                   	push   %ebp
  80154c:	89 e5                	mov    %esp,%ebp
  80154e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801551:	8b 55 08             	mov    0x8(%ebp),%edx
  801554:	8b 45 10             	mov    0x10(%ebp),%eax
  801557:	01 d0                	add    %edx,%eax
  801559:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80155c:	eb 15                	jmp    801573 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80155e:	8b 45 08             	mov    0x8(%ebp),%eax
  801561:	8a 00                	mov    (%eax),%al
  801563:	0f b6 d0             	movzbl %al,%edx
  801566:	8b 45 0c             	mov    0xc(%ebp),%eax
  801569:	0f b6 c0             	movzbl %al,%eax
  80156c:	39 c2                	cmp    %eax,%edx
  80156e:	74 0d                	je     80157d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801570:	ff 45 08             	incl   0x8(%ebp)
  801573:	8b 45 08             	mov    0x8(%ebp),%eax
  801576:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801579:	72 e3                	jb     80155e <memfind+0x13>
  80157b:	eb 01                	jmp    80157e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80157d:	90                   	nop
	return (void *) s;
  80157e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801581:	c9                   	leave  
  801582:	c3                   	ret    

00801583 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801583:	55                   	push   %ebp
  801584:	89 e5                	mov    %esp,%ebp
  801586:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801589:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801590:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801597:	eb 03                	jmp    80159c <strtol+0x19>
		s++;
  801599:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	3c 20                	cmp    $0x20,%al
  8015a3:	74 f4                	je     801599 <strtol+0x16>
  8015a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a8:	8a 00                	mov    (%eax),%al
  8015aa:	3c 09                	cmp    $0x9,%al
  8015ac:	74 eb                	je     801599 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b1:	8a 00                	mov    (%eax),%al
  8015b3:	3c 2b                	cmp    $0x2b,%al
  8015b5:	75 05                	jne    8015bc <strtol+0x39>
		s++;
  8015b7:	ff 45 08             	incl   0x8(%ebp)
  8015ba:	eb 13                	jmp    8015cf <strtol+0x4c>
	else if (*s == '-')
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	8a 00                	mov    (%eax),%al
  8015c1:	3c 2d                	cmp    $0x2d,%al
  8015c3:	75 0a                	jne    8015cf <strtol+0x4c>
		s++, neg = 1;
  8015c5:	ff 45 08             	incl   0x8(%ebp)
  8015c8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015cf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015d3:	74 06                	je     8015db <strtol+0x58>
  8015d5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015d9:	75 20                	jne    8015fb <strtol+0x78>
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	8a 00                	mov    (%eax),%al
  8015e0:	3c 30                	cmp    $0x30,%al
  8015e2:	75 17                	jne    8015fb <strtol+0x78>
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	40                   	inc    %eax
  8015e8:	8a 00                	mov    (%eax),%al
  8015ea:	3c 78                	cmp    $0x78,%al
  8015ec:	75 0d                	jne    8015fb <strtol+0x78>
		s += 2, base = 16;
  8015ee:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015f2:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015f9:	eb 28                	jmp    801623 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015ff:	75 15                	jne    801616 <strtol+0x93>
  801601:	8b 45 08             	mov    0x8(%ebp),%eax
  801604:	8a 00                	mov    (%eax),%al
  801606:	3c 30                	cmp    $0x30,%al
  801608:	75 0c                	jne    801616 <strtol+0x93>
		s++, base = 8;
  80160a:	ff 45 08             	incl   0x8(%ebp)
  80160d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801614:	eb 0d                	jmp    801623 <strtol+0xa0>
	else if (base == 0)
  801616:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80161a:	75 07                	jne    801623 <strtol+0xa0>
		base = 10;
  80161c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
  801626:	8a 00                	mov    (%eax),%al
  801628:	3c 2f                	cmp    $0x2f,%al
  80162a:	7e 19                	jle    801645 <strtol+0xc2>
  80162c:	8b 45 08             	mov    0x8(%ebp),%eax
  80162f:	8a 00                	mov    (%eax),%al
  801631:	3c 39                	cmp    $0x39,%al
  801633:	7f 10                	jg     801645 <strtol+0xc2>
			dig = *s - '0';
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	8a 00                	mov    (%eax),%al
  80163a:	0f be c0             	movsbl %al,%eax
  80163d:	83 e8 30             	sub    $0x30,%eax
  801640:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801643:	eb 42                	jmp    801687 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
  801648:	8a 00                	mov    (%eax),%al
  80164a:	3c 60                	cmp    $0x60,%al
  80164c:	7e 19                	jle    801667 <strtol+0xe4>
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8a 00                	mov    (%eax),%al
  801653:	3c 7a                	cmp    $0x7a,%al
  801655:	7f 10                	jg     801667 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801657:	8b 45 08             	mov    0x8(%ebp),%eax
  80165a:	8a 00                	mov    (%eax),%al
  80165c:	0f be c0             	movsbl %al,%eax
  80165f:	83 e8 57             	sub    $0x57,%eax
  801662:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801665:	eb 20                	jmp    801687 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	8a 00                	mov    (%eax),%al
  80166c:	3c 40                	cmp    $0x40,%al
  80166e:	7e 39                	jle    8016a9 <strtol+0x126>
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	8a 00                	mov    (%eax),%al
  801675:	3c 5a                	cmp    $0x5a,%al
  801677:	7f 30                	jg     8016a9 <strtol+0x126>
			dig = *s - 'A' + 10;
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	8a 00                	mov    (%eax),%al
  80167e:	0f be c0             	movsbl %al,%eax
  801681:	83 e8 37             	sub    $0x37,%eax
  801684:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801687:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80168a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80168d:	7d 19                	jge    8016a8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80168f:	ff 45 08             	incl   0x8(%ebp)
  801692:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801695:	0f af 45 10          	imul   0x10(%ebp),%eax
  801699:	89 c2                	mov    %eax,%edx
  80169b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80169e:	01 d0                	add    %edx,%eax
  8016a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016a3:	e9 7b ff ff ff       	jmp    801623 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016a8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016ad:	74 08                	je     8016b7 <strtol+0x134>
		*endptr = (char *) s;
  8016af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016b2:	8b 55 08             	mov    0x8(%ebp),%edx
  8016b5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016b7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016bb:	74 07                	je     8016c4 <strtol+0x141>
  8016bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c0:	f7 d8                	neg    %eax
  8016c2:	eb 03                	jmp    8016c7 <strtol+0x144>
  8016c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <ltostr>:

void
ltostr(long value, char *str)
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
  8016cc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016d6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016e1:	79 13                	jns    8016f6 <ltostr+0x2d>
	{
		neg = 1;
  8016e3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ed:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016f0:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016f3:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016fe:	99                   	cltd   
  8016ff:	f7 f9                	idiv   %ecx
  801701:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801704:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801707:	8d 50 01             	lea    0x1(%eax),%edx
  80170a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80170d:	89 c2                	mov    %eax,%edx
  80170f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801712:	01 d0                	add    %edx,%eax
  801714:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801717:	83 c2 30             	add    $0x30,%edx
  80171a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80171c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80171f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801724:	f7 e9                	imul   %ecx
  801726:	c1 fa 02             	sar    $0x2,%edx
  801729:	89 c8                	mov    %ecx,%eax
  80172b:	c1 f8 1f             	sar    $0x1f,%eax
  80172e:	29 c2                	sub    %eax,%edx
  801730:	89 d0                	mov    %edx,%eax
  801732:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801735:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801738:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80173d:	f7 e9                	imul   %ecx
  80173f:	c1 fa 02             	sar    $0x2,%edx
  801742:	89 c8                	mov    %ecx,%eax
  801744:	c1 f8 1f             	sar    $0x1f,%eax
  801747:	29 c2                	sub    %eax,%edx
  801749:	89 d0                	mov    %edx,%eax
  80174b:	c1 e0 02             	shl    $0x2,%eax
  80174e:	01 d0                	add    %edx,%eax
  801750:	01 c0                	add    %eax,%eax
  801752:	29 c1                	sub    %eax,%ecx
  801754:	89 ca                	mov    %ecx,%edx
  801756:	85 d2                	test   %edx,%edx
  801758:	75 9c                	jne    8016f6 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80175a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801761:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801764:	48                   	dec    %eax
  801765:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801768:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80176c:	74 3d                	je     8017ab <ltostr+0xe2>
		start = 1 ;
  80176e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801775:	eb 34                	jmp    8017ab <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801777:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80177a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177d:	01 d0                	add    %edx,%eax
  80177f:	8a 00                	mov    (%eax),%al
  801781:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801784:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801787:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178a:	01 c2                	add    %eax,%edx
  80178c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80178f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801792:	01 c8                	add    %ecx,%eax
  801794:	8a 00                	mov    (%eax),%al
  801796:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801798:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80179b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179e:	01 c2                	add    %eax,%edx
  8017a0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017a3:	88 02                	mov    %al,(%edx)
		start++ ;
  8017a5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017a8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ae:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017b1:	7c c4                	jl     801777 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017b3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b9:	01 d0                	add    %edx,%eax
  8017bb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017be:	90                   	nop
  8017bf:	c9                   	leave  
  8017c0:	c3                   	ret    

008017c1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017c1:	55                   	push   %ebp
  8017c2:	89 e5                	mov    %esp,%ebp
  8017c4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017c7:	ff 75 08             	pushl  0x8(%ebp)
  8017ca:	e8 54 fa ff ff       	call   801223 <strlen>
  8017cf:	83 c4 04             	add    $0x4,%esp
  8017d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017d5:	ff 75 0c             	pushl  0xc(%ebp)
  8017d8:	e8 46 fa ff ff       	call   801223 <strlen>
  8017dd:	83 c4 04             	add    $0x4,%esp
  8017e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017f1:	eb 17                	jmp    80180a <strcconcat+0x49>
		final[s] = str1[s] ;
  8017f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f9:	01 c2                	add    %eax,%edx
  8017fb:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801801:	01 c8                	add    %ecx,%eax
  801803:	8a 00                	mov    (%eax),%al
  801805:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801807:	ff 45 fc             	incl   -0x4(%ebp)
  80180a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80180d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801810:	7c e1                	jl     8017f3 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801812:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801819:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801820:	eb 1f                	jmp    801841 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801822:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801825:	8d 50 01             	lea    0x1(%eax),%edx
  801828:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80182b:	89 c2                	mov    %eax,%edx
  80182d:	8b 45 10             	mov    0x10(%ebp),%eax
  801830:	01 c2                	add    %eax,%edx
  801832:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801835:	8b 45 0c             	mov    0xc(%ebp),%eax
  801838:	01 c8                	add    %ecx,%eax
  80183a:	8a 00                	mov    (%eax),%al
  80183c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80183e:	ff 45 f8             	incl   -0x8(%ebp)
  801841:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801844:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801847:	7c d9                	jl     801822 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801849:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80184c:	8b 45 10             	mov    0x10(%ebp),%eax
  80184f:	01 d0                	add    %edx,%eax
  801851:	c6 00 00             	movb   $0x0,(%eax)
}
  801854:	90                   	nop
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80185a:	8b 45 14             	mov    0x14(%ebp),%eax
  80185d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801863:	8b 45 14             	mov    0x14(%ebp),%eax
  801866:	8b 00                	mov    (%eax),%eax
  801868:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80186f:	8b 45 10             	mov    0x10(%ebp),%eax
  801872:	01 d0                	add    %edx,%eax
  801874:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80187a:	eb 0c                	jmp    801888 <strsplit+0x31>
			*string++ = 0;
  80187c:	8b 45 08             	mov    0x8(%ebp),%eax
  80187f:	8d 50 01             	lea    0x1(%eax),%edx
  801882:	89 55 08             	mov    %edx,0x8(%ebp)
  801885:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801888:	8b 45 08             	mov    0x8(%ebp),%eax
  80188b:	8a 00                	mov    (%eax),%al
  80188d:	84 c0                	test   %al,%al
  80188f:	74 18                	je     8018a9 <strsplit+0x52>
  801891:	8b 45 08             	mov    0x8(%ebp),%eax
  801894:	8a 00                	mov    (%eax),%al
  801896:	0f be c0             	movsbl %al,%eax
  801899:	50                   	push   %eax
  80189a:	ff 75 0c             	pushl  0xc(%ebp)
  80189d:	e8 13 fb ff ff       	call   8013b5 <strchr>
  8018a2:	83 c4 08             	add    $0x8,%esp
  8018a5:	85 c0                	test   %eax,%eax
  8018a7:	75 d3                	jne    80187c <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	8a 00                	mov    (%eax),%al
  8018ae:	84 c0                	test   %al,%al
  8018b0:	74 5a                	je     80190c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b5:	8b 00                	mov    (%eax),%eax
  8018b7:	83 f8 0f             	cmp    $0xf,%eax
  8018ba:	75 07                	jne    8018c3 <strsplit+0x6c>
		{
			return 0;
  8018bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8018c1:	eb 66                	jmp    801929 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8018c6:	8b 00                	mov    (%eax),%eax
  8018c8:	8d 48 01             	lea    0x1(%eax),%ecx
  8018cb:	8b 55 14             	mov    0x14(%ebp),%edx
  8018ce:	89 0a                	mov    %ecx,(%edx)
  8018d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018da:	01 c2                	add    %eax,%edx
  8018dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018df:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018e1:	eb 03                	jmp    8018e6 <strsplit+0x8f>
			string++;
  8018e3:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e9:	8a 00                	mov    (%eax),%al
  8018eb:	84 c0                	test   %al,%al
  8018ed:	74 8b                	je     80187a <strsplit+0x23>
  8018ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f2:	8a 00                	mov    (%eax),%al
  8018f4:	0f be c0             	movsbl %al,%eax
  8018f7:	50                   	push   %eax
  8018f8:	ff 75 0c             	pushl  0xc(%ebp)
  8018fb:	e8 b5 fa ff ff       	call   8013b5 <strchr>
  801900:	83 c4 08             	add    $0x8,%esp
  801903:	85 c0                	test   %eax,%eax
  801905:	74 dc                	je     8018e3 <strsplit+0x8c>
			string++;
	}
  801907:	e9 6e ff ff ff       	jmp    80187a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80190c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80190d:	8b 45 14             	mov    0x14(%ebp),%eax
  801910:	8b 00                	mov    (%eax),%eax
  801912:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801919:	8b 45 10             	mov    0x10(%ebp),%eax
  80191c:	01 d0                	add    %edx,%eax
  80191e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801924:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801929:	c9                   	leave  
  80192a:	c3                   	ret    

0080192b <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

void* malloc(uint32 size) {
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
  80192e:	83 ec 28             	sub    $0x28,%esp
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,


	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801931:	e8 31 08 00 00       	call   802167 <sys_isUHeapPlacementStrategyNEXTFIT>
  801936:	85 c0                	test   %eax,%eax
  801938:	0f 84 64 01 00 00    	je     801aa2 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  80193e:	8b 0d 2c 30 80 00    	mov    0x80302c,%ecx
  801944:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  80194b:	8b 55 08             	mov    0x8(%ebp),%edx
  80194e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801951:	01 d0                	add    %edx,%eax
  801953:	48                   	dec    %eax
  801954:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801957:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80195a:	ba 00 00 00 00       	mov    $0x0,%edx
  80195f:	f7 75 e8             	divl   -0x18(%ebp)
  801962:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801965:	29 d0                	sub    %edx,%eax
  801967:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  80196e:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801974:	8b 45 08             	mov    0x8(%ebp),%eax
  801977:	01 d0                	add    %edx,%eax
  801979:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  80197c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801983:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801988:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80198f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801992:	0f 83 0a 01 00 00    	jae    801aa2 <malloc+0x177>
  801998:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80199d:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8019a4:	85 c0                	test   %eax,%eax
  8019a6:	0f 84 f6 00 00 00    	je     801aa2 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8019ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019b3:	e9 dc 00 00 00       	jmp    801a94 <malloc+0x169>
				flag++;
  8019b8:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  8019bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019be:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8019c5:	85 c0                	test   %eax,%eax
  8019c7:	74 07                	je     8019d0 <malloc+0xa5>
					flag=0;
  8019c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  8019d0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019d5:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8019dc:	85 c0                	test   %eax,%eax
  8019de:	79 05                	jns    8019e5 <malloc+0xba>
  8019e0:	05 ff 0f 00 00       	add    $0xfff,%eax
  8019e5:	c1 f8 0c             	sar    $0xc,%eax
  8019e8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019eb:	0f 85 a0 00 00 00    	jne    801a91 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  8019f1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019f6:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8019fd:	85 c0                	test   %eax,%eax
  8019ff:	79 05                	jns    801a06 <malloc+0xdb>
  801a01:	05 ff 0f 00 00       	add    $0xfff,%eax
  801a06:	c1 f8 0c             	sar    $0xc,%eax
  801a09:	89 c2                	mov    %eax,%edx
  801a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a0e:	29 d0                	sub    %edx,%eax
  801a10:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801a13:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a16:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801a19:	eb 11                	jmp    801a2c <malloc+0x101>
						hFreeArr[j] = 1;
  801a1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a1e:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801a25:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801a29:	ff 45 ec             	incl   -0x14(%ebp)
  801a2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a2f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a32:	7e e7                	jle    801a1b <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801a34:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a39:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801a3c:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801a42:	c1 e2 0c             	shl    $0xc,%edx
  801a45:	89 15 04 30 80 00    	mov    %edx,0x803004
  801a4b:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801a51:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801a58:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a5d:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801a64:	89 c2                	mov    %eax,%edx
  801a66:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a6b:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801a72:	83 ec 08             	sub    $0x8,%esp
  801a75:	52                   	push   %edx
  801a76:	50                   	push   %eax
  801a77:	e8 21 03 00 00       	call   801d9d <sys_allocateMem>
  801a7c:	83 c4 10             	add    $0x10,%esp

					idx++;
  801a7f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a84:	40                   	inc    %eax
  801a85:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*)startAdd;
  801a8a:	a1 04 30 80 00       	mov    0x803004,%eax
  801a8f:	eb 16                	jmp    801aa7 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801a91:	ff 45 f0             	incl   -0x10(%ebp)
  801a94:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a97:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a9c:	0f 86 16 ff ff ff    	jbe    8019b8 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801aa2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aa7:	c9                   	leave  
  801aa8:	c3                   	ret    

00801aa9 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801aa9:	55                   	push   %ebp
  801aaa:	89 e5                	mov    %esp,%ebp
  801aac:	83 ec 18             	sub    $0x18,%esp
  801aaf:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab2:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801ab5:	83 ec 04             	sub    $0x4,%esp
  801ab8:	68 70 2b 80 00       	push   $0x802b70
  801abd:	6a 5a                	push   $0x5a
  801abf:	68 8f 2b 80 00       	push   $0x802b8f
  801ac4:	e8 24 ee ff ff       	call   8008ed <_panic>

00801ac9 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801ac9:	55                   	push   %ebp
  801aca:	89 e5                	mov    %esp,%ebp
  801acc:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801acf:	83 ec 04             	sub    $0x4,%esp
  801ad2:	68 9b 2b 80 00       	push   $0x802b9b
  801ad7:	6a 60                	push   $0x60
  801ad9:	68 8f 2b 80 00       	push   $0x802b8f
  801ade:	e8 0a ee ff ff       	call   8008ed <_panic>

00801ae3 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801ae3:	55                   	push   %ebp
  801ae4:	89 e5                	mov    %esp,%ebp
  801ae6:	83 ec 18             	sub    $0x18,%esp

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  801ae9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801af0:	e9 8a 00 00 00       	jmp    801b7f <free+0x9c>
		if (virtual_address == (void*)uHeapArr[i].first) {
  801af5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801af8:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801aff:	3b 45 08             	cmp    0x8(%ebp),%eax
  801b02:	75 78                	jne    801b7c <free+0x99>
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
  801b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b07:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801b0e:	05 00 00 00 80       	add    $0x80000000,%eax
  801b13:	c1 e8 0c             	shr    $0xc,%eax
  801b16:	89 45 ec             	mov    %eax,-0x14(%ebp)
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;
  801b19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b1c:	8b 14 c5 44 30 88 00 	mov    0x883044(,%eax,8),%edx
  801b23:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b26:	01 d0                	add    %edx,%eax
  801b28:	85 c0                	test   %eax,%eax
  801b2a:	79 05                	jns    801b31 <free+0x4e>
  801b2c:	05 ff 0f 00 00       	add    $0xfff,%eax
  801b31:	c1 f8 0c             	sar    $0xc,%eax
  801b34:	89 45 e8             	mov    %eax,-0x18(%ebp)

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  801b37:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b3d:	eb 19                	jmp    801b58 <free+0x75>
				sys_freeMem((uint32)j, fIDX);
  801b3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b42:	83 ec 08             	sub    $0x8,%esp
  801b45:	50                   	push   %eax
  801b46:	ff 75 f0             	pushl  -0x10(%ebp)
  801b49:	e8 33 02 00 00       	call   801d81 <sys_freeMem>
  801b4e:	83 c4 10             	add    $0x10,%esp
	for(int i=0; i<idx; i++) {
		if (virtual_address == (void*)uHeapArr[i].first) {
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  801b51:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
  801b58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b5b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b5e:	72 df                	jb     801b3f <free+0x5c>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
  801b60:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b63:	c7 04 c5 44 30 88 00 	movl   $0x0,0x883044(,%eax,8)
  801b6a:	00 00 00 00 
  801b6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b71:	c7 04 c5 40 30 88 00 	movl   $0x0,0x883040(,%eax,8)
  801b78:	00 00 00 00 

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  801b7c:	ff 45 f4             	incl   -0xc(%ebp)
  801b7f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b84:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  801b87:	0f 8c 68 ff ff ff    	jl     801af5 <free+0x12>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
		}
	}
}
  801b8d:	90                   	nop
  801b8e:	c9                   	leave  
  801b8f:	c3                   	ret    

00801b90 <sfree>:


void sfree(void* virtual_address)
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
  801b93:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801b96:	83 ec 04             	sub    $0x4,%esp
  801b99:	68 b7 2b 80 00       	push   $0x802bb7
  801b9e:	68 87 00 00 00       	push   $0x87
  801ba3:	68 8f 2b 80 00       	push   $0x802b8f
  801ba8:	e8 40 ed ff ff       	call   8008ed <_panic>

00801bad <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801bad:	55                   	push   %ebp
  801bae:	89 e5                	mov    %esp,%ebp
  801bb0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801bb3:	83 ec 04             	sub    $0x4,%esp
  801bb6:	68 d4 2b 80 00       	push   $0x802bd4
  801bbb:	68 9f 00 00 00       	push   $0x9f
  801bc0:	68 8f 2b 80 00       	push   $0x802b8f
  801bc5:	e8 23 ed ff ff       	call   8008ed <_panic>

00801bca <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801bca:	55                   	push   %ebp
  801bcb:	89 e5                	mov    %esp,%ebp
  801bcd:	57                   	push   %edi
  801bce:	56                   	push   %esi
  801bcf:	53                   	push   %ebx
  801bd0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bdc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bdf:	8b 7d 18             	mov    0x18(%ebp),%edi
  801be2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801be5:	cd 30                	int    $0x30
  801be7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801bea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bed:	83 c4 10             	add    $0x10,%esp
  801bf0:	5b                   	pop    %ebx
  801bf1:	5e                   	pop    %esi
  801bf2:	5f                   	pop    %edi
  801bf3:	5d                   	pop    %ebp
  801bf4:	c3                   	ret    

00801bf5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801bf5:	55                   	push   %ebp
  801bf6:	89 e5                	mov    %esp,%ebp
  801bf8:	83 ec 04             	sub    $0x4,%esp
  801bfb:	8b 45 10             	mov    0x10(%ebp),%eax
  801bfe:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c01:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c05:	8b 45 08             	mov    0x8(%ebp),%eax
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	52                   	push   %edx
  801c0d:	ff 75 0c             	pushl  0xc(%ebp)
  801c10:	50                   	push   %eax
  801c11:	6a 00                	push   $0x0
  801c13:	e8 b2 ff ff ff       	call   801bca <syscall>
  801c18:	83 c4 18             	add    $0x18,%esp
}
  801c1b:	90                   	nop
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <sys_cgetc>:

int
sys_cgetc(void)
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 01                	push   $0x1
  801c2d:	e8 98 ff ff ff       	call   801bca <syscall>
  801c32:	83 c4 18             	add    $0x18,%esp
}
  801c35:	c9                   	leave  
  801c36:	c3                   	ret    

00801c37 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c37:	55                   	push   %ebp
  801c38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	50                   	push   %eax
  801c46:	6a 05                	push   $0x5
  801c48:	e8 7d ff ff ff       	call   801bca <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
}
  801c50:	c9                   	leave  
  801c51:	c3                   	ret    

00801c52 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c52:	55                   	push   %ebp
  801c53:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 02                	push   $0x2
  801c61:	e8 64 ff ff ff       	call   801bca <syscall>
  801c66:	83 c4 18             	add    $0x18,%esp
}
  801c69:	c9                   	leave  
  801c6a:	c3                   	ret    

00801c6b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c6b:	55                   	push   %ebp
  801c6c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 03                	push   $0x3
  801c7a:	e8 4b ff ff ff       	call   801bca <syscall>
  801c7f:	83 c4 18             	add    $0x18,%esp
}
  801c82:	c9                   	leave  
  801c83:	c3                   	ret    

00801c84 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c84:	55                   	push   %ebp
  801c85:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 04                	push   $0x4
  801c93:	e8 32 ff ff ff       	call   801bca <syscall>
  801c98:	83 c4 18             	add    $0x18,%esp
}
  801c9b:	c9                   	leave  
  801c9c:	c3                   	ret    

00801c9d <sys_env_exit>:


void sys_env_exit(void)
{
  801c9d:	55                   	push   %ebp
  801c9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 06                	push   $0x6
  801cac:	e8 19 ff ff ff       	call   801bca <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
}
  801cb4:	90                   	nop
  801cb5:	c9                   	leave  
  801cb6:	c3                   	ret    

00801cb7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801cb7:	55                   	push   %ebp
  801cb8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801cba:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	52                   	push   %edx
  801cc7:	50                   	push   %eax
  801cc8:	6a 07                	push   $0x7
  801cca:	e8 fb fe ff ff       	call   801bca <syscall>
  801ccf:	83 c4 18             	add    $0x18,%esp
}
  801cd2:	c9                   	leave  
  801cd3:	c3                   	ret    

00801cd4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801cd4:	55                   	push   %ebp
  801cd5:	89 e5                	mov    %esp,%ebp
  801cd7:	56                   	push   %esi
  801cd8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801cd9:	8b 75 18             	mov    0x18(%ebp),%esi
  801cdc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cdf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ce2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce8:	56                   	push   %esi
  801ce9:	53                   	push   %ebx
  801cea:	51                   	push   %ecx
  801ceb:	52                   	push   %edx
  801cec:	50                   	push   %eax
  801ced:	6a 08                	push   $0x8
  801cef:	e8 d6 fe ff ff       	call   801bca <syscall>
  801cf4:	83 c4 18             	add    $0x18,%esp
}
  801cf7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801cfa:	5b                   	pop    %ebx
  801cfb:	5e                   	pop    %esi
  801cfc:	5d                   	pop    %ebp
  801cfd:	c3                   	ret    

00801cfe <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801cfe:	55                   	push   %ebp
  801cff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d01:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d04:	8b 45 08             	mov    0x8(%ebp),%eax
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	52                   	push   %edx
  801d0e:	50                   	push   %eax
  801d0f:	6a 09                	push   $0x9
  801d11:	e8 b4 fe ff ff       	call   801bca <syscall>
  801d16:	83 c4 18             	add    $0x18,%esp
}
  801d19:	c9                   	leave  
  801d1a:	c3                   	ret    

00801d1b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	ff 75 0c             	pushl  0xc(%ebp)
  801d27:	ff 75 08             	pushl  0x8(%ebp)
  801d2a:	6a 0a                	push   $0xa
  801d2c:	e8 99 fe ff ff       	call   801bca <syscall>
  801d31:	83 c4 18             	add    $0x18,%esp
}
  801d34:	c9                   	leave  
  801d35:	c3                   	ret    

00801d36 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 0b                	push   $0xb
  801d45:	e8 80 fe ff ff       	call   801bca <syscall>
  801d4a:	83 c4 18             	add    $0x18,%esp
}
  801d4d:	c9                   	leave  
  801d4e:	c3                   	ret    

00801d4f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d4f:	55                   	push   %ebp
  801d50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d52:	6a 00                	push   $0x0
  801d54:	6a 00                	push   $0x0
  801d56:	6a 00                	push   $0x0
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 0c                	push   $0xc
  801d5e:	e8 67 fe ff ff       	call   801bca <syscall>
  801d63:	83 c4 18             	add    $0x18,%esp
}
  801d66:	c9                   	leave  
  801d67:	c3                   	ret    

00801d68 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d68:	55                   	push   %ebp
  801d69:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 0d                	push   $0xd
  801d77:	e8 4e fe ff ff       	call   801bca <syscall>
  801d7c:	83 c4 18             	add    $0x18,%esp
}
  801d7f:	c9                   	leave  
  801d80:	c3                   	ret    

00801d81 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d81:	55                   	push   %ebp
  801d82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	6a 00                	push   $0x0
  801d8a:	ff 75 0c             	pushl  0xc(%ebp)
  801d8d:	ff 75 08             	pushl  0x8(%ebp)
  801d90:	6a 11                	push   $0x11
  801d92:	e8 33 fe ff ff       	call   801bca <syscall>
  801d97:	83 c4 18             	add    $0x18,%esp
	return;
  801d9a:	90                   	nop
}
  801d9b:	c9                   	leave  
  801d9c:	c3                   	ret    

00801d9d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d9d:	55                   	push   %ebp
  801d9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	ff 75 0c             	pushl  0xc(%ebp)
  801da9:	ff 75 08             	pushl  0x8(%ebp)
  801dac:	6a 12                	push   $0x12
  801dae:	e8 17 fe ff ff       	call   801bca <syscall>
  801db3:	83 c4 18             	add    $0x18,%esp
	return ;
  801db6:	90                   	nop
}
  801db7:	c9                   	leave  
  801db8:	c3                   	ret    

00801db9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801db9:	55                   	push   %ebp
  801dba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 0e                	push   $0xe
  801dc8:	e8 fd fd ff ff       	call   801bca <syscall>
  801dcd:	83 c4 18             	add    $0x18,%esp
}
  801dd0:	c9                   	leave  
  801dd1:	c3                   	ret    

00801dd2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801dd2:	55                   	push   %ebp
  801dd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	ff 75 08             	pushl  0x8(%ebp)
  801de0:	6a 0f                	push   $0xf
  801de2:	e8 e3 fd ff ff       	call   801bca <syscall>
  801de7:	83 c4 18             	add    $0x18,%esp
}
  801dea:	c9                   	leave  
  801deb:	c3                   	ret    

00801dec <sys_scarce_memory>:

void sys_scarce_memory()
{
  801dec:	55                   	push   %ebp
  801ded:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 10                	push   $0x10
  801dfb:	e8 ca fd ff ff       	call   801bca <syscall>
  801e00:	83 c4 18             	add    $0x18,%esp
}
  801e03:	90                   	nop
  801e04:	c9                   	leave  
  801e05:	c3                   	ret    

00801e06 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e06:	55                   	push   %ebp
  801e07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 14                	push   $0x14
  801e15:	e8 b0 fd ff ff       	call   801bca <syscall>
  801e1a:	83 c4 18             	add    $0x18,%esp
}
  801e1d:	90                   	nop
  801e1e:	c9                   	leave  
  801e1f:	c3                   	ret    

00801e20 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e20:	55                   	push   %ebp
  801e21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 15                	push   $0x15
  801e2f:	e8 96 fd ff ff       	call   801bca <syscall>
  801e34:	83 c4 18             	add    $0x18,%esp
}
  801e37:	90                   	nop
  801e38:	c9                   	leave  
  801e39:	c3                   	ret    

00801e3a <sys_cputc>:


void
sys_cputc(const char c)
{
  801e3a:	55                   	push   %ebp
  801e3b:	89 e5                	mov    %esp,%ebp
  801e3d:	83 ec 04             	sub    $0x4,%esp
  801e40:	8b 45 08             	mov    0x8(%ebp),%eax
  801e43:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e46:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	50                   	push   %eax
  801e53:	6a 16                	push   $0x16
  801e55:	e8 70 fd ff ff       	call   801bca <syscall>
  801e5a:	83 c4 18             	add    $0x18,%esp
}
  801e5d:	90                   	nop
  801e5e:	c9                   	leave  
  801e5f:	c3                   	ret    

00801e60 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e60:	55                   	push   %ebp
  801e61:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 17                	push   $0x17
  801e6f:	e8 56 fd ff ff       	call   801bca <syscall>
  801e74:	83 c4 18             	add    $0x18,%esp
}
  801e77:	90                   	nop
  801e78:	c9                   	leave  
  801e79:	c3                   	ret    

00801e7a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e7a:	55                   	push   %ebp
  801e7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	ff 75 0c             	pushl  0xc(%ebp)
  801e89:	50                   	push   %eax
  801e8a:	6a 18                	push   $0x18
  801e8c:	e8 39 fd ff ff       	call   801bca <syscall>
  801e91:	83 c4 18             	add    $0x18,%esp
}
  801e94:	c9                   	leave  
  801e95:	c3                   	ret    

00801e96 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e96:	55                   	push   %ebp
  801e97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e99:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	52                   	push   %edx
  801ea6:	50                   	push   %eax
  801ea7:	6a 1b                	push   $0x1b
  801ea9:	e8 1c fd ff ff       	call   801bca <syscall>
  801eae:	83 c4 18             	add    $0x18,%esp
}
  801eb1:	c9                   	leave  
  801eb2:	c3                   	ret    

00801eb3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801eb3:	55                   	push   %ebp
  801eb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801eb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	52                   	push   %edx
  801ec3:	50                   	push   %eax
  801ec4:	6a 19                	push   $0x19
  801ec6:	e8 ff fc ff ff       	call   801bca <syscall>
  801ecb:	83 c4 18             	add    $0x18,%esp
}
  801ece:	90                   	nop
  801ecf:	c9                   	leave  
  801ed0:	c3                   	ret    

00801ed1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ed1:	55                   	push   %ebp
  801ed2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ed4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eda:	6a 00                	push   $0x0
  801edc:	6a 00                	push   $0x0
  801ede:	6a 00                	push   $0x0
  801ee0:	52                   	push   %edx
  801ee1:	50                   	push   %eax
  801ee2:	6a 1a                	push   $0x1a
  801ee4:	e8 e1 fc ff ff       	call   801bca <syscall>
  801ee9:	83 c4 18             	add    $0x18,%esp
}
  801eec:	90                   	nop
  801eed:	c9                   	leave  
  801eee:	c3                   	ret    

00801eef <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801eef:	55                   	push   %ebp
  801ef0:	89 e5                	mov    %esp,%ebp
  801ef2:	83 ec 04             	sub    $0x4,%esp
  801ef5:	8b 45 10             	mov    0x10(%ebp),%eax
  801ef8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801efb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801efe:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f02:	8b 45 08             	mov    0x8(%ebp),%eax
  801f05:	6a 00                	push   $0x0
  801f07:	51                   	push   %ecx
  801f08:	52                   	push   %edx
  801f09:	ff 75 0c             	pushl  0xc(%ebp)
  801f0c:	50                   	push   %eax
  801f0d:	6a 1c                	push   $0x1c
  801f0f:	e8 b6 fc ff ff       	call   801bca <syscall>
  801f14:	83 c4 18             	add    $0x18,%esp
}
  801f17:	c9                   	leave  
  801f18:	c3                   	ret    

00801f19 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f19:	55                   	push   %ebp
  801f1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f22:	6a 00                	push   $0x0
  801f24:	6a 00                	push   $0x0
  801f26:	6a 00                	push   $0x0
  801f28:	52                   	push   %edx
  801f29:	50                   	push   %eax
  801f2a:	6a 1d                	push   $0x1d
  801f2c:	e8 99 fc ff ff       	call   801bca <syscall>
  801f31:	83 c4 18             	add    $0x18,%esp
}
  801f34:	c9                   	leave  
  801f35:	c3                   	ret    

00801f36 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f36:	55                   	push   %ebp
  801f37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f39:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	51                   	push   %ecx
  801f47:	52                   	push   %edx
  801f48:	50                   	push   %eax
  801f49:	6a 1e                	push   $0x1e
  801f4b:	e8 7a fc ff ff       	call   801bca <syscall>
  801f50:	83 c4 18             	add    $0x18,%esp
}
  801f53:	c9                   	leave  
  801f54:	c3                   	ret    

00801f55 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f55:	55                   	push   %ebp
  801f56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f58:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	52                   	push   %edx
  801f65:	50                   	push   %eax
  801f66:	6a 1f                	push   $0x1f
  801f68:	e8 5d fc ff ff       	call   801bca <syscall>
  801f6d:	83 c4 18             	add    $0x18,%esp
}
  801f70:	c9                   	leave  
  801f71:	c3                   	ret    

00801f72 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f72:	55                   	push   %ebp
  801f73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 20                	push   $0x20
  801f81:	e8 44 fc ff ff       	call   801bca <syscall>
  801f86:	83 c4 18             	add    $0x18,%esp
}
  801f89:	c9                   	leave  
  801f8a:	c3                   	ret    

00801f8b <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801f8b:	55                   	push   %ebp
  801f8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	ff 75 10             	pushl  0x10(%ebp)
  801f98:	ff 75 0c             	pushl  0xc(%ebp)
  801f9b:	50                   	push   %eax
  801f9c:	6a 21                	push   $0x21
  801f9e:	e8 27 fc ff ff       	call   801bca <syscall>
  801fa3:	83 c4 18             	add    $0x18,%esp
}
  801fa6:	c9                   	leave  
  801fa7:	c3                   	ret    

00801fa8 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801fa8:	55                   	push   %ebp
  801fa9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801fab:	8b 45 08             	mov    0x8(%ebp),%eax
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	50                   	push   %eax
  801fb7:	6a 22                	push   $0x22
  801fb9:	e8 0c fc ff ff       	call   801bca <syscall>
  801fbe:	83 c4 18             	add    $0x18,%esp
}
  801fc1:	90                   	nop
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801fc4:	55                   	push   %ebp
  801fc5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	50                   	push   %eax
  801fd3:	6a 23                	push   $0x23
  801fd5:	e8 f0 fb ff ff       	call   801bca <syscall>
  801fda:	83 c4 18             	add    $0x18,%esp
}
  801fdd:	90                   	nop
  801fde:	c9                   	leave  
  801fdf:	c3                   	ret    

00801fe0 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801fe0:	55                   	push   %ebp
  801fe1:	89 e5                	mov    %esp,%ebp
  801fe3:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801fe6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fe9:	8d 50 04             	lea    0x4(%eax),%edx
  801fec:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	52                   	push   %edx
  801ff6:	50                   	push   %eax
  801ff7:	6a 24                	push   $0x24
  801ff9:	e8 cc fb ff ff       	call   801bca <syscall>
  801ffe:	83 c4 18             	add    $0x18,%esp
	return result;
  802001:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802004:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802007:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80200a:	89 01                	mov    %eax,(%ecx)
  80200c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80200f:	8b 45 08             	mov    0x8(%ebp),%eax
  802012:	c9                   	leave  
  802013:	c2 04 00             	ret    $0x4

00802016 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802016:	55                   	push   %ebp
  802017:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	ff 75 10             	pushl  0x10(%ebp)
  802020:	ff 75 0c             	pushl  0xc(%ebp)
  802023:	ff 75 08             	pushl  0x8(%ebp)
  802026:	6a 13                	push   $0x13
  802028:	e8 9d fb ff ff       	call   801bca <syscall>
  80202d:	83 c4 18             	add    $0x18,%esp
	return ;
  802030:	90                   	nop
}
  802031:	c9                   	leave  
  802032:	c3                   	ret    

00802033 <sys_rcr2>:
uint32 sys_rcr2()
{
  802033:	55                   	push   %ebp
  802034:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	6a 25                	push   $0x25
  802042:	e8 83 fb ff ff       	call   801bca <syscall>
  802047:	83 c4 18             	add    $0x18,%esp
}
  80204a:	c9                   	leave  
  80204b:	c3                   	ret    

0080204c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80204c:	55                   	push   %ebp
  80204d:	89 e5                	mov    %esp,%ebp
  80204f:	83 ec 04             	sub    $0x4,%esp
  802052:	8b 45 08             	mov    0x8(%ebp),%eax
  802055:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802058:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	50                   	push   %eax
  802065:	6a 26                	push   $0x26
  802067:	e8 5e fb ff ff       	call   801bca <syscall>
  80206c:	83 c4 18             	add    $0x18,%esp
	return ;
  80206f:	90                   	nop
}
  802070:	c9                   	leave  
  802071:	c3                   	ret    

00802072 <rsttst>:
void rsttst()
{
  802072:	55                   	push   %ebp
  802073:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802075:	6a 00                	push   $0x0
  802077:	6a 00                	push   $0x0
  802079:	6a 00                	push   $0x0
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 28                	push   $0x28
  802081:	e8 44 fb ff ff       	call   801bca <syscall>
  802086:	83 c4 18             	add    $0x18,%esp
	return ;
  802089:	90                   	nop
}
  80208a:	c9                   	leave  
  80208b:	c3                   	ret    

0080208c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80208c:	55                   	push   %ebp
  80208d:	89 e5                	mov    %esp,%ebp
  80208f:	83 ec 04             	sub    $0x4,%esp
  802092:	8b 45 14             	mov    0x14(%ebp),%eax
  802095:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802098:	8b 55 18             	mov    0x18(%ebp),%edx
  80209b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80209f:	52                   	push   %edx
  8020a0:	50                   	push   %eax
  8020a1:	ff 75 10             	pushl  0x10(%ebp)
  8020a4:	ff 75 0c             	pushl  0xc(%ebp)
  8020a7:	ff 75 08             	pushl  0x8(%ebp)
  8020aa:	6a 27                	push   $0x27
  8020ac:	e8 19 fb ff ff       	call   801bca <syscall>
  8020b1:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b4:	90                   	nop
}
  8020b5:	c9                   	leave  
  8020b6:	c3                   	ret    

008020b7 <chktst>:
void chktst(uint32 n)
{
  8020b7:	55                   	push   %ebp
  8020b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 00                	push   $0x0
  8020c2:	ff 75 08             	pushl  0x8(%ebp)
  8020c5:	6a 29                	push   $0x29
  8020c7:	e8 fe fa ff ff       	call   801bca <syscall>
  8020cc:	83 c4 18             	add    $0x18,%esp
	return ;
  8020cf:	90                   	nop
}
  8020d0:	c9                   	leave  
  8020d1:	c3                   	ret    

008020d2 <inctst>:

void inctst()
{
  8020d2:	55                   	push   %ebp
  8020d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 2a                	push   $0x2a
  8020e1:	e8 e4 fa ff ff       	call   801bca <syscall>
  8020e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e9:	90                   	nop
}
  8020ea:	c9                   	leave  
  8020eb:	c3                   	ret    

008020ec <gettst>:
uint32 gettst()
{
  8020ec:	55                   	push   %ebp
  8020ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 2b                	push   $0x2b
  8020fb:	e8 ca fa ff ff       	call   801bca <syscall>
  802100:	83 c4 18             	add    $0x18,%esp
}
  802103:	c9                   	leave  
  802104:	c3                   	ret    

00802105 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802105:	55                   	push   %ebp
  802106:	89 e5                	mov    %esp,%ebp
  802108:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80210b:	6a 00                	push   $0x0
  80210d:	6a 00                	push   $0x0
  80210f:	6a 00                	push   $0x0
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 2c                	push   $0x2c
  802117:	e8 ae fa ff ff       	call   801bca <syscall>
  80211c:	83 c4 18             	add    $0x18,%esp
  80211f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802122:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802126:	75 07                	jne    80212f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802128:	b8 01 00 00 00       	mov    $0x1,%eax
  80212d:	eb 05                	jmp    802134 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80212f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802134:	c9                   	leave  
  802135:	c3                   	ret    

00802136 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802136:	55                   	push   %ebp
  802137:	89 e5                	mov    %esp,%ebp
  802139:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 00                	push   $0x0
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 2c                	push   $0x2c
  802148:	e8 7d fa ff ff       	call   801bca <syscall>
  80214d:	83 c4 18             	add    $0x18,%esp
  802150:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802153:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802157:	75 07                	jne    802160 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802159:	b8 01 00 00 00       	mov    $0x1,%eax
  80215e:	eb 05                	jmp    802165 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802160:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802165:	c9                   	leave  
  802166:	c3                   	ret    

00802167 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802167:	55                   	push   %ebp
  802168:	89 e5                	mov    %esp,%ebp
  80216a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80216d:	6a 00                	push   $0x0
  80216f:	6a 00                	push   $0x0
  802171:	6a 00                	push   $0x0
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 2c                	push   $0x2c
  802179:	e8 4c fa ff ff       	call   801bca <syscall>
  80217e:	83 c4 18             	add    $0x18,%esp
  802181:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802184:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802188:	75 07                	jne    802191 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80218a:	b8 01 00 00 00       	mov    $0x1,%eax
  80218f:	eb 05                	jmp    802196 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802191:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802196:	c9                   	leave  
  802197:	c3                   	ret    

00802198 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802198:	55                   	push   %ebp
  802199:	89 e5                	mov    %esp,%ebp
  80219b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80219e:	6a 00                	push   $0x0
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 2c                	push   $0x2c
  8021aa:	e8 1b fa ff ff       	call   801bca <syscall>
  8021af:	83 c4 18             	add    $0x18,%esp
  8021b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021b5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8021b9:	75 07                	jne    8021c2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8021bb:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c0:	eb 05                	jmp    8021c7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021c7:	c9                   	leave  
  8021c8:	c3                   	ret    

008021c9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021c9:	55                   	push   %ebp
  8021ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021cc:	6a 00                	push   $0x0
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	ff 75 08             	pushl  0x8(%ebp)
  8021d7:	6a 2d                	push   $0x2d
  8021d9:	e8 ec f9 ff ff       	call   801bca <syscall>
  8021de:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e1:	90                   	nop
}
  8021e2:	c9                   	leave  
  8021e3:	c3                   	ret    

008021e4 <__udivdi3>:
  8021e4:	55                   	push   %ebp
  8021e5:	57                   	push   %edi
  8021e6:	56                   	push   %esi
  8021e7:	53                   	push   %ebx
  8021e8:	83 ec 1c             	sub    $0x1c,%esp
  8021eb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021ef:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021f7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021fb:	89 ca                	mov    %ecx,%edx
  8021fd:	89 f8                	mov    %edi,%eax
  8021ff:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802203:	85 f6                	test   %esi,%esi
  802205:	75 2d                	jne    802234 <__udivdi3+0x50>
  802207:	39 cf                	cmp    %ecx,%edi
  802209:	77 65                	ja     802270 <__udivdi3+0x8c>
  80220b:	89 fd                	mov    %edi,%ebp
  80220d:	85 ff                	test   %edi,%edi
  80220f:	75 0b                	jne    80221c <__udivdi3+0x38>
  802211:	b8 01 00 00 00       	mov    $0x1,%eax
  802216:	31 d2                	xor    %edx,%edx
  802218:	f7 f7                	div    %edi
  80221a:	89 c5                	mov    %eax,%ebp
  80221c:	31 d2                	xor    %edx,%edx
  80221e:	89 c8                	mov    %ecx,%eax
  802220:	f7 f5                	div    %ebp
  802222:	89 c1                	mov    %eax,%ecx
  802224:	89 d8                	mov    %ebx,%eax
  802226:	f7 f5                	div    %ebp
  802228:	89 cf                	mov    %ecx,%edi
  80222a:	89 fa                	mov    %edi,%edx
  80222c:	83 c4 1c             	add    $0x1c,%esp
  80222f:	5b                   	pop    %ebx
  802230:	5e                   	pop    %esi
  802231:	5f                   	pop    %edi
  802232:	5d                   	pop    %ebp
  802233:	c3                   	ret    
  802234:	39 ce                	cmp    %ecx,%esi
  802236:	77 28                	ja     802260 <__udivdi3+0x7c>
  802238:	0f bd fe             	bsr    %esi,%edi
  80223b:	83 f7 1f             	xor    $0x1f,%edi
  80223e:	75 40                	jne    802280 <__udivdi3+0x9c>
  802240:	39 ce                	cmp    %ecx,%esi
  802242:	72 0a                	jb     80224e <__udivdi3+0x6a>
  802244:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802248:	0f 87 9e 00 00 00    	ja     8022ec <__udivdi3+0x108>
  80224e:	b8 01 00 00 00       	mov    $0x1,%eax
  802253:	89 fa                	mov    %edi,%edx
  802255:	83 c4 1c             	add    $0x1c,%esp
  802258:	5b                   	pop    %ebx
  802259:	5e                   	pop    %esi
  80225a:	5f                   	pop    %edi
  80225b:	5d                   	pop    %ebp
  80225c:	c3                   	ret    
  80225d:	8d 76 00             	lea    0x0(%esi),%esi
  802260:	31 ff                	xor    %edi,%edi
  802262:	31 c0                	xor    %eax,%eax
  802264:	89 fa                	mov    %edi,%edx
  802266:	83 c4 1c             	add    $0x1c,%esp
  802269:	5b                   	pop    %ebx
  80226a:	5e                   	pop    %esi
  80226b:	5f                   	pop    %edi
  80226c:	5d                   	pop    %ebp
  80226d:	c3                   	ret    
  80226e:	66 90                	xchg   %ax,%ax
  802270:	89 d8                	mov    %ebx,%eax
  802272:	f7 f7                	div    %edi
  802274:	31 ff                	xor    %edi,%edi
  802276:	89 fa                	mov    %edi,%edx
  802278:	83 c4 1c             	add    $0x1c,%esp
  80227b:	5b                   	pop    %ebx
  80227c:	5e                   	pop    %esi
  80227d:	5f                   	pop    %edi
  80227e:	5d                   	pop    %ebp
  80227f:	c3                   	ret    
  802280:	bd 20 00 00 00       	mov    $0x20,%ebp
  802285:	89 eb                	mov    %ebp,%ebx
  802287:	29 fb                	sub    %edi,%ebx
  802289:	89 f9                	mov    %edi,%ecx
  80228b:	d3 e6                	shl    %cl,%esi
  80228d:	89 c5                	mov    %eax,%ebp
  80228f:	88 d9                	mov    %bl,%cl
  802291:	d3 ed                	shr    %cl,%ebp
  802293:	89 e9                	mov    %ebp,%ecx
  802295:	09 f1                	or     %esi,%ecx
  802297:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80229b:	89 f9                	mov    %edi,%ecx
  80229d:	d3 e0                	shl    %cl,%eax
  80229f:	89 c5                	mov    %eax,%ebp
  8022a1:	89 d6                	mov    %edx,%esi
  8022a3:	88 d9                	mov    %bl,%cl
  8022a5:	d3 ee                	shr    %cl,%esi
  8022a7:	89 f9                	mov    %edi,%ecx
  8022a9:	d3 e2                	shl    %cl,%edx
  8022ab:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022af:	88 d9                	mov    %bl,%cl
  8022b1:	d3 e8                	shr    %cl,%eax
  8022b3:	09 c2                	or     %eax,%edx
  8022b5:	89 d0                	mov    %edx,%eax
  8022b7:	89 f2                	mov    %esi,%edx
  8022b9:	f7 74 24 0c          	divl   0xc(%esp)
  8022bd:	89 d6                	mov    %edx,%esi
  8022bf:	89 c3                	mov    %eax,%ebx
  8022c1:	f7 e5                	mul    %ebp
  8022c3:	39 d6                	cmp    %edx,%esi
  8022c5:	72 19                	jb     8022e0 <__udivdi3+0xfc>
  8022c7:	74 0b                	je     8022d4 <__udivdi3+0xf0>
  8022c9:	89 d8                	mov    %ebx,%eax
  8022cb:	31 ff                	xor    %edi,%edi
  8022cd:	e9 58 ff ff ff       	jmp    80222a <__udivdi3+0x46>
  8022d2:	66 90                	xchg   %ax,%ax
  8022d4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022d8:	89 f9                	mov    %edi,%ecx
  8022da:	d3 e2                	shl    %cl,%edx
  8022dc:	39 c2                	cmp    %eax,%edx
  8022de:	73 e9                	jae    8022c9 <__udivdi3+0xe5>
  8022e0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022e3:	31 ff                	xor    %edi,%edi
  8022e5:	e9 40 ff ff ff       	jmp    80222a <__udivdi3+0x46>
  8022ea:	66 90                	xchg   %ax,%ax
  8022ec:	31 c0                	xor    %eax,%eax
  8022ee:	e9 37 ff ff ff       	jmp    80222a <__udivdi3+0x46>
  8022f3:	90                   	nop

008022f4 <__umoddi3>:
  8022f4:	55                   	push   %ebp
  8022f5:	57                   	push   %edi
  8022f6:	56                   	push   %esi
  8022f7:	53                   	push   %ebx
  8022f8:	83 ec 1c             	sub    $0x1c,%esp
  8022fb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022ff:	8b 74 24 34          	mov    0x34(%esp),%esi
  802303:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802307:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80230b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80230f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802313:	89 f3                	mov    %esi,%ebx
  802315:	89 fa                	mov    %edi,%edx
  802317:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80231b:	89 34 24             	mov    %esi,(%esp)
  80231e:	85 c0                	test   %eax,%eax
  802320:	75 1a                	jne    80233c <__umoddi3+0x48>
  802322:	39 f7                	cmp    %esi,%edi
  802324:	0f 86 a2 00 00 00    	jbe    8023cc <__umoddi3+0xd8>
  80232a:	89 c8                	mov    %ecx,%eax
  80232c:	89 f2                	mov    %esi,%edx
  80232e:	f7 f7                	div    %edi
  802330:	89 d0                	mov    %edx,%eax
  802332:	31 d2                	xor    %edx,%edx
  802334:	83 c4 1c             	add    $0x1c,%esp
  802337:	5b                   	pop    %ebx
  802338:	5e                   	pop    %esi
  802339:	5f                   	pop    %edi
  80233a:	5d                   	pop    %ebp
  80233b:	c3                   	ret    
  80233c:	39 f0                	cmp    %esi,%eax
  80233e:	0f 87 ac 00 00 00    	ja     8023f0 <__umoddi3+0xfc>
  802344:	0f bd e8             	bsr    %eax,%ebp
  802347:	83 f5 1f             	xor    $0x1f,%ebp
  80234a:	0f 84 ac 00 00 00    	je     8023fc <__umoddi3+0x108>
  802350:	bf 20 00 00 00       	mov    $0x20,%edi
  802355:	29 ef                	sub    %ebp,%edi
  802357:	89 fe                	mov    %edi,%esi
  802359:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80235d:	89 e9                	mov    %ebp,%ecx
  80235f:	d3 e0                	shl    %cl,%eax
  802361:	89 d7                	mov    %edx,%edi
  802363:	89 f1                	mov    %esi,%ecx
  802365:	d3 ef                	shr    %cl,%edi
  802367:	09 c7                	or     %eax,%edi
  802369:	89 e9                	mov    %ebp,%ecx
  80236b:	d3 e2                	shl    %cl,%edx
  80236d:	89 14 24             	mov    %edx,(%esp)
  802370:	89 d8                	mov    %ebx,%eax
  802372:	d3 e0                	shl    %cl,%eax
  802374:	89 c2                	mov    %eax,%edx
  802376:	8b 44 24 08          	mov    0x8(%esp),%eax
  80237a:	d3 e0                	shl    %cl,%eax
  80237c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802380:	8b 44 24 08          	mov    0x8(%esp),%eax
  802384:	89 f1                	mov    %esi,%ecx
  802386:	d3 e8                	shr    %cl,%eax
  802388:	09 d0                	or     %edx,%eax
  80238a:	d3 eb                	shr    %cl,%ebx
  80238c:	89 da                	mov    %ebx,%edx
  80238e:	f7 f7                	div    %edi
  802390:	89 d3                	mov    %edx,%ebx
  802392:	f7 24 24             	mull   (%esp)
  802395:	89 c6                	mov    %eax,%esi
  802397:	89 d1                	mov    %edx,%ecx
  802399:	39 d3                	cmp    %edx,%ebx
  80239b:	0f 82 87 00 00 00    	jb     802428 <__umoddi3+0x134>
  8023a1:	0f 84 91 00 00 00    	je     802438 <__umoddi3+0x144>
  8023a7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023ab:	29 f2                	sub    %esi,%edx
  8023ad:	19 cb                	sbb    %ecx,%ebx
  8023af:	89 d8                	mov    %ebx,%eax
  8023b1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023b5:	d3 e0                	shl    %cl,%eax
  8023b7:	89 e9                	mov    %ebp,%ecx
  8023b9:	d3 ea                	shr    %cl,%edx
  8023bb:	09 d0                	or     %edx,%eax
  8023bd:	89 e9                	mov    %ebp,%ecx
  8023bf:	d3 eb                	shr    %cl,%ebx
  8023c1:	89 da                	mov    %ebx,%edx
  8023c3:	83 c4 1c             	add    $0x1c,%esp
  8023c6:	5b                   	pop    %ebx
  8023c7:	5e                   	pop    %esi
  8023c8:	5f                   	pop    %edi
  8023c9:	5d                   	pop    %ebp
  8023ca:	c3                   	ret    
  8023cb:	90                   	nop
  8023cc:	89 fd                	mov    %edi,%ebp
  8023ce:	85 ff                	test   %edi,%edi
  8023d0:	75 0b                	jne    8023dd <__umoddi3+0xe9>
  8023d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8023d7:	31 d2                	xor    %edx,%edx
  8023d9:	f7 f7                	div    %edi
  8023db:	89 c5                	mov    %eax,%ebp
  8023dd:	89 f0                	mov    %esi,%eax
  8023df:	31 d2                	xor    %edx,%edx
  8023e1:	f7 f5                	div    %ebp
  8023e3:	89 c8                	mov    %ecx,%eax
  8023e5:	f7 f5                	div    %ebp
  8023e7:	89 d0                	mov    %edx,%eax
  8023e9:	e9 44 ff ff ff       	jmp    802332 <__umoddi3+0x3e>
  8023ee:	66 90                	xchg   %ax,%ax
  8023f0:	89 c8                	mov    %ecx,%eax
  8023f2:	89 f2                	mov    %esi,%edx
  8023f4:	83 c4 1c             	add    $0x1c,%esp
  8023f7:	5b                   	pop    %ebx
  8023f8:	5e                   	pop    %esi
  8023f9:	5f                   	pop    %edi
  8023fa:	5d                   	pop    %ebp
  8023fb:	c3                   	ret    
  8023fc:	3b 04 24             	cmp    (%esp),%eax
  8023ff:	72 06                	jb     802407 <__umoddi3+0x113>
  802401:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802405:	77 0f                	ja     802416 <__umoddi3+0x122>
  802407:	89 f2                	mov    %esi,%edx
  802409:	29 f9                	sub    %edi,%ecx
  80240b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80240f:	89 14 24             	mov    %edx,(%esp)
  802412:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802416:	8b 44 24 04          	mov    0x4(%esp),%eax
  80241a:	8b 14 24             	mov    (%esp),%edx
  80241d:	83 c4 1c             	add    $0x1c,%esp
  802420:	5b                   	pop    %ebx
  802421:	5e                   	pop    %esi
  802422:	5f                   	pop    %edi
  802423:	5d                   	pop    %ebp
  802424:	c3                   	ret    
  802425:	8d 76 00             	lea    0x0(%esi),%esi
  802428:	2b 04 24             	sub    (%esp),%eax
  80242b:	19 fa                	sbb    %edi,%edx
  80242d:	89 d1                	mov    %edx,%ecx
  80242f:	89 c6                	mov    %eax,%esi
  802431:	e9 71 ff ff ff       	jmp    8023a7 <__umoddi3+0xb3>
  802436:	66 90                	xchg   %ax,%ax
  802438:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80243c:	72 ea                	jb     802428 <__umoddi3+0x134>
  80243e:	89 d9                	mov    %ebx,%ecx
  802440:	e9 62 ff ff ff       	jmp    8023a7 <__umoddi3+0xb3>
