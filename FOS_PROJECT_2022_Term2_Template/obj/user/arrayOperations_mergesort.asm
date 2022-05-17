
obj/user/arrayOperations_mergesort:     file format elf32-i386


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
  800031:	e8 3d 04 00 00       	call   800473 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

//int *Left;
//int *Right;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int32 parentenvID = sys_getparentenvid();
  80003e:	e8 93 17 00 00       	call   8017d6 <sys_getparentenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int ret;
	/*[1] GET SHARED VARs*/
	//Get the shared array & its size
	int *numOfElements = NULL;
  800046:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int *sharedArray = NULL;
  80004d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	sharedArray = sget(parentenvID, "arr") ;
  800054:	83 ec 08             	sub    $0x8,%esp
  800057:	68 80 21 80 00       	push   $0x802180
  80005c:	ff 75 f0             	pushl  -0x10(%ebp)
  80005f:	e8 d2 15 00 00       	call   801636 <sget>
  800064:	83 c4 10             	add    $0x10,%esp
  800067:	89 45 e8             	mov    %eax,-0x18(%ebp)
	numOfElements = sget(parentenvID, "arrSize") ;
  80006a:	83 ec 08             	sub    $0x8,%esp
  80006d:	68 84 21 80 00       	push   $0x802184
  800072:	ff 75 f0             	pushl  -0x10(%ebp)
  800075:	e8 bc 15 00 00       	call   801636 <sget>
  80007a:	83 c4 10             	add    $0x10,%esp
  80007d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	//PrintElements(sharedArray, *numOfElements);

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800080:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	finishedCount = sget(parentenvID, "finishedCount") ;
  800087:	83 ec 08             	sub    $0x8,%esp
  80008a:	68 8c 21 80 00       	push   $0x80218c
  80008f:	ff 75 f0             	pushl  -0x10(%ebp)
  800092:	e8 9f 15 00 00       	call   801636 <sget>
  800097:	83 c4 10             	add    $0x10,%esp
  80009a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("mergesortedArr", sizeof(int) * *numOfElements, 0) ;
  80009d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000a0:	8b 00                	mov    (%eax),%eax
  8000a2:	c1 e0 02             	shl    $0x2,%eax
  8000a5:	83 ec 04             	sub    $0x4,%esp
  8000a8:	6a 00                	push   $0x0
  8000aa:	50                   	push   %eax
  8000ab:	68 9a 21 80 00       	push   $0x80219a
  8000b0:	e8 61 15 00 00       	call   801616 <smalloc>
  8000b5:	83 c4 10             	add    $0x10,%esp
  8000b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000c2:	eb 25                	jmp    8000e9 <_main+0xb1>
	{
		sortedArray[i] = sharedArray[i];
  8000c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000d1:	01 c2                	add    %eax,%edx
  8000d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000d6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e0:	01 c8                	add    %ecx,%eax
  8000e2:	8b 00                	mov    (%eax),%eax
  8000e4:	89 02                	mov    %eax,(%edx)
	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("mergesortedArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000e6:	ff 45 f4             	incl   -0xc(%ebp)
  8000e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f1:	7f d1                	jg     8000c4 <_main+0x8c>
	}
//	//Create two temps array for "left" & "right"
//	Left = smalloc("mergesortLeftArr", sizeof(int) * (*numOfElements), 1) ;
//	Right = smalloc("mergesortRightArr", sizeof(int) * (*numOfElements), 1) ;

	MSort(sortedArray, 1, *numOfElements);
  8000f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000f6:	8b 00                	mov    (%eax),%eax
  8000f8:	83 ec 04             	sub    $0x4,%esp
  8000fb:	50                   	push   %eax
  8000fc:	6a 01                	push   $0x1
  8000fe:	ff 75 e0             	pushl  -0x20(%ebp)
  800101:	e8 fc 00 00 00       	call   800202 <MSort>
  800106:	83 c4 10             	add    $0x10,%esp
	cprintf("Merge sort is Finished!!!!\n") ;
  800109:	83 ec 0c             	sub    $0xc,%esp
  80010c:	68 a9 21 80 00       	push   $0x8021a9
  800111:	e8 40 05 00 00       	call   800656 <cprintf>
  800116:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	(*finishedCount)++ ;
  800119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80011c:	8b 00                	mov    (%eax),%eax
  80011e:	8d 50 01             	lea    0x1(%eax),%edx
  800121:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800124:	89 10                	mov    %edx,(%eax)

}
  800126:	90                   	nop
  800127:	c9                   	leave  
  800128:	c3                   	ret    

00800129 <Swap>:

void Swap(int *Elements, int First, int Second)
{
  800129:	55                   	push   %ebp
  80012a:	89 e5                	mov    %esp,%ebp
  80012c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80012f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800132:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800139:	8b 45 08             	mov    0x8(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	8b 00                	mov    (%eax),%eax
  800140:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800143:	8b 45 0c             	mov    0xc(%ebp),%eax
  800146:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80014d:	8b 45 08             	mov    0x8(%ebp),%eax
  800150:	01 c2                	add    %eax,%edx
  800152:	8b 45 10             	mov    0x10(%ebp),%eax
  800155:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80015c:	8b 45 08             	mov    0x8(%ebp),%eax
  80015f:	01 c8                	add    %ecx,%eax
  800161:	8b 00                	mov    (%eax),%eax
  800163:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800165:	8b 45 10             	mov    0x10(%ebp),%eax
  800168:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80016f:	8b 45 08             	mov    0x8(%ebp),%eax
  800172:	01 c2                	add    %eax,%edx
  800174:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800177:	89 02                	mov    %eax,(%edx)
}
  800179:	90                   	nop
  80017a:	c9                   	leave  
  80017b:	c3                   	ret    

0080017c <PrintElements>:


void PrintElements(int *Elements, int NumOfElements)
{
  80017c:	55                   	push   %ebp
  80017d:	89 e5                	mov    %esp,%ebp
  80017f:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800182:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800189:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800190:	eb 42                	jmp    8001d4 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800192:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800195:	99                   	cltd   
  800196:	f7 7d f0             	idivl  -0x10(%ebp)
  800199:	89 d0                	mov    %edx,%eax
  80019b:	85 c0                	test   %eax,%eax
  80019d:	75 10                	jne    8001af <PrintElements+0x33>
			cprintf("\n");
  80019f:	83 ec 0c             	sub    $0xc,%esp
  8001a2:	68 c5 21 80 00       	push   $0x8021c5
  8001a7:	e8 aa 04 00 00       	call   800656 <cprintf>
  8001ac:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8001af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8001bc:	01 d0                	add    %edx,%eax
  8001be:	8b 00                	mov    (%eax),%eax
  8001c0:	83 ec 08             	sub    $0x8,%esp
  8001c3:	50                   	push   %eax
  8001c4:	68 c7 21 80 00       	push   $0x8021c7
  8001c9:	e8 88 04 00 00       	call   800656 <cprintf>
  8001ce:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8001d1:	ff 45 f4             	incl   -0xc(%ebp)
  8001d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d7:	48                   	dec    %eax
  8001d8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8001db:	7f b5                	jg     800192 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8001dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8001ea:	01 d0                	add    %edx,%eax
  8001ec:	8b 00                	mov    (%eax),%eax
  8001ee:	83 ec 08             	sub    $0x8,%esp
  8001f1:	50                   	push   %eax
  8001f2:	68 cc 21 80 00       	push   $0x8021cc
  8001f7:	e8 5a 04 00 00       	call   800656 <cprintf>
  8001fc:	83 c4 10             	add    $0x10,%esp

}
  8001ff:	90                   	nop
  800200:	c9                   	leave  
  800201:	c3                   	ret    

00800202 <MSort>:


void MSort(int* A, int p, int r)
{
  800202:	55                   	push   %ebp
  800203:	89 e5                	mov    %esp,%ebp
  800205:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  800208:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80020e:	7d 54                	jge    800264 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  800210:	8b 55 0c             	mov    0xc(%ebp),%edx
  800213:	8b 45 10             	mov    0x10(%ebp),%eax
  800216:	01 d0                	add    %edx,%eax
  800218:	89 c2                	mov    %eax,%edx
  80021a:	c1 ea 1f             	shr    $0x1f,%edx
  80021d:	01 d0                	add    %edx,%eax
  80021f:	d1 f8                	sar    %eax
  800221:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  800224:	83 ec 04             	sub    $0x4,%esp
  800227:	ff 75 f4             	pushl  -0xc(%ebp)
  80022a:	ff 75 0c             	pushl  0xc(%ebp)
  80022d:	ff 75 08             	pushl  0x8(%ebp)
  800230:	e8 cd ff ff ff       	call   800202 <MSort>
  800235:	83 c4 10             	add    $0x10,%esp
//	cprintf("LEFT is sorted: from %d to %d\n", p, q);

	MSort(A, q + 1, r);
  800238:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80023b:	40                   	inc    %eax
  80023c:	83 ec 04             	sub    $0x4,%esp
  80023f:	ff 75 10             	pushl  0x10(%ebp)
  800242:	50                   	push   %eax
  800243:	ff 75 08             	pushl  0x8(%ebp)
  800246:	e8 b7 ff ff ff       	call   800202 <MSort>
  80024b:	83 c4 10             	add    $0x10,%esp
//	cprintf("RIGHT is sorted: from %d to %d\n", q+1, r);

	Merge(A, p, q, r);
  80024e:	ff 75 10             	pushl  0x10(%ebp)
  800251:	ff 75 f4             	pushl  -0xc(%ebp)
  800254:	ff 75 0c             	pushl  0xc(%ebp)
  800257:	ff 75 08             	pushl  0x8(%ebp)
  80025a:	e8 08 00 00 00       	call   800267 <Merge>
  80025f:	83 c4 10             	add    $0x10,%esp
  800262:	eb 01                	jmp    800265 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800264:	90                   	nop
//	cprintf("RIGHT is sorted: from %d to %d\n", q+1, r);

	Merge(A, p, q, r);
	//cprintf("[%d %d] + [%d %d] = [%d %d]\n", p, q, q+1, r, p, r);

}
  800265:	c9                   	leave  
  800266:	c3                   	ret    

00800267 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800267:	55                   	push   %ebp
  800268:	89 e5                	mov    %esp,%ebp
  80026a:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80026d:	8b 45 10             	mov    0x10(%ebp),%eax
  800270:	2b 45 0c             	sub    0xc(%ebp),%eax
  800273:	40                   	inc    %eax
  800274:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800277:	8b 45 14             	mov    0x14(%ebp),%eax
  80027a:	2b 45 10             	sub    0x10(%ebp),%eax
  80027d:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800280:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800287:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  80028e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800291:	c1 e0 02             	shl    $0x2,%eax
  800294:	83 ec 0c             	sub    $0xc,%esp
  800297:	50                   	push   %eax
  800298:	e8 28 13 00 00       	call   8015c5 <malloc>
  80029d:	83 c4 10             	add    $0x10,%esp
  8002a0:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  8002a3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002a6:	c1 e0 02             	shl    $0x2,%eax
  8002a9:	83 ec 0c             	sub    $0xc,%esp
  8002ac:	50                   	push   %eax
  8002ad:	e8 13 13 00 00       	call   8015c5 <malloc>
  8002b2:	83 c4 10             	add    $0x10,%esp
  8002b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8002b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8002bf:	eb 2f                	jmp    8002f0 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8002c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002ce:	01 c2                	add    %eax,%edx
  8002d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002d6:	01 c8                	add    %ecx,%eax
  8002d8:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8002dd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 c8                	add    %ecx,%eax
  8002e9:	8b 00                	mov    (%eax),%eax
  8002eb:	89 02                	mov    %eax,(%edx)
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8002ed:	ff 45 ec             	incl   -0x14(%ebp)
  8002f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002f6:	7c c9                	jl     8002c1 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8002f8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002ff:	eb 2a                	jmp    80032b <Merge+0xc4>
	{
		Right[j] = A[q + j];
  800301:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800304:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80030e:	01 c2                	add    %eax,%edx
  800310:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800313:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800316:	01 c8                	add    %ecx,%eax
  800318:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80031f:	8b 45 08             	mov    0x8(%ebp),%eax
  800322:	01 c8                	add    %ecx,%eax
  800324:	8b 00                	mov    (%eax),%eax
  800326:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800328:	ff 45 e8             	incl   -0x18(%ebp)
  80032b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80032e:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800331:	7c ce                	jl     800301 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800333:	8b 45 0c             	mov    0xc(%ebp),%eax
  800336:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800339:	e9 0a 01 00 00       	jmp    800448 <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  80033e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800341:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800344:	0f 8d 95 00 00 00    	jge    8003df <Merge+0x178>
  80034a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80034d:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800350:	0f 8d 89 00 00 00    	jge    8003df <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800356:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800359:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800360:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	8b 10                	mov    (%eax),%edx
  800367:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800371:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800374:	01 c8                	add    %ecx,%eax
  800376:	8b 00                	mov    (%eax),%eax
  800378:	39 c2                	cmp    %eax,%edx
  80037a:	7d 33                	jge    8003af <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80037c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80037f:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800384:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80038b:	8b 45 08             	mov    0x8(%ebp),%eax
  80038e:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800391:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800394:	8d 50 01             	lea    0x1(%eax),%edx
  800397:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80039a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8003aa:	e9 96 00 00 00       	jmp    800445 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  8003af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003b2:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8003b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003be:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c7:	8d 50 01             	lea    0x1(%eax),%edx
  8003ca:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8003cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003d7:	01 d0                	add    %edx,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8003dd:	eb 66                	jmp    800445 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  8003df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8003e5:	7d 30                	jge    800417 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  8003e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003ea:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8003ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ff:	8d 50 01             	lea    0x1(%eax),%edx
  800402:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800405:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80040f:	01 d0                	add    %edx,%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	89 01                	mov    %eax,(%ecx)
  800415:	eb 2e                	jmp    800445 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  800417:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80041a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80041f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80042c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80042f:	8d 50 01             	lea    0x1(%eax),%edx
  800432:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800435:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80043f:	01 d0                	add    %edx,%eax
  800441:	8b 00                	mov    (%eax),%eax
  800443:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800445:	ff 45 e4             	incl   -0x1c(%ebp)
  800448:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80044b:	3b 45 14             	cmp    0x14(%ebp),%eax
  80044e:	0f 8e ea fe ff ff    	jle    80033e <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

	free(Left);
  800454:	83 ec 0c             	sub    $0xc,%esp
  800457:	ff 75 d8             	pushl  -0x28(%ebp)
  80045a:	e8 f4 11 00 00       	call   801653 <free>
  80045f:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800462:	83 ec 0c             	sub    $0xc,%esp
  800465:	ff 75 d4             	pushl  -0x2c(%ebp)
  800468:	e8 e6 11 00 00       	call   801653 <free>
  80046d:	83 c4 10             	add    $0x10,%esp

}
  800470:	90                   	nop
  800471:	c9                   	leave  
  800472:	c3                   	ret    

00800473 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800473:	55                   	push   %ebp
  800474:	89 e5                	mov    %esp,%ebp
  800476:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800479:	e8 3f 13 00 00       	call   8017bd <sys_getenvindex>
  80047e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800481:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800484:	89 d0                	mov    %edx,%eax
  800486:	c1 e0 02             	shl    $0x2,%eax
  800489:	01 d0                	add    %edx,%eax
  80048b:	01 c0                	add    %eax,%eax
  80048d:	01 d0                	add    %edx,%eax
  80048f:	01 c0                	add    %eax,%eax
  800491:	01 d0                	add    %edx,%eax
  800493:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80049a:	01 d0                	add    %edx,%eax
  80049c:	c1 e0 02             	shl    $0x2,%eax
  80049f:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8004a4:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8004a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ae:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8004b4:	84 c0                	test   %al,%al
  8004b6:	74 0f                	je     8004c7 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8004b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bd:	05 f4 02 00 00       	add    $0x2f4,%eax
  8004c2:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8004c7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8004cb:	7e 0a                	jle    8004d7 <libmain+0x64>
		binaryname = argv[0];
  8004cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d0:	8b 00                	mov    (%eax),%eax
  8004d2:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8004d7:	83 ec 08             	sub    $0x8,%esp
  8004da:	ff 75 0c             	pushl  0xc(%ebp)
  8004dd:	ff 75 08             	pushl  0x8(%ebp)
  8004e0:	e8 53 fb ff ff       	call   800038 <_main>
  8004e5:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8004e8:	e8 6b 14 00 00       	call   801958 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004ed:	83 ec 0c             	sub    $0xc,%esp
  8004f0:	68 e8 21 80 00       	push   $0x8021e8
  8004f5:	e8 5c 01 00 00       	call   800656 <cprintf>
  8004fa:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8004fd:	a1 20 30 80 00       	mov    0x803020,%eax
  800502:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800508:	a1 20 30 80 00       	mov    0x803020,%eax
  80050d:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800513:	83 ec 04             	sub    $0x4,%esp
  800516:	52                   	push   %edx
  800517:	50                   	push   %eax
  800518:	68 10 22 80 00       	push   $0x802210
  80051d:	e8 34 01 00 00       	call   800656 <cprintf>
  800522:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800525:	a1 20 30 80 00       	mov    0x803020,%eax
  80052a:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800530:	83 ec 08             	sub    $0x8,%esp
  800533:	50                   	push   %eax
  800534:	68 35 22 80 00       	push   $0x802235
  800539:	e8 18 01 00 00       	call   800656 <cprintf>
  80053e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800541:	83 ec 0c             	sub    $0xc,%esp
  800544:	68 e8 21 80 00       	push   $0x8021e8
  800549:	e8 08 01 00 00       	call   800656 <cprintf>
  80054e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800551:	e8 1c 14 00 00       	call   801972 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800556:	e8 19 00 00 00       	call   800574 <exit>
}
  80055b:	90                   	nop
  80055c:	c9                   	leave  
  80055d:	c3                   	ret    

0080055e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80055e:	55                   	push   %ebp
  80055f:	89 e5                	mov    %esp,%ebp
  800561:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800564:	83 ec 0c             	sub    $0xc,%esp
  800567:	6a 00                	push   $0x0
  800569:	e8 1b 12 00 00       	call   801789 <sys_env_destroy>
  80056e:	83 c4 10             	add    $0x10,%esp
}
  800571:	90                   	nop
  800572:	c9                   	leave  
  800573:	c3                   	ret    

00800574 <exit>:

void
exit(void)
{
  800574:	55                   	push   %ebp
  800575:	89 e5                	mov    %esp,%ebp
  800577:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80057a:	e8 70 12 00 00       	call   8017ef <sys_env_exit>
}
  80057f:	90                   	nop
  800580:	c9                   	leave  
  800581:	c3                   	ret    

00800582 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800582:	55                   	push   %ebp
  800583:	89 e5                	mov    %esp,%ebp
  800585:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800588:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058b:	8b 00                	mov    (%eax),%eax
  80058d:	8d 48 01             	lea    0x1(%eax),%ecx
  800590:	8b 55 0c             	mov    0xc(%ebp),%edx
  800593:	89 0a                	mov    %ecx,(%edx)
  800595:	8b 55 08             	mov    0x8(%ebp),%edx
  800598:	88 d1                	mov    %dl,%cl
  80059a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80059d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a4:	8b 00                	mov    (%eax),%eax
  8005a6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005ab:	75 2c                	jne    8005d9 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005ad:	a0 24 30 80 00       	mov    0x803024,%al
  8005b2:	0f b6 c0             	movzbl %al,%eax
  8005b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005b8:	8b 12                	mov    (%edx),%edx
  8005ba:	89 d1                	mov    %edx,%ecx
  8005bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005bf:	83 c2 08             	add    $0x8,%edx
  8005c2:	83 ec 04             	sub    $0x4,%esp
  8005c5:	50                   	push   %eax
  8005c6:	51                   	push   %ecx
  8005c7:	52                   	push   %edx
  8005c8:	e8 7a 11 00 00       	call   801747 <sys_cputs>
  8005cd:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005d3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005dc:	8b 40 04             	mov    0x4(%eax),%eax
  8005df:	8d 50 01             	lea    0x1(%eax),%edx
  8005e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8005e8:	90                   	nop
  8005e9:	c9                   	leave  
  8005ea:	c3                   	ret    

008005eb <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8005eb:	55                   	push   %ebp
  8005ec:	89 e5                	mov    %esp,%ebp
  8005ee:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005f4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8005fb:	00 00 00 
	b.cnt = 0;
  8005fe:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800605:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800608:	ff 75 0c             	pushl  0xc(%ebp)
  80060b:	ff 75 08             	pushl  0x8(%ebp)
  80060e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800614:	50                   	push   %eax
  800615:	68 82 05 80 00       	push   $0x800582
  80061a:	e8 11 02 00 00       	call   800830 <vprintfmt>
  80061f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800622:	a0 24 30 80 00       	mov    0x803024,%al
  800627:	0f b6 c0             	movzbl %al,%eax
  80062a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800630:	83 ec 04             	sub    $0x4,%esp
  800633:	50                   	push   %eax
  800634:	52                   	push   %edx
  800635:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80063b:	83 c0 08             	add    $0x8,%eax
  80063e:	50                   	push   %eax
  80063f:	e8 03 11 00 00       	call   801747 <sys_cputs>
  800644:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800647:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80064e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800654:	c9                   	leave  
  800655:	c3                   	ret    

00800656 <cprintf>:

int cprintf(const char *fmt, ...) {
  800656:	55                   	push   %ebp
  800657:	89 e5                	mov    %esp,%ebp
  800659:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80065c:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800663:	8d 45 0c             	lea    0xc(%ebp),%eax
  800666:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800669:	8b 45 08             	mov    0x8(%ebp),%eax
  80066c:	83 ec 08             	sub    $0x8,%esp
  80066f:	ff 75 f4             	pushl  -0xc(%ebp)
  800672:	50                   	push   %eax
  800673:	e8 73 ff ff ff       	call   8005eb <vcprintf>
  800678:	83 c4 10             	add    $0x10,%esp
  80067b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80067e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800681:	c9                   	leave  
  800682:	c3                   	ret    

00800683 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800683:	55                   	push   %ebp
  800684:	89 e5                	mov    %esp,%ebp
  800686:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800689:	e8 ca 12 00 00       	call   801958 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80068e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800691:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800694:	8b 45 08             	mov    0x8(%ebp),%eax
  800697:	83 ec 08             	sub    $0x8,%esp
  80069a:	ff 75 f4             	pushl  -0xc(%ebp)
  80069d:	50                   	push   %eax
  80069e:	e8 48 ff ff ff       	call   8005eb <vcprintf>
  8006a3:	83 c4 10             	add    $0x10,%esp
  8006a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006a9:	e8 c4 12 00 00       	call   801972 <sys_enable_interrupt>
	return cnt;
  8006ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006b1:	c9                   	leave  
  8006b2:	c3                   	ret    

008006b3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006b3:	55                   	push   %ebp
  8006b4:	89 e5                	mov    %esp,%ebp
  8006b6:	53                   	push   %ebx
  8006b7:	83 ec 14             	sub    $0x14,%esp
  8006ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8006bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8006c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006c6:	8b 45 18             	mov    0x18(%ebp),%eax
  8006c9:	ba 00 00 00 00       	mov    $0x0,%edx
  8006ce:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006d1:	77 55                	ja     800728 <printnum+0x75>
  8006d3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006d6:	72 05                	jb     8006dd <printnum+0x2a>
  8006d8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006db:	77 4b                	ja     800728 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006dd:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006e0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006e3:	8b 45 18             	mov    0x18(%ebp),%eax
  8006e6:	ba 00 00 00 00       	mov    $0x0,%edx
  8006eb:	52                   	push   %edx
  8006ec:	50                   	push   %eax
  8006ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8006f0:	ff 75 f0             	pushl  -0x10(%ebp)
  8006f3:	e8 20 18 00 00       	call   801f18 <__udivdi3>
  8006f8:	83 c4 10             	add    $0x10,%esp
  8006fb:	83 ec 04             	sub    $0x4,%esp
  8006fe:	ff 75 20             	pushl  0x20(%ebp)
  800701:	53                   	push   %ebx
  800702:	ff 75 18             	pushl  0x18(%ebp)
  800705:	52                   	push   %edx
  800706:	50                   	push   %eax
  800707:	ff 75 0c             	pushl  0xc(%ebp)
  80070a:	ff 75 08             	pushl  0x8(%ebp)
  80070d:	e8 a1 ff ff ff       	call   8006b3 <printnum>
  800712:	83 c4 20             	add    $0x20,%esp
  800715:	eb 1a                	jmp    800731 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800717:	83 ec 08             	sub    $0x8,%esp
  80071a:	ff 75 0c             	pushl  0xc(%ebp)
  80071d:	ff 75 20             	pushl  0x20(%ebp)
  800720:	8b 45 08             	mov    0x8(%ebp),%eax
  800723:	ff d0                	call   *%eax
  800725:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800728:	ff 4d 1c             	decl   0x1c(%ebp)
  80072b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80072f:	7f e6                	jg     800717 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800731:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800734:	bb 00 00 00 00       	mov    $0x0,%ebx
  800739:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80073c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80073f:	53                   	push   %ebx
  800740:	51                   	push   %ecx
  800741:	52                   	push   %edx
  800742:	50                   	push   %eax
  800743:	e8 e0 18 00 00       	call   802028 <__umoddi3>
  800748:	83 c4 10             	add    $0x10,%esp
  80074b:	05 74 24 80 00       	add    $0x802474,%eax
  800750:	8a 00                	mov    (%eax),%al
  800752:	0f be c0             	movsbl %al,%eax
  800755:	83 ec 08             	sub    $0x8,%esp
  800758:	ff 75 0c             	pushl  0xc(%ebp)
  80075b:	50                   	push   %eax
  80075c:	8b 45 08             	mov    0x8(%ebp),%eax
  80075f:	ff d0                	call   *%eax
  800761:	83 c4 10             	add    $0x10,%esp
}
  800764:	90                   	nop
  800765:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800768:	c9                   	leave  
  800769:	c3                   	ret    

0080076a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80076a:	55                   	push   %ebp
  80076b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80076d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800771:	7e 1c                	jle    80078f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	8b 00                	mov    (%eax),%eax
  800778:	8d 50 08             	lea    0x8(%eax),%edx
  80077b:	8b 45 08             	mov    0x8(%ebp),%eax
  80077e:	89 10                	mov    %edx,(%eax)
  800780:	8b 45 08             	mov    0x8(%ebp),%eax
  800783:	8b 00                	mov    (%eax),%eax
  800785:	83 e8 08             	sub    $0x8,%eax
  800788:	8b 50 04             	mov    0x4(%eax),%edx
  80078b:	8b 00                	mov    (%eax),%eax
  80078d:	eb 40                	jmp    8007cf <getuint+0x65>
	else if (lflag)
  80078f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800793:	74 1e                	je     8007b3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800795:	8b 45 08             	mov    0x8(%ebp),%eax
  800798:	8b 00                	mov    (%eax),%eax
  80079a:	8d 50 04             	lea    0x4(%eax),%edx
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	89 10                	mov    %edx,(%eax)
  8007a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a5:	8b 00                	mov    (%eax),%eax
  8007a7:	83 e8 04             	sub    $0x4,%eax
  8007aa:	8b 00                	mov    (%eax),%eax
  8007ac:	ba 00 00 00 00       	mov    $0x0,%edx
  8007b1:	eb 1c                	jmp    8007cf <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	8b 00                	mov    (%eax),%eax
  8007b8:	8d 50 04             	lea    0x4(%eax),%edx
  8007bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007be:	89 10                	mov    %edx,(%eax)
  8007c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c3:	8b 00                	mov    (%eax),%eax
  8007c5:	83 e8 04             	sub    $0x4,%eax
  8007c8:	8b 00                	mov    (%eax),%eax
  8007ca:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007cf:	5d                   	pop    %ebp
  8007d0:	c3                   	ret    

008007d1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007d1:	55                   	push   %ebp
  8007d2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007d4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007d8:	7e 1c                	jle    8007f6 <getint+0x25>
		return va_arg(*ap, long long);
  8007da:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dd:	8b 00                	mov    (%eax),%eax
  8007df:	8d 50 08             	lea    0x8(%eax),%edx
  8007e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e5:	89 10                	mov    %edx,(%eax)
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	8b 00                	mov    (%eax),%eax
  8007ec:	83 e8 08             	sub    $0x8,%eax
  8007ef:	8b 50 04             	mov    0x4(%eax),%edx
  8007f2:	8b 00                	mov    (%eax),%eax
  8007f4:	eb 38                	jmp    80082e <getint+0x5d>
	else if (lflag)
  8007f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007fa:	74 1a                	je     800816 <getint+0x45>
		return va_arg(*ap, long);
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	8b 00                	mov    (%eax),%eax
  800801:	8d 50 04             	lea    0x4(%eax),%edx
  800804:	8b 45 08             	mov    0x8(%ebp),%eax
  800807:	89 10                	mov    %edx,(%eax)
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	8b 00                	mov    (%eax),%eax
  80080e:	83 e8 04             	sub    $0x4,%eax
  800811:	8b 00                	mov    (%eax),%eax
  800813:	99                   	cltd   
  800814:	eb 18                	jmp    80082e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800816:	8b 45 08             	mov    0x8(%ebp),%eax
  800819:	8b 00                	mov    (%eax),%eax
  80081b:	8d 50 04             	lea    0x4(%eax),%edx
  80081e:	8b 45 08             	mov    0x8(%ebp),%eax
  800821:	89 10                	mov    %edx,(%eax)
  800823:	8b 45 08             	mov    0x8(%ebp),%eax
  800826:	8b 00                	mov    (%eax),%eax
  800828:	83 e8 04             	sub    $0x4,%eax
  80082b:	8b 00                	mov    (%eax),%eax
  80082d:	99                   	cltd   
}
  80082e:	5d                   	pop    %ebp
  80082f:	c3                   	ret    

00800830 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800830:	55                   	push   %ebp
  800831:	89 e5                	mov    %esp,%ebp
  800833:	56                   	push   %esi
  800834:	53                   	push   %ebx
  800835:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800838:	eb 17                	jmp    800851 <vprintfmt+0x21>
			if (ch == '\0')
  80083a:	85 db                	test   %ebx,%ebx
  80083c:	0f 84 af 03 00 00    	je     800bf1 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800842:	83 ec 08             	sub    $0x8,%esp
  800845:	ff 75 0c             	pushl  0xc(%ebp)
  800848:	53                   	push   %ebx
  800849:	8b 45 08             	mov    0x8(%ebp),%eax
  80084c:	ff d0                	call   *%eax
  80084e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800851:	8b 45 10             	mov    0x10(%ebp),%eax
  800854:	8d 50 01             	lea    0x1(%eax),%edx
  800857:	89 55 10             	mov    %edx,0x10(%ebp)
  80085a:	8a 00                	mov    (%eax),%al
  80085c:	0f b6 d8             	movzbl %al,%ebx
  80085f:	83 fb 25             	cmp    $0x25,%ebx
  800862:	75 d6                	jne    80083a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800864:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800868:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80086f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800876:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80087d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800884:	8b 45 10             	mov    0x10(%ebp),%eax
  800887:	8d 50 01             	lea    0x1(%eax),%edx
  80088a:	89 55 10             	mov    %edx,0x10(%ebp)
  80088d:	8a 00                	mov    (%eax),%al
  80088f:	0f b6 d8             	movzbl %al,%ebx
  800892:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800895:	83 f8 55             	cmp    $0x55,%eax
  800898:	0f 87 2b 03 00 00    	ja     800bc9 <vprintfmt+0x399>
  80089e:	8b 04 85 98 24 80 00 	mov    0x802498(,%eax,4),%eax
  8008a5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008a7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008ab:	eb d7                	jmp    800884 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008ad:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008b1:	eb d1                	jmp    800884 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008b3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008ba:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008bd:	89 d0                	mov    %edx,%eax
  8008bf:	c1 e0 02             	shl    $0x2,%eax
  8008c2:	01 d0                	add    %edx,%eax
  8008c4:	01 c0                	add    %eax,%eax
  8008c6:	01 d8                	add    %ebx,%eax
  8008c8:	83 e8 30             	sub    $0x30,%eax
  8008cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8008d1:	8a 00                	mov    (%eax),%al
  8008d3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008d6:	83 fb 2f             	cmp    $0x2f,%ebx
  8008d9:	7e 3e                	jle    800919 <vprintfmt+0xe9>
  8008db:	83 fb 39             	cmp    $0x39,%ebx
  8008de:	7f 39                	jg     800919 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008e0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008e3:	eb d5                	jmp    8008ba <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e8:	83 c0 04             	add    $0x4,%eax
  8008eb:	89 45 14             	mov    %eax,0x14(%ebp)
  8008ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f1:	83 e8 04             	sub    $0x4,%eax
  8008f4:	8b 00                	mov    (%eax),%eax
  8008f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008f9:	eb 1f                	jmp    80091a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008fb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ff:	79 83                	jns    800884 <vprintfmt+0x54>
				width = 0;
  800901:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800908:	e9 77 ff ff ff       	jmp    800884 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80090d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800914:	e9 6b ff ff ff       	jmp    800884 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800919:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80091a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80091e:	0f 89 60 ff ff ff    	jns    800884 <vprintfmt+0x54>
				width = precision, precision = -1;
  800924:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800927:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80092a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800931:	e9 4e ff ff ff       	jmp    800884 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800936:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800939:	e9 46 ff ff ff       	jmp    800884 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80093e:	8b 45 14             	mov    0x14(%ebp),%eax
  800941:	83 c0 04             	add    $0x4,%eax
  800944:	89 45 14             	mov    %eax,0x14(%ebp)
  800947:	8b 45 14             	mov    0x14(%ebp),%eax
  80094a:	83 e8 04             	sub    $0x4,%eax
  80094d:	8b 00                	mov    (%eax),%eax
  80094f:	83 ec 08             	sub    $0x8,%esp
  800952:	ff 75 0c             	pushl  0xc(%ebp)
  800955:	50                   	push   %eax
  800956:	8b 45 08             	mov    0x8(%ebp),%eax
  800959:	ff d0                	call   *%eax
  80095b:	83 c4 10             	add    $0x10,%esp
			break;
  80095e:	e9 89 02 00 00       	jmp    800bec <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800963:	8b 45 14             	mov    0x14(%ebp),%eax
  800966:	83 c0 04             	add    $0x4,%eax
  800969:	89 45 14             	mov    %eax,0x14(%ebp)
  80096c:	8b 45 14             	mov    0x14(%ebp),%eax
  80096f:	83 e8 04             	sub    $0x4,%eax
  800972:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800974:	85 db                	test   %ebx,%ebx
  800976:	79 02                	jns    80097a <vprintfmt+0x14a>
				err = -err;
  800978:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80097a:	83 fb 64             	cmp    $0x64,%ebx
  80097d:	7f 0b                	jg     80098a <vprintfmt+0x15a>
  80097f:	8b 34 9d e0 22 80 00 	mov    0x8022e0(,%ebx,4),%esi
  800986:	85 f6                	test   %esi,%esi
  800988:	75 19                	jne    8009a3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80098a:	53                   	push   %ebx
  80098b:	68 85 24 80 00       	push   $0x802485
  800990:	ff 75 0c             	pushl  0xc(%ebp)
  800993:	ff 75 08             	pushl  0x8(%ebp)
  800996:	e8 5e 02 00 00       	call   800bf9 <printfmt>
  80099b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80099e:	e9 49 02 00 00       	jmp    800bec <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009a3:	56                   	push   %esi
  8009a4:	68 8e 24 80 00       	push   $0x80248e
  8009a9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ac:	ff 75 08             	pushl  0x8(%ebp)
  8009af:	e8 45 02 00 00       	call   800bf9 <printfmt>
  8009b4:	83 c4 10             	add    $0x10,%esp
			break;
  8009b7:	e9 30 02 00 00       	jmp    800bec <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8009bf:	83 c0 04             	add    $0x4,%eax
  8009c2:	89 45 14             	mov    %eax,0x14(%ebp)
  8009c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c8:	83 e8 04             	sub    $0x4,%eax
  8009cb:	8b 30                	mov    (%eax),%esi
  8009cd:	85 f6                	test   %esi,%esi
  8009cf:	75 05                	jne    8009d6 <vprintfmt+0x1a6>
				p = "(null)";
  8009d1:	be 91 24 80 00       	mov    $0x802491,%esi
			if (width > 0 && padc != '-')
  8009d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009da:	7e 6d                	jle    800a49 <vprintfmt+0x219>
  8009dc:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009e0:	74 67                	je     800a49 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009e5:	83 ec 08             	sub    $0x8,%esp
  8009e8:	50                   	push   %eax
  8009e9:	56                   	push   %esi
  8009ea:	e8 0c 03 00 00       	call   800cfb <strnlen>
  8009ef:	83 c4 10             	add    $0x10,%esp
  8009f2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009f5:	eb 16                	jmp    800a0d <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009f7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009fb:	83 ec 08             	sub    $0x8,%esp
  8009fe:	ff 75 0c             	pushl  0xc(%ebp)
  800a01:	50                   	push   %eax
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	ff d0                	call   *%eax
  800a07:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a0a:	ff 4d e4             	decl   -0x1c(%ebp)
  800a0d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a11:	7f e4                	jg     8009f7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a13:	eb 34                	jmp    800a49 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a15:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a19:	74 1c                	je     800a37 <vprintfmt+0x207>
  800a1b:	83 fb 1f             	cmp    $0x1f,%ebx
  800a1e:	7e 05                	jle    800a25 <vprintfmt+0x1f5>
  800a20:	83 fb 7e             	cmp    $0x7e,%ebx
  800a23:	7e 12                	jle    800a37 <vprintfmt+0x207>
					putch('?', putdat);
  800a25:	83 ec 08             	sub    $0x8,%esp
  800a28:	ff 75 0c             	pushl  0xc(%ebp)
  800a2b:	6a 3f                	push   $0x3f
  800a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a30:	ff d0                	call   *%eax
  800a32:	83 c4 10             	add    $0x10,%esp
  800a35:	eb 0f                	jmp    800a46 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a37:	83 ec 08             	sub    $0x8,%esp
  800a3a:	ff 75 0c             	pushl  0xc(%ebp)
  800a3d:	53                   	push   %ebx
  800a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a41:	ff d0                	call   *%eax
  800a43:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a46:	ff 4d e4             	decl   -0x1c(%ebp)
  800a49:	89 f0                	mov    %esi,%eax
  800a4b:	8d 70 01             	lea    0x1(%eax),%esi
  800a4e:	8a 00                	mov    (%eax),%al
  800a50:	0f be d8             	movsbl %al,%ebx
  800a53:	85 db                	test   %ebx,%ebx
  800a55:	74 24                	je     800a7b <vprintfmt+0x24b>
  800a57:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a5b:	78 b8                	js     800a15 <vprintfmt+0x1e5>
  800a5d:	ff 4d e0             	decl   -0x20(%ebp)
  800a60:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a64:	79 af                	jns    800a15 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a66:	eb 13                	jmp    800a7b <vprintfmt+0x24b>
				putch(' ', putdat);
  800a68:	83 ec 08             	sub    $0x8,%esp
  800a6b:	ff 75 0c             	pushl  0xc(%ebp)
  800a6e:	6a 20                	push   $0x20
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	ff d0                	call   *%eax
  800a75:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a78:	ff 4d e4             	decl   -0x1c(%ebp)
  800a7b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a7f:	7f e7                	jg     800a68 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a81:	e9 66 01 00 00       	jmp    800bec <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a86:	83 ec 08             	sub    $0x8,%esp
  800a89:	ff 75 e8             	pushl  -0x18(%ebp)
  800a8c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a8f:	50                   	push   %eax
  800a90:	e8 3c fd ff ff       	call   8007d1 <getint>
  800a95:	83 c4 10             	add    $0x10,%esp
  800a98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aa4:	85 d2                	test   %edx,%edx
  800aa6:	79 23                	jns    800acb <vprintfmt+0x29b>
				putch('-', putdat);
  800aa8:	83 ec 08             	sub    $0x8,%esp
  800aab:	ff 75 0c             	pushl  0xc(%ebp)
  800aae:	6a 2d                	push   $0x2d
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	ff d0                	call   *%eax
  800ab5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ab8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800abb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800abe:	f7 d8                	neg    %eax
  800ac0:	83 d2 00             	adc    $0x0,%edx
  800ac3:	f7 da                	neg    %edx
  800ac5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800acb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ad2:	e9 bc 00 00 00       	jmp    800b93 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ad7:	83 ec 08             	sub    $0x8,%esp
  800ada:	ff 75 e8             	pushl  -0x18(%ebp)
  800add:	8d 45 14             	lea    0x14(%ebp),%eax
  800ae0:	50                   	push   %eax
  800ae1:	e8 84 fc ff ff       	call   80076a <getuint>
  800ae6:	83 c4 10             	add    $0x10,%esp
  800ae9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aec:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800aef:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800af6:	e9 98 00 00 00       	jmp    800b93 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800afb:	83 ec 08             	sub    $0x8,%esp
  800afe:	ff 75 0c             	pushl  0xc(%ebp)
  800b01:	6a 58                	push   $0x58
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	ff d0                	call   *%eax
  800b08:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b0b:	83 ec 08             	sub    $0x8,%esp
  800b0e:	ff 75 0c             	pushl  0xc(%ebp)
  800b11:	6a 58                	push   $0x58
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
  800b16:	ff d0                	call   *%eax
  800b18:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b1b:	83 ec 08             	sub    $0x8,%esp
  800b1e:	ff 75 0c             	pushl  0xc(%ebp)
  800b21:	6a 58                	push   $0x58
  800b23:	8b 45 08             	mov    0x8(%ebp),%eax
  800b26:	ff d0                	call   *%eax
  800b28:	83 c4 10             	add    $0x10,%esp
			break;
  800b2b:	e9 bc 00 00 00       	jmp    800bec <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b30:	83 ec 08             	sub    $0x8,%esp
  800b33:	ff 75 0c             	pushl  0xc(%ebp)
  800b36:	6a 30                	push   $0x30
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	ff d0                	call   *%eax
  800b3d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b40:	83 ec 08             	sub    $0x8,%esp
  800b43:	ff 75 0c             	pushl  0xc(%ebp)
  800b46:	6a 78                	push   $0x78
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	ff d0                	call   *%eax
  800b4d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b50:	8b 45 14             	mov    0x14(%ebp),%eax
  800b53:	83 c0 04             	add    $0x4,%eax
  800b56:	89 45 14             	mov    %eax,0x14(%ebp)
  800b59:	8b 45 14             	mov    0x14(%ebp),%eax
  800b5c:	83 e8 04             	sub    $0x4,%eax
  800b5f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b61:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b64:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b6b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b72:	eb 1f                	jmp    800b93 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b74:	83 ec 08             	sub    $0x8,%esp
  800b77:	ff 75 e8             	pushl  -0x18(%ebp)
  800b7a:	8d 45 14             	lea    0x14(%ebp),%eax
  800b7d:	50                   	push   %eax
  800b7e:	e8 e7 fb ff ff       	call   80076a <getuint>
  800b83:	83 c4 10             	add    $0x10,%esp
  800b86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b89:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b8c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b93:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b97:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b9a:	83 ec 04             	sub    $0x4,%esp
  800b9d:	52                   	push   %edx
  800b9e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ba1:	50                   	push   %eax
  800ba2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba5:	ff 75 f0             	pushl  -0x10(%ebp)
  800ba8:	ff 75 0c             	pushl  0xc(%ebp)
  800bab:	ff 75 08             	pushl  0x8(%ebp)
  800bae:	e8 00 fb ff ff       	call   8006b3 <printnum>
  800bb3:	83 c4 20             	add    $0x20,%esp
			break;
  800bb6:	eb 34                	jmp    800bec <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bb8:	83 ec 08             	sub    $0x8,%esp
  800bbb:	ff 75 0c             	pushl  0xc(%ebp)
  800bbe:	53                   	push   %ebx
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	ff d0                	call   *%eax
  800bc4:	83 c4 10             	add    $0x10,%esp
			break;
  800bc7:	eb 23                	jmp    800bec <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bc9:	83 ec 08             	sub    $0x8,%esp
  800bcc:	ff 75 0c             	pushl  0xc(%ebp)
  800bcf:	6a 25                	push   $0x25
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	ff d0                	call   *%eax
  800bd6:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bd9:	ff 4d 10             	decl   0x10(%ebp)
  800bdc:	eb 03                	jmp    800be1 <vprintfmt+0x3b1>
  800bde:	ff 4d 10             	decl   0x10(%ebp)
  800be1:	8b 45 10             	mov    0x10(%ebp),%eax
  800be4:	48                   	dec    %eax
  800be5:	8a 00                	mov    (%eax),%al
  800be7:	3c 25                	cmp    $0x25,%al
  800be9:	75 f3                	jne    800bde <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800beb:	90                   	nop
		}
	}
  800bec:	e9 47 fc ff ff       	jmp    800838 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bf1:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bf2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800bf5:	5b                   	pop    %ebx
  800bf6:	5e                   	pop    %esi
  800bf7:	5d                   	pop    %ebp
  800bf8:	c3                   	ret    

00800bf9 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bf9:	55                   	push   %ebp
  800bfa:	89 e5                	mov    %esp,%ebp
  800bfc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800bff:	8d 45 10             	lea    0x10(%ebp),%eax
  800c02:	83 c0 04             	add    $0x4,%eax
  800c05:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c08:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c0e:	50                   	push   %eax
  800c0f:	ff 75 0c             	pushl  0xc(%ebp)
  800c12:	ff 75 08             	pushl  0x8(%ebp)
  800c15:	e8 16 fc ff ff       	call   800830 <vprintfmt>
  800c1a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c1d:	90                   	nop
  800c1e:	c9                   	leave  
  800c1f:	c3                   	ret    

00800c20 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c20:	55                   	push   %ebp
  800c21:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c26:	8b 40 08             	mov    0x8(%eax),%eax
  800c29:	8d 50 01             	lea    0x1(%eax),%edx
  800c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c35:	8b 10                	mov    (%eax),%edx
  800c37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3a:	8b 40 04             	mov    0x4(%eax),%eax
  800c3d:	39 c2                	cmp    %eax,%edx
  800c3f:	73 12                	jae    800c53 <sprintputch+0x33>
		*b->buf++ = ch;
  800c41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c44:	8b 00                	mov    (%eax),%eax
  800c46:	8d 48 01             	lea    0x1(%eax),%ecx
  800c49:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4c:	89 0a                	mov    %ecx,(%edx)
  800c4e:	8b 55 08             	mov    0x8(%ebp),%edx
  800c51:	88 10                	mov    %dl,(%eax)
}
  800c53:	90                   	nop
  800c54:	5d                   	pop    %ebp
  800c55:	c3                   	ret    

00800c56 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c56:	55                   	push   %ebp
  800c57:	89 e5                	mov    %esp,%ebp
  800c59:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c65:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	01 d0                	add    %edx,%eax
  800c6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c70:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c77:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c7b:	74 06                	je     800c83 <vsnprintf+0x2d>
  800c7d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c81:	7f 07                	jg     800c8a <vsnprintf+0x34>
		return -E_INVAL;
  800c83:	b8 03 00 00 00       	mov    $0x3,%eax
  800c88:	eb 20                	jmp    800caa <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c8a:	ff 75 14             	pushl  0x14(%ebp)
  800c8d:	ff 75 10             	pushl  0x10(%ebp)
  800c90:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c93:	50                   	push   %eax
  800c94:	68 20 0c 80 00       	push   $0x800c20
  800c99:	e8 92 fb ff ff       	call   800830 <vprintfmt>
  800c9e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ca1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ca4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ca7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800caa:	c9                   	leave  
  800cab:	c3                   	ret    

00800cac <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800cac:	55                   	push   %ebp
  800cad:	89 e5                	mov    %esp,%ebp
  800caf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cb2:	8d 45 10             	lea    0x10(%ebp),%eax
  800cb5:	83 c0 04             	add    $0x4,%eax
  800cb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800cbe:	ff 75 f4             	pushl  -0xc(%ebp)
  800cc1:	50                   	push   %eax
  800cc2:	ff 75 0c             	pushl  0xc(%ebp)
  800cc5:	ff 75 08             	pushl  0x8(%ebp)
  800cc8:	e8 89 ff ff ff       	call   800c56 <vsnprintf>
  800ccd:	83 c4 10             	add    $0x10,%esp
  800cd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cd6:	c9                   	leave  
  800cd7:	c3                   	ret    

00800cd8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cd8:	55                   	push   %ebp
  800cd9:	89 e5                	mov    %esp,%ebp
  800cdb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cde:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ce5:	eb 06                	jmp    800ced <strlen+0x15>
		n++;
  800ce7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cea:	ff 45 08             	incl   0x8(%ebp)
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	8a 00                	mov    (%eax),%al
  800cf2:	84 c0                	test   %al,%al
  800cf4:	75 f1                	jne    800ce7 <strlen+0xf>
		n++;
	return n;
  800cf6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cf9:	c9                   	leave  
  800cfa:	c3                   	ret    

00800cfb <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800cfb:	55                   	push   %ebp
  800cfc:	89 e5                	mov    %esp,%ebp
  800cfe:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d01:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d08:	eb 09                	jmp    800d13 <strnlen+0x18>
		n++;
  800d0a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d0d:	ff 45 08             	incl   0x8(%ebp)
  800d10:	ff 4d 0c             	decl   0xc(%ebp)
  800d13:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d17:	74 09                	je     800d22 <strnlen+0x27>
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	84 c0                	test   %al,%al
  800d20:	75 e8                	jne    800d0a <strnlen+0xf>
		n++;
	return n;
  800d22:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d25:	c9                   	leave  
  800d26:	c3                   	ret    

00800d27 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d27:	55                   	push   %ebp
  800d28:	89 e5                	mov    %esp,%ebp
  800d2a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d33:	90                   	nop
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
  800d37:	8d 50 01             	lea    0x1(%eax),%edx
  800d3a:	89 55 08             	mov    %edx,0x8(%ebp)
  800d3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d40:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d43:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d46:	8a 12                	mov    (%edx),%dl
  800d48:	88 10                	mov    %dl,(%eax)
  800d4a:	8a 00                	mov    (%eax),%al
  800d4c:	84 c0                	test   %al,%al
  800d4e:	75 e4                	jne    800d34 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d50:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d53:	c9                   	leave  
  800d54:	c3                   	ret    

00800d55 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d55:	55                   	push   %ebp
  800d56:	89 e5                	mov    %esp,%ebp
  800d58:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d61:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d68:	eb 1f                	jmp    800d89 <strncpy+0x34>
		*dst++ = *src;
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8d 50 01             	lea    0x1(%eax),%edx
  800d70:	89 55 08             	mov    %edx,0x8(%ebp)
  800d73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d76:	8a 12                	mov    (%edx),%dl
  800d78:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	84 c0                	test   %al,%al
  800d81:	74 03                	je     800d86 <strncpy+0x31>
			src++;
  800d83:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d86:	ff 45 fc             	incl   -0x4(%ebp)
  800d89:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d8c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d8f:	72 d9                	jb     800d6a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d91:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d94:	c9                   	leave  
  800d95:	c3                   	ret    

00800d96 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d96:	55                   	push   %ebp
  800d97:	89 e5                	mov    %esp,%ebp
  800d99:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800da2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800da6:	74 30                	je     800dd8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800da8:	eb 16                	jmp    800dc0 <strlcpy+0x2a>
			*dst++ = *src++;
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	8d 50 01             	lea    0x1(%eax),%edx
  800db0:	89 55 08             	mov    %edx,0x8(%ebp)
  800db3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800db6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800db9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800dbc:	8a 12                	mov    (%edx),%dl
  800dbe:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800dc0:	ff 4d 10             	decl   0x10(%ebp)
  800dc3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc7:	74 09                	je     800dd2 <strlcpy+0x3c>
  800dc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dcc:	8a 00                	mov    (%eax),%al
  800dce:	84 c0                	test   %al,%al
  800dd0:	75 d8                	jne    800daa <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800dd8:	8b 55 08             	mov    0x8(%ebp),%edx
  800ddb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dde:	29 c2                	sub    %eax,%edx
  800de0:	89 d0                	mov    %edx,%eax
}
  800de2:	c9                   	leave  
  800de3:	c3                   	ret    

00800de4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800de4:	55                   	push   %ebp
  800de5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800de7:	eb 06                	jmp    800def <strcmp+0xb>
		p++, q++;
  800de9:	ff 45 08             	incl   0x8(%ebp)
  800dec:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800def:	8b 45 08             	mov    0x8(%ebp),%eax
  800df2:	8a 00                	mov    (%eax),%al
  800df4:	84 c0                	test   %al,%al
  800df6:	74 0e                	je     800e06 <strcmp+0x22>
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	8a 10                	mov    (%eax),%dl
  800dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e00:	8a 00                	mov    (%eax),%al
  800e02:	38 c2                	cmp    %al,%dl
  800e04:	74 e3                	je     800de9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e06:	8b 45 08             	mov    0x8(%ebp),%eax
  800e09:	8a 00                	mov    (%eax),%al
  800e0b:	0f b6 d0             	movzbl %al,%edx
  800e0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e11:	8a 00                	mov    (%eax),%al
  800e13:	0f b6 c0             	movzbl %al,%eax
  800e16:	29 c2                	sub    %eax,%edx
  800e18:	89 d0                	mov    %edx,%eax
}
  800e1a:	5d                   	pop    %ebp
  800e1b:	c3                   	ret    

00800e1c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e1c:	55                   	push   %ebp
  800e1d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e1f:	eb 09                	jmp    800e2a <strncmp+0xe>
		n--, p++, q++;
  800e21:	ff 4d 10             	decl   0x10(%ebp)
  800e24:	ff 45 08             	incl   0x8(%ebp)
  800e27:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e2a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e2e:	74 17                	je     800e47 <strncmp+0x2b>
  800e30:	8b 45 08             	mov    0x8(%ebp),%eax
  800e33:	8a 00                	mov    (%eax),%al
  800e35:	84 c0                	test   %al,%al
  800e37:	74 0e                	je     800e47 <strncmp+0x2b>
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	8a 10                	mov    (%eax),%dl
  800e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	38 c2                	cmp    %al,%dl
  800e45:	74 da                	je     800e21 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e47:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e4b:	75 07                	jne    800e54 <strncmp+0x38>
		return 0;
  800e4d:	b8 00 00 00 00       	mov    $0x0,%eax
  800e52:	eb 14                	jmp    800e68 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	8a 00                	mov    (%eax),%al
  800e59:	0f b6 d0             	movzbl %al,%edx
  800e5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	0f b6 c0             	movzbl %al,%eax
  800e64:	29 c2                	sub    %eax,%edx
  800e66:	89 d0                	mov    %edx,%eax
}
  800e68:	5d                   	pop    %ebp
  800e69:	c3                   	ret    

00800e6a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e6a:	55                   	push   %ebp
  800e6b:	89 e5                	mov    %esp,%ebp
  800e6d:	83 ec 04             	sub    $0x4,%esp
  800e70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e73:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e76:	eb 12                	jmp    800e8a <strchr+0x20>
		if (*s == c)
  800e78:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7b:	8a 00                	mov    (%eax),%al
  800e7d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e80:	75 05                	jne    800e87 <strchr+0x1d>
			return (char *) s;
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	eb 11                	jmp    800e98 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e87:	ff 45 08             	incl   0x8(%ebp)
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	84 c0                	test   %al,%al
  800e91:	75 e5                	jne    800e78 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e93:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e98:	c9                   	leave  
  800e99:	c3                   	ret    

00800e9a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e9a:	55                   	push   %ebp
  800e9b:	89 e5                	mov    %esp,%ebp
  800e9d:	83 ec 04             	sub    $0x4,%esp
  800ea0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ea6:	eb 0d                	jmp    800eb5 <strfind+0x1b>
		if (*s == c)
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eab:	8a 00                	mov    (%eax),%al
  800ead:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eb0:	74 0e                	je     800ec0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800eb2:	ff 45 08             	incl   0x8(%ebp)
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	8a 00                	mov    (%eax),%al
  800eba:	84 c0                	test   %al,%al
  800ebc:	75 ea                	jne    800ea8 <strfind+0xe>
  800ebe:	eb 01                	jmp    800ec1 <strfind+0x27>
		if (*s == c)
			break;
  800ec0:	90                   	nop
	return (char *) s;
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec4:	c9                   	leave  
  800ec5:	c3                   	ret    

00800ec6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ec6:	55                   	push   %ebp
  800ec7:	89 e5                	mov    %esp,%ebp
  800ec9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ed2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ed8:	eb 0e                	jmp    800ee8 <memset+0x22>
		*p++ = c;
  800eda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800edd:	8d 50 01             	lea    0x1(%eax),%edx
  800ee0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ee3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ee6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ee8:	ff 4d f8             	decl   -0x8(%ebp)
  800eeb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800eef:	79 e9                	jns    800eda <memset+0x14>
		*p++ = c;

	return v;
  800ef1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ef4:	c9                   	leave  
  800ef5:	c3                   	ret    

00800ef6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ef6:	55                   	push   %ebp
  800ef7:	89 e5                	mov    %esp,%ebp
  800ef9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800efc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f08:	eb 16                	jmp    800f20 <memcpy+0x2a>
		*d++ = *s++;
  800f0a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f0d:	8d 50 01             	lea    0x1(%eax),%edx
  800f10:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f13:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f16:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f19:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f1c:	8a 12                	mov    (%edx),%dl
  800f1e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f20:	8b 45 10             	mov    0x10(%ebp),%eax
  800f23:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f26:	89 55 10             	mov    %edx,0x10(%ebp)
  800f29:	85 c0                	test   %eax,%eax
  800f2b:	75 dd                	jne    800f0a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f30:	c9                   	leave  
  800f31:	c3                   	ret    

00800f32 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f32:	55                   	push   %ebp
  800f33:	89 e5                	mov    %esp,%ebp
  800f35:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800f38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f41:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f47:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f4a:	73 50                	jae    800f9c <memmove+0x6a>
  800f4c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f52:	01 d0                	add    %edx,%eax
  800f54:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f57:	76 43                	jbe    800f9c <memmove+0x6a>
		s += n;
  800f59:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f62:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f65:	eb 10                	jmp    800f77 <memmove+0x45>
			*--d = *--s;
  800f67:	ff 4d f8             	decl   -0x8(%ebp)
  800f6a:	ff 4d fc             	decl   -0x4(%ebp)
  800f6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f70:	8a 10                	mov    (%eax),%dl
  800f72:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f75:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f77:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f7d:	89 55 10             	mov    %edx,0x10(%ebp)
  800f80:	85 c0                	test   %eax,%eax
  800f82:	75 e3                	jne    800f67 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f84:	eb 23                	jmp    800fa9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f86:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f89:	8d 50 01             	lea    0x1(%eax),%edx
  800f8c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f8f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f92:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f95:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f98:	8a 12                	mov    (%edx),%dl
  800f9a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f9c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fa2:	89 55 10             	mov    %edx,0x10(%ebp)
  800fa5:	85 c0                	test   %eax,%eax
  800fa7:	75 dd                	jne    800f86 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fa9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fac:	c9                   	leave  
  800fad:	c3                   	ret    

00800fae <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fae:	55                   	push   %ebp
  800faf:	89 e5                	mov    %esp,%ebp
  800fb1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbd:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fc0:	eb 2a                	jmp    800fec <memcmp+0x3e>
		if (*s1 != *s2)
  800fc2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc5:	8a 10                	mov    (%eax),%dl
  800fc7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	38 c2                	cmp    %al,%dl
  800fce:	74 16                	je     800fe6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800fd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fd3:	8a 00                	mov    (%eax),%al
  800fd5:	0f b6 d0             	movzbl %al,%edx
  800fd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	0f b6 c0             	movzbl %al,%eax
  800fe0:	29 c2                	sub    %eax,%edx
  800fe2:	89 d0                	mov    %edx,%eax
  800fe4:	eb 18                	jmp    800ffe <memcmp+0x50>
		s1++, s2++;
  800fe6:	ff 45 fc             	incl   -0x4(%ebp)
  800fe9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800fec:	8b 45 10             	mov    0x10(%ebp),%eax
  800fef:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ff2:	89 55 10             	mov    %edx,0x10(%ebp)
  800ff5:	85 c0                	test   %eax,%eax
  800ff7:	75 c9                	jne    800fc2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ff9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ffe:	c9                   	leave  
  800fff:	c3                   	ret    

00801000 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801000:	55                   	push   %ebp
  801001:	89 e5                	mov    %esp,%ebp
  801003:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801006:	8b 55 08             	mov    0x8(%ebp),%edx
  801009:	8b 45 10             	mov    0x10(%ebp),%eax
  80100c:	01 d0                	add    %edx,%eax
  80100e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801011:	eb 15                	jmp    801028 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	8a 00                	mov    (%eax),%al
  801018:	0f b6 d0             	movzbl %al,%edx
  80101b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101e:	0f b6 c0             	movzbl %al,%eax
  801021:	39 c2                	cmp    %eax,%edx
  801023:	74 0d                	je     801032 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801025:	ff 45 08             	incl   0x8(%ebp)
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80102e:	72 e3                	jb     801013 <memfind+0x13>
  801030:	eb 01                	jmp    801033 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801032:	90                   	nop
	return (void *) s;
  801033:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801036:	c9                   	leave  
  801037:	c3                   	ret    

00801038 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801038:	55                   	push   %ebp
  801039:	89 e5                	mov    %esp,%ebp
  80103b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80103e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801045:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80104c:	eb 03                	jmp    801051 <strtol+0x19>
		s++;
  80104e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	8a 00                	mov    (%eax),%al
  801056:	3c 20                	cmp    $0x20,%al
  801058:	74 f4                	je     80104e <strtol+0x16>
  80105a:	8b 45 08             	mov    0x8(%ebp),%eax
  80105d:	8a 00                	mov    (%eax),%al
  80105f:	3c 09                	cmp    $0x9,%al
  801061:	74 eb                	je     80104e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
  801066:	8a 00                	mov    (%eax),%al
  801068:	3c 2b                	cmp    $0x2b,%al
  80106a:	75 05                	jne    801071 <strtol+0x39>
		s++;
  80106c:	ff 45 08             	incl   0x8(%ebp)
  80106f:	eb 13                	jmp    801084 <strtol+0x4c>
	else if (*s == '-')
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	8a 00                	mov    (%eax),%al
  801076:	3c 2d                	cmp    $0x2d,%al
  801078:	75 0a                	jne    801084 <strtol+0x4c>
		s++, neg = 1;
  80107a:	ff 45 08             	incl   0x8(%ebp)
  80107d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801084:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801088:	74 06                	je     801090 <strtol+0x58>
  80108a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80108e:	75 20                	jne    8010b0 <strtol+0x78>
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	8a 00                	mov    (%eax),%al
  801095:	3c 30                	cmp    $0x30,%al
  801097:	75 17                	jne    8010b0 <strtol+0x78>
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	40                   	inc    %eax
  80109d:	8a 00                	mov    (%eax),%al
  80109f:	3c 78                	cmp    $0x78,%al
  8010a1:	75 0d                	jne    8010b0 <strtol+0x78>
		s += 2, base = 16;
  8010a3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010a7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010ae:	eb 28                	jmp    8010d8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010b0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b4:	75 15                	jne    8010cb <strtol+0x93>
  8010b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b9:	8a 00                	mov    (%eax),%al
  8010bb:	3c 30                	cmp    $0x30,%al
  8010bd:	75 0c                	jne    8010cb <strtol+0x93>
		s++, base = 8;
  8010bf:	ff 45 08             	incl   0x8(%ebp)
  8010c2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010c9:	eb 0d                	jmp    8010d8 <strtol+0xa0>
	else if (base == 0)
  8010cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010cf:	75 07                	jne    8010d8 <strtol+0xa0>
		base = 10;
  8010d1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010db:	8a 00                	mov    (%eax),%al
  8010dd:	3c 2f                	cmp    $0x2f,%al
  8010df:	7e 19                	jle    8010fa <strtol+0xc2>
  8010e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e4:	8a 00                	mov    (%eax),%al
  8010e6:	3c 39                	cmp    $0x39,%al
  8010e8:	7f 10                	jg     8010fa <strtol+0xc2>
			dig = *s - '0';
  8010ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	0f be c0             	movsbl %al,%eax
  8010f2:	83 e8 30             	sub    $0x30,%eax
  8010f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010f8:	eb 42                	jmp    80113c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8010fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fd:	8a 00                	mov    (%eax),%al
  8010ff:	3c 60                	cmp    $0x60,%al
  801101:	7e 19                	jle    80111c <strtol+0xe4>
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	3c 7a                	cmp    $0x7a,%al
  80110a:	7f 10                	jg     80111c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80110c:	8b 45 08             	mov    0x8(%ebp),%eax
  80110f:	8a 00                	mov    (%eax),%al
  801111:	0f be c0             	movsbl %al,%eax
  801114:	83 e8 57             	sub    $0x57,%eax
  801117:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80111a:	eb 20                	jmp    80113c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80111c:	8b 45 08             	mov    0x8(%ebp),%eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	3c 40                	cmp    $0x40,%al
  801123:	7e 39                	jle    80115e <strtol+0x126>
  801125:	8b 45 08             	mov    0x8(%ebp),%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	3c 5a                	cmp    $0x5a,%al
  80112c:	7f 30                	jg     80115e <strtol+0x126>
			dig = *s - 'A' + 10;
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	8a 00                	mov    (%eax),%al
  801133:	0f be c0             	movsbl %al,%eax
  801136:	83 e8 37             	sub    $0x37,%eax
  801139:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80113c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80113f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801142:	7d 19                	jge    80115d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801144:	ff 45 08             	incl   0x8(%ebp)
  801147:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80114e:	89 c2                	mov    %eax,%edx
  801150:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801153:	01 d0                	add    %edx,%eax
  801155:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801158:	e9 7b ff ff ff       	jmp    8010d8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80115d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80115e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801162:	74 08                	je     80116c <strtol+0x134>
		*endptr = (char *) s;
  801164:	8b 45 0c             	mov    0xc(%ebp),%eax
  801167:	8b 55 08             	mov    0x8(%ebp),%edx
  80116a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80116c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801170:	74 07                	je     801179 <strtol+0x141>
  801172:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801175:	f7 d8                	neg    %eax
  801177:	eb 03                	jmp    80117c <strtol+0x144>
  801179:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80117c:	c9                   	leave  
  80117d:	c3                   	ret    

0080117e <ltostr>:

void
ltostr(long value, char *str)
{
  80117e:	55                   	push   %ebp
  80117f:	89 e5                	mov    %esp,%ebp
  801181:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801184:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80118b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801192:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801196:	79 13                	jns    8011ab <ltostr+0x2d>
	{
		neg = 1;
  801198:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80119f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011a5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011a8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011b3:	99                   	cltd   
  8011b4:	f7 f9                	idiv   %ecx
  8011b6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011bc:	8d 50 01             	lea    0x1(%eax),%edx
  8011bf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011c2:	89 c2                	mov    %eax,%edx
  8011c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c7:	01 d0                	add    %edx,%eax
  8011c9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011cc:	83 c2 30             	add    $0x30,%edx
  8011cf:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011d4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011d9:	f7 e9                	imul   %ecx
  8011db:	c1 fa 02             	sar    $0x2,%edx
  8011de:	89 c8                	mov    %ecx,%eax
  8011e0:	c1 f8 1f             	sar    $0x1f,%eax
  8011e3:	29 c2                	sub    %eax,%edx
  8011e5:	89 d0                	mov    %edx,%eax
  8011e7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8011ea:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011ed:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011f2:	f7 e9                	imul   %ecx
  8011f4:	c1 fa 02             	sar    $0x2,%edx
  8011f7:	89 c8                	mov    %ecx,%eax
  8011f9:	c1 f8 1f             	sar    $0x1f,%eax
  8011fc:	29 c2                	sub    %eax,%edx
  8011fe:	89 d0                	mov    %edx,%eax
  801200:	c1 e0 02             	shl    $0x2,%eax
  801203:	01 d0                	add    %edx,%eax
  801205:	01 c0                	add    %eax,%eax
  801207:	29 c1                	sub    %eax,%ecx
  801209:	89 ca                	mov    %ecx,%edx
  80120b:	85 d2                	test   %edx,%edx
  80120d:	75 9c                	jne    8011ab <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80120f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801216:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801219:	48                   	dec    %eax
  80121a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80121d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801221:	74 3d                	je     801260 <ltostr+0xe2>
		start = 1 ;
  801223:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80122a:	eb 34                	jmp    801260 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80122c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80122f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801232:	01 d0                	add    %edx,%eax
  801234:	8a 00                	mov    (%eax),%al
  801236:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801239:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80123c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123f:	01 c2                	add    %eax,%edx
  801241:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801244:	8b 45 0c             	mov    0xc(%ebp),%eax
  801247:	01 c8                	add    %ecx,%eax
  801249:	8a 00                	mov    (%eax),%al
  80124b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80124d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801250:	8b 45 0c             	mov    0xc(%ebp),%eax
  801253:	01 c2                	add    %eax,%edx
  801255:	8a 45 eb             	mov    -0x15(%ebp),%al
  801258:	88 02                	mov    %al,(%edx)
		start++ ;
  80125a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80125d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801260:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801263:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801266:	7c c4                	jl     80122c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801268:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80126b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126e:	01 d0                	add    %edx,%eax
  801270:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801273:	90                   	nop
  801274:	c9                   	leave  
  801275:	c3                   	ret    

00801276 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801276:	55                   	push   %ebp
  801277:	89 e5                	mov    %esp,%ebp
  801279:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80127c:	ff 75 08             	pushl  0x8(%ebp)
  80127f:	e8 54 fa ff ff       	call   800cd8 <strlen>
  801284:	83 c4 04             	add    $0x4,%esp
  801287:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80128a:	ff 75 0c             	pushl  0xc(%ebp)
  80128d:	e8 46 fa ff ff       	call   800cd8 <strlen>
  801292:	83 c4 04             	add    $0x4,%esp
  801295:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801298:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80129f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012a6:	eb 17                	jmp    8012bf <strcconcat+0x49>
		final[s] = str1[s] ;
  8012a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ae:	01 c2                	add    %eax,%edx
  8012b0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	01 c8                	add    %ecx,%eax
  8012b8:	8a 00                	mov    (%eax),%al
  8012ba:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012bc:	ff 45 fc             	incl   -0x4(%ebp)
  8012bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012c5:	7c e1                	jl     8012a8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012c7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012ce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012d5:	eb 1f                	jmp    8012f6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012da:	8d 50 01             	lea    0x1(%eax),%edx
  8012dd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012e0:	89 c2                	mov    %eax,%edx
  8012e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e5:	01 c2                	add    %eax,%edx
  8012e7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8012ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ed:	01 c8                	add    %ecx,%eax
  8012ef:	8a 00                	mov    (%eax),%al
  8012f1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8012f3:	ff 45 f8             	incl   -0x8(%ebp)
  8012f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012fc:	7c d9                	jl     8012d7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8012fe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801301:	8b 45 10             	mov    0x10(%ebp),%eax
  801304:	01 d0                	add    %edx,%eax
  801306:	c6 00 00             	movb   $0x0,(%eax)
}
  801309:	90                   	nop
  80130a:	c9                   	leave  
  80130b:	c3                   	ret    

0080130c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80130c:	55                   	push   %ebp
  80130d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80130f:	8b 45 14             	mov    0x14(%ebp),%eax
  801312:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801318:	8b 45 14             	mov    0x14(%ebp),%eax
  80131b:	8b 00                	mov    (%eax),%eax
  80131d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801324:	8b 45 10             	mov    0x10(%ebp),%eax
  801327:	01 d0                	add    %edx,%eax
  801329:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80132f:	eb 0c                	jmp    80133d <strsplit+0x31>
			*string++ = 0;
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	8d 50 01             	lea    0x1(%eax),%edx
  801337:	89 55 08             	mov    %edx,0x8(%ebp)
  80133a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80133d:	8b 45 08             	mov    0x8(%ebp),%eax
  801340:	8a 00                	mov    (%eax),%al
  801342:	84 c0                	test   %al,%al
  801344:	74 18                	je     80135e <strsplit+0x52>
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	8a 00                	mov    (%eax),%al
  80134b:	0f be c0             	movsbl %al,%eax
  80134e:	50                   	push   %eax
  80134f:	ff 75 0c             	pushl  0xc(%ebp)
  801352:	e8 13 fb ff ff       	call   800e6a <strchr>
  801357:	83 c4 08             	add    $0x8,%esp
  80135a:	85 c0                	test   %eax,%eax
  80135c:	75 d3                	jne    801331 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80135e:	8b 45 08             	mov    0x8(%ebp),%eax
  801361:	8a 00                	mov    (%eax),%al
  801363:	84 c0                	test   %al,%al
  801365:	74 5a                	je     8013c1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801367:	8b 45 14             	mov    0x14(%ebp),%eax
  80136a:	8b 00                	mov    (%eax),%eax
  80136c:	83 f8 0f             	cmp    $0xf,%eax
  80136f:	75 07                	jne    801378 <strsplit+0x6c>
		{
			return 0;
  801371:	b8 00 00 00 00       	mov    $0x0,%eax
  801376:	eb 66                	jmp    8013de <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801378:	8b 45 14             	mov    0x14(%ebp),%eax
  80137b:	8b 00                	mov    (%eax),%eax
  80137d:	8d 48 01             	lea    0x1(%eax),%ecx
  801380:	8b 55 14             	mov    0x14(%ebp),%edx
  801383:	89 0a                	mov    %ecx,(%edx)
  801385:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80138c:	8b 45 10             	mov    0x10(%ebp),%eax
  80138f:	01 c2                	add    %eax,%edx
  801391:	8b 45 08             	mov    0x8(%ebp),%eax
  801394:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801396:	eb 03                	jmp    80139b <strsplit+0x8f>
			string++;
  801398:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	8a 00                	mov    (%eax),%al
  8013a0:	84 c0                	test   %al,%al
  8013a2:	74 8b                	je     80132f <strsplit+0x23>
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	0f be c0             	movsbl %al,%eax
  8013ac:	50                   	push   %eax
  8013ad:	ff 75 0c             	pushl  0xc(%ebp)
  8013b0:	e8 b5 fa ff ff       	call   800e6a <strchr>
  8013b5:	83 c4 08             	add    $0x8,%esp
  8013b8:	85 c0                	test   %eax,%eax
  8013ba:	74 dc                	je     801398 <strsplit+0x8c>
			string++;
	}
  8013bc:	e9 6e ff ff ff       	jmp    80132f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013c1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c5:	8b 00                	mov    (%eax),%eax
  8013c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d1:	01 d0                	add    %edx,%eax
  8013d3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013d9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013de:	c9                   	leave  
  8013df:	c3                   	ret    

008013e0 <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
  8013e3:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  8013e6:	a1 04 30 80 00       	mov    0x803004,%eax
  8013eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  8013f5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8013fc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  801403:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  80140a:	e9 f9 00 00 00       	jmp    801508 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  80140f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801412:	05 00 00 00 80       	add    $0x80000000,%eax
  801417:	c1 e8 0c             	shr    $0xc,%eax
  80141a:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801421:	85 c0                	test   %eax,%eax
  801423:	75 1c                	jne    801441 <nextFitAlgo+0x61>
  801425:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801429:	74 16                	je     801441 <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  80142b:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801432:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801439:	ff 4d e0             	decl   -0x20(%ebp)
  80143c:	e9 90 00 00 00       	jmp    8014d1 <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  801441:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801444:	05 00 00 00 80       	add    $0x80000000,%eax
  801449:	c1 e8 0c             	shr    $0xc,%eax
  80144c:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801453:	85 c0                	test   %eax,%eax
  801455:	75 26                	jne    80147d <nextFitAlgo+0x9d>
  801457:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  80145b:	75 20                	jne    80147d <nextFitAlgo+0x9d>
			flag = 1;
  80145d:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  801464:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801467:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  80146a:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801471:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801478:	ff 4d e0             	decl   -0x20(%ebp)
  80147b:	eb 54                	jmp    8014d1 <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  80147d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801480:	3b 45 08             	cmp    0x8(%ebp),%eax
  801483:	72 11                	jb     801496 <nextFitAlgo+0xb6>
				startAdd = tmp;
  801485:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801488:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  80148d:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  801494:	eb 7c                	jmp    801512 <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  801496:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801499:	05 00 00 00 80       	add    $0x80000000,%eax
  80149e:	c1 e8 0c             	shr    $0xc,%eax
  8014a1:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8014a8:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  8014ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ae:	05 00 00 00 80       	add    $0x80000000,%eax
  8014b3:	c1 e8 0c             	shr    $0xc,%eax
  8014b6:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8014bd:	c1 e0 0c             	shl    $0xc,%eax
  8014c0:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  8014c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8014ca:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  8014d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014d4:	3b 45 08             	cmp    0x8(%ebp),%eax
  8014d7:	72 11                	jb     8014ea <nextFitAlgo+0x10a>
			startAdd = tmp;
  8014d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014dc:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  8014e1:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  8014e8:	eb 28                	jmp    801512 <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  8014ea:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  8014f1:	76 15                	jbe    801508 <nextFitAlgo+0x128>
			flag = newSize = 0;
  8014f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8014fa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  801501:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  801508:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80150c:	0f 85 fd fe ff ff    	jne    80140f <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  801512:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801516:	75 1a                	jne    801532 <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  801518:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80151b:	3b 45 08             	cmp    0x8(%ebp),%eax
  80151e:	73 0a                	jae    80152a <nextFitAlgo+0x14a>
  801520:	b8 00 00 00 00       	mov    $0x0,%eax
  801525:	e9 99 00 00 00       	jmp    8015c3 <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  80152a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80152d:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  801532:	a1 04 30 80 00       	mov    0x803004,%eax
  801537:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  80153a:	a1 04 30 80 00       	mov    0x803004,%eax
  80153f:	05 00 00 00 80       	add    $0x80000000,%eax
  801544:	c1 e8 0c             	shr    $0xc,%eax
  801547:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  80154a:	8b 45 08             	mov    0x8(%ebp),%eax
  80154d:	c1 e8 0c             	shr    $0xc,%eax
  801550:	89 c2                	mov    %eax,%edx
  801552:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801555:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  80155c:	a1 04 30 80 00       	mov    0x803004,%eax
  801561:	83 ec 08             	sub    $0x8,%esp
  801564:	ff 75 08             	pushl  0x8(%ebp)
  801567:	50                   	push   %eax
  801568:	e8 82 03 00 00       	call   8018ef <sys_allocateMem>
  80156d:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  801570:	a1 04 30 80 00       	mov    0x803004,%eax
  801575:	05 00 00 00 80       	add    $0x80000000,%eax
  80157a:	c1 e8 0c             	shr    $0xc,%eax
  80157d:	89 c2                	mov    %eax,%edx
  80157f:	a1 04 30 80 00       	mov    0x803004,%eax
  801584:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  80158b:	a1 04 30 80 00       	mov    0x803004,%eax
  801590:	05 00 00 00 80       	add    $0x80000000,%eax
  801595:	c1 e8 0c             	shr    $0xc,%eax
  801598:	89 c2                	mov    %eax,%edx
  80159a:	8b 45 08             	mov    0x8(%ebp),%eax
  80159d:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  8015a4:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8015aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ad:	01 d0                	add    %edx,%eax
  8015af:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  8015b4:	76 0a                	jbe    8015c0 <nextFitAlgo+0x1e0>
  8015b6:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  8015bd:	00 00 80 

	return (void*)returnHolder;
  8015c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <malloc>:

void* malloc(uint32 size) {
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
  8015c8:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  8015cb:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  8015d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8015d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015d8:	01 d0                	add    %edx,%eax
  8015da:	48                   	dec    %eax
  8015db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015e1:	ba 00 00 00 00       	mov    $0x0,%edx
  8015e6:	f7 75 f4             	divl   -0xc(%ebp)
  8015e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015ec:	29 d0                	sub    %edx,%eax
  8015ee:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  8015f1:	e8 c3 06 00 00       	call   801cb9 <sys_isUHeapPlacementStrategyNEXTFIT>
  8015f6:	85 c0                	test   %eax,%eax
  8015f8:	74 10                	je     80160a <malloc+0x45>
		return nextFitAlgo(size);
  8015fa:	83 ec 0c             	sub    $0xc,%esp
  8015fd:	ff 75 08             	pushl  0x8(%ebp)
  801600:	e8 db fd ff ff       	call   8013e0 <nextFitAlgo>
  801605:	83 c4 10             	add    $0x10,%esp
  801608:	eb 0a                	jmp    801614 <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  80160a:	e8 79 06 00 00       	call   801c88 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  80160f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801614:	c9                   	leave  
  801615:	c3                   	ret    

00801616 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801616:	55                   	push   %ebp
  801617:	89 e5                	mov    %esp,%ebp
  801619:	83 ec 18             	sub    $0x18,%esp
  80161c:	8b 45 10             	mov    0x10(%ebp),%eax
  80161f:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801622:	83 ec 04             	sub    $0x4,%esp
  801625:	68 f0 25 80 00       	push   $0x8025f0
  80162a:	6a 7e                	push   $0x7e
  80162c:	68 0f 26 80 00       	push   $0x80260f
  801631:	e8 00 07 00 00       	call   801d36 <_panic>

00801636 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801636:	55                   	push   %ebp
  801637:	89 e5                	mov    %esp,%ebp
  801639:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  80163c:	83 ec 04             	sub    $0x4,%esp
  80163f:	68 1b 26 80 00       	push   $0x80261b
  801644:	68 84 00 00 00       	push   $0x84
  801649:	68 0f 26 80 00       	push   $0x80260f
  80164e:	e8 e3 06 00 00       	call   801d36 <_panic>

00801653 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801653:	55                   	push   %ebp
  801654:	89 e5                	mov    %esp,%ebp
  801656:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801659:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801660:	eb 61                	jmp    8016c3 <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  801662:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801665:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	39 c2                	cmp    %eax,%edx
  801671:	75 4d                	jne    8016c0 <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
  801676:	05 00 00 00 80       	add    $0x80000000,%eax
  80167b:	c1 e8 0c             	shr    $0xc,%eax
  80167e:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801681:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801684:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  80168b:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  80168e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801691:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  801698:	00 00 00 00 
  80169c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80169f:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  8016a6:	00 00 00 00 
  8016aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016ad:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  8016b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016b7:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  8016be:	eb 0d                	jmp    8016cd <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8016c0:	ff 45 f0             	incl   -0x10(%ebp)
  8016c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016c6:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8016cb:	76 95                	jbe    801662 <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  8016cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d0:	83 ec 08             	sub    $0x8,%esp
  8016d3:	ff 75 f4             	pushl  -0xc(%ebp)
  8016d6:	50                   	push   %eax
  8016d7:	e8 f7 01 00 00       	call   8018d3 <sys_freeMem>
  8016dc:	83 c4 10             	add    $0x10,%esp
}
  8016df:	90                   	nop
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <sfree>:


void sfree(void* virtual_address)
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
  8016e5:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8016e8:	83 ec 04             	sub    $0x4,%esp
  8016eb:	68 37 26 80 00       	push   $0x802637
  8016f0:	68 ac 00 00 00       	push   $0xac
  8016f5:	68 0f 26 80 00       	push   $0x80260f
  8016fa:	e8 37 06 00 00       	call   801d36 <_panic>

008016ff <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
  801702:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801705:	83 ec 04             	sub    $0x4,%esp
  801708:	68 54 26 80 00       	push   $0x802654
  80170d:	68 c4 00 00 00       	push   $0xc4
  801712:	68 0f 26 80 00       	push   $0x80260f
  801717:	e8 1a 06 00 00       	call   801d36 <_panic>

0080171c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80171c:	55                   	push   %ebp
  80171d:	89 e5                	mov    %esp,%ebp
  80171f:	57                   	push   %edi
  801720:	56                   	push   %esi
  801721:	53                   	push   %ebx
  801722:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	8b 55 0c             	mov    0xc(%ebp),%edx
  80172b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80172e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801731:	8b 7d 18             	mov    0x18(%ebp),%edi
  801734:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801737:	cd 30                	int    $0x30
  801739:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80173c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80173f:	83 c4 10             	add    $0x10,%esp
  801742:	5b                   	pop    %ebx
  801743:	5e                   	pop    %esi
  801744:	5f                   	pop    %edi
  801745:	5d                   	pop    %ebp
  801746:	c3                   	ret    

00801747 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801747:	55                   	push   %ebp
  801748:	89 e5                	mov    %esp,%ebp
  80174a:	83 ec 04             	sub    $0x4,%esp
  80174d:	8b 45 10             	mov    0x10(%ebp),%eax
  801750:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801753:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801757:	8b 45 08             	mov    0x8(%ebp),%eax
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	52                   	push   %edx
  80175f:	ff 75 0c             	pushl  0xc(%ebp)
  801762:	50                   	push   %eax
  801763:	6a 00                	push   $0x0
  801765:	e8 b2 ff ff ff       	call   80171c <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
}
  80176d:	90                   	nop
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <sys_cgetc>:

int
sys_cgetc(void)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 01                	push   $0x1
  80177f:	e8 98 ff ff ff       	call   80171c <syscall>
  801784:	83 c4 18             	add    $0x18,%esp
}
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	50                   	push   %eax
  801798:	6a 05                	push   $0x5
  80179a:	e8 7d ff ff ff       	call   80171c <syscall>
  80179f:	83 c4 18             	add    $0x18,%esp
}
  8017a2:	c9                   	leave  
  8017a3:	c3                   	ret    

008017a4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017a4:	55                   	push   %ebp
  8017a5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 02                	push   $0x2
  8017b3:	e8 64 ff ff ff       	call   80171c <syscall>
  8017b8:	83 c4 18             	add    $0x18,%esp
}
  8017bb:	c9                   	leave  
  8017bc:	c3                   	ret    

008017bd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017bd:	55                   	push   %ebp
  8017be:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 03                	push   $0x3
  8017cc:	e8 4b ff ff ff       	call   80171c <syscall>
  8017d1:	83 c4 18             	add    $0x18,%esp
}
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 04                	push   $0x4
  8017e5:	e8 32 ff ff ff       	call   80171c <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_env_exit>:


void sys_env_exit(void)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 06                	push   $0x6
  8017fe:	e8 19 ff ff ff       	call   80171c <syscall>
  801803:	83 c4 18             	add    $0x18,%esp
}
  801806:	90                   	nop
  801807:	c9                   	leave  
  801808:	c3                   	ret    

00801809 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801809:	55                   	push   %ebp
  80180a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80180c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80180f:	8b 45 08             	mov    0x8(%ebp),%eax
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	52                   	push   %edx
  801819:	50                   	push   %eax
  80181a:	6a 07                	push   $0x7
  80181c:	e8 fb fe ff ff       	call   80171c <syscall>
  801821:	83 c4 18             	add    $0x18,%esp
}
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
  801829:	56                   	push   %esi
  80182a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80182b:	8b 75 18             	mov    0x18(%ebp),%esi
  80182e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801831:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801834:	8b 55 0c             	mov    0xc(%ebp),%edx
  801837:	8b 45 08             	mov    0x8(%ebp),%eax
  80183a:	56                   	push   %esi
  80183b:	53                   	push   %ebx
  80183c:	51                   	push   %ecx
  80183d:	52                   	push   %edx
  80183e:	50                   	push   %eax
  80183f:	6a 08                	push   $0x8
  801841:	e8 d6 fe ff ff       	call   80171c <syscall>
  801846:	83 c4 18             	add    $0x18,%esp
}
  801849:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80184c:	5b                   	pop    %ebx
  80184d:	5e                   	pop    %esi
  80184e:	5d                   	pop    %ebp
  80184f:	c3                   	ret    

00801850 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801853:	8b 55 0c             	mov    0xc(%ebp),%edx
  801856:	8b 45 08             	mov    0x8(%ebp),%eax
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	52                   	push   %edx
  801860:	50                   	push   %eax
  801861:	6a 09                	push   $0x9
  801863:	e8 b4 fe ff ff       	call   80171c <syscall>
  801868:	83 c4 18             	add    $0x18,%esp
}
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	ff 75 0c             	pushl  0xc(%ebp)
  801879:	ff 75 08             	pushl  0x8(%ebp)
  80187c:	6a 0a                	push   $0xa
  80187e:	e8 99 fe ff ff       	call   80171c <syscall>
  801883:	83 c4 18             	add    $0x18,%esp
}
  801886:	c9                   	leave  
  801887:	c3                   	ret    

00801888 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801888:	55                   	push   %ebp
  801889:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 0b                	push   $0xb
  801897:	e8 80 fe ff ff       	call   80171c <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
}
  80189f:	c9                   	leave  
  8018a0:	c3                   	ret    

008018a1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018a1:	55                   	push   %ebp
  8018a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 0c                	push   $0xc
  8018b0:	e8 67 fe ff ff       	call   80171c <syscall>
  8018b5:	83 c4 18             	add    $0x18,%esp
}
  8018b8:	c9                   	leave  
  8018b9:	c3                   	ret    

008018ba <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018ba:	55                   	push   %ebp
  8018bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 0d                	push   $0xd
  8018c9:	e8 4e fe ff ff       	call   80171c <syscall>
  8018ce:	83 c4 18             	add    $0x18,%esp
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	ff 75 0c             	pushl  0xc(%ebp)
  8018df:	ff 75 08             	pushl  0x8(%ebp)
  8018e2:	6a 11                	push   $0x11
  8018e4:	e8 33 fe ff ff       	call   80171c <syscall>
  8018e9:	83 c4 18             	add    $0x18,%esp
	return;
  8018ec:	90                   	nop
}
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	ff 75 0c             	pushl  0xc(%ebp)
  8018fb:	ff 75 08             	pushl  0x8(%ebp)
  8018fe:	6a 12                	push   $0x12
  801900:	e8 17 fe ff ff       	call   80171c <syscall>
  801905:	83 c4 18             	add    $0x18,%esp
	return ;
  801908:	90                   	nop
}
  801909:	c9                   	leave  
  80190a:	c3                   	ret    

0080190b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80190b:	55                   	push   %ebp
  80190c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 0e                	push   $0xe
  80191a:	e8 fd fd ff ff       	call   80171c <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	ff 75 08             	pushl  0x8(%ebp)
  801932:	6a 0f                	push   $0xf
  801934:	e8 e3 fd ff ff       	call   80171c <syscall>
  801939:	83 c4 18             	add    $0x18,%esp
}
  80193c:	c9                   	leave  
  80193d:	c3                   	ret    

0080193e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80193e:	55                   	push   %ebp
  80193f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 10                	push   $0x10
  80194d:	e8 ca fd ff ff       	call   80171c <syscall>
  801952:	83 c4 18             	add    $0x18,%esp
}
  801955:	90                   	nop
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 14                	push   $0x14
  801967:	e8 b0 fd ff ff       	call   80171c <syscall>
  80196c:	83 c4 18             	add    $0x18,%esp
}
  80196f:	90                   	nop
  801970:	c9                   	leave  
  801971:	c3                   	ret    

00801972 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801972:	55                   	push   %ebp
  801973:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 15                	push   $0x15
  801981:	e8 96 fd ff ff       	call   80171c <syscall>
  801986:	83 c4 18             	add    $0x18,%esp
}
  801989:	90                   	nop
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <sys_cputc>:


void
sys_cputc(const char c)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
  80198f:	83 ec 04             	sub    $0x4,%esp
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801998:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	50                   	push   %eax
  8019a5:	6a 16                	push   $0x16
  8019a7:	e8 70 fd ff ff       	call   80171c <syscall>
  8019ac:	83 c4 18             	add    $0x18,%esp
}
  8019af:	90                   	nop
  8019b0:	c9                   	leave  
  8019b1:	c3                   	ret    

008019b2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 17                	push   $0x17
  8019c1:	e8 56 fd ff ff       	call   80171c <syscall>
  8019c6:	83 c4 18             	add    $0x18,%esp
}
  8019c9:	90                   	nop
  8019ca:	c9                   	leave  
  8019cb:	c3                   	ret    

008019cc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019cc:	55                   	push   %ebp
  8019cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	ff 75 0c             	pushl  0xc(%ebp)
  8019db:	50                   	push   %eax
  8019dc:	6a 18                	push   $0x18
  8019de:	e8 39 fd ff ff       	call   80171c <syscall>
  8019e3:	83 c4 18             	add    $0x18,%esp
}
  8019e6:	c9                   	leave  
  8019e7:	c3                   	ret    

008019e8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019e8:	55                   	push   %ebp
  8019e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	52                   	push   %edx
  8019f8:	50                   	push   %eax
  8019f9:	6a 1b                	push   $0x1b
  8019fb:	e8 1c fd ff ff       	call   80171c <syscall>
  801a00:	83 c4 18             	add    $0x18,%esp
}
  801a03:	c9                   	leave  
  801a04:	c3                   	ret    

00801a05 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a05:	55                   	push   %ebp
  801a06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a08:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	52                   	push   %edx
  801a15:	50                   	push   %eax
  801a16:	6a 19                	push   $0x19
  801a18:	e8 ff fc ff ff       	call   80171c <syscall>
  801a1d:	83 c4 18             	add    $0x18,%esp
}
  801a20:	90                   	nop
  801a21:	c9                   	leave  
  801a22:	c3                   	ret    

00801a23 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a23:	55                   	push   %ebp
  801a24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a26:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a29:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	52                   	push   %edx
  801a33:	50                   	push   %eax
  801a34:	6a 1a                	push   $0x1a
  801a36:	e8 e1 fc ff ff       	call   80171c <syscall>
  801a3b:	83 c4 18             	add    $0x18,%esp
}
  801a3e:	90                   	nop
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
  801a44:	83 ec 04             	sub    $0x4,%esp
  801a47:	8b 45 10             	mov    0x10(%ebp),%eax
  801a4a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a4d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a50:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a54:	8b 45 08             	mov    0x8(%ebp),%eax
  801a57:	6a 00                	push   $0x0
  801a59:	51                   	push   %ecx
  801a5a:	52                   	push   %edx
  801a5b:	ff 75 0c             	pushl  0xc(%ebp)
  801a5e:	50                   	push   %eax
  801a5f:	6a 1c                	push   $0x1c
  801a61:	e8 b6 fc ff ff       	call   80171c <syscall>
  801a66:	83 c4 18             	add    $0x18,%esp
}
  801a69:	c9                   	leave  
  801a6a:	c3                   	ret    

00801a6b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a6b:	55                   	push   %ebp
  801a6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a71:	8b 45 08             	mov    0x8(%ebp),%eax
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	52                   	push   %edx
  801a7b:	50                   	push   %eax
  801a7c:	6a 1d                	push   $0x1d
  801a7e:	e8 99 fc ff ff       	call   80171c <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
}
  801a86:	c9                   	leave  
  801a87:	c3                   	ret    

00801a88 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a8b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a91:	8b 45 08             	mov    0x8(%ebp),%eax
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	51                   	push   %ecx
  801a99:	52                   	push   %edx
  801a9a:	50                   	push   %eax
  801a9b:	6a 1e                	push   $0x1e
  801a9d:	e8 7a fc ff ff       	call   80171c <syscall>
  801aa2:	83 c4 18             	add    $0x18,%esp
}
  801aa5:	c9                   	leave  
  801aa6:	c3                   	ret    

00801aa7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801aaa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aad:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	52                   	push   %edx
  801ab7:	50                   	push   %eax
  801ab8:	6a 1f                	push   $0x1f
  801aba:	e8 5d fc ff ff       	call   80171c <syscall>
  801abf:	83 c4 18             	add    $0x18,%esp
}
  801ac2:	c9                   	leave  
  801ac3:	c3                   	ret    

00801ac4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ac4:	55                   	push   %ebp
  801ac5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 20                	push   $0x20
  801ad3:	e8 44 fc ff ff       	call   80171c <syscall>
  801ad8:	83 c4 18             	add    $0x18,%esp
}
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	ff 75 10             	pushl  0x10(%ebp)
  801aea:	ff 75 0c             	pushl  0xc(%ebp)
  801aed:	50                   	push   %eax
  801aee:	6a 21                	push   $0x21
  801af0:	e8 27 fc ff ff       	call   80171c <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
}
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801afd:	8b 45 08             	mov    0x8(%ebp),%eax
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	50                   	push   %eax
  801b09:	6a 22                	push   $0x22
  801b0b:	e8 0c fc ff ff       	call   80171c <syscall>
  801b10:	83 c4 18             	add    $0x18,%esp
}
  801b13:	90                   	nop
  801b14:	c9                   	leave  
  801b15:	c3                   	ret    

00801b16 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b16:	55                   	push   %ebp
  801b17:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b19:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	50                   	push   %eax
  801b25:	6a 23                	push   $0x23
  801b27:	e8 f0 fb ff ff       	call   80171c <syscall>
  801b2c:	83 c4 18             	add    $0x18,%esp
}
  801b2f:	90                   	nop
  801b30:	c9                   	leave  
  801b31:	c3                   	ret    

00801b32 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b32:	55                   	push   %ebp
  801b33:	89 e5                	mov    %esp,%ebp
  801b35:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b38:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b3b:	8d 50 04             	lea    0x4(%eax),%edx
  801b3e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	52                   	push   %edx
  801b48:	50                   	push   %eax
  801b49:	6a 24                	push   $0x24
  801b4b:	e8 cc fb ff ff       	call   80171c <syscall>
  801b50:	83 c4 18             	add    $0x18,%esp
	return result;
  801b53:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b56:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b59:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b5c:	89 01                	mov    %eax,(%ecx)
  801b5e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b61:	8b 45 08             	mov    0x8(%ebp),%eax
  801b64:	c9                   	leave  
  801b65:	c2 04 00             	ret    $0x4

00801b68 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b68:	55                   	push   %ebp
  801b69:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	ff 75 10             	pushl  0x10(%ebp)
  801b72:	ff 75 0c             	pushl  0xc(%ebp)
  801b75:	ff 75 08             	pushl  0x8(%ebp)
  801b78:	6a 13                	push   $0x13
  801b7a:	e8 9d fb ff ff       	call   80171c <syscall>
  801b7f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b82:	90                   	nop
}
  801b83:	c9                   	leave  
  801b84:	c3                   	ret    

00801b85 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b85:	55                   	push   %ebp
  801b86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 25                	push   $0x25
  801b94:	e8 83 fb ff ff       	call   80171c <syscall>
  801b99:	83 c4 18             	add    $0x18,%esp
}
  801b9c:	c9                   	leave  
  801b9d:	c3                   	ret    

00801b9e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b9e:	55                   	push   %ebp
  801b9f:	89 e5                	mov    %esp,%ebp
  801ba1:	83 ec 04             	sub    $0x4,%esp
  801ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801baa:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	50                   	push   %eax
  801bb7:	6a 26                	push   $0x26
  801bb9:	e8 5e fb ff ff       	call   80171c <syscall>
  801bbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc1:	90                   	nop
}
  801bc2:	c9                   	leave  
  801bc3:	c3                   	ret    

00801bc4 <rsttst>:
void rsttst()
{
  801bc4:	55                   	push   %ebp
  801bc5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 28                	push   $0x28
  801bd3:	e8 44 fb ff ff       	call   80171c <syscall>
  801bd8:	83 c4 18             	add    $0x18,%esp
	return ;
  801bdb:	90                   	nop
}
  801bdc:	c9                   	leave  
  801bdd:	c3                   	ret    

00801bde <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bde:	55                   	push   %ebp
  801bdf:	89 e5                	mov    %esp,%ebp
  801be1:	83 ec 04             	sub    $0x4,%esp
  801be4:	8b 45 14             	mov    0x14(%ebp),%eax
  801be7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bea:	8b 55 18             	mov    0x18(%ebp),%edx
  801bed:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bf1:	52                   	push   %edx
  801bf2:	50                   	push   %eax
  801bf3:	ff 75 10             	pushl  0x10(%ebp)
  801bf6:	ff 75 0c             	pushl  0xc(%ebp)
  801bf9:	ff 75 08             	pushl  0x8(%ebp)
  801bfc:	6a 27                	push   $0x27
  801bfe:	e8 19 fb ff ff       	call   80171c <syscall>
  801c03:	83 c4 18             	add    $0x18,%esp
	return ;
  801c06:	90                   	nop
}
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <chktst>:
void chktst(uint32 n)
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	ff 75 08             	pushl  0x8(%ebp)
  801c17:	6a 29                	push   $0x29
  801c19:	e8 fe fa ff ff       	call   80171c <syscall>
  801c1e:	83 c4 18             	add    $0x18,%esp
	return ;
  801c21:	90                   	nop
}
  801c22:	c9                   	leave  
  801c23:	c3                   	ret    

00801c24 <inctst>:

void inctst()
{
  801c24:	55                   	push   %ebp
  801c25:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 2a                	push   $0x2a
  801c33:	e8 e4 fa ff ff       	call   80171c <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
	return ;
  801c3b:	90                   	nop
}
  801c3c:	c9                   	leave  
  801c3d:	c3                   	ret    

00801c3e <gettst>:
uint32 gettst()
{
  801c3e:	55                   	push   %ebp
  801c3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 2b                	push   $0x2b
  801c4d:	e8 ca fa ff ff       	call   80171c <syscall>
  801c52:	83 c4 18             	add    $0x18,%esp
}
  801c55:	c9                   	leave  
  801c56:	c3                   	ret    

00801c57 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c57:	55                   	push   %ebp
  801c58:	89 e5                	mov    %esp,%ebp
  801c5a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 2c                	push   $0x2c
  801c69:	e8 ae fa ff ff       	call   80171c <syscall>
  801c6e:	83 c4 18             	add    $0x18,%esp
  801c71:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c74:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c78:	75 07                	jne    801c81 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c7f:	eb 05                	jmp    801c86 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c81:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c86:	c9                   	leave  
  801c87:	c3                   	ret    

00801c88 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c88:	55                   	push   %ebp
  801c89:	89 e5                	mov    %esp,%ebp
  801c8b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 2c                	push   $0x2c
  801c9a:	e8 7d fa ff ff       	call   80171c <syscall>
  801c9f:	83 c4 18             	add    $0x18,%esp
  801ca2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ca5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ca9:	75 07                	jne    801cb2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cab:	b8 01 00 00 00       	mov    $0x1,%eax
  801cb0:	eb 05                	jmp    801cb7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cb2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cb7:	c9                   	leave  
  801cb8:	c3                   	ret    

00801cb9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cb9:	55                   	push   %ebp
  801cba:	89 e5                	mov    %esp,%ebp
  801cbc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 2c                	push   $0x2c
  801ccb:	e8 4c fa ff ff       	call   80171c <syscall>
  801cd0:	83 c4 18             	add    $0x18,%esp
  801cd3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cd6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cda:	75 07                	jne    801ce3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cdc:	b8 01 00 00 00       	mov    $0x1,%eax
  801ce1:	eb 05                	jmp    801ce8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ce3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ce8:	c9                   	leave  
  801ce9:	c3                   	ret    

00801cea <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cea:	55                   	push   %ebp
  801ceb:	89 e5                	mov    %esp,%ebp
  801ced:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 2c                	push   $0x2c
  801cfc:	e8 1b fa ff ff       	call   80171c <syscall>
  801d01:	83 c4 18             	add    $0x18,%esp
  801d04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d07:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d0b:	75 07                	jne    801d14 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d0d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d12:	eb 05                	jmp    801d19 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d14:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d19:	c9                   	leave  
  801d1a:	c3                   	ret    

00801d1b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	ff 75 08             	pushl  0x8(%ebp)
  801d29:	6a 2d                	push   $0x2d
  801d2b:	e8 ec f9 ff ff       	call   80171c <syscall>
  801d30:	83 c4 18             	add    $0x18,%esp
	return ;
  801d33:	90                   	nop
}
  801d34:	c9                   	leave  
  801d35:	c3                   	ret    

00801d36 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
  801d39:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801d3c:	8d 45 10             	lea    0x10(%ebp),%eax
  801d3f:	83 c0 04             	add    $0x4,%eax
  801d42:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801d45:	a1 60 30 98 00       	mov    0x983060,%eax
  801d4a:	85 c0                	test   %eax,%eax
  801d4c:	74 16                	je     801d64 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801d4e:	a1 60 30 98 00       	mov    0x983060,%eax
  801d53:	83 ec 08             	sub    $0x8,%esp
  801d56:	50                   	push   %eax
  801d57:	68 7c 26 80 00       	push   $0x80267c
  801d5c:	e8 f5 e8 ff ff       	call   800656 <cprintf>
  801d61:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801d64:	a1 00 30 80 00       	mov    0x803000,%eax
  801d69:	ff 75 0c             	pushl  0xc(%ebp)
  801d6c:	ff 75 08             	pushl  0x8(%ebp)
  801d6f:	50                   	push   %eax
  801d70:	68 81 26 80 00       	push   $0x802681
  801d75:	e8 dc e8 ff ff       	call   800656 <cprintf>
  801d7a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801d7d:	8b 45 10             	mov    0x10(%ebp),%eax
  801d80:	83 ec 08             	sub    $0x8,%esp
  801d83:	ff 75 f4             	pushl  -0xc(%ebp)
  801d86:	50                   	push   %eax
  801d87:	e8 5f e8 ff ff       	call   8005eb <vcprintf>
  801d8c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801d8f:	83 ec 08             	sub    $0x8,%esp
  801d92:	6a 00                	push   $0x0
  801d94:	68 9d 26 80 00       	push   $0x80269d
  801d99:	e8 4d e8 ff ff       	call   8005eb <vcprintf>
  801d9e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801da1:	e8 ce e7 ff ff       	call   800574 <exit>

	// should not return here
	while (1) ;
  801da6:	eb fe                	jmp    801da6 <_panic+0x70>

00801da8 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801da8:	55                   	push   %ebp
  801da9:	89 e5                	mov    %esp,%ebp
  801dab:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801dae:	a1 20 30 80 00       	mov    0x803020,%eax
  801db3:	8b 50 74             	mov    0x74(%eax),%edx
  801db6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801db9:	39 c2                	cmp    %eax,%edx
  801dbb:	74 14                	je     801dd1 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801dbd:	83 ec 04             	sub    $0x4,%esp
  801dc0:	68 a0 26 80 00       	push   $0x8026a0
  801dc5:	6a 26                	push   $0x26
  801dc7:	68 ec 26 80 00       	push   $0x8026ec
  801dcc:	e8 65 ff ff ff       	call   801d36 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801dd1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801dd8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ddf:	e9 c2 00 00 00       	jmp    801ea6 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801de4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801de7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801dee:	8b 45 08             	mov    0x8(%ebp),%eax
  801df1:	01 d0                	add    %edx,%eax
  801df3:	8b 00                	mov    (%eax),%eax
  801df5:	85 c0                	test   %eax,%eax
  801df7:	75 08                	jne    801e01 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801df9:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801dfc:	e9 a2 00 00 00       	jmp    801ea3 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801e01:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e08:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801e0f:	eb 69                	jmp    801e7a <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801e11:	a1 20 30 80 00       	mov    0x803020,%eax
  801e16:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801e1c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e1f:	89 d0                	mov    %edx,%eax
  801e21:	01 c0                	add    %eax,%eax
  801e23:	01 d0                	add    %edx,%eax
  801e25:	c1 e0 02             	shl    $0x2,%eax
  801e28:	01 c8                	add    %ecx,%eax
  801e2a:	8a 40 04             	mov    0x4(%eax),%al
  801e2d:	84 c0                	test   %al,%al
  801e2f:	75 46                	jne    801e77 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801e31:	a1 20 30 80 00       	mov    0x803020,%eax
  801e36:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801e3c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e3f:	89 d0                	mov    %edx,%eax
  801e41:	01 c0                	add    %eax,%eax
  801e43:	01 d0                	add    %edx,%eax
  801e45:	c1 e0 02             	shl    $0x2,%eax
  801e48:	01 c8                	add    %ecx,%eax
  801e4a:	8b 00                	mov    (%eax),%eax
  801e4c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801e4f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801e52:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801e57:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801e59:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e5c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801e63:	8b 45 08             	mov    0x8(%ebp),%eax
  801e66:	01 c8                	add    %ecx,%eax
  801e68:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801e6a:	39 c2                	cmp    %eax,%edx
  801e6c:	75 09                	jne    801e77 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801e6e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801e75:	eb 12                	jmp    801e89 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e77:	ff 45 e8             	incl   -0x18(%ebp)
  801e7a:	a1 20 30 80 00       	mov    0x803020,%eax
  801e7f:	8b 50 74             	mov    0x74(%eax),%edx
  801e82:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e85:	39 c2                	cmp    %eax,%edx
  801e87:	77 88                	ja     801e11 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801e89:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801e8d:	75 14                	jne    801ea3 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801e8f:	83 ec 04             	sub    $0x4,%esp
  801e92:	68 f8 26 80 00       	push   $0x8026f8
  801e97:	6a 3a                	push   $0x3a
  801e99:	68 ec 26 80 00       	push   $0x8026ec
  801e9e:	e8 93 fe ff ff       	call   801d36 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801ea3:	ff 45 f0             	incl   -0x10(%ebp)
  801ea6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ea9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801eac:	0f 8c 32 ff ff ff    	jl     801de4 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801eb2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801eb9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801ec0:	eb 26                	jmp    801ee8 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801ec2:	a1 20 30 80 00       	mov    0x803020,%eax
  801ec7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ecd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ed0:	89 d0                	mov    %edx,%eax
  801ed2:	01 c0                	add    %eax,%eax
  801ed4:	01 d0                	add    %edx,%eax
  801ed6:	c1 e0 02             	shl    $0x2,%eax
  801ed9:	01 c8                	add    %ecx,%eax
  801edb:	8a 40 04             	mov    0x4(%eax),%al
  801ede:	3c 01                	cmp    $0x1,%al
  801ee0:	75 03                	jne    801ee5 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801ee2:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ee5:	ff 45 e0             	incl   -0x20(%ebp)
  801ee8:	a1 20 30 80 00       	mov    0x803020,%eax
  801eed:	8b 50 74             	mov    0x74(%eax),%edx
  801ef0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ef3:	39 c2                	cmp    %eax,%edx
  801ef5:	77 cb                	ja     801ec2 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801ef7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801efa:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801efd:	74 14                	je     801f13 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801eff:	83 ec 04             	sub    $0x4,%esp
  801f02:	68 4c 27 80 00       	push   $0x80274c
  801f07:	6a 44                	push   $0x44
  801f09:	68 ec 26 80 00       	push   $0x8026ec
  801f0e:	e8 23 fe ff ff       	call   801d36 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801f13:	90                   	nop
  801f14:	c9                   	leave  
  801f15:	c3                   	ret    
  801f16:	66 90                	xchg   %ax,%ax

00801f18 <__udivdi3>:
  801f18:	55                   	push   %ebp
  801f19:	57                   	push   %edi
  801f1a:	56                   	push   %esi
  801f1b:	53                   	push   %ebx
  801f1c:	83 ec 1c             	sub    $0x1c,%esp
  801f1f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f23:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f27:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f2b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f2f:	89 ca                	mov    %ecx,%edx
  801f31:	89 f8                	mov    %edi,%eax
  801f33:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f37:	85 f6                	test   %esi,%esi
  801f39:	75 2d                	jne    801f68 <__udivdi3+0x50>
  801f3b:	39 cf                	cmp    %ecx,%edi
  801f3d:	77 65                	ja     801fa4 <__udivdi3+0x8c>
  801f3f:	89 fd                	mov    %edi,%ebp
  801f41:	85 ff                	test   %edi,%edi
  801f43:	75 0b                	jne    801f50 <__udivdi3+0x38>
  801f45:	b8 01 00 00 00       	mov    $0x1,%eax
  801f4a:	31 d2                	xor    %edx,%edx
  801f4c:	f7 f7                	div    %edi
  801f4e:	89 c5                	mov    %eax,%ebp
  801f50:	31 d2                	xor    %edx,%edx
  801f52:	89 c8                	mov    %ecx,%eax
  801f54:	f7 f5                	div    %ebp
  801f56:	89 c1                	mov    %eax,%ecx
  801f58:	89 d8                	mov    %ebx,%eax
  801f5a:	f7 f5                	div    %ebp
  801f5c:	89 cf                	mov    %ecx,%edi
  801f5e:	89 fa                	mov    %edi,%edx
  801f60:	83 c4 1c             	add    $0x1c,%esp
  801f63:	5b                   	pop    %ebx
  801f64:	5e                   	pop    %esi
  801f65:	5f                   	pop    %edi
  801f66:	5d                   	pop    %ebp
  801f67:	c3                   	ret    
  801f68:	39 ce                	cmp    %ecx,%esi
  801f6a:	77 28                	ja     801f94 <__udivdi3+0x7c>
  801f6c:	0f bd fe             	bsr    %esi,%edi
  801f6f:	83 f7 1f             	xor    $0x1f,%edi
  801f72:	75 40                	jne    801fb4 <__udivdi3+0x9c>
  801f74:	39 ce                	cmp    %ecx,%esi
  801f76:	72 0a                	jb     801f82 <__udivdi3+0x6a>
  801f78:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f7c:	0f 87 9e 00 00 00    	ja     802020 <__udivdi3+0x108>
  801f82:	b8 01 00 00 00       	mov    $0x1,%eax
  801f87:	89 fa                	mov    %edi,%edx
  801f89:	83 c4 1c             	add    $0x1c,%esp
  801f8c:	5b                   	pop    %ebx
  801f8d:	5e                   	pop    %esi
  801f8e:	5f                   	pop    %edi
  801f8f:	5d                   	pop    %ebp
  801f90:	c3                   	ret    
  801f91:	8d 76 00             	lea    0x0(%esi),%esi
  801f94:	31 ff                	xor    %edi,%edi
  801f96:	31 c0                	xor    %eax,%eax
  801f98:	89 fa                	mov    %edi,%edx
  801f9a:	83 c4 1c             	add    $0x1c,%esp
  801f9d:	5b                   	pop    %ebx
  801f9e:	5e                   	pop    %esi
  801f9f:	5f                   	pop    %edi
  801fa0:	5d                   	pop    %ebp
  801fa1:	c3                   	ret    
  801fa2:	66 90                	xchg   %ax,%ax
  801fa4:	89 d8                	mov    %ebx,%eax
  801fa6:	f7 f7                	div    %edi
  801fa8:	31 ff                	xor    %edi,%edi
  801faa:	89 fa                	mov    %edi,%edx
  801fac:	83 c4 1c             	add    $0x1c,%esp
  801faf:	5b                   	pop    %ebx
  801fb0:	5e                   	pop    %esi
  801fb1:	5f                   	pop    %edi
  801fb2:	5d                   	pop    %ebp
  801fb3:	c3                   	ret    
  801fb4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801fb9:	89 eb                	mov    %ebp,%ebx
  801fbb:	29 fb                	sub    %edi,%ebx
  801fbd:	89 f9                	mov    %edi,%ecx
  801fbf:	d3 e6                	shl    %cl,%esi
  801fc1:	89 c5                	mov    %eax,%ebp
  801fc3:	88 d9                	mov    %bl,%cl
  801fc5:	d3 ed                	shr    %cl,%ebp
  801fc7:	89 e9                	mov    %ebp,%ecx
  801fc9:	09 f1                	or     %esi,%ecx
  801fcb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801fcf:	89 f9                	mov    %edi,%ecx
  801fd1:	d3 e0                	shl    %cl,%eax
  801fd3:	89 c5                	mov    %eax,%ebp
  801fd5:	89 d6                	mov    %edx,%esi
  801fd7:	88 d9                	mov    %bl,%cl
  801fd9:	d3 ee                	shr    %cl,%esi
  801fdb:	89 f9                	mov    %edi,%ecx
  801fdd:	d3 e2                	shl    %cl,%edx
  801fdf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fe3:	88 d9                	mov    %bl,%cl
  801fe5:	d3 e8                	shr    %cl,%eax
  801fe7:	09 c2                	or     %eax,%edx
  801fe9:	89 d0                	mov    %edx,%eax
  801feb:	89 f2                	mov    %esi,%edx
  801fed:	f7 74 24 0c          	divl   0xc(%esp)
  801ff1:	89 d6                	mov    %edx,%esi
  801ff3:	89 c3                	mov    %eax,%ebx
  801ff5:	f7 e5                	mul    %ebp
  801ff7:	39 d6                	cmp    %edx,%esi
  801ff9:	72 19                	jb     802014 <__udivdi3+0xfc>
  801ffb:	74 0b                	je     802008 <__udivdi3+0xf0>
  801ffd:	89 d8                	mov    %ebx,%eax
  801fff:	31 ff                	xor    %edi,%edi
  802001:	e9 58 ff ff ff       	jmp    801f5e <__udivdi3+0x46>
  802006:	66 90                	xchg   %ax,%ax
  802008:	8b 54 24 08          	mov    0x8(%esp),%edx
  80200c:	89 f9                	mov    %edi,%ecx
  80200e:	d3 e2                	shl    %cl,%edx
  802010:	39 c2                	cmp    %eax,%edx
  802012:	73 e9                	jae    801ffd <__udivdi3+0xe5>
  802014:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802017:	31 ff                	xor    %edi,%edi
  802019:	e9 40 ff ff ff       	jmp    801f5e <__udivdi3+0x46>
  80201e:	66 90                	xchg   %ax,%ax
  802020:	31 c0                	xor    %eax,%eax
  802022:	e9 37 ff ff ff       	jmp    801f5e <__udivdi3+0x46>
  802027:	90                   	nop

00802028 <__umoddi3>:
  802028:	55                   	push   %ebp
  802029:	57                   	push   %edi
  80202a:	56                   	push   %esi
  80202b:	53                   	push   %ebx
  80202c:	83 ec 1c             	sub    $0x1c,%esp
  80202f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802033:	8b 74 24 34          	mov    0x34(%esp),%esi
  802037:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80203b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80203f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802043:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802047:	89 f3                	mov    %esi,%ebx
  802049:	89 fa                	mov    %edi,%edx
  80204b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80204f:	89 34 24             	mov    %esi,(%esp)
  802052:	85 c0                	test   %eax,%eax
  802054:	75 1a                	jne    802070 <__umoddi3+0x48>
  802056:	39 f7                	cmp    %esi,%edi
  802058:	0f 86 a2 00 00 00    	jbe    802100 <__umoddi3+0xd8>
  80205e:	89 c8                	mov    %ecx,%eax
  802060:	89 f2                	mov    %esi,%edx
  802062:	f7 f7                	div    %edi
  802064:	89 d0                	mov    %edx,%eax
  802066:	31 d2                	xor    %edx,%edx
  802068:	83 c4 1c             	add    $0x1c,%esp
  80206b:	5b                   	pop    %ebx
  80206c:	5e                   	pop    %esi
  80206d:	5f                   	pop    %edi
  80206e:	5d                   	pop    %ebp
  80206f:	c3                   	ret    
  802070:	39 f0                	cmp    %esi,%eax
  802072:	0f 87 ac 00 00 00    	ja     802124 <__umoddi3+0xfc>
  802078:	0f bd e8             	bsr    %eax,%ebp
  80207b:	83 f5 1f             	xor    $0x1f,%ebp
  80207e:	0f 84 ac 00 00 00    	je     802130 <__umoddi3+0x108>
  802084:	bf 20 00 00 00       	mov    $0x20,%edi
  802089:	29 ef                	sub    %ebp,%edi
  80208b:	89 fe                	mov    %edi,%esi
  80208d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802091:	89 e9                	mov    %ebp,%ecx
  802093:	d3 e0                	shl    %cl,%eax
  802095:	89 d7                	mov    %edx,%edi
  802097:	89 f1                	mov    %esi,%ecx
  802099:	d3 ef                	shr    %cl,%edi
  80209b:	09 c7                	or     %eax,%edi
  80209d:	89 e9                	mov    %ebp,%ecx
  80209f:	d3 e2                	shl    %cl,%edx
  8020a1:	89 14 24             	mov    %edx,(%esp)
  8020a4:	89 d8                	mov    %ebx,%eax
  8020a6:	d3 e0                	shl    %cl,%eax
  8020a8:	89 c2                	mov    %eax,%edx
  8020aa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020ae:	d3 e0                	shl    %cl,%eax
  8020b0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020b4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020b8:	89 f1                	mov    %esi,%ecx
  8020ba:	d3 e8                	shr    %cl,%eax
  8020bc:	09 d0                	or     %edx,%eax
  8020be:	d3 eb                	shr    %cl,%ebx
  8020c0:	89 da                	mov    %ebx,%edx
  8020c2:	f7 f7                	div    %edi
  8020c4:	89 d3                	mov    %edx,%ebx
  8020c6:	f7 24 24             	mull   (%esp)
  8020c9:	89 c6                	mov    %eax,%esi
  8020cb:	89 d1                	mov    %edx,%ecx
  8020cd:	39 d3                	cmp    %edx,%ebx
  8020cf:	0f 82 87 00 00 00    	jb     80215c <__umoddi3+0x134>
  8020d5:	0f 84 91 00 00 00    	je     80216c <__umoddi3+0x144>
  8020db:	8b 54 24 04          	mov    0x4(%esp),%edx
  8020df:	29 f2                	sub    %esi,%edx
  8020e1:	19 cb                	sbb    %ecx,%ebx
  8020e3:	89 d8                	mov    %ebx,%eax
  8020e5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8020e9:	d3 e0                	shl    %cl,%eax
  8020eb:	89 e9                	mov    %ebp,%ecx
  8020ed:	d3 ea                	shr    %cl,%edx
  8020ef:	09 d0                	or     %edx,%eax
  8020f1:	89 e9                	mov    %ebp,%ecx
  8020f3:	d3 eb                	shr    %cl,%ebx
  8020f5:	89 da                	mov    %ebx,%edx
  8020f7:	83 c4 1c             	add    $0x1c,%esp
  8020fa:	5b                   	pop    %ebx
  8020fb:	5e                   	pop    %esi
  8020fc:	5f                   	pop    %edi
  8020fd:	5d                   	pop    %ebp
  8020fe:	c3                   	ret    
  8020ff:	90                   	nop
  802100:	89 fd                	mov    %edi,%ebp
  802102:	85 ff                	test   %edi,%edi
  802104:	75 0b                	jne    802111 <__umoddi3+0xe9>
  802106:	b8 01 00 00 00       	mov    $0x1,%eax
  80210b:	31 d2                	xor    %edx,%edx
  80210d:	f7 f7                	div    %edi
  80210f:	89 c5                	mov    %eax,%ebp
  802111:	89 f0                	mov    %esi,%eax
  802113:	31 d2                	xor    %edx,%edx
  802115:	f7 f5                	div    %ebp
  802117:	89 c8                	mov    %ecx,%eax
  802119:	f7 f5                	div    %ebp
  80211b:	89 d0                	mov    %edx,%eax
  80211d:	e9 44 ff ff ff       	jmp    802066 <__umoddi3+0x3e>
  802122:	66 90                	xchg   %ax,%ax
  802124:	89 c8                	mov    %ecx,%eax
  802126:	89 f2                	mov    %esi,%edx
  802128:	83 c4 1c             	add    $0x1c,%esp
  80212b:	5b                   	pop    %ebx
  80212c:	5e                   	pop    %esi
  80212d:	5f                   	pop    %edi
  80212e:	5d                   	pop    %ebp
  80212f:	c3                   	ret    
  802130:	3b 04 24             	cmp    (%esp),%eax
  802133:	72 06                	jb     80213b <__umoddi3+0x113>
  802135:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802139:	77 0f                	ja     80214a <__umoddi3+0x122>
  80213b:	89 f2                	mov    %esi,%edx
  80213d:	29 f9                	sub    %edi,%ecx
  80213f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802143:	89 14 24             	mov    %edx,(%esp)
  802146:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80214a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80214e:	8b 14 24             	mov    (%esp),%edx
  802151:	83 c4 1c             	add    $0x1c,%esp
  802154:	5b                   	pop    %ebx
  802155:	5e                   	pop    %esi
  802156:	5f                   	pop    %edi
  802157:	5d                   	pop    %ebp
  802158:	c3                   	ret    
  802159:	8d 76 00             	lea    0x0(%esi),%esi
  80215c:	2b 04 24             	sub    (%esp),%eax
  80215f:	19 fa                	sbb    %edi,%edx
  802161:	89 d1                	mov    %edx,%ecx
  802163:	89 c6                	mov    %eax,%esi
  802165:	e9 71 ff ff ff       	jmp    8020db <__umoddi3+0xb3>
  80216a:	66 90                	xchg   %ax,%ax
  80216c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802170:	72 ea                	jb     80215c <__umoddi3+0x134>
  802172:	89 d9                	mov    %ebx,%ecx
  802174:	e9 62 ff ff ff       	jmp    8020db <__umoddi3+0xb3>
