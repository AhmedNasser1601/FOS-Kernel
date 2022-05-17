
obj/user/arrayOperations_stats:     file format elf32-i386


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
  800031:	e8 f7 04 00 00       	call   80052d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var, int *min, int *max, int *med);
int KthElement(int *Elements, int NumOfElements, int k);
int QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex, int kIndex);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 58             	sub    $0x58,%esp
	int32 envID = sys_getenvid();
  80003e:	e8 1b 18 00 00       	call   80185e <sys_getenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int32 parentenvID = sys_getparentenvid();
  800046:	e8 45 18 00 00       	call   801890 <sys_getparentenvid>
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
  80005f:	68 40 22 80 00       	push   $0x802240
  800064:	ff 75 ec             	pushl  -0x14(%ebp)
  800067:	e8 84 16 00 00       	call   8016f0 <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	numOfElements = sget(parentenvID,"arrSize") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 44 22 80 00       	push   $0x802244
  80007a:	ff 75 ec             	pushl  -0x14(%ebp)
  80007d:	e8 6e 16 00 00       	call   8016f0 <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800088:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	finishedCount = sget(parentenvID,"finishedCount") ;
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	68 4c 22 80 00       	push   $0x80224c
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 51 16 00 00       	call   8016f0 <sget>
  80009f:	83 c4 10             	add    $0x10,%esp
  8000a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int max ;
	int med ;

	//take a copy from the original array
	int *tmpArray;
	tmpArray = smalloc("tmpArr", sizeof(int) * *numOfElements, 0) ;
  8000a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000a8:	8b 00                	mov    (%eax),%eax
  8000aa:	c1 e0 02             	shl    $0x2,%eax
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 00                	push   $0x0
  8000b2:	50                   	push   %eax
  8000b3:	68 5a 22 80 00       	push   $0x80225a
  8000b8:	e8 13 16 00 00       	call   8016d0 <smalloc>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ca:	eb 25                	jmp    8000f1 <_main+0xb9>
	{
		tmpArray[i] = sharedArray[i];
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

	//take a copy from the original array
	int *tmpArray;
	tmpArray = smalloc("tmpArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000ee:	ff 45 f4             	incl   -0xc(%ebp)
  8000f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f4:	8b 00                	mov    (%eax),%eax
  8000f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f9:	7f d1                	jg     8000cc <_main+0x94>
	{
		tmpArray[i] = sharedArray[i];
	}

	ArrayStats(tmpArray ,*numOfElements, &mean, &var, &min, &max, &med);
  8000fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000fe:	8b 00                	mov    (%eax),%eax
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	8d 55 b4             	lea    -0x4c(%ebp),%edx
  800106:	52                   	push   %edx
  800107:	8d 55 b8             	lea    -0x48(%ebp),%edx
  80010a:	52                   	push   %edx
  80010b:	8d 55 bc             	lea    -0x44(%ebp),%edx
  80010e:	52                   	push   %edx
  80010f:	8d 55 c0             	lea    -0x40(%ebp),%edx
  800112:	52                   	push   %edx
  800113:	8d 55 c4             	lea    -0x3c(%ebp),%edx
  800116:	52                   	push   %edx
  800117:	50                   	push   %eax
  800118:	ff 75 dc             	pushl  -0x24(%ebp)
  80011b:	e8 55 02 00 00       	call   800375 <ArrayStats>
  800120:	83 c4 20             	add    $0x20,%esp
	cprintf("Stats Calculations are Finished!!!!\n") ;
  800123:	83 ec 0c             	sub    $0xc,%esp
  800126:	68 64 22 80 00       	push   $0x802264
  80012b:	e8 e0 05 00 00       	call   800710 <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	int *shMean, *shVar, *shMin, *shMax, *shMed;
	shMean = smalloc("mean", sizeof(int), 0) ; *shMean = mean;
  800133:	83 ec 04             	sub    $0x4,%esp
  800136:	6a 00                	push   $0x0
  800138:	6a 04                	push   $0x4
  80013a:	68 89 22 80 00       	push   $0x802289
  80013f:	e8 8c 15 00 00       	call   8016d0 <smalloc>
  800144:	83 c4 10             	add    $0x10,%esp
  800147:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80014a:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  80014d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800150:	89 10                	mov    %edx,(%eax)
	shVar = smalloc("var", sizeof(int), 0) ; *shVar = var;
  800152:	83 ec 04             	sub    $0x4,%esp
  800155:	6a 00                	push   $0x0
  800157:	6a 04                	push   $0x4
  800159:	68 8e 22 80 00       	push   $0x80228e
  80015e:	e8 6d 15 00 00       	call   8016d0 <smalloc>
  800163:	83 c4 10             	add    $0x10,%esp
  800166:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800169:	8b 55 c0             	mov    -0x40(%ebp),%edx
  80016c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80016f:	89 10                	mov    %edx,(%eax)
	shMin = smalloc("min", sizeof(int), 0) ; *shMin = min;
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	6a 00                	push   $0x0
  800176:	6a 04                	push   $0x4
  800178:	68 92 22 80 00       	push   $0x802292
  80017d:	e8 4e 15 00 00       	call   8016d0 <smalloc>
  800182:	83 c4 10             	add    $0x10,%esp
  800185:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800188:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80018b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80018e:	89 10                	mov    %edx,(%eax)
	shMax = smalloc("max", sizeof(int), 0) ; *shMax = max;
  800190:	83 ec 04             	sub    $0x4,%esp
  800193:	6a 00                	push   $0x0
  800195:	6a 04                	push   $0x4
  800197:	68 96 22 80 00       	push   $0x802296
  80019c:	e8 2f 15 00 00       	call   8016d0 <smalloc>
  8001a1:	83 c4 10             	add    $0x10,%esp
  8001a4:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001a7:	8b 55 b8             	mov    -0x48(%ebp),%edx
  8001aa:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001ad:	89 10                	mov    %edx,(%eax)
	shMed = smalloc("med", sizeof(int), 0) ; *shMed = med;
  8001af:	83 ec 04             	sub    $0x4,%esp
  8001b2:	6a 00                	push   $0x0
  8001b4:	6a 04                	push   $0x4
  8001b6:	68 9a 22 80 00       	push   $0x80229a
  8001bb:	e8 10 15 00 00       	call   8016d0 <smalloc>
  8001c0:	83 c4 10             	add    $0x10,%esp
  8001c3:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8001c6:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  8001c9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001cc:	89 10                	mov    %edx,(%eax)

	(*finishedCount)++ ;
  8001ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001d1:	8b 00                	mov    (%eax),%eax
  8001d3:	8d 50 01             	lea    0x1(%eax),%edx
  8001d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001d9:	89 10                	mov    %edx,(%eax)

}
  8001db:	90                   	nop
  8001dc:	c9                   	leave  
  8001dd:	c3                   	ret    

008001de <KthElement>:



///Kth Element
int KthElement(int *Elements, int NumOfElements, int k)
{
  8001de:	55                   	push   %ebp
  8001df:	89 e5                	mov    %esp,%ebp
  8001e1:	83 ec 08             	sub    $0x8,%esp
	return QSort(Elements, NumOfElements, 0, NumOfElements-1, k-1) ;
  8001e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8001e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8001ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ed:	48                   	dec    %eax
  8001ee:	83 ec 0c             	sub    $0xc,%esp
  8001f1:	52                   	push   %edx
  8001f2:	50                   	push   %eax
  8001f3:	6a 00                	push   $0x0
  8001f5:	ff 75 0c             	pushl  0xc(%ebp)
  8001f8:	ff 75 08             	pushl  0x8(%ebp)
  8001fb:	e8 05 00 00 00       	call   800205 <QSort>
  800200:	83 c4 20             	add    $0x20,%esp
}
  800203:	c9                   	leave  
  800204:	c3                   	ret    

00800205 <QSort>:


int QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex, int kIndex)
{
  800205:	55                   	push   %ebp
  800206:	89 e5                	mov    %esp,%ebp
  800208:	83 ec 28             	sub    $0x28,%esp
	if (startIndex >= finalIndex) return Elements[finalIndex];
  80020b:	8b 45 10             	mov    0x10(%ebp),%eax
  80020e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800211:	7c 16                	jl     800229 <QSort+0x24>
  800213:	8b 45 14             	mov    0x14(%ebp),%eax
  800216:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80021d:	8b 45 08             	mov    0x8(%ebp),%eax
  800220:	01 d0                	add    %edx,%eax
  800222:	8b 00                	mov    (%eax),%eax
  800224:	e9 4a 01 00 00       	jmp    800373 <QSort+0x16e>

	int pvtIndex = RAND(startIndex, finalIndex) ;
  800229:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  80022c:	83 ec 0c             	sub    $0xc,%esp
  80022f:	50                   	push   %eax
  800230:	e8 b7 19 00 00       	call   801bec <sys_get_virtual_time>
  800235:	83 c4 0c             	add    $0xc,%esp
  800238:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80023b:	8b 55 14             	mov    0x14(%ebp),%edx
  80023e:	2b 55 10             	sub    0x10(%ebp),%edx
  800241:	89 d1                	mov    %edx,%ecx
  800243:	ba 00 00 00 00       	mov    $0x0,%edx
  800248:	f7 f1                	div    %ecx
  80024a:	8b 45 10             	mov    0x10(%ebp),%eax
  80024d:	01 d0                	add    %edx,%eax
  80024f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	Swap(Elements, startIndex, pvtIndex);
  800252:	83 ec 04             	sub    $0x4,%esp
  800255:	ff 75 ec             	pushl  -0x14(%ebp)
  800258:	ff 75 10             	pushl  0x10(%ebp)
  80025b:	ff 75 08             	pushl  0x8(%ebp)
  80025e:	e8 77 02 00 00       	call   8004da <Swap>
  800263:	83 c4 10             	add    $0x10,%esp

	int i = startIndex+1, j = finalIndex;
  800266:	8b 45 10             	mov    0x10(%ebp),%eax
  800269:	40                   	inc    %eax
  80026a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80026d:	8b 45 14             	mov    0x14(%ebp),%eax
  800270:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800273:	e9 80 00 00 00       	jmp    8002f8 <QSort+0xf3>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800278:	ff 45 f4             	incl   -0xc(%ebp)
  80027b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80027e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800281:	7f 2b                	jg     8002ae <QSort+0xa9>
  800283:	8b 45 10             	mov    0x10(%ebp),%eax
  800286:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028d:	8b 45 08             	mov    0x8(%ebp),%eax
  800290:	01 d0                	add    %edx,%eax
  800292:	8b 10                	mov    (%eax),%edx
  800294:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800297:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80029e:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a1:	01 c8                	add    %ecx,%eax
  8002a3:	8b 00                	mov    (%eax),%eax
  8002a5:	39 c2                	cmp    %eax,%edx
  8002a7:	7d cf                	jge    800278 <QSort+0x73>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002a9:	eb 03                	jmp    8002ae <QSort+0xa9>
  8002ab:	ff 4d f0             	decl   -0x10(%ebp)
  8002ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002b1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002b4:	7e 26                	jle    8002dc <QSort+0xd7>
  8002b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c3:	01 d0                	add    %edx,%eax
  8002c5:	8b 10                	mov    (%eax),%edx
  8002c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d4:	01 c8                	add    %ecx,%eax
  8002d6:	8b 00                	mov    (%eax),%eax
  8002d8:	39 c2                	cmp    %eax,%edx
  8002da:	7e cf                	jle    8002ab <QSort+0xa6>

		if (i <= j)
  8002dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002df:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002e2:	7f 14                	jg     8002f8 <QSort+0xf3>
		{
			Swap(Elements, i, j);
  8002e4:	83 ec 04             	sub    $0x4,%esp
  8002e7:	ff 75 f0             	pushl  -0x10(%ebp)
  8002ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ed:	ff 75 08             	pushl  0x8(%ebp)
  8002f0:	e8 e5 01 00 00       	call   8004da <Swap>
  8002f5:	83 c4 10             	add    $0x10,%esp
	int pvtIndex = RAND(startIndex, finalIndex) ;
	Swap(Elements, startIndex, pvtIndex);

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8002f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002fe:	0f 8e 77 ff ff ff    	jle    80027b <QSort+0x76>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800304:	83 ec 04             	sub    $0x4,%esp
  800307:	ff 75 f0             	pushl  -0x10(%ebp)
  80030a:	ff 75 10             	pushl  0x10(%ebp)
  80030d:	ff 75 08             	pushl  0x8(%ebp)
  800310:	e8 c5 01 00 00       	call   8004da <Swap>
  800315:	83 c4 10             	add    $0x10,%esp

	if (kIndex == j)
  800318:	8b 45 18             	mov    0x18(%ebp),%eax
  80031b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80031e:	75 13                	jne    800333 <QSort+0x12e>
		return Elements[kIndex] ;
  800320:	8b 45 18             	mov    0x18(%ebp),%eax
  800323:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032a:	8b 45 08             	mov    0x8(%ebp),%eax
  80032d:	01 d0                	add    %edx,%eax
  80032f:	8b 00                	mov    (%eax),%eax
  800331:	eb 40                	jmp    800373 <QSort+0x16e>
	else if (kIndex < j)
  800333:	8b 45 18             	mov    0x18(%ebp),%eax
  800336:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800339:	7d 1e                	jge    800359 <QSort+0x154>
		return QSort(Elements, NumOfElements, startIndex, j - 1, kIndex);
  80033b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033e:	48                   	dec    %eax
  80033f:	83 ec 0c             	sub    $0xc,%esp
  800342:	ff 75 18             	pushl  0x18(%ebp)
  800345:	50                   	push   %eax
  800346:	ff 75 10             	pushl  0x10(%ebp)
  800349:	ff 75 0c             	pushl  0xc(%ebp)
  80034c:	ff 75 08             	pushl  0x8(%ebp)
  80034f:	e8 b1 fe ff ff       	call   800205 <QSort>
  800354:	83 c4 20             	add    $0x20,%esp
  800357:	eb 1a                	jmp    800373 <QSort+0x16e>
	else
		return QSort(Elements, NumOfElements, i, finalIndex, kIndex);
  800359:	83 ec 0c             	sub    $0xc,%esp
  80035c:	ff 75 18             	pushl  0x18(%ebp)
  80035f:	ff 75 14             	pushl  0x14(%ebp)
  800362:	ff 75 f4             	pushl  -0xc(%ebp)
  800365:	ff 75 0c             	pushl  0xc(%ebp)
  800368:	ff 75 08             	pushl  0x8(%ebp)
  80036b:	e8 95 fe ff ff       	call   800205 <QSort>
  800370:	83 c4 20             	add    $0x20,%esp
}
  800373:	c9                   	leave  
  800374:	c3                   	ret    

00800375 <ArrayStats>:

void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var, int *min, int *max, int *med)
{
  800375:	55                   	push   %ebp
  800376:	89 e5                	mov    %esp,%ebp
  800378:	53                   	push   %ebx
  800379:	83 ec 14             	sub    $0x14,%esp
	int i ;
	*mean =0 ;
  80037c:	8b 45 10             	mov    0x10(%ebp),%eax
  80037f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	*min = 0x7FFFFFFF ;
  800385:	8b 45 18             	mov    0x18(%ebp),%eax
  800388:	c7 00 ff ff ff 7f    	movl   $0x7fffffff,(%eax)
	*max = 0x80000000 ;
  80038e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800391:	c7 00 00 00 00 80    	movl   $0x80000000,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  800397:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80039e:	e9 80 00 00 00       	jmp    800423 <ArrayStats+0xae>
	{
		(*mean) += Elements[i];
  8003a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8003a6:	8b 10                	mov    (%eax),%edx
  8003a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ab:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b5:	01 c8                	add    %ecx,%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	01 c2                	add    %eax,%edx
  8003bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8003be:	89 10                	mov    %edx,(%eax)
		if (Elements[i] < (*min))
  8003c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cd:	01 d0                	add    %edx,%eax
  8003cf:	8b 10                	mov    (%eax),%edx
  8003d1:	8b 45 18             	mov    0x18(%ebp),%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	39 c2                	cmp    %eax,%edx
  8003d8:	7d 16                	jge    8003f0 <ArrayStats+0x7b>
		{
			(*min) = Elements[i];
  8003da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e7:	01 d0                	add    %edx,%eax
  8003e9:	8b 10                	mov    (%eax),%edx
  8003eb:	8b 45 18             	mov    0x18(%ebp),%eax
  8003ee:	89 10                	mov    %edx,(%eax)
		}
		if (Elements[i] > (*max))
  8003f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fd:	01 d0                	add    %edx,%eax
  8003ff:	8b 10                	mov    (%eax),%edx
  800401:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800404:	8b 00                	mov    (%eax),%eax
  800406:	39 c2                	cmp    %eax,%edx
  800408:	7e 16                	jle    800420 <ArrayStats+0xab>
		{
			(*max) = Elements[i];
  80040a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80040d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	01 d0                	add    %edx,%eax
  800419:	8b 10                	mov    (%eax),%edx
  80041b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80041e:	89 10                	mov    %edx,(%eax)
{
	int i ;
	*mean =0 ;
	*min = 0x7FFFFFFF ;
	*max = 0x80000000 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800420:	ff 45 f4             	incl   -0xc(%ebp)
  800423:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800426:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800429:	0f 8c 74 ff ff ff    	jl     8003a3 <ArrayStats+0x2e>
		{
			(*max) = Elements[i];
		}
	}

	(*med) = KthElement(Elements, NumOfElements, NumOfElements/2);
  80042f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800432:	89 c2                	mov    %eax,%edx
  800434:	c1 ea 1f             	shr    $0x1f,%edx
  800437:	01 d0                	add    %edx,%eax
  800439:	d1 f8                	sar    %eax
  80043b:	83 ec 04             	sub    $0x4,%esp
  80043e:	50                   	push   %eax
  80043f:	ff 75 0c             	pushl  0xc(%ebp)
  800442:	ff 75 08             	pushl  0x8(%ebp)
  800445:	e8 94 fd ff ff       	call   8001de <KthElement>
  80044a:	83 c4 10             	add    $0x10,%esp
  80044d:	89 c2                	mov    %eax,%edx
  80044f:	8b 45 20             	mov    0x20(%ebp),%eax
  800452:	89 10                	mov    %edx,(%eax)

	(*mean) /= NumOfElements;
  800454:	8b 45 10             	mov    0x10(%ebp),%eax
  800457:	8b 00                	mov    (%eax),%eax
  800459:	99                   	cltd   
  80045a:	f7 7d 0c             	idivl  0xc(%ebp)
  80045d:	89 c2                	mov    %eax,%edx
  80045f:	8b 45 10             	mov    0x10(%ebp),%eax
  800462:	89 10                	mov    %edx,(%eax)
	(*var) = 0;
  800464:	8b 45 14             	mov    0x14(%ebp),%eax
  800467:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  80046d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800474:	eb 46                	jmp    8004bc <ArrayStats+0x147>
	{
		(*var) += (Elements[i] - (*mean))*(Elements[i] - (*mean));
  800476:	8b 45 14             	mov    0x14(%ebp),%eax
  800479:	8b 10                	mov    (%eax),%edx
  80047b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80047e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	01 c8                	add    %ecx,%eax
  80048a:	8b 08                	mov    (%eax),%ecx
  80048c:	8b 45 10             	mov    0x10(%ebp),%eax
  80048f:	8b 00                	mov    (%eax),%eax
  800491:	89 cb                	mov    %ecx,%ebx
  800493:	29 c3                	sub    %eax,%ebx
  800495:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800498:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80049f:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a2:	01 c8                	add    %ecx,%eax
  8004a4:	8b 08                	mov    (%eax),%ecx
  8004a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a9:	8b 00                	mov    (%eax),%eax
  8004ab:	29 c1                	sub    %eax,%ecx
  8004ad:	89 c8                	mov    %ecx,%eax
  8004af:	0f af c3             	imul   %ebx,%eax
  8004b2:	01 c2                	add    %eax,%edx
  8004b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8004b7:	89 10                	mov    %edx,(%eax)

	(*med) = KthElement(Elements, NumOfElements, NumOfElements/2);

	(*mean) /= NumOfElements;
	(*var) = 0;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b9:	ff 45 f4             	incl   -0xc(%ebp)
  8004bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004bf:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004c2:	7c b2                	jl     800476 <ArrayStats+0x101>
	{
		(*var) += (Elements[i] - (*mean))*(Elements[i] - (*mean));
	}
	(*var) /= NumOfElements;
  8004c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	99                   	cltd   
  8004ca:	f7 7d 0c             	idivl  0xc(%ebp)
  8004cd:	89 c2                	mov    %eax,%edx
  8004cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d2:	89 10                	mov    %edx,(%eax)
}
  8004d4:	90                   	nop
  8004d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004d8:	c9                   	leave  
  8004d9:	c3                   	ret    

008004da <Swap>:

///Private Functions
void Swap(int *Elements, int First, int Second)
{
  8004da:	55                   	push   %ebp
  8004db:	89 e5                	mov    %esp,%ebp
  8004dd:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8004e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ed:	01 d0                	add    %edx,%eax
  8004ef:	8b 00                	mov    (%eax),%eax
  8004f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8004f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800501:	01 c2                	add    %eax,%edx
  800503:	8b 45 10             	mov    0x10(%ebp),%eax
  800506:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 c8                	add    %ecx,%eax
  800512:	8b 00                	mov    (%eax),%eax
  800514:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800516:	8b 45 10             	mov    0x10(%ebp),%eax
  800519:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800520:	8b 45 08             	mov    0x8(%ebp),%eax
  800523:	01 c2                	add    %eax,%edx
  800525:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800528:	89 02                	mov    %eax,(%edx)
}
  80052a:	90                   	nop
  80052b:	c9                   	leave  
  80052c:	c3                   	ret    

0080052d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80052d:	55                   	push   %ebp
  80052e:	89 e5                	mov    %esp,%ebp
  800530:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800533:	e8 3f 13 00 00       	call   801877 <sys_getenvindex>
  800538:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80053b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80053e:	89 d0                	mov    %edx,%eax
  800540:	c1 e0 02             	shl    $0x2,%eax
  800543:	01 d0                	add    %edx,%eax
  800545:	01 c0                	add    %eax,%eax
  800547:	01 d0                	add    %edx,%eax
  800549:	01 c0                	add    %eax,%eax
  80054b:	01 d0                	add    %edx,%eax
  80054d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800554:	01 d0                	add    %edx,%eax
  800556:	c1 e0 02             	shl    $0x2,%eax
  800559:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80055e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800563:	a1 20 30 80 00       	mov    0x803020,%eax
  800568:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80056e:	84 c0                	test   %al,%al
  800570:	74 0f                	je     800581 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800572:	a1 20 30 80 00       	mov    0x803020,%eax
  800577:	05 f4 02 00 00       	add    $0x2f4,%eax
  80057c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800581:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800585:	7e 0a                	jle    800591 <libmain+0x64>
		binaryname = argv[0];
  800587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058a:	8b 00                	mov    (%eax),%eax
  80058c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800591:	83 ec 08             	sub    $0x8,%esp
  800594:	ff 75 0c             	pushl  0xc(%ebp)
  800597:	ff 75 08             	pushl  0x8(%ebp)
  80059a:	e8 99 fa ff ff       	call   800038 <_main>
  80059f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8005a2:	e8 6b 14 00 00       	call   801a12 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8005a7:	83 ec 0c             	sub    $0xc,%esp
  8005aa:	68 b8 22 80 00       	push   $0x8022b8
  8005af:	e8 5c 01 00 00       	call   800710 <cprintf>
  8005b4:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8005b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8005bc:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8005c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c7:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8005cd:	83 ec 04             	sub    $0x4,%esp
  8005d0:	52                   	push   %edx
  8005d1:	50                   	push   %eax
  8005d2:	68 e0 22 80 00       	push   $0x8022e0
  8005d7:	e8 34 01 00 00       	call   800710 <cprintf>
  8005dc:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8005df:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e4:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8005ea:	83 ec 08             	sub    $0x8,%esp
  8005ed:	50                   	push   %eax
  8005ee:	68 05 23 80 00       	push   $0x802305
  8005f3:	e8 18 01 00 00       	call   800710 <cprintf>
  8005f8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8005fb:	83 ec 0c             	sub    $0xc,%esp
  8005fe:	68 b8 22 80 00       	push   $0x8022b8
  800603:	e8 08 01 00 00       	call   800710 <cprintf>
  800608:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80060b:	e8 1c 14 00 00       	call   801a2c <sys_enable_interrupt>

	// exit gracefully
	exit();
  800610:	e8 19 00 00 00       	call   80062e <exit>
}
  800615:	90                   	nop
  800616:	c9                   	leave  
  800617:	c3                   	ret    

00800618 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800618:	55                   	push   %ebp
  800619:	89 e5                	mov    %esp,%ebp
  80061b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80061e:	83 ec 0c             	sub    $0xc,%esp
  800621:	6a 00                	push   $0x0
  800623:	e8 1b 12 00 00       	call   801843 <sys_env_destroy>
  800628:	83 c4 10             	add    $0x10,%esp
}
  80062b:	90                   	nop
  80062c:	c9                   	leave  
  80062d:	c3                   	ret    

0080062e <exit>:

void
exit(void)
{
  80062e:	55                   	push   %ebp
  80062f:	89 e5                	mov    %esp,%ebp
  800631:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800634:	e8 70 12 00 00       	call   8018a9 <sys_env_exit>
}
  800639:	90                   	nop
  80063a:	c9                   	leave  
  80063b:	c3                   	ret    

0080063c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80063c:	55                   	push   %ebp
  80063d:	89 e5                	mov    %esp,%ebp
  80063f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800642:	8b 45 0c             	mov    0xc(%ebp),%eax
  800645:	8b 00                	mov    (%eax),%eax
  800647:	8d 48 01             	lea    0x1(%eax),%ecx
  80064a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80064d:	89 0a                	mov    %ecx,(%edx)
  80064f:	8b 55 08             	mov    0x8(%ebp),%edx
  800652:	88 d1                	mov    %dl,%cl
  800654:	8b 55 0c             	mov    0xc(%ebp),%edx
  800657:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80065b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80065e:	8b 00                	mov    (%eax),%eax
  800660:	3d ff 00 00 00       	cmp    $0xff,%eax
  800665:	75 2c                	jne    800693 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800667:	a0 24 30 80 00       	mov    0x803024,%al
  80066c:	0f b6 c0             	movzbl %al,%eax
  80066f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800672:	8b 12                	mov    (%edx),%edx
  800674:	89 d1                	mov    %edx,%ecx
  800676:	8b 55 0c             	mov    0xc(%ebp),%edx
  800679:	83 c2 08             	add    $0x8,%edx
  80067c:	83 ec 04             	sub    $0x4,%esp
  80067f:	50                   	push   %eax
  800680:	51                   	push   %ecx
  800681:	52                   	push   %edx
  800682:	e8 7a 11 00 00       	call   801801 <sys_cputs>
  800687:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80068a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80068d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800693:	8b 45 0c             	mov    0xc(%ebp),%eax
  800696:	8b 40 04             	mov    0x4(%eax),%eax
  800699:	8d 50 01             	lea    0x1(%eax),%edx
  80069c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80069f:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006a2:	90                   	nop
  8006a3:	c9                   	leave  
  8006a4:	c3                   	ret    

008006a5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006a5:	55                   	push   %ebp
  8006a6:	89 e5                	mov    %esp,%ebp
  8006a8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006ae:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006b5:	00 00 00 
	b.cnt = 0;
  8006b8:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006bf:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006c2:	ff 75 0c             	pushl  0xc(%ebp)
  8006c5:	ff 75 08             	pushl  0x8(%ebp)
  8006c8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006ce:	50                   	push   %eax
  8006cf:	68 3c 06 80 00       	push   $0x80063c
  8006d4:	e8 11 02 00 00       	call   8008ea <vprintfmt>
  8006d9:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006dc:	a0 24 30 80 00       	mov    0x803024,%al
  8006e1:	0f b6 c0             	movzbl %al,%eax
  8006e4:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006ea:	83 ec 04             	sub    $0x4,%esp
  8006ed:	50                   	push   %eax
  8006ee:	52                   	push   %edx
  8006ef:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006f5:	83 c0 08             	add    $0x8,%eax
  8006f8:	50                   	push   %eax
  8006f9:	e8 03 11 00 00       	call   801801 <sys_cputs>
  8006fe:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800701:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800708:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80070e:	c9                   	leave  
  80070f:	c3                   	ret    

00800710 <cprintf>:

int cprintf(const char *fmt, ...) {
  800710:	55                   	push   %ebp
  800711:	89 e5                	mov    %esp,%ebp
  800713:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800716:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80071d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800720:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800723:	8b 45 08             	mov    0x8(%ebp),%eax
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	ff 75 f4             	pushl  -0xc(%ebp)
  80072c:	50                   	push   %eax
  80072d:	e8 73 ff ff ff       	call   8006a5 <vcprintf>
  800732:	83 c4 10             	add    $0x10,%esp
  800735:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800738:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80073b:	c9                   	leave  
  80073c:	c3                   	ret    

0080073d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80073d:	55                   	push   %ebp
  80073e:	89 e5                	mov    %esp,%ebp
  800740:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800743:	e8 ca 12 00 00       	call   801a12 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800748:	8d 45 0c             	lea    0xc(%ebp),%eax
  80074b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80074e:	8b 45 08             	mov    0x8(%ebp),%eax
  800751:	83 ec 08             	sub    $0x8,%esp
  800754:	ff 75 f4             	pushl  -0xc(%ebp)
  800757:	50                   	push   %eax
  800758:	e8 48 ff ff ff       	call   8006a5 <vcprintf>
  80075d:	83 c4 10             	add    $0x10,%esp
  800760:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800763:	e8 c4 12 00 00       	call   801a2c <sys_enable_interrupt>
	return cnt;
  800768:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80076b:	c9                   	leave  
  80076c:	c3                   	ret    

0080076d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80076d:	55                   	push   %ebp
  80076e:	89 e5                	mov    %esp,%ebp
  800770:	53                   	push   %ebx
  800771:	83 ec 14             	sub    $0x14,%esp
  800774:	8b 45 10             	mov    0x10(%ebp),%eax
  800777:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80077a:	8b 45 14             	mov    0x14(%ebp),%eax
  80077d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800780:	8b 45 18             	mov    0x18(%ebp),%eax
  800783:	ba 00 00 00 00       	mov    $0x0,%edx
  800788:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80078b:	77 55                	ja     8007e2 <printnum+0x75>
  80078d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800790:	72 05                	jb     800797 <printnum+0x2a>
  800792:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800795:	77 4b                	ja     8007e2 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800797:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80079a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80079d:	8b 45 18             	mov    0x18(%ebp),%eax
  8007a0:	ba 00 00 00 00       	mov    $0x0,%edx
  8007a5:	52                   	push   %edx
  8007a6:	50                   	push   %eax
  8007a7:	ff 75 f4             	pushl  -0xc(%ebp)
  8007aa:	ff 75 f0             	pushl  -0x10(%ebp)
  8007ad:	e8 1e 18 00 00       	call   801fd0 <__udivdi3>
  8007b2:	83 c4 10             	add    $0x10,%esp
  8007b5:	83 ec 04             	sub    $0x4,%esp
  8007b8:	ff 75 20             	pushl  0x20(%ebp)
  8007bb:	53                   	push   %ebx
  8007bc:	ff 75 18             	pushl  0x18(%ebp)
  8007bf:	52                   	push   %edx
  8007c0:	50                   	push   %eax
  8007c1:	ff 75 0c             	pushl  0xc(%ebp)
  8007c4:	ff 75 08             	pushl  0x8(%ebp)
  8007c7:	e8 a1 ff ff ff       	call   80076d <printnum>
  8007cc:	83 c4 20             	add    $0x20,%esp
  8007cf:	eb 1a                	jmp    8007eb <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007d1:	83 ec 08             	sub    $0x8,%esp
  8007d4:	ff 75 0c             	pushl  0xc(%ebp)
  8007d7:	ff 75 20             	pushl  0x20(%ebp)
  8007da:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dd:	ff d0                	call   *%eax
  8007df:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007e2:	ff 4d 1c             	decl   0x1c(%ebp)
  8007e5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007e9:	7f e6                	jg     8007d1 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007eb:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007ee:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007f9:	53                   	push   %ebx
  8007fa:	51                   	push   %ecx
  8007fb:	52                   	push   %edx
  8007fc:	50                   	push   %eax
  8007fd:	e8 de 18 00 00       	call   8020e0 <__umoddi3>
  800802:	83 c4 10             	add    $0x10,%esp
  800805:	05 34 25 80 00       	add    $0x802534,%eax
  80080a:	8a 00                	mov    (%eax),%al
  80080c:	0f be c0             	movsbl %al,%eax
  80080f:	83 ec 08             	sub    $0x8,%esp
  800812:	ff 75 0c             	pushl  0xc(%ebp)
  800815:	50                   	push   %eax
  800816:	8b 45 08             	mov    0x8(%ebp),%eax
  800819:	ff d0                	call   *%eax
  80081b:	83 c4 10             	add    $0x10,%esp
}
  80081e:	90                   	nop
  80081f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800822:	c9                   	leave  
  800823:	c3                   	ret    

00800824 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800824:	55                   	push   %ebp
  800825:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800827:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80082b:	7e 1c                	jle    800849 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	8b 00                	mov    (%eax),%eax
  800832:	8d 50 08             	lea    0x8(%eax),%edx
  800835:	8b 45 08             	mov    0x8(%ebp),%eax
  800838:	89 10                	mov    %edx,(%eax)
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	8b 00                	mov    (%eax),%eax
  80083f:	83 e8 08             	sub    $0x8,%eax
  800842:	8b 50 04             	mov    0x4(%eax),%edx
  800845:	8b 00                	mov    (%eax),%eax
  800847:	eb 40                	jmp    800889 <getuint+0x65>
	else if (lflag)
  800849:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80084d:	74 1e                	je     80086d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	8b 00                	mov    (%eax),%eax
  800854:	8d 50 04             	lea    0x4(%eax),%edx
  800857:	8b 45 08             	mov    0x8(%ebp),%eax
  80085a:	89 10                	mov    %edx,(%eax)
  80085c:	8b 45 08             	mov    0x8(%ebp),%eax
  80085f:	8b 00                	mov    (%eax),%eax
  800861:	83 e8 04             	sub    $0x4,%eax
  800864:	8b 00                	mov    (%eax),%eax
  800866:	ba 00 00 00 00       	mov    $0x0,%edx
  80086b:	eb 1c                	jmp    800889 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80086d:	8b 45 08             	mov    0x8(%ebp),%eax
  800870:	8b 00                	mov    (%eax),%eax
  800872:	8d 50 04             	lea    0x4(%eax),%edx
  800875:	8b 45 08             	mov    0x8(%ebp),%eax
  800878:	89 10                	mov    %edx,(%eax)
  80087a:	8b 45 08             	mov    0x8(%ebp),%eax
  80087d:	8b 00                	mov    (%eax),%eax
  80087f:	83 e8 04             	sub    $0x4,%eax
  800882:	8b 00                	mov    (%eax),%eax
  800884:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800889:	5d                   	pop    %ebp
  80088a:	c3                   	ret    

0080088b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80088b:	55                   	push   %ebp
  80088c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80088e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800892:	7e 1c                	jle    8008b0 <getint+0x25>
		return va_arg(*ap, long long);
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	8b 00                	mov    (%eax),%eax
  800899:	8d 50 08             	lea    0x8(%eax),%edx
  80089c:	8b 45 08             	mov    0x8(%ebp),%eax
  80089f:	89 10                	mov    %edx,(%eax)
  8008a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a4:	8b 00                	mov    (%eax),%eax
  8008a6:	83 e8 08             	sub    $0x8,%eax
  8008a9:	8b 50 04             	mov    0x4(%eax),%edx
  8008ac:	8b 00                	mov    (%eax),%eax
  8008ae:	eb 38                	jmp    8008e8 <getint+0x5d>
	else if (lflag)
  8008b0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008b4:	74 1a                	je     8008d0 <getint+0x45>
		return va_arg(*ap, long);
  8008b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b9:	8b 00                	mov    (%eax),%eax
  8008bb:	8d 50 04             	lea    0x4(%eax),%edx
  8008be:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c1:	89 10                	mov    %edx,(%eax)
  8008c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c6:	8b 00                	mov    (%eax),%eax
  8008c8:	83 e8 04             	sub    $0x4,%eax
  8008cb:	8b 00                	mov    (%eax),%eax
  8008cd:	99                   	cltd   
  8008ce:	eb 18                	jmp    8008e8 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d3:	8b 00                	mov    (%eax),%eax
  8008d5:	8d 50 04             	lea    0x4(%eax),%edx
  8008d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008db:	89 10                	mov    %edx,(%eax)
  8008dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e0:	8b 00                	mov    (%eax),%eax
  8008e2:	83 e8 04             	sub    $0x4,%eax
  8008e5:	8b 00                	mov    (%eax),%eax
  8008e7:	99                   	cltd   
}
  8008e8:	5d                   	pop    %ebp
  8008e9:	c3                   	ret    

008008ea <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008ea:	55                   	push   %ebp
  8008eb:	89 e5                	mov    %esp,%ebp
  8008ed:	56                   	push   %esi
  8008ee:	53                   	push   %ebx
  8008ef:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008f2:	eb 17                	jmp    80090b <vprintfmt+0x21>
			if (ch == '\0')
  8008f4:	85 db                	test   %ebx,%ebx
  8008f6:	0f 84 af 03 00 00    	je     800cab <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008fc:	83 ec 08             	sub    $0x8,%esp
  8008ff:	ff 75 0c             	pushl  0xc(%ebp)
  800902:	53                   	push   %ebx
  800903:	8b 45 08             	mov    0x8(%ebp),%eax
  800906:	ff d0                	call   *%eax
  800908:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80090b:	8b 45 10             	mov    0x10(%ebp),%eax
  80090e:	8d 50 01             	lea    0x1(%eax),%edx
  800911:	89 55 10             	mov    %edx,0x10(%ebp)
  800914:	8a 00                	mov    (%eax),%al
  800916:	0f b6 d8             	movzbl %al,%ebx
  800919:	83 fb 25             	cmp    $0x25,%ebx
  80091c:	75 d6                	jne    8008f4 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80091e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800922:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800929:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800930:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800937:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80093e:	8b 45 10             	mov    0x10(%ebp),%eax
  800941:	8d 50 01             	lea    0x1(%eax),%edx
  800944:	89 55 10             	mov    %edx,0x10(%ebp)
  800947:	8a 00                	mov    (%eax),%al
  800949:	0f b6 d8             	movzbl %al,%ebx
  80094c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80094f:	83 f8 55             	cmp    $0x55,%eax
  800952:	0f 87 2b 03 00 00    	ja     800c83 <vprintfmt+0x399>
  800958:	8b 04 85 58 25 80 00 	mov    0x802558(,%eax,4),%eax
  80095f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800961:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800965:	eb d7                	jmp    80093e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800967:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80096b:	eb d1                	jmp    80093e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80096d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800974:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800977:	89 d0                	mov    %edx,%eax
  800979:	c1 e0 02             	shl    $0x2,%eax
  80097c:	01 d0                	add    %edx,%eax
  80097e:	01 c0                	add    %eax,%eax
  800980:	01 d8                	add    %ebx,%eax
  800982:	83 e8 30             	sub    $0x30,%eax
  800985:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800988:	8b 45 10             	mov    0x10(%ebp),%eax
  80098b:	8a 00                	mov    (%eax),%al
  80098d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800990:	83 fb 2f             	cmp    $0x2f,%ebx
  800993:	7e 3e                	jle    8009d3 <vprintfmt+0xe9>
  800995:	83 fb 39             	cmp    $0x39,%ebx
  800998:	7f 39                	jg     8009d3 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80099a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80099d:	eb d5                	jmp    800974 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80099f:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a2:	83 c0 04             	add    $0x4,%eax
  8009a5:	89 45 14             	mov    %eax,0x14(%ebp)
  8009a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ab:	83 e8 04             	sub    $0x4,%eax
  8009ae:	8b 00                	mov    (%eax),%eax
  8009b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009b3:	eb 1f                	jmp    8009d4 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009b5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009b9:	79 83                	jns    80093e <vprintfmt+0x54>
				width = 0;
  8009bb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009c2:	e9 77 ff ff ff       	jmp    80093e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009c7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009ce:	e9 6b ff ff ff       	jmp    80093e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009d3:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009d4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009d8:	0f 89 60 ff ff ff    	jns    80093e <vprintfmt+0x54>
				width = precision, precision = -1;
  8009de:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009e4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009eb:	e9 4e ff ff ff       	jmp    80093e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009f0:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009f3:	e9 46 ff ff ff       	jmp    80093e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fb:	83 c0 04             	add    $0x4,%eax
  8009fe:	89 45 14             	mov    %eax,0x14(%ebp)
  800a01:	8b 45 14             	mov    0x14(%ebp),%eax
  800a04:	83 e8 04             	sub    $0x4,%eax
  800a07:	8b 00                	mov    (%eax),%eax
  800a09:	83 ec 08             	sub    $0x8,%esp
  800a0c:	ff 75 0c             	pushl  0xc(%ebp)
  800a0f:	50                   	push   %eax
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	ff d0                	call   *%eax
  800a15:	83 c4 10             	add    $0x10,%esp
			break;
  800a18:	e9 89 02 00 00       	jmp    800ca6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a20:	83 c0 04             	add    $0x4,%eax
  800a23:	89 45 14             	mov    %eax,0x14(%ebp)
  800a26:	8b 45 14             	mov    0x14(%ebp),%eax
  800a29:	83 e8 04             	sub    $0x4,%eax
  800a2c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a2e:	85 db                	test   %ebx,%ebx
  800a30:	79 02                	jns    800a34 <vprintfmt+0x14a>
				err = -err;
  800a32:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a34:	83 fb 64             	cmp    $0x64,%ebx
  800a37:	7f 0b                	jg     800a44 <vprintfmt+0x15a>
  800a39:	8b 34 9d a0 23 80 00 	mov    0x8023a0(,%ebx,4),%esi
  800a40:	85 f6                	test   %esi,%esi
  800a42:	75 19                	jne    800a5d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a44:	53                   	push   %ebx
  800a45:	68 45 25 80 00       	push   $0x802545
  800a4a:	ff 75 0c             	pushl  0xc(%ebp)
  800a4d:	ff 75 08             	pushl  0x8(%ebp)
  800a50:	e8 5e 02 00 00       	call   800cb3 <printfmt>
  800a55:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a58:	e9 49 02 00 00       	jmp    800ca6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a5d:	56                   	push   %esi
  800a5e:	68 4e 25 80 00       	push   $0x80254e
  800a63:	ff 75 0c             	pushl  0xc(%ebp)
  800a66:	ff 75 08             	pushl  0x8(%ebp)
  800a69:	e8 45 02 00 00       	call   800cb3 <printfmt>
  800a6e:	83 c4 10             	add    $0x10,%esp
			break;
  800a71:	e9 30 02 00 00       	jmp    800ca6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a76:	8b 45 14             	mov    0x14(%ebp),%eax
  800a79:	83 c0 04             	add    $0x4,%eax
  800a7c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a7f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a82:	83 e8 04             	sub    $0x4,%eax
  800a85:	8b 30                	mov    (%eax),%esi
  800a87:	85 f6                	test   %esi,%esi
  800a89:	75 05                	jne    800a90 <vprintfmt+0x1a6>
				p = "(null)";
  800a8b:	be 51 25 80 00       	mov    $0x802551,%esi
			if (width > 0 && padc != '-')
  800a90:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a94:	7e 6d                	jle    800b03 <vprintfmt+0x219>
  800a96:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a9a:	74 67                	je     800b03 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a9f:	83 ec 08             	sub    $0x8,%esp
  800aa2:	50                   	push   %eax
  800aa3:	56                   	push   %esi
  800aa4:	e8 0c 03 00 00       	call   800db5 <strnlen>
  800aa9:	83 c4 10             	add    $0x10,%esp
  800aac:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800aaf:	eb 16                	jmp    800ac7 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ab1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ab5:	83 ec 08             	sub    $0x8,%esp
  800ab8:	ff 75 0c             	pushl  0xc(%ebp)
  800abb:	50                   	push   %eax
  800abc:	8b 45 08             	mov    0x8(%ebp),%eax
  800abf:	ff d0                	call   *%eax
  800ac1:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ac4:	ff 4d e4             	decl   -0x1c(%ebp)
  800ac7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800acb:	7f e4                	jg     800ab1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800acd:	eb 34                	jmp    800b03 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800acf:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ad3:	74 1c                	je     800af1 <vprintfmt+0x207>
  800ad5:	83 fb 1f             	cmp    $0x1f,%ebx
  800ad8:	7e 05                	jle    800adf <vprintfmt+0x1f5>
  800ada:	83 fb 7e             	cmp    $0x7e,%ebx
  800add:	7e 12                	jle    800af1 <vprintfmt+0x207>
					putch('?', putdat);
  800adf:	83 ec 08             	sub    $0x8,%esp
  800ae2:	ff 75 0c             	pushl  0xc(%ebp)
  800ae5:	6a 3f                	push   $0x3f
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	ff d0                	call   *%eax
  800aec:	83 c4 10             	add    $0x10,%esp
  800aef:	eb 0f                	jmp    800b00 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800af1:	83 ec 08             	sub    $0x8,%esp
  800af4:	ff 75 0c             	pushl  0xc(%ebp)
  800af7:	53                   	push   %ebx
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	ff d0                	call   *%eax
  800afd:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b00:	ff 4d e4             	decl   -0x1c(%ebp)
  800b03:	89 f0                	mov    %esi,%eax
  800b05:	8d 70 01             	lea    0x1(%eax),%esi
  800b08:	8a 00                	mov    (%eax),%al
  800b0a:	0f be d8             	movsbl %al,%ebx
  800b0d:	85 db                	test   %ebx,%ebx
  800b0f:	74 24                	je     800b35 <vprintfmt+0x24b>
  800b11:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b15:	78 b8                	js     800acf <vprintfmt+0x1e5>
  800b17:	ff 4d e0             	decl   -0x20(%ebp)
  800b1a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b1e:	79 af                	jns    800acf <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b20:	eb 13                	jmp    800b35 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b22:	83 ec 08             	sub    $0x8,%esp
  800b25:	ff 75 0c             	pushl  0xc(%ebp)
  800b28:	6a 20                	push   $0x20
  800b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2d:	ff d0                	call   *%eax
  800b2f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b32:	ff 4d e4             	decl   -0x1c(%ebp)
  800b35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b39:	7f e7                	jg     800b22 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b3b:	e9 66 01 00 00       	jmp    800ca6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b40:	83 ec 08             	sub    $0x8,%esp
  800b43:	ff 75 e8             	pushl  -0x18(%ebp)
  800b46:	8d 45 14             	lea    0x14(%ebp),%eax
  800b49:	50                   	push   %eax
  800b4a:	e8 3c fd ff ff       	call   80088b <getint>
  800b4f:	83 c4 10             	add    $0x10,%esp
  800b52:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b55:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b5b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b5e:	85 d2                	test   %edx,%edx
  800b60:	79 23                	jns    800b85 <vprintfmt+0x29b>
				putch('-', putdat);
  800b62:	83 ec 08             	sub    $0x8,%esp
  800b65:	ff 75 0c             	pushl  0xc(%ebp)
  800b68:	6a 2d                	push   $0x2d
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	ff d0                	call   *%eax
  800b6f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b72:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b75:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b78:	f7 d8                	neg    %eax
  800b7a:	83 d2 00             	adc    $0x0,%edx
  800b7d:	f7 da                	neg    %edx
  800b7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b82:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b85:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b8c:	e9 bc 00 00 00       	jmp    800c4d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b91:	83 ec 08             	sub    $0x8,%esp
  800b94:	ff 75 e8             	pushl  -0x18(%ebp)
  800b97:	8d 45 14             	lea    0x14(%ebp),%eax
  800b9a:	50                   	push   %eax
  800b9b:	e8 84 fc ff ff       	call   800824 <getuint>
  800ba0:	83 c4 10             	add    $0x10,%esp
  800ba3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ba9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bb0:	e9 98 00 00 00       	jmp    800c4d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800bb5:	83 ec 08             	sub    $0x8,%esp
  800bb8:	ff 75 0c             	pushl  0xc(%ebp)
  800bbb:	6a 58                	push   $0x58
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	ff d0                	call   *%eax
  800bc2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bc5:	83 ec 08             	sub    $0x8,%esp
  800bc8:	ff 75 0c             	pushl  0xc(%ebp)
  800bcb:	6a 58                	push   $0x58
  800bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd0:	ff d0                	call   *%eax
  800bd2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bd5:	83 ec 08             	sub    $0x8,%esp
  800bd8:	ff 75 0c             	pushl  0xc(%ebp)
  800bdb:	6a 58                	push   $0x58
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	ff d0                	call   *%eax
  800be2:	83 c4 10             	add    $0x10,%esp
			break;
  800be5:	e9 bc 00 00 00       	jmp    800ca6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bea:	83 ec 08             	sub    $0x8,%esp
  800bed:	ff 75 0c             	pushl  0xc(%ebp)
  800bf0:	6a 30                	push   $0x30
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	ff d0                	call   *%eax
  800bf7:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bfa:	83 ec 08             	sub    $0x8,%esp
  800bfd:	ff 75 0c             	pushl  0xc(%ebp)
  800c00:	6a 78                	push   $0x78
  800c02:	8b 45 08             	mov    0x8(%ebp),%eax
  800c05:	ff d0                	call   *%eax
  800c07:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0d:	83 c0 04             	add    $0x4,%eax
  800c10:	89 45 14             	mov    %eax,0x14(%ebp)
  800c13:	8b 45 14             	mov    0x14(%ebp),%eax
  800c16:	83 e8 04             	sub    $0x4,%eax
  800c19:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c25:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c2c:	eb 1f                	jmp    800c4d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c2e:	83 ec 08             	sub    $0x8,%esp
  800c31:	ff 75 e8             	pushl  -0x18(%ebp)
  800c34:	8d 45 14             	lea    0x14(%ebp),%eax
  800c37:	50                   	push   %eax
  800c38:	e8 e7 fb ff ff       	call   800824 <getuint>
  800c3d:	83 c4 10             	add    $0x10,%esp
  800c40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c43:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c46:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c4d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c51:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c54:	83 ec 04             	sub    $0x4,%esp
  800c57:	52                   	push   %edx
  800c58:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c5b:	50                   	push   %eax
  800c5c:	ff 75 f4             	pushl  -0xc(%ebp)
  800c5f:	ff 75 f0             	pushl  -0x10(%ebp)
  800c62:	ff 75 0c             	pushl  0xc(%ebp)
  800c65:	ff 75 08             	pushl  0x8(%ebp)
  800c68:	e8 00 fb ff ff       	call   80076d <printnum>
  800c6d:	83 c4 20             	add    $0x20,%esp
			break;
  800c70:	eb 34                	jmp    800ca6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c72:	83 ec 08             	sub    $0x8,%esp
  800c75:	ff 75 0c             	pushl  0xc(%ebp)
  800c78:	53                   	push   %ebx
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	ff d0                	call   *%eax
  800c7e:	83 c4 10             	add    $0x10,%esp
			break;
  800c81:	eb 23                	jmp    800ca6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c83:	83 ec 08             	sub    $0x8,%esp
  800c86:	ff 75 0c             	pushl  0xc(%ebp)
  800c89:	6a 25                	push   $0x25
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	ff d0                	call   *%eax
  800c90:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c93:	ff 4d 10             	decl   0x10(%ebp)
  800c96:	eb 03                	jmp    800c9b <vprintfmt+0x3b1>
  800c98:	ff 4d 10             	decl   0x10(%ebp)
  800c9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9e:	48                   	dec    %eax
  800c9f:	8a 00                	mov    (%eax),%al
  800ca1:	3c 25                	cmp    $0x25,%al
  800ca3:	75 f3                	jne    800c98 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ca5:	90                   	nop
		}
	}
  800ca6:	e9 47 fc ff ff       	jmp    8008f2 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cab:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800cac:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800caf:	5b                   	pop    %ebx
  800cb0:	5e                   	pop    %esi
  800cb1:	5d                   	pop    %ebp
  800cb2:	c3                   	ret    

00800cb3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800cb3:	55                   	push   %ebp
  800cb4:	89 e5                	mov    %esp,%ebp
  800cb6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cb9:	8d 45 10             	lea    0x10(%ebp),%eax
  800cbc:	83 c0 04             	add    $0x4,%eax
  800cbf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800cc2:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc5:	ff 75 f4             	pushl  -0xc(%ebp)
  800cc8:	50                   	push   %eax
  800cc9:	ff 75 0c             	pushl  0xc(%ebp)
  800ccc:	ff 75 08             	pushl  0x8(%ebp)
  800ccf:	e8 16 fc ff ff       	call   8008ea <vprintfmt>
  800cd4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cd7:	90                   	nop
  800cd8:	c9                   	leave  
  800cd9:	c3                   	ret    

00800cda <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cda:	55                   	push   %ebp
  800cdb:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce0:	8b 40 08             	mov    0x8(%eax),%eax
  800ce3:	8d 50 01             	lea    0x1(%eax),%edx
  800ce6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cef:	8b 10                	mov    (%eax),%edx
  800cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf4:	8b 40 04             	mov    0x4(%eax),%eax
  800cf7:	39 c2                	cmp    %eax,%edx
  800cf9:	73 12                	jae    800d0d <sprintputch+0x33>
		*b->buf++ = ch;
  800cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfe:	8b 00                	mov    (%eax),%eax
  800d00:	8d 48 01             	lea    0x1(%eax),%ecx
  800d03:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d06:	89 0a                	mov    %ecx,(%edx)
  800d08:	8b 55 08             	mov    0x8(%ebp),%edx
  800d0b:	88 10                	mov    %dl,(%eax)
}
  800d0d:	90                   	nop
  800d0e:	5d                   	pop    %ebp
  800d0f:	c3                   	ret    

00800d10 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d10:	55                   	push   %ebp
  800d11:	89 e5                	mov    %esp,%ebp
  800d13:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	01 d0                	add    %edx,%eax
  800d27:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d2a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d31:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d35:	74 06                	je     800d3d <vsnprintf+0x2d>
  800d37:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d3b:	7f 07                	jg     800d44 <vsnprintf+0x34>
		return -E_INVAL;
  800d3d:	b8 03 00 00 00       	mov    $0x3,%eax
  800d42:	eb 20                	jmp    800d64 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d44:	ff 75 14             	pushl  0x14(%ebp)
  800d47:	ff 75 10             	pushl  0x10(%ebp)
  800d4a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d4d:	50                   	push   %eax
  800d4e:	68 da 0c 80 00       	push   $0x800cda
  800d53:	e8 92 fb ff ff       	call   8008ea <vprintfmt>
  800d58:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d5b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d5e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d64:	c9                   	leave  
  800d65:	c3                   	ret    

00800d66 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d66:	55                   	push   %ebp
  800d67:	89 e5                	mov    %esp,%ebp
  800d69:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d6c:	8d 45 10             	lea    0x10(%ebp),%eax
  800d6f:	83 c0 04             	add    $0x4,%eax
  800d72:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d75:	8b 45 10             	mov    0x10(%ebp),%eax
  800d78:	ff 75 f4             	pushl  -0xc(%ebp)
  800d7b:	50                   	push   %eax
  800d7c:	ff 75 0c             	pushl  0xc(%ebp)
  800d7f:	ff 75 08             	pushl  0x8(%ebp)
  800d82:	e8 89 ff ff ff       	call   800d10 <vsnprintf>
  800d87:	83 c4 10             	add    $0x10,%esp
  800d8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d90:	c9                   	leave  
  800d91:	c3                   	ret    

00800d92 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d92:	55                   	push   %ebp
  800d93:	89 e5                	mov    %esp,%ebp
  800d95:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d98:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d9f:	eb 06                	jmp    800da7 <strlen+0x15>
		n++;
  800da1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800da4:	ff 45 08             	incl   0x8(%ebp)
  800da7:	8b 45 08             	mov    0x8(%ebp),%eax
  800daa:	8a 00                	mov    (%eax),%al
  800dac:	84 c0                	test   %al,%al
  800dae:	75 f1                	jne    800da1 <strlen+0xf>
		n++;
	return n;
  800db0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800db3:	c9                   	leave  
  800db4:	c3                   	ret    

00800db5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800db5:	55                   	push   %ebp
  800db6:	89 e5                	mov    %esp,%ebp
  800db8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dbb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dc2:	eb 09                	jmp    800dcd <strnlen+0x18>
		n++;
  800dc4:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dc7:	ff 45 08             	incl   0x8(%ebp)
  800dca:	ff 4d 0c             	decl   0xc(%ebp)
  800dcd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dd1:	74 09                	je     800ddc <strnlen+0x27>
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd6:	8a 00                	mov    (%eax),%al
  800dd8:	84 c0                	test   %al,%al
  800dda:	75 e8                	jne    800dc4 <strnlen+0xf>
		n++;
	return n;
  800ddc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ddf:	c9                   	leave  
  800de0:	c3                   	ret    

00800de1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800de1:	55                   	push   %ebp
  800de2:	89 e5                	mov    %esp,%ebp
  800de4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ded:	90                   	nop
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	8d 50 01             	lea    0x1(%eax),%edx
  800df4:	89 55 08             	mov    %edx,0x8(%ebp)
  800df7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dfa:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dfd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e00:	8a 12                	mov    (%edx),%dl
  800e02:	88 10                	mov    %dl,(%eax)
  800e04:	8a 00                	mov    (%eax),%al
  800e06:	84 c0                	test   %al,%al
  800e08:	75 e4                	jne    800dee <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e0d:	c9                   	leave  
  800e0e:	c3                   	ret    

00800e0f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e0f:	55                   	push   %ebp
  800e10:	89 e5                	mov    %esp,%ebp
  800e12:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e1b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e22:	eb 1f                	jmp    800e43 <strncpy+0x34>
		*dst++ = *src;
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	8d 50 01             	lea    0x1(%eax),%edx
  800e2a:	89 55 08             	mov    %edx,0x8(%ebp)
  800e2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e30:	8a 12                	mov    (%edx),%dl
  800e32:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e37:	8a 00                	mov    (%eax),%al
  800e39:	84 c0                	test   %al,%al
  800e3b:	74 03                	je     800e40 <strncpy+0x31>
			src++;
  800e3d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e40:	ff 45 fc             	incl   -0x4(%ebp)
  800e43:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e46:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e49:	72 d9                	jb     800e24 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e4e:	c9                   	leave  
  800e4f:	c3                   	ret    

00800e50 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e50:	55                   	push   %ebp
  800e51:	89 e5                	mov    %esp,%ebp
  800e53:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e56:	8b 45 08             	mov    0x8(%ebp),%eax
  800e59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e5c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e60:	74 30                	je     800e92 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e62:	eb 16                	jmp    800e7a <strlcpy+0x2a>
			*dst++ = *src++;
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	8d 50 01             	lea    0x1(%eax),%edx
  800e6a:	89 55 08             	mov    %edx,0x8(%ebp)
  800e6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e70:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e73:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e76:	8a 12                	mov    (%edx),%dl
  800e78:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e7a:	ff 4d 10             	decl   0x10(%ebp)
  800e7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e81:	74 09                	je     800e8c <strlcpy+0x3c>
  800e83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e86:	8a 00                	mov    (%eax),%al
  800e88:	84 c0                	test   %al,%al
  800e8a:	75 d8                	jne    800e64 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e92:	8b 55 08             	mov    0x8(%ebp),%edx
  800e95:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e98:	29 c2                	sub    %eax,%edx
  800e9a:	89 d0                	mov    %edx,%eax
}
  800e9c:	c9                   	leave  
  800e9d:	c3                   	ret    

00800e9e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e9e:	55                   	push   %ebp
  800e9f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ea1:	eb 06                	jmp    800ea9 <strcmp+0xb>
		p++, q++;
  800ea3:	ff 45 08             	incl   0x8(%ebp)
  800ea6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eac:	8a 00                	mov    (%eax),%al
  800eae:	84 c0                	test   %al,%al
  800eb0:	74 0e                	je     800ec0 <strcmp+0x22>
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	8a 10                	mov    (%eax),%dl
  800eb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eba:	8a 00                	mov    (%eax),%al
  800ebc:	38 c2                	cmp    %al,%dl
  800ebe:	74 e3                	je     800ea3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	0f b6 d0             	movzbl %al,%edx
  800ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecb:	8a 00                	mov    (%eax),%al
  800ecd:	0f b6 c0             	movzbl %al,%eax
  800ed0:	29 c2                	sub    %eax,%edx
  800ed2:	89 d0                	mov    %edx,%eax
}
  800ed4:	5d                   	pop    %ebp
  800ed5:	c3                   	ret    

00800ed6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ed6:	55                   	push   %ebp
  800ed7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ed9:	eb 09                	jmp    800ee4 <strncmp+0xe>
		n--, p++, q++;
  800edb:	ff 4d 10             	decl   0x10(%ebp)
  800ede:	ff 45 08             	incl   0x8(%ebp)
  800ee1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ee4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee8:	74 17                	je     800f01 <strncmp+0x2b>
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	84 c0                	test   %al,%al
  800ef1:	74 0e                	je     800f01 <strncmp+0x2b>
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	8a 10                	mov    (%eax),%dl
  800ef8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	38 c2                	cmp    %al,%dl
  800eff:	74 da                	je     800edb <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f05:	75 07                	jne    800f0e <strncmp+0x38>
		return 0;
  800f07:	b8 00 00 00 00       	mov    $0x0,%eax
  800f0c:	eb 14                	jmp    800f22 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	0f b6 d0             	movzbl %al,%edx
  800f16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f19:	8a 00                	mov    (%eax),%al
  800f1b:	0f b6 c0             	movzbl %al,%eax
  800f1e:	29 c2                	sub    %eax,%edx
  800f20:	89 d0                	mov    %edx,%eax
}
  800f22:	5d                   	pop    %ebp
  800f23:	c3                   	ret    

00800f24 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f24:	55                   	push   %ebp
  800f25:	89 e5                	mov    %esp,%ebp
  800f27:	83 ec 04             	sub    $0x4,%esp
  800f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f30:	eb 12                	jmp    800f44 <strchr+0x20>
		if (*s == c)
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	8a 00                	mov    (%eax),%al
  800f37:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f3a:	75 05                	jne    800f41 <strchr+0x1d>
			return (char *) s;
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	eb 11                	jmp    800f52 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f41:	ff 45 08             	incl   0x8(%ebp)
  800f44:	8b 45 08             	mov    0x8(%ebp),%eax
  800f47:	8a 00                	mov    (%eax),%al
  800f49:	84 c0                	test   %al,%al
  800f4b:	75 e5                	jne    800f32 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f4d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f52:	c9                   	leave  
  800f53:	c3                   	ret    

00800f54 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f54:	55                   	push   %ebp
  800f55:	89 e5                	mov    %esp,%ebp
  800f57:	83 ec 04             	sub    $0x4,%esp
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f60:	eb 0d                	jmp    800f6f <strfind+0x1b>
		if (*s == c)
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f6a:	74 0e                	je     800f7a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f6c:	ff 45 08             	incl   0x8(%ebp)
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	84 c0                	test   %al,%al
  800f76:	75 ea                	jne    800f62 <strfind+0xe>
  800f78:	eb 01                	jmp    800f7b <strfind+0x27>
		if (*s == c)
			break;
  800f7a:	90                   	nop
	return (char *) s;
  800f7b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f7e:	c9                   	leave  
  800f7f:	c3                   	ret    

00800f80 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f80:	55                   	push   %ebp
  800f81:	89 e5                	mov    %esp,%ebp
  800f83:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f92:	eb 0e                	jmp    800fa2 <memset+0x22>
		*p++ = c;
  800f94:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f97:	8d 50 01             	lea    0x1(%eax),%edx
  800f9a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fa0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fa2:	ff 4d f8             	decl   -0x8(%ebp)
  800fa5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fa9:	79 e9                	jns    800f94 <memset+0x14>
		*p++ = c;

	return v;
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fae:	c9                   	leave  
  800faf:	c3                   	ret    

00800fb0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fb0:	55                   	push   %ebp
  800fb1:	89 e5                	mov    %esp,%ebp
  800fb3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fc2:	eb 16                	jmp    800fda <memcpy+0x2a>
		*d++ = *s++;
  800fc4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc7:	8d 50 01             	lea    0x1(%eax),%edx
  800fca:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fcd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fd0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fd3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fd6:	8a 12                	mov    (%edx),%dl
  800fd8:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fda:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe0:	89 55 10             	mov    %edx,0x10(%ebp)
  800fe3:	85 c0                	test   %eax,%eax
  800fe5:	75 dd                	jne    800fc4 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800fe7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fea:	c9                   	leave  
  800feb:	c3                   	ret    

00800fec <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fec:	55                   	push   %ebp
  800fed:	89 e5                	mov    %esp,%ebp
  800fef:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800ff2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ffe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801001:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801004:	73 50                	jae    801056 <memmove+0x6a>
  801006:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801009:	8b 45 10             	mov    0x10(%ebp),%eax
  80100c:	01 d0                	add    %edx,%eax
  80100e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801011:	76 43                	jbe    801056 <memmove+0x6a>
		s += n;
  801013:	8b 45 10             	mov    0x10(%ebp),%eax
  801016:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801019:	8b 45 10             	mov    0x10(%ebp),%eax
  80101c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80101f:	eb 10                	jmp    801031 <memmove+0x45>
			*--d = *--s;
  801021:	ff 4d f8             	decl   -0x8(%ebp)
  801024:	ff 4d fc             	decl   -0x4(%ebp)
  801027:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80102a:	8a 10                	mov    (%eax),%dl
  80102c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80102f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801031:	8b 45 10             	mov    0x10(%ebp),%eax
  801034:	8d 50 ff             	lea    -0x1(%eax),%edx
  801037:	89 55 10             	mov    %edx,0x10(%ebp)
  80103a:	85 c0                	test   %eax,%eax
  80103c:	75 e3                	jne    801021 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80103e:	eb 23                	jmp    801063 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801040:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801043:	8d 50 01             	lea    0x1(%eax),%edx
  801046:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801049:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80104c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80104f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801052:	8a 12                	mov    (%edx),%dl
  801054:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801056:	8b 45 10             	mov    0x10(%ebp),%eax
  801059:	8d 50 ff             	lea    -0x1(%eax),%edx
  80105c:	89 55 10             	mov    %edx,0x10(%ebp)
  80105f:	85 c0                	test   %eax,%eax
  801061:	75 dd                	jne    801040 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801066:	c9                   	leave  
  801067:	c3                   	ret    

00801068 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801068:	55                   	push   %ebp
  801069:	89 e5                	mov    %esp,%ebp
  80106b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801074:	8b 45 0c             	mov    0xc(%ebp),%eax
  801077:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80107a:	eb 2a                	jmp    8010a6 <memcmp+0x3e>
		if (*s1 != *s2)
  80107c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80107f:	8a 10                	mov    (%eax),%dl
  801081:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801084:	8a 00                	mov    (%eax),%al
  801086:	38 c2                	cmp    %al,%dl
  801088:	74 16                	je     8010a0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80108a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80108d:	8a 00                	mov    (%eax),%al
  80108f:	0f b6 d0             	movzbl %al,%edx
  801092:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801095:	8a 00                	mov    (%eax),%al
  801097:	0f b6 c0             	movzbl %al,%eax
  80109a:	29 c2                	sub    %eax,%edx
  80109c:	89 d0                	mov    %edx,%eax
  80109e:	eb 18                	jmp    8010b8 <memcmp+0x50>
		s1++, s2++;
  8010a0:	ff 45 fc             	incl   -0x4(%ebp)
  8010a3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ac:	89 55 10             	mov    %edx,0x10(%ebp)
  8010af:	85 c0                	test   %eax,%eax
  8010b1:	75 c9                	jne    80107c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010b8:	c9                   	leave  
  8010b9:	c3                   	ret    

008010ba <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010ba:	55                   	push   %ebp
  8010bb:	89 e5                	mov    %esp,%ebp
  8010bd:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010c0:	8b 55 08             	mov    0x8(%ebp),%edx
  8010c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c6:	01 d0                	add    %edx,%eax
  8010c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010cb:	eb 15                	jmp    8010e2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d0:	8a 00                	mov    (%eax),%al
  8010d2:	0f b6 d0             	movzbl %al,%edx
  8010d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d8:	0f b6 c0             	movzbl %al,%eax
  8010db:	39 c2                	cmp    %eax,%edx
  8010dd:	74 0d                	je     8010ec <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010df:	ff 45 08             	incl   0x8(%ebp)
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010e8:	72 e3                	jb     8010cd <memfind+0x13>
  8010ea:	eb 01                	jmp    8010ed <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010ec:	90                   	nop
	return (void *) s;
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010f0:	c9                   	leave  
  8010f1:	c3                   	ret    

008010f2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010f2:	55                   	push   %ebp
  8010f3:	89 e5                	mov    %esp,%ebp
  8010f5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010ff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801106:	eb 03                	jmp    80110b <strtol+0x19>
		s++;
  801108:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	8a 00                	mov    (%eax),%al
  801110:	3c 20                	cmp    $0x20,%al
  801112:	74 f4                	je     801108 <strtol+0x16>
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	3c 09                	cmp    $0x9,%al
  80111b:	74 eb                	je     801108 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8a 00                	mov    (%eax),%al
  801122:	3c 2b                	cmp    $0x2b,%al
  801124:	75 05                	jne    80112b <strtol+0x39>
		s++;
  801126:	ff 45 08             	incl   0x8(%ebp)
  801129:	eb 13                	jmp    80113e <strtol+0x4c>
	else if (*s == '-')
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	8a 00                	mov    (%eax),%al
  801130:	3c 2d                	cmp    $0x2d,%al
  801132:	75 0a                	jne    80113e <strtol+0x4c>
		s++, neg = 1;
  801134:	ff 45 08             	incl   0x8(%ebp)
  801137:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80113e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801142:	74 06                	je     80114a <strtol+0x58>
  801144:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801148:	75 20                	jne    80116a <strtol+0x78>
  80114a:	8b 45 08             	mov    0x8(%ebp),%eax
  80114d:	8a 00                	mov    (%eax),%al
  80114f:	3c 30                	cmp    $0x30,%al
  801151:	75 17                	jne    80116a <strtol+0x78>
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	40                   	inc    %eax
  801157:	8a 00                	mov    (%eax),%al
  801159:	3c 78                	cmp    $0x78,%al
  80115b:	75 0d                	jne    80116a <strtol+0x78>
		s += 2, base = 16;
  80115d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801161:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801168:	eb 28                	jmp    801192 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80116a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80116e:	75 15                	jne    801185 <strtol+0x93>
  801170:	8b 45 08             	mov    0x8(%ebp),%eax
  801173:	8a 00                	mov    (%eax),%al
  801175:	3c 30                	cmp    $0x30,%al
  801177:	75 0c                	jne    801185 <strtol+0x93>
		s++, base = 8;
  801179:	ff 45 08             	incl   0x8(%ebp)
  80117c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801183:	eb 0d                	jmp    801192 <strtol+0xa0>
	else if (base == 0)
  801185:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801189:	75 07                	jne    801192 <strtol+0xa0>
		base = 10;
  80118b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	8a 00                	mov    (%eax),%al
  801197:	3c 2f                	cmp    $0x2f,%al
  801199:	7e 19                	jle    8011b4 <strtol+0xc2>
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	8a 00                	mov    (%eax),%al
  8011a0:	3c 39                	cmp    $0x39,%al
  8011a2:	7f 10                	jg     8011b4 <strtol+0xc2>
			dig = *s - '0';
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	0f be c0             	movsbl %al,%eax
  8011ac:	83 e8 30             	sub    $0x30,%eax
  8011af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011b2:	eb 42                	jmp    8011f6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	3c 60                	cmp    $0x60,%al
  8011bb:	7e 19                	jle    8011d6 <strtol+0xe4>
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	8a 00                	mov    (%eax),%al
  8011c2:	3c 7a                	cmp    $0x7a,%al
  8011c4:	7f 10                	jg     8011d6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c9:	8a 00                	mov    (%eax),%al
  8011cb:	0f be c0             	movsbl %al,%eax
  8011ce:	83 e8 57             	sub    $0x57,%eax
  8011d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011d4:	eb 20                	jmp    8011f6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	8a 00                	mov    (%eax),%al
  8011db:	3c 40                	cmp    $0x40,%al
  8011dd:	7e 39                	jle    801218 <strtol+0x126>
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	8a 00                	mov    (%eax),%al
  8011e4:	3c 5a                	cmp    $0x5a,%al
  8011e6:	7f 30                	jg     801218 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011eb:	8a 00                	mov    (%eax),%al
  8011ed:	0f be c0             	movsbl %al,%eax
  8011f0:	83 e8 37             	sub    $0x37,%eax
  8011f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011f9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011fc:	7d 19                	jge    801217 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011fe:	ff 45 08             	incl   0x8(%ebp)
  801201:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801204:	0f af 45 10          	imul   0x10(%ebp),%eax
  801208:	89 c2                	mov    %eax,%edx
  80120a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80120d:	01 d0                	add    %edx,%eax
  80120f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801212:	e9 7b ff ff ff       	jmp    801192 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801217:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801218:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80121c:	74 08                	je     801226 <strtol+0x134>
		*endptr = (char *) s;
  80121e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801221:	8b 55 08             	mov    0x8(%ebp),%edx
  801224:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801226:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80122a:	74 07                	je     801233 <strtol+0x141>
  80122c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122f:	f7 d8                	neg    %eax
  801231:	eb 03                	jmp    801236 <strtol+0x144>
  801233:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801236:	c9                   	leave  
  801237:	c3                   	ret    

00801238 <ltostr>:

void
ltostr(long value, char *str)
{
  801238:	55                   	push   %ebp
  801239:	89 e5                	mov    %esp,%ebp
  80123b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80123e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801245:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80124c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801250:	79 13                	jns    801265 <ltostr+0x2d>
	{
		neg = 1;
  801252:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801259:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80125f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801262:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801265:	8b 45 08             	mov    0x8(%ebp),%eax
  801268:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80126d:	99                   	cltd   
  80126e:	f7 f9                	idiv   %ecx
  801270:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801273:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801276:	8d 50 01             	lea    0x1(%eax),%edx
  801279:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80127c:	89 c2                	mov    %eax,%edx
  80127e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801281:	01 d0                	add    %edx,%eax
  801283:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801286:	83 c2 30             	add    $0x30,%edx
  801289:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80128b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80128e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801293:	f7 e9                	imul   %ecx
  801295:	c1 fa 02             	sar    $0x2,%edx
  801298:	89 c8                	mov    %ecx,%eax
  80129a:	c1 f8 1f             	sar    $0x1f,%eax
  80129d:	29 c2                	sub    %eax,%edx
  80129f:	89 d0                	mov    %edx,%eax
  8012a1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012a7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012ac:	f7 e9                	imul   %ecx
  8012ae:	c1 fa 02             	sar    $0x2,%edx
  8012b1:	89 c8                	mov    %ecx,%eax
  8012b3:	c1 f8 1f             	sar    $0x1f,%eax
  8012b6:	29 c2                	sub    %eax,%edx
  8012b8:	89 d0                	mov    %edx,%eax
  8012ba:	c1 e0 02             	shl    $0x2,%eax
  8012bd:	01 d0                	add    %edx,%eax
  8012bf:	01 c0                	add    %eax,%eax
  8012c1:	29 c1                	sub    %eax,%ecx
  8012c3:	89 ca                	mov    %ecx,%edx
  8012c5:	85 d2                	test   %edx,%edx
  8012c7:	75 9c                	jne    801265 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d3:	48                   	dec    %eax
  8012d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012db:	74 3d                	je     80131a <ltostr+0xe2>
		start = 1 ;
  8012dd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012e4:	eb 34                	jmp    80131a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ec:	01 d0                	add    %edx,%eax
  8012ee:	8a 00                	mov    (%eax),%al
  8012f0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f9:	01 c2                	add    %eax,%edx
  8012fb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801301:	01 c8                	add    %ecx,%eax
  801303:	8a 00                	mov    (%eax),%al
  801305:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801307:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80130a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130d:	01 c2                	add    %eax,%edx
  80130f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801312:	88 02                	mov    %al,(%edx)
		start++ ;
  801314:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801317:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80131a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80131d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801320:	7c c4                	jl     8012e6 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801322:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801325:	8b 45 0c             	mov    0xc(%ebp),%eax
  801328:	01 d0                	add    %edx,%eax
  80132a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80132d:	90                   	nop
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
  801333:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801336:	ff 75 08             	pushl  0x8(%ebp)
  801339:	e8 54 fa ff ff       	call   800d92 <strlen>
  80133e:	83 c4 04             	add    $0x4,%esp
  801341:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801344:	ff 75 0c             	pushl  0xc(%ebp)
  801347:	e8 46 fa ff ff       	call   800d92 <strlen>
  80134c:	83 c4 04             	add    $0x4,%esp
  80134f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801352:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801359:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801360:	eb 17                	jmp    801379 <strcconcat+0x49>
		final[s] = str1[s] ;
  801362:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801365:	8b 45 10             	mov    0x10(%ebp),%eax
  801368:	01 c2                	add    %eax,%edx
  80136a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80136d:	8b 45 08             	mov    0x8(%ebp),%eax
  801370:	01 c8                	add    %ecx,%eax
  801372:	8a 00                	mov    (%eax),%al
  801374:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801376:	ff 45 fc             	incl   -0x4(%ebp)
  801379:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80137c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80137f:	7c e1                	jl     801362 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801381:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801388:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80138f:	eb 1f                	jmp    8013b0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801391:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801394:	8d 50 01             	lea    0x1(%eax),%edx
  801397:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80139a:	89 c2                	mov    %eax,%edx
  80139c:	8b 45 10             	mov    0x10(%ebp),%eax
  80139f:	01 c2                	add    %eax,%edx
  8013a1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a7:	01 c8                	add    %ecx,%eax
  8013a9:	8a 00                	mov    (%eax),%al
  8013ab:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013ad:	ff 45 f8             	incl   -0x8(%ebp)
  8013b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013b6:	7c d9                	jl     801391 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8013be:	01 d0                	add    %edx,%eax
  8013c0:	c6 00 00             	movb   $0x0,(%eax)
}
  8013c3:	90                   	nop
  8013c4:	c9                   	leave  
  8013c5:	c3                   	ret    

008013c6 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013c6:	55                   	push   %ebp
  8013c7:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8013cc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d5:	8b 00                	mov    (%eax),%eax
  8013d7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013de:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e1:	01 d0                	add    %edx,%eax
  8013e3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013e9:	eb 0c                	jmp    8013f7 <strsplit+0x31>
			*string++ = 0;
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	8d 50 01             	lea    0x1(%eax),%edx
  8013f1:	89 55 08             	mov    %edx,0x8(%ebp)
  8013f4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	8a 00                	mov    (%eax),%al
  8013fc:	84 c0                	test   %al,%al
  8013fe:	74 18                	je     801418 <strsplit+0x52>
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	8a 00                	mov    (%eax),%al
  801405:	0f be c0             	movsbl %al,%eax
  801408:	50                   	push   %eax
  801409:	ff 75 0c             	pushl  0xc(%ebp)
  80140c:	e8 13 fb ff ff       	call   800f24 <strchr>
  801411:	83 c4 08             	add    $0x8,%esp
  801414:	85 c0                	test   %eax,%eax
  801416:	75 d3                	jne    8013eb <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	84 c0                	test   %al,%al
  80141f:	74 5a                	je     80147b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801421:	8b 45 14             	mov    0x14(%ebp),%eax
  801424:	8b 00                	mov    (%eax),%eax
  801426:	83 f8 0f             	cmp    $0xf,%eax
  801429:	75 07                	jne    801432 <strsplit+0x6c>
		{
			return 0;
  80142b:	b8 00 00 00 00       	mov    $0x0,%eax
  801430:	eb 66                	jmp    801498 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801432:	8b 45 14             	mov    0x14(%ebp),%eax
  801435:	8b 00                	mov    (%eax),%eax
  801437:	8d 48 01             	lea    0x1(%eax),%ecx
  80143a:	8b 55 14             	mov    0x14(%ebp),%edx
  80143d:	89 0a                	mov    %ecx,(%edx)
  80143f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801446:	8b 45 10             	mov    0x10(%ebp),%eax
  801449:	01 c2                	add    %eax,%edx
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801450:	eb 03                	jmp    801455 <strsplit+0x8f>
			string++;
  801452:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	8a 00                	mov    (%eax),%al
  80145a:	84 c0                	test   %al,%al
  80145c:	74 8b                	je     8013e9 <strsplit+0x23>
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	8a 00                	mov    (%eax),%al
  801463:	0f be c0             	movsbl %al,%eax
  801466:	50                   	push   %eax
  801467:	ff 75 0c             	pushl  0xc(%ebp)
  80146a:	e8 b5 fa ff ff       	call   800f24 <strchr>
  80146f:	83 c4 08             	add    $0x8,%esp
  801472:	85 c0                	test   %eax,%eax
  801474:	74 dc                	je     801452 <strsplit+0x8c>
			string++;
	}
  801476:	e9 6e ff ff ff       	jmp    8013e9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80147b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80147c:	8b 45 14             	mov    0x14(%ebp),%eax
  80147f:	8b 00                	mov    (%eax),%eax
  801481:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801488:	8b 45 10             	mov    0x10(%ebp),%eax
  80148b:	01 d0                	add    %edx,%eax
  80148d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801493:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
  80149d:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  8014a0:	a1 04 30 80 00       	mov    0x803004,%eax
  8014a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8014a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  8014af:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8014b6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  8014bd:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  8014c4:	e9 f9 00 00 00       	jmp    8015c2 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  8014c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014cc:	05 00 00 00 80       	add    $0x80000000,%eax
  8014d1:	c1 e8 0c             	shr    $0xc,%eax
  8014d4:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8014db:	85 c0                	test   %eax,%eax
  8014dd:	75 1c                	jne    8014fb <nextFitAlgo+0x61>
  8014df:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8014e3:	74 16                	je     8014fb <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  8014e5:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  8014ec:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  8014f3:	ff 4d e0             	decl   -0x20(%ebp)
  8014f6:	e9 90 00 00 00       	jmp    80158b <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  8014fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014fe:	05 00 00 00 80       	add    $0x80000000,%eax
  801503:	c1 e8 0c             	shr    $0xc,%eax
  801506:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80150d:	85 c0                	test   %eax,%eax
  80150f:	75 26                	jne    801537 <nextFitAlgo+0x9d>
  801511:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801515:	75 20                	jne    801537 <nextFitAlgo+0x9d>
			flag = 1;
  801517:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  80151e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801521:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  801524:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  80152b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801532:	ff 4d e0             	decl   -0x20(%ebp)
  801535:	eb 54                	jmp    80158b <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  801537:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80153a:	3b 45 08             	cmp    0x8(%ebp),%eax
  80153d:	72 11                	jb     801550 <nextFitAlgo+0xb6>
				startAdd = tmp;
  80153f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801542:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  801547:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  80154e:	eb 7c                	jmp    8015cc <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  801550:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801553:	05 00 00 00 80       	add    $0x80000000,%eax
  801558:	c1 e8 0c             	shr    $0xc,%eax
  80155b:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801562:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  801565:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801568:	05 00 00 00 80       	add    $0x80000000,%eax
  80156d:	c1 e8 0c             	shr    $0xc,%eax
  801570:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801577:	c1 e0 0c             	shl    $0xc,%eax
  80157a:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  80157d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801584:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  80158b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80158e:	3b 45 08             	cmp    0x8(%ebp),%eax
  801591:	72 11                	jb     8015a4 <nextFitAlgo+0x10a>
			startAdd = tmp;
  801593:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801596:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  80159b:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  8015a2:	eb 28                	jmp    8015cc <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  8015a4:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  8015ab:	76 15                	jbe    8015c2 <nextFitAlgo+0x128>
			flag = newSize = 0;
  8015ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015b4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  8015bb:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  8015c2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8015c6:	0f 85 fd fe ff ff    	jne    8014c9 <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  8015cc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015d0:	75 1a                	jne    8015ec <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  8015d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015d5:	3b 45 08             	cmp    0x8(%ebp),%eax
  8015d8:	73 0a                	jae    8015e4 <nextFitAlgo+0x14a>
  8015da:	b8 00 00 00 00       	mov    $0x0,%eax
  8015df:	e9 99 00 00 00       	jmp    80167d <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  8015e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015e7:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  8015ec:	a1 04 30 80 00       	mov    0x803004,%eax
  8015f1:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  8015f4:	a1 04 30 80 00       	mov    0x803004,%eax
  8015f9:	05 00 00 00 80       	add    $0x80000000,%eax
  8015fe:	c1 e8 0c             	shr    $0xc,%eax
  801601:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  801604:	8b 45 08             	mov    0x8(%ebp),%eax
  801607:	c1 e8 0c             	shr    $0xc,%eax
  80160a:	89 c2                	mov    %eax,%edx
  80160c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80160f:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  801616:	a1 04 30 80 00       	mov    0x803004,%eax
  80161b:	83 ec 08             	sub    $0x8,%esp
  80161e:	ff 75 08             	pushl  0x8(%ebp)
  801621:	50                   	push   %eax
  801622:	e8 82 03 00 00       	call   8019a9 <sys_allocateMem>
  801627:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  80162a:	a1 04 30 80 00       	mov    0x803004,%eax
  80162f:	05 00 00 00 80       	add    $0x80000000,%eax
  801634:	c1 e8 0c             	shr    $0xc,%eax
  801637:	89 c2                	mov    %eax,%edx
  801639:	a1 04 30 80 00       	mov    0x803004,%eax
  80163e:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  801645:	a1 04 30 80 00       	mov    0x803004,%eax
  80164a:	05 00 00 00 80       	add    $0x80000000,%eax
  80164f:	c1 e8 0c             	shr    $0xc,%eax
  801652:	89 c2                	mov    %eax,%edx
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  80165e:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801664:	8b 45 08             	mov    0x8(%ebp),%eax
  801667:	01 d0                	add    %edx,%eax
  801669:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  80166e:	76 0a                	jbe    80167a <nextFitAlgo+0x1e0>
  801670:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  801677:	00 00 80 

	return (void*)returnHolder;
  80167a:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  80167d:	c9                   	leave  
  80167e:	c3                   	ret    

0080167f <malloc>:

void* malloc(uint32 size) {
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
  801682:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  801685:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  80168c:	8b 55 08             	mov    0x8(%ebp),%edx
  80168f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801692:	01 d0                	add    %edx,%eax
  801694:	48                   	dec    %eax
  801695:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801698:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80169b:	ba 00 00 00 00       	mov    $0x0,%edx
  8016a0:	f7 75 f4             	divl   -0xc(%ebp)
  8016a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016a6:	29 d0                	sub    %edx,%eax
  8016a8:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  8016ab:	e8 c3 06 00 00       	call   801d73 <sys_isUHeapPlacementStrategyNEXTFIT>
  8016b0:	85 c0                	test   %eax,%eax
  8016b2:	74 10                	je     8016c4 <malloc+0x45>
		return nextFitAlgo(size);
  8016b4:	83 ec 0c             	sub    $0xc,%esp
  8016b7:	ff 75 08             	pushl  0x8(%ebp)
  8016ba:	e8 db fd ff ff       	call   80149a <nextFitAlgo>
  8016bf:	83 c4 10             	add    $0x10,%esp
  8016c2:	eb 0a                	jmp    8016ce <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  8016c4:	e8 79 06 00 00       	call   801d42 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  8016c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
  8016d3:	83 ec 18             	sub    $0x18,%esp
  8016d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d9:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8016dc:	83 ec 04             	sub    $0x4,%esp
  8016df:	68 b0 26 80 00       	push   $0x8026b0
  8016e4:	6a 7e                	push   $0x7e
  8016e6:	68 cf 26 80 00       	push   $0x8026cf
  8016eb:	e8 00 07 00 00       	call   801df0 <_panic>

008016f0 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
  8016f3:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8016f6:	83 ec 04             	sub    $0x4,%esp
  8016f9:	68 db 26 80 00       	push   $0x8026db
  8016fe:	68 84 00 00 00       	push   $0x84
  801703:	68 cf 26 80 00       	push   $0x8026cf
  801708:	e8 e3 06 00 00       	call   801df0 <_panic>

0080170d <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80170d:	55                   	push   %ebp
  80170e:	89 e5                	mov    %esp,%ebp
  801710:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801713:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80171a:	eb 61                	jmp    80177d <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  80171c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80171f:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  801726:	8b 45 08             	mov    0x8(%ebp),%eax
  801729:	39 c2                	cmp    %eax,%edx
  80172b:	75 4d                	jne    80177a <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  80172d:	8b 45 08             	mov    0x8(%ebp),%eax
  801730:	05 00 00 00 80       	add    $0x80000000,%eax
  801735:	c1 e8 0c             	shr    $0xc,%eax
  801738:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  80173b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80173e:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  801745:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  801748:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80174b:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  801752:	00 00 00 00 
  801756:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801759:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  801760:	00 00 00 00 
  801764:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801767:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  80176e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801771:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  801778:	eb 0d                	jmp    801787 <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  80177a:	ff 45 f0             	incl   -0x10(%ebp)
  80177d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801780:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801785:	76 95                	jbe    80171c <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  801787:	8b 45 08             	mov    0x8(%ebp),%eax
  80178a:	83 ec 08             	sub    $0x8,%esp
  80178d:	ff 75 f4             	pushl  -0xc(%ebp)
  801790:	50                   	push   %eax
  801791:	e8 f7 01 00 00       	call   80198d <sys_freeMem>
  801796:	83 c4 10             	add    $0x10,%esp
}
  801799:	90                   	nop
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sfree>:


void sfree(void* virtual_address)
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
  80179f:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8017a2:	83 ec 04             	sub    $0x4,%esp
  8017a5:	68 f7 26 80 00       	push   $0x8026f7
  8017aa:	68 ac 00 00 00       	push   $0xac
  8017af:	68 cf 26 80 00       	push   $0x8026cf
  8017b4:	e8 37 06 00 00       	call   801df0 <_panic>

008017b9 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  8017b9:	55                   	push   %ebp
  8017ba:	89 e5                	mov    %esp,%ebp
  8017bc:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8017bf:	83 ec 04             	sub    $0x4,%esp
  8017c2:	68 14 27 80 00       	push   $0x802714
  8017c7:	68 c4 00 00 00       	push   $0xc4
  8017cc:	68 cf 26 80 00       	push   $0x8026cf
  8017d1:	e8 1a 06 00 00       	call   801df0 <_panic>

008017d6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
  8017d9:	57                   	push   %edi
  8017da:	56                   	push   %esi
  8017db:	53                   	push   %ebx
  8017dc:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8017df:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017e8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017eb:	8b 7d 18             	mov    0x18(%ebp),%edi
  8017ee:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8017f1:	cd 30                	int    $0x30
  8017f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8017f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8017f9:	83 c4 10             	add    $0x10,%esp
  8017fc:	5b                   	pop    %ebx
  8017fd:	5e                   	pop    %esi
  8017fe:	5f                   	pop    %edi
  8017ff:	5d                   	pop    %ebp
  801800:	c3                   	ret    

00801801 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
  801804:	83 ec 04             	sub    $0x4,%esp
  801807:	8b 45 10             	mov    0x10(%ebp),%eax
  80180a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80180d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801811:	8b 45 08             	mov    0x8(%ebp),%eax
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	52                   	push   %edx
  801819:	ff 75 0c             	pushl  0xc(%ebp)
  80181c:	50                   	push   %eax
  80181d:	6a 00                	push   $0x0
  80181f:	e8 b2 ff ff ff       	call   8017d6 <syscall>
  801824:	83 c4 18             	add    $0x18,%esp
}
  801827:	90                   	nop
  801828:	c9                   	leave  
  801829:	c3                   	ret    

0080182a <sys_cgetc>:

int
sys_cgetc(void)
{
  80182a:	55                   	push   %ebp
  80182b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 01                	push   $0x1
  801839:	e8 98 ff ff ff       	call   8017d6 <syscall>
  80183e:	83 c4 18             	add    $0x18,%esp
}
  801841:	c9                   	leave  
  801842:	c3                   	ret    

00801843 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801843:	55                   	push   %ebp
  801844:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801846:	8b 45 08             	mov    0x8(%ebp),%eax
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	50                   	push   %eax
  801852:	6a 05                	push   $0x5
  801854:	e8 7d ff ff ff       	call   8017d6 <syscall>
  801859:	83 c4 18             	add    $0x18,%esp
}
  80185c:	c9                   	leave  
  80185d:	c3                   	ret    

0080185e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80185e:	55                   	push   %ebp
  80185f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 02                	push   $0x2
  80186d:	e8 64 ff ff ff       	call   8017d6 <syscall>
  801872:	83 c4 18             	add    $0x18,%esp
}
  801875:	c9                   	leave  
  801876:	c3                   	ret    

00801877 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801877:	55                   	push   %ebp
  801878:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 03                	push   $0x3
  801886:	e8 4b ff ff ff       	call   8017d6 <syscall>
  80188b:	83 c4 18             	add    $0x18,%esp
}
  80188e:	c9                   	leave  
  80188f:	c3                   	ret    

00801890 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801890:	55                   	push   %ebp
  801891:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 04                	push   $0x4
  80189f:	e8 32 ff ff ff       	call   8017d6 <syscall>
  8018a4:	83 c4 18             	add    $0x18,%esp
}
  8018a7:	c9                   	leave  
  8018a8:	c3                   	ret    

008018a9 <sys_env_exit>:


void sys_env_exit(void)
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 06                	push   $0x6
  8018b8:	e8 19 ff ff ff       	call   8017d6 <syscall>
  8018bd:	83 c4 18             	add    $0x18,%esp
}
  8018c0:	90                   	nop
  8018c1:	c9                   	leave  
  8018c2:	c3                   	ret    

008018c3 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8018c3:	55                   	push   %ebp
  8018c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8018c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	52                   	push   %edx
  8018d3:	50                   	push   %eax
  8018d4:	6a 07                	push   $0x7
  8018d6:	e8 fb fe ff ff       	call   8017d6 <syscall>
  8018db:	83 c4 18             	add    $0x18,%esp
}
  8018de:	c9                   	leave  
  8018df:	c3                   	ret    

008018e0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8018e0:	55                   	push   %ebp
  8018e1:	89 e5                	mov    %esp,%ebp
  8018e3:	56                   	push   %esi
  8018e4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8018e5:	8b 75 18             	mov    0x18(%ebp),%esi
  8018e8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f4:	56                   	push   %esi
  8018f5:	53                   	push   %ebx
  8018f6:	51                   	push   %ecx
  8018f7:	52                   	push   %edx
  8018f8:	50                   	push   %eax
  8018f9:	6a 08                	push   $0x8
  8018fb:	e8 d6 fe ff ff       	call   8017d6 <syscall>
  801900:	83 c4 18             	add    $0x18,%esp
}
  801903:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801906:	5b                   	pop    %ebx
  801907:	5e                   	pop    %esi
  801908:	5d                   	pop    %ebp
  801909:	c3                   	ret    

0080190a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80190a:	55                   	push   %ebp
  80190b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80190d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801910:	8b 45 08             	mov    0x8(%ebp),%eax
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	52                   	push   %edx
  80191a:	50                   	push   %eax
  80191b:	6a 09                	push   $0x9
  80191d:	e8 b4 fe ff ff       	call   8017d6 <syscall>
  801922:	83 c4 18             	add    $0x18,%esp
}
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	ff 75 0c             	pushl  0xc(%ebp)
  801933:	ff 75 08             	pushl  0x8(%ebp)
  801936:	6a 0a                	push   $0xa
  801938:	e8 99 fe ff ff       	call   8017d6 <syscall>
  80193d:	83 c4 18             	add    $0x18,%esp
}
  801940:	c9                   	leave  
  801941:	c3                   	ret    

00801942 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801942:	55                   	push   %ebp
  801943:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 0b                	push   $0xb
  801951:	e8 80 fe ff ff       	call   8017d6 <syscall>
  801956:	83 c4 18             	add    $0x18,%esp
}
  801959:	c9                   	leave  
  80195a:	c3                   	ret    

0080195b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 0c                	push   $0xc
  80196a:	e8 67 fe ff ff       	call   8017d6 <syscall>
  80196f:	83 c4 18             	add    $0x18,%esp
}
  801972:	c9                   	leave  
  801973:	c3                   	ret    

00801974 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 0d                	push   $0xd
  801983:	e8 4e fe ff ff       	call   8017d6 <syscall>
  801988:	83 c4 18             	add    $0x18,%esp
}
  80198b:	c9                   	leave  
  80198c:	c3                   	ret    

0080198d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80198d:	55                   	push   %ebp
  80198e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	ff 75 0c             	pushl  0xc(%ebp)
  801999:	ff 75 08             	pushl  0x8(%ebp)
  80199c:	6a 11                	push   $0x11
  80199e:	e8 33 fe ff ff       	call   8017d6 <syscall>
  8019a3:	83 c4 18             	add    $0x18,%esp
	return;
  8019a6:	90                   	nop
}
  8019a7:	c9                   	leave  
  8019a8:	c3                   	ret    

008019a9 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019a9:	55                   	push   %ebp
  8019aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	ff 75 0c             	pushl  0xc(%ebp)
  8019b5:	ff 75 08             	pushl  0x8(%ebp)
  8019b8:	6a 12                	push   $0x12
  8019ba:	e8 17 fe ff ff       	call   8017d6 <syscall>
  8019bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8019c2:	90                   	nop
}
  8019c3:	c9                   	leave  
  8019c4:	c3                   	ret    

008019c5 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8019c5:	55                   	push   %ebp
  8019c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 0e                	push   $0xe
  8019d4:	e8 fd fd ff ff       	call   8017d6 <syscall>
  8019d9:	83 c4 18             	add    $0x18,%esp
}
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	ff 75 08             	pushl  0x8(%ebp)
  8019ec:	6a 0f                	push   $0xf
  8019ee:	e8 e3 fd ff ff       	call   8017d6 <syscall>
  8019f3:	83 c4 18             	add    $0x18,%esp
}
  8019f6:	c9                   	leave  
  8019f7:	c3                   	ret    

008019f8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8019f8:	55                   	push   %ebp
  8019f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 10                	push   $0x10
  801a07:	e8 ca fd ff ff       	call   8017d6 <syscall>
  801a0c:	83 c4 18             	add    $0x18,%esp
}
  801a0f:	90                   	nop
  801a10:	c9                   	leave  
  801a11:	c3                   	ret    

00801a12 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a12:	55                   	push   %ebp
  801a13:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 00                	push   $0x0
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 14                	push   $0x14
  801a21:	e8 b0 fd ff ff       	call   8017d6 <syscall>
  801a26:	83 c4 18             	add    $0x18,%esp
}
  801a29:	90                   	nop
  801a2a:	c9                   	leave  
  801a2b:	c3                   	ret    

00801a2c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a2c:	55                   	push   %ebp
  801a2d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	6a 15                	push   $0x15
  801a3b:	e8 96 fd ff ff       	call   8017d6 <syscall>
  801a40:	83 c4 18             	add    $0x18,%esp
}
  801a43:	90                   	nop
  801a44:	c9                   	leave  
  801a45:	c3                   	ret    

00801a46 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
  801a49:	83 ec 04             	sub    $0x4,%esp
  801a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a52:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	50                   	push   %eax
  801a5f:	6a 16                	push   $0x16
  801a61:	e8 70 fd ff ff       	call   8017d6 <syscall>
  801a66:	83 c4 18             	add    $0x18,%esp
}
  801a69:	90                   	nop
  801a6a:	c9                   	leave  
  801a6b:	c3                   	ret    

00801a6c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	6a 17                	push   $0x17
  801a7b:	e8 56 fd ff ff       	call   8017d6 <syscall>
  801a80:	83 c4 18             	add    $0x18,%esp
}
  801a83:	90                   	nop
  801a84:	c9                   	leave  
  801a85:	c3                   	ret    

00801a86 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a89:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	ff 75 0c             	pushl  0xc(%ebp)
  801a95:	50                   	push   %eax
  801a96:	6a 18                	push   $0x18
  801a98:	e8 39 fd ff ff       	call   8017d6 <syscall>
  801a9d:	83 c4 18             	add    $0x18,%esp
}
  801aa0:	c9                   	leave  
  801aa1:	c3                   	ret    

00801aa2 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801aa2:	55                   	push   %ebp
  801aa3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801aa5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	52                   	push   %edx
  801ab2:	50                   	push   %eax
  801ab3:	6a 1b                	push   $0x1b
  801ab5:	e8 1c fd ff ff       	call   8017d6 <syscall>
  801aba:	83 c4 18             	add    $0x18,%esp
}
  801abd:	c9                   	leave  
  801abe:	c3                   	ret    

00801abf <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801abf:	55                   	push   %ebp
  801ac0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ac2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	52                   	push   %edx
  801acf:	50                   	push   %eax
  801ad0:	6a 19                	push   $0x19
  801ad2:	e8 ff fc ff ff       	call   8017d6 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
}
  801ada:	90                   	nop
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ae0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	52                   	push   %edx
  801aed:	50                   	push   %eax
  801aee:	6a 1a                	push   $0x1a
  801af0:	e8 e1 fc ff ff       	call   8017d6 <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
}
  801af8:	90                   	nop
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
  801afe:	83 ec 04             	sub    $0x4,%esp
  801b01:	8b 45 10             	mov    0x10(%ebp),%eax
  801b04:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b07:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b0a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b11:	6a 00                	push   $0x0
  801b13:	51                   	push   %ecx
  801b14:	52                   	push   %edx
  801b15:	ff 75 0c             	pushl  0xc(%ebp)
  801b18:	50                   	push   %eax
  801b19:	6a 1c                	push   $0x1c
  801b1b:	e8 b6 fc ff ff       	call   8017d6 <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b28:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	52                   	push   %edx
  801b35:	50                   	push   %eax
  801b36:	6a 1d                	push   $0x1d
  801b38:	e8 99 fc ff ff       	call   8017d6 <syscall>
  801b3d:	83 c4 18             	add    $0x18,%esp
}
  801b40:	c9                   	leave  
  801b41:	c3                   	ret    

00801b42 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b42:	55                   	push   %ebp
  801b43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b45:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	51                   	push   %ecx
  801b53:	52                   	push   %edx
  801b54:	50                   	push   %eax
  801b55:	6a 1e                	push   $0x1e
  801b57:	e8 7a fc ff ff       	call   8017d6 <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
}
  801b5f:	c9                   	leave  
  801b60:	c3                   	ret    

00801b61 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b61:	55                   	push   %ebp
  801b62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b64:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b67:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6a:	6a 00                	push   $0x0
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	52                   	push   %edx
  801b71:	50                   	push   %eax
  801b72:	6a 1f                	push   $0x1f
  801b74:	e8 5d fc ff ff       	call   8017d6 <syscall>
  801b79:	83 c4 18             	add    $0x18,%esp
}
  801b7c:	c9                   	leave  
  801b7d:	c3                   	ret    

00801b7e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b7e:	55                   	push   %ebp
  801b7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b81:	6a 00                	push   $0x0
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 20                	push   $0x20
  801b8d:	e8 44 fc ff ff       	call   8017d6 <syscall>
  801b92:	83 c4 18             	add    $0x18,%esp
}
  801b95:	c9                   	leave  
  801b96:	c3                   	ret    

00801b97 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801b97:	55                   	push   %ebp
  801b98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	ff 75 10             	pushl  0x10(%ebp)
  801ba4:	ff 75 0c             	pushl  0xc(%ebp)
  801ba7:	50                   	push   %eax
  801ba8:	6a 21                	push   $0x21
  801baa:	e8 27 fc ff ff       	call   8017d6 <syscall>
  801baf:	83 c4 18             	add    $0x18,%esp
}
  801bb2:	c9                   	leave  
  801bb3:	c3                   	ret    

00801bb4 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801bb4:	55                   	push   %ebp
  801bb5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 00                	push   $0x0
  801bc2:	50                   	push   %eax
  801bc3:	6a 22                	push   $0x22
  801bc5:	e8 0c fc ff ff       	call   8017d6 <syscall>
  801bca:	83 c4 18             	add    $0x18,%esp
}
  801bcd:	90                   	nop
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	50                   	push   %eax
  801bdf:	6a 23                	push   $0x23
  801be1:	e8 f0 fb ff ff       	call   8017d6 <syscall>
  801be6:	83 c4 18             	add    $0x18,%esp
}
  801be9:	90                   	nop
  801bea:	c9                   	leave  
  801beb:	c3                   	ret    

00801bec <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801bec:	55                   	push   %ebp
  801bed:	89 e5                	mov    %esp,%ebp
  801bef:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801bf2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bf5:	8d 50 04             	lea    0x4(%eax),%edx
  801bf8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	52                   	push   %edx
  801c02:	50                   	push   %eax
  801c03:	6a 24                	push   $0x24
  801c05:	e8 cc fb ff ff       	call   8017d6 <syscall>
  801c0a:	83 c4 18             	add    $0x18,%esp
	return result;
  801c0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c13:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c16:	89 01                	mov    %eax,(%ecx)
  801c18:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1e:	c9                   	leave  
  801c1f:	c2 04 00             	ret    $0x4

00801c22 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c22:	55                   	push   %ebp
  801c23:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	ff 75 10             	pushl  0x10(%ebp)
  801c2c:	ff 75 0c             	pushl  0xc(%ebp)
  801c2f:	ff 75 08             	pushl  0x8(%ebp)
  801c32:	6a 13                	push   $0x13
  801c34:	e8 9d fb ff ff       	call   8017d6 <syscall>
  801c39:	83 c4 18             	add    $0x18,%esp
	return ;
  801c3c:	90                   	nop
}
  801c3d:	c9                   	leave  
  801c3e:	c3                   	ret    

00801c3f <sys_rcr2>:
uint32 sys_rcr2()
{
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 25                	push   $0x25
  801c4e:	e8 83 fb ff ff       	call   8017d6 <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
}
  801c56:	c9                   	leave  
  801c57:	c3                   	ret    

00801c58 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c58:	55                   	push   %ebp
  801c59:	89 e5                	mov    %esp,%ebp
  801c5b:	83 ec 04             	sub    $0x4,%esp
  801c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c61:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c64:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	50                   	push   %eax
  801c71:	6a 26                	push   $0x26
  801c73:	e8 5e fb ff ff       	call   8017d6 <syscall>
  801c78:	83 c4 18             	add    $0x18,%esp
	return ;
  801c7b:	90                   	nop
}
  801c7c:	c9                   	leave  
  801c7d:	c3                   	ret    

00801c7e <rsttst>:
void rsttst()
{
  801c7e:	55                   	push   %ebp
  801c7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 28                	push   $0x28
  801c8d:	e8 44 fb ff ff       	call   8017d6 <syscall>
  801c92:	83 c4 18             	add    $0x18,%esp
	return ;
  801c95:	90                   	nop
}
  801c96:	c9                   	leave  
  801c97:	c3                   	ret    

00801c98 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c98:	55                   	push   %ebp
  801c99:	89 e5                	mov    %esp,%ebp
  801c9b:	83 ec 04             	sub    $0x4,%esp
  801c9e:	8b 45 14             	mov    0x14(%ebp),%eax
  801ca1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ca4:	8b 55 18             	mov    0x18(%ebp),%edx
  801ca7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cab:	52                   	push   %edx
  801cac:	50                   	push   %eax
  801cad:	ff 75 10             	pushl  0x10(%ebp)
  801cb0:	ff 75 0c             	pushl  0xc(%ebp)
  801cb3:	ff 75 08             	pushl  0x8(%ebp)
  801cb6:	6a 27                	push   $0x27
  801cb8:	e8 19 fb ff ff       	call   8017d6 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
	return ;
  801cc0:	90                   	nop
}
  801cc1:	c9                   	leave  
  801cc2:	c3                   	ret    

00801cc3 <chktst>:
void chktst(uint32 n)
{
  801cc3:	55                   	push   %ebp
  801cc4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	ff 75 08             	pushl  0x8(%ebp)
  801cd1:	6a 29                	push   $0x29
  801cd3:	e8 fe fa ff ff       	call   8017d6 <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
	return ;
  801cdb:	90                   	nop
}
  801cdc:	c9                   	leave  
  801cdd:	c3                   	ret    

00801cde <inctst>:

void inctst()
{
  801cde:	55                   	push   %ebp
  801cdf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 2a                	push   $0x2a
  801ced:	e8 e4 fa ff ff       	call   8017d6 <syscall>
  801cf2:	83 c4 18             	add    $0x18,%esp
	return ;
  801cf5:	90                   	nop
}
  801cf6:	c9                   	leave  
  801cf7:	c3                   	ret    

00801cf8 <gettst>:
uint32 gettst()
{
  801cf8:	55                   	push   %ebp
  801cf9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 2b                	push   $0x2b
  801d07:	e8 ca fa ff ff       	call   8017d6 <syscall>
  801d0c:	83 c4 18             	add    $0x18,%esp
}
  801d0f:	c9                   	leave  
  801d10:	c3                   	ret    

00801d11 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d11:	55                   	push   %ebp
  801d12:	89 e5                	mov    %esp,%ebp
  801d14:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d17:	6a 00                	push   $0x0
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 2c                	push   $0x2c
  801d23:	e8 ae fa ff ff       	call   8017d6 <syscall>
  801d28:	83 c4 18             	add    $0x18,%esp
  801d2b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d2e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d32:	75 07                	jne    801d3b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d34:	b8 01 00 00 00       	mov    $0x1,%eax
  801d39:	eb 05                	jmp    801d40 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d3b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d40:	c9                   	leave  
  801d41:	c3                   	ret    

00801d42 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d42:	55                   	push   %ebp
  801d43:	89 e5                	mov    %esp,%ebp
  801d45:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	6a 2c                	push   $0x2c
  801d54:	e8 7d fa ff ff       	call   8017d6 <syscall>
  801d59:	83 c4 18             	add    $0x18,%esp
  801d5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d5f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d63:	75 07                	jne    801d6c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d65:	b8 01 00 00 00       	mov    $0x1,%eax
  801d6a:	eb 05                	jmp    801d71 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d6c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d71:	c9                   	leave  
  801d72:	c3                   	ret    

00801d73 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d73:	55                   	push   %ebp
  801d74:	89 e5                	mov    %esp,%ebp
  801d76:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 2c                	push   $0x2c
  801d85:	e8 4c fa ff ff       	call   8017d6 <syscall>
  801d8a:	83 c4 18             	add    $0x18,%esp
  801d8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d90:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d94:	75 07                	jne    801d9d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d96:	b8 01 00 00 00       	mov    $0x1,%eax
  801d9b:	eb 05                	jmp    801da2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801da2:	c9                   	leave  
  801da3:	c3                   	ret    

00801da4 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801da4:	55                   	push   %ebp
  801da5:	89 e5                	mov    %esp,%ebp
  801da7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	6a 2c                	push   $0x2c
  801db6:	e8 1b fa ff ff       	call   8017d6 <syscall>
  801dbb:	83 c4 18             	add    $0x18,%esp
  801dbe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801dc1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801dc5:	75 07                	jne    801dce <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801dc7:	b8 01 00 00 00       	mov    $0x1,%eax
  801dcc:	eb 05                	jmp    801dd3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801dce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dd3:	c9                   	leave  
  801dd4:	c3                   	ret    

00801dd5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801dd5:	55                   	push   %ebp
  801dd6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	ff 75 08             	pushl  0x8(%ebp)
  801de3:	6a 2d                	push   $0x2d
  801de5:	e8 ec f9 ff ff       	call   8017d6 <syscall>
  801dea:	83 c4 18             	add    $0x18,%esp
	return ;
  801ded:	90                   	nop
}
  801dee:	c9                   	leave  
  801def:	c3                   	ret    

00801df0 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801df0:	55                   	push   %ebp
  801df1:	89 e5                	mov    %esp,%ebp
  801df3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801df6:	8d 45 10             	lea    0x10(%ebp),%eax
  801df9:	83 c0 04             	add    $0x4,%eax
  801dfc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801dff:	a1 60 30 98 00       	mov    0x983060,%eax
  801e04:	85 c0                	test   %eax,%eax
  801e06:	74 16                	je     801e1e <_panic+0x2e>
		cprintf("%s: ", argv0);
  801e08:	a1 60 30 98 00       	mov    0x983060,%eax
  801e0d:	83 ec 08             	sub    $0x8,%esp
  801e10:	50                   	push   %eax
  801e11:	68 3c 27 80 00       	push   $0x80273c
  801e16:	e8 f5 e8 ff ff       	call   800710 <cprintf>
  801e1b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801e1e:	a1 00 30 80 00       	mov    0x803000,%eax
  801e23:	ff 75 0c             	pushl  0xc(%ebp)
  801e26:	ff 75 08             	pushl  0x8(%ebp)
  801e29:	50                   	push   %eax
  801e2a:	68 41 27 80 00       	push   $0x802741
  801e2f:	e8 dc e8 ff ff       	call   800710 <cprintf>
  801e34:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801e37:	8b 45 10             	mov    0x10(%ebp),%eax
  801e3a:	83 ec 08             	sub    $0x8,%esp
  801e3d:	ff 75 f4             	pushl  -0xc(%ebp)
  801e40:	50                   	push   %eax
  801e41:	e8 5f e8 ff ff       	call   8006a5 <vcprintf>
  801e46:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801e49:	83 ec 08             	sub    $0x8,%esp
  801e4c:	6a 00                	push   $0x0
  801e4e:	68 5d 27 80 00       	push   $0x80275d
  801e53:	e8 4d e8 ff ff       	call   8006a5 <vcprintf>
  801e58:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801e5b:	e8 ce e7 ff ff       	call   80062e <exit>

	// should not return here
	while (1) ;
  801e60:	eb fe                	jmp    801e60 <_panic+0x70>

00801e62 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801e62:	55                   	push   %ebp
  801e63:	89 e5                	mov    %esp,%ebp
  801e65:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801e68:	a1 20 30 80 00       	mov    0x803020,%eax
  801e6d:	8b 50 74             	mov    0x74(%eax),%edx
  801e70:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e73:	39 c2                	cmp    %eax,%edx
  801e75:	74 14                	je     801e8b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801e77:	83 ec 04             	sub    $0x4,%esp
  801e7a:	68 60 27 80 00       	push   $0x802760
  801e7f:	6a 26                	push   $0x26
  801e81:	68 ac 27 80 00       	push   $0x8027ac
  801e86:	e8 65 ff ff ff       	call   801df0 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801e8b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801e92:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801e99:	e9 c2 00 00 00       	jmp    801f60 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801e9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ea1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  801eab:	01 d0                	add    %edx,%eax
  801ead:	8b 00                	mov    (%eax),%eax
  801eaf:	85 c0                	test   %eax,%eax
  801eb1:	75 08                	jne    801ebb <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801eb3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801eb6:	e9 a2 00 00 00       	jmp    801f5d <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801ebb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ec2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801ec9:	eb 69                	jmp    801f34 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801ecb:	a1 20 30 80 00       	mov    0x803020,%eax
  801ed0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ed6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801ed9:	89 d0                	mov    %edx,%eax
  801edb:	01 c0                	add    %eax,%eax
  801edd:	01 d0                	add    %edx,%eax
  801edf:	c1 e0 02             	shl    $0x2,%eax
  801ee2:	01 c8                	add    %ecx,%eax
  801ee4:	8a 40 04             	mov    0x4(%eax),%al
  801ee7:	84 c0                	test   %al,%al
  801ee9:	75 46                	jne    801f31 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801eeb:	a1 20 30 80 00       	mov    0x803020,%eax
  801ef0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ef6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801ef9:	89 d0                	mov    %edx,%eax
  801efb:	01 c0                	add    %eax,%eax
  801efd:	01 d0                	add    %edx,%eax
  801eff:	c1 e0 02             	shl    $0x2,%eax
  801f02:	01 c8                	add    %ecx,%eax
  801f04:	8b 00                	mov    (%eax),%eax
  801f06:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801f09:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801f0c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801f11:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801f13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f16:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f20:	01 c8                	add    %ecx,%eax
  801f22:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f24:	39 c2                	cmp    %eax,%edx
  801f26:	75 09                	jne    801f31 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801f28:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801f2f:	eb 12                	jmp    801f43 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f31:	ff 45 e8             	incl   -0x18(%ebp)
  801f34:	a1 20 30 80 00       	mov    0x803020,%eax
  801f39:	8b 50 74             	mov    0x74(%eax),%edx
  801f3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f3f:	39 c2                	cmp    %eax,%edx
  801f41:	77 88                	ja     801ecb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801f43:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801f47:	75 14                	jne    801f5d <CheckWSWithoutLastIndex+0xfb>
			panic(
  801f49:	83 ec 04             	sub    $0x4,%esp
  801f4c:	68 b8 27 80 00       	push   $0x8027b8
  801f51:	6a 3a                	push   $0x3a
  801f53:	68 ac 27 80 00       	push   $0x8027ac
  801f58:	e8 93 fe ff ff       	call   801df0 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801f5d:	ff 45 f0             	incl   -0x10(%ebp)
  801f60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f63:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801f66:	0f 8c 32 ff ff ff    	jl     801e9e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801f6c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f73:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801f7a:	eb 26                	jmp    801fa2 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801f7c:	a1 20 30 80 00       	mov    0x803020,%eax
  801f81:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801f87:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801f8a:	89 d0                	mov    %edx,%eax
  801f8c:	01 c0                	add    %eax,%eax
  801f8e:	01 d0                	add    %edx,%eax
  801f90:	c1 e0 02             	shl    $0x2,%eax
  801f93:	01 c8                	add    %ecx,%eax
  801f95:	8a 40 04             	mov    0x4(%eax),%al
  801f98:	3c 01                	cmp    $0x1,%al
  801f9a:	75 03                	jne    801f9f <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801f9c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f9f:	ff 45 e0             	incl   -0x20(%ebp)
  801fa2:	a1 20 30 80 00       	mov    0x803020,%eax
  801fa7:	8b 50 74             	mov    0x74(%eax),%edx
  801faa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801fad:	39 c2                	cmp    %eax,%edx
  801faf:	77 cb                	ja     801f7c <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801fb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801fb4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801fb7:	74 14                	je     801fcd <CheckWSWithoutLastIndex+0x16b>
		panic(
  801fb9:	83 ec 04             	sub    $0x4,%esp
  801fbc:	68 0c 28 80 00       	push   $0x80280c
  801fc1:	6a 44                	push   $0x44
  801fc3:	68 ac 27 80 00       	push   $0x8027ac
  801fc8:	e8 23 fe ff ff       	call   801df0 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801fcd:	90                   	nop
  801fce:	c9                   	leave  
  801fcf:	c3                   	ret    

00801fd0 <__udivdi3>:
  801fd0:	55                   	push   %ebp
  801fd1:	57                   	push   %edi
  801fd2:	56                   	push   %esi
  801fd3:	53                   	push   %ebx
  801fd4:	83 ec 1c             	sub    $0x1c,%esp
  801fd7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801fdb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fdf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fe3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801fe7:	89 ca                	mov    %ecx,%edx
  801fe9:	89 f8                	mov    %edi,%eax
  801feb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801fef:	85 f6                	test   %esi,%esi
  801ff1:	75 2d                	jne    802020 <__udivdi3+0x50>
  801ff3:	39 cf                	cmp    %ecx,%edi
  801ff5:	77 65                	ja     80205c <__udivdi3+0x8c>
  801ff7:	89 fd                	mov    %edi,%ebp
  801ff9:	85 ff                	test   %edi,%edi
  801ffb:	75 0b                	jne    802008 <__udivdi3+0x38>
  801ffd:	b8 01 00 00 00       	mov    $0x1,%eax
  802002:	31 d2                	xor    %edx,%edx
  802004:	f7 f7                	div    %edi
  802006:	89 c5                	mov    %eax,%ebp
  802008:	31 d2                	xor    %edx,%edx
  80200a:	89 c8                	mov    %ecx,%eax
  80200c:	f7 f5                	div    %ebp
  80200e:	89 c1                	mov    %eax,%ecx
  802010:	89 d8                	mov    %ebx,%eax
  802012:	f7 f5                	div    %ebp
  802014:	89 cf                	mov    %ecx,%edi
  802016:	89 fa                	mov    %edi,%edx
  802018:	83 c4 1c             	add    $0x1c,%esp
  80201b:	5b                   	pop    %ebx
  80201c:	5e                   	pop    %esi
  80201d:	5f                   	pop    %edi
  80201e:	5d                   	pop    %ebp
  80201f:	c3                   	ret    
  802020:	39 ce                	cmp    %ecx,%esi
  802022:	77 28                	ja     80204c <__udivdi3+0x7c>
  802024:	0f bd fe             	bsr    %esi,%edi
  802027:	83 f7 1f             	xor    $0x1f,%edi
  80202a:	75 40                	jne    80206c <__udivdi3+0x9c>
  80202c:	39 ce                	cmp    %ecx,%esi
  80202e:	72 0a                	jb     80203a <__udivdi3+0x6a>
  802030:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802034:	0f 87 9e 00 00 00    	ja     8020d8 <__udivdi3+0x108>
  80203a:	b8 01 00 00 00       	mov    $0x1,%eax
  80203f:	89 fa                	mov    %edi,%edx
  802041:	83 c4 1c             	add    $0x1c,%esp
  802044:	5b                   	pop    %ebx
  802045:	5e                   	pop    %esi
  802046:	5f                   	pop    %edi
  802047:	5d                   	pop    %ebp
  802048:	c3                   	ret    
  802049:	8d 76 00             	lea    0x0(%esi),%esi
  80204c:	31 ff                	xor    %edi,%edi
  80204e:	31 c0                	xor    %eax,%eax
  802050:	89 fa                	mov    %edi,%edx
  802052:	83 c4 1c             	add    $0x1c,%esp
  802055:	5b                   	pop    %ebx
  802056:	5e                   	pop    %esi
  802057:	5f                   	pop    %edi
  802058:	5d                   	pop    %ebp
  802059:	c3                   	ret    
  80205a:	66 90                	xchg   %ax,%ax
  80205c:	89 d8                	mov    %ebx,%eax
  80205e:	f7 f7                	div    %edi
  802060:	31 ff                	xor    %edi,%edi
  802062:	89 fa                	mov    %edi,%edx
  802064:	83 c4 1c             	add    $0x1c,%esp
  802067:	5b                   	pop    %ebx
  802068:	5e                   	pop    %esi
  802069:	5f                   	pop    %edi
  80206a:	5d                   	pop    %ebp
  80206b:	c3                   	ret    
  80206c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802071:	89 eb                	mov    %ebp,%ebx
  802073:	29 fb                	sub    %edi,%ebx
  802075:	89 f9                	mov    %edi,%ecx
  802077:	d3 e6                	shl    %cl,%esi
  802079:	89 c5                	mov    %eax,%ebp
  80207b:	88 d9                	mov    %bl,%cl
  80207d:	d3 ed                	shr    %cl,%ebp
  80207f:	89 e9                	mov    %ebp,%ecx
  802081:	09 f1                	or     %esi,%ecx
  802083:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802087:	89 f9                	mov    %edi,%ecx
  802089:	d3 e0                	shl    %cl,%eax
  80208b:	89 c5                	mov    %eax,%ebp
  80208d:	89 d6                	mov    %edx,%esi
  80208f:	88 d9                	mov    %bl,%cl
  802091:	d3 ee                	shr    %cl,%esi
  802093:	89 f9                	mov    %edi,%ecx
  802095:	d3 e2                	shl    %cl,%edx
  802097:	8b 44 24 08          	mov    0x8(%esp),%eax
  80209b:	88 d9                	mov    %bl,%cl
  80209d:	d3 e8                	shr    %cl,%eax
  80209f:	09 c2                	or     %eax,%edx
  8020a1:	89 d0                	mov    %edx,%eax
  8020a3:	89 f2                	mov    %esi,%edx
  8020a5:	f7 74 24 0c          	divl   0xc(%esp)
  8020a9:	89 d6                	mov    %edx,%esi
  8020ab:	89 c3                	mov    %eax,%ebx
  8020ad:	f7 e5                	mul    %ebp
  8020af:	39 d6                	cmp    %edx,%esi
  8020b1:	72 19                	jb     8020cc <__udivdi3+0xfc>
  8020b3:	74 0b                	je     8020c0 <__udivdi3+0xf0>
  8020b5:	89 d8                	mov    %ebx,%eax
  8020b7:	31 ff                	xor    %edi,%edi
  8020b9:	e9 58 ff ff ff       	jmp    802016 <__udivdi3+0x46>
  8020be:	66 90                	xchg   %ax,%ax
  8020c0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8020c4:	89 f9                	mov    %edi,%ecx
  8020c6:	d3 e2                	shl    %cl,%edx
  8020c8:	39 c2                	cmp    %eax,%edx
  8020ca:	73 e9                	jae    8020b5 <__udivdi3+0xe5>
  8020cc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8020cf:	31 ff                	xor    %edi,%edi
  8020d1:	e9 40 ff ff ff       	jmp    802016 <__udivdi3+0x46>
  8020d6:	66 90                	xchg   %ax,%ax
  8020d8:	31 c0                	xor    %eax,%eax
  8020da:	e9 37 ff ff ff       	jmp    802016 <__udivdi3+0x46>
  8020df:	90                   	nop

008020e0 <__umoddi3>:
  8020e0:	55                   	push   %ebp
  8020e1:	57                   	push   %edi
  8020e2:	56                   	push   %esi
  8020e3:	53                   	push   %ebx
  8020e4:	83 ec 1c             	sub    $0x1c,%esp
  8020e7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020eb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020ef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020f3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020fb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8020ff:	89 f3                	mov    %esi,%ebx
  802101:	89 fa                	mov    %edi,%edx
  802103:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802107:	89 34 24             	mov    %esi,(%esp)
  80210a:	85 c0                	test   %eax,%eax
  80210c:	75 1a                	jne    802128 <__umoddi3+0x48>
  80210e:	39 f7                	cmp    %esi,%edi
  802110:	0f 86 a2 00 00 00    	jbe    8021b8 <__umoddi3+0xd8>
  802116:	89 c8                	mov    %ecx,%eax
  802118:	89 f2                	mov    %esi,%edx
  80211a:	f7 f7                	div    %edi
  80211c:	89 d0                	mov    %edx,%eax
  80211e:	31 d2                	xor    %edx,%edx
  802120:	83 c4 1c             	add    $0x1c,%esp
  802123:	5b                   	pop    %ebx
  802124:	5e                   	pop    %esi
  802125:	5f                   	pop    %edi
  802126:	5d                   	pop    %ebp
  802127:	c3                   	ret    
  802128:	39 f0                	cmp    %esi,%eax
  80212a:	0f 87 ac 00 00 00    	ja     8021dc <__umoddi3+0xfc>
  802130:	0f bd e8             	bsr    %eax,%ebp
  802133:	83 f5 1f             	xor    $0x1f,%ebp
  802136:	0f 84 ac 00 00 00    	je     8021e8 <__umoddi3+0x108>
  80213c:	bf 20 00 00 00       	mov    $0x20,%edi
  802141:	29 ef                	sub    %ebp,%edi
  802143:	89 fe                	mov    %edi,%esi
  802145:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802149:	89 e9                	mov    %ebp,%ecx
  80214b:	d3 e0                	shl    %cl,%eax
  80214d:	89 d7                	mov    %edx,%edi
  80214f:	89 f1                	mov    %esi,%ecx
  802151:	d3 ef                	shr    %cl,%edi
  802153:	09 c7                	or     %eax,%edi
  802155:	89 e9                	mov    %ebp,%ecx
  802157:	d3 e2                	shl    %cl,%edx
  802159:	89 14 24             	mov    %edx,(%esp)
  80215c:	89 d8                	mov    %ebx,%eax
  80215e:	d3 e0                	shl    %cl,%eax
  802160:	89 c2                	mov    %eax,%edx
  802162:	8b 44 24 08          	mov    0x8(%esp),%eax
  802166:	d3 e0                	shl    %cl,%eax
  802168:	89 44 24 04          	mov    %eax,0x4(%esp)
  80216c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802170:	89 f1                	mov    %esi,%ecx
  802172:	d3 e8                	shr    %cl,%eax
  802174:	09 d0                	or     %edx,%eax
  802176:	d3 eb                	shr    %cl,%ebx
  802178:	89 da                	mov    %ebx,%edx
  80217a:	f7 f7                	div    %edi
  80217c:	89 d3                	mov    %edx,%ebx
  80217e:	f7 24 24             	mull   (%esp)
  802181:	89 c6                	mov    %eax,%esi
  802183:	89 d1                	mov    %edx,%ecx
  802185:	39 d3                	cmp    %edx,%ebx
  802187:	0f 82 87 00 00 00    	jb     802214 <__umoddi3+0x134>
  80218d:	0f 84 91 00 00 00    	je     802224 <__umoddi3+0x144>
  802193:	8b 54 24 04          	mov    0x4(%esp),%edx
  802197:	29 f2                	sub    %esi,%edx
  802199:	19 cb                	sbb    %ecx,%ebx
  80219b:	89 d8                	mov    %ebx,%eax
  80219d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8021a1:	d3 e0                	shl    %cl,%eax
  8021a3:	89 e9                	mov    %ebp,%ecx
  8021a5:	d3 ea                	shr    %cl,%edx
  8021a7:	09 d0                	or     %edx,%eax
  8021a9:	89 e9                	mov    %ebp,%ecx
  8021ab:	d3 eb                	shr    %cl,%ebx
  8021ad:	89 da                	mov    %ebx,%edx
  8021af:	83 c4 1c             	add    $0x1c,%esp
  8021b2:	5b                   	pop    %ebx
  8021b3:	5e                   	pop    %esi
  8021b4:	5f                   	pop    %edi
  8021b5:	5d                   	pop    %ebp
  8021b6:	c3                   	ret    
  8021b7:	90                   	nop
  8021b8:	89 fd                	mov    %edi,%ebp
  8021ba:	85 ff                	test   %edi,%edi
  8021bc:	75 0b                	jne    8021c9 <__umoddi3+0xe9>
  8021be:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c3:	31 d2                	xor    %edx,%edx
  8021c5:	f7 f7                	div    %edi
  8021c7:	89 c5                	mov    %eax,%ebp
  8021c9:	89 f0                	mov    %esi,%eax
  8021cb:	31 d2                	xor    %edx,%edx
  8021cd:	f7 f5                	div    %ebp
  8021cf:	89 c8                	mov    %ecx,%eax
  8021d1:	f7 f5                	div    %ebp
  8021d3:	89 d0                	mov    %edx,%eax
  8021d5:	e9 44 ff ff ff       	jmp    80211e <__umoddi3+0x3e>
  8021da:	66 90                	xchg   %ax,%ax
  8021dc:	89 c8                	mov    %ecx,%eax
  8021de:	89 f2                	mov    %esi,%edx
  8021e0:	83 c4 1c             	add    $0x1c,%esp
  8021e3:	5b                   	pop    %ebx
  8021e4:	5e                   	pop    %esi
  8021e5:	5f                   	pop    %edi
  8021e6:	5d                   	pop    %ebp
  8021e7:	c3                   	ret    
  8021e8:	3b 04 24             	cmp    (%esp),%eax
  8021eb:	72 06                	jb     8021f3 <__umoddi3+0x113>
  8021ed:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021f1:	77 0f                	ja     802202 <__umoddi3+0x122>
  8021f3:	89 f2                	mov    %esi,%edx
  8021f5:	29 f9                	sub    %edi,%ecx
  8021f7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021fb:	89 14 24             	mov    %edx,(%esp)
  8021fe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802202:	8b 44 24 04          	mov    0x4(%esp),%eax
  802206:	8b 14 24             	mov    (%esp),%edx
  802209:	83 c4 1c             	add    $0x1c,%esp
  80220c:	5b                   	pop    %ebx
  80220d:	5e                   	pop    %esi
  80220e:	5f                   	pop    %edi
  80220f:	5d                   	pop    %ebp
  802210:	c3                   	ret    
  802211:	8d 76 00             	lea    0x0(%esi),%esi
  802214:	2b 04 24             	sub    (%esp),%eax
  802217:	19 fa                	sbb    %edi,%edx
  802219:	89 d1                	mov    %edx,%ecx
  80221b:	89 c6                	mov    %eax,%esi
  80221d:	e9 71 ff ff ff       	jmp    802193 <__umoddi3+0xb3>
  802222:	66 90                	xchg   %ax,%ax
  802224:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802228:	72 ea                	jb     802214 <__umoddi3+0x134>
  80222a:	89 d9                	mov    %ebx,%ecx
  80222c:	e9 62 ff ff ff       	jmp    802193 <__umoddi3+0xb3>
