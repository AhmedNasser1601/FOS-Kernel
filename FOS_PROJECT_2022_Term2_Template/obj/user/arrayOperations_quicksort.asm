
obj/user/arrayOperations_quicksort:     file format elf32-i386


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
  800031:	e8 20 03 00 00       	call   800356 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int32 envID = sys_getenvid();
  80003e:	e8 11 15 00 00       	call   801554 <sys_getenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int32 parentenvID = sys_getparentenvid();
  800046:	e8 3b 15 00 00       	call   801586 <sys_getparentenvid>
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)

	int ret;
	/*[1] GET SHARED VARs*/
	//Get the shared array & its size
	int *numOfElements = NULL;
  80004e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	int *sharedArray = NULL;
  800055:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	sharedArray = sget(parentenvID,"arr") ;
  80005c:	83 ec 08             	sub    $0x8,%esp
  80005f:	68 40 1f 80 00       	push   $0x801f40
  800064:	ff 75 ec             	pushl  -0x14(%ebp)
  800067:	e8 f5 13 00 00       	call   801461 <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	numOfElements = sget(parentenvID,"arrSize") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 44 1f 80 00       	push   $0x801f44
  80007a:	ff 75 ec             	pushl  -0x14(%ebp)
  80007d:	e8 df 13 00 00       	call   801461 <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800088:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	finishedCount = sget(parentenvID,"finishedCount") ;
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	68 4c 1f 80 00       	push   $0x801f4c
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 c2 13 00 00       	call   801461 <sget>
  80009f:	83 c4 10             	add    $0x10,%esp
  8000a2:	89 45 e0             	mov    %eax,-0x20(%ebp)

	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("quicksortedArr", sizeof(int) * *numOfElements, 0) ;
  8000a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000a8:	8b 00                	mov    (%eax),%eax
  8000aa:	c1 e0 02             	shl    $0x2,%eax
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 00                	push   $0x0
  8000b2:	50                   	push   %eax
  8000b3:	68 5a 1f 80 00       	push   $0x801f5a
  8000b8:	e8 84 13 00 00       	call   801441 <smalloc>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ca:	eb 25                	jmp    8000f1 <_main+0xb9>
	{
		sortedArray[i] = sharedArray[i];
  8000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000d9:	01 c2                	add    %eax,%edx
  8000db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000de:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e8:	01 c8                	add    %ecx,%eax
  8000ea:	8b 00                	mov    (%eax),%eax
  8000ec:	89 02                	mov    %eax,(%edx)
	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("quicksortedArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000ee:	ff 45 f4             	incl   -0xc(%ebp)
  8000f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f4:	8b 00                	mov    (%eax),%eax
  8000f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f9:	7f d1                	jg     8000cc <_main+0x94>
	{
		sortedArray[i] = sharedArray[i];
	}
	QuickSort(sortedArray, *numOfElements);
  8000fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000fe:	8b 00                	mov    (%eax),%eax
  800100:	83 ec 08             	sub    $0x8,%esp
  800103:	50                   	push   %eax
  800104:	ff 75 dc             	pushl  -0x24(%ebp)
  800107:	e8 23 00 00 00       	call   80012f <QuickSort>
  80010c:	83 c4 10             	add    $0x10,%esp
	cprintf("Quick sort is Finished!!!!\n") ;
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	68 69 1f 80 00       	push   $0x801f69
  800117:	e8 1d 04 00 00       	call   800539 <cprintf>
  80011c:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	(*finishedCount)++ ;
  80011f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	8d 50 01             	lea    0x1(%eax),%edx
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	89 10                	mov    %edx,(%eax)

}
  80012c:	90                   	nop
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800135:	8b 45 0c             	mov    0xc(%ebp),%eax
  800138:	48                   	dec    %eax
  800139:	50                   	push   %eax
  80013a:	6a 00                	push   $0x0
  80013c:	ff 75 0c             	pushl  0xc(%ebp)
  80013f:	ff 75 08             	pushl  0x8(%ebp)
  800142:	e8 06 00 00 00       	call   80014d <QSort>
  800147:	83 c4 10             	add    $0x10,%esp
}
  80014a:	90                   	nop
  80014b:	c9                   	leave  
  80014c:	c3                   	ret    

0080014d <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80014d:	55                   	push   %ebp
  80014e:	89 e5                	mov    %esp,%ebp
  800150:	83 ec 28             	sub    $0x28,%esp
	if (startIndex >= finalIndex) return;
  800153:	8b 45 10             	mov    0x10(%ebp),%eax
  800156:	3b 45 14             	cmp    0x14(%ebp),%eax
  800159:	0f 8d 1b 01 00 00    	jge    80027a <QSort+0x12d>
	int pvtIndex = RAND(startIndex, finalIndex) ;
  80015f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  800162:	83 ec 0c             	sub    $0xc,%esp
  800165:	50                   	push   %eax
  800166:	e8 77 17 00 00       	call   8018e2 <sys_get_virtual_time>
  80016b:	83 c4 0c             	add    $0xc,%esp
  80016e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800171:	8b 55 14             	mov    0x14(%ebp),%edx
  800174:	2b 55 10             	sub    0x10(%ebp),%edx
  800177:	89 d1                	mov    %edx,%ecx
  800179:	ba 00 00 00 00       	mov    $0x0,%edx
  80017e:	f7 f1                	div    %ecx
  800180:	8b 45 10             	mov    0x10(%ebp),%eax
  800183:	01 d0                	add    %edx,%eax
  800185:	89 45 ec             	mov    %eax,-0x14(%ebp)
	Swap(Elements, startIndex, pvtIndex);
  800188:	83 ec 04             	sub    $0x4,%esp
  80018b:	ff 75 ec             	pushl  -0x14(%ebp)
  80018e:	ff 75 10             	pushl  0x10(%ebp)
  800191:	ff 75 08             	pushl  0x8(%ebp)
  800194:	e8 e4 00 00 00       	call   80027d <Swap>
  800199:	83 c4 10             	add    $0x10,%esp

	int i = startIndex+1, j = finalIndex;
  80019c:	8b 45 10             	mov    0x10(%ebp),%eax
  80019f:	40                   	inc    %eax
  8001a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8001a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8001a6:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8001a9:	e9 80 00 00 00       	jmp    80022e <QSort+0xe1>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8001ae:	ff 45 f4             	incl   -0xc(%ebp)
  8001b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b4:	3b 45 14             	cmp    0x14(%ebp),%eax
  8001b7:	7f 2b                	jg     8001e4 <QSort+0x97>
  8001b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8001bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	8b 10                	mov    (%eax),%edx
  8001ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8001d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8001d7:	01 c8                	add    %ecx,%eax
  8001d9:	8b 00                	mov    (%eax),%eax
  8001db:	39 c2                	cmp    %eax,%edx
  8001dd:	7d cf                	jge    8001ae <QSort+0x61>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8001df:	eb 03                	jmp    8001e4 <QSort+0x97>
  8001e1:	ff 4d f0             	decl   -0x10(%ebp)
  8001e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8001ea:	7e 26                	jle    800212 <QSort+0xc5>
  8001ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8001ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8001f9:	01 d0                	add    %edx,%eax
  8001fb:	8b 10                	mov    (%eax),%edx
  8001fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800200:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800207:	8b 45 08             	mov    0x8(%ebp),%eax
  80020a:	01 c8                	add    %ecx,%eax
  80020c:	8b 00                	mov    (%eax),%eax
  80020e:	39 c2                	cmp    %eax,%edx
  800210:	7e cf                	jle    8001e1 <QSort+0x94>

		if (i <= j)
  800212:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800215:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800218:	7f 14                	jg     80022e <QSort+0xe1>
		{
			Swap(Elements, i, j);
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	ff 75 f0             	pushl  -0x10(%ebp)
  800220:	ff 75 f4             	pushl  -0xc(%ebp)
  800223:	ff 75 08             	pushl  0x8(%ebp)
  800226:	e8 52 00 00 00       	call   80027d <Swap>
  80022b:	83 c4 10             	add    $0x10,%esp
	int pvtIndex = RAND(startIndex, finalIndex) ;
	Swap(Elements, startIndex, pvtIndex);

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80022e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800231:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800234:	0f 8e 77 ff ff ff    	jle    8001b1 <QSort+0x64>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	ff 75 f0             	pushl  -0x10(%ebp)
  800240:	ff 75 10             	pushl  0x10(%ebp)
  800243:	ff 75 08             	pushl  0x8(%ebp)
  800246:	e8 32 00 00 00       	call   80027d <Swap>
  80024b:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80024e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800251:	48                   	dec    %eax
  800252:	50                   	push   %eax
  800253:	ff 75 10             	pushl  0x10(%ebp)
  800256:	ff 75 0c             	pushl  0xc(%ebp)
  800259:	ff 75 08             	pushl  0x8(%ebp)
  80025c:	e8 ec fe ff ff       	call   80014d <QSort>
  800261:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800264:	ff 75 14             	pushl  0x14(%ebp)
  800267:	ff 75 f4             	pushl  -0xc(%ebp)
  80026a:	ff 75 0c             	pushl  0xc(%ebp)
  80026d:	ff 75 08             	pushl  0x8(%ebp)
  800270:	e8 d8 fe ff ff       	call   80014d <QSort>
  800275:	83 c4 10             	add    $0x10,%esp
  800278:	eb 01                	jmp    80027b <QSort+0x12e>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80027a:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  80027b:	c9                   	leave  
  80027c:	c3                   	ret    

0080027d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80027d:	55                   	push   %ebp
  80027e:	89 e5                	mov    %esp,%ebp
  800280:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800283:	8b 45 0c             	mov    0xc(%ebp),%eax
  800286:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028d:	8b 45 08             	mov    0x8(%ebp),%eax
  800290:	01 d0                	add    %edx,%eax
  800292:	8b 00                	mov    (%eax),%eax
  800294:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80029a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a4:	01 c2                	add    %eax,%edx
  8002a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b3:	01 c8                	add    %ecx,%eax
  8002b5:	8b 00                	mov    (%eax),%eax
  8002b7:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8002b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c6:	01 c2                	add    %eax,%edx
  8002c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8002cb:	89 02                	mov    %eax,(%edx)
}
  8002cd:	90                   	nop
  8002ce:	c9                   	leave  
  8002cf:	c3                   	ret    

008002d0 <PrintElements>:


void PrintElements(int *Elements, int NumOfElements)
{
  8002d0:	55                   	push   %ebp
  8002d1:	89 e5                	mov    %esp,%ebp
  8002d3:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8002d6:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8002dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002e4:	eb 42                	jmp    800328 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8002e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e9:	99                   	cltd   
  8002ea:	f7 7d f0             	idivl  -0x10(%ebp)
  8002ed:	89 d0                	mov    %edx,%eax
  8002ef:	85 c0                	test   %eax,%eax
  8002f1:	75 10                	jne    800303 <PrintElements+0x33>
			cprintf("\n");
  8002f3:	83 ec 0c             	sub    $0xc,%esp
  8002f6:	68 85 1f 80 00       	push   $0x801f85
  8002fb:	e8 39 02 00 00       	call   800539 <cprintf>
  800300:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800303:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800306:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030d:	8b 45 08             	mov    0x8(%ebp),%eax
  800310:	01 d0                	add    %edx,%eax
  800312:	8b 00                	mov    (%eax),%eax
  800314:	83 ec 08             	sub    $0x8,%esp
  800317:	50                   	push   %eax
  800318:	68 87 1f 80 00       	push   $0x801f87
  80031d:	e8 17 02 00 00       	call   800539 <cprintf>
  800322:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800325:	ff 45 f4             	incl   -0xc(%ebp)
  800328:	8b 45 0c             	mov    0xc(%ebp),%eax
  80032b:	48                   	dec    %eax
  80032c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80032f:	7f b5                	jg     8002e6 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800331:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800334:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033b:	8b 45 08             	mov    0x8(%ebp),%eax
  80033e:	01 d0                	add    %edx,%eax
  800340:	8b 00                	mov    (%eax),%eax
  800342:	83 ec 08             	sub    $0x8,%esp
  800345:	50                   	push   %eax
  800346:	68 8c 1f 80 00       	push   $0x801f8c
  80034b:	e8 e9 01 00 00       	call   800539 <cprintf>
  800350:	83 c4 10             	add    $0x10,%esp

}
  800353:	90                   	nop
  800354:	c9                   	leave  
  800355:	c3                   	ret    

00800356 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800356:	55                   	push   %ebp
  800357:	89 e5                	mov    %esp,%ebp
  800359:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80035c:	e8 0c 12 00 00       	call   80156d <sys_getenvindex>
  800361:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800364:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800367:	89 d0                	mov    %edx,%eax
  800369:	c1 e0 02             	shl    $0x2,%eax
  80036c:	01 d0                	add    %edx,%eax
  80036e:	01 c0                	add    %eax,%eax
  800370:	01 d0                	add    %edx,%eax
  800372:	01 c0                	add    %eax,%eax
  800374:	01 d0                	add    %edx,%eax
  800376:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80037d:	01 d0                	add    %edx,%eax
  80037f:	c1 e0 02             	shl    $0x2,%eax
  800382:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800387:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80038c:	a1 20 30 80 00       	mov    0x803020,%eax
  800391:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800397:	84 c0                	test   %al,%al
  800399:	74 0f                	je     8003aa <libmain+0x54>
		binaryname = myEnv->prog_name;
  80039b:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a0:	05 f4 02 00 00       	add    $0x2f4,%eax
  8003a5:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003ae:	7e 0a                	jle    8003ba <libmain+0x64>
		binaryname = argv[0];
  8003b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b3:	8b 00                	mov    (%eax),%eax
  8003b5:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003ba:	83 ec 08             	sub    $0x8,%esp
  8003bd:	ff 75 0c             	pushl  0xc(%ebp)
  8003c0:	ff 75 08             	pushl  0x8(%ebp)
  8003c3:	e8 70 fc ff ff       	call   800038 <_main>
  8003c8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003cb:	e8 38 13 00 00       	call   801708 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003d0:	83 ec 0c             	sub    $0xc,%esp
  8003d3:	68 a8 1f 80 00       	push   $0x801fa8
  8003d8:	e8 5c 01 00 00       	call   800539 <cprintf>
  8003dd:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e5:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8003eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f0:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8003f6:	83 ec 04             	sub    $0x4,%esp
  8003f9:	52                   	push   %edx
  8003fa:	50                   	push   %eax
  8003fb:	68 d0 1f 80 00       	push   $0x801fd0
  800400:	e8 34 01 00 00       	call   800539 <cprintf>
  800405:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800408:	a1 20 30 80 00       	mov    0x803020,%eax
  80040d:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800413:	83 ec 08             	sub    $0x8,%esp
  800416:	50                   	push   %eax
  800417:	68 f5 1f 80 00       	push   $0x801ff5
  80041c:	e8 18 01 00 00       	call   800539 <cprintf>
  800421:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800424:	83 ec 0c             	sub    $0xc,%esp
  800427:	68 a8 1f 80 00       	push   $0x801fa8
  80042c:	e8 08 01 00 00       	call   800539 <cprintf>
  800431:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800434:	e8 e9 12 00 00       	call   801722 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800439:	e8 19 00 00 00       	call   800457 <exit>
}
  80043e:	90                   	nop
  80043f:	c9                   	leave  
  800440:	c3                   	ret    

00800441 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800441:	55                   	push   %ebp
  800442:	89 e5                	mov    %esp,%ebp
  800444:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800447:	83 ec 0c             	sub    $0xc,%esp
  80044a:	6a 00                	push   $0x0
  80044c:	e8 e8 10 00 00       	call   801539 <sys_env_destroy>
  800451:	83 c4 10             	add    $0x10,%esp
}
  800454:	90                   	nop
  800455:	c9                   	leave  
  800456:	c3                   	ret    

00800457 <exit>:

void
exit(void)
{
  800457:	55                   	push   %ebp
  800458:	89 e5                	mov    %esp,%ebp
  80045a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80045d:	e8 3d 11 00 00       	call   80159f <sys_env_exit>
}
  800462:	90                   	nop
  800463:	c9                   	leave  
  800464:	c3                   	ret    

00800465 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800465:	55                   	push   %ebp
  800466:	89 e5                	mov    %esp,%ebp
  800468:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80046b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	8d 48 01             	lea    0x1(%eax),%ecx
  800473:	8b 55 0c             	mov    0xc(%ebp),%edx
  800476:	89 0a                	mov    %ecx,(%edx)
  800478:	8b 55 08             	mov    0x8(%ebp),%edx
  80047b:	88 d1                	mov    %dl,%cl
  80047d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800480:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800484:	8b 45 0c             	mov    0xc(%ebp),%eax
  800487:	8b 00                	mov    (%eax),%eax
  800489:	3d ff 00 00 00       	cmp    $0xff,%eax
  80048e:	75 2c                	jne    8004bc <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800490:	a0 24 30 80 00       	mov    0x803024,%al
  800495:	0f b6 c0             	movzbl %al,%eax
  800498:	8b 55 0c             	mov    0xc(%ebp),%edx
  80049b:	8b 12                	mov    (%edx),%edx
  80049d:	89 d1                	mov    %edx,%ecx
  80049f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004a2:	83 c2 08             	add    $0x8,%edx
  8004a5:	83 ec 04             	sub    $0x4,%esp
  8004a8:	50                   	push   %eax
  8004a9:	51                   	push   %ecx
  8004aa:	52                   	push   %edx
  8004ab:	e8 47 10 00 00       	call   8014f7 <sys_cputs>
  8004b0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bf:	8b 40 04             	mov    0x4(%eax),%eax
  8004c2:	8d 50 01             	lea    0x1(%eax),%edx
  8004c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c8:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004cb:	90                   	nop
  8004cc:	c9                   	leave  
  8004cd:	c3                   	ret    

008004ce <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004ce:	55                   	push   %ebp
  8004cf:	89 e5                	mov    %esp,%ebp
  8004d1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004d7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004de:	00 00 00 
	b.cnt = 0;
  8004e1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004e8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004eb:	ff 75 0c             	pushl  0xc(%ebp)
  8004ee:	ff 75 08             	pushl  0x8(%ebp)
  8004f1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004f7:	50                   	push   %eax
  8004f8:	68 65 04 80 00       	push   $0x800465
  8004fd:	e8 11 02 00 00       	call   800713 <vprintfmt>
  800502:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800505:	a0 24 30 80 00       	mov    0x803024,%al
  80050a:	0f b6 c0             	movzbl %al,%eax
  80050d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800513:	83 ec 04             	sub    $0x4,%esp
  800516:	50                   	push   %eax
  800517:	52                   	push   %edx
  800518:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80051e:	83 c0 08             	add    $0x8,%eax
  800521:	50                   	push   %eax
  800522:	e8 d0 0f 00 00       	call   8014f7 <sys_cputs>
  800527:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80052a:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800531:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800537:	c9                   	leave  
  800538:	c3                   	ret    

00800539 <cprintf>:

int cprintf(const char *fmt, ...) {
  800539:	55                   	push   %ebp
  80053a:	89 e5                	mov    %esp,%ebp
  80053c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80053f:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800546:	8d 45 0c             	lea    0xc(%ebp),%eax
  800549:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80054c:	8b 45 08             	mov    0x8(%ebp),%eax
  80054f:	83 ec 08             	sub    $0x8,%esp
  800552:	ff 75 f4             	pushl  -0xc(%ebp)
  800555:	50                   	push   %eax
  800556:	e8 73 ff ff ff       	call   8004ce <vcprintf>
  80055b:	83 c4 10             	add    $0x10,%esp
  80055e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800561:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800564:	c9                   	leave  
  800565:	c3                   	ret    

00800566 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800566:	55                   	push   %ebp
  800567:	89 e5                	mov    %esp,%ebp
  800569:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80056c:	e8 97 11 00 00       	call   801708 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800571:	8d 45 0c             	lea    0xc(%ebp),%eax
  800574:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800577:	8b 45 08             	mov    0x8(%ebp),%eax
  80057a:	83 ec 08             	sub    $0x8,%esp
  80057d:	ff 75 f4             	pushl  -0xc(%ebp)
  800580:	50                   	push   %eax
  800581:	e8 48 ff ff ff       	call   8004ce <vcprintf>
  800586:	83 c4 10             	add    $0x10,%esp
  800589:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80058c:	e8 91 11 00 00       	call   801722 <sys_enable_interrupt>
	return cnt;
  800591:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800594:	c9                   	leave  
  800595:	c3                   	ret    

00800596 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800596:	55                   	push   %ebp
  800597:	89 e5                	mov    %esp,%ebp
  800599:	53                   	push   %ebx
  80059a:	83 ec 14             	sub    $0x14,%esp
  80059d:	8b 45 10             	mov    0x10(%ebp),%eax
  8005a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005a9:	8b 45 18             	mov    0x18(%ebp),%eax
  8005ac:	ba 00 00 00 00       	mov    $0x0,%edx
  8005b1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005b4:	77 55                	ja     80060b <printnum+0x75>
  8005b6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005b9:	72 05                	jb     8005c0 <printnum+0x2a>
  8005bb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005be:	77 4b                	ja     80060b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005c0:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005c3:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005c6:	8b 45 18             	mov    0x18(%ebp),%eax
  8005c9:	ba 00 00 00 00       	mov    $0x0,%edx
  8005ce:	52                   	push   %edx
  8005cf:	50                   	push   %eax
  8005d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8005d3:	ff 75 f0             	pushl  -0x10(%ebp)
  8005d6:	e8 ed 16 00 00       	call   801cc8 <__udivdi3>
  8005db:	83 c4 10             	add    $0x10,%esp
  8005de:	83 ec 04             	sub    $0x4,%esp
  8005e1:	ff 75 20             	pushl  0x20(%ebp)
  8005e4:	53                   	push   %ebx
  8005e5:	ff 75 18             	pushl  0x18(%ebp)
  8005e8:	52                   	push   %edx
  8005e9:	50                   	push   %eax
  8005ea:	ff 75 0c             	pushl  0xc(%ebp)
  8005ed:	ff 75 08             	pushl  0x8(%ebp)
  8005f0:	e8 a1 ff ff ff       	call   800596 <printnum>
  8005f5:	83 c4 20             	add    $0x20,%esp
  8005f8:	eb 1a                	jmp    800614 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005fa:	83 ec 08             	sub    $0x8,%esp
  8005fd:	ff 75 0c             	pushl  0xc(%ebp)
  800600:	ff 75 20             	pushl  0x20(%ebp)
  800603:	8b 45 08             	mov    0x8(%ebp),%eax
  800606:	ff d0                	call   *%eax
  800608:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80060b:	ff 4d 1c             	decl   0x1c(%ebp)
  80060e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800612:	7f e6                	jg     8005fa <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800614:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800617:	bb 00 00 00 00       	mov    $0x0,%ebx
  80061c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800622:	53                   	push   %ebx
  800623:	51                   	push   %ecx
  800624:	52                   	push   %edx
  800625:	50                   	push   %eax
  800626:	e8 ad 17 00 00       	call   801dd8 <__umoddi3>
  80062b:	83 c4 10             	add    $0x10,%esp
  80062e:	05 34 22 80 00       	add    $0x802234,%eax
  800633:	8a 00                	mov    (%eax),%al
  800635:	0f be c0             	movsbl %al,%eax
  800638:	83 ec 08             	sub    $0x8,%esp
  80063b:	ff 75 0c             	pushl  0xc(%ebp)
  80063e:	50                   	push   %eax
  80063f:	8b 45 08             	mov    0x8(%ebp),%eax
  800642:	ff d0                	call   *%eax
  800644:	83 c4 10             	add    $0x10,%esp
}
  800647:	90                   	nop
  800648:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80064b:	c9                   	leave  
  80064c:	c3                   	ret    

0080064d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80064d:	55                   	push   %ebp
  80064e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800650:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800654:	7e 1c                	jle    800672 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	8b 00                	mov    (%eax),%eax
  80065b:	8d 50 08             	lea    0x8(%eax),%edx
  80065e:	8b 45 08             	mov    0x8(%ebp),%eax
  800661:	89 10                	mov    %edx,(%eax)
  800663:	8b 45 08             	mov    0x8(%ebp),%eax
  800666:	8b 00                	mov    (%eax),%eax
  800668:	83 e8 08             	sub    $0x8,%eax
  80066b:	8b 50 04             	mov    0x4(%eax),%edx
  80066e:	8b 00                	mov    (%eax),%eax
  800670:	eb 40                	jmp    8006b2 <getuint+0x65>
	else if (lflag)
  800672:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800676:	74 1e                	je     800696 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800678:	8b 45 08             	mov    0x8(%ebp),%eax
  80067b:	8b 00                	mov    (%eax),%eax
  80067d:	8d 50 04             	lea    0x4(%eax),%edx
  800680:	8b 45 08             	mov    0x8(%ebp),%eax
  800683:	89 10                	mov    %edx,(%eax)
  800685:	8b 45 08             	mov    0x8(%ebp),%eax
  800688:	8b 00                	mov    (%eax),%eax
  80068a:	83 e8 04             	sub    $0x4,%eax
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	ba 00 00 00 00       	mov    $0x0,%edx
  800694:	eb 1c                	jmp    8006b2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800696:	8b 45 08             	mov    0x8(%ebp),%eax
  800699:	8b 00                	mov    (%eax),%eax
  80069b:	8d 50 04             	lea    0x4(%eax),%edx
  80069e:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a1:	89 10                	mov    %edx,(%eax)
  8006a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a6:	8b 00                	mov    (%eax),%eax
  8006a8:	83 e8 04             	sub    $0x4,%eax
  8006ab:	8b 00                	mov    (%eax),%eax
  8006ad:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006b2:	5d                   	pop    %ebp
  8006b3:	c3                   	ret    

008006b4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006b4:	55                   	push   %ebp
  8006b5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006b7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006bb:	7e 1c                	jle    8006d9 <getint+0x25>
		return va_arg(*ap, long long);
  8006bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c0:	8b 00                	mov    (%eax),%eax
  8006c2:	8d 50 08             	lea    0x8(%eax),%edx
  8006c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c8:	89 10                	mov    %edx,(%eax)
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8b 00                	mov    (%eax),%eax
  8006cf:	83 e8 08             	sub    $0x8,%eax
  8006d2:	8b 50 04             	mov    0x4(%eax),%edx
  8006d5:	8b 00                	mov    (%eax),%eax
  8006d7:	eb 38                	jmp    800711 <getint+0x5d>
	else if (lflag)
  8006d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006dd:	74 1a                	je     8006f9 <getint+0x45>
		return va_arg(*ap, long);
  8006df:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e2:	8b 00                	mov    (%eax),%eax
  8006e4:	8d 50 04             	lea    0x4(%eax),%edx
  8006e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ea:	89 10                	mov    %edx,(%eax)
  8006ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ef:	8b 00                	mov    (%eax),%eax
  8006f1:	83 e8 04             	sub    $0x4,%eax
  8006f4:	8b 00                	mov    (%eax),%eax
  8006f6:	99                   	cltd   
  8006f7:	eb 18                	jmp    800711 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fc:	8b 00                	mov    (%eax),%eax
  8006fe:	8d 50 04             	lea    0x4(%eax),%edx
  800701:	8b 45 08             	mov    0x8(%ebp),%eax
  800704:	89 10                	mov    %edx,(%eax)
  800706:	8b 45 08             	mov    0x8(%ebp),%eax
  800709:	8b 00                	mov    (%eax),%eax
  80070b:	83 e8 04             	sub    $0x4,%eax
  80070e:	8b 00                	mov    (%eax),%eax
  800710:	99                   	cltd   
}
  800711:	5d                   	pop    %ebp
  800712:	c3                   	ret    

00800713 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800713:	55                   	push   %ebp
  800714:	89 e5                	mov    %esp,%ebp
  800716:	56                   	push   %esi
  800717:	53                   	push   %ebx
  800718:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80071b:	eb 17                	jmp    800734 <vprintfmt+0x21>
			if (ch == '\0')
  80071d:	85 db                	test   %ebx,%ebx
  80071f:	0f 84 af 03 00 00    	je     800ad4 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800725:	83 ec 08             	sub    $0x8,%esp
  800728:	ff 75 0c             	pushl  0xc(%ebp)
  80072b:	53                   	push   %ebx
  80072c:	8b 45 08             	mov    0x8(%ebp),%eax
  80072f:	ff d0                	call   *%eax
  800731:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800734:	8b 45 10             	mov    0x10(%ebp),%eax
  800737:	8d 50 01             	lea    0x1(%eax),%edx
  80073a:	89 55 10             	mov    %edx,0x10(%ebp)
  80073d:	8a 00                	mov    (%eax),%al
  80073f:	0f b6 d8             	movzbl %al,%ebx
  800742:	83 fb 25             	cmp    $0x25,%ebx
  800745:	75 d6                	jne    80071d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800747:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80074b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800752:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800759:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800760:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800767:	8b 45 10             	mov    0x10(%ebp),%eax
  80076a:	8d 50 01             	lea    0x1(%eax),%edx
  80076d:	89 55 10             	mov    %edx,0x10(%ebp)
  800770:	8a 00                	mov    (%eax),%al
  800772:	0f b6 d8             	movzbl %al,%ebx
  800775:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800778:	83 f8 55             	cmp    $0x55,%eax
  80077b:	0f 87 2b 03 00 00    	ja     800aac <vprintfmt+0x399>
  800781:	8b 04 85 58 22 80 00 	mov    0x802258(,%eax,4),%eax
  800788:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80078a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80078e:	eb d7                	jmp    800767 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800790:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800794:	eb d1                	jmp    800767 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800796:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80079d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007a0:	89 d0                	mov    %edx,%eax
  8007a2:	c1 e0 02             	shl    $0x2,%eax
  8007a5:	01 d0                	add    %edx,%eax
  8007a7:	01 c0                	add    %eax,%eax
  8007a9:	01 d8                	add    %ebx,%eax
  8007ab:	83 e8 30             	sub    $0x30,%eax
  8007ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b4:	8a 00                	mov    (%eax),%al
  8007b6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007b9:	83 fb 2f             	cmp    $0x2f,%ebx
  8007bc:	7e 3e                	jle    8007fc <vprintfmt+0xe9>
  8007be:	83 fb 39             	cmp    $0x39,%ebx
  8007c1:	7f 39                	jg     8007fc <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007c3:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007c6:	eb d5                	jmp    80079d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cb:	83 c0 04             	add    $0x4,%eax
  8007ce:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d4:	83 e8 04             	sub    $0x4,%eax
  8007d7:	8b 00                	mov    (%eax),%eax
  8007d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007dc:	eb 1f                	jmp    8007fd <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007e2:	79 83                	jns    800767 <vprintfmt+0x54>
				width = 0;
  8007e4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007eb:	e9 77 ff ff ff       	jmp    800767 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007f0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007f7:	e9 6b ff ff ff       	jmp    800767 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007fc:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007fd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800801:	0f 89 60 ff ff ff    	jns    800767 <vprintfmt+0x54>
				width = precision, precision = -1;
  800807:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80080a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80080d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800814:	e9 4e ff ff ff       	jmp    800767 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800819:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80081c:	e9 46 ff ff ff       	jmp    800767 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800821:	8b 45 14             	mov    0x14(%ebp),%eax
  800824:	83 c0 04             	add    $0x4,%eax
  800827:	89 45 14             	mov    %eax,0x14(%ebp)
  80082a:	8b 45 14             	mov    0x14(%ebp),%eax
  80082d:	83 e8 04             	sub    $0x4,%eax
  800830:	8b 00                	mov    (%eax),%eax
  800832:	83 ec 08             	sub    $0x8,%esp
  800835:	ff 75 0c             	pushl  0xc(%ebp)
  800838:	50                   	push   %eax
  800839:	8b 45 08             	mov    0x8(%ebp),%eax
  80083c:	ff d0                	call   *%eax
  80083e:	83 c4 10             	add    $0x10,%esp
			break;
  800841:	e9 89 02 00 00       	jmp    800acf <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800846:	8b 45 14             	mov    0x14(%ebp),%eax
  800849:	83 c0 04             	add    $0x4,%eax
  80084c:	89 45 14             	mov    %eax,0x14(%ebp)
  80084f:	8b 45 14             	mov    0x14(%ebp),%eax
  800852:	83 e8 04             	sub    $0x4,%eax
  800855:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800857:	85 db                	test   %ebx,%ebx
  800859:	79 02                	jns    80085d <vprintfmt+0x14a>
				err = -err;
  80085b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80085d:	83 fb 64             	cmp    $0x64,%ebx
  800860:	7f 0b                	jg     80086d <vprintfmt+0x15a>
  800862:	8b 34 9d a0 20 80 00 	mov    0x8020a0(,%ebx,4),%esi
  800869:	85 f6                	test   %esi,%esi
  80086b:	75 19                	jne    800886 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80086d:	53                   	push   %ebx
  80086e:	68 45 22 80 00       	push   $0x802245
  800873:	ff 75 0c             	pushl  0xc(%ebp)
  800876:	ff 75 08             	pushl  0x8(%ebp)
  800879:	e8 5e 02 00 00       	call   800adc <printfmt>
  80087e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800881:	e9 49 02 00 00       	jmp    800acf <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800886:	56                   	push   %esi
  800887:	68 4e 22 80 00       	push   $0x80224e
  80088c:	ff 75 0c             	pushl  0xc(%ebp)
  80088f:	ff 75 08             	pushl  0x8(%ebp)
  800892:	e8 45 02 00 00       	call   800adc <printfmt>
  800897:	83 c4 10             	add    $0x10,%esp
			break;
  80089a:	e9 30 02 00 00       	jmp    800acf <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80089f:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a2:	83 c0 04             	add    $0x4,%eax
  8008a5:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ab:	83 e8 04             	sub    $0x4,%eax
  8008ae:	8b 30                	mov    (%eax),%esi
  8008b0:	85 f6                	test   %esi,%esi
  8008b2:	75 05                	jne    8008b9 <vprintfmt+0x1a6>
				p = "(null)";
  8008b4:	be 51 22 80 00       	mov    $0x802251,%esi
			if (width > 0 && padc != '-')
  8008b9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008bd:	7e 6d                	jle    80092c <vprintfmt+0x219>
  8008bf:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008c3:	74 67                	je     80092c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c8:	83 ec 08             	sub    $0x8,%esp
  8008cb:	50                   	push   %eax
  8008cc:	56                   	push   %esi
  8008cd:	e8 0c 03 00 00       	call   800bde <strnlen>
  8008d2:	83 c4 10             	add    $0x10,%esp
  8008d5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008d8:	eb 16                	jmp    8008f0 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008da:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008de:	83 ec 08             	sub    $0x8,%esp
  8008e1:	ff 75 0c             	pushl  0xc(%ebp)
  8008e4:	50                   	push   %eax
  8008e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e8:	ff d0                	call   *%eax
  8008ea:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008ed:	ff 4d e4             	decl   -0x1c(%ebp)
  8008f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f4:	7f e4                	jg     8008da <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008f6:	eb 34                	jmp    80092c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008f8:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008fc:	74 1c                	je     80091a <vprintfmt+0x207>
  8008fe:	83 fb 1f             	cmp    $0x1f,%ebx
  800901:	7e 05                	jle    800908 <vprintfmt+0x1f5>
  800903:	83 fb 7e             	cmp    $0x7e,%ebx
  800906:	7e 12                	jle    80091a <vprintfmt+0x207>
					putch('?', putdat);
  800908:	83 ec 08             	sub    $0x8,%esp
  80090b:	ff 75 0c             	pushl  0xc(%ebp)
  80090e:	6a 3f                	push   $0x3f
  800910:	8b 45 08             	mov    0x8(%ebp),%eax
  800913:	ff d0                	call   *%eax
  800915:	83 c4 10             	add    $0x10,%esp
  800918:	eb 0f                	jmp    800929 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80091a:	83 ec 08             	sub    $0x8,%esp
  80091d:	ff 75 0c             	pushl  0xc(%ebp)
  800920:	53                   	push   %ebx
  800921:	8b 45 08             	mov    0x8(%ebp),%eax
  800924:	ff d0                	call   *%eax
  800926:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800929:	ff 4d e4             	decl   -0x1c(%ebp)
  80092c:	89 f0                	mov    %esi,%eax
  80092e:	8d 70 01             	lea    0x1(%eax),%esi
  800931:	8a 00                	mov    (%eax),%al
  800933:	0f be d8             	movsbl %al,%ebx
  800936:	85 db                	test   %ebx,%ebx
  800938:	74 24                	je     80095e <vprintfmt+0x24b>
  80093a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80093e:	78 b8                	js     8008f8 <vprintfmt+0x1e5>
  800940:	ff 4d e0             	decl   -0x20(%ebp)
  800943:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800947:	79 af                	jns    8008f8 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800949:	eb 13                	jmp    80095e <vprintfmt+0x24b>
				putch(' ', putdat);
  80094b:	83 ec 08             	sub    $0x8,%esp
  80094e:	ff 75 0c             	pushl  0xc(%ebp)
  800951:	6a 20                	push   $0x20
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	ff d0                	call   *%eax
  800958:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80095b:	ff 4d e4             	decl   -0x1c(%ebp)
  80095e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800962:	7f e7                	jg     80094b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800964:	e9 66 01 00 00       	jmp    800acf <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800969:	83 ec 08             	sub    $0x8,%esp
  80096c:	ff 75 e8             	pushl  -0x18(%ebp)
  80096f:	8d 45 14             	lea    0x14(%ebp),%eax
  800972:	50                   	push   %eax
  800973:	e8 3c fd ff ff       	call   8006b4 <getint>
  800978:	83 c4 10             	add    $0x10,%esp
  80097b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800981:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800984:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800987:	85 d2                	test   %edx,%edx
  800989:	79 23                	jns    8009ae <vprintfmt+0x29b>
				putch('-', putdat);
  80098b:	83 ec 08             	sub    $0x8,%esp
  80098e:	ff 75 0c             	pushl  0xc(%ebp)
  800991:	6a 2d                	push   $0x2d
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	ff d0                	call   *%eax
  800998:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80099b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80099e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009a1:	f7 d8                	neg    %eax
  8009a3:	83 d2 00             	adc    $0x0,%edx
  8009a6:	f7 da                	neg    %edx
  8009a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009ae:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009b5:	e9 bc 00 00 00       	jmp    800a76 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009ba:	83 ec 08             	sub    $0x8,%esp
  8009bd:	ff 75 e8             	pushl  -0x18(%ebp)
  8009c0:	8d 45 14             	lea    0x14(%ebp),%eax
  8009c3:	50                   	push   %eax
  8009c4:	e8 84 fc ff ff       	call   80064d <getuint>
  8009c9:	83 c4 10             	add    $0x10,%esp
  8009cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009d2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009d9:	e9 98 00 00 00       	jmp    800a76 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009de:	83 ec 08             	sub    $0x8,%esp
  8009e1:	ff 75 0c             	pushl  0xc(%ebp)
  8009e4:	6a 58                	push   $0x58
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	ff d0                	call   *%eax
  8009eb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009ee:	83 ec 08             	sub    $0x8,%esp
  8009f1:	ff 75 0c             	pushl  0xc(%ebp)
  8009f4:	6a 58                	push   $0x58
  8009f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f9:	ff d0                	call   *%eax
  8009fb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009fe:	83 ec 08             	sub    $0x8,%esp
  800a01:	ff 75 0c             	pushl  0xc(%ebp)
  800a04:	6a 58                	push   $0x58
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	ff d0                	call   *%eax
  800a0b:	83 c4 10             	add    $0x10,%esp
			break;
  800a0e:	e9 bc 00 00 00       	jmp    800acf <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a13:	83 ec 08             	sub    $0x8,%esp
  800a16:	ff 75 0c             	pushl  0xc(%ebp)
  800a19:	6a 30                	push   $0x30
  800a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1e:	ff d0                	call   *%eax
  800a20:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a23:	83 ec 08             	sub    $0x8,%esp
  800a26:	ff 75 0c             	pushl  0xc(%ebp)
  800a29:	6a 78                	push   $0x78
  800a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2e:	ff d0                	call   *%eax
  800a30:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a33:	8b 45 14             	mov    0x14(%ebp),%eax
  800a36:	83 c0 04             	add    $0x4,%eax
  800a39:	89 45 14             	mov    %eax,0x14(%ebp)
  800a3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a3f:	83 e8 04             	sub    $0x4,%eax
  800a42:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a47:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a4e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a55:	eb 1f                	jmp    800a76 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a57:	83 ec 08             	sub    $0x8,%esp
  800a5a:	ff 75 e8             	pushl  -0x18(%ebp)
  800a5d:	8d 45 14             	lea    0x14(%ebp),%eax
  800a60:	50                   	push   %eax
  800a61:	e8 e7 fb ff ff       	call   80064d <getuint>
  800a66:	83 c4 10             	add    $0x10,%esp
  800a69:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a6f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a76:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a7a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a7d:	83 ec 04             	sub    $0x4,%esp
  800a80:	52                   	push   %edx
  800a81:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a84:	50                   	push   %eax
  800a85:	ff 75 f4             	pushl  -0xc(%ebp)
  800a88:	ff 75 f0             	pushl  -0x10(%ebp)
  800a8b:	ff 75 0c             	pushl  0xc(%ebp)
  800a8e:	ff 75 08             	pushl  0x8(%ebp)
  800a91:	e8 00 fb ff ff       	call   800596 <printnum>
  800a96:	83 c4 20             	add    $0x20,%esp
			break;
  800a99:	eb 34                	jmp    800acf <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a9b:	83 ec 08             	sub    $0x8,%esp
  800a9e:	ff 75 0c             	pushl  0xc(%ebp)
  800aa1:	53                   	push   %ebx
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa5:	ff d0                	call   *%eax
  800aa7:	83 c4 10             	add    $0x10,%esp
			break;
  800aaa:	eb 23                	jmp    800acf <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800aac:	83 ec 08             	sub    $0x8,%esp
  800aaf:	ff 75 0c             	pushl  0xc(%ebp)
  800ab2:	6a 25                	push   $0x25
  800ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab7:	ff d0                	call   *%eax
  800ab9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800abc:	ff 4d 10             	decl   0x10(%ebp)
  800abf:	eb 03                	jmp    800ac4 <vprintfmt+0x3b1>
  800ac1:	ff 4d 10             	decl   0x10(%ebp)
  800ac4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac7:	48                   	dec    %eax
  800ac8:	8a 00                	mov    (%eax),%al
  800aca:	3c 25                	cmp    $0x25,%al
  800acc:	75 f3                	jne    800ac1 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ace:	90                   	nop
		}
	}
  800acf:	e9 47 fc ff ff       	jmp    80071b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ad4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ad5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ad8:	5b                   	pop    %ebx
  800ad9:	5e                   	pop    %esi
  800ada:	5d                   	pop    %ebp
  800adb:	c3                   	ret    

00800adc <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800adc:	55                   	push   %ebp
  800add:	89 e5                	mov    %esp,%ebp
  800adf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ae2:	8d 45 10             	lea    0x10(%ebp),%eax
  800ae5:	83 c0 04             	add    $0x4,%eax
  800ae8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800aeb:	8b 45 10             	mov    0x10(%ebp),%eax
  800aee:	ff 75 f4             	pushl  -0xc(%ebp)
  800af1:	50                   	push   %eax
  800af2:	ff 75 0c             	pushl  0xc(%ebp)
  800af5:	ff 75 08             	pushl  0x8(%ebp)
  800af8:	e8 16 fc ff ff       	call   800713 <vprintfmt>
  800afd:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b00:	90                   	nop
  800b01:	c9                   	leave  
  800b02:	c3                   	ret    

00800b03 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b03:	55                   	push   %ebp
  800b04:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b09:	8b 40 08             	mov    0x8(%eax),%eax
  800b0c:	8d 50 01             	lea    0x1(%eax),%edx
  800b0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b12:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b18:	8b 10                	mov    (%eax),%edx
  800b1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1d:	8b 40 04             	mov    0x4(%eax),%eax
  800b20:	39 c2                	cmp    %eax,%edx
  800b22:	73 12                	jae    800b36 <sprintputch+0x33>
		*b->buf++ = ch;
  800b24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	8d 48 01             	lea    0x1(%eax),%ecx
  800b2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b2f:	89 0a                	mov    %ecx,(%edx)
  800b31:	8b 55 08             	mov    0x8(%ebp),%edx
  800b34:	88 10                	mov    %dl,(%eax)
}
  800b36:	90                   	nop
  800b37:	5d                   	pop    %ebp
  800b38:	c3                   	ret    

00800b39 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b39:	55                   	push   %ebp
  800b3a:	89 e5                	mov    %esp,%ebp
  800b3c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b48:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	01 d0                	add    %edx,%eax
  800b50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b5a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b5e:	74 06                	je     800b66 <vsnprintf+0x2d>
  800b60:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b64:	7f 07                	jg     800b6d <vsnprintf+0x34>
		return -E_INVAL;
  800b66:	b8 03 00 00 00       	mov    $0x3,%eax
  800b6b:	eb 20                	jmp    800b8d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b6d:	ff 75 14             	pushl  0x14(%ebp)
  800b70:	ff 75 10             	pushl  0x10(%ebp)
  800b73:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b76:	50                   	push   %eax
  800b77:	68 03 0b 80 00       	push   $0x800b03
  800b7c:	e8 92 fb ff ff       	call   800713 <vprintfmt>
  800b81:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b84:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b87:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b8d:	c9                   	leave  
  800b8e:	c3                   	ret    

00800b8f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b8f:	55                   	push   %ebp
  800b90:	89 e5                	mov    %esp,%ebp
  800b92:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b95:	8d 45 10             	lea    0x10(%ebp),%eax
  800b98:	83 c0 04             	add    $0x4,%eax
  800b9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba4:	50                   	push   %eax
  800ba5:	ff 75 0c             	pushl  0xc(%ebp)
  800ba8:	ff 75 08             	pushl  0x8(%ebp)
  800bab:	e8 89 ff ff ff       	call   800b39 <vsnprintf>
  800bb0:	83 c4 10             	add    $0x10,%esp
  800bb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bb9:	c9                   	leave  
  800bba:	c3                   	ret    

00800bbb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bbb:	55                   	push   %ebp
  800bbc:	89 e5                	mov    %esp,%ebp
  800bbe:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bc8:	eb 06                	jmp    800bd0 <strlen+0x15>
		n++;
  800bca:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bcd:	ff 45 08             	incl   0x8(%ebp)
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	8a 00                	mov    (%eax),%al
  800bd5:	84 c0                	test   %al,%al
  800bd7:	75 f1                	jne    800bca <strlen+0xf>
		n++;
	return n;
  800bd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bdc:	c9                   	leave  
  800bdd:	c3                   	ret    

00800bde <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bde:	55                   	push   %ebp
  800bdf:	89 e5                	mov    %esp,%ebp
  800be1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800be4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800beb:	eb 09                	jmp    800bf6 <strnlen+0x18>
		n++;
  800bed:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bf0:	ff 45 08             	incl   0x8(%ebp)
  800bf3:	ff 4d 0c             	decl   0xc(%ebp)
  800bf6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bfa:	74 09                	je     800c05 <strnlen+0x27>
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	8a 00                	mov    (%eax),%al
  800c01:	84 c0                	test   %al,%al
  800c03:	75 e8                	jne    800bed <strnlen+0xf>
		n++;
	return n;
  800c05:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c08:	c9                   	leave  
  800c09:	c3                   	ret    

00800c0a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c0a:	55                   	push   %ebp
  800c0b:	89 e5                	mov    %esp,%ebp
  800c0d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c16:	90                   	nop
  800c17:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1a:	8d 50 01             	lea    0x1(%eax),%edx
  800c1d:	89 55 08             	mov    %edx,0x8(%ebp)
  800c20:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c23:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c26:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c29:	8a 12                	mov    (%edx),%dl
  800c2b:	88 10                	mov    %dl,(%eax)
  800c2d:	8a 00                	mov    (%eax),%al
  800c2f:	84 c0                	test   %al,%al
  800c31:	75 e4                	jne    800c17 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c33:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c36:	c9                   	leave  
  800c37:	c3                   	ret    

00800c38 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c38:	55                   	push   %ebp
  800c39:	89 e5                	mov    %esp,%ebp
  800c3b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c44:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c4b:	eb 1f                	jmp    800c6c <strncpy+0x34>
		*dst++ = *src;
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	8d 50 01             	lea    0x1(%eax),%edx
  800c53:	89 55 08             	mov    %edx,0x8(%ebp)
  800c56:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c59:	8a 12                	mov    (%edx),%dl
  800c5b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c60:	8a 00                	mov    (%eax),%al
  800c62:	84 c0                	test   %al,%al
  800c64:	74 03                	je     800c69 <strncpy+0x31>
			src++;
  800c66:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c69:	ff 45 fc             	incl   -0x4(%ebp)
  800c6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c6f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c72:	72 d9                	jb     800c4d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c74:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c77:	c9                   	leave  
  800c78:	c3                   	ret    

00800c79 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c79:	55                   	push   %ebp
  800c7a:	89 e5                	mov    %esp,%ebp
  800c7c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c85:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c89:	74 30                	je     800cbb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c8b:	eb 16                	jmp    800ca3 <strlcpy+0x2a>
			*dst++ = *src++;
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	8d 50 01             	lea    0x1(%eax),%edx
  800c93:	89 55 08             	mov    %edx,0x8(%ebp)
  800c96:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c99:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c9c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c9f:	8a 12                	mov    (%edx),%dl
  800ca1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ca3:	ff 4d 10             	decl   0x10(%ebp)
  800ca6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800caa:	74 09                	je     800cb5 <strlcpy+0x3c>
  800cac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800caf:	8a 00                	mov    (%eax),%al
  800cb1:	84 c0                	test   %al,%al
  800cb3:	75 d8                	jne    800c8d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cbb:	8b 55 08             	mov    0x8(%ebp),%edx
  800cbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cc1:	29 c2                	sub    %eax,%edx
  800cc3:	89 d0                	mov    %edx,%eax
}
  800cc5:	c9                   	leave  
  800cc6:	c3                   	ret    

00800cc7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cc7:	55                   	push   %ebp
  800cc8:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cca:	eb 06                	jmp    800cd2 <strcmp+0xb>
		p++, q++;
  800ccc:	ff 45 08             	incl   0x8(%ebp)
  800ccf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd5:	8a 00                	mov    (%eax),%al
  800cd7:	84 c0                	test   %al,%al
  800cd9:	74 0e                	je     800ce9 <strcmp+0x22>
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	8a 10                	mov    (%eax),%dl
  800ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce3:	8a 00                	mov    (%eax),%al
  800ce5:	38 c2                	cmp    %al,%dl
  800ce7:	74 e3                	je     800ccc <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cec:	8a 00                	mov    (%eax),%al
  800cee:	0f b6 d0             	movzbl %al,%edx
  800cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf4:	8a 00                	mov    (%eax),%al
  800cf6:	0f b6 c0             	movzbl %al,%eax
  800cf9:	29 c2                	sub    %eax,%edx
  800cfb:	89 d0                	mov    %edx,%eax
}
  800cfd:	5d                   	pop    %ebp
  800cfe:	c3                   	ret    

00800cff <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cff:	55                   	push   %ebp
  800d00:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d02:	eb 09                	jmp    800d0d <strncmp+0xe>
		n--, p++, q++;
  800d04:	ff 4d 10             	decl   0x10(%ebp)
  800d07:	ff 45 08             	incl   0x8(%ebp)
  800d0a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d11:	74 17                	je     800d2a <strncmp+0x2b>
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	84 c0                	test   %al,%al
  800d1a:	74 0e                	je     800d2a <strncmp+0x2b>
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	8a 10                	mov    (%eax),%dl
  800d21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d24:	8a 00                	mov    (%eax),%al
  800d26:	38 c2                	cmp    %al,%dl
  800d28:	74 da                	je     800d04 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d2a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2e:	75 07                	jne    800d37 <strncmp+0x38>
		return 0;
  800d30:	b8 00 00 00 00       	mov    $0x0,%eax
  800d35:	eb 14                	jmp    800d4b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	8a 00                	mov    (%eax),%al
  800d3c:	0f b6 d0             	movzbl %al,%edx
  800d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	0f b6 c0             	movzbl %al,%eax
  800d47:	29 c2                	sub    %eax,%edx
  800d49:	89 d0                	mov    %edx,%eax
}
  800d4b:	5d                   	pop    %ebp
  800d4c:	c3                   	ret    

00800d4d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d4d:	55                   	push   %ebp
  800d4e:	89 e5                	mov    %esp,%ebp
  800d50:	83 ec 04             	sub    $0x4,%esp
  800d53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d56:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d59:	eb 12                	jmp    800d6d <strchr+0x20>
		if (*s == c)
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	8a 00                	mov    (%eax),%al
  800d60:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d63:	75 05                	jne    800d6a <strchr+0x1d>
			return (char *) s;
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	eb 11                	jmp    800d7b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d6a:	ff 45 08             	incl   0x8(%ebp)
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	84 c0                	test   %al,%al
  800d74:	75 e5                	jne    800d5b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d76:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d7b:	c9                   	leave  
  800d7c:	c3                   	ret    

00800d7d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d7d:	55                   	push   %ebp
  800d7e:	89 e5                	mov    %esp,%ebp
  800d80:	83 ec 04             	sub    $0x4,%esp
  800d83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d86:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d89:	eb 0d                	jmp    800d98 <strfind+0x1b>
		if (*s == c)
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	8a 00                	mov    (%eax),%al
  800d90:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d93:	74 0e                	je     800da3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d95:	ff 45 08             	incl   0x8(%ebp)
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	8a 00                	mov    (%eax),%al
  800d9d:	84 c0                	test   %al,%al
  800d9f:	75 ea                	jne    800d8b <strfind+0xe>
  800da1:	eb 01                	jmp    800da4 <strfind+0x27>
		if (*s == c)
			break;
  800da3:	90                   	nop
	return (char *) s;
  800da4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da7:	c9                   	leave  
  800da8:	c3                   	ret    

00800da9 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800da9:	55                   	push   %ebp
  800daa:	89 e5                	mov    %esp,%ebp
  800dac:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800daf:	8b 45 08             	mov    0x8(%ebp),%eax
  800db2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800db5:	8b 45 10             	mov    0x10(%ebp),%eax
  800db8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dbb:	eb 0e                	jmp    800dcb <memset+0x22>
		*p++ = c;
  800dbd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc0:	8d 50 01             	lea    0x1(%eax),%edx
  800dc3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800dc6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dc9:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dcb:	ff 4d f8             	decl   -0x8(%ebp)
  800dce:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dd2:	79 e9                	jns    800dbd <memset+0x14>
		*p++ = c;

	return v;
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dd7:	c9                   	leave  
  800dd8:	c3                   	ret    

00800dd9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dd9:	55                   	push   %ebp
  800dda:	89 e5                	mov    %esp,%ebp
  800ddc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800deb:	eb 16                	jmp    800e03 <memcpy+0x2a>
		*d++ = *s++;
  800ded:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df0:	8d 50 01             	lea    0x1(%eax),%edx
  800df3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800df6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dfc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dff:	8a 12                	mov    (%edx),%dl
  800e01:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e03:	8b 45 10             	mov    0x10(%ebp),%eax
  800e06:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e09:	89 55 10             	mov    %edx,0x10(%ebp)
  800e0c:	85 c0                	test   %eax,%eax
  800e0e:	75 dd                	jne    800ded <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e13:	c9                   	leave  
  800e14:	c3                   	ret    

00800e15 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e15:	55                   	push   %ebp
  800e16:	89 e5                	mov    %esp,%ebp
  800e18:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800e1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e21:	8b 45 08             	mov    0x8(%ebp),%eax
  800e24:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e27:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e2a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e2d:	73 50                	jae    800e7f <memmove+0x6a>
  800e2f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e32:	8b 45 10             	mov    0x10(%ebp),%eax
  800e35:	01 d0                	add    %edx,%eax
  800e37:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e3a:	76 43                	jbe    800e7f <memmove+0x6a>
		s += n;
  800e3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e3f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e42:	8b 45 10             	mov    0x10(%ebp),%eax
  800e45:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e48:	eb 10                	jmp    800e5a <memmove+0x45>
			*--d = *--s;
  800e4a:	ff 4d f8             	decl   -0x8(%ebp)
  800e4d:	ff 4d fc             	decl   -0x4(%ebp)
  800e50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e53:	8a 10                	mov    (%eax),%dl
  800e55:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e58:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e60:	89 55 10             	mov    %edx,0x10(%ebp)
  800e63:	85 c0                	test   %eax,%eax
  800e65:	75 e3                	jne    800e4a <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e67:	eb 23                	jmp    800e8c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e69:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e6c:	8d 50 01             	lea    0x1(%eax),%edx
  800e6f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e72:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e75:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e78:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e7b:	8a 12                	mov    (%edx),%dl
  800e7d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e82:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e85:	89 55 10             	mov    %edx,0x10(%ebp)
  800e88:	85 c0                	test   %eax,%eax
  800e8a:	75 dd                	jne    800e69 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e8f:	c9                   	leave  
  800e90:	c3                   	ret    

00800e91 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e91:	55                   	push   %ebp
  800e92:	89 e5                	mov    %esp,%ebp
  800e94:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ea3:	eb 2a                	jmp    800ecf <memcmp+0x3e>
		if (*s1 != *s2)
  800ea5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea8:	8a 10                	mov    (%eax),%dl
  800eaa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ead:	8a 00                	mov    (%eax),%al
  800eaf:	38 c2                	cmp    %al,%dl
  800eb1:	74 16                	je     800ec9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800eb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb6:	8a 00                	mov    (%eax),%al
  800eb8:	0f b6 d0             	movzbl %al,%edx
  800ebb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ebe:	8a 00                	mov    (%eax),%al
  800ec0:	0f b6 c0             	movzbl %al,%eax
  800ec3:	29 c2                	sub    %eax,%edx
  800ec5:	89 d0                	mov    %edx,%eax
  800ec7:	eb 18                	jmp    800ee1 <memcmp+0x50>
		s1++, s2++;
  800ec9:	ff 45 fc             	incl   -0x4(%ebp)
  800ecc:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ecf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ed5:	89 55 10             	mov    %edx,0x10(%ebp)
  800ed8:	85 c0                	test   %eax,%eax
  800eda:	75 c9                	jne    800ea5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800edc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ee1:	c9                   	leave  
  800ee2:	c3                   	ret    

00800ee3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ee3:	55                   	push   %ebp
  800ee4:	89 e5                	mov    %esp,%ebp
  800ee6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ee9:	8b 55 08             	mov    0x8(%ebp),%edx
  800eec:	8b 45 10             	mov    0x10(%ebp),%eax
  800eef:	01 d0                	add    %edx,%eax
  800ef1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ef4:	eb 15                	jmp    800f0b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	0f b6 d0             	movzbl %al,%edx
  800efe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f01:	0f b6 c0             	movzbl %al,%eax
  800f04:	39 c2                	cmp    %eax,%edx
  800f06:	74 0d                	je     800f15 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f08:	ff 45 08             	incl   0x8(%ebp)
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f11:	72 e3                	jb     800ef6 <memfind+0x13>
  800f13:	eb 01                	jmp    800f16 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f15:	90                   	nop
	return (void *) s;
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f19:	c9                   	leave  
  800f1a:	c3                   	ret    

00800f1b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f1b:	55                   	push   %ebp
  800f1c:	89 e5                	mov    %esp,%ebp
  800f1e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f21:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f28:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f2f:	eb 03                	jmp    800f34 <strtol+0x19>
		s++;
  800f31:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	8a 00                	mov    (%eax),%al
  800f39:	3c 20                	cmp    $0x20,%al
  800f3b:	74 f4                	je     800f31 <strtol+0x16>
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	8a 00                	mov    (%eax),%al
  800f42:	3c 09                	cmp    $0x9,%al
  800f44:	74 eb                	je     800f31 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	3c 2b                	cmp    $0x2b,%al
  800f4d:	75 05                	jne    800f54 <strtol+0x39>
		s++;
  800f4f:	ff 45 08             	incl   0x8(%ebp)
  800f52:	eb 13                	jmp    800f67 <strtol+0x4c>
	else if (*s == '-')
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	8a 00                	mov    (%eax),%al
  800f59:	3c 2d                	cmp    $0x2d,%al
  800f5b:	75 0a                	jne    800f67 <strtol+0x4c>
		s++, neg = 1;
  800f5d:	ff 45 08             	incl   0x8(%ebp)
  800f60:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f67:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f6b:	74 06                	je     800f73 <strtol+0x58>
  800f6d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f71:	75 20                	jne    800f93 <strtol+0x78>
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	3c 30                	cmp    $0x30,%al
  800f7a:	75 17                	jne    800f93 <strtol+0x78>
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	40                   	inc    %eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	3c 78                	cmp    $0x78,%al
  800f84:	75 0d                	jne    800f93 <strtol+0x78>
		s += 2, base = 16;
  800f86:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f8a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f91:	eb 28                	jmp    800fbb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f93:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f97:	75 15                	jne    800fae <strtol+0x93>
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	3c 30                	cmp    $0x30,%al
  800fa0:	75 0c                	jne    800fae <strtol+0x93>
		s++, base = 8;
  800fa2:	ff 45 08             	incl   0x8(%ebp)
  800fa5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fac:	eb 0d                	jmp    800fbb <strtol+0xa0>
	else if (base == 0)
  800fae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fb2:	75 07                	jne    800fbb <strtol+0xa0>
		base = 10;
  800fb4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbe:	8a 00                	mov    (%eax),%al
  800fc0:	3c 2f                	cmp    $0x2f,%al
  800fc2:	7e 19                	jle    800fdd <strtol+0xc2>
  800fc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc7:	8a 00                	mov    (%eax),%al
  800fc9:	3c 39                	cmp    $0x39,%al
  800fcb:	7f 10                	jg     800fdd <strtol+0xc2>
			dig = *s - '0';
  800fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd0:	8a 00                	mov    (%eax),%al
  800fd2:	0f be c0             	movsbl %al,%eax
  800fd5:	83 e8 30             	sub    $0x30,%eax
  800fd8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fdb:	eb 42                	jmp    80101f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe0:	8a 00                	mov    (%eax),%al
  800fe2:	3c 60                	cmp    $0x60,%al
  800fe4:	7e 19                	jle    800fff <strtol+0xe4>
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe9:	8a 00                	mov    (%eax),%al
  800feb:	3c 7a                	cmp    $0x7a,%al
  800fed:	7f 10                	jg     800fff <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff2:	8a 00                	mov    (%eax),%al
  800ff4:	0f be c0             	movsbl %al,%eax
  800ff7:	83 e8 57             	sub    $0x57,%eax
  800ffa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ffd:	eb 20                	jmp    80101f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fff:	8b 45 08             	mov    0x8(%ebp),%eax
  801002:	8a 00                	mov    (%eax),%al
  801004:	3c 40                	cmp    $0x40,%al
  801006:	7e 39                	jle    801041 <strtol+0x126>
  801008:	8b 45 08             	mov    0x8(%ebp),%eax
  80100b:	8a 00                	mov    (%eax),%al
  80100d:	3c 5a                	cmp    $0x5a,%al
  80100f:	7f 30                	jg     801041 <strtol+0x126>
			dig = *s - 'A' + 10;
  801011:	8b 45 08             	mov    0x8(%ebp),%eax
  801014:	8a 00                	mov    (%eax),%al
  801016:	0f be c0             	movsbl %al,%eax
  801019:	83 e8 37             	sub    $0x37,%eax
  80101c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80101f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801022:	3b 45 10             	cmp    0x10(%ebp),%eax
  801025:	7d 19                	jge    801040 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801027:	ff 45 08             	incl   0x8(%ebp)
  80102a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80102d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801031:	89 c2                	mov    %eax,%edx
  801033:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801036:	01 d0                	add    %edx,%eax
  801038:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80103b:	e9 7b ff ff ff       	jmp    800fbb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801040:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801041:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801045:	74 08                	je     80104f <strtol+0x134>
		*endptr = (char *) s;
  801047:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104a:	8b 55 08             	mov    0x8(%ebp),%edx
  80104d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80104f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801053:	74 07                	je     80105c <strtol+0x141>
  801055:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801058:	f7 d8                	neg    %eax
  80105a:	eb 03                	jmp    80105f <strtol+0x144>
  80105c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80105f:	c9                   	leave  
  801060:	c3                   	ret    

00801061 <ltostr>:

void
ltostr(long value, char *str)
{
  801061:	55                   	push   %ebp
  801062:	89 e5                	mov    %esp,%ebp
  801064:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801067:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80106e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801075:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801079:	79 13                	jns    80108e <ltostr+0x2d>
	{
		neg = 1;
  80107b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801082:	8b 45 0c             	mov    0xc(%ebp),%eax
  801085:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801088:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80108b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80108e:	8b 45 08             	mov    0x8(%ebp),%eax
  801091:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801096:	99                   	cltd   
  801097:	f7 f9                	idiv   %ecx
  801099:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80109c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109f:	8d 50 01             	lea    0x1(%eax),%edx
  8010a2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010a5:	89 c2                	mov    %eax,%edx
  8010a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010aa:	01 d0                	add    %edx,%eax
  8010ac:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010af:	83 c2 30             	add    $0x30,%edx
  8010b2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010b7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010bc:	f7 e9                	imul   %ecx
  8010be:	c1 fa 02             	sar    $0x2,%edx
  8010c1:	89 c8                	mov    %ecx,%eax
  8010c3:	c1 f8 1f             	sar    $0x1f,%eax
  8010c6:	29 c2                	sub    %eax,%edx
  8010c8:	89 d0                	mov    %edx,%eax
  8010ca:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010d0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010d5:	f7 e9                	imul   %ecx
  8010d7:	c1 fa 02             	sar    $0x2,%edx
  8010da:	89 c8                	mov    %ecx,%eax
  8010dc:	c1 f8 1f             	sar    $0x1f,%eax
  8010df:	29 c2                	sub    %eax,%edx
  8010e1:	89 d0                	mov    %edx,%eax
  8010e3:	c1 e0 02             	shl    $0x2,%eax
  8010e6:	01 d0                	add    %edx,%eax
  8010e8:	01 c0                	add    %eax,%eax
  8010ea:	29 c1                	sub    %eax,%ecx
  8010ec:	89 ca                	mov    %ecx,%edx
  8010ee:	85 d2                	test   %edx,%edx
  8010f0:	75 9c                	jne    80108e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fc:	48                   	dec    %eax
  8010fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801100:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801104:	74 3d                	je     801143 <ltostr+0xe2>
		start = 1 ;
  801106:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80110d:	eb 34                	jmp    801143 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80110f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801112:	8b 45 0c             	mov    0xc(%ebp),%eax
  801115:	01 d0                	add    %edx,%eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80111c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80111f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801122:	01 c2                	add    %eax,%edx
  801124:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801127:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112a:	01 c8                	add    %ecx,%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801130:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801133:	8b 45 0c             	mov    0xc(%ebp),%eax
  801136:	01 c2                	add    %eax,%edx
  801138:	8a 45 eb             	mov    -0x15(%ebp),%al
  80113b:	88 02                	mov    %al,(%edx)
		start++ ;
  80113d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801140:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801143:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801146:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801149:	7c c4                	jl     80110f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80114b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80114e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801151:	01 d0                	add    %edx,%eax
  801153:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801156:	90                   	nop
  801157:	c9                   	leave  
  801158:	c3                   	ret    

00801159 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801159:	55                   	push   %ebp
  80115a:	89 e5                	mov    %esp,%ebp
  80115c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80115f:	ff 75 08             	pushl  0x8(%ebp)
  801162:	e8 54 fa ff ff       	call   800bbb <strlen>
  801167:	83 c4 04             	add    $0x4,%esp
  80116a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80116d:	ff 75 0c             	pushl  0xc(%ebp)
  801170:	e8 46 fa ff ff       	call   800bbb <strlen>
  801175:	83 c4 04             	add    $0x4,%esp
  801178:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80117b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801182:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801189:	eb 17                	jmp    8011a2 <strcconcat+0x49>
		final[s] = str1[s] ;
  80118b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80118e:	8b 45 10             	mov    0x10(%ebp),%eax
  801191:	01 c2                	add    %eax,%edx
  801193:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	01 c8                	add    %ecx,%eax
  80119b:	8a 00                	mov    (%eax),%al
  80119d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80119f:	ff 45 fc             	incl   -0x4(%ebp)
  8011a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011a5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011a8:	7c e1                	jl     80118b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011aa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011b1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011b8:	eb 1f                	jmp    8011d9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011bd:	8d 50 01             	lea    0x1(%eax),%edx
  8011c0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011c3:	89 c2                	mov    %eax,%edx
  8011c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c8:	01 c2                	add    %eax,%edx
  8011ca:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d0:	01 c8                	add    %ecx,%eax
  8011d2:	8a 00                	mov    (%eax),%al
  8011d4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011d6:	ff 45 f8             	incl   -0x8(%ebp)
  8011d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011dc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011df:	7c d9                	jl     8011ba <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e7:	01 d0                	add    %edx,%eax
  8011e9:	c6 00 00             	movb   $0x0,(%eax)
}
  8011ec:	90                   	nop
  8011ed:	c9                   	leave  
  8011ee:	c3                   	ret    

008011ef <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011ef:	55                   	push   %ebp
  8011f0:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8011fe:	8b 00                	mov    (%eax),%eax
  801200:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801207:	8b 45 10             	mov    0x10(%ebp),%eax
  80120a:	01 d0                	add    %edx,%eax
  80120c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801212:	eb 0c                	jmp    801220 <strsplit+0x31>
			*string++ = 0;
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
  801217:	8d 50 01             	lea    0x1(%eax),%edx
  80121a:	89 55 08             	mov    %edx,0x8(%ebp)
  80121d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	8a 00                	mov    (%eax),%al
  801225:	84 c0                	test   %al,%al
  801227:	74 18                	je     801241 <strsplit+0x52>
  801229:	8b 45 08             	mov    0x8(%ebp),%eax
  80122c:	8a 00                	mov    (%eax),%al
  80122e:	0f be c0             	movsbl %al,%eax
  801231:	50                   	push   %eax
  801232:	ff 75 0c             	pushl  0xc(%ebp)
  801235:	e8 13 fb ff ff       	call   800d4d <strchr>
  80123a:	83 c4 08             	add    $0x8,%esp
  80123d:	85 c0                	test   %eax,%eax
  80123f:	75 d3                	jne    801214 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801241:	8b 45 08             	mov    0x8(%ebp),%eax
  801244:	8a 00                	mov    (%eax),%al
  801246:	84 c0                	test   %al,%al
  801248:	74 5a                	je     8012a4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80124a:	8b 45 14             	mov    0x14(%ebp),%eax
  80124d:	8b 00                	mov    (%eax),%eax
  80124f:	83 f8 0f             	cmp    $0xf,%eax
  801252:	75 07                	jne    80125b <strsplit+0x6c>
		{
			return 0;
  801254:	b8 00 00 00 00       	mov    $0x0,%eax
  801259:	eb 66                	jmp    8012c1 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80125b:	8b 45 14             	mov    0x14(%ebp),%eax
  80125e:	8b 00                	mov    (%eax),%eax
  801260:	8d 48 01             	lea    0x1(%eax),%ecx
  801263:	8b 55 14             	mov    0x14(%ebp),%edx
  801266:	89 0a                	mov    %ecx,(%edx)
  801268:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80126f:	8b 45 10             	mov    0x10(%ebp),%eax
  801272:	01 c2                	add    %eax,%edx
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
  801277:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801279:	eb 03                	jmp    80127e <strsplit+0x8f>
			string++;
  80127b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80127e:	8b 45 08             	mov    0x8(%ebp),%eax
  801281:	8a 00                	mov    (%eax),%al
  801283:	84 c0                	test   %al,%al
  801285:	74 8b                	je     801212 <strsplit+0x23>
  801287:	8b 45 08             	mov    0x8(%ebp),%eax
  80128a:	8a 00                	mov    (%eax),%al
  80128c:	0f be c0             	movsbl %al,%eax
  80128f:	50                   	push   %eax
  801290:	ff 75 0c             	pushl  0xc(%ebp)
  801293:	e8 b5 fa ff ff       	call   800d4d <strchr>
  801298:	83 c4 08             	add    $0x8,%esp
  80129b:	85 c0                	test   %eax,%eax
  80129d:	74 dc                	je     80127b <strsplit+0x8c>
			string++;
	}
  80129f:	e9 6e ff ff ff       	jmp    801212 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012a4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a8:	8b 00                	mov    (%eax),%eax
  8012aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b4:	01 d0                	add    %edx,%eax
  8012b6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012bc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012c1:	c9                   	leave  
  8012c2:	c3                   	ret    

008012c3 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  8012c3:	55                   	push   %ebp
  8012c4:	89 e5                	mov    %esp,%ebp
  8012c6:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  8012c9:	e8 9b 07 00 00       	call   801a69 <sys_isUHeapPlacementStrategyNEXTFIT>
  8012ce:	85 c0                	test   %eax,%eax
  8012d0:	0f 84 64 01 00 00    	je     80143a <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  8012d6:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  8012dc:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  8012e3:	8b 55 08             	mov    0x8(%ebp),%edx
  8012e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8012e9:	01 d0                	add    %edx,%eax
  8012eb:	48                   	dec    %eax
  8012ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8012ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8012f2:	ba 00 00 00 00       	mov    $0x0,%edx
  8012f7:	f7 75 e8             	divl   -0x18(%ebp)
  8012fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8012fd:	29 d0                	sub    %edx,%eax
  8012ff:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801306:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
  80130f:	01 d0                	add    %edx,%eax
  801311:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801314:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  80131b:	a1 28 30 80 00       	mov    0x803028,%eax
  801320:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801327:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80132a:	0f 83 0a 01 00 00    	jae    80143a <malloc+0x177>
  801330:	a1 28 30 80 00       	mov    0x803028,%eax
  801335:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80133c:	85 c0                	test   %eax,%eax
  80133e:	0f 84 f6 00 00 00    	je     80143a <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801344:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80134b:	e9 dc 00 00 00       	jmp    80142c <malloc+0x169>
				flag++;
  801350:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801353:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801356:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80135d:	85 c0                	test   %eax,%eax
  80135f:	74 07                	je     801368 <malloc+0xa5>
					flag=0;
  801361:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801368:	a1 28 30 80 00       	mov    0x803028,%eax
  80136d:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801374:	85 c0                	test   %eax,%eax
  801376:	79 05                	jns    80137d <malloc+0xba>
  801378:	05 ff 0f 00 00       	add    $0xfff,%eax
  80137d:	c1 f8 0c             	sar    $0xc,%eax
  801380:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801383:	0f 85 a0 00 00 00    	jne    801429 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801389:	a1 28 30 80 00       	mov    0x803028,%eax
  80138e:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801395:	85 c0                	test   %eax,%eax
  801397:	79 05                	jns    80139e <malloc+0xdb>
  801399:	05 ff 0f 00 00       	add    $0xfff,%eax
  80139e:	c1 f8 0c             	sar    $0xc,%eax
  8013a1:	89 c2                	mov    %eax,%edx
  8013a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013a6:	29 d0                	sub    %edx,%eax
  8013a8:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  8013ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8013ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8013b1:	eb 11                	jmp    8013c4 <malloc+0x101>
						hFreeArr[j] = 1;
  8013b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013b6:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  8013bd:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  8013c1:	ff 45 ec             	incl   -0x14(%ebp)
  8013c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013c7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013ca:	7e e7                	jle    8013b3 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  8013cc:	a1 28 30 80 00       	mov    0x803028,%eax
  8013d1:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8013d4:	81 c2 01 00 08 00    	add    $0x80001,%edx
  8013da:	c1 e2 0c             	shl    $0xc,%edx
  8013dd:	89 15 04 30 80 00    	mov    %edx,0x803004
  8013e3:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8013e9:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  8013f0:	a1 28 30 80 00       	mov    0x803028,%eax
  8013f5:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8013fc:	89 c2                	mov    %eax,%edx
  8013fe:	a1 28 30 80 00       	mov    0x803028,%eax
  801403:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  80140a:	83 ec 08             	sub    $0x8,%esp
  80140d:	52                   	push   %edx
  80140e:	50                   	push   %eax
  80140f:	e8 8b 02 00 00       	call   80169f <sys_allocateMem>
  801414:	83 c4 10             	add    $0x10,%esp

					idx++;
  801417:	a1 28 30 80 00       	mov    0x803028,%eax
  80141c:	40                   	inc    %eax
  80141d:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  801422:	a1 04 30 80 00       	mov    0x803004,%eax
  801427:	eb 16                	jmp    80143f <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801429:	ff 45 f0             	incl   -0x10(%ebp)
  80142c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80142f:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801434:	0f 86 16 ff ff ff    	jbe    801350 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  80143a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80143f:	c9                   	leave  
  801440:	c3                   	ret    

00801441 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801441:	55                   	push   %ebp
  801442:	89 e5                	mov    %esp,%ebp
  801444:	83 ec 18             	sub    $0x18,%esp
  801447:	8b 45 10             	mov    0x10(%ebp),%eax
  80144a:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  80144d:	83 ec 04             	sub    $0x4,%esp
  801450:	68 b0 23 80 00       	push   $0x8023b0
  801455:	6a 59                	push   $0x59
  801457:	68 cf 23 80 00       	push   $0x8023cf
  80145c:	e8 85 06 00 00       	call   801ae6 <_panic>

00801461 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801461:	55                   	push   %ebp
  801462:	89 e5                	mov    %esp,%ebp
  801464:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801467:	83 ec 04             	sub    $0x4,%esp
  80146a:	68 db 23 80 00       	push   $0x8023db
  80146f:	6a 5f                	push   $0x5f
  801471:	68 cf 23 80 00       	push   $0x8023cf
  801476:	e8 6b 06 00 00       	call   801ae6 <_panic>

0080147b <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80147b:	55                   	push   %ebp
  80147c:	89 e5                	mov    %esp,%ebp
  80147e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801481:	83 ec 04             	sub    $0x4,%esp
  801484:	68 f8 23 80 00       	push   $0x8023f8
  801489:	6a 70                	push   $0x70
  80148b:	68 cf 23 80 00       	push   $0x8023cf
  801490:	e8 51 06 00 00       	call   801ae6 <_panic>

00801495 <sfree>:

}


void sfree(void* virtual_address)
{
  801495:	55                   	push   %ebp
  801496:	89 e5                	mov    %esp,%ebp
  801498:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  80149b:	83 ec 04             	sub    $0x4,%esp
  80149e:	68 1b 24 80 00       	push   $0x80241b
  8014a3:	6a 7b                	push   $0x7b
  8014a5:	68 cf 23 80 00       	push   $0x8023cf
  8014aa:	e8 37 06 00 00       	call   801ae6 <_panic>

008014af <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  8014af:	55                   	push   %ebp
  8014b0:	89 e5                	mov    %esp,%ebp
  8014b2:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8014b5:	83 ec 04             	sub    $0x4,%esp
  8014b8:	68 38 24 80 00       	push   $0x802438
  8014bd:	68 93 00 00 00       	push   $0x93
  8014c2:	68 cf 23 80 00       	push   $0x8023cf
  8014c7:	e8 1a 06 00 00       	call   801ae6 <_panic>

008014cc <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014cc:	55                   	push   %ebp
  8014cd:	89 e5                	mov    %esp,%ebp
  8014cf:	57                   	push   %edi
  8014d0:	56                   	push   %esi
  8014d1:	53                   	push   %ebx
  8014d2:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014de:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014e1:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014e4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014e7:	cd 30                	int    $0x30
  8014e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014ef:	83 c4 10             	add    $0x10,%esp
  8014f2:	5b                   	pop    %ebx
  8014f3:	5e                   	pop    %esi
  8014f4:	5f                   	pop    %edi
  8014f5:	5d                   	pop    %ebp
  8014f6:	c3                   	ret    

008014f7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
  8014fa:	83 ec 04             	sub    $0x4,%esp
  8014fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801500:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801503:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801507:	8b 45 08             	mov    0x8(%ebp),%eax
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	52                   	push   %edx
  80150f:	ff 75 0c             	pushl  0xc(%ebp)
  801512:	50                   	push   %eax
  801513:	6a 00                	push   $0x0
  801515:	e8 b2 ff ff ff       	call   8014cc <syscall>
  80151a:	83 c4 18             	add    $0x18,%esp
}
  80151d:	90                   	nop
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <sys_cgetc>:

int
sys_cgetc(void)
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 01                	push   $0x1
  80152f:	e8 98 ff ff ff       	call   8014cc <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
}
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80153c:	8b 45 08             	mov    0x8(%ebp),%eax
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	50                   	push   %eax
  801548:	6a 05                	push   $0x5
  80154a:	e8 7d ff ff ff       	call   8014cc <syscall>
  80154f:	83 c4 18             	add    $0x18,%esp
}
  801552:	c9                   	leave  
  801553:	c3                   	ret    

00801554 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801554:	55                   	push   %ebp
  801555:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 02                	push   $0x2
  801563:	e8 64 ff ff ff       	call   8014cc <syscall>
  801568:	83 c4 18             	add    $0x18,%esp
}
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 03                	push   $0x3
  80157c:	e8 4b ff ff ff       	call   8014cc <syscall>
  801581:	83 c4 18             	add    $0x18,%esp
}
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	6a 04                	push   $0x4
  801595:	e8 32 ff ff ff       	call   8014cc <syscall>
  80159a:	83 c4 18             	add    $0x18,%esp
}
  80159d:	c9                   	leave  
  80159e:	c3                   	ret    

0080159f <sys_env_exit>:


void sys_env_exit(void)
{
  80159f:	55                   	push   %ebp
  8015a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 06                	push   $0x6
  8015ae:	e8 19 ff ff ff       	call   8014cc <syscall>
  8015b3:	83 c4 18             	add    $0x18,%esp
}
  8015b6:	90                   	nop
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	52                   	push   %edx
  8015c9:	50                   	push   %eax
  8015ca:	6a 07                	push   $0x7
  8015cc:	e8 fb fe ff ff       	call   8014cc <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
}
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
  8015d9:	56                   	push   %esi
  8015da:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015db:	8b 75 18             	mov    0x18(%ebp),%esi
  8015de:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015e1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	56                   	push   %esi
  8015eb:	53                   	push   %ebx
  8015ec:	51                   	push   %ecx
  8015ed:	52                   	push   %edx
  8015ee:	50                   	push   %eax
  8015ef:	6a 08                	push   $0x8
  8015f1:	e8 d6 fe ff ff       	call   8014cc <syscall>
  8015f6:	83 c4 18             	add    $0x18,%esp
}
  8015f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015fc:	5b                   	pop    %ebx
  8015fd:	5e                   	pop    %esi
  8015fe:	5d                   	pop    %ebp
  8015ff:	c3                   	ret    

00801600 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801600:	55                   	push   %ebp
  801601:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801603:	8b 55 0c             	mov    0xc(%ebp),%edx
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	52                   	push   %edx
  801610:	50                   	push   %eax
  801611:	6a 09                	push   $0x9
  801613:	e8 b4 fe ff ff       	call   8014cc <syscall>
  801618:	83 c4 18             	add    $0x18,%esp
}
  80161b:	c9                   	leave  
  80161c:	c3                   	ret    

0080161d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80161d:	55                   	push   %ebp
  80161e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	ff 75 0c             	pushl  0xc(%ebp)
  801629:	ff 75 08             	pushl  0x8(%ebp)
  80162c:	6a 0a                	push   $0xa
  80162e:	e8 99 fe ff ff       	call   8014cc <syscall>
  801633:	83 c4 18             	add    $0x18,%esp
}
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 0b                	push   $0xb
  801647:	e8 80 fe ff ff       	call   8014cc <syscall>
  80164c:	83 c4 18             	add    $0x18,%esp
}
  80164f:	c9                   	leave  
  801650:	c3                   	ret    

00801651 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801651:	55                   	push   %ebp
  801652:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 0c                	push   $0xc
  801660:	e8 67 fe ff ff       	call   8014cc <syscall>
  801665:	83 c4 18             	add    $0x18,%esp
}
  801668:	c9                   	leave  
  801669:	c3                   	ret    

0080166a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80166a:	55                   	push   %ebp
  80166b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 0d                	push   $0xd
  801679:	e8 4e fe ff ff       	call   8014cc <syscall>
  80167e:	83 c4 18             	add    $0x18,%esp
}
  801681:	c9                   	leave  
  801682:	c3                   	ret    

00801683 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801683:	55                   	push   %ebp
  801684:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	ff 75 0c             	pushl  0xc(%ebp)
  80168f:	ff 75 08             	pushl  0x8(%ebp)
  801692:	6a 11                	push   $0x11
  801694:	e8 33 fe ff ff       	call   8014cc <syscall>
  801699:	83 c4 18             	add    $0x18,%esp
	return;
  80169c:	90                   	nop
}
  80169d:	c9                   	leave  
  80169e:	c3                   	ret    

0080169f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80169f:	55                   	push   %ebp
  8016a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	ff 75 0c             	pushl  0xc(%ebp)
  8016ab:	ff 75 08             	pushl  0x8(%ebp)
  8016ae:	6a 12                	push   $0x12
  8016b0:	e8 17 fe ff ff       	call   8014cc <syscall>
  8016b5:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b8:	90                   	nop
}
  8016b9:	c9                   	leave  
  8016ba:	c3                   	ret    

008016bb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016bb:	55                   	push   %ebp
  8016bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 0e                	push   $0xe
  8016ca:	e8 fd fd ff ff       	call   8014cc <syscall>
  8016cf:	83 c4 18             	add    $0x18,%esp
}
  8016d2:	c9                   	leave  
  8016d3:	c3                   	ret    

008016d4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016d4:	55                   	push   %ebp
  8016d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	ff 75 08             	pushl  0x8(%ebp)
  8016e2:	6a 0f                	push   $0xf
  8016e4:	e8 e3 fd ff ff       	call   8014cc <syscall>
  8016e9:	83 c4 18             	add    $0x18,%esp
}
  8016ec:	c9                   	leave  
  8016ed:	c3                   	ret    

008016ee <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 10                	push   $0x10
  8016fd:	e8 ca fd ff ff       	call   8014cc <syscall>
  801702:	83 c4 18             	add    $0x18,%esp
}
  801705:	90                   	nop
  801706:	c9                   	leave  
  801707:	c3                   	ret    

00801708 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801708:	55                   	push   %ebp
  801709:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 14                	push   $0x14
  801717:	e8 b0 fd ff ff       	call   8014cc <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
}
  80171f:	90                   	nop
  801720:	c9                   	leave  
  801721:	c3                   	ret    

00801722 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801722:	55                   	push   %ebp
  801723:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 15                	push   $0x15
  801731:	e8 96 fd ff ff       	call   8014cc <syscall>
  801736:	83 c4 18             	add    $0x18,%esp
}
  801739:	90                   	nop
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <sys_cputc>:


void
sys_cputc(const char c)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
  80173f:	83 ec 04             	sub    $0x4,%esp
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801748:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	50                   	push   %eax
  801755:	6a 16                	push   $0x16
  801757:	e8 70 fd ff ff       	call   8014cc <syscall>
  80175c:	83 c4 18             	add    $0x18,%esp
}
  80175f:	90                   	nop
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 17                	push   $0x17
  801771:	e8 56 fd ff ff       	call   8014cc <syscall>
  801776:	83 c4 18             	add    $0x18,%esp
}
  801779:	90                   	nop
  80177a:	c9                   	leave  
  80177b:	c3                   	ret    

0080177c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80177c:	55                   	push   %ebp
  80177d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	ff 75 0c             	pushl  0xc(%ebp)
  80178b:	50                   	push   %eax
  80178c:	6a 18                	push   $0x18
  80178e:	e8 39 fd ff ff       	call   8014cc <syscall>
  801793:	83 c4 18             	add    $0x18,%esp
}
  801796:	c9                   	leave  
  801797:	c3                   	ret    

00801798 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801798:	55                   	push   %ebp
  801799:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80179b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179e:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	52                   	push   %edx
  8017a8:	50                   	push   %eax
  8017a9:	6a 1b                	push   $0x1b
  8017ab:	e8 1c fd ff ff       	call   8014cc <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
}
  8017b3:	c9                   	leave  
  8017b4:	c3                   	ret    

008017b5 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017b5:	55                   	push   %ebp
  8017b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	52                   	push   %edx
  8017c5:	50                   	push   %eax
  8017c6:	6a 19                	push   $0x19
  8017c8:	e8 ff fc ff ff       	call   8014cc <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
}
  8017d0:	90                   	nop
  8017d1:	c9                   	leave  
  8017d2:	c3                   	ret    

008017d3 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017d3:	55                   	push   %ebp
  8017d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	52                   	push   %edx
  8017e3:	50                   	push   %eax
  8017e4:	6a 1a                	push   $0x1a
  8017e6:	e8 e1 fc ff ff       	call   8014cc <syscall>
  8017eb:	83 c4 18             	add    $0x18,%esp
}
  8017ee:	90                   	nop
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
  8017f4:	83 ec 04             	sub    $0x4,%esp
  8017f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8017fa:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8017fd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801800:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801804:	8b 45 08             	mov    0x8(%ebp),%eax
  801807:	6a 00                	push   $0x0
  801809:	51                   	push   %ecx
  80180a:	52                   	push   %edx
  80180b:	ff 75 0c             	pushl  0xc(%ebp)
  80180e:	50                   	push   %eax
  80180f:	6a 1c                	push   $0x1c
  801811:	e8 b6 fc ff ff       	call   8014cc <syscall>
  801816:	83 c4 18             	add    $0x18,%esp
}
  801819:	c9                   	leave  
  80181a:	c3                   	ret    

0080181b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80181b:	55                   	push   %ebp
  80181c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80181e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801821:	8b 45 08             	mov    0x8(%ebp),%eax
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	52                   	push   %edx
  80182b:	50                   	push   %eax
  80182c:	6a 1d                	push   $0x1d
  80182e:	e8 99 fc ff ff       	call   8014cc <syscall>
  801833:	83 c4 18             	add    $0x18,%esp
}
  801836:	c9                   	leave  
  801837:	c3                   	ret    

00801838 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801838:	55                   	push   %ebp
  801839:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80183b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80183e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801841:	8b 45 08             	mov    0x8(%ebp),%eax
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	51                   	push   %ecx
  801849:	52                   	push   %edx
  80184a:	50                   	push   %eax
  80184b:	6a 1e                	push   $0x1e
  80184d:	e8 7a fc ff ff       	call   8014cc <syscall>
  801852:	83 c4 18             	add    $0x18,%esp
}
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80185a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	52                   	push   %edx
  801867:	50                   	push   %eax
  801868:	6a 1f                	push   $0x1f
  80186a:	e8 5d fc ff ff       	call   8014cc <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
}
  801872:	c9                   	leave  
  801873:	c3                   	ret    

00801874 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801874:	55                   	push   %ebp
  801875:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 20                	push   $0x20
  801883:	e8 44 fc ff ff       	call   8014cc <syscall>
  801888:	83 c4 18             	add    $0x18,%esp
}
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801890:	8b 45 08             	mov    0x8(%ebp),%eax
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	ff 75 10             	pushl  0x10(%ebp)
  80189a:	ff 75 0c             	pushl  0xc(%ebp)
  80189d:	50                   	push   %eax
  80189e:	6a 21                	push   $0x21
  8018a0:	e8 27 fc ff ff       	call   8014cc <syscall>
  8018a5:	83 c4 18             	add    $0x18,%esp
}
  8018a8:	c9                   	leave  
  8018a9:	c3                   	ret    

008018aa <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8018aa:	55                   	push   %ebp
  8018ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	50                   	push   %eax
  8018b9:	6a 22                	push   $0x22
  8018bb:	e8 0c fc ff ff       	call   8014cc <syscall>
  8018c0:	83 c4 18             	add    $0x18,%esp
}
  8018c3:	90                   	nop
  8018c4:	c9                   	leave  
  8018c5:	c3                   	ret    

008018c6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018c6:	55                   	push   %ebp
  8018c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	50                   	push   %eax
  8018d5:	6a 23                	push   $0x23
  8018d7:	e8 f0 fb ff ff       	call   8014cc <syscall>
  8018dc:	83 c4 18             	add    $0x18,%esp
}
  8018df:	90                   	nop
  8018e0:	c9                   	leave  
  8018e1:	c3                   	ret    

008018e2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8018e2:	55                   	push   %ebp
  8018e3:	89 e5                	mov    %esp,%ebp
  8018e5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8018e8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018eb:	8d 50 04             	lea    0x4(%eax),%edx
  8018ee:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	52                   	push   %edx
  8018f8:	50                   	push   %eax
  8018f9:	6a 24                	push   $0x24
  8018fb:	e8 cc fb ff ff       	call   8014cc <syscall>
  801900:	83 c4 18             	add    $0x18,%esp
	return result;
  801903:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801906:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801909:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80190c:	89 01                	mov    %eax,(%ecx)
  80190e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	c9                   	leave  
  801915:	c2 04 00             	ret    $0x4

00801918 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801918:	55                   	push   %ebp
  801919:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	ff 75 10             	pushl  0x10(%ebp)
  801922:	ff 75 0c             	pushl  0xc(%ebp)
  801925:	ff 75 08             	pushl  0x8(%ebp)
  801928:	6a 13                	push   $0x13
  80192a:	e8 9d fb ff ff       	call   8014cc <syscall>
  80192f:	83 c4 18             	add    $0x18,%esp
	return ;
  801932:	90                   	nop
}
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <sys_rcr2>:
uint32 sys_rcr2()
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 25                	push   $0x25
  801944:	e8 83 fb ff ff       	call   8014cc <syscall>
  801949:	83 c4 18             	add    $0x18,%esp
}
  80194c:	c9                   	leave  
  80194d:	c3                   	ret    

0080194e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80194e:	55                   	push   %ebp
  80194f:	89 e5                	mov    %esp,%ebp
  801951:	83 ec 04             	sub    $0x4,%esp
  801954:	8b 45 08             	mov    0x8(%ebp),%eax
  801957:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80195a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	50                   	push   %eax
  801967:	6a 26                	push   $0x26
  801969:	e8 5e fb ff ff       	call   8014cc <syscall>
  80196e:	83 c4 18             	add    $0x18,%esp
	return ;
  801971:	90                   	nop
}
  801972:	c9                   	leave  
  801973:	c3                   	ret    

00801974 <rsttst>:
void rsttst()
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 28                	push   $0x28
  801983:	e8 44 fb ff ff       	call   8014cc <syscall>
  801988:	83 c4 18             	add    $0x18,%esp
	return ;
  80198b:	90                   	nop
}
  80198c:	c9                   	leave  
  80198d:	c3                   	ret    

0080198e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80198e:	55                   	push   %ebp
  80198f:	89 e5                	mov    %esp,%ebp
  801991:	83 ec 04             	sub    $0x4,%esp
  801994:	8b 45 14             	mov    0x14(%ebp),%eax
  801997:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80199a:	8b 55 18             	mov    0x18(%ebp),%edx
  80199d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019a1:	52                   	push   %edx
  8019a2:	50                   	push   %eax
  8019a3:	ff 75 10             	pushl  0x10(%ebp)
  8019a6:	ff 75 0c             	pushl  0xc(%ebp)
  8019a9:	ff 75 08             	pushl  0x8(%ebp)
  8019ac:	6a 27                	push   $0x27
  8019ae:	e8 19 fb ff ff       	call   8014cc <syscall>
  8019b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8019b6:	90                   	nop
}
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <chktst>:
void chktst(uint32 n)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	ff 75 08             	pushl  0x8(%ebp)
  8019c7:	6a 29                	push   $0x29
  8019c9:	e8 fe fa ff ff       	call   8014cc <syscall>
  8019ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8019d1:	90                   	nop
}
  8019d2:	c9                   	leave  
  8019d3:	c3                   	ret    

008019d4 <inctst>:

void inctst()
{
  8019d4:	55                   	push   %ebp
  8019d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 2a                	push   $0x2a
  8019e3:	e8 e4 fa ff ff       	call   8014cc <syscall>
  8019e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8019eb:	90                   	nop
}
  8019ec:	c9                   	leave  
  8019ed:	c3                   	ret    

008019ee <gettst>:
uint32 gettst()
{
  8019ee:	55                   	push   %ebp
  8019ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 2b                	push   $0x2b
  8019fd:	e8 ca fa ff ff       	call   8014cc <syscall>
  801a02:	83 c4 18             	add    $0x18,%esp
}
  801a05:	c9                   	leave  
  801a06:	c3                   	ret    

00801a07 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a07:	55                   	push   %ebp
  801a08:	89 e5                	mov    %esp,%ebp
  801a0a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 2c                	push   $0x2c
  801a19:	e8 ae fa ff ff       	call   8014cc <syscall>
  801a1e:	83 c4 18             	add    $0x18,%esp
  801a21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a24:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a28:	75 07                	jne    801a31 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2f:	eb 05                	jmp    801a36 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a31:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a36:	c9                   	leave  
  801a37:	c3                   	ret    

00801a38 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
  801a3b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	6a 2c                	push   $0x2c
  801a4a:	e8 7d fa ff ff       	call   8014cc <syscall>
  801a4f:	83 c4 18             	add    $0x18,%esp
  801a52:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a55:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a59:	75 07                	jne    801a62 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a5b:	b8 01 00 00 00       	mov    $0x1,%eax
  801a60:	eb 05                	jmp    801a67 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a62:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a67:	c9                   	leave  
  801a68:	c3                   	ret    

00801a69 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a69:	55                   	push   %ebp
  801a6a:	89 e5                	mov    %esp,%ebp
  801a6c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	6a 2c                	push   $0x2c
  801a7b:	e8 4c fa ff ff       	call   8014cc <syscall>
  801a80:	83 c4 18             	add    $0x18,%esp
  801a83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a86:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a8a:	75 07                	jne    801a93 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a8c:	b8 01 00 00 00       	mov    $0x1,%eax
  801a91:	eb 05                	jmp    801a98 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a93:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a98:	c9                   	leave  
  801a99:	c3                   	ret    

00801a9a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a9a:	55                   	push   %ebp
  801a9b:	89 e5                	mov    %esp,%ebp
  801a9d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 2c                	push   $0x2c
  801aac:	e8 1b fa ff ff       	call   8014cc <syscall>
  801ab1:	83 c4 18             	add    $0x18,%esp
  801ab4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ab7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801abb:	75 07                	jne    801ac4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801abd:	b8 01 00 00 00       	mov    $0x1,%eax
  801ac2:	eb 05                	jmp    801ac9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ac4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ac9:	c9                   	leave  
  801aca:	c3                   	ret    

00801acb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801acb:	55                   	push   %ebp
  801acc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	ff 75 08             	pushl  0x8(%ebp)
  801ad9:	6a 2d                	push   $0x2d
  801adb:	e8 ec f9 ff ff       	call   8014cc <syscall>
  801ae0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ae3:	90                   	nop
}
  801ae4:	c9                   	leave  
  801ae5:	c3                   	ret    

00801ae6 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801ae6:	55                   	push   %ebp
  801ae7:	89 e5                	mov    %esp,%ebp
  801ae9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801aec:	8d 45 10             	lea    0x10(%ebp),%eax
  801aef:	83 c0 04             	add    $0x4,%eax
  801af2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801af5:	a1 40 50 88 00       	mov    0x885040,%eax
  801afa:	85 c0                	test   %eax,%eax
  801afc:	74 16                	je     801b14 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801afe:	a1 40 50 88 00       	mov    0x885040,%eax
  801b03:	83 ec 08             	sub    $0x8,%esp
  801b06:	50                   	push   %eax
  801b07:	68 60 24 80 00       	push   $0x802460
  801b0c:	e8 28 ea ff ff       	call   800539 <cprintf>
  801b11:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801b14:	a1 00 30 80 00       	mov    0x803000,%eax
  801b19:	ff 75 0c             	pushl  0xc(%ebp)
  801b1c:	ff 75 08             	pushl  0x8(%ebp)
  801b1f:	50                   	push   %eax
  801b20:	68 65 24 80 00       	push   $0x802465
  801b25:	e8 0f ea ff ff       	call   800539 <cprintf>
  801b2a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801b2d:	8b 45 10             	mov    0x10(%ebp),%eax
  801b30:	83 ec 08             	sub    $0x8,%esp
  801b33:	ff 75 f4             	pushl  -0xc(%ebp)
  801b36:	50                   	push   %eax
  801b37:	e8 92 e9 ff ff       	call   8004ce <vcprintf>
  801b3c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801b3f:	83 ec 08             	sub    $0x8,%esp
  801b42:	6a 00                	push   $0x0
  801b44:	68 81 24 80 00       	push   $0x802481
  801b49:	e8 80 e9 ff ff       	call   8004ce <vcprintf>
  801b4e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801b51:	e8 01 e9 ff ff       	call   800457 <exit>

	// should not return here
	while (1) ;
  801b56:	eb fe                	jmp    801b56 <_panic+0x70>

00801b58 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801b58:	55                   	push   %ebp
  801b59:	89 e5                	mov    %esp,%ebp
  801b5b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801b5e:	a1 20 30 80 00       	mov    0x803020,%eax
  801b63:	8b 50 74             	mov    0x74(%eax),%edx
  801b66:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b69:	39 c2                	cmp    %eax,%edx
  801b6b:	74 14                	je     801b81 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801b6d:	83 ec 04             	sub    $0x4,%esp
  801b70:	68 84 24 80 00       	push   $0x802484
  801b75:	6a 26                	push   $0x26
  801b77:	68 d0 24 80 00       	push   $0x8024d0
  801b7c:	e8 65 ff ff ff       	call   801ae6 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801b81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801b88:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b8f:	e9 c2 00 00 00       	jmp    801c56 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801b94:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b97:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba1:	01 d0                	add    %edx,%eax
  801ba3:	8b 00                	mov    (%eax),%eax
  801ba5:	85 c0                	test   %eax,%eax
  801ba7:	75 08                	jne    801bb1 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801ba9:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801bac:	e9 a2 00 00 00       	jmp    801c53 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801bb1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bb8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801bbf:	eb 69                	jmp    801c2a <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801bc1:	a1 20 30 80 00       	mov    0x803020,%eax
  801bc6:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801bcc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801bcf:	89 d0                	mov    %edx,%eax
  801bd1:	01 c0                	add    %eax,%eax
  801bd3:	01 d0                	add    %edx,%eax
  801bd5:	c1 e0 02             	shl    $0x2,%eax
  801bd8:	01 c8                	add    %ecx,%eax
  801bda:	8a 40 04             	mov    0x4(%eax),%al
  801bdd:	84 c0                	test   %al,%al
  801bdf:	75 46                	jne    801c27 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801be1:	a1 20 30 80 00       	mov    0x803020,%eax
  801be6:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801bec:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801bef:	89 d0                	mov    %edx,%eax
  801bf1:	01 c0                	add    %eax,%eax
  801bf3:	01 d0                	add    %edx,%eax
  801bf5:	c1 e0 02             	shl    $0x2,%eax
  801bf8:	01 c8                	add    %ecx,%eax
  801bfa:	8b 00                	mov    (%eax),%eax
  801bfc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801bff:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c02:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c07:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801c09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c0c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801c13:	8b 45 08             	mov    0x8(%ebp),%eax
  801c16:	01 c8                	add    %ecx,%eax
  801c18:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c1a:	39 c2                	cmp    %eax,%edx
  801c1c:	75 09                	jne    801c27 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801c1e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801c25:	eb 12                	jmp    801c39 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c27:	ff 45 e8             	incl   -0x18(%ebp)
  801c2a:	a1 20 30 80 00       	mov    0x803020,%eax
  801c2f:	8b 50 74             	mov    0x74(%eax),%edx
  801c32:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c35:	39 c2                	cmp    %eax,%edx
  801c37:	77 88                	ja     801bc1 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801c39:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801c3d:	75 14                	jne    801c53 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801c3f:	83 ec 04             	sub    $0x4,%esp
  801c42:	68 dc 24 80 00       	push   $0x8024dc
  801c47:	6a 3a                	push   $0x3a
  801c49:	68 d0 24 80 00       	push   $0x8024d0
  801c4e:	e8 93 fe ff ff       	call   801ae6 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801c53:	ff 45 f0             	incl   -0x10(%ebp)
  801c56:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c59:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801c5c:	0f 8c 32 ff ff ff    	jl     801b94 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801c62:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c69:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801c70:	eb 26                	jmp    801c98 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801c72:	a1 20 30 80 00       	mov    0x803020,%eax
  801c77:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801c7d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c80:	89 d0                	mov    %edx,%eax
  801c82:	01 c0                	add    %eax,%eax
  801c84:	01 d0                	add    %edx,%eax
  801c86:	c1 e0 02             	shl    $0x2,%eax
  801c89:	01 c8                	add    %ecx,%eax
  801c8b:	8a 40 04             	mov    0x4(%eax),%al
  801c8e:	3c 01                	cmp    $0x1,%al
  801c90:	75 03                	jne    801c95 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801c92:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c95:	ff 45 e0             	incl   -0x20(%ebp)
  801c98:	a1 20 30 80 00       	mov    0x803020,%eax
  801c9d:	8b 50 74             	mov    0x74(%eax),%edx
  801ca0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ca3:	39 c2                	cmp    %eax,%edx
  801ca5:	77 cb                	ja     801c72 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801ca7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801caa:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801cad:	74 14                	je     801cc3 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801caf:	83 ec 04             	sub    $0x4,%esp
  801cb2:	68 30 25 80 00       	push   $0x802530
  801cb7:	6a 44                	push   $0x44
  801cb9:	68 d0 24 80 00       	push   $0x8024d0
  801cbe:	e8 23 fe ff ff       	call   801ae6 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801cc3:	90                   	nop
  801cc4:	c9                   	leave  
  801cc5:	c3                   	ret    
  801cc6:	66 90                	xchg   %ax,%ax

00801cc8 <__udivdi3>:
  801cc8:	55                   	push   %ebp
  801cc9:	57                   	push   %edi
  801cca:	56                   	push   %esi
  801ccb:	53                   	push   %ebx
  801ccc:	83 ec 1c             	sub    $0x1c,%esp
  801ccf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801cd3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801cd7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cdb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801cdf:	89 ca                	mov    %ecx,%edx
  801ce1:	89 f8                	mov    %edi,%eax
  801ce3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ce7:	85 f6                	test   %esi,%esi
  801ce9:	75 2d                	jne    801d18 <__udivdi3+0x50>
  801ceb:	39 cf                	cmp    %ecx,%edi
  801ced:	77 65                	ja     801d54 <__udivdi3+0x8c>
  801cef:	89 fd                	mov    %edi,%ebp
  801cf1:	85 ff                	test   %edi,%edi
  801cf3:	75 0b                	jne    801d00 <__udivdi3+0x38>
  801cf5:	b8 01 00 00 00       	mov    $0x1,%eax
  801cfa:	31 d2                	xor    %edx,%edx
  801cfc:	f7 f7                	div    %edi
  801cfe:	89 c5                	mov    %eax,%ebp
  801d00:	31 d2                	xor    %edx,%edx
  801d02:	89 c8                	mov    %ecx,%eax
  801d04:	f7 f5                	div    %ebp
  801d06:	89 c1                	mov    %eax,%ecx
  801d08:	89 d8                	mov    %ebx,%eax
  801d0a:	f7 f5                	div    %ebp
  801d0c:	89 cf                	mov    %ecx,%edi
  801d0e:	89 fa                	mov    %edi,%edx
  801d10:	83 c4 1c             	add    $0x1c,%esp
  801d13:	5b                   	pop    %ebx
  801d14:	5e                   	pop    %esi
  801d15:	5f                   	pop    %edi
  801d16:	5d                   	pop    %ebp
  801d17:	c3                   	ret    
  801d18:	39 ce                	cmp    %ecx,%esi
  801d1a:	77 28                	ja     801d44 <__udivdi3+0x7c>
  801d1c:	0f bd fe             	bsr    %esi,%edi
  801d1f:	83 f7 1f             	xor    $0x1f,%edi
  801d22:	75 40                	jne    801d64 <__udivdi3+0x9c>
  801d24:	39 ce                	cmp    %ecx,%esi
  801d26:	72 0a                	jb     801d32 <__udivdi3+0x6a>
  801d28:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d2c:	0f 87 9e 00 00 00    	ja     801dd0 <__udivdi3+0x108>
  801d32:	b8 01 00 00 00       	mov    $0x1,%eax
  801d37:	89 fa                	mov    %edi,%edx
  801d39:	83 c4 1c             	add    $0x1c,%esp
  801d3c:	5b                   	pop    %ebx
  801d3d:	5e                   	pop    %esi
  801d3e:	5f                   	pop    %edi
  801d3f:	5d                   	pop    %ebp
  801d40:	c3                   	ret    
  801d41:	8d 76 00             	lea    0x0(%esi),%esi
  801d44:	31 ff                	xor    %edi,%edi
  801d46:	31 c0                	xor    %eax,%eax
  801d48:	89 fa                	mov    %edi,%edx
  801d4a:	83 c4 1c             	add    $0x1c,%esp
  801d4d:	5b                   	pop    %ebx
  801d4e:	5e                   	pop    %esi
  801d4f:	5f                   	pop    %edi
  801d50:	5d                   	pop    %ebp
  801d51:	c3                   	ret    
  801d52:	66 90                	xchg   %ax,%ax
  801d54:	89 d8                	mov    %ebx,%eax
  801d56:	f7 f7                	div    %edi
  801d58:	31 ff                	xor    %edi,%edi
  801d5a:	89 fa                	mov    %edi,%edx
  801d5c:	83 c4 1c             	add    $0x1c,%esp
  801d5f:	5b                   	pop    %ebx
  801d60:	5e                   	pop    %esi
  801d61:	5f                   	pop    %edi
  801d62:	5d                   	pop    %ebp
  801d63:	c3                   	ret    
  801d64:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d69:	89 eb                	mov    %ebp,%ebx
  801d6b:	29 fb                	sub    %edi,%ebx
  801d6d:	89 f9                	mov    %edi,%ecx
  801d6f:	d3 e6                	shl    %cl,%esi
  801d71:	89 c5                	mov    %eax,%ebp
  801d73:	88 d9                	mov    %bl,%cl
  801d75:	d3 ed                	shr    %cl,%ebp
  801d77:	89 e9                	mov    %ebp,%ecx
  801d79:	09 f1                	or     %esi,%ecx
  801d7b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d7f:	89 f9                	mov    %edi,%ecx
  801d81:	d3 e0                	shl    %cl,%eax
  801d83:	89 c5                	mov    %eax,%ebp
  801d85:	89 d6                	mov    %edx,%esi
  801d87:	88 d9                	mov    %bl,%cl
  801d89:	d3 ee                	shr    %cl,%esi
  801d8b:	89 f9                	mov    %edi,%ecx
  801d8d:	d3 e2                	shl    %cl,%edx
  801d8f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d93:	88 d9                	mov    %bl,%cl
  801d95:	d3 e8                	shr    %cl,%eax
  801d97:	09 c2                	or     %eax,%edx
  801d99:	89 d0                	mov    %edx,%eax
  801d9b:	89 f2                	mov    %esi,%edx
  801d9d:	f7 74 24 0c          	divl   0xc(%esp)
  801da1:	89 d6                	mov    %edx,%esi
  801da3:	89 c3                	mov    %eax,%ebx
  801da5:	f7 e5                	mul    %ebp
  801da7:	39 d6                	cmp    %edx,%esi
  801da9:	72 19                	jb     801dc4 <__udivdi3+0xfc>
  801dab:	74 0b                	je     801db8 <__udivdi3+0xf0>
  801dad:	89 d8                	mov    %ebx,%eax
  801daf:	31 ff                	xor    %edi,%edi
  801db1:	e9 58 ff ff ff       	jmp    801d0e <__udivdi3+0x46>
  801db6:	66 90                	xchg   %ax,%ax
  801db8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801dbc:	89 f9                	mov    %edi,%ecx
  801dbe:	d3 e2                	shl    %cl,%edx
  801dc0:	39 c2                	cmp    %eax,%edx
  801dc2:	73 e9                	jae    801dad <__udivdi3+0xe5>
  801dc4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dc7:	31 ff                	xor    %edi,%edi
  801dc9:	e9 40 ff ff ff       	jmp    801d0e <__udivdi3+0x46>
  801dce:	66 90                	xchg   %ax,%ax
  801dd0:	31 c0                	xor    %eax,%eax
  801dd2:	e9 37 ff ff ff       	jmp    801d0e <__udivdi3+0x46>
  801dd7:	90                   	nop

00801dd8 <__umoddi3>:
  801dd8:	55                   	push   %ebp
  801dd9:	57                   	push   %edi
  801dda:	56                   	push   %esi
  801ddb:	53                   	push   %ebx
  801ddc:	83 ec 1c             	sub    $0x1c,%esp
  801ddf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801de3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801de7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801deb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801def:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801df3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801df7:	89 f3                	mov    %esi,%ebx
  801df9:	89 fa                	mov    %edi,%edx
  801dfb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801dff:	89 34 24             	mov    %esi,(%esp)
  801e02:	85 c0                	test   %eax,%eax
  801e04:	75 1a                	jne    801e20 <__umoddi3+0x48>
  801e06:	39 f7                	cmp    %esi,%edi
  801e08:	0f 86 a2 00 00 00    	jbe    801eb0 <__umoddi3+0xd8>
  801e0e:	89 c8                	mov    %ecx,%eax
  801e10:	89 f2                	mov    %esi,%edx
  801e12:	f7 f7                	div    %edi
  801e14:	89 d0                	mov    %edx,%eax
  801e16:	31 d2                	xor    %edx,%edx
  801e18:	83 c4 1c             	add    $0x1c,%esp
  801e1b:	5b                   	pop    %ebx
  801e1c:	5e                   	pop    %esi
  801e1d:	5f                   	pop    %edi
  801e1e:	5d                   	pop    %ebp
  801e1f:	c3                   	ret    
  801e20:	39 f0                	cmp    %esi,%eax
  801e22:	0f 87 ac 00 00 00    	ja     801ed4 <__umoddi3+0xfc>
  801e28:	0f bd e8             	bsr    %eax,%ebp
  801e2b:	83 f5 1f             	xor    $0x1f,%ebp
  801e2e:	0f 84 ac 00 00 00    	je     801ee0 <__umoddi3+0x108>
  801e34:	bf 20 00 00 00       	mov    $0x20,%edi
  801e39:	29 ef                	sub    %ebp,%edi
  801e3b:	89 fe                	mov    %edi,%esi
  801e3d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e41:	89 e9                	mov    %ebp,%ecx
  801e43:	d3 e0                	shl    %cl,%eax
  801e45:	89 d7                	mov    %edx,%edi
  801e47:	89 f1                	mov    %esi,%ecx
  801e49:	d3 ef                	shr    %cl,%edi
  801e4b:	09 c7                	or     %eax,%edi
  801e4d:	89 e9                	mov    %ebp,%ecx
  801e4f:	d3 e2                	shl    %cl,%edx
  801e51:	89 14 24             	mov    %edx,(%esp)
  801e54:	89 d8                	mov    %ebx,%eax
  801e56:	d3 e0                	shl    %cl,%eax
  801e58:	89 c2                	mov    %eax,%edx
  801e5a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e5e:	d3 e0                	shl    %cl,%eax
  801e60:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e64:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e68:	89 f1                	mov    %esi,%ecx
  801e6a:	d3 e8                	shr    %cl,%eax
  801e6c:	09 d0                	or     %edx,%eax
  801e6e:	d3 eb                	shr    %cl,%ebx
  801e70:	89 da                	mov    %ebx,%edx
  801e72:	f7 f7                	div    %edi
  801e74:	89 d3                	mov    %edx,%ebx
  801e76:	f7 24 24             	mull   (%esp)
  801e79:	89 c6                	mov    %eax,%esi
  801e7b:	89 d1                	mov    %edx,%ecx
  801e7d:	39 d3                	cmp    %edx,%ebx
  801e7f:	0f 82 87 00 00 00    	jb     801f0c <__umoddi3+0x134>
  801e85:	0f 84 91 00 00 00    	je     801f1c <__umoddi3+0x144>
  801e8b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e8f:	29 f2                	sub    %esi,%edx
  801e91:	19 cb                	sbb    %ecx,%ebx
  801e93:	89 d8                	mov    %ebx,%eax
  801e95:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e99:	d3 e0                	shl    %cl,%eax
  801e9b:	89 e9                	mov    %ebp,%ecx
  801e9d:	d3 ea                	shr    %cl,%edx
  801e9f:	09 d0                	or     %edx,%eax
  801ea1:	89 e9                	mov    %ebp,%ecx
  801ea3:	d3 eb                	shr    %cl,%ebx
  801ea5:	89 da                	mov    %ebx,%edx
  801ea7:	83 c4 1c             	add    $0x1c,%esp
  801eaa:	5b                   	pop    %ebx
  801eab:	5e                   	pop    %esi
  801eac:	5f                   	pop    %edi
  801ead:	5d                   	pop    %ebp
  801eae:	c3                   	ret    
  801eaf:	90                   	nop
  801eb0:	89 fd                	mov    %edi,%ebp
  801eb2:	85 ff                	test   %edi,%edi
  801eb4:	75 0b                	jne    801ec1 <__umoddi3+0xe9>
  801eb6:	b8 01 00 00 00       	mov    $0x1,%eax
  801ebb:	31 d2                	xor    %edx,%edx
  801ebd:	f7 f7                	div    %edi
  801ebf:	89 c5                	mov    %eax,%ebp
  801ec1:	89 f0                	mov    %esi,%eax
  801ec3:	31 d2                	xor    %edx,%edx
  801ec5:	f7 f5                	div    %ebp
  801ec7:	89 c8                	mov    %ecx,%eax
  801ec9:	f7 f5                	div    %ebp
  801ecb:	89 d0                	mov    %edx,%eax
  801ecd:	e9 44 ff ff ff       	jmp    801e16 <__umoddi3+0x3e>
  801ed2:	66 90                	xchg   %ax,%ax
  801ed4:	89 c8                	mov    %ecx,%eax
  801ed6:	89 f2                	mov    %esi,%edx
  801ed8:	83 c4 1c             	add    $0x1c,%esp
  801edb:	5b                   	pop    %ebx
  801edc:	5e                   	pop    %esi
  801edd:	5f                   	pop    %edi
  801ede:	5d                   	pop    %ebp
  801edf:	c3                   	ret    
  801ee0:	3b 04 24             	cmp    (%esp),%eax
  801ee3:	72 06                	jb     801eeb <__umoddi3+0x113>
  801ee5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ee9:	77 0f                	ja     801efa <__umoddi3+0x122>
  801eeb:	89 f2                	mov    %esi,%edx
  801eed:	29 f9                	sub    %edi,%ecx
  801eef:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ef3:	89 14 24             	mov    %edx,(%esp)
  801ef6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801efa:	8b 44 24 04          	mov    0x4(%esp),%eax
  801efe:	8b 14 24             	mov    (%esp),%edx
  801f01:	83 c4 1c             	add    $0x1c,%esp
  801f04:	5b                   	pop    %ebx
  801f05:	5e                   	pop    %esi
  801f06:	5f                   	pop    %edi
  801f07:	5d                   	pop    %ebp
  801f08:	c3                   	ret    
  801f09:	8d 76 00             	lea    0x0(%esi),%esi
  801f0c:	2b 04 24             	sub    (%esp),%eax
  801f0f:	19 fa                	sbb    %edi,%edx
  801f11:	89 d1                	mov    %edx,%ecx
  801f13:	89 c6                	mov    %eax,%esi
  801f15:	e9 71 ff ff ff       	jmp    801e8b <__umoddi3+0xb3>
  801f1a:	66 90                	xchg   %ax,%ax
  801f1c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f20:	72 ea                	jb     801f0c <__umoddi3+0x134>
  801f22:	89 d9                	mov    %ebx,%ecx
  801f24:	e9 62 ff ff ff       	jmp    801e8b <__umoddi3+0xb3>
