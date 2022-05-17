
obj/user/ef_mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 81 07 00 00       	call   8007b7 <libmain>
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
  800041:	e8 36 1e 00 00       	call   801e7c <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 c0 24 80 00       	push   $0x8024c0
  80004e:	e8 27 0b 00 00       	call   800b7a <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 c2 24 80 00       	push   $0x8024c2
  80005e:	e8 17 0b 00 00       	call   800b7a <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 d8 24 80 00       	push   $0x8024d8
  80006e:	e8 07 0b 00 00       	call   800b7a <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 c2 24 80 00       	push   $0x8024c2
  80007e:	e8 f7 0a 00 00       	call   800b7a <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 c0 24 80 00       	push   $0x8024c0
  80008e:	e8 e7 0a 00 00       	call   800b7a <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		//readline("Enter the number of elements: ", Line);
		cprintf("Enter the number of elements: ");
  800096:	83 ec 0c             	sub    $0xc,%esp
  800099:	68 f0 24 80 00       	push   $0x8024f0
  80009e:	e8 d7 0a 00 00       	call   800b7a <cprintf>
  8000a3:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = 2000 ;
  8000a6:	c7 45 f0 d0 07 00 00 	movl   $0x7d0,-0x10(%ebp)
		cprintf("%d\n", NumOfElements) ;
  8000ad:	83 ec 08             	sub    $0x8,%esp
  8000b0:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b3:	68 0f 25 80 00       	push   $0x80250f
  8000b8:	e8 bd 0a 00 00       	call   800b7a <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c3:	c1 e0 02             	shl    $0x2,%eax
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	50                   	push   %eax
  8000ca:	e8 1a 1a 00 00       	call   801ae9 <malloc>
  8000cf:	83 c4 10             	add    $0x10,%esp
  8000d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000d5:	83 ec 0c             	sub    $0xc,%esp
  8000d8:	68 14 25 80 00       	push   $0x802514
  8000dd:	e8 98 0a 00 00       	call   800b7a <cprintf>
  8000e2:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	68 36 25 80 00       	push   $0x802536
  8000ed:	e8 88 0a 00 00       	call   800b7a <cprintf>
  8000f2:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f5:	83 ec 0c             	sub    $0xc,%esp
  8000f8:	68 44 25 80 00       	push   $0x802544
  8000fd:	e8 78 0a 00 00       	call   800b7a <cprintf>
  800102:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	68 53 25 80 00       	push   $0x802553
  80010d:	e8 68 0a 00 00       	call   800b7a <cprintf>
  800112:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	68 63 25 80 00       	push   $0x802563
  80011d:	e8 58 0a 00 00       	call   800b7a <cprintf>
  800122:	83 c4 10             	add    $0x10,%esp
			//Chose = getchar() ;
			Chose = 'a';
  800125:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
			cputchar(Chose);
  800129:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80012d:	83 ec 0c             	sub    $0xc,%esp
  800130:	50                   	push   %eax
  800131:	e8 e1 05 00 00       	call   800717 <cputchar>
  800136:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800139:	83 ec 0c             	sub    $0xc,%esp
  80013c:	6a 0a                	push   $0xa
  80013e:	e8 d4 05 00 00       	call   800717 <cputchar>
  800143:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800146:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80014a:	74 0c                	je     800158 <_main+0x120>
  80014c:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800150:	74 06                	je     800158 <_main+0x120>
  800152:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800156:	75 bd                	jne    800115 <_main+0xdd>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800158:	e8 39 1d 00 00       	call   801e96 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  80015d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800161:	83 f8 62             	cmp    $0x62,%eax
  800164:	74 1d                	je     800183 <_main+0x14b>
  800166:	83 f8 63             	cmp    $0x63,%eax
  800169:	74 2b                	je     800196 <_main+0x15e>
  80016b:	83 f8 61             	cmp    $0x61,%eax
  80016e:	75 39                	jne    8001a9 <_main+0x171>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800170:	83 ec 08             	sub    $0x8,%esp
  800173:	ff 75 f0             	pushl  -0x10(%ebp)
  800176:	ff 75 ec             	pushl  -0x14(%ebp)
  800179:	e8 f0 01 00 00       	call   80036e <InitializeAscending>
  80017e:	83 c4 10             	add    $0x10,%esp
			break ;
  800181:	eb 37                	jmp    8001ba <_main+0x182>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  800183:	83 ec 08             	sub    $0x8,%esp
  800186:	ff 75 f0             	pushl  -0x10(%ebp)
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	e8 0e 02 00 00       	call   80039f <InitializeDescending>
  800191:	83 c4 10             	add    $0x10,%esp
			break ;
  800194:	eb 24                	jmp    8001ba <_main+0x182>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800196:	83 ec 08             	sub    $0x8,%esp
  800199:	ff 75 f0             	pushl  -0x10(%ebp)
  80019c:	ff 75 ec             	pushl  -0x14(%ebp)
  80019f:	e8 30 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001a4:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a7:	eb 11                	jmp    8001ba <_main+0x182>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001a9:	83 ec 08             	sub    $0x8,%esp
  8001ac:	ff 75 f0             	pushl  -0x10(%ebp)
  8001af:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b2:	e8 1d 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001b7:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001ba:	83 ec 04             	sub    $0x4,%esp
  8001bd:	ff 75 f0             	pushl  -0x10(%ebp)
  8001c0:	6a 01                	push   $0x1
  8001c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8001c5:	e8 dc 02 00 00       	call   8004a6 <MSort>
  8001ca:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001cd:	e8 aa 1c 00 00       	call   801e7c <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 6c 25 80 00       	push   $0x80256c
  8001da:	e8 9b 09 00 00       	call   800b7a <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001e2:	e8 af 1c 00 00       	call   801e96 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001e7:	83 ec 08             	sub    $0x8,%esp
  8001ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ed:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f0:	e8 cf 00 00 00       	call   8002c4 <CheckSorted>
  8001f5:	83 c4 10             	add    $0x10,%esp
  8001f8:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001fb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001ff:	75 14                	jne    800215 <_main+0x1dd>
  800201:	83 ec 04             	sub    $0x4,%esp
  800204:	68 a0 25 80 00       	push   $0x8025a0
  800209:	6a 4e                	push   $0x4e
  80020b:	68 c2 25 80 00       	push   $0x8025c2
  800210:	e8 b1 06 00 00       	call   8008c6 <_panic>
		else
		{
			sys_disable_interrupt();
  800215:	e8 62 1c 00 00       	call   801e7c <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	68 e0 25 80 00       	push   $0x8025e0
  800222:	e8 53 09 00 00       	call   800b7a <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80022a:	83 ec 0c             	sub    $0xc,%esp
  80022d:	68 14 26 80 00       	push   $0x802614
  800232:	e8 43 09 00 00       	call   800b7a <cprintf>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 48 26 80 00       	push   $0x802648
  800242:	e8 33 09 00 00       	call   800b7a <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80024a:	e8 47 1c 00 00       	call   801e96 <sys_enable_interrupt>
		}

		free(Elements) ;
  80024f:	83 ec 0c             	sub    $0xc,%esp
  800252:	ff 75 ec             	pushl  -0x14(%ebp)
  800255:	e8 1d 19 00 00       	call   801b77 <free>
  80025a:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  80025d:	e8 1a 1c 00 00       	call   801e7c <sys_disable_interrupt>
			Chose = 0 ;
  800262:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800266:	eb 3e                	jmp    8002a6 <_main+0x26e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800268:	83 ec 0c             	sub    $0xc,%esp
  80026b:	68 7a 26 80 00       	push   $0x80267a
  800270:	e8 05 09 00 00       	call   800b7a <cprintf>
  800275:	83 c4 10             	add    $0x10,%esp
				Chose = 'n' ;
  800278:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
				cputchar(Chose);
  80027c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	50                   	push   %eax
  800284:	e8 8e 04 00 00       	call   800717 <cputchar>
  800289:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	6a 0a                	push   $0xa
  800291:	e8 81 04 00 00       	call   800717 <cputchar>
  800296:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	6a 0a                	push   $0xa
  80029e:	e8 74 04 00 00       	call   800717 <cputchar>
  8002a3:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a6:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002aa:	74 06                	je     8002b2 <_main+0x27a>
  8002ac:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002b0:	75 b6                	jne    800268 <_main+0x230>
				Chose = 'n' ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b2:	e8 df 1b 00 00       	call   801e96 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b7:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002bb:	0f 84 80 fd ff ff    	je     800041 <_main+0x9>
}
  8002c1:	90                   	nop
  8002c2:	c9                   	leave  
  8002c3:	c3                   	ret    

008002c4 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002c4:	55                   	push   %ebp
  8002c5:	89 e5                	mov    %esp,%ebp
  8002c7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002d8:	eb 33                	jmp    80030d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 d0                	add    %edx,%eax
  8002e9:	8b 10                	mov    (%eax),%edx
  8002eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002ee:	40                   	inc    %eax
  8002ef:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 c8                	add    %ecx,%eax
  8002fb:	8b 00                	mov    (%eax),%eax
  8002fd:	39 c2                	cmp    %eax,%edx
  8002ff:	7e 09                	jle    80030a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800301:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800308:	eb 0c                	jmp    800316 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80030a:	ff 45 f8             	incl   -0x8(%ebp)
  80030d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800310:	48                   	dec    %eax
  800311:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800314:	7f c4                	jg     8002da <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800316:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800321:	8b 45 0c             	mov    0xc(%ebp),%eax
  800324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032b:	8b 45 08             	mov    0x8(%ebp),%eax
  80032e:	01 d0                	add    %edx,%eax
  800330:	8b 00                	mov    (%eax),%eax
  800332:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800335:	8b 45 0c             	mov    0xc(%ebp),%eax
  800338:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033f:	8b 45 08             	mov    0x8(%ebp),%eax
  800342:	01 c2                	add    %eax,%edx
  800344:	8b 45 10             	mov    0x10(%ebp),%eax
  800347:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034e:	8b 45 08             	mov    0x8(%ebp),%eax
  800351:	01 c8                	add    %ecx,%eax
  800353:	8b 00                	mov    (%eax),%eax
  800355:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800357:	8b 45 10             	mov    0x10(%ebp),%eax
  80035a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800361:	8b 45 08             	mov    0x8(%ebp),%eax
  800364:	01 c2                	add    %eax,%edx
  800366:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800369:	89 02                	mov    %eax,(%edx)
}
  80036b:	90                   	nop
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800374:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80037b:	eb 17                	jmp    800394 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80037d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800380:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	01 c2                	add    %eax,%edx
  80038c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800391:	ff 45 fc             	incl   -0x4(%ebp)
  800394:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800397:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80039a:	7c e1                	jl     80037d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80039c:	90                   	nop
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ac:	eb 1b                	jmp    8003c9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	01 c2                	add    %eax,%edx
  8003bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003c3:	48                   	dec    %eax
  8003c4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003c6:	ff 45 fc             	incl   -0x4(%ebp)
  8003c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003cf:	7c dd                	jl     8003ae <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003d1:	90                   	nop
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003dd:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003e2:	f7 e9                	imul   %ecx
  8003e4:	c1 f9 1f             	sar    $0x1f,%ecx
  8003e7:	89 d0                	mov    %edx,%eax
  8003e9:	29 c8                	sub    %ecx,%eax
  8003eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003f5:	eb 1e                	jmp    800415 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8003f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040a:	99                   	cltd   
  80040b:	f7 7d f8             	idivl  -0x8(%ebp)
  80040e:	89 d0                	mov    %edx,%eax
  800410:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800412:	ff 45 fc             	incl   -0x4(%ebp)
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041b:	7c da                	jl     8003f7 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800426:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80042d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800434:	eb 42                	jmp    800478 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800439:	99                   	cltd   
  80043a:	f7 7d f0             	idivl  -0x10(%ebp)
  80043d:	89 d0                	mov    %edx,%eax
  80043f:	85 c0                	test   %eax,%eax
  800441:	75 10                	jne    800453 <PrintElements+0x33>
			cprintf("\n");
  800443:	83 ec 0c             	sub    $0xc,%esp
  800446:	68 c0 24 80 00       	push   $0x8024c0
  80044b:	e8 2a 07 00 00       	call   800b7a <cprintf>
  800450:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800453:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 d0                	add    %edx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	83 ec 08             	sub    $0x8,%esp
  800467:	50                   	push   %eax
  800468:	68 98 26 80 00       	push   $0x802698
  80046d:	e8 08 07 00 00       	call   800b7a <cprintf>
  800472:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800475:	ff 45 f4             	incl   -0xc(%ebp)
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	48                   	dec    %eax
  80047c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80047f:	7f b5                	jg     800436 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800481:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 ec 08             	sub    $0x8,%esp
  800495:	50                   	push   %eax
  800496:	68 0f 25 80 00       	push   $0x80250f
  80049b:	e8 da 06 00 00       	call   800b7a <cprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp

}
  8004a3:	90                   	nop
  8004a4:	c9                   	leave  
  8004a5:	c3                   	ret    

008004a6 <MSort>:


void MSort(int* A, int p, int r)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004b2:	7d 54                	jge    800508 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	89 c2                	mov    %eax,%edx
  8004be:	c1 ea 1f             	shr    $0x1f,%edx
  8004c1:	01 d0                	add    %edx,%eax
  8004c3:	d1 f8                	sar    %eax
  8004c5:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004c8:	83 ec 04             	sub    $0x4,%esp
  8004cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ce:	ff 75 0c             	pushl  0xc(%ebp)
  8004d1:	ff 75 08             	pushl  0x8(%ebp)
  8004d4:	e8 cd ff ff ff       	call   8004a6 <MSort>
  8004d9:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004df:	40                   	inc    %eax
  8004e0:	83 ec 04             	sub    $0x4,%esp
  8004e3:	ff 75 10             	pushl  0x10(%ebp)
  8004e6:	50                   	push   %eax
  8004e7:	ff 75 08             	pushl  0x8(%ebp)
  8004ea:	e8 b7 ff ff ff       	call   8004a6 <MSort>
  8004ef:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004f2:	ff 75 10             	pushl  0x10(%ebp)
  8004f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f8:	ff 75 0c             	pushl  0xc(%ebp)
  8004fb:	ff 75 08             	pushl  0x8(%ebp)
  8004fe:	e8 08 00 00 00       	call   80050b <Merge>
  800503:	83 c4 10             	add    $0x10,%esp
  800506:	eb 01                	jmp    800509 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800508:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800511:	8b 45 10             	mov    0x10(%ebp),%eax
  800514:	2b 45 0c             	sub    0xc(%ebp),%eax
  800517:	40                   	inc    %eax
  800518:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80051b:	8b 45 14             	mov    0x14(%ebp),%eax
  80051e:	2b 45 10             	sub    0x10(%ebp),%eax
  800521:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800524:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80052b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800532:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800535:	c1 e0 02             	shl    $0x2,%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 a8 15 00 00       	call   801ae9 <malloc>
  800541:	83 c4 10             	add    $0x10,%esp
  800544:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800547:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054a:	c1 e0 02             	shl    $0x2,%eax
  80054d:	83 ec 0c             	sub    $0xc,%esp
  800550:	50                   	push   %eax
  800551:	e8 93 15 00 00       	call   801ae9 <malloc>
  800556:	83 c4 10             	add    $0x10,%esp
  800559:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80055c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800563:	eb 2f                	jmp    800594 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800565:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800568:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800572:	01 c2                	add    %eax,%edx
  800574:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80057a:	01 c8                	add    %ecx,%eax
  80057c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800581:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800588:	8b 45 08             	mov    0x8(%ebp),%eax
  80058b:	01 c8                	add    %ecx,%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	89 02                	mov    %eax,(%edx)
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800591:	ff 45 ec             	incl   -0x14(%ebp)
  800594:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800597:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80059a:	7c c9                	jl     800565 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80059c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a3:	eb 2a                	jmp    8005cf <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b2:	01 c2                	add    %eax,%edx
  8005b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	01 c8                	add    %ecx,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005cc:	ff 45 e8             	incl   -0x18(%ebp)
  8005cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d2:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005d5:	7c ce                	jl     8005a5 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005dd:	e9 0a 01 00 00       	jmp    8006ec <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005e8:	0f 8d 95 00 00 00    	jge    800683 <Merge+0x178>
  8005ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f1:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005f4:	0f 8d 89 00 00 00    	jge    800683 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800604:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800607:	01 d0                	add    %edx,%eax
  800609:	8b 10                	mov    (%eax),%edx
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80060e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800615:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800618:	01 c8                	add    %ecx,%eax
  80061a:	8b 00                	mov    (%eax),%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	7d 33                	jge    800653 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800623:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800628:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80062f:	8b 45 08             	mov    0x8(%ebp),%eax
  800632:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800638:	8d 50 01             	lea    0x1(%eax),%edx
  80063b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80063e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800645:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80064e:	e9 96 00 00 00       	jmp    8006e9 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800656:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80065b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800662:	8b 45 08             	mov    0x8(%ebp),%eax
  800665:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80066b:	8d 50 01             	lea    0x1(%eax),%edx
  80066e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800671:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80067b:	01 d0                	add    %edx,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800681:	eb 66                	jmp    8006e9 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800683:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800686:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800689:	7d 30                	jge    8006bb <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80068b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80068e:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006b3:	01 d0                	add    %edx,%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	89 01                	mov    %eax,(%ecx)
  8006b9:	eb 2e                	jmp    8006e9 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006be:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d3:	8d 50 01             	lea    0x1(%eax),%edx
  8006d6:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e3:	01 d0                	add    %edx,%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ef:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006f2:	0f 8e ea fe ff ff    	jle    8005e2 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

	free(Left);
  8006f8:	83 ec 0c             	sub    $0xc,%esp
  8006fb:	ff 75 d8             	pushl  -0x28(%ebp)
  8006fe:	e8 74 14 00 00       	call   801b77 <free>
  800703:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	ff 75 d4             	pushl  -0x2c(%ebp)
  80070c:	e8 66 14 00 00       	call   801b77 <free>
  800711:	83 c4 10             	add    $0x10,%esp

}
  800714:	90                   	nop
  800715:	c9                   	leave  
  800716:	c3                   	ret    

00800717 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800717:	55                   	push   %ebp
  800718:	89 e5                	mov    %esp,%ebp
  80071a:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800723:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800727:	83 ec 0c             	sub    $0xc,%esp
  80072a:	50                   	push   %eax
  80072b:	e8 80 17 00 00       	call   801eb0 <sys_cputc>
  800730:	83 c4 10             	add    $0x10,%esp
}
  800733:	90                   	nop
  800734:	c9                   	leave  
  800735:	c3                   	ret    

00800736 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800736:	55                   	push   %ebp
  800737:	89 e5                	mov    %esp,%ebp
  800739:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80073c:	e8 3b 17 00 00       	call   801e7c <sys_disable_interrupt>
	char c = ch;
  800741:	8b 45 08             	mov    0x8(%ebp),%eax
  800744:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800747:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80074b:	83 ec 0c             	sub    $0xc,%esp
  80074e:	50                   	push   %eax
  80074f:	e8 5c 17 00 00       	call   801eb0 <sys_cputc>
  800754:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800757:	e8 3a 17 00 00       	call   801e96 <sys_enable_interrupt>
}
  80075c:	90                   	nop
  80075d:	c9                   	leave  
  80075e:	c3                   	ret    

0080075f <getchar>:

int
getchar(void)
{
  80075f:	55                   	push   %ebp
  800760:	89 e5                	mov    %esp,%ebp
  800762:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800765:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80076c:	eb 08                	jmp    800776 <getchar+0x17>
	{
		c = sys_cgetc();
  80076e:	e8 21 15 00 00       	call   801c94 <sys_cgetc>
  800773:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800776:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80077a:	74 f2                	je     80076e <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80077c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80077f:	c9                   	leave  
  800780:	c3                   	ret    

00800781 <atomic_getchar>:

int
atomic_getchar(void)
{
  800781:	55                   	push   %ebp
  800782:	89 e5                	mov    %esp,%ebp
  800784:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800787:	e8 f0 16 00 00       	call   801e7c <sys_disable_interrupt>
	int c=0;
  80078c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800793:	eb 08                	jmp    80079d <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800795:	e8 fa 14 00 00       	call   801c94 <sys_cgetc>
  80079a:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80079d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007a1:	74 f2                	je     800795 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007a3:	e8 ee 16 00 00       	call   801e96 <sys_enable_interrupt>
	return c;
  8007a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007ab:	c9                   	leave  
  8007ac:	c3                   	ret    

008007ad <iscons>:

int iscons(int fdnum)
{
  8007ad:	55                   	push   %ebp
  8007ae:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007b0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007b5:	5d                   	pop    %ebp
  8007b6:	c3                   	ret    

008007b7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007b7:	55                   	push   %ebp
  8007b8:	89 e5                	mov    %esp,%ebp
  8007ba:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007bd:	e8 1f 15 00 00       	call   801ce1 <sys_getenvindex>
  8007c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007c8:	89 d0                	mov    %edx,%eax
  8007ca:	c1 e0 02             	shl    $0x2,%eax
  8007cd:	01 d0                	add    %edx,%eax
  8007cf:	01 c0                	add    %eax,%eax
  8007d1:	01 d0                	add    %edx,%eax
  8007d3:	01 c0                	add    %eax,%eax
  8007d5:	01 d0                	add    %edx,%eax
  8007d7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007de:	01 d0                	add    %edx,%eax
  8007e0:	c1 e0 02             	shl    $0x2,%eax
  8007e3:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007e8:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007ed:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f2:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8007f8:	84 c0                	test   %al,%al
  8007fa:	74 0f                	je     80080b <libmain+0x54>
		binaryname = myEnv->prog_name;
  8007fc:	a1 24 30 80 00       	mov    0x803024,%eax
  800801:	05 f4 02 00 00       	add    $0x2f4,%eax
  800806:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80080b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80080f:	7e 0a                	jle    80081b <libmain+0x64>
		binaryname = argv[0];
  800811:	8b 45 0c             	mov    0xc(%ebp),%eax
  800814:	8b 00                	mov    (%eax),%eax
  800816:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80081b:	83 ec 08             	sub    $0x8,%esp
  80081e:	ff 75 0c             	pushl  0xc(%ebp)
  800821:	ff 75 08             	pushl  0x8(%ebp)
  800824:	e8 0f f8 ff ff       	call   800038 <_main>
  800829:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80082c:	e8 4b 16 00 00       	call   801e7c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800831:	83 ec 0c             	sub    $0xc,%esp
  800834:	68 b8 26 80 00       	push   $0x8026b8
  800839:	e8 3c 03 00 00       	call   800b7a <cprintf>
  80083e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800841:	a1 24 30 80 00       	mov    0x803024,%eax
  800846:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80084c:	a1 24 30 80 00       	mov    0x803024,%eax
  800851:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800857:	83 ec 04             	sub    $0x4,%esp
  80085a:	52                   	push   %edx
  80085b:	50                   	push   %eax
  80085c:	68 e0 26 80 00       	push   $0x8026e0
  800861:	e8 14 03 00 00       	call   800b7a <cprintf>
  800866:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800869:	a1 24 30 80 00       	mov    0x803024,%eax
  80086e:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800874:	83 ec 08             	sub    $0x8,%esp
  800877:	50                   	push   %eax
  800878:	68 05 27 80 00       	push   $0x802705
  80087d:	e8 f8 02 00 00       	call   800b7a <cprintf>
  800882:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800885:	83 ec 0c             	sub    $0xc,%esp
  800888:	68 b8 26 80 00       	push   $0x8026b8
  80088d:	e8 e8 02 00 00       	call   800b7a <cprintf>
  800892:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800895:	e8 fc 15 00 00       	call   801e96 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80089a:	e8 19 00 00 00       	call   8008b8 <exit>
}
  80089f:	90                   	nop
  8008a0:	c9                   	leave  
  8008a1:	c3                   	ret    

008008a2 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008a2:	55                   	push   %ebp
  8008a3:	89 e5                	mov    %esp,%ebp
  8008a5:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008a8:	83 ec 0c             	sub    $0xc,%esp
  8008ab:	6a 00                	push   $0x0
  8008ad:	e8 fb 13 00 00       	call   801cad <sys_env_destroy>
  8008b2:	83 c4 10             	add    $0x10,%esp
}
  8008b5:	90                   	nop
  8008b6:	c9                   	leave  
  8008b7:	c3                   	ret    

008008b8 <exit>:

void
exit(void)
{
  8008b8:	55                   	push   %ebp
  8008b9:	89 e5                	mov    %esp,%ebp
  8008bb:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008be:	e8 50 14 00 00       	call   801d13 <sys_env_exit>
}
  8008c3:	90                   	nop
  8008c4:	c9                   	leave  
  8008c5:	c3                   	ret    

008008c6 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008c6:	55                   	push   %ebp
  8008c7:	89 e5                	mov    %esp,%ebp
  8008c9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008cc:	8d 45 10             	lea    0x10(%ebp),%eax
  8008cf:	83 c0 04             	add    $0x4,%eax
  8008d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008d5:	a1 48 30 88 00       	mov    0x883048,%eax
  8008da:	85 c0                	test   %eax,%eax
  8008dc:	74 16                	je     8008f4 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008de:	a1 48 30 88 00       	mov    0x883048,%eax
  8008e3:	83 ec 08             	sub    $0x8,%esp
  8008e6:	50                   	push   %eax
  8008e7:	68 1c 27 80 00       	push   $0x80271c
  8008ec:	e8 89 02 00 00       	call   800b7a <cprintf>
  8008f1:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008f4:	a1 00 30 80 00       	mov    0x803000,%eax
  8008f9:	ff 75 0c             	pushl  0xc(%ebp)
  8008fc:	ff 75 08             	pushl  0x8(%ebp)
  8008ff:	50                   	push   %eax
  800900:	68 21 27 80 00       	push   $0x802721
  800905:	e8 70 02 00 00       	call   800b7a <cprintf>
  80090a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80090d:	8b 45 10             	mov    0x10(%ebp),%eax
  800910:	83 ec 08             	sub    $0x8,%esp
  800913:	ff 75 f4             	pushl  -0xc(%ebp)
  800916:	50                   	push   %eax
  800917:	e8 f3 01 00 00       	call   800b0f <vcprintf>
  80091c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80091f:	83 ec 08             	sub    $0x8,%esp
  800922:	6a 00                	push   $0x0
  800924:	68 3d 27 80 00       	push   $0x80273d
  800929:	e8 e1 01 00 00       	call   800b0f <vcprintf>
  80092e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800931:	e8 82 ff ff ff       	call   8008b8 <exit>

	// should not return here
	while (1) ;
  800936:	eb fe                	jmp    800936 <_panic+0x70>

00800938 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800938:	55                   	push   %ebp
  800939:	89 e5                	mov    %esp,%ebp
  80093b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80093e:	a1 24 30 80 00       	mov    0x803024,%eax
  800943:	8b 50 74             	mov    0x74(%eax),%edx
  800946:	8b 45 0c             	mov    0xc(%ebp),%eax
  800949:	39 c2                	cmp    %eax,%edx
  80094b:	74 14                	je     800961 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80094d:	83 ec 04             	sub    $0x4,%esp
  800950:	68 40 27 80 00       	push   $0x802740
  800955:	6a 26                	push   $0x26
  800957:	68 8c 27 80 00       	push   $0x80278c
  80095c:	e8 65 ff ff ff       	call   8008c6 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800961:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800968:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80096f:	e9 c2 00 00 00       	jmp    800a36 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800974:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800977:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	01 d0                	add    %edx,%eax
  800983:	8b 00                	mov    (%eax),%eax
  800985:	85 c0                	test   %eax,%eax
  800987:	75 08                	jne    800991 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800989:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80098c:	e9 a2 00 00 00       	jmp    800a33 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800991:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800998:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80099f:	eb 69                	jmp    800a0a <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009a1:	a1 24 30 80 00       	mov    0x803024,%eax
  8009a6:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009ac:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009af:	89 d0                	mov    %edx,%eax
  8009b1:	01 c0                	add    %eax,%eax
  8009b3:	01 d0                	add    %edx,%eax
  8009b5:	c1 e0 02             	shl    $0x2,%eax
  8009b8:	01 c8                	add    %ecx,%eax
  8009ba:	8a 40 04             	mov    0x4(%eax),%al
  8009bd:	84 c0                	test   %al,%al
  8009bf:	75 46                	jne    800a07 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009c1:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c6:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009cc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009cf:	89 d0                	mov    %edx,%eax
  8009d1:	01 c0                	add    %eax,%eax
  8009d3:	01 d0                	add    %edx,%eax
  8009d5:	c1 e0 02             	shl    $0x2,%eax
  8009d8:	01 c8                	add    %ecx,%eax
  8009da:	8b 00                	mov    (%eax),%eax
  8009dc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009df:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009e7:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ec:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f6:	01 c8                	add    %ecx,%eax
  8009f8:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009fa:	39 c2                	cmp    %eax,%edx
  8009fc:	75 09                	jne    800a07 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8009fe:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a05:	eb 12                	jmp    800a19 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a07:	ff 45 e8             	incl   -0x18(%ebp)
  800a0a:	a1 24 30 80 00       	mov    0x803024,%eax
  800a0f:	8b 50 74             	mov    0x74(%eax),%edx
  800a12:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a15:	39 c2                	cmp    %eax,%edx
  800a17:	77 88                	ja     8009a1 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a19:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a1d:	75 14                	jne    800a33 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a1f:	83 ec 04             	sub    $0x4,%esp
  800a22:	68 98 27 80 00       	push   $0x802798
  800a27:	6a 3a                	push   $0x3a
  800a29:	68 8c 27 80 00       	push   $0x80278c
  800a2e:	e8 93 fe ff ff       	call   8008c6 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a33:	ff 45 f0             	incl   -0x10(%ebp)
  800a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a39:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a3c:	0f 8c 32 ff ff ff    	jl     800974 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a42:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a49:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a50:	eb 26                	jmp    800a78 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a52:	a1 24 30 80 00       	mov    0x803024,%eax
  800a57:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a5d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a60:	89 d0                	mov    %edx,%eax
  800a62:	01 c0                	add    %eax,%eax
  800a64:	01 d0                	add    %edx,%eax
  800a66:	c1 e0 02             	shl    $0x2,%eax
  800a69:	01 c8                	add    %ecx,%eax
  800a6b:	8a 40 04             	mov    0x4(%eax),%al
  800a6e:	3c 01                	cmp    $0x1,%al
  800a70:	75 03                	jne    800a75 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a72:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a75:	ff 45 e0             	incl   -0x20(%ebp)
  800a78:	a1 24 30 80 00       	mov    0x803024,%eax
  800a7d:	8b 50 74             	mov    0x74(%eax),%edx
  800a80:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a83:	39 c2                	cmp    %eax,%edx
  800a85:	77 cb                	ja     800a52 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a8a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a8d:	74 14                	je     800aa3 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800a8f:	83 ec 04             	sub    $0x4,%esp
  800a92:	68 ec 27 80 00       	push   $0x8027ec
  800a97:	6a 44                	push   $0x44
  800a99:	68 8c 27 80 00       	push   $0x80278c
  800a9e:	e8 23 fe ff ff       	call   8008c6 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aa3:	90                   	nop
  800aa4:	c9                   	leave  
  800aa5:	c3                   	ret    

00800aa6 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800aa6:	55                   	push   %ebp
  800aa7:	89 e5                	mov    %esp,%ebp
  800aa9:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800aac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aaf:	8b 00                	mov    (%eax),%eax
  800ab1:	8d 48 01             	lea    0x1(%eax),%ecx
  800ab4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ab7:	89 0a                	mov    %ecx,(%edx)
  800ab9:	8b 55 08             	mov    0x8(%ebp),%edx
  800abc:	88 d1                	mov    %dl,%cl
  800abe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac1:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ac5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac8:	8b 00                	mov    (%eax),%eax
  800aca:	3d ff 00 00 00       	cmp    $0xff,%eax
  800acf:	75 2c                	jne    800afd <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ad1:	a0 28 30 80 00       	mov    0x803028,%al
  800ad6:	0f b6 c0             	movzbl %al,%eax
  800ad9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800adc:	8b 12                	mov    (%edx),%edx
  800ade:	89 d1                	mov    %edx,%ecx
  800ae0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae3:	83 c2 08             	add    $0x8,%edx
  800ae6:	83 ec 04             	sub    $0x4,%esp
  800ae9:	50                   	push   %eax
  800aea:	51                   	push   %ecx
  800aeb:	52                   	push   %edx
  800aec:	e8 7a 11 00 00       	call   801c6b <sys_cputs>
  800af1:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800af4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800afd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b00:	8b 40 04             	mov    0x4(%eax),%eax
  800b03:	8d 50 01             	lea    0x1(%eax),%edx
  800b06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b09:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b0c:	90                   	nop
  800b0d:	c9                   	leave  
  800b0e:	c3                   	ret    

00800b0f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b0f:	55                   	push   %ebp
  800b10:	89 e5                	mov    %esp,%ebp
  800b12:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b18:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b1f:	00 00 00 
	b.cnt = 0;
  800b22:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b29:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b2c:	ff 75 0c             	pushl  0xc(%ebp)
  800b2f:	ff 75 08             	pushl  0x8(%ebp)
  800b32:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b38:	50                   	push   %eax
  800b39:	68 a6 0a 80 00       	push   $0x800aa6
  800b3e:	e8 11 02 00 00       	call   800d54 <vprintfmt>
  800b43:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b46:	a0 28 30 80 00       	mov    0x803028,%al
  800b4b:	0f b6 c0             	movzbl %al,%eax
  800b4e:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b54:	83 ec 04             	sub    $0x4,%esp
  800b57:	50                   	push   %eax
  800b58:	52                   	push   %edx
  800b59:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b5f:	83 c0 08             	add    $0x8,%eax
  800b62:	50                   	push   %eax
  800b63:	e8 03 11 00 00       	call   801c6b <sys_cputs>
  800b68:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b6b:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b72:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b78:	c9                   	leave  
  800b79:	c3                   	ret    

00800b7a <cprintf>:

int cprintf(const char *fmt, ...) {
  800b7a:	55                   	push   %ebp
  800b7b:	89 e5                	mov    %esp,%ebp
  800b7d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b80:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b87:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b90:	83 ec 08             	sub    $0x8,%esp
  800b93:	ff 75 f4             	pushl  -0xc(%ebp)
  800b96:	50                   	push   %eax
  800b97:	e8 73 ff ff ff       	call   800b0f <vcprintf>
  800b9c:	83 c4 10             	add    $0x10,%esp
  800b9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ba2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ba5:	c9                   	leave  
  800ba6:	c3                   	ret    

00800ba7 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ba7:	55                   	push   %ebp
  800ba8:	89 e5                	mov    %esp,%ebp
  800baa:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bad:	e8 ca 12 00 00       	call   801e7c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bb2:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbb:	83 ec 08             	sub    $0x8,%esp
  800bbe:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc1:	50                   	push   %eax
  800bc2:	e8 48 ff ff ff       	call   800b0f <vcprintf>
  800bc7:	83 c4 10             	add    $0x10,%esp
  800bca:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bcd:	e8 c4 12 00 00       	call   801e96 <sys_enable_interrupt>
	return cnt;
  800bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bd5:	c9                   	leave  
  800bd6:	c3                   	ret    

00800bd7 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bd7:	55                   	push   %ebp
  800bd8:	89 e5                	mov    %esp,%ebp
  800bda:	53                   	push   %ebx
  800bdb:	83 ec 14             	sub    $0x14,%esp
  800bde:	8b 45 10             	mov    0x10(%ebp),%eax
  800be1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800be4:	8b 45 14             	mov    0x14(%ebp),%eax
  800be7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bea:	8b 45 18             	mov    0x18(%ebp),%eax
  800bed:	ba 00 00 00 00       	mov    $0x0,%edx
  800bf2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bf5:	77 55                	ja     800c4c <printnum+0x75>
  800bf7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bfa:	72 05                	jb     800c01 <printnum+0x2a>
  800bfc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bff:	77 4b                	ja     800c4c <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c01:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c04:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c07:	8b 45 18             	mov    0x18(%ebp),%eax
  800c0a:	ba 00 00 00 00       	mov    $0x0,%edx
  800c0f:	52                   	push   %edx
  800c10:	50                   	push   %eax
  800c11:	ff 75 f4             	pushl  -0xc(%ebp)
  800c14:	ff 75 f0             	pushl  -0x10(%ebp)
  800c17:	e8 40 16 00 00       	call   80225c <__udivdi3>
  800c1c:	83 c4 10             	add    $0x10,%esp
  800c1f:	83 ec 04             	sub    $0x4,%esp
  800c22:	ff 75 20             	pushl  0x20(%ebp)
  800c25:	53                   	push   %ebx
  800c26:	ff 75 18             	pushl  0x18(%ebp)
  800c29:	52                   	push   %edx
  800c2a:	50                   	push   %eax
  800c2b:	ff 75 0c             	pushl  0xc(%ebp)
  800c2e:	ff 75 08             	pushl  0x8(%ebp)
  800c31:	e8 a1 ff ff ff       	call   800bd7 <printnum>
  800c36:	83 c4 20             	add    $0x20,%esp
  800c39:	eb 1a                	jmp    800c55 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c3b:	83 ec 08             	sub    $0x8,%esp
  800c3e:	ff 75 0c             	pushl  0xc(%ebp)
  800c41:	ff 75 20             	pushl  0x20(%ebp)
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	ff d0                	call   *%eax
  800c49:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c4c:	ff 4d 1c             	decl   0x1c(%ebp)
  800c4f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c53:	7f e6                	jg     800c3b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c55:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c58:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c60:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c63:	53                   	push   %ebx
  800c64:	51                   	push   %ecx
  800c65:	52                   	push   %edx
  800c66:	50                   	push   %eax
  800c67:	e8 00 17 00 00       	call   80236c <__umoddi3>
  800c6c:	83 c4 10             	add    $0x10,%esp
  800c6f:	05 54 2a 80 00       	add    $0x802a54,%eax
  800c74:	8a 00                	mov    (%eax),%al
  800c76:	0f be c0             	movsbl %al,%eax
  800c79:	83 ec 08             	sub    $0x8,%esp
  800c7c:	ff 75 0c             	pushl  0xc(%ebp)
  800c7f:	50                   	push   %eax
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	ff d0                	call   *%eax
  800c85:	83 c4 10             	add    $0x10,%esp
}
  800c88:	90                   	nop
  800c89:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c8c:	c9                   	leave  
  800c8d:	c3                   	ret    

00800c8e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c8e:	55                   	push   %ebp
  800c8f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c91:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c95:	7e 1c                	jle    800cb3 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	8b 00                	mov    (%eax),%eax
  800c9c:	8d 50 08             	lea    0x8(%eax),%edx
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	89 10                	mov    %edx,(%eax)
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	8b 00                	mov    (%eax),%eax
  800ca9:	83 e8 08             	sub    $0x8,%eax
  800cac:	8b 50 04             	mov    0x4(%eax),%edx
  800caf:	8b 00                	mov    (%eax),%eax
  800cb1:	eb 40                	jmp    800cf3 <getuint+0x65>
	else if (lflag)
  800cb3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cb7:	74 1e                	je     800cd7 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	8b 00                	mov    (%eax),%eax
  800cbe:	8d 50 04             	lea    0x4(%eax),%edx
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	89 10                	mov    %edx,(%eax)
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	8b 00                	mov    (%eax),%eax
  800ccb:	83 e8 04             	sub    $0x4,%eax
  800cce:	8b 00                	mov    (%eax),%eax
  800cd0:	ba 00 00 00 00       	mov    $0x0,%edx
  800cd5:	eb 1c                	jmp    800cf3 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8b 00                	mov    (%eax),%eax
  800cdc:	8d 50 04             	lea    0x4(%eax),%edx
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	89 10                	mov    %edx,(%eax)
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	8b 00                	mov    (%eax),%eax
  800ce9:	83 e8 04             	sub    $0x4,%eax
  800cec:	8b 00                	mov    (%eax),%eax
  800cee:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cf3:	5d                   	pop    %ebp
  800cf4:	c3                   	ret    

00800cf5 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cf5:	55                   	push   %ebp
  800cf6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cf8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cfc:	7e 1c                	jle    800d1a <getint+0x25>
		return va_arg(*ap, long long);
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8b 00                	mov    (%eax),%eax
  800d03:	8d 50 08             	lea    0x8(%eax),%edx
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	89 10                	mov    %edx,(%eax)
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8b 00                	mov    (%eax),%eax
  800d10:	83 e8 08             	sub    $0x8,%eax
  800d13:	8b 50 04             	mov    0x4(%eax),%edx
  800d16:	8b 00                	mov    (%eax),%eax
  800d18:	eb 38                	jmp    800d52 <getint+0x5d>
	else if (lflag)
  800d1a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d1e:	74 1a                	je     800d3a <getint+0x45>
		return va_arg(*ap, long);
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	8b 00                	mov    (%eax),%eax
  800d25:	8d 50 04             	lea    0x4(%eax),%edx
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	89 10                	mov    %edx,(%eax)
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	8b 00                	mov    (%eax),%eax
  800d32:	83 e8 04             	sub    $0x4,%eax
  800d35:	8b 00                	mov    (%eax),%eax
  800d37:	99                   	cltd   
  800d38:	eb 18                	jmp    800d52 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8b 00                	mov    (%eax),%eax
  800d3f:	8d 50 04             	lea    0x4(%eax),%edx
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	89 10                	mov    %edx,(%eax)
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	8b 00                	mov    (%eax),%eax
  800d4c:	83 e8 04             	sub    $0x4,%eax
  800d4f:	8b 00                	mov    (%eax),%eax
  800d51:	99                   	cltd   
}
  800d52:	5d                   	pop    %ebp
  800d53:	c3                   	ret    

00800d54 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d54:	55                   	push   %ebp
  800d55:	89 e5                	mov    %esp,%ebp
  800d57:	56                   	push   %esi
  800d58:	53                   	push   %ebx
  800d59:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d5c:	eb 17                	jmp    800d75 <vprintfmt+0x21>
			if (ch == '\0')
  800d5e:	85 db                	test   %ebx,%ebx
  800d60:	0f 84 af 03 00 00    	je     801115 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d66:	83 ec 08             	sub    $0x8,%esp
  800d69:	ff 75 0c             	pushl  0xc(%ebp)
  800d6c:	53                   	push   %ebx
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	ff d0                	call   *%eax
  800d72:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d75:	8b 45 10             	mov    0x10(%ebp),%eax
  800d78:	8d 50 01             	lea    0x1(%eax),%edx
  800d7b:	89 55 10             	mov    %edx,0x10(%ebp)
  800d7e:	8a 00                	mov    (%eax),%al
  800d80:	0f b6 d8             	movzbl %al,%ebx
  800d83:	83 fb 25             	cmp    $0x25,%ebx
  800d86:	75 d6                	jne    800d5e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d88:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d8c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d93:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d9a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800da1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800da8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dab:	8d 50 01             	lea    0x1(%eax),%edx
  800dae:	89 55 10             	mov    %edx,0x10(%ebp)
  800db1:	8a 00                	mov    (%eax),%al
  800db3:	0f b6 d8             	movzbl %al,%ebx
  800db6:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800db9:	83 f8 55             	cmp    $0x55,%eax
  800dbc:	0f 87 2b 03 00 00    	ja     8010ed <vprintfmt+0x399>
  800dc2:	8b 04 85 78 2a 80 00 	mov    0x802a78(,%eax,4),%eax
  800dc9:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dcb:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dcf:	eb d7                	jmp    800da8 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dd1:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dd5:	eb d1                	jmp    800da8 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dd7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800dde:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800de1:	89 d0                	mov    %edx,%eax
  800de3:	c1 e0 02             	shl    $0x2,%eax
  800de6:	01 d0                	add    %edx,%eax
  800de8:	01 c0                	add    %eax,%eax
  800dea:	01 d8                	add    %ebx,%eax
  800dec:	83 e8 30             	sub    $0x30,%eax
  800def:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800df2:	8b 45 10             	mov    0x10(%ebp),%eax
  800df5:	8a 00                	mov    (%eax),%al
  800df7:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800dfa:	83 fb 2f             	cmp    $0x2f,%ebx
  800dfd:	7e 3e                	jle    800e3d <vprintfmt+0xe9>
  800dff:	83 fb 39             	cmp    $0x39,%ebx
  800e02:	7f 39                	jg     800e3d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e04:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e07:	eb d5                	jmp    800dde <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e09:	8b 45 14             	mov    0x14(%ebp),%eax
  800e0c:	83 c0 04             	add    $0x4,%eax
  800e0f:	89 45 14             	mov    %eax,0x14(%ebp)
  800e12:	8b 45 14             	mov    0x14(%ebp),%eax
  800e15:	83 e8 04             	sub    $0x4,%eax
  800e18:	8b 00                	mov    (%eax),%eax
  800e1a:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e1d:	eb 1f                	jmp    800e3e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e1f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e23:	79 83                	jns    800da8 <vprintfmt+0x54>
				width = 0;
  800e25:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e2c:	e9 77 ff ff ff       	jmp    800da8 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e31:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e38:	e9 6b ff ff ff       	jmp    800da8 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e3d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e3e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e42:	0f 89 60 ff ff ff    	jns    800da8 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e48:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e4b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e4e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e55:	e9 4e ff ff ff       	jmp    800da8 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e5a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e5d:	e9 46 ff ff ff       	jmp    800da8 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e62:	8b 45 14             	mov    0x14(%ebp),%eax
  800e65:	83 c0 04             	add    $0x4,%eax
  800e68:	89 45 14             	mov    %eax,0x14(%ebp)
  800e6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6e:	83 e8 04             	sub    $0x4,%eax
  800e71:	8b 00                	mov    (%eax),%eax
  800e73:	83 ec 08             	sub    $0x8,%esp
  800e76:	ff 75 0c             	pushl  0xc(%ebp)
  800e79:	50                   	push   %eax
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	ff d0                	call   *%eax
  800e7f:	83 c4 10             	add    $0x10,%esp
			break;
  800e82:	e9 89 02 00 00       	jmp    801110 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e87:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8a:	83 c0 04             	add    $0x4,%eax
  800e8d:	89 45 14             	mov    %eax,0x14(%ebp)
  800e90:	8b 45 14             	mov    0x14(%ebp),%eax
  800e93:	83 e8 04             	sub    $0x4,%eax
  800e96:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e98:	85 db                	test   %ebx,%ebx
  800e9a:	79 02                	jns    800e9e <vprintfmt+0x14a>
				err = -err;
  800e9c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e9e:	83 fb 64             	cmp    $0x64,%ebx
  800ea1:	7f 0b                	jg     800eae <vprintfmt+0x15a>
  800ea3:	8b 34 9d c0 28 80 00 	mov    0x8028c0(,%ebx,4),%esi
  800eaa:	85 f6                	test   %esi,%esi
  800eac:	75 19                	jne    800ec7 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eae:	53                   	push   %ebx
  800eaf:	68 65 2a 80 00       	push   $0x802a65
  800eb4:	ff 75 0c             	pushl  0xc(%ebp)
  800eb7:	ff 75 08             	pushl  0x8(%ebp)
  800eba:	e8 5e 02 00 00       	call   80111d <printfmt>
  800ebf:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ec2:	e9 49 02 00 00       	jmp    801110 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ec7:	56                   	push   %esi
  800ec8:	68 6e 2a 80 00       	push   $0x802a6e
  800ecd:	ff 75 0c             	pushl  0xc(%ebp)
  800ed0:	ff 75 08             	pushl  0x8(%ebp)
  800ed3:	e8 45 02 00 00       	call   80111d <printfmt>
  800ed8:	83 c4 10             	add    $0x10,%esp
			break;
  800edb:	e9 30 02 00 00       	jmp    801110 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ee0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee3:	83 c0 04             	add    $0x4,%eax
  800ee6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ee9:	8b 45 14             	mov    0x14(%ebp),%eax
  800eec:	83 e8 04             	sub    $0x4,%eax
  800eef:	8b 30                	mov    (%eax),%esi
  800ef1:	85 f6                	test   %esi,%esi
  800ef3:	75 05                	jne    800efa <vprintfmt+0x1a6>
				p = "(null)";
  800ef5:	be 71 2a 80 00       	mov    $0x802a71,%esi
			if (width > 0 && padc != '-')
  800efa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800efe:	7e 6d                	jle    800f6d <vprintfmt+0x219>
  800f00:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f04:	74 67                	je     800f6d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f06:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f09:	83 ec 08             	sub    $0x8,%esp
  800f0c:	50                   	push   %eax
  800f0d:	56                   	push   %esi
  800f0e:	e8 0c 03 00 00       	call   80121f <strnlen>
  800f13:	83 c4 10             	add    $0x10,%esp
  800f16:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f19:	eb 16                	jmp    800f31 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f1b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f1f:	83 ec 08             	sub    $0x8,%esp
  800f22:	ff 75 0c             	pushl  0xc(%ebp)
  800f25:	50                   	push   %eax
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	ff d0                	call   *%eax
  800f2b:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f2e:	ff 4d e4             	decl   -0x1c(%ebp)
  800f31:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f35:	7f e4                	jg     800f1b <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f37:	eb 34                	jmp    800f6d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f39:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f3d:	74 1c                	je     800f5b <vprintfmt+0x207>
  800f3f:	83 fb 1f             	cmp    $0x1f,%ebx
  800f42:	7e 05                	jle    800f49 <vprintfmt+0x1f5>
  800f44:	83 fb 7e             	cmp    $0x7e,%ebx
  800f47:	7e 12                	jle    800f5b <vprintfmt+0x207>
					putch('?', putdat);
  800f49:	83 ec 08             	sub    $0x8,%esp
  800f4c:	ff 75 0c             	pushl  0xc(%ebp)
  800f4f:	6a 3f                	push   $0x3f
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
  800f54:	ff d0                	call   *%eax
  800f56:	83 c4 10             	add    $0x10,%esp
  800f59:	eb 0f                	jmp    800f6a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f5b:	83 ec 08             	sub    $0x8,%esp
  800f5e:	ff 75 0c             	pushl  0xc(%ebp)
  800f61:	53                   	push   %ebx
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	ff d0                	call   *%eax
  800f67:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f6a:	ff 4d e4             	decl   -0x1c(%ebp)
  800f6d:	89 f0                	mov    %esi,%eax
  800f6f:	8d 70 01             	lea    0x1(%eax),%esi
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	0f be d8             	movsbl %al,%ebx
  800f77:	85 db                	test   %ebx,%ebx
  800f79:	74 24                	je     800f9f <vprintfmt+0x24b>
  800f7b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f7f:	78 b8                	js     800f39 <vprintfmt+0x1e5>
  800f81:	ff 4d e0             	decl   -0x20(%ebp)
  800f84:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f88:	79 af                	jns    800f39 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f8a:	eb 13                	jmp    800f9f <vprintfmt+0x24b>
				putch(' ', putdat);
  800f8c:	83 ec 08             	sub    $0x8,%esp
  800f8f:	ff 75 0c             	pushl  0xc(%ebp)
  800f92:	6a 20                	push   $0x20
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	ff d0                	call   *%eax
  800f99:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f9c:	ff 4d e4             	decl   -0x1c(%ebp)
  800f9f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fa3:	7f e7                	jg     800f8c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fa5:	e9 66 01 00 00       	jmp    801110 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800faa:	83 ec 08             	sub    $0x8,%esp
  800fad:	ff 75 e8             	pushl  -0x18(%ebp)
  800fb0:	8d 45 14             	lea    0x14(%ebp),%eax
  800fb3:	50                   	push   %eax
  800fb4:	e8 3c fd ff ff       	call   800cf5 <getint>
  800fb9:	83 c4 10             	add    $0x10,%esp
  800fbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fbf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc8:	85 d2                	test   %edx,%edx
  800fca:	79 23                	jns    800fef <vprintfmt+0x29b>
				putch('-', putdat);
  800fcc:	83 ec 08             	sub    $0x8,%esp
  800fcf:	ff 75 0c             	pushl  0xc(%ebp)
  800fd2:	6a 2d                	push   $0x2d
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	ff d0                	call   *%eax
  800fd9:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fdf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe2:	f7 d8                	neg    %eax
  800fe4:	83 d2 00             	adc    $0x0,%edx
  800fe7:	f7 da                	neg    %edx
  800fe9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fec:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fef:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ff6:	e9 bc 00 00 00       	jmp    8010b7 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ffb:	83 ec 08             	sub    $0x8,%esp
  800ffe:	ff 75 e8             	pushl  -0x18(%ebp)
  801001:	8d 45 14             	lea    0x14(%ebp),%eax
  801004:	50                   	push   %eax
  801005:	e8 84 fc ff ff       	call   800c8e <getuint>
  80100a:	83 c4 10             	add    $0x10,%esp
  80100d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801010:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801013:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80101a:	e9 98 00 00 00       	jmp    8010b7 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80101f:	83 ec 08             	sub    $0x8,%esp
  801022:	ff 75 0c             	pushl  0xc(%ebp)
  801025:	6a 58                	push   $0x58
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	ff d0                	call   *%eax
  80102c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80102f:	83 ec 08             	sub    $0x8,%esp
  801032:	ff 75 0c             	pushl  0xc(%ebp)
  801035:	6a 58                	push   $0x58
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	ff d0                	call   *%eax
  80103c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80103f:	83 ec 08             	sub    $0x8,%esp
  801042:	ff 75 0c             	pushl  0xc(%ebp)
  801045:	6a 58                	push   $0x58
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	ff d0                	call   *%eax
  80104c:	83 c4 10             	add    $0x10,%esp
			break;
  80104f:	e9 bc 00 00 00       	jmp    801110 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801054:	83 ec 08             	sub    $0x8,%esp
  801057:	ff 75 0c             	pushl  0xc(%ebp)
  80105a:	6a 30                	push   $0x30
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	ff d0                	call   *%eax
  801061:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801064:	83 ec 08             	sub    $0x8,%esp
  801067:	ff 75 0c             	pushl  0xc(%ebp)
  80106a:	6a 78                	push   $0x78
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
  80106f:	ff d0                	call   *%eax
  801071:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801074:	8b 45 14             	mov    0x14(%ebp),%eax
  801077:	83 c0 04             	add    $0x4,%eax
  80107a:	89 45 14             	mov    %eax,0x14(%ebp)
  80107d:	8b 45 14             	mov    0x14(%ebp),%eax
  801080:	83 e8 04             	sub    $0x4,%eax
  801083:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801085:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801088:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80108f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801096:	eb 1f                	jmp    8010b7 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801098:	83 ec 08             	sub    $0x8,%esp
  80109b:	ff 75 e8             	pushl  -0x18(%ebp)
  80109e:	8d 45 14             	lea    0x14(%ebp),%eax
  8010a1:	50                   	push   %eax
  8010a2:	e8 e7 fb ff ff       	call   800c8e <getuint>
  8010a7:	83 c4 10             	add    $0x10,%esp
  8010aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ad:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010b0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010b7:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010be:	83 ec 04             	sub    $0x4,%esp
  8010c1:	52                   	push   %edx
  8010c2:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010c5:	50                   	push   %eax
  8010c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8010c9:	ff 75 f0             	pushl  -0x10(%ebp)
  8010cc:	ff 75 0c             	pushl  0xc(%ebp)
  8010cf:	ff 75 08             	pushl  0x8(%ebp)
  8010d2:	e8 00 fb ff ff       	call   800bd7 <printnum>
  8010d7:	83 c4 20             	add    $0x20,%esp
			break;
  8010da:	eb 34                	jmp    801110 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010dc:	83 ec 08             	sub    $0x8,%esp
  8010df:	ff 75 0c             	pushl  0xc(%ebp)
  8010e2:	53                   	push   %ebx
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	ff d0                	call   *%eax
  8010e8:	83 c4 10             	add    $0x10,%esp
			break;
  8010eb:	eb 23                	jmp    801110 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010ed:	83 ec 08             	sub    $0x8,%esp
  8010f0:	ff 75 0c             	pushl  0xc(%ebp)
  8010f3:	6a 25                	push   $0x25
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f8:	ff d0                	call   *%eax
  8010fa:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010fd:	ff 4d 10             	decl   0x10(%ebp)
  801100:	eb 03                	jmp    801105 <vprintfmt+0x3b1>
  801102:	ff 4d 10             	decl   0x10(%ebp)
  801105:	8b 45 10             	mov    0x10(%ebp),%eax
  801108:	48                   	dec    %eax
  801109:	8a 00                	mov    (%eax),%al
  80110b:	3c 25                	cmp    $0x25,%al
  80110d:	75 f3                	jne    801102 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80110f:	90                   	nop
		}
	}
  801110:	e9 47 fc ff ff       	jmp    800d5c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801115:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801116:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801119:	5b                   	pop    %ebx
  80111a:	5e                   	pop    %esi
  80111b:	5d                   	pop    %ebp
  80111c:	c3                   	ret    

0080111d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
  801120:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801123:	8d 45 10             	lea    0x10(%ebp),%eax
  801126:	83 c0 04             	add    $0x4,%eax
  801129:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80112c:	8b 45 10             	mov    0x10(%ebp),%eax
  80112f:	ff 75 f4             	pushl  -0xc(%ebp)
  801132:	50                   	push   %eax
  801133:	ff 75 0c             	pushl  0xc(%ebp)
  801136:	ff 75 08             	pushl  0x8(%ebp)
  801139:	e8 16 fc ff ff       	call   800d54 <vprintfmt>
  80113e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801141:	90                   	nop
  801142:	c9                   	leave  
  801143:	c3                   	ret    

00801144 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801147:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114a:	8b 40 08             	mov    0x8(%eax),%eax
  80114d:	8d 50 01             	lea    0x1(%eax),%edx
  801150:	8b 45 0c             	mov    0xc(%ebp),%eax
  801153:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801156:	8b 45 0c             	mov    0xc(%ebp),%eax
  801159:	8b 10                	mov    (%eax),%edx
  80115b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115e:	8b 40 04             	mov    0x4(%eax),%eax
  801161:	39 c2                	cmp    %eax,%edx
  801163:	73 12                	jae    801177 <sprintputch+0x33>
		*b->buf++ = ch;
  801165:	8b 45 0c             	mov    0xc(%ebp),%eax
  801168:	8b 00                	mov    (%eax),%eax
  80116a:	8d 48 01             	lea    0x1(%eax),%ecx
  80116d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801170:	89 0a                	mov    %ecx,(%edx)
  801172:	8b 55 08             	mov    0x8(%ebp),%edx
  801175:	88 10                	mov    %dl,(%eax)
}
  801177:	90                   	nop
  801178:	5d                   	pop    %ebp
  801179:	c3                   	ret    

0080117a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80117a:	55                   	push   %ebp
  80117b:	89 e5                	mov    %esp,%ebp
  80117d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801186:	8b 45 0c             	mov    0xc(%ebp),%eax
  801189:	8d 50 ff             	lea    -0x1(%eax),%edx
  80118c:	8b 45 08             	mov    0x8(%ebp),%eax
  80118f:	01 d0                	add    %edx,%eax
  801191:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801194:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80119b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80119f:	74 06                	je     8011a7 <vsnprintf+0x2d>
  8011a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011a5:	7f 07                	jg     8011ae <vsnprintf+0x34>
		return -E_INVAL;
  8011a7:	b8 03 00 00 00       	mov    $0x3,%eax
  8011ac:	eb 20                	jmp    8011ce <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011ae:	ff 75 14             	pushl  0x14(%ebp)
  8011b1:	ff 75 10             	pushl  0x10(%ebp)
  8011b4:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011b7:	50                   	push   %eax
  8011b8:	68 44 11 80 00       	push   $0x801144
  8011bd:	e8 92 fb ff ff       	call   800d54 <vprintfmt>
  8011c2:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011c8:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011ce:	c9                   	leave  
  8011cf:	c3                   	ret    

008011d0 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011d0:	55                   	push   %ebp
  8011d1:	89 e5                	mov    %esp,%ebp
  8011d3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011d6:	8d 45 10             	lea    0x10(%ebp),%eax
  8011d9:	83 c0 04             	add    $0x4,%eax
  8011dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011df:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8011e5:	50                   	push   %eax
  8011e6:	ff 75 0c             	pushl  0xc(%ebp)
  8011e9:	ff 75 08             	pushl  0x8(%ebp)
  8011ec:	e8 89 ff ff ff       	call   80117a <vsnprintf>
  8011f1:	83 c4 10             	add    $0x10,%esp
  8011f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011fa:	c9                   	leave  
  8011fb:	c3                   	ret    

008011fc <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8011fc:	55                   	push   %ebp
  8011fd:	89 e5                	mov    %esp,%ebp
  8011ff:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801202:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801209:	eb 06                	jmp    801211 <strlen+0x15>
		n++;
  80120b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80120e:	ff 45 08             	incl   0x8(%ebp)
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	84 c0                	test   %al,%al
  801218:	75 f1                	jne    80120b <strlen+0xf>
		n++;
	return n;
  80121a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80121d:	c9                   	leave  
  80121e:	c3                   	ret    

0080121f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80121f:	55                   	push   %ebp
  801220:	89 e5                	mov    %esp,%ebp
  801222:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801225:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80122c:	eb 09                	jmp    801237 <strnlen+0x18>
		n++;
  80122e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801231:	ff 45 08             	incl   0x8(%ebp)
  801234:	ff 4d 0c             	decl   0xc(%ebp)
  801237:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80123b:	74 09                	je     801246 <strnlen+0x27>
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	8a 00                	mov    (%eax),%al
  801242:	84 c0                	test   %al,%al
  801244:	75 e8                	jne    80122e <strnlen+0xf>
		n++;
	return n;
  801246:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801249:	c9                   	leave  
  80124a:	c3                   	ret    

0080124b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80124b:	55                   	push   %ebp
  80124c:	89 e5                	mov    %esp,%ebp
  80124e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801251:	8b 45 08             	mov    0x8(%ebp),%eax
  801254:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801257:	90                   	nop
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
  80125b:	8d 50 01             	lea    0x1(%eax),%edx
  80125e:	89 55 08             	mov    %edx,0x8(%ebp)
  801261:	8b 55 0c             	mov    0xc(%ebp),%edx
  801264:	8d 4a 01             	lea    0x1(%edx),%ecx
  801267:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80126a:	8a 12                	mov    (%edx),%dl
  80126c:	88 10                	mov    %dl,(%eax)
  80126e:	8a 00                	mov    (%eax),%al
  801270:	84 c0                	test   %al,%al
  801272:	75 e4                	jne    801258 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801274:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801277:	c9                   	leave  
  801278:	c3                   	ret    

00801279 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
  80127c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80127f:	8b 45 08             	mov    0x8(%ebp),%eax
  801282:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801285:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80128c:	eb 1f                	jmp    8012ad <strncpy+0x34>
		*dst++ = *src;
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	8d 50 01             	lea    0x1(%eax),%edx
  801294:	89 55 08             	mov    %edx,0x8(%ebp)
  801297:	8b 55 0c             	mov    0xc(%ebp),%edx
  80129a:	8a 12                	mov    (%edx),%dl
  80129c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	8a 00                	mov    (%eax),%al
  8012a3:	84 c0                	test   %al,%al
  8012a5:	74 03                	je     8012aa <strncpy+0x31>
			src++;
  8012a7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012aa:	ff 45 fc             	incl   -0x4(%ebp)
  8012ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012b0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012b3:	72 d9                	jb     80128e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
  8012bd:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012c6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ca:	74 30                	je     8012fc <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012cc:	eb 16                	jmp    8012e4 <strlcpy+0x2a>
			*dst++ = *src++;
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	8d 50 01             	lea    0x1(%eax),%edx
  8012d4:	89 55 08             	mov    %edx,0x8(%ebp)
  8012d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012da:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012dd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012e0:	8a 12                	mov    (%edx),%dl
  8012e2:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012e4:	ff 4d 10             	decl   0x10(%ebp)
  8012e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012eb:	74 09                	je     8012f6 <strlcpy+0x3c>
  8012ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f0:	8a 00                	mov    (%eax),%al
  8012f2:	84 c0                	test   %al,%al
  8012f4:	75 d8                	jne    8012ce <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8012f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8012fc:	8b 55 08             	mov    0x8(%ebp),%edx
  8012ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801302:	29 c2                	sub    %eax,%edx
  801304:	89 d0                	mov    %edx,%eax
}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80130b:	eb 06                	jmp    801313 <strcmp+0xb>
		p++, q++;
  80130d:	ff 45 08             	incl   0x8(%ebp)
  801310:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801313:	8b 45 08             	mov    0x8(%ebp),%eax
  801316:	8a 00                	mov    (%eax),%al
  801318:	84 c0                	test   %al,%al
  80131a:	74 0e                	je     80132a <strcmp+0x22>
  80131c:	8b 45 08             	mov    0x8(%ebp),%eax
  80131f:	8a 10                	mov    (%eax),%dl
  801321:	8b 45 0c             	mov    0xc(%ebp),%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	38 c2                	cmp    %al,%dl
  801328:	74 e3                	je     80130d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80132a:	8b 45 08             	mov    0x8(%ebp),%eax
  80132d:	8a 00                	mov    (%eax),%al
  80132f:	0f b6 d0             	movzbl %al,%edx
  801332:	8b 45 0c             	mov    0xc(%ebp),%eax
  801335:	8a 00                	mov    (%eax),%al
  801337:	0f b6 c0             	movzbl %al,%eax
  80133a:	29 c2                	sub    %eax,%edx
  80133c:	89 d0                	mov    %edx,%eax
}
  80133e:	5d                   	pop    %ebp
  80133f:	c3                   	ret    

00801340 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801340:	55                   	push   %ebp
  801341:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801343:	eb 09                	jmp    80134e <strncmp+0xe>
		n--, p++, q++;
  801345:	ff 4d 10             	decl   0x10(%ebp)
  801348:	ff 45 08             	incl   0x8(%ebp)
  80134b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80134e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801352:	74 17                	je     80136b <strncmp+0x2b>
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	8a 00                	mov    (%eax),%al
  801359:	84 c0                	test   %al,%al
  80135b:	74 0e                	je     80136b <strncmp+0x2b>
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	8a 10                	mov    (%eax),%dl
  801362:	8b 45 0c             	mov    0xc(%ebp),%eax
  801365:	8a 00                	mov    (%eax),%al
  801367:	38 c2                	cmp    %al,%dl
  801369:	74 da                	je     801345 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80136b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80136f:	75 07                	jne    801378 <strncmp+0x38>
		return 0;
  801371:	b8 00 00 00 00       	mov    $0x0,%eax
  801376:	eb 14                	jmp    80138c <strncmp+0x4c>
	else
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

0080138e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80138e:	55                   	push   %ebp
  80138f:	89 e5                	mov    %esp,%ebp
  801391:	83 ec 04             	sub    $0x4,%esp
  801394:	8b 45 0c             	mov    0xc(%ebp),%eax
  801397:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80139a:	eb 12                	jmp    8013ae <strchr+0x20>
		if (*s == c)
  80139c:	8b 45 08             	mov    0x8(%ebp),%eax
  80139f:	8a 00                	mov    (%eax),%al
  8013a1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013a4:	75 05                	jne    8013ab <strchr+0x1d>
			return (char *) s;
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	eb 11                	jmp    8013bc <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013ab:	ff 45 08             	incl   0x8(%ebp)
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	8a 00                	mov    (%eax),%al
  8013b3:	84 c0                	test   %al,%al
  8013b5:	75 e5                	jne    80139c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013bc:	c9                   	leave  
  8013bd:	c3                   	ret    

008013be <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013be:	55                   	push   %ebp
  8013bf:	89 e5                	mov    %esp,%ebp
  8013c1:	83 ec 04             	sub    $0x4,%esp
  8013c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ca:	eb 0d                	jmp    8013d9 <strfind+0x1b>
		if (*s == c)
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	8a 00                	mov    (%eax),%al
  8013d1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013d4:	74 0e                	je     8013e4 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013d6:	ff 45 08             	incl   0x8(%ebp)
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dc:	8a 00                	mov    (%eax),%al
  8013de:	84 c0                	test   %al,%al
  8013e0:	75 ea                	jne    8013cc <strfind+0xe>
  8013e2:	eb 01                	jmp    8013e5 <strfind+0x27>
		if (*s == c)
			break;
  8013e4:	90                   	nop
	return (char *) s;
  8013e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013e8:	c9                   	leave  
  8013e9:	c3                   	ret    

008013ea <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8013ea:	55                   	push   %ebp
  8013eb:	89 e5                	mov    %esp,%ebp
  8013ed:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8013f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8013fc:	eb 0e                	jmp    80140c <memset+0x22>
		*p++ = c;
  8013fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801401:	8d 50 01             	lea    0x1(%eax),%edx
  801404:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801407:	8b 55 0c             	mov    0xc(%ebp),%edx
  80140a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80140c:	ff 4d f8             	decl   -0x8(%ebp)
  80140f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801413:	79 e9                	jns    8013fe <memset+0x14>
		*p++ = c;

	return v;
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801418:	c9                   	leave  
  801419:	c3                   	ret    

0080141a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80141a:	55                   	push   %ebp
  80141b:	89 e5                	mov    %esp,%ebp
  80141d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801420:	8b 45 0c             	mov    0xc(%ebp),%eax
  801423:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801426:	8b 45 08             	mov    0x8(%ebp),%eax
  801429:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80142c:	eb 16                	jmp    801444 <memcpy+0x2a>
		*d++ = *s++;
  80142e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801431:	8d 50 01             	lea    0x1(%eax),%edx
  801434:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801437:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80143a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80143d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801440:	8a 12                	mov    (%edx),%dl
  801442:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801444:	8b 45 10             	mov    0x10(%ebp),%eax
  801447:	8d 50 ff             	lea    -0x1(%eax),%edx
  80144a:	89 55 10             	mov    %edx,0x10(%ebp)
  80144d:	85 c0                	test   %eax,%eax
  80144f:	75 dd                	jne    80142e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
  801459:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80145c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801468:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80146b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80146e:	73 50                	jae    8014c0 <memmove+0x6a>
  801470:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801473:	8b 45 10             	mov    0x10(%ebp),%eax
  801476:	01 d0                	add    %edx,%eax
  801478:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80147b:	76 43                	jbe    8014c0 <memmove+0x6a>
		s += n;
  80147d:	8b 45 10             	mov    0x10(%ebp),%eax
  801480:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801483:	8b 45 10             	mov    0x10(%ebp),%eax
  801486:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801489:	eb 10                	jmp    80149b <memmove+0x45>
			*--d = *--s;
  80148b:	ff 4d f8             	decl   -0x8(%ebp)
  80148e:	ff 4d fc             	decl   -0x4(%ebp)
  801491:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801494:	8a 10                	mov    (%eax),%dl
  801496:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801499:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80149b:	8b 45 10             	mov    0x10(%ebp),%eax
  80149e:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014a1:	89 55 10             	mov    %edx,0x10(%ebp)
  8014a4:	85 c0                	test   %eax,%eax
  8014a6:	75 e3                	jne    80148b <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014a8:	eb 23                	jmp    8014cd <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ad:	8d 50 01             	lea    0x1(%eax),%edx
  8014b0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014b3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014b6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014b9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014bc:	8a 12                	mov    (%edx),%dl
  8014be:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014c6:	89 55 10             	mov    %edx,0x10(%ebp)
  8014c9:	85 c0                	test   %eax,%eax
  8014cb:	75 dd                	jne    8014aa <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014cd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
  8014d5:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8014de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e1:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8014e4:	eb 2a                	jmp    801510 <memcmp+0x3e>
		if (*s1 != *s2)
  8014e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e9:	8a 10                	mov    (%eax),%dl
  8014eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ee:	8a 00                	mov    (%eax),%al
  8014f0:	38 c2                	cmp    %al,%dl
  8014f2:	74 16                	je     80150a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8014f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f7:	8a 00                	mov    (%eax),%al
  8014f9:	0f b6 d0             	movzbl %al,%edx
  8014fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ff:	8a 00                	mov    (%eax),%al
  801501:	0f b6 c0             	movzbl %al,%eax
  801504:	29 c2                	sub    %eax,%edx
  801506:	89 d0                	mov    %edx,%eax
  801508:	eb 18                	jmp    801522 <memcmp+0x50>
		s1++, s2++;
  80150a:	ff 45 fc             	incl   -0x4(%ebp)
  80150d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801510:	8b 45 10             	mov    0x10(%ebp),%eax
  801513:	8d 50 ff             	lea    -0x1(%eax),%edx
  801516:	89 55 10             	mov    %edx,0x10(%ebp)
  801519:	85 c0                	test   %eax,%eax
  80151b:	75 c9                	jne    8014e6 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80151d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801522:	c9                   	leave  
  801523:	c3                   	ret    

00801524 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801524:	55                   	push   %ebp
  801525:	89 e5                	mov    %esp,%ebp
  801527:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80152a:	8b 55 08             	mov    0x8(%ebp),%edx
  80152d:	8b 45 10             	mov    0x10(%ebp),%eax
  801530:	01 d0                	add    %edx,%eax
  801532:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801535:	eb 15                	jmp    80154c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801537:	8b 45 08             	mov    0x8(%ebp),%eax
  80153a:	8a 00                	mov    (%eax),%al
  80153c:	0f b6 d0             	movzbl %al,%edx
  80153f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801542:	0f b6 c0             	movzbl %al,%eax
  801545:	39 c2                	cmp    %eax,%edx
  801547:	74 0d                	je     801556 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801549:	ff 45 08             	incl   0x8(%ebp)
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801552:	72 e3                	jb     801537 <memfind+0x13>
  801554:	eb 01                	jmp    801557 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801556:	90                   	nop
	return (void *) s;
  801557:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80155a:	c9                   	leave  
  80155b:	c3                   	ret    

0080155c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80155c:	55                   	push   %ebp
  80155d:	89 e5                	mov    %esp,%ebp
  80155f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801562:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801569:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801570:	eb 03                	jmp    801575 <strtol+0x19>
		s++;
  801572:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801575:	8b 45 08             	mov    0x8(%ebp),%eax
  801578:	8a 00                	mov    (%eax),%al
  80157a:	3c 20                	cmp    $0x20,%al
  80157c:	74 f4                	je     801572 <strtol+0x16>
  80157e:	8b 45 08             	mov    0x8(%ebp),%eax
  801581:	8a 00                	mov    (%eax),%al
  801583:	3c 09                	cmp    $0x9,%al
  801585:	74 eb                	je     801572 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	8a 00                	mov    (%eax),%al
  80158c:	3c 2b                	cmp    $0x2b,%al
  80158e:	75 05                	jne    801595 <strtol+0x39>
		s++;
  801590:	ff 45 08             	incl   0x8(%ebp)
  801593:	eb 13                	jmp    8015a8 <strtol+0x4c>
	else if (*s == '-')
  801595:	8b 45 08             	mov    0x8(%ebp),%eax
  801598:	8a 00                	mov    (%eax),%al
  80159a:	3c 2d                	cmp    $0x2d,%al
  80159c:	75 0a                	jne    8015a8 <strtol+0x4c>
		s++, neg = 1;
  80159e:	ff 45 08             	incl   0x8(%ebp)
  8015a1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015a8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015ac:	74 06                	je     8015b4 <strtol+0x58>
  8015ae:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015b2:	75 20                	jne    8015d4 <strtol+0x78>
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b7:	8a 00                	mov    (%eax),%al
  8015b9:	3c 30                	cmp    $0x30,%al
  8015bb:	75 17                	jne    8015d4 <strtol+0x78>
  8015bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c0:	40                   	inc    %eax
  8015c1:	8a 00                	mov    (%eax),%al
  8015c3:	3c 78                	cmp    $0x78,%al
  8015c5:	75 0d                	jne    8015d4 <strtol+0x78>
		s += 2, base = 16;
  8015c7:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015cb:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015d2:	eb 28                	jmp    8015fc <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015d4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015d8:	75 15                	jne    8015ef <strtol+0x93>
  8015da:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dd:	8a 00                	mov    (%eax),%al
  8015df:	3c 30                	cmp    $0x30,%al
  8015e1:	75 0c                	jne    8015ef <strtol+0x93>
		s++, base = 8;
  8015e3:	ff 45 08             	incl   0x8(%ebp)
  8015e6:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8015ed:	eb 0d                	jmp    8015fc <strtol+0xa0>
	else if (base == 0)
  8015ef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015f3:	75 07                	jne    8015fc <strtol+0xa0>
		base = 10;
  8015f5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	8a 00                	mov    (%eax),%al
  801601:	3c 2f                	cmp    $0x2f,%al
  801603:	7e 19                	jle    80161e <strtol+0xc2>
  801605:	8b 45 08             	mov    0x8(%ebp),%eax
  801608:	8a 00                	mov    (%eax),%al
  80160a:	3c 39                	cmp    $0x39,%al
  80160c:	7f 10                	jg     80161e <strtol+0xc2>
			dig = *s - '0';
  80160e:	8b 45 08             	mov    0x8(%ebp),%eax
  801611:	8a 00                	mov    (%eax),%al
  801613:	0f be c0             	movsbl %al,%eax
  801616:	83 e8 30             	sub    $0x30,%eax
  801619:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80161c:	eb 42                	jmp    801660 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80161e:	8b 45 08             	mov    0x8(%ebp),%eax
  801621:	8a 00                	mov    (%eax),%al
  801623:	3c 60                	cmp    $0x60,%al
  801625:	7e 19                	jle    801640 <strtol+0xe4>
  801627:	8b 45 08             	mov    0x8(%ebp),%eax
  80162a:	8a 00                	mov    (%eax),%al
  80162c:	3c 7a                	cmp    $0x7a,%al
  80162e:	7f 10                	jg     801640 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801630:	8b 45 08             	mov    0x8(%ebp),%eax
  801633:	8a 00                	mov    (%eax),%al
  801635:	0f be c0             	movsbl %al,%eax
  801638:	83 e8 57             	sub    $0x57,%eax
  80163b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80163e:	eb 20                	jmp    801660 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801640:	8b 45 08             	mov    0x8(%ebp),%eax
  801643:	8a 00                	mov    (%eax),%al
  801645:	3c 40                	cmp    $0x40,%al
  801647:	7e 39                	jle    801682 <strtol+0x126>
  801649:	8b 45 08             	mov    0x8(%ebp),%eax
  80164c:	8a 00                	mov    (%eax),%al
  80164e:	3c 5a                	cmp    $0x5a,%al
  801650:	7f 30                	jg     801682 <strtol+0x126>
			dig = *s - 'A' + 10;
  801652:	8b 45 08             	mov    0x8(%ebp),%eax
  801655:	8a 00                	mov    (%eax),%al
  801657:	0f be c0             	movsbl %al,%eax
  80165a:	83 e8 37             	sub    $0x37,%eax
  80165d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801660:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801663:	3b 45 10             	cmp    0x10(%ebp),%eax
  801666:	7d 19                	jge    801681 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801668:	ff 45 08             	incl   0x8(%ebp)
  80166b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80166e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801672:	89 c2                	mov    %eax,%edx
  801674:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801677:	01 d0                	add    %edx,%eax
  801679:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80167c:	e9 7b ff ff ff       	jmp    8015fc <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801681:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801682:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801686:	74 08                	je     801690 <strtol+0x134>
		*endptr = (char *) s;
  801688:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168b:	8b 55 08             	mov    0x8(%ebp),%edx
  80168e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801690:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801694:	74 07                	je     80169d <strtol+0x141>
  801696:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801699:	f7 d8                	neg    %eax
  80169b:	eb 03                	jmp    8016a0 <strtol+0x144>
  80169d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <ltostr>:

void
ltostr(long value, char *str)
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
  8016a5:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016af:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016b6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016ba:	79 13                	jns    8016cf <ltostr+0x2d>
	{
		neg = 1;
  8016bc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c6:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016c9:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016cc:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d2:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016d7:	99                   	cltd   
  8016d8:	f7 f9                	idiv   %ecx
  8016da:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8016dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e0:	8d 50 01             	lea    0x1(%eax),%edx
  8016e3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016e6:	89 c2                	mov    %eax,%edx
  8016e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016eb:	01 d0                	add    %edx,%eax
  8016ed:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016f0:	83 c2 30             	add    $0x30,%edx
  8016f3:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8016f5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016f8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8016fd:	f7 e9                	imul   %ecx
  8016ff:	c1 fa 02             	sar    $0x2,%edx
  801702:	89 c8                	mov    %ecx,%eax
  801704:	c1 f8 1f             	sar    $0x1f,%eax
  801707:	29 c2                	sub    %eax,%edx
  801709:	89 d0                	mov    %edx,%eax
  80170b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80170e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801711:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801716:	f7 e9                	imul   %ecx
  801718:	c1 fa 02             	sar    $0x2,%edx
  80171b:	89 c8                	mov    %ecx,%eax
  80171d:	c1 f8 1f             	sar    $0x1f,%eax
  801720:	29 c2                	sub    %eax,%edx
  801722:	89 d0                	mov    %edx,%eax
  801724:	c1 e0 02             	shl    $0x2,%eax
  801727:	01 d0                	add    %edx,%eax
  801729:	01 c0                	add    %eax,%eax
  80172b:	29 c1                	sub    %eax,%ecx
  80172d:	89 ca                	mov    %ecx,%edx
  80172f:	85 d2                	test   %edx,%edx
  801731:	75 9c                	jne    8016cf <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801733:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80173a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80173d:	48                   	dec    %eax
  80173e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801741:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801745:	74 3d                	je     801784 <ltostr+0xe2>
		start = 1 ;
  801747:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80174e:	eb 34                	jmp    801784 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801750:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801753:	8b 45 0c             	mov    0xc(%ebp),%eax
  801756:	01 d0                	add    %edx,%eax
  801758:	8a 00                	mov    (%eax),%al
  80175a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80175d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801760:	8b 45 0c             	mov    0xc(%ebp),%eax
  801763:	01 c2                	add    %eax,%edx
  801765:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801768:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176b:	01 c8                	add    %ecx,%eax
  80176d:	8a 00                	mov    (%eax),%al
  80176f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801771:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801774:	8b 45 0c             	mov    0xc(%ebp),%eax
  801777:	01 c2                	add    %eax,%edx
  801779:	8a 45 eb             	mov    -0x15(%ebp),%al
  80177c:	88 02                	mov    %al,(%edx)
		start++ ;
  80177e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801781:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801784:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801787:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80178a:	7c c4                	jl     801750 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80178c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80178f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801792:	01 d0                	add    %edx,%eax
  801794:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801797:	90                   	nop
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
  80179d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017a0:	ff 75 08             	pushl  0x8(%ebp)
  8017a3:	e8 54 fa ff ff       	call   8011fc <strlen>
  8017a8:	83 c4 04             	add    $0x4,%esp
  8017ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017ae:	ff 75 0c             	pushl  0xc(%ebp)
  8017b1:	e8 46 fa ff ff       	call   8011fc <strlen>
  8017b6:	83 c4 04             	add    $0x4,%esp
  8017b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017ca:	eb 17                	jmp    8017e3 <strcconcat+0x49>
		final[s] = str1[s] ;
  8017cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d2:	01 c2                	add    %eax,%edx
  8017d4:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017da:	01 c8                	add    %ecx,%eax
  8017dc:	8a 00                	mov    (%eax),%al
  8017de:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8017e0:	ff 45 fc             	incl   -0x4(%ebp)
  8017e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017e6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8017e9:	7c e1                	jl     8017cc <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8017eb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8017f2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8017f9:	eb 1f                	jmp    80181a <strcconcat+0x80>
		final[s++] = str2[i] ;
  8017fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017fe:	8d 50 01             	lea    0x1(%eax),%edx
  801801:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801804:	89 c2                	mov    %eax,%edx
  801806:	8b 45 10             	mov    0x10(%ebp),%eax
  801809:	01 c2                	add    %eax,%edx
  80180b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80180e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801811:	01 c8                	add    %ecx,%eax
  801813:	8a 00                	mov    (%eax),%al
  801815:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801817:	ff 45 f8             	incl   -0x8(%ebp)
  80181a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80181d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801820:	7c d9                	jl     8017fb <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801822:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801825:	8b 45 10             	mov    0x10(%ebp),%eax
  801828:	01 d0                	add    %edx,%eax
  80182a:	c6 00 00             	movb   $0x0,(%eax)
}
  80182d:	90                   	nop
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801833:	8b 45 14             	mov    0x14(%ebp),%eax
  801836:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80183c:	8b 45 14             	mov    0x14(%ebp),%eax
  80183f:	8b 00                	mov    (%eax),%eax
  801841:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801848:	8b 45 10             	mov    0x10(%ebp),%eax
  80184b:	01 d0                	add    %edx,%eax
  80184d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801853:	eb 0c                	jmp    801861 <strsplit+0x31>
			*string++ = 0;
  801855:	8b 45 08             	mov    0x8(%ebp),%eax
  801858:	8d 50 01             	lea    0x1(%eax),%edx
  80185b:	89 55 08             	mov    %edx,0x8(%ebp)
  80185e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801861:	8b 45 08             	mov    0x8(%ebp),%eax
  801864:	8a 00                	mov    (%eax),%al
  801866:	84 c0                	test   %al,%al
  801868:	74 18                	je     801882 <strsplit+0x52>
  80186a:	8b 45 08             	mov    0x8(%ebp),%eax
  80186d:	8a 00                	mov    (%eax),%al
  80186f:	0f be c0             	movsbl %al,%eax
  801872:	50                   	push   %eax
  801873:	ff 75 0c             	pushl  0xc(%ebp)
  801876:	e8 13 fb ff ff       	call   80138e <strchr>
  80187b:	83 c4 08             	add    $0x8,%esp
  80187e:	85 c0                	test   %eax,%eax
  801880:	75 d3                	jne    801855 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801882:	8b 45 08             	mov    0x8(%ebp),%eax
  801885:	8a 00                	mov    (%eax),%al
  801887:	84 c0                	test   %al,%al
  801889:	74 5a                	je     8018e5 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80188b:	8b 45 14             	mov    0x14(%ebp),%eax
  80188e:	8b 00                	mov    (%eax),%eax
  801890:	83 f8 0f             	cmp    $0xf,%eax
  801893:	75 07                	jne    80189c <strsplit+0x6c>
		{
			return 0;
  801895:	b8 00 00 00 00       	mov    $0x0,%eax
  80189a:	eb 66                	jmp    801902 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80189c:	8b 45 14             	mov    0x14(%ebp),%eax
  80189f:	8b 00                	mov    (%eax),%eax
  8018a1:	8d 48 01             	lea    0x1(%eax),%ecx
  8018a4:	8b 55 14             	mov    0x14(%ebp),%edx
  8018a7:	89 0a                	mov    %ecx,(%edx)
  8018a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b3:	01 c2                	add    %eax,%edx
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018ba:	eb 03                	jmp    8018bf <strsplit+0x8f>
			string++;
  8018bc:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c2:	8a 00                	mov    (%eax),%al
  8018c4:	84 c0                	test   %al,%al
  8018c6:	74 8b                	je     801853 <strsplit+0x23>
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	8a 00                	mov    (%eax),%al
  8018cd:	0f be c0             	movsbl %al,%eax
  8018d0:	50                   	push   %eax
  8018d1:	ff 75 0c             	pushl  0xc(%ebp)
  8018d4:	e8 b5 fa ff ff       	call   80138e <strchr>
  8018d9:	83 c4 08             	add    $0x8,%esp
  8018dc:	85 c0                	test   %eax,%eax
  8018de:	74 dc                	je     8018bc <strsplit+0x8c>
			string++;
	}
  8018e0:	e9 6e ff ff ff       	jmp    801853 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8018e5:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8018e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e9:	8b 00                	mov    (%eax),%eax
  8018eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f5:	01 d0                	add    %edx,%eax
  8018f7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8018fd:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801902:	c9                   	leave  
  801903:	c3                   	ret    

00801904 <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  801904:	55                   	push   %ebp
  801905:	89 e5                	mov    %esp,%ebp
  801907:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  80190a:	a1 04 30 80 00       	mov    0x803004,%eax
  80190f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801912:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  801919:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801920:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  801927:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  80192e:	e9 f9 00 00 00       	jmp    801a2c <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  801933:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801936:	05 00 00 00 80       	add    $0x80000000,%eax
  80193b:	c1 e8 0c             	shr    $0xc,%eax
  80193e:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801945:	85 c0                	test   %eax,%eax
  801947:	75 1c                	jne    801965 <nextFitAlgo+0x61>
  801949:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  80194d:	74 16                	je     801965 <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  80194f:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801956:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  80195d:	ff 4d e0             	decl   -0x20(%ebp)
  801960:	e9 90 00 00 00       	jmp    8019f5 <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  801965:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801968:	05 00 00 00 80       	add    $0x80000000,%eax
  80196d:	c1 e8 0c             	shr    $0xc,%eax
  801970:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801977:	85 c0                	test   %eax,%eax
  801979:	75 26                	jne    8019a1 <nextFitAlgo+0x9d>
  80197b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  80197f:	75 20                	jne    8019a1 <nextFitAlgo+0x9d>
			flag = 1;
  801981:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  801988:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80198b:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  80198e:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801995:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  80199c:	ff 4d e0             	decl   -0x20(%ebp)
  80199f:	eb 54                	jmp    8019f5 <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  8019a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019a4:	3b 45 08             	cmp    0x8(%ebp),%eax
  8019a7:	72 11                	jb     8019ba <nextFitAlgo+0xb6>
				startAdd = tmp;
  8019a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019ac:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  8019b1:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  8019b8:	eb 7c                	jmp    801a36 <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  8019ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019bd:	05 00 00 00 80       	add    $0x80000000,%eax
  8019c2:	c1 e8 0c             	shr    $0xc,%eax
  8019c5:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8019cc:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  8019cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019d2:	05 00 00 00 80       	add    $0x80000000,%eax
  8019d7:	c1 e8 0c             	shr    $0xc,%eax
  8019da:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8019e1:	c1 e0 0c             	shl    $0xc,%eax
  8019e4:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  8019e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019ee:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  8019f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019f8:	3b 45 08             	cmp    0x8(%ebp),%eax
  8019fb:	72 11                	jb     801a0e <nextFitAlgo+0x10a>
			startAdd = tmp;
  8019fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a00:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  801a05:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  801a0c:	eb 28                	jmp    801a36 <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  801a0e:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  801a15:	76 15                	jbe    801a2c <nextFitAlgo+0x128>
			flag = newSize = 0;
  801a17:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a1e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  801a25:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  801a2c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801a30:	0f 85 fd fe ff ff    	jne    801933 <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  801a36:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801a3a:	75 1a                	jne    801a56 <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  801a3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a3f:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a42:	73 0a                	jae    801a4e <nextFitAlgo+0x14a>
  801a44:	b8 00 00 00 00       	mov    $0x0,%eax
  801a49:	e9 99 00 00 00       	jmp    801ae7 <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  801a4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a51:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  801a56:	a1 04 30 80 00       	mov    0x803004,%eax
  801a5b:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  801a5e:	a1 04 30 80 00       	mov    0x803004,%eax
  801a63:	05 00 00 00 80       	add    $0x80000000,%eax
  801a68:	c1 e8 0c             	shr    $0xc,%eax
  801a6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  801a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a71:	c1 e8 0c             	shr    $0xc,%eax
  801a74:	89 c2                	mov    %eax,%edx
  801a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a79:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  801a80:	a1 04 30 80 00       	mov    0x803004,%eax
  801a85:	83 ec 08             	sub    $0x8,%esp
  801a88:	ff 75 08             	pushl  0x8(%ebp)
  801a8b:	50                   	push   %eax
  801a8c:	e8 82 03 00 00       	call   801e13 <sys_allocateMem>
  801a91:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  801a94:	a1 04 30 80 00       	mov    0x803004,%eax
  801a99:	05 00 00 00 80       	add    $0x80000000,%eax
  801a9e:	c1 e8 0c             	shr    $0xc,%eax
  801aa1:	89 c2                	mov    %eax,%edx
  801aa3:	a1 04 30 80 00       	mov    0x803004,%eax
  801aa8:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  801aaf:	a1 04 30 80 00       	mov    0x803004,%eax
  801ab4:	05 00 00 00 80       	add    $0x80000000,%eax
  801ab9:	c1 e8 0c             	shr    $0xc,%eax
  801abc:	89 c2                	mov    %eax,%edx
  801abe:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac1:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  801ac8:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801ace:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad1:	01 d0                	add    %edx,%eax
  801ad3:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  801ad8:	76 0a                	jbe    801ae4 <nextFitAlgo+0x1e0>
  801ada:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  801ae1:	00 00 80 

	return (void*)returnHolder;
  801ae4:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <malloc>:

void* malloc(uint32 size) {
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
  801aec:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  801aef:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  801af6:	8b 55 08             	mov    0x8(%ebp),%edx
  801af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801afc:	01 d0                	add    %edx,%eax
  801afe:	48                   	dec    %eax
  801aff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b02:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b05:	ba 00 00 00 00       	mov    $0x0,%edx
  801b0a:	f7 75 f4             	divl   -0xc(%ebp)
  801b0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b10:	29 d0                	sub    %edx,%eax
  801b12:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801b15:	e8 c3 06 00 00       	call   8021dd <sys_isUHeapPlacementStrategyNEXTFIT>
  801b1a:	85 c0                	test   %eax,%eax
  801b1c:	74 10                	je     801b2e <malloc+0x45>
		return nextFitAlgo(size);
  801b1e:	83 ec 0c             	sub    $0xc,%esp
  801b21:	ff 75 08             	pushl  0x8(%ebp)
  801b24:	e8 db fd ff ff       	call   801904 <nextFitAlgo>
  801b29:	83 c4 10             	add    $0x10,%esp
  801b2c:	eb 0a                	jmp    801b38 <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  801b2e:	e8 79 06 00 00       	call   8021ac <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  801b33:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b38:	c9                   	leave  
  801b39:	c3                   	ret    

00801b3a <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b3a:	55                   	push   %ebp
  801b3b:	89 e5                	mov    %esp,%ebp
  801b3d:	83 ec 18             	sub    $0x18,%esp
  801b40:	8b 45 10             	mov    0x10(%ebp),%eax
  801b43:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801b46:	83 ec 04             	sub    $0x4,%esp
  801b49:	68 d0 2b 80 00       	push   $0x802bd0
  801b4e:	6a 7e                	push   $0x7e
  801b50:	68 ef 2b 80 00       	push   $0x802bef
  801b55:	e8 6c ed ff ff       	call   8008c6 <_panic>

00801b5a <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b5a:	55                   	push   %ebp
  801b5b:	89 e5                	mov    %esp,%ebp
  801b5d:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801b60:	83 ec 04             	sub    $0x4,%esp
  801b63:	68 fb 2b 80 00       	push   $0x802bfb
  801b68:	68 84 00 00 00       	push   $0x84
  801b6d:	68 ef 2b 80 00       	push   $0x802bef
  801b72:	e8 4f ed ff ff       	call   8008c6 <_panic>

00801b77 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801b77:	55                   	push   %ebp
  801b78:	89 e5                	mov    %esp,%ebp
  801b7a:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801b7d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b84:	eb 61                	jmp    801be7 <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  801b86:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b89:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  801b90:	8b 45 08             	mov    0x8(%ebp),%eax
  801b93:	39 c2                	cmp    %eax,%edx
  801b95:	75 4d                	jne    801be4 <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  801b97:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9a:	05 00 00 00 80       	add    $0x80000000,%eax
  801b9f:	c1 e8 0c             	shr    $0xc,%eax
  801ba2:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801ba5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ba8:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  801baf:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  801bb2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bb5:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  801bbc:	00 00 00 00 
  801bc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bc3:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  801bca:	00 00 00 00 
  801bce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bd1:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  801bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bdb:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  801be2:	eb 0d                	jmp    801bf1 <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801be4:	ff 45 f0             	incl   -0x10(%ebp)
  801be7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bea:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801bef:	76 95                	jbe    801b86 <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  801bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf4:	83 ec 08             	sub    $0x8,%esp
  801bf7:	ff 75 f4             	pushl  -0xc(%ebp)
  801bfa:	50                   	push   %eax
  801bfb:	e8 f7 01 00 00       	call   801df7 <sys_freeMem>
  801c00:	83 c4 10             	add    $0x10,%esp
}
  801c03:	90                   	nop
  801c04:	c9                   	leave  
  801c05:	c3                   	ret    

00801c06 <sfree>:


void sfree(void* virtual_address)
{
  801c06:	55                   	push   %ebp
  801c07:	89 e5                	mov    %esp,%ebp
  801c09:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801c0c:	83 ec 04             	sub    $0x4,%esp
  801c0f:	68 17 2c 80 00       	push   $0x802c17
  801c14:	68 ac 00 00 00       	push   $0xac
  801c19:	68 ef 2b 80 00       	push   $0x802bef
  801c1e:	e8 a3 ec ff ff       	call   8008c6 <_panic>

00801c23 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801c23:	55                   	push   %ebp
  801c24:	89 e5                	mov    %esp,%ebp
  801c26:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801c29:	83 ec 04             	sub    $0x4,%esp
  801c2c:	68 34 2c 80 00       	push   $0x802c34
  801c31:	68 c4 00 00 00       	push   $0xc4
  801c36:	68 ef 2b 80 00       	push   $0x802bef
  801c3b:	e8 86 ec ff ff       	call   8008c6 <_panic>

00801c40 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c40:	55                   	push   %ebp
  801c41:	89 e5                	mov    %esp,%ebp
  801c43:	57                   	push   %edi
  801c44:	56                   	push   %esi
  801c45:	53                   	push   %ebx
  801c46:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c49:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c4f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c52:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c55:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c58:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c5b:	cd 30                	int    $0x30
  801c5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c60:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c63:	83 c4 10             	add    $0x10,%esp
  801c66:	5b                   	pop    %ebx
  801c67:	5e                   	pop    %esi
  801c68:	5f                   	pop    %edi
  801c69:	5d                   	pop    %ebp
  801c6a:	c3                   	ret    

00801c6b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c6b:	55                   	push   %ebp
  801c6c:	89 e5                	mov    %esp,%ebp
  801c6e:	83 ec 04             	sub    $0x4,%esp
  801c71:	8b 45 10             	mov    0x10(%ebp),%eax
  801c74:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c77:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	52                   	push   %edx
  801c83:	ff 75 0c             	pushl  0xc(%ebp)
  801c86:	50                   	push   %eax
  801c87:	6a 00                	push   $0x0
  801c89:	e8 b2 ff ff ff       	call   801c40 <syscall>
  801c8e:	83 c4 18             	add    $0x18,%esp
}
  801c91:	90                   	nop
  801c92:	c9                   	leave  
  801c93:	c3                   	ret    

00801c94 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c94:	55                   	push   %ebp
  801c95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 01                	push   $0x1
  801ca3:	e8 98 ff ff ff       	call   801c40 <syscall>
  801ca8:	83 c4 18             	add    $0x18,%esp
}
  801cab:	c9                   	leave  
  801cac:	c3                   	ret    

00801cad <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801cad:	55                   	push   %ebp
  801cae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 00                	push   $0x0
  801cbb:	50                   	push   %eax
  801cbc:	6a 05                	push   $0x5
  801cbe:	e8 7d ff ff ff       	call   801c40 <syscall>
  801cc3:	83 c4 18             	add    $0x18,%esp
}
  801cc6:	c9                   	leave  
  801cc7:	c3                   	ret    

00801cc8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801cc8:	55                   	push   %ebp
  801cc9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 02                	push   $0x2
  801cd7:	e8 64 ff ff ff       	call   801c40 <syscall>
  801cdc:	83 c4 18             	add    $0x18,%esp
}
  801cdf:	c9                   	leave  
  801ce0:	c3                   	ret    

00801ce1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ce1:	55                   	push   %ebp
  801ce2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 03                	push   $0x3
  801cf0:	e8 4b ff ff ff       	call   801c40 <syscall>
  801cf5:	83 c4 18             	add    $0x18,%esp
}
  801cf8:	c9                   	leave  
  801cf9:	c3                   	ret    

00801cfa <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cfa:	55                   	push   %ebp
  801cfb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 04                	push   $0x4
  801d09:	e8 32 ff ff ff       	call   801c40 <syscall>
  801d0e:	83 c4 18             	add    $0x18,%esp
}
  801d11:	c9                   	leave  
  801d12:	c3                   	ret    

00801d13 <sys_env_exit>:


void sys_env_exit(void)
{
  801d13:	55                   	push   %ebp
  801d14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 06                	push   $0x6
  801d22:	e8 19 ff ff ff       	call   801c40 <syscall>
  801d27:	83 c4 18             	add    $0x18,%esp
}
  801d2a:	90                   	nop
  801d2b:	c9                   	leave  
  801d2c:	c3                   	ret    

00801d2d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d2d:	55                   	push   %ebp
  801d2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d30:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d33:	8b 45 08             	mov    0x8(%ebp),%eax
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	52                   	push   %edx
  801d3d:	50                   	push   %eax
  801d3e:	6a 07                	push   $0x7
  801d40:	e8 fb fe ff ff       	call   801c40 <syscall>
  801d45:	83 c4 18             	add    $0x18,%esp
}
  801d48:	c9                   	leave  
  801d49:	c3                   	ret    

00801d4a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d4a:	55                   	push   %ebp
  801d4b:	89 e5                	mov    %esp,%ebp
  801d4d:	56                   	push   %esi
  801d4e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d4f:	8b 75 18             	mov    0x18(%ebp),%esi
  801d52:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d55:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d58:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5e:	56                   	push   %esi
  801d5f:	53                   	push   %ebx
  801d60:	51                   	push   %ecx
  801d61:	52                   	push   %edx
  801d62:	50                   	push   %eax
  801d63:	6a 08                	push   $0x8
  801d65:	e8 d6 fe ff ff       	call   801c40 <syscall>
  801d6a:	83 c4 18             	add    $0x18,%esp
}
  801d6d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d70:	5b                   	pop    %ebx
  801d71:	5e                   	pop    %esi
  801d72:	5d                   	pop    %ebp
  801d73:	c3                   	ret    

00801d74 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d74:	55                   	push   %ebp
  801d75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d77:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	52                   	push   %edx
  801d84:	50                   	push   %eax
  801d85:	6a 09                	push   $0x9
  801d87:	e8 b4 fe ff ff       	call   801c40 <syscall>
  801d8c:	83 c4 18             	add    $0x18,%esp
}
  801d8f:	c9                   	leave  
  801d90:	c3                   	ret    

00801d91 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d91:	55                   	push   %ebp
  801d92:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	ff 75 0c             	pushl  0xc(%ebp)
  801d9d:	ff 75 08             	pushl  0x8(%ebp)
  801da0:	6a 0a                	push   $0xa
  801da2:	e8 99 fe ff ff       	call   801c40 <syscall>
  801da7:	83 c4 18             	add    $0x18,%esp
}
  801daa:	c9                   	leave  
  801dab:	c3                   	ret    

00801dac <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801dac:	55                   	push   %ebp
  801dad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 0b                	push   $0xb
  801dbb:	e8 80 fe ff ff       	call   801c40 <syscall>
  801dc0:	83 c4 18             	add    $0x18,%esp
}
  801dc3:	c9                   	leave  
  801dc4:	c3                   	ret    

00801dc5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 0c                	push   $0xc
  801dd4:	e8 67 fe ff ff       	call   801c40 <syscall>
  801dd9:	83 c4 18             	add    $0x18,%esp
}
  801ddc:	c9                   	leave  
  801ddd:	c3                   	ret    

00801dde <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801dde:	55                   	push   %ebp
  801ddf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 0d                	push   $0xd
  801ded:	e8 4e fe ff ff       	call   801c40 <syscall>
  801df2:	83 c4 18             	add    $0x18,%esp
}
  801df5:	c9                   	leave  
  801df6:	c3                   	ret    

00801df7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801df7:	55                   	push   %ebp
  801df8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	ff 75 0c             	pushl  0xc(%ebp)
  801e03:	ff 75 08             	pushl  0x8(%ebp)
  801e06:	6a 11                	push   $0x11
  801e08:	e8 33 fe ff ff       	call   801c40 <syscall>
  801e0d:	83 c4 18             	add    $0x18,%esp
	return;
  801e10:	90                   	nop
}
  801e11:	c9                   	leave  
  801e12:	c3                   	ret    

00801e13 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e13:	55                   	push   %ebp
  801e14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	ff 75 0c             	pushl  0xc(%ebp)
  801e1f:	ff 75 08             	pushl  0x8(%ebp)
  801e22:	6a 12                	push   $0x12
  801e24:	e8 17 fe ff ff       	call   801c40 <syscall>
  801e29:	83 c4 18             	add    $0x18,%esp
	return ;
  801e2c:	90                   	nop
}
  801e2d:	c9                   	leave  
  801e2e:	c3                   	ret    

00801e2f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e2f:	55                   	push   %ebp
  801e30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 0e                	push   $0xe
  801e3e:	e8 fd fd ff ff       	call   801c40 <syscall>
  801e43:	83 c4 18             	add    $0x18,%esp
}
  801e46:	c9                   	leave  
  801e47:	c3                   	ret    

00801e48 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e48:	55                   	push   %ebp
  801e49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	ff 75 08             	pushl  0x8(%ebp)
  801e56:	6a 0f                	push   $0xf
  801e58:	e8 e3 fd ff ff       	call   801c40 <syscall>
  801e5d:	83 c4 18             	add    $0x18,%esp
}
  801e60:	c9                   	leave  
  801e61:	c3                   	ret    

00801e62 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e62:	55                   	push   %ebp
  801e63:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 10                	push   $0x10
  801e71:	e8 ca fd ff ff       	call   801c40 <syscall>
  801e76:	83 c4 18             	add    $0x18,%esp
}
  801e79:	90                   	nop
  801e7a:	c9                   	leave  
  801e7b:	c3                   	ret    

00801e7c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e7c:	55                   	push   %ebp
  801e7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	6a 14                	push   $0x14
  801e8b:	e8 b0 fd ff ff       	call   801c40 <syscall>
  801e90:	83 c4 18             	add    $0x18,%esp
}
  801e93:	90                   	nop
  801e94:	c9                   	leave  
  801e95:	c3                   	ret    

00801e96 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e96:	55                   	push   %ebp
  801e97:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 15                	push   $0x15
  801ea5:	e8 96 fd ff ff       	call   801c40 <syscall>
  801eaa:	83 c4 18             	add    $0x18,%esp
}
  801ead:	90                   	nop
  801eae:	c9                   	leave  
  801eaf:	c3                   	ret    

00801eb0 <sys_cputc>:


void
sys_cputc(const char c)
{
  801eb0:	55                   	push   %ebp
  801eb1:	89 e5                	mov    %esp,%ebp
  801eb3:	83 ec 04             	sub    $0x4,%esp
  801eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ebc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	50                   	push   %eax
  801ec9:	6a 16                	push   $0x16
  801ecb:	e8 70 fd ff ff       	call   801c40 <syscall>
  801ed0:	83 c4 18             	add    $0x18,%esp
}
  801ed3:	90                   	nop
  801ed4:	c9                   	leave  
  801ed5:	c3                   	ret    

00801ed6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ed6:	55                   	push   %ebp
  801ed7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 17                	push   $0x17
  801ee5:	e8 56 fd ff ff       	call   801c40 <syscall>
  801eea:	83 c4 18             	add    $0x18,%esp
}
  801eed:	90                   	nop
  801eee:	c9                   	leave  
  801eef:	c3                   	ret    

00801ef0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ef0:	55                   	push   %ebp
  801ef1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	ff 75 0c             	pushl  0xc(%ebp)
  801eff:	50                   	push   %eax
  801f00:	6a 18                	push   $0x18
  801f02:	e8 39 fd ff ff       	call   801c40 <syscall>
  801f07:	83 c4 18             	add    $0x18,%esp
}
  801f0a:	c9                   	leave  
  801f0b:	c3                   	ret    

00801f0c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f0c:	55                   	push   %ebp
  801f0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f12:	8b 45 08             	mov    0x8(%ebp),%eax
  801f15:	6a 00                	push   $0x0
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	52                   	push   %edx
  801f1c:	50                   	push   %eax
  801f1d:	6a 1b                	push   $0x1b
  801f1f:	e8 1c fd ff ff       	call   801c40 <syscall>
  801f24:	83 c4 18             	add    $0x18,%esp
}
  801f27:	c9                   	leave  
  801f28:	c3                   	ret    

00801f29 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f29:	55                   	push   %ebp
  801f2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	52                   	push   %edx
  801f39:	50                   	push   %eax
  801f3a:	6a 19                	push   $0x19
  801f3c:	e8 ff fc ff ff       	call   801c40 <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
}
  801f44:	90                   	nop
  801f45:	c9                   	leave  
  801f46:	c3                   	ret    

00801f47 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f47:	55                   	push   %ebp
  801f48:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	52                   	push   %edx
  801f57:	50                   	push   %eax
  801f58:	6a 1a                	push   $0x1a
  801f5a:	e8 e1 fc ff ff       	call   801c40 <syscall>
  801f5f:	83 c4 18             	add    $0x18,%esp
}
  801f62:	90                   	nop
  801f63:	c9                   	leave  
  801f64:	c3                   	ret    

00801f65 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f65:	55                   	push   %ebp
  801f66:	89 e5                	mov    %esp,%ebp
  801f68:	83 ec 04             	sub    $0x4,%esp
  801f6b:	8b 45 10             	mov    0x10(%ebp),%eax
  801f6e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f71:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f74:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f78:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7b:	6a 00                	push   $0x0
  801f7d:	51                   	push   %ecx
  801f7e:	52                   	push   %edx
  801f7f:	ff 75 0c             	pushl  0xc(%ebp)
  801f82:	50                   	push   %eax
  801f83:	6a 1c                	push   $0x1c
  801f85:	e8 b6 fc ff ff       	call   801c40 <syscall>
  801f8a:	83 c4 18             	add    $0x18,%esp
}
  801f8d:	c9                   	leave  
  801f8e:	c3                   	ret    

00801f8f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f8f:	55                   	push   %ebp
  801f90:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f92:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f95:	8b 45 08             	mov    0x8(%ebp),%eax
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	52                   	push   %edx
  801f9f:	50                   	push   %eax
  801fa0:	6a 1d                	push   $0x1d
  801fa2:	e8 99 fc ff ff       	call   801c40 <syscall>
  801fa7:	83 c4 18             	add    $0x18,%esp
}
  801faa:	c9                   	leave  
  801fab:	c3                   	ret    

00801fac <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801fac:	55                   	push   %ebp
  801fad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801faf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fb2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	51                   	push   %ecx
  801fbd:	52                   	push   %edx
  801fbe:	50                   	push   %eax
  801fbf:	6a 1e                	push   $0x1e
  801fc1:	e8 7a fc ff ff       	call   801c40 <syscall>
  801fc6:	83 c4 18             	add    $0x18,%esp
}
  801fc9:	c9                   	leave  
  801fca:	c3                   	ret    

00801fcb <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801fcb:	55                   	push   %ebp
  801fcc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801fce:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	52                   	push   %edx
  801fdb:	50                   	push   %eax
  801fdc:	6a 1f                	push   $0x1f
  801fde:	e8 5d fc ff ff       	call   801c40 <syscall>
  801fe3:	83 c4 18             	add    $0x18,%esp
}
  801fe6:	c9                   	leave  
  801fe7:	c3                   	ret    

00801fe8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fe8:	55                   	push   %ebp
  801fe9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801feb:	6a 00                	push   $0x0
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 20                	push   $0x20
  801ff7:	e8 44 fc ff ff       	call   801c40 <syscall>
  801ffc:	83 c4 18             	add    $0x18,%esp
}
  801fff:	c9                   	leave  
  802000:	c3                   	ret    

00802001 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802001:	55                   	push   %ebp
  802002:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802004:	8b 45 08             	mov    0x8(%ebp),%eax
  802007:	6a 00                	push   $0x0
  802009:	6a 00                	push   $0x0
  80200b:	ff 75 10             	pushl  0x10(%ebp)
  80200e:	ff 75 0c             	pushl  0xc(%ebp)
  802011:	50                   	push   %eax
  802012:	6a 21                	push   $0x21
  802014:	e8 27 fc ff ff       	call   801c40 <syscall>
  802019:	83 c4 18             	add    $0x18,%esp
}
  80201c:	c9                   	leave  
  80201d:	c3                   	ret    

0080201e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80201e:	55                   	push   %ebp
  80201f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802021:	8b 45 08             	mov    0x8(%ebp),%eax
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 00                	push   $0x0
  80202a:	6a 00                	push   $0x0
  80202c:	50                   	push   %eax
  80202d:	6a 22                	push   $0x22
  80202f:	e8 0c fc ff ff       	call   801c40 <syscall>
  802034:	83 c4 18             	add    $0x18,%esp
}
  802037:	90                   	nop
  802038:	c9                   	leave  
  802039:	c3                   	ret    

0080203a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80203a:	55                   	push   %ebp
  80203b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80203d:	8b 45 08             	mov    0x8(%ebp),%eax
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	50                   	push   %eax
  802049:	6a 23                	push   $0x23
  80204b:	e8 f0 fb ff ff       	call   801c40 <syscall>
  802050:	83 c4 18             	add    $0x18,%esp
}
  802053:	90                   	nop
  802054:	c9                   	leave  
  802055:	c3                   	ret    

00802056 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802056:	55                   	push   %ebp
  802057:	89 e5                	mov    %esp,%ebp
  802059:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80205c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80205f:	8d 50 04             	lea    0x4(%eax),%edx
  802062:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	52                   	push   %edx
  80206c:	50                   	push   %eax
  80206d:	6a 24                	push   $0x24
  80206f:	e8 cc fb ff ff       	call   801c40 <syscall>
  802074:	83 c4 18             	add    $0x18,%esp
	return result;
  802077:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80207a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80207d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802080:	89 01                	mov    %eax,(%ecx)
  802082:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802085:	8b 45 08             	mov    0x8(%ebp),%eax
  802088:	c9                   	leave  
  802089:	c2 04 00             	ret    $0x4

0080208c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80208c:	55                   	push   %ebp
  80208d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	ff 75 10             	pushl  0x10(%ebp)
  802096:	ff 75 0c             	pushl  0xc(%ebp)
  802099:	ff 75 08             	pushl  0x8(%ebp)
  80209c:	6a 13                	push   $0x13
  80209e:	e8 9d fb ff ff       	call   801c40 <syscall>
  8020a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8020a6:	90                   	nop
}
  8020a7:	c9                   	leave  
  8020a8:	c3                   	ret    

008020a9 <sys_rcr2>:
uint32 sys_rcr2()
{
  8020a9:	55                   	push   %ebp
  8020aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 25                	push   $0x25
  8020b8:	e8 83 fb ff ff       	call   801c40 <syscall>
  8020bd:	83 c4 18             	add    $0x18,%esp
}
  8020c0:	c9                   	leave  
  8020c1:	c3                   	ret    

008020c2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8020c2:	55                   	push   %ebp
  8020c3:	89 e5                	mov    %esp,%ebp
  8020c5:	83 ec 04             	sub    $0x4,%esp
  8020c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020ce:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 00                	push   $0x0
  8020da:	50                   	push   %eax
  8020db:	6a 26                	push   $0x26
  8020dd:	e8 5e fb ff ff       	call   801c40 <syscall>
  8020e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e5:	90                   	nop
}
  8020e6:	c9                   	leave  
  8020e7:	c3                   	ret    

008020e8 <rsttst>:
void rsttst()
{
  8020e8:	55                   	push   %ebp
  8020e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	6a 28                	push   $0x28
  8020f7:	e8 44 fb ff ff       	call   801c40 <syscall>
  8020fc:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ff:	90                   	nop
}
  802100:	c9                   	leave  
  802101:	c3                   	ret    

00802102 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802102:	55                   	push   %ebp
  802103:	89 e5                	mov    %esp,%ebp
  802105:	83 ec 04             	sub    $0x4,%esp
  802108:	8b 45 14             	mov    0x14(%ebp),%eax
  80210b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80210e:	8b 55 18             	mov    0x18(%ebp),%edx
  802111:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802115:	52                   	push   %edx
  802116:	50                   	push   %eax
  802117:	ff 75 10             	pushl  0x10(%ebp)
  80211a:	ff 75 0c             	pushl  0xc(%ebp)
  80211d:	ff 75 08             	pushl  0x8(%ebp)
  802120:	6a 27                	push   $0x27
  802122:	e8 19 fb ff ff       	call   801c40 <syscall>
  802127:	83 c4 18             	add    $0x18,%esp
	return ;
  80212a:	90                   	nop
}
  80212b:	c9                   	leave  
  80212c:	c3                   	ret    

0080212d <chktst>:
void chktst(uint32 n)
{
  80212d:	55                   	push   %ebp
  80212e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	6a 00                	push   $0x0
  802136:	6a 00                	push   $0x0
  802138:	ff 75 08             	pushl  0x8(%ebp)
  80213b:	6a 29                	push   $0x29
  80213d:	e8 fe fa ff ff       	call   801c40 <syscall>
  802142:	83 c4 18             	add    $0x18,%esp
	return ;
  802145:	90                   	nop
}
  802146:	c9                   	leave  
  802147:	c3                   	ret    

00802148 <inctst>:

void inctst()
{
  802148:	55                   	push   %ebp
  802149:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	6a 2a                	push   $0x2a
  802157:	e8 e4 fa ff ff       	call   801c40 <syscall>
  80215c:	83 c4 18             	add    $0x18,%esp
	return ;
  80215f:	90                   	nop
}
  802160:	c9                   	leave  
  802161:	c3                   	ret    

00802162 <gettst>:
uint32 gettst()
{
  802162:	55                   	push   %ebp
  802163:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 00                	push   $0x0
  80216d:	6a 00                	push   $0x0
  80216f:	6a 2b                	push   $0x2b
  802171:	e8 ca fa ff ff       	call   801c40 <syscall>
  802176:	83 c4 18             	add    $0x18,%esp
}
  802179:	c9                   	leave  
  80217a:	c3                   	ret    

0080217b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80217b:	55                   	push   %ebp
  80217c:	89 e5                	mov    %esp,%ebp
  80217e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	6a 2c                	push   $0x2c
  80218d:	e8 ae fa ff ff       	call   801c40 <syscall>
  802192:	83 c4 18             	add    $0x18,%esp
  802195:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802198:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80219c:	75 07                	jne    8021a5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80219e:	b8 01 00 00 00       	mov    $0x1,%eax
  8021a3:	eb 05                	jmp    8021aa <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8021a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021aa:	c9                   	leave  
  8021ab:	c3                   	ret    

008021ac <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8021ac:	55                   	push   %ebp
  8021ad:	89 e5                	mov    %esp,%ebp
  8021af:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	6a 00                	push   $0x0
  8021bc:	6a 2c                	push   $0x2c
  8021be:	e8 7d fa ff ff       	call   801c40 <syscall>
  8021c3:	83 c4 18             	add    $0x18,%esp
  8021c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8021c9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021cd:	75 07                	jne    8021d6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021cf:	b8 01 00 00 00       	mov    $0x1,%eax
  8021d4:	eb 05                	jmp    8021db <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021db:	c9                   	leave  
  8021dc:	c3                   	ret    

008021dd <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021dd:	55                   	push   %ebp
  8021de:	89 e5                	mov    %esp,%ebp
  8021e0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 00                	push   $0x0
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 2c                	push   $0x2c
  8021ef:	e8 4c fa ff ff       	call   801c40 <syscall>
  8021f4:	83 c4 18             	add    $0x18,%esp
  8021f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021fa:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021fe:	75 07                	jne    802207 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802200:	b8 01 00 00 00       	mov    $0x1,%eax
  802205:	eb 05                	jmp    80220c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802207:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80220c:	c9                   	leave  
  80220d:	c3                   	ret    

0080220e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80220e:	55                   	push   %ebp
  80220f:	89 e5                	mov    %esp,%ebp
  802211:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802214:	6a 00                	push   $0x0
  802216:	6a 00                	push   $0x0
  802218:	6a 00                	push   $0x0
  80221a:	6a 00                	push   $0x0
  80221c:	6a 00                	push   $0x0
  80221e:	6a 2c                	push   $0x2c
  802220:	e8 1b fa ff ff       	call   801c40 <syscall>
  802225:	83 c4 18             	add    $0x18,%esp
  802228:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80222b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80222f:	75 07                	jne    802238 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802231:	b8 01 00 00 00       	mov    $0x1,%eax
  802236:	eb 05                	jmp    80223d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802238:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80223d:	c9                   	leave  
  80223e:	c3                   	ret    

0080223f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80223f:	55                   	push   %ebp
  802240:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	ff 75 08             	pushl  0x8(%ebp)
  80224d:	6a 2d                	push   $0x2d
  80224f:	e8 ec f9 ff ff       	call   801c40 <syscall>
  802254:	83 c4 18             	add    $0x18,%esp
	return ;
  802257:	90                   	nop
}
  802258:	c9                   	leave  
  802259:	c3                   	ret    
  80225a:	66 90                	xchg   %ax,%ax

0080225c <__udivdi3>:
  80225c:	55                   	push   %ebp
  80225d:	57                   	push   %edi
  80225e:	56                   	push   %esi
  80225f:	53                   	push   %ebx
  802260:	83 ec 1c             	sub    $0x1c,%esp
  802263:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802267:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80226b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80226f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802273:	89 ca                	mov    %ecx,%edx
  802275:	89 f8                	mov    %edi,%eax
  802277:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80227b:	85 f6                	test   %esi,%esi
  80227d:	75 2d                	jne    8022ac <__udivdi3+0x50>
  80227f:	39 cf                	cmp    %ecx,%edi
  802281:	77 65                	ja     8022e8 <__udivdi3+0x8c>
  802283:	89 fd                	mov    %edi,%ebp
  802285:	85 ff                	test   %edi,%edi
  802287:	75 0b                	jne    802294 <__udivdi3+0x38>
  802289:	b8 01 00 00 00       	mov    $0x1,%eax
  80228e:	31 d2                	xor    %edx,%edx
  802290:	f7 f7                	div    %edi
  802292:	89 c5                	mov    %eax,%ebp
  802294:	31 d2                	xor    %edx,%edx
  802296:	89 c8                	mov    %ecx,%eax
  802298:	f7 f5                	div    %ebp
  80229a:	89 c1                	mov    %eax,%ecx
  80229c:	89 d8                	mov    %ebx,%eax
  80229e:	f7 f5                	div    %ebp
  8022a0:	89 cf                	mov    %ecx,%edi
  8022a2:	89 fa                	mov    %edi,%edx
  8022a4:	83 c4 1c             	add    $0x1c,%esp
  8022a7:	5b                   	pop    %ebx
  8022a8:	5e                   	pop    %esi
  8022a9:	5f                   	pop    %edi
  8022aa:	5d                   	pop    %ebp
  8022ab:	c3                   	ret    
  8022ac:	39 ce                	cmp    %ecx,%esi
  8022ae:	77 28                	ja     8022d8 <__udivdi3+0x7c>
  8022b0:	0f bd fe             	bsr    %esi,%edi
  8022b3:	83 f7 1f             	xor    $0x1f,%edi
  8022b6:	75 40                	jne    8022f8 <__udivdi3+0x9c>
  8022b8:	39 ce                	cmp    %ecx,%esi
  8022ba:	72 0a                	jb     8022c6 <__udivdi3+0x6a>
  8022bc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022c0:	0f 87 9e 00 00 00    	ja     802364 <__udivdi3+0x108>
  8022c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8022cb:	89 fa                	mov    %edi,%edx
  8022cd:	83 c4 1c             	add    $0x1c,%esp
  8022d0:	5b                   	pop    %ebx
  8022d1:	5e                   	pop    %esi
  8022d2:	5f                   	pop    %edi
  8022d3:	5d                   	pop    %ebp
  8022d4:	c3                   	ret    
  8022d5:	8d 76 00             	lea    0x0(%esi),%esi
  8022d8:	31 ff                	xor    %edi,%edi
  8022da:	31 c0                	xor    %eax,%eax
  8022dc:	89 fa                	mov    %edi,%edx
  8022de:	83 c4 1c             	add    $0x1c,%esp
  8022e1:	5b                   	pop    %ebx
  8022e2:	5e                   	pop    %esi
  8022e3:	5f                   	pop    %edi
  8022e4:	5d                   	pop    %ebp
  8022e5:	c3                   	ret    
  8022e6:	66 90                	xchg   %ax,%ax
  8022e8:	89 d8                	mov    %ebx,%eax
  8022ea:	f7 f7                	div    %edi
  8022ec:	31 ff                	xor    %edi,%edi
  8022ee:	89 fa                	mov    %edi,%edx
  8022f0:	83 c4 1c             	add    $0x1c,%esp
  8022f3:	5b                   	pop    %ebx
  8022f4:	5e                   	pop    %esi
  8022f5:	5f                   	pop    %edi
  8022f6:	5d                   	pop    %ebp
  8022f7:	c3                   	ret    
  8022f8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8022fd:	89 eb                	mov    %ebp,%ebx
  8022ff:	29 fb                	sub    %edi,%ebx
  802301:	89 f9                	mov    %edi,%ecx
  802303:	d3 e6                	shl    %cl,%esi
  802305:	89 c5                	mov    %eax,%ebp
  802307:	88 d9                	mov    %bl,%cl
  802309:	d3 ed                	shr    %cl,%ebp
  80230b:	89 e9                	mov    %ebp,%ecx
  80230d:	09 f1                	or     %esi,%ecx
  80230f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802313:	89 f9                	mov    %edi,%ecx
  802315:	d3 e0                	shl    %cl,%eax
  802317:	89 c5                	mov    %eax,%ebp
  802319:	89 d6                	mov    %edx,%esi
  80231b:	88 d9                	mov    %bl,%cl
  80231d:	d3 ee                	shr    %cl,%esi
  80231f:	89 f9                	mov    %edi,%ecx
  802321:	d3 e2                	shl    %cl,%edx
  802323:	8b 44 24 08          	mov    0x8(%esp),%eax
  802327:	88 d9                	mov    %bl,%cl
  802329:	d3 e8                	shr    %cl,%eax
  80232b:	09 c2                	or     %eax,%edx
  80232d:	89 d0                	mov    %edx,%eax
  80232f:	89 f2                	mov    %esi,%edx
  802331:	f7 74 24 0c          	divl   0xc(%esp)
  802335:	89 d6                	mov    %edx,%esi
  802337:	89 c3                	mov    %eax,%ebx
  802339:	f7 e5                	mul    %ebp
  80233b:	39 d6                	cmp    %edx,%esi
  80233d:	72 19                	jb     802358 <__udivdi3+0xfc>
  80233f:	74 0b                	je     80234c <__udivdi3+0xf0>
  802341:	89 d8                	mov    %ebx,%eax
  802343:	31 ff                	xor    %edi,%edi
  802345:	e9 58 ff ff ff       	jmp    8022a2 <__udivdi3+0x46>
  80234a:	66 90                	xchg   %ax,%ax
  80234c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802350:	89 f9                	mov    %edi,%ecx
  802352:	d3 e2                	shl    %cl,%edx
  802354:	39 c2                	cmp    %eax,%edx
  802356:	73 e9                	jae    802341 <__udivdi3+0xe5>
  802358:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80235b:	31 ff                	xor    %edi,%edi
  80235d:	e9 40 ff ff ff       	jmp    8022a2 <__udivdi3+0x46>
  802362:	66 90                	xchg   %ax,%ax
  802364:	31 c0                	xor    %eax,%eax
  802366:	e9 37 ff ff ff       	jmp    8022a2 <__udivdi3+0x46>
  80236b:	90                   	nop

0080236c <__umoddi3>:
  80236c:	55                   	push   %ebp
  80236d:	57                   	push   %edi
  80236e:	56                   	push   %esi
  80236f:	53                   	push   %ebx
  802370:	83 ec 1c             	sub    $0x1c,%esp
  802373:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802377:	8b 74 24 34          	mov    0x34(%esp),%esi
  80237b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80237f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802383:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802387:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80238b:	89 f3                	mov    %esi,%ebx
  80238d:	89 fa                	mov    %edi,%edx
  80238f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802393:	89 34 24             	mov    %esi,(%esp)
  802396:	85 c0                	test   %eax,%eax
  802398:	75 1a                	jne    8023b4 <__umoddi3+0x48>
  80239a:	39 f7                	cmp    %esi,%edi
  80239c:	0f 86 a2 00 00 00    	jbe    802444 <__umoddi3+0xd8>
  8023a2:	89 c8                	mov    %ecx,%eax
  8023a4:	89 f2                	mov    %esi,%edx
  8023a6:	f7 f7                	div    %edi
  8023a8:	89 d0                	mov    %edx,%eax
  8023aa:	31 d2                	xor    %edx,%edx
  8023ac:	83 c4 1c             	add    $0x1c,%esp
  8023af:	5b                   	pop    %ebx
  8023b0:	5e                   	pop    %esi
  8023b1:	5f                   	pop    %edi
  8023b2:	5d                   	pop    %ebp
  8023b3:	c3                   	ret    
  8023b4:	39 f0                	cmp    %esi,%eax
  8023b6:	0f 87 ac 00 00 00    	ja     802468 <__umoddi3+0xfc>
  8023bc:	0f bd e8             	bsr    %eax,%ebp
  8023bf:	83 f5 1f             	xor    $0x1f,%ebp
  8023c2:	0f 84 ac 00 00 00    	je     802474 <__umoddi3+0x108>
  8023c8:	bf 20 00 00 00       	mov    $0x20,%edi
  8023cd:	29 ef                	sub    %ebp,%edi
  8023cf:	89 fe                	mov    %edi,%esi
  8023d1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023d5:	89 e9                	mov    %ebp,%ecx
  8023d7:	d3 e0                	shl    %cl,%eax
  8023d9:	89 d7                	mov    %edx,%edi
  8023db:	89 f1                	mov    %esi,%ecx
  8023dd:	d3 ef                	shr    %cl,%edi
  8023df:	09 c7                	or     %eax,%edi
  8023e1:	89 e9                	mov    %ebp,%ecx
  8023e3:	d3 e2                	shl    %cl,%edx
  8023e5:	89 14 24             	mov    %edx,(%esp)
  8023e8:	89 d8                	mov    %ebx,%eax
  8023ea:	d3 e0                	shl    %cl,%eax
  8023ec:	89 c2                	mov    %eax,%edx
  8023ee:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023f2:	d3 e0                	shl    %cl,%eax
  8023f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8023f8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023fc:	89 f1                	mov    %esi,%ecx
  8023fe:	d3 e8                	shr    %cl,%eax
  802400:	09 d0                	or     %edx,%eax
  802402:	d3 eb                	shr    %cl,%ebx
  802404:	89 da                	mov    %ebx,%edx
  802406:	f7 f7                	div    %edi
  802408:	89 d3                	mov    %edx,%ebx
  80240a:	f7 24 24             	mull   (%esp)
  80240d:	89 c6                	mov    %eax,%esi
  80240f:	89 d1                	mov    %edx,%ecx
  802411:	39 d3                	cmp    %edx,%ebx
  802413:	0f 82 87 00 00 00    	jb     8024a0 <__umoddi3+0x134>
  802419:	0f 84 91 00 00 00    	je     8024b0 <__umoddi3+0x144>
  80241f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802423:	29 f2                	sub    %esi,%edx
  802425:	19 cb                	sbb    %ecx,%ebx
  802427:	89 d8                	mov    %ebx,%eax
  802429:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80242d:	d3 e0                	shl    %cl,%eax
  80242f:	89 e9                	mov    %ebp,%ecx
  802431:	d3 ea                	shr    %cl,%edx
  802433:	09 d0                	or     %edx,%eax
  802435:	89 e9                	mov    %ebp,%ecx
  802437:	d3 eb                	shr    %cl,%ebx
  802439:	89 da                	mov    %ebx,%edx
  80243b:	83 c4 1c             	add    $0x1c,%esp
  80243e:	5b                   	pop    %ebx
  80243f:	5e                   	pop    %esi
  802440:	5f                   	pop    %edi
  802441:	5d                   	pop    %ebp
  802442:	c3                   	ret    
  802443:	90                   	nop
  802444:	89 fd                	mov    %edi,%ebp
  802446:	85 ff                	test   %edi,%edi
  802448:	75 0b                	jne    802455 <__umoddi3+0xe9>
  80244a:	b8 01 00 00 00       	mov    $0x1,%eax
  80244f:	31 d2                	xor    %edx,%edx
  802451:	f7 f7                	div    %edi
  802453:	89 c5                	mov    %eax,%ebp
  802455:	89 f0                	mov    %esi,%eax
  802457:	31 d2                	xor    %edx,%edx
  802459:	f7 f5                	div    %ebp
  80245b:	89 c8                	mov    %ecx,%eax
  80245d:	f7 f5                	div    %ebp
  80245f:	89 d0                	mov    %edx,%eax
  802461:	e9 44 ff ff ff       	jmp    8023aa <__umoddi3+0x3e>
  802466:	66 90                	xchg   %ax,%ax
  802468:	89 c8                	mov    %ecx,%eax
  80246a:	89 f2                	mov    %esi,%edx
  80246c:	83 c4 1c             	add    $0x1c,%esp
  80246f:	5b                   	pop    %ebx
  802470:	5e                   	pop    %esi
  802471:	5f                   	pop    %edi
  802472:	5d                   	pop    %ebp
  802473:	c3                   	ret    
  802474:	3b 04 24             	cmp    (%esp),%eax
  802477:	72 06                	jb     80247f <__umoddi3+0x113>
  802479:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80247d:	77 0f                	ja     80248e <__umoddi3+0x122>
  80247f:	89 f2                	mov    %esi,%edx
  802481:	29 f9                	sub    %edi,%ecx
  802483:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802487:	89 14 24             	mov    %edx,(%esp)
  80248a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80248e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802492:	8b 14 24             	mov    (%esp),%edx
  802495:	83 c4 1c             	add    $0x1c,%esp
  802498:	5b                   	pop    %ebx
  802499:	5e                   	pop    %esi
  80249a:	5f                   	pop    %edi
  80249b:	5d                   	pop    %ebp
  80249c:	c3                   	ret    
  80249d:	8d 76 00             	lea    0x0(%esi),%esi
  8024a0:	2b 04 24             	sub    (%esp),%eax
  8024a3:	19 fa                	sbb    %edi,%edx
  8024a5:	89 d1                	mov    %edx,%ecx
  8024a7:	89 c6                	mov    %eax,%esi
  8024a9:	e9 71 ff ff ff       	jmp    80241f <__umoddi3+0xb3>
  8024ae:	66 90                	xchg   %ax,%ax
  8024b0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024b4:	72 ea                	jb     8024a0 <__umoddi3+0x134>
  8024b6:	89 d9                	mov    %ebx,%ecx
  8024b8:	e9 62 ff ff ff       	jmp    80241f <__umoddi3+0xb3>
