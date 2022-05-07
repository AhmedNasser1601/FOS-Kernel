
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
  80003e:	e8 60 16 00 00       	call   8016a3 <sys_getparentenvid>
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
  800057:	68 60 20 80 00       	push   $0x802060
  80005c:	ff 75 f0             	pushl  -0x10(%ebp)
  80005f:	e8 1a 15 00 00       	call   80157e <sget>
  800064:	83 c4 10             	add    $0x10,%esp
  800067:	89 45 e8             	mov    %eax,-0x18(%ebp)
	numOfElements = sget(parentenvID, "arrSize") ;
  80006a:	83 ec 08             	sub    $0x8,%esp
  80006d:	68 64 20 80 00       	push   $0x802064
  800072:	ff 75 f0             	pushl  -0x10(%ebp)
  800075:	e8 04 15 00 00       	call   80157e <sget>
  80007a:	83 c4 10             	add    $0x10,%esp
  80007d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	//PrintElements(sharedArray, *numOfElements);

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800080:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	finishedCount = sget(parentenvID, "finishedCount") ;
  800087:	83 ec 08             	sub    $0x8,%esp
  80008a:	68 6c 20 80 00       	push   $0x80206c
  80008f:	ff 75 f0             	pushl  -0x10(%ebp)
  800092:	e8 e7 14 00 00       	call   80157e <sget>
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
  8000ab:	68 7a 20 80 00       	push   $0x80207a
  8000b0:	e8 a9 14 00 00       	call   80155e <smalloc>
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
  80010c:	68 89 20 80 00       	push   $0x802089
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
  8001a2:	68 a5 20 80 00       	push   $0x8020a5
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
  8001c4:	68 a7 20 80 00       	push   $0x8020a7
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
  8001f2:	68 ac 20 80 00       	push   $0x8020ac
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
  800298:	e8 43 11 00 00       	call   8013e0 <malloc>
  80029d:	83 c4 10             	add    $0x10,%esp
  8002a0:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  8002a3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002a6:	c1 e0 02             	shl    $0x2,%eax
  8002a9:	83 ec 0c             	sub    $0xc,%esp
  8002ac:	50                   	push   %eax
  8002ad:	e8 2e 11 00 00       	call   8013e0 <malloc>
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
  80045a:	e8 39 11 00 00       	call   801598 <free>
  80045f:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800462:	83 ec 0c             	sub    $0xc,%esp
  800465:	ff 75 d4             	pushl  -0x2c(%ebp)
  800468:	e8 2b 11 00 00       	call   801598 <free>
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
  800479:	e8 0c 12 00 00       	call   80168a <sys_getenvindex>
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
  8004e8:	e8 38 13 00 00       	call   801825 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004ed:	83 ec 0c             	sub    $0xc,%esp
  8004f0:	68 c8 20 80 00       	push   $0x8020c8
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
  800518:	68 f0 20 80 00       	push   $0x8020f0
  80051d:	e8 34 01 00 00       	call   800656 <cprintf>
  800522:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800525:	a1 20 30 80 00       	mov    0x803020,%eax
  80052a:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800530:	83 ec 08             	sub    $0x8,%esp
  800533:	50                   	push   %eax
  800534:	68 15 21 80 00       	push   $0x802115
  800539:	e8 18 01 00 00       	call   800656 <cprintf>
  80053e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800541:	83 ec 0c             	sub    $0xc,%esp
  800544:	68 c8 20 80 00       	push   $0x8020c8
  800549:	e8 08 01 00 00       	call   800656 <cprintf>
  80054e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800551:	e8 e9 12 00 00       	call   80183f <sys_enable_interrupt>

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
  800569:	e8 e8 10 00 00       	call   801656 <sys_env_destroy>
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
  80057a:	e8 3d 11 00 00       	call   8016bc <sys_env_exit>
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
  8005c8:	e8 47 10 00 00       	call   801614 <sys_cputs>
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
  80063f:	e8 d0 0f 00 00       	call   801614 <sys_cputs>
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
  800689:	e8 97 11 00 00       	call   801825 <sys_disable_interrupt>
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
  8006a9:	e8 91 11 00 00       	call   80183f <sys_enable_interrupt>
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
  8006f3:	e8 ec 16 00 00       	call   801de4 <__udivdi3>
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
  800743:	e8 ac 17 00 00       	call   801ef4 <__umoddi3>
  800748:	83 c4 10             	add    $0x10,%esp
  80074b:	05 54 23 80 00       	add    $0x802354,%eax
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
  80089e:	8b 04 85 78 23 80 00 	mov    0x802378(,%eax,4),%eax
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
  80097f:	8b 34 9d c0 21 80 00 	mov    0x8021c0(,%ebx,4),%esi
  800986:	85 f6                	test   %esi,%esi
  800988:	75 19                	jne    8009a3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80098a:	53                   	push   %ebx
  80098b:	68 65 23 80 00       	push   $0x802365
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
  8009a4:	68 6e 23 80 00       	push   $0x80236e
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
  8009d1:	be 71 23 80 00       	mov    $0x802371,%esi
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

008013e0 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
  8013e3:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  8013e6:	e8 9b 07 00 00       	call   801b86 <sys_isUHeapPlacementStrategyNEXTFIT>
  8013eb:	85 c0                	test   %eax,%eax
  8013ed:	0f 84 64 01 00 00    	je     801557 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  8013f3:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  8013f9:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801400:	8b 55 08             	mov    0x8(%ebp),%edx
  801403:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801406:	01 d0                	add    %edx,%eax
  801408:	48                   	dec    %eax
  801409:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80140c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80140f:	ba 00 00 00 00       	mov    $0x0,%edx
  801414:	f7 75 e8             	divl   -0x18(%ebp)
  801417:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80141a:	29 d0                	sub    %edx,%eax
  80141c:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801423:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801429:	8b 45 08             	mov    0x8(%ebp),%eax
  80142c:	01 d0                	add    %edx,%eax
  80142e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801431:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801438:	a1 28 30 80 00       	mov    0x803028,%eax
  80143d:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801444:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801447:	0f 83 0a 01 00 00    	jae    801557 <malloc+0x177>
  80144d:	a1 28 30 80 00       	mov    0x803028,%eax
  801452:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801459:	85 c0                	test   %eax,%eax
  80145b:	0f 84 f6 00 00 00    	je     801557 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801461:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801468:	e9 dc 00 00 00       	jmp    801549 <malloc+0x169>
				flag++;
  80146d:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801470:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801473:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80147a:	85 c0                	test   %eax,%eax
  80147c:	74 07                	je     801485 <malloc+0xa5>
					flag=0;
  80147e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801485:	a1 28 30 80 00       	mov    0x803028,%eax
  80148a:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801491:	85 c0                	test   %eax,%eax
  801493:	79 05                	jns    80149a <malloc+0xba>
  801495:	05 ff 0f 00 00       	add    $0xfff,%eax
  80149a:	c1 f8 0c             	sar    $0xc,%eax
  80149d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014a0:	0f 85 a0 00 00 00    	jne    801546 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  8014a6:	a1 28 30 80 00       	mov    0x803028,%eax
  8014ab:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8014b2:	85 c0                	test   %eax,%eax
  8014b4:	79 05                	jns    8014bb <malloc+0xdb>
  8014b6:	05 ff 0f 00 00       	add    $0xfff,%eax
  8014bb:	c1 f8 0c             	sar    $0xc,%eax
  8014be:	89 c2                	mov    %eax,%edx
  8014c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014c3:	29 d0                	sub    %edx,%eax
  8014c5:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  8014c8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8014cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8014ce:	eb 11                	jmp    8014e1 <malloc+0x101>
						hFreeArr[j] = 1;
  8014d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014d3:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  8014da:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  8014de:	ff 45 ec             	incl   -0x14(%ebp)
  8014e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014e4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014e7:	7e e7                	jle    8014d0 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  8014e9:	a1 28 30 80 00       	mov    0x803028,%eax
  8014ee:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8014f1:	81 c2 01 00 08 00    	add    $0x80001,%edx
  8014f7:	c1 e2 0c             	shl    $0xc,%edx
  8014fa:	89 15 04 30 80 00    	mov    %edx,0x803004
  801500:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801506:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  80150d:	a1 28 30 80 00       	mov    0x803028,%eax
  801512:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801519:	89 c2                	mov    %eax,%edx
  80151b:	a1 28 30 80 00       	mov    0x803028,%eax
  801520:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801527:	83 ec 08             	sub    $0x8,%esp
  80152a:	52                   	push   %edx
  80152b:	50                   	push   %eax
  80152c:	e8 8b 02 00 00       	call   8017bc <sys_allocateMem>
  801531:	83 c4 10             	add    $0x10,%esp

					idx++;
  801534:	a1 28 30 80 00       	mov    0x803028,%eax
  801539:	40                   	inc    %eax
  80153a:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  80153f:	a1 04 30 80 00       	mov    0x803004,%eax
  801544:	eb 16                	jmp    80155c <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801546:	ff 45 f0             	incl   -0x10(%ebp)
  801549:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80154c:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801551:	0f 86 16 ff ff ff    	jbe    80146d <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801557:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
  801561:	83 ec 18             	sub    $0x18,%esp
  801564:	8b 45 10             	mov    0x10(%ebp),%eax
  801567:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  80156a:	83 ec 04             	sub    $0x4,%esp
  80156d:	68 d0 24 80 00       	push   $0x8024d0
  801572:	6a 59                	push   $0x59
  801574:	68 ef 24 80 00       	push   $0x8024ef
  801579:	e8 85 06 00 00       	call   801c03 <_panic>

0080157e <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
  801581:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801584:	83 ec 04             	sub    $0x4,%esp
  801587:	68 fb 24 80 00       	push   $0x8024fb
  80158c:	6a 5f                	push   $0x5f
  80158e:	68 ef 24 80 00       	push   $0x8024ef
  801593:	e8 6b 06 00 00       	call   801c03 <_panic>

00801598 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
  80159b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  80159e:	83 ec 04             	sub    $0x4,%esp
  8015a1:	68 18 25 80 00       	push   $0x802518
  8015a6:	6a 70                	push   $0x70
  8015a8:	68 ef 24 80 00       	push   $0x8024ef
  8015ad:	e8 51 06 00 00       	call   801c03 <_panic>

008015b2 <sfree>:

}


void sfree(void* virtual_address)
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
  8015b5:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8015b8:	83 ec 04             	sub    $0x4,%esp
  8015bb:	68 3b 25 80 00       	push   $0x80253b
  8015c0:	6a 7b                	push   $0x7b
  8015c2:	68 ef 24 80 00       	push   $0x8024ef
  8015c7:	e8 37 06 00 00       	call   801c03 <_panic>

008015cc <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
  8015cf:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8015d2:	83 ec 04             	sub    $0x4,%esp
  8015d5:	68 58 25 80 00       	push   $0x802558
  8015da:	68 93 00 00 00       	push   $0x93
  8015df:	68 ef 24 80 00       	push   $0x8024ef
  8015e4:	e8 1a 06 00 00       	call   801c03 <_panic>

008015e9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
  8015ec:	57                   	push   %edi
  8015ed:	56                   	push   %esi
  8015ee:	53                   	push   %ebx
  8015ef:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015fb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015fe:	8b 7d 18             	mov    0x18(%ebp),%edi
  801601:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801604:	cd 30                	int    $0x30
  801606:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801609:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80160c:	83 c4 10             	add    $0x10,%esp
  80160f:	5b                   	pop    %ebx
  801610:	5e                   	pop    %esi
  801611:	5f                   	pop    %edi
  801612:	5d                   	pop    %ebp
  801613:	c3                   	ret    

00801614 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801614:	55                   	push   %ebp
  801615:	89 e5                	mov    %esp,%ebp
  801617:	83 ec 04             	sub    $0x4,%esp
  80161a:	8b 45 10             	mov    0x10(%ebp),%eax
  80161d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801620:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801624:	8b 45 08             	mov    0x8(%ebp),%eax
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	52                   	push   %edx
  80162c:	ff 75 0c             	pushl  0xc(%ebp)
  80162f:	50                   	push   %eax
  801630:	6a 00                	push   $0x0
  801632:	e8 b2 ff ff ff       	call   8015e9 <syscall>
  801637:	83 c4 18             	add    $0x18,%esp
}
  80163a:	90                   	nop
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <sys_cgetc>:

int
sys_cgetc(void)
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 01                	push   $0x1
  80164c:	e8 98 ff ff ff       	call   8015e9 <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801659:	8b 45 08             	mov    0x8(%ebp),%eax
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	50                   	push   %eax
  801665:	6a 05                	push   $0x5
  801667:	e8 7d ff ff ff       	call   8015e9 <syscall>
  80166c:	83 c4 18             	add    $0x18,%esp
}
  80166f:	c9                   	leave  
  801670:	c3                   	ret    

00801671 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801671:	55                   	push   %ebp
  801672:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 02                	push   $0x2
  801680:	e8 64 ff ff ff       	call   8015e9 <syscall>
  801685:	83 c4 18             	add    $0x18,%esp
}
  801688:	c9                   	leave  
  801689:	c3                   	ret    

0080168a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80168a:	55                   	push   %ebp
  80168b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 03                	push   $0x3
  801699:	e8 4b ff ff ff       	call   8015e9 <syscall>
  80169e:	83 c4 18             	add    $0x18,%esp
}
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 04                	push   $0x4
  8016b2:	e8 32 ff ff ff       	call   8015e9 <syscall>
  8016b7:	83 c4 18             	add    $0x18,%esp
}
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <sys_env_exit>:


void sys_env_exit(void)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 06                	push   $0x6
  8016cb:	e8 19 ff ff ff       	call   8015e9 <syscall>
  8016d0:	83 c4 18             	add    $0x18,%esp
}
  8016d3:	90                   	nop
  8016d4:	c9                   	leave  
  8016d5:	c3                   	ret    

008016d6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016d6:	55                   	push   %ebp
  8016d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	52                   	push   %edx
  8016e6:	50                   	push   %eax
  8016e7:	6a 07                	push   $0x7
  8016e9:	e8 fb fe ff ff       	call   8015e9 <syscall>
  8016ee:	83 c4 18             	add    $0x18,%esp
}
  8016f1:	c9                   	leave  
  8016f2:	c3                   	ret    

008016f3 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016f3:	55                   	push   %ebp
  8016f4:	89 e5                	mov    %esp,%ebp
  8016f6:	56                   	push   %esi
  8016f7:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016f8:	8b 75 18             	mov    0x18(%ebp),%esi
  8016fb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016fe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801701:	8b 55 0c             	mov    0xc(%ebp),%edx
  801704:	8b 45 08             	mov    0x8(%ebp),%eax
  801707:	56                   	push   %esi
  801708:	53                   	push   %ebx
  801709:	51                   	push   %ecx
  80170a:	52                   	push   %edx
  80170b:	50                   	push   %eax
  80170c:	6a 08                	push   $0x8
  80170e:	e8 d6 fe ff ff       	call   8015e9 <syscall>
  801713:	83 c4 18             	add    $0x18,%esp
}
  801716:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801719:	5b                   	pop    %ebx
  80171a:	5e                   	pop    %esi
  80171b:	5d                   	pop    %ebp
  80171c:	c3                   	ret    

0080171d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80171d:	55                   	push   %ebp
  80171e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801720:	8b 55 0c             	mov    0xc(%ebp),%edx
  801723:	8b 45 08             	mov    0x8(%ebp),%eax
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	52                   	push   %edx
  80172d:	50                   	push   %eax
  80172e:	6a 09                	push   $0x9
  801730:	e8 b4 fe ff ff       	call   8015e9 <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
}
  801738:	c9                   	leave  
  801739:	c3                   	ret    

0080173a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80173a:	55                   	push   %ebp
  80173b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	ff 75 0c             	pushl  0xc(%ebp)
  801746:	ff 75 08             	pushl  0x8(%ebp)
  801749:	6a 0a                	push   $0xa
  80174b:	e8 99 fe ff ff       	call   8015e9 <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
}
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 0b                	push   $0xb
  801764:	e8 80 fe ff ff       	call   8015e9 <syscall>
  801769:	83 c4 18             	add    $0x18,%esp
}
  80176c:	c9                   	leave  
  80176d:	c3                   	ret    

0080176e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80176e:	55                   	push   %ebp
  80176f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 0c                	push   $0xc
  80177d:	e8 67 fe ff ff       	call   8015e9 <syscall>
  801782:	83 c4 18             	add    $0x18,%esp
}
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 0d                	push   $0xd
  801796:	e8 4e fe ff ff       	call   8015e9 <syscall>
  80179b:	83 c4 18             	add    $0x18,%esp
}
  80179e:	c9                   	leave  
  80179f:	c3                   	ret    

008017a0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	ff 75 0c             	pushl  0xc(%ebp)
  8017ac:	ff 75 08             	pushl  0x8(%ebp)
  8017af:	6a 11                	push   $0x11
  8017b1:	e8 33 fe ff ff       	call   8015e9 <syscall>
  8017b6:	83 c4 18             	add    $0x18,%esp
	return;
  8017b9:	90                   	nop
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	ff 75 0c             	pushl  0xc(%ebp)
  8017c8:	ff 75 08             	pushl  0x8(%ebp)
  8017cb:	6a 12                	push   $0x12
  8017cd:	e8 17 fe ff ff       	call   8015e9 <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d5:	90                   	nop
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 0e                	push   $0xe
  8017e7:	e8 fd fd ff ff       	call   8015e9 <syscall>
  8017ec:	83 c4 18             	add    $0x18,%esp
}
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	ff 75 08             	pushl  0x8(%ebp)
  8017ff:	6a 0f                	push   $0xf
  801801:	e8 e3 fd ff ff       	call   8015e9 <syscall>
  801806:	83 c4 18             	add    $0x18,%esp
}
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 10                	push   $0x10
  80181a:	e8 ca fd ff ff       	call   8015e9 <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
}
  801822:	90                   	nop
  801823:	c9                   	leave  
  801824:	c3                   	ret    

00801825 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801825:	55                   	push   %ebp
  801826:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 14                	push   $0x14
  801834:	e8 b0 fd ff ff       	call   8015e9 <syscall>
  801839:	83 c4 18             	add    $0x18,%esp
}
  80183c:	90                   	nop
  80183d:	c9                   	leave  
  80183e:	c3                   	ret    

0080183f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80183f:	55                   	push   %ebp
  801840:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 15                	push   $0x15
  80184e:	e8 96 fd ff ff       	call   8015e9 <syscall>
  801853:	83 c4 18             	add    $0x18,%esp
}
  801856:	90                   	nop
  801857:	c9                   	leave  
  801858:	c3                   	ret    

00801859 <sys_cputc>:


void
sys_cputc(const char c)
{
  801859:	55                   	push   %ebp
  80185a:	89 e5                	mov    %esp,%ebp
  80185c:	83 ec 04             	sub    $0x4,%esp
  80185f:	8b 45 08             	mov    0x8(%ebp),%eax
  801862:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801865:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	50                   	push   %eax
  801872:	6a 16                	push   $0x16
  801874:	e8 70 fd ff ff       	call   8015e9 <syscall>
  801879:	83 c4 18             	add    $0x18,%esp
}
  80187c:	90                   	nop
  80187d:	c9                   	leave  
  80187e:	c3                   	ret    

0080187f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 17                	push   $0x17
  80188e:	e8 56 fd ff ff       	call   8015e9 <syscall>
  801893:	83 c4 18             	add    $0x18,%esp
}
  801896:	90                   	nop
  801897:	c9                   	leave  
  801898:	c3                   	ret    

00801899 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80189c:	8b 45 08             	mov    0x8(%ebp),%eax
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	ff 75 0c             	pushl  0xc(%ebp)
  8018a8:	50                   	push   %eax
  8018a9:	6a 18                	push   $0x18
  8018ab:	e8 39 fd ff ff       	call   8015e9 <syscall>
  8018b0:	83 c4 18             	add    $0x18,%esp
}
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	52                   	push   %edx
  8018c5:	50                   	push   %eax
  8018c6:	6a 1b                	push   $0x1b
  8018c8:	e8 1c fd ff ff       	call   8015e9 <syscall>
  8018cd:	83 c4 18             	add    $0x18,%esp
}
  8018d0:	c9                   	leave  
  8018d1:	c3                   	ret    

008018d2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018d2:	55                   	push   %ebp
  8018d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	52                   	push   %edx
  8018e2:	50                   	push   %eax
  8018e3:	6a 19                	push   $0x19
  8018e5:	e8 ff fc ff ff       	call   8015e9 <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
}
  8018ed:	90                   	nop
  8018ee:	c9                   	leave  
  8018ef:	c3                   	ret    

008018f0 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	52                   	push   %edx
  801900:	50                   	push   %eax
  801901:	6a 1a                	push   $0x1a
  801903:	e8 e1 fc ff ff       	call   8015e9 <syscall>
  801908:	83 c4 18             	add    $0x18,%esp
}
  80190b:	90                   	nop
  80190c:	c9                   	leave  
  80190d:	c3                   	ret    

0080190e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80190e:	55                   	push   %ebp
  80190f:	89 e5                	mov    %esp,%ebp
  801911:	83 ec 04             	sub    $0x4,%esp
  801914:	8b 45 10             	mov    0x10(%ebp),%eax
  801917:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80191a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80191d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801921:	8b 45 08             	mov    0x8(%ebp),%eax
  801924:	6a 00                	push   $0x0
  801926:	51                   	push   %ecx
  801927:	52                   	push   %edx
  801928:	ff 75 0c             	pushl  0xc(%ebp)
  80192b:	50                   	push   %eax
  80192c:	6a 1c                	push   $0x1c
  80192e:	e8 b6 fc ff ff       	call   8015e9 <syscall>
  801933:	83 c4 18             	add    $0x18,%esp
}
  801936:	c9                   	leave  
  801937:	c3                   	ret    

00801938 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801938:	55                   	push   %ebp
  801939:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80193b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80193e:	8b 45 08             	mov    0x8(%ebp),%eax
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	52                   	push   %edx
  801948:	50                   	push   %eax
  801949:	6a 1d                	push   $0x1d
  80194b:	e8 99 fc ff ff       	call   8015e9 <syscall>
  801950:	83 c4 18             	add    $0x18,%esp
}
  801953:	c9                   	leave  
  801954:	c3                   	ret    

00801955 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801955:	55                   	push   %ebp
  801956:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801958:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80195b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80195e:	8b 45 08             	mov    0x8(%ebp),%eax
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	51                   	push   %ecx
  801966:	52                   	push   %edx
  801967:	50                   	push   %eax
  801968:	6a 1e                	push   $0x1e
  80196a:	e8 7a fc ff ff       	call   8015e9 <syscall>
  80196f:	83 c4 18             	add    $0x18,%esp
}
  801972:	c9                   	leave  
  801973:	c3                   	ret    

00801974 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801977:	8b 55 0c             	mov    0xc(%ebp),%edx
  80197a:	8b 45 08             	mov    0x8(%ebp),%eax
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	52                   	push   %edx
  801984:	50                   	push   %eax
  801985:	6a 1f                	push   $0x1f
  801987:	e8 5d fc ff ff       	call   8015e9 <syscall>
  80198c:	83 c4 18             	add    $0x18,%esp
}
  80198f:	c9                   	leave  
  801990:	c3                   	ret    

00801991 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801991:	55                   	push   %ebp
  801992:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 20                	push   $0x20
  8019a0:	e8 44 fc ff ff       	call   8015e9 <syscall>
  8019a5:	83 c4 18             	add    $0x18,%esp
}
  8019a8:	c9                   	leave  
  8019a9:	c3                   	ret    

008019aa <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8019aa:	55                   	push   %ebp
  8019ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8019ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	ff 75 10             	pushl  0x10(%ebp)
  8019b7:	ff 75 0c             	pushl  0xc(%ebp)
  8019ba:	50                   	push   %eax
  8019bb:	6a 21                	push   $0x21
  8019bd:	e8 27 fc ff ff       	call   8015e9 <syscall>
  8019c2:	83 c4 18             	add    $0x18,%esp
}
  8019c5:	c9                   	leave  
  8019c6:	c3                   	ret    

008019c7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019c7:	55                   	push   %ebp
  8019c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	50                   	push   %eax
  8019d6:	6a 22                	push   $0x22
  8019d8:	e8 0c fc ff ff       	call   8015e9 <syscall>
  8019dd:	83 c4 18             	add    $0x18,%esp
}
  8019e0:	90                   	nop
  8019e1:	c9                   	leave  
  8019e2:	c3                   	ret    

008019e3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019e3:	55                   	push   %ebp
  8019e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	50                   	push   %eax
  8019f2:	6a 23                	push   $0x23
  8019f4:	e8 f0 fb ff ff       	call   8015e9 <syscall>
  8019f9:	83 c4 18             	add    $0x18,%esp
}
  8019fc:	90                   	nop
  8019fd:	c9                   	leave  
  8019fe:	c3                   	ret    

008019ff <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019ff:	55                   	push   %ebp
  801a00:	89 e5                	mov    %esp,%ebp
  801a02:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a05:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a08:	8d 50 04             	lea    0x4(%eax),%edx
  801a0b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	52                   	push   %edx
  801a15:	50                   	push   %eax
  801a16:	6a 24                	push   $0x24
  801a18:	e8 cc fb ff ff       	call   8015e9 <syscall>
  801a1d:	83 c4 18             	add    $0x18,%esp
	return result;
  801a20:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a23:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a26:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a29:	89 01                	mov    %eax,(%ecx)
  801a2b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a31:	c9                   	leave  
  801a32:	c2 04 00             	ret    $0x4

00801a35 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	ff 75 10             	pushl  0x10(%ebp)
  801a3f:	ff 75 0c             	pushl  0xc(%ebp)
  801a42:	ff 75 08             	pushl  0x8(%ebp)
  801a45:	6a 13                	push   $0x13
  801a47:	e8 9d fb ff ff       	call   8015e9 <syscall>
  801a4c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a4f:	90                   	nop
}
  801a50:	c9                   	leave  
  801a51:	c3                   	ret    

00801a52 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 25                	push   $0x25
  801a61:	e8 83 fb ff ff       	call   8015e9 <syscall>
  801a66:	83 c4 18             	add    $0x18,%esp
}
  801a69:	c9                   	leave  
  801a6a:	c3                   	ret    

00801a6b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a6b:	55                   	push   %ebp
  801a6c:	89 e5                	mov    %esp,%ebp
  801a6e:	83 ec 04             	sub    $0x4,%esp
  801a71:	8b 45 08             	mov    0x8(%ebp),%eax
  801a74:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a77:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	50                   	push   %eax
  801a84:	6a 26                	push   $0x26
  801a86:	e8 5e fb ff ff       	call   8015e9 <syscall>
  801a8b:	83 c4 18             	add    $0x18,%esp
	return ;
  801a8e:	90                   	nop
}
  801a8f:	c9                   	leave  
  801a90:	c3                   	ret    

00801a91 <rsttst>:
void rsttst()
{
  801a91:	55                   	push   %ebp
  801a92:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 28                	push   $0x28
  801aa0:	e8 44 fb ff ff       	call   8015e9 <syscall>
  801aa5:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa8:	90                   	nop
}
  801aa9:	c9                   	leave  
  801aaa:	c3                   	ret    

00801aab <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801aab:	55                   	push   %ebp
  801aac:	89 e5                	mov    %esp,%ebp
  801aae:	83 ec 04             	sub    $0x4,%esp
  801ab1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ab4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ab7:	8b 55 18             	mov    0x18(%ebp),%edx
  801aba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801abe:	52                   	push   %edx
  801abf:	50                   	push   %eax
  801ac0:	ff 75 10             	pushl  0x10(%ebp)
  801ac3:	ff 75 0c             	pushl  0xc(%ebp)
  801ac6:	ff 75 08             	pushl  0x8(%ebp)
  801ac9:	6a 27                	push   $0x27
  801acb:	e8 19 fb ff ff       	call   8015e9 <syscall>
  801ad0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad3:	90                   	nop
}
  801ad4:	c9                   	leave  
  801ad5:	c3                   	ret    

00801ad6 <chktst>:
void chktst(uint32 n)
{
  801ad6:	55                   	push   %ebp
  801ad7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	ff 75 08             	pushl  0x8(%ebp)
  801ae4:	6a 29                	push   $0x29
  801ae6:	e8 fe fa ff ff       	call   8015e9 <syscall>
  801aeb:	83 c4 18             	add    $0x18,%esp
	return ;
  801aee:	90                   	nop
}
  801aef:	c9                   	leave  
  801af0:	c3                   	ret    

00801af1 <inctst>:

void inctst()
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 2a                	push   $0x2a
  801b00:	e8 e4 fa ff ff       	call   8015e9 <syscall>
  801b05:	83 c4 18             	add    $0x18,%esp
	return ;
  801b08:	90                   	nop
}
  801b09:	c9                   	leave  
  801b0a:	c3                   	ret    

00801b0b <gettst>:
uint32 gettst()
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 2b                	push   $0x2b
  801b1a:	e8 ca fa ff ff       	call   8015e9 <syscall>
  801b1f:	83 c4 18             	add    $0x18,%esp
}
  801b22:	c9                   	leave  
  801b23:	c3                   	ret    

00801b24 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
  801b27:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 2c                	push   $0x2c
  801b36:	e8 ae fa ff ff       	call   8015e9 <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
  801b3e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b41:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b45:	75 07                	jne    801b4e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b47:	b8 01 00 00 00       	mov    $0x1,%eax
  801b4c:	eb 05                	jmp    801b53 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b4e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b53:	c9                   	leave  
  801b54:	c3                   	ret    

00801b55 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
  801b58:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 2c                	push   $0x2c
  801b67:	e8 7d fa ff ff       	call   8015e9 <syscall>
  801b6c:	83 c4 18             	add    $0x18,%esp
  801b6f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b72:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b76:	75 07                	jne    801b7f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b78:	b8 01 00 00 00       	mov    $0x1,%eax
  801b7d:	eb 05                	jmp    801b84 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b84:	c9                   	leave  
  801b85:	c3                   	ret    

00801b86 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b86:	55                   	push   %ebp
  801b87:	89 e5                	mov    %esp,%ebp
  801b89:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 2c                	push   $0x2c
  801b98:	e8 4c fa ff ff       	call   8015e9 <syscall>
  801b9d:	83 c4 18             	add    $0x18,%esp
  801ba0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ba3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ba7:	75 07                	jne    801bb0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ba9:	b8 01 00 00 00       	mov    $0x1,%eax
  801bae:	eb 05                	jmp    801bb5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801bb0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bb5:	c9                   	leave  
  801bb6:	c3                   	ret    

00801bb7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
  801bba:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 2c                	push   $0x2c
  801bc9:	e8 1b fa ff ff       	call   8015e9 <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
  801bd1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801bd4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bd8:	75 07                	jne    801be1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bda:	b8 01 00 00 00       	mov    $0x1,%eax
  801bdf:	eb 05                	jmp    801be6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801be1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801be6:	c9                   	leave  
  801be7:	c3                   	ret    

00801be8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801be8:	55                   	push   %ebp
  801be9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	ff 75 08             	pushl  0x8(%ebp)
  801bf6:	6a 2d                	push   $0x2d
  801bf8:	e8 ec f9 ff ff       	call   8015e9 <syscall>
  801bfd:	83 c4 18             	add    $0x18,%esp
	return ;
  801c00:	90                   	nop
}
  801c01:	c9                   	leave  
  801c02:	c3                   	ret    

00801c03 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801c03:	55                   	push   %ebp
  801c04:	89 e5                	mov    %esp,%ebp
  801c06:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801c09:	8d 45 10             	lea    0x10(%ebp),%eax
  801c0c:	83 c0 04             	add    $0x4,%eax
  801c0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801c12:	a1 40 50 88 00       	mov    0x885040,%eax
  801c17:	85 c0                	test   %eax,%eax
  801c19:	74 16                	je     801c31 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801c1b:	a1 40 50 88 00       	mov    0x885040,%eax
  801c20:	83 ec 08             	sub    $0x8,%esp
  801c23:	50                   	push   %eax
  801c24:	68 80 25 80 00       	push   $0x802580
  801c29:	e8 28 ea ff ff       	call   800656 <cprintf>
  801c2e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801c31:	a1 00 30 80 00       	mov    0x803000,%eax
  801c36:	ff 75 0c             	pushl  0xc(%ebp)
  801c39:	ff 75 08             	pushl  0x8(%ebp)
  801c3c:	50                   	push   %eax
  801c3d:	68 85 25 80 00       	push   $0x802585
  801c42:	e8 0f ea ff ff       	call   800656 <cprintf>
  801c47:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801c4a:	8b 45 10             	mov    0x10(%ebp),%eax
  801c4d:	83 ec 08             	sub    $0x8,%esp
  801c50:	ff 75 f4             	pushl  -0xc(%ebp)
  801c53:	50                   	push   %eax
  801c54:	e8 92 e9 ff ff       	call   8005eb <vcprintf>
  801c59:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801c5c:	83 ec 08             	sub    $0x8,%esp
  801c5f:	6a 00                	push   $0x0
  801c61:	68 a1 25 80 00       	push   $0x8025a1
  801c66:	e8 80 e9 ff ff       	call   8005eb <vcprintf>
  801c6b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801c6e:	e8 01 e9 ff ff       	call   800574 <exit>

	// should not return here
	while (1) ;
  801c73:	eb fe                	jmp    801c73 <_panic+0x70>

00801c75 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801c75:	55                   	push   %ebp
  801c76:	89 e5                	mov    %esp,%ebp
  801c78:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801c7b:	a1 20 30 80 00       	mov    0x803020,%eax
  801c80:	8b 50 74             	mov    0x74(%eax),%edx
  801c83:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c86:	39 c2                	cmp    %eax,%edx
  801c88:	74 14                	je     801c9e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801c8a:	83 ec 04             	sub    $0x4,%esp
  801c8d:	68 a4 25 80 00       	push   $0x8025a4
  801c92:	6a 26                	push   $0x26
  801c94:	68 f0 25 80 00       	push   $0x8025f0
  801c99:	e8 65 ff ff ff       	call   801c03 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801c9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801ca5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801cac:	e9 c2 00 00 00       	jmp    801d73 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801cb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cb4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbe:	01 d0                	add    %edx,%eax
  801cc0:	8b 00                	mov    (%eax),%eax
  801cc2:	85 c0                	test   %eax,%eax
  801cc4:	75 08                	jne    801cce <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801cc6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801cc9:	e9 a2 00 00 00       	jmp    801d70 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801cce:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cd5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801cdc:	eb 69                	jmp    801d47 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801cde:	a1 20 30 80 00       	mov    0x803020,%eax
  801ce3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ce9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801cec:	89 d0                	mov    %edx,%eax
  801cee:	01 c0                	add    %eax,%eax
  801cf0:	01 d0                	add    %edx,%eax
  801cf2:	c1 e0 02             	shl    $0x2,%eax
  801cf5:	01 c8                	add    %ecx,%eax
  801cf7:	8a 40 04             	mov    0x4(%eax),%al
  801cfa:	84 c0                	test   %al,%al
  801cfc:	75 46                	jne    801d44 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801cfe:	a1 20 30 80 00       	mov    0x803020,%eax
  801d03:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801d09:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d0c:	89 d0                	mov    %edx,%eax
  801d0e:	01 c0                	add    %eax,%eax
  801d10:	01 d0                	add    %edx,%eax
  801d12:	c1 e0 02             	shl    $0x2,%eax
  801d15:	01 c8                	add    %ecx,%eax
  801d17:	8b 00                	mov    (%eax),%eax
  801d19:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801d1c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d1f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801d24:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801d26:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d29:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801d30:	8b 45 08             	mov    0x8(%ebp),%eax
  801d33:	01 c8                	add    %ecx,%eax
  801d35:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d37:	39 c2                	cmp    %eax,%edx
  801d39:	75 09                	jne    801d44 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801d3b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801d42:	eb 12                	jmp    801d56 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d44:	ff 45 e8             	incl   -0x18(%ebp)
  801d47:	a1 20 30 80 00       	mov    0x803020,%eax
  801d4c:	8b 50 74             	mov    0x74(%eax),%edx
  801d4f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d52:	39 c2                	cmp    %eax,%edx
  801d54:	77 88                	ja     801cde <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801d56:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801d5a:	75 14                	jne    801d70 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801d5c:	83 ec 04             	sub    $0x4,%esp
  801d5f:	68 fc 25 80 00       	push   $0x8025fc
  801d64:	6a 3a                	push   $0x3a
  801d66:	68 f0 25 80 00       	push   $0x8025f0
  801d6b:	e8 93 fe ff ff       	call   801c03 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801d70:	ff 45 f0             	incl   -0x10(%ebp)
  801d73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d76:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801d79:	0f 8c 32 ff ff ff    	jl     801cb1 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801d7f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d86:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801d8d:	eb 26                	jmp    801db5 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801d8f:	a1 20 30 80 00       	mov    0x803020,%eax
  801d94:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801d9a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d9d:	89 d0                	mov    %edx,%eax
  801d9f:	01 c0                	add    %eax,%eax
  801da1:	01 d0                	add    %edx,%eax
  801da3:	c1 e0 02             	shl    $0x2,%eax
  801da6:	01 c8                	add    %ecx,%eax
  801da8:	8a 40 04             	mov    0x4(%eax),%al
  801dab:	3c 01                	cmp    $0x1,%al
  801dad:	75 03                	jne    801db2 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801daf:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801db2:	ff 45 e0             	incl   -0x20(%ebp)
  801db5:	a1 20 30 80 00       	mov    0x803020,%eax
  801dba:	8b 50 74             	mov    0x74(%eax),%edx
  801dbd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801dc0:	39 c2                	cmp    %eax,%edx
  801dc2:	77 cb                	ja     801d8f <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801dc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dc7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801dca:	74 14                	je     801de0 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801dcc:	83 ec 04             	sub    $0x4,%esp
  801dcf:	68 50 26 80 00       	push   $0x802650
  801dd4:	6a 44                	push   $0x44
  801dd6:	68 f0 25 80 00       	push   $0x8025f0
  801ddb:	e8 23 fe ff ff       	call   801c03 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801de0:	90                   	nop
  801de1:	c9                   	leave  
  801de2:	c3                   	ret    
  801de3:	90                   	nop

00801de4 <__udivdi3>:
  801de4:	55                   	push   %ebp
  801de5:	57                   	push   %edi
  801de6:	56                   	push   %esi
  801de7:	53                   	push   %ebx
  801de8:	83 ec 1c             	sub    $0x1c,%esp
  801deb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801def:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801df3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801df7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dfb:	89 ca                	mov    %ecx,%edx
  801dfd:	89 f8                	mov    %edi,%eax
  801dff:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e03:	85 f6                	test   %esi,%esi
  801e05:	75 2d                	jne    801e34 <__udivdi3+0x50>
  801e07:	39 cf                	cmp    %ecx,%edi
  801e09:	77 65                	ja     801e70 <__udivdi3+0x8c>
  801e0b:	89 fd                	mov    %edi,%ebp
  801e0d:	85 ff                	test   %edi,%edi
  801e0f:	75 0b                	jne    801e1c <__udivdi3+0x38>
  801e11:	b8 01 00 00 00       	mov    $0x1,%eax
  801e16:	31 d2                	xor    %edx,%edx
  801e18:	f7 f7                	div    %edi
  801e1a:	89 c5                	mov    %eax,%ebp
  801e1c:	31 d2                	xor    %edx,%edx
  801e1e:	89 c8                	mov    %ecx,%eax
  801e20:	f7 f5                	div    %ebp
  801e22:	89 c1                	mov    %eax,%ecx
  801e24:	89 d8                	mov    %ebx,%eax
  801e26:	f7 f5                	div    %ebp
  801e28:	89 cf                	mov    %ecx,%edi
  801e2a:	89 fa                	mov    %edi,%edx
  801e2c:	83 c4 1c             	add    $0x1c,%esp
  801e2f:	5b                   	pop    %ebx
  801e30:	5e                   	pop    %esi
  801e31:	5f                   	pop    %edi
  801e32:	5d                   	pop    %ebp
  801e33:	c3                   	ret    
  801e34:	39 ce                	cmp    %ecx,%esi
  801e36:	77 28                	ja     801e60 <__udivdi3+0x7c>
  801e38:	0f bd fe             	bsr    %esi,%edi
  801e3b:	83 f7 1f             	xor    $0x1f,%edi
  801e3e:	75 40                	jne    801e80 <__udivdi3+0x9c>
  801e40:	39 ce                	cmp    %ecx,%esi
  801e42:	72 0a                	jb     801e4e <__udivdi3+0x6a>
  801e44:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e48:	0f 87 9e 00 00 00    	ja     801eec <__udivdi3+0x108>
  801e4e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e53:	89 fa                	mov    %edi,%edx
  801e55:	83 c4 1c             	add    $0x1c,%esp
  801e58:	5b                   	pop    %ebx
  801e59:	5e                   	pop    %esi
  801e5a:	5f                   	pop    %edi
  801e5b:	5d                   	pop    %ebp
  801e5c:	c3                   	ret    
  801e5d:	8d 76 00             	lea    0x0(%esi),%esi
  801e60:	31 ff                	xor    %edi,%edi
  801e62:	31 c0                	xor    %eax,%eax
  801e64:	89 fa                	mov    %edi,%edx
  801e66:	83 c4 1c             	add    $0x1c,%esp
  801e69:	5b                   	pop    %ebx
  801e6a:	5e                   	pop    %esi
  801e6b:	5f                   	pop    %edi
  801e6c:	5d                   	pop    %ebp
  801e6d:	c3                   	ret    
  801e6e:	66 90                	xchg   %ax,%ax
  801e70:	89 d8                	mov    %ebx,%eax
  801e72:	f7 f7                	div    %edi
  801e74:	31 ff                	xor    %edi,%edi
  801e76:	89 fa                	mov    %edi,%edx
  801e78:	83 c4 1c             	add    $0x1c,%esp
  801e7b:	5b                   	pop    %ebx
  801e7c:	5e                   	pop    %esi
  801e7d:	5f                   	pop    %edi
  801e7e:	5d                   	pop    %ebp
  801e7f:	c3                   	ret    
  801e80:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e85:	89 eb                	mov    %ebp,%ebx
  801e87:	29 fb                	sub    %edi,%ebx
  801e89:	89 f9                	mov    %edi,%ecx
  801e8b:	d3 e6                	shl    %cl,%esi
  801e8d:	89 c5                	mov    %eax,%ebp
  801e8f:	88 d9                	mov    %bl,%cl
  801e91:	d3 ed                	shr    %cl,%ebp
  801e93:	89 e9                	mov    %ebp,%ecx
  801e95:	09 f1                	or     %esi,%ecx
  801e97:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e9b:	89 f9                	mov    %edi,%ecx
  801e9d:	d3 e0                	shl    %cl,%eax
  801e9f:	89 c5                	mov    %eax,%ebp
  801ea1:	89 d6                	mov    %edx,%esi
  801ea3:	88 d9                	mov    %bl,%cl
  801ea5:	d3 ee                	shr    %cl,%esi
  801ea7:	89 f9                	mov    %edi,%ecx
  801ea9:	d3 e2                	shl    %cl,%edx
  801eab:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eaf:	88 d9                	mov    %bl,%cl
  801eb1:	d3 e8                	shr    %cl,%eax
  801eb3:	09 c2                	or     %eax,%edx
  801eb5:	89 d0                	mov    %edx,%eax
  801eb7:	89 f2                	mov    %esi,%edx
  801eb9:	f7 74 24 0c          	divl   0xc(%esp)
  801ebd:	89 d6                	mov    %edx,%esi
  801ebf:	89 c3                	mov    %eax,%ebx
  801ec1:	f7 e5                	mul    %ebp
  801ec3:	39 d6                	cmp    %edx,%esi
  801ec5:	72 19                	jb     801ee0 <__udivdi3+0xfc>
  801ec7:	74 0b                	je     801ed4 <__udivdi3+0xf0>
  801ec9:	89 d8                	mov    %ebx,%eax
  801ecb:	31 ff                	xor    %edi,%edi
  801ecd:	e9 58 ff ff ff       	jmp    801e2a <__udivdi3+0x46>
  801ed2:	66 90                	xchg   %ax,%ax
  801ed4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ed8:	89 f9                	mov    %edi,%ecx
  801eda:	d3 e2                	shl    %cl,%edx
  801edc:	39 c2                	cmp    %eax,%edx
  801ede:	73 e9                	jae    801ec9 <__udivdi3+0xe5>
  801ee0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ee3:	31 ff                	xor    %edi,%edi
  801ee5:	e9 40 ff ff ff       	jmp    801e2a <__udivdi3+0x46>
  801eea:	66 90                	xchg   %ax,%ax
  801eec:	31 c0                	xor    %eax,%eax
  801eee:	e9 37 ff ff ff       	jmp    801e2a <__udivdi3+0x46>
  801ef3:	90                   	nop

00801ef4 <__umoddi3>:
  801ef4:	55                   	push   %ebp
  801ef5:	57                   	push   %edi
  801ef6:	56                   	push   %esi
  801ef7:	53                   	push   %ebx
  801ef8:	83 ec 1c             	sub    $0x1c,%esp
  801efb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801eff:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f03:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f07:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f0b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f0f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f13:	89 f3                	mov    %esi,%ebx
  801f15:	89 fa                	mov    %edi,%edx
  801f17:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f1b:	89 34 24             	mov    %esi,(%esp)
  801f1e:	85 c0                	test   %eax,%eax
  801f20:	75 1a                	jne    801f3c <__umoddi3+0x48>
  801f22:	39 f7                	cmp    %esi,%edi
  801f24:	0f 86 a2 00 00 00    	jbe    801fcc <__umoddi3+0xd8>
  801f2a:	89 c8                	mov    %ecx,%eax
  801f2c:	89 f2                	mov    %esi,%edx
  801f2e:	f7 f7                	div    %edi
  801f30:	89 d0                	mov    %edx,%eax
  801f32:	31 d2                	xor    %edx,%edx
  801f34:	83 c4 1c             	add    $0x1c,%esp
  801f37:	5b                   	pop    %ebx
  801f38:	5e                   	pop    %esi
  801f39:	5f                   	pop    %edi
  801f3a:	5d                   	pop    %ebp
  801f3b:	c3                   	ret    
  801f3c:	39 f0                	cmp    %esi,%eax
  801f3e:	0f 87 ac 00 00 00    	ja     801ff0 <__umoddi3+0xfc>
  801f44:	0f bd e8             	bsr    %eax,%ebp
  801f47:	83 f5 1f             	xor    $0x1f,%ebp
  801f4a:	0f 84 ac 00 00 00    	je     801ffc <__umoddi3+0x108>
  801f50:	bf 20 00 00 00       	mov    $0x20,%edi
  801f55:	29 ef                	sub    %ebp,%edi
  801f57:	89 fe                	mov    %edi,%esi
  801f59:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f5d:	89 e9                	mov    %ebp,%ecx
  801f5f:	d3 e0                	shl    %cl,%eax
  801f61:	89 d7                	mov    %edx,%edi
  801f63:	89 f1                	mov    %esi,%ecx
  801f65:	d3 ef                	shr    %cl,%edi
  801f67:	09 c7                	or     %eax,%edi
  801f69:	89 e9                	mov    %ebp,%ecx
  801f6b:	d3 e2                	shl    %cl,%edx
  801f6d:	89 14 24             	mov    %edx,(%esp)
  801f70:	89 d8                	mov    %ebx,%eax
  801f72:	d3 e0                	shl    %cl,%eax
  801f74:	89 c2                	mov    %eax,%edx
  801f76:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f7a:	d3 e0                	shl    %cl,%eax
  801f7c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f80:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f84:	89 f1                	mov    %esi,%ecx
  801f86:	d3 e8                	shr    %cl,%eax
  801f88:	09 d0                	or     %edx,%eax
  801f8a:	d3 eb                	shr    %cl,%ebx
  801f8c:	89 da                	mov    %ebx,%edx
  801f8e:	f7 f7                	div    %edi
  801f90:	89 d3                	mov    %edx,%ebx
  801f92:	f7 24 24             	mull   (%esp)
  801f95:	89 c6                	mov    %eax,%esi
  801f97:	89 d1                	mov    %edx,%ecx
  801f99:	39 d3                	cmp    %edx,%ebx
  801f9b:	0f 82 87 00 00 00    	jb     802028 <__umoddi3+0x134>
  801fa1:	0f 84 91 00 00 00    	je     802038 <__umoddi3+0x144>
  801fa7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fab:	29 f2                	sub    %esi,%edx
  801fad:	19 cb                	sbb    %ecx,%ebx
  801faf:	89 d8                	mov    %ebx,%eax
  801fb1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fb5:	d3 e0                	shl    %cl,%eax
  801fb7:	89 e9                	mov    %ebp,%ecx
  801fb9:	d3 ea                	shr    %cl,%edx
  801fbb:	09 d0                	or     %edx,%eax
  801fbd:	89 e9                	mov    %ebp,%ecx
  801fbf:	d3 eb                	shr    %cl,%ebx
  801fc1:	89 da                	mov    %ebx,%edx
  801fc3:	83 c4 1c             	add    $0x1c,%esp
  801fc6:	5b                   	pop    %ebx
  801fc7:	5e                   	pop    %esi
  801fc8:	5f                   	pop    %edi
  801fc9:	5d                   	pop    %ebp
  801fca:	c3                   	ret    
  801fcb:	90                   	nop
  801fcc:	89 fd                	mov    %edi,%ebp
  801fce:	85 ff                	test   %edi,%edi
  801fd0:	75 0b                	jne    801fdd <__umoddi3+0xe9>
  801fd2:	b8 01 00 00 00       	mov    $0x1,%eax
  801fd7:	31 d2                	xor    %edx,%edx
  801fd9:	f7 f7                	div    %edi
  801fdb:	89 c5                	mov    %eax,%ebp
  801fdd:	89 f0                	mov    %esi,%eax
  801fdf:	31 d2                	xor    %edx,%edx
  801fe1:	f7 f5                	div    %ebp
  801fe3:	89 c8                	mov    %ecx,%eax
  801fe5:	f7 f5                	div    %ebp
  801fe7:	89 d0                	mov    %edx,%eax
  801fe9:	e9 44 ff ff ff       	jmp    801f32 <__umoddi3+0x3e>
  801fee:	66 90                	xchg   %ax,%ax
  801ff0:	89 c8                	mov    %ecx,%eax
  801ff2:	89 f2                	mov    %esi,%edx
  801ff4:	83 c4 1c             	add    $0x1c,%esp
  801ff7:	5b                   	pop    %ebx
  801ff8:	5e                   	pop    %esi
  801ff9:	5f                   	pop    %edi
  801ffa:	5d                   	pop    %ebp
  801ffb:	c3                   	ret    
  801ffc:	3b 04 24             	cmp    (%esp),%eax
  801fff:	72 06                	jb     802007 <__umoddi3+0x113>
  802001:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802005:	77 0f                	ja     802016 <__umoddi3+0x122>
  802007:	89 f2                	mov    %esi,%edx
  802009:	29 f9                	sub    %edi,%ecx
  80200b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80200f:	89 14 24             	mov    %edx,(%esp)
  802012:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802016:	8b 44 24 04          	mov    0x4(%esp),%eax
  80201a:	8b 14 24             	mov    (%esp),%edx
  80201d:	83 c4 1c             	add    $0x1c,%esp
  802020:	5b                   	pop    %ebx
  802021:	5e                   	pop    %esi
  802022:	5f                   	pop    %edi
  802023:	5d                   	pop    %ebp
  802024:	c3                   	ret    
  802025:	8d 76 00             	lea    0x0(%esi),%esi
  802028:	2b 04 24             	sub    (%esp),%eax
  80202b:	19 fa                	sbb    %edi,%edx
  80202d:	89 d1                	mov    %edx,%ecx
  80202f:	89 c6                	mov    %eax,%esi
  802031:	e9 71 ff ff ff       	jmp    801fa7 <__umoddi3+0xb3>
  802036:	66 90                	xchg   %ax,%ax
  802038:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80203c:	72 ea                	jb     802028 <__umoddi3+0x134>
  80203e:	89 d9                	mov    %ebx,%ecx
  802040:	e9 62 ff ff ff       	jmp    801fa7 <__umoddi3+0xb3>
