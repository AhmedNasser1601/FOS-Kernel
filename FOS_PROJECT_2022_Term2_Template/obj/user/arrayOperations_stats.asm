
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
  80003e:	e8 e8 16 00 00       	call   80172b <sys_getenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int32 parentenvID = sys_getparentenvid();
  800046:	e8 12 17 00 00       	call   80175d <sys_getparentenvid>
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
  80005f:	68 20 21 80 00       	push   $0x802120
  800064:	ff 75 ec             	pushl  -0x14(%ebp)
  800067:	e8 cc 15 00 00       	call   801638 <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	numOfElements = sget(parentenvID,"arrSize") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 24 21 80 00       	push   $0x802124
  80007a:	ff 75 ec             	pushl  -0x14(%ebp)
  80007d:	e8 b6 15 00 00       	call   801638 <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800088:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	finishedCount = sget(parentenvID,"finishedCount") ;
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	68 2c 21 80 00       	push   $0x80212c
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 99 15 00 00       	call   801638 <sget>
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
  8000b3:	68 3a 21 80 00       	push   $0x80213a
  8000b8:	e8 5b 15 00 00       	call   801618 <smalloc>
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
  800126:	68 44 21 80 00       	push   $0x802144
  80012b:	e8 e0 05 00 00       	call   800710 <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	int *shMean, *shVar, *shMin, *shMax, *shMed;
	shMean = smalloc("mean", sizeof(int), 0) ; *shMean = mean;
  800133:	83 ec 04             	sub    $0x4,%esp
  800136:	6a 00                	push   $0x0
  800138:	6a 04                	push   $0x4
  80013a:	68 69 21 80 00       	push   $0x802169
  80013f:	e8 d4 14 00 00       	call   801618 <smalloc>
  800144:	83 c4 10             	add    $0x10,%esp
  800147:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80014a:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  80014d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800150:	89 10                	mov    %edx,(%eax)
	shVar = smalloc("var", sizeof(int), 0) ; *shVar = var;
  800152:	83 ec 04             	sub    $0x4,%esp
  800155:	6a 00                	push   $0x0
  800157:	6a 04                	push   $0x4
  800159:	68 6e 21 80 00       	push   $0x80216e
  80015e:	e8 b5 14 00 00       	call   801618 <smalloc>
  800163:	83 c4 10             	add    $0x10,%esp
  800166:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800169:	8b 55 c0             	mov    -0x40(%ebp),%edx
  80016c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80016f:	89 10                	mov    %edx,(%eax)
	shMin = smalloc("min", sizeof(int), 0) ; *shMin = min;
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	6a 00                	push   $0x0
  800176:	6a 04                	push   $0x4
  800178:	68 72 21 80 00       	push   $0x802172
  80017d:	e8 96 14 00 00       	call   801618 <smalloc>
  800182:	83 c4 10             	add    $0x10,%esp
  800185:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800188:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80018b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80018e:	89 10                	mov    %edx,(%eax)
	shMax = smalloc("max", sizeof(int), 0) ; *shMax = max;
  800190:	83 ec 04             	sub    $0x4,%esp
  800193:	6a 00                	push   $0x0
  800195:	6a 04                	push   $0x4
  800197:	68 76 21 80 00       	push   $0x802176
  80019c:	e8 77 14 00 00       	call   801618 <smalloc>
  8001a1:	83 c4 10             	add    $0x10,%esp
  8001a4:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001a7:	8b 55 b8             	mov    -0x48(%ebp),%edx
  8001aa:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001ad:	89 10                	mov    %edx,(%eax)
	shMed = smalloc("med", sizeof(int), 0) ; *shMed = med;
  8001af:	83 ec 04             	sub    $0x4,%esp
  8001b2:	6a 00                	push   $0x0
  8001b4:	6a 04                	push   $0x4
  8001b6:	68 7a 21 80 00       	push   $0x80217a
  8001bb:	e8 58 14 00 00       	call   801618 <smalloc>
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
  800230:	e8 84 18 00 00       	call   801ab9 <sys_get_virtual_time>
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
  800533:	e8 0c 12 00 00       	call   801744 <sys_getenvindex>
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
  8005a2:	e8 38 13 00 00       	call   8018df <sys_disable_interrupt>
	cprintf("**************************************\n");
  8005a7:	83 ec 0c             	sub    $0xc,%esp
  8005aa:	68 98 21 80 00       	push   $0x802198
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
  8005d2:	68 c0 21 80 00       	push   $0x8021c0
  8005d7:	e8 34 01 00 00       	call   800710 <cprintf>
  8005dc:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8005df:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e4:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8005ea:	83 ec 08             	sub    $0x8,%esp
  8005ed:	50                   	push   %eax
  8005ee:	68 e5 21 80 00       	push   $0x8021e5
  8005f3:	e8 18 01 00 00       	call   800710 <cprintf>
  8005f8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8005fb:	83 ec 0c             	sub    $0xc,%esp
  8005fe:	68 98 21 80 00       	push   $0x802198
  800603:	e8 08 01 00 00       	call   800710 <cprintf>
  800608:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80060b:	e8 e9 12 00 00       	call   8018f9 <sys_enable_interrupt>

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
  800623:	e8 e8 10 00 00       	call   801710 <sys_env_destroy>
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
  800634:	e8 3d 11 00 00       	call   801776 <sys_env_exit>
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
  800682:	e8 47 10 00 00       	call   8016ce <sys_cputs>
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
  8006f9:	e8 d0 0f 00 00       	call   8016ce <sys_cputs>
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
  800743:	e8 97 11 00 00       	call   8018df <sys_disable_interrupt>
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
  800763:	e8 91 11 00 00       	call   8018f9 <sys_enable_interrupt>
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
  8007ad:	e8 ee 16 00 00       	call   801ea0 <__udivdi3>
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
  8007fd:	e8 ae 17 00 00       	call   801fb0 <__umoddi3>
  800802:	83 c4 10             	add    $0x10,%esp
  800805:	05 14 24 80 00       	add    $0x802414,%eax
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
  800958:	8b 04 85 38 24 80 00 	mov    0x802438(,%eax,4),%eax
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
  800a39:	8b 34 9d 80 22 80 00 	mov    0x802280(,%ebx,4),%esi
  800a40:	85 f6                	test   %esi,%esi
  800a42:	75 19                	jne    800a5d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a44:	53                   	push   %ebx
  800a45:	68 25 24 80 00       	push   $0x802425
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
  800a5e:	68 2e 24 80 00       	push   $0x80242e
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
  800a8b:	be 31 24 80 00       	mov    $0x802431,%esi
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

0080149a <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
  80149d:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  8014a0:	e8 9b 07 00 00       	call   801c40 <sys_isUHeapPlacementStrategyNEXTFIT>
  8014a5:	85 c0                	test   %eax,%eax
  8014a7:	0f 84 64 01 00 00    	je     801611 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  8014ad:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  8014b3:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  8014ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8014bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014c0:	01 d0                	add    %edx,%eax
  8014c2:	48                   	dec    %eax
  8014c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8014c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014c9:	ba 00 00 00 00       	mov    $0x0,%edx
  8014ce:	f7 75 e8             	divl   -0x18(%ebp)
  8014d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8014d4:	29 d0                	sub    %edx,%eax
  8014d6:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  8014dd:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	01 d0                	add    %edx,%eax
  8014e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  8014eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  8014f2:	a1 28 30 80 00       	mov    0x803028,%eax
  8014f7:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8014fe:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801501:	0f 83 0a 01 00 00    	jae    801611 <malloc+0x177>
  801507:	a1 28 30 80 00       	mov    0x803028,%eax
  80150c:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801513:	85 c0                	test   %eax,%eax
  801515:	0f 84 f6 00 00 00    	je     801611 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  80151b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801522:	e9 dc 00 00 00       	jmp    801603 <malloc+0x169>
				flag++;
  801527:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  80152a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80152d:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801534:	85 c0                	test   %eax,%eax
  801536:	74 07                	je     80153f <malloc+0xa5>
					flag=0;
  801538:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  80153f:	a1 28 30 80 00       	mov    0x803028,%eax
  801544:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80154b:	85 c0                	test   %eax,%eax
  80154d:	79 05                	jns    801554 <malloc+0xba>
  80154f:	05 ff 0f 00 00       	add    $0xfff,%eax
  801554:	c1 f8 0c             	sar    $0xc,%eax
  801557:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80155a:	0f 85 a0 00 00 00    	jne    801600 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801560:	a1 28 30 80 00       	mov    0x803028,%eax
  801565:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80156c:	85 c0                	test   %eax,%eax
  80156e:	79 05                	jns    801575 <malloc+0xdb>
  801570:	05 ff 0f 00 00       	add    $0xfff,%eax
  801575:	c1 f8 0c             	sar    $0xc,%eax
  801578:	89 c2                	mov    %eax,%edx
  80157a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80157d:	29 d0                	sub    %edx,%eax
  80157f:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801582:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801585:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801588:	eb 11                	jmp    80159b <malloc+0x101>
						hFreeArr[j] = 1;
  80158a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80158d:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801594:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801598:	ff 45 ec             	incl   -0x14(%ebp)
  80159b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80159e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015a1:	7e e7                	jle    80158a <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  8015a3:	a1 28 30 80 00       	mov    0x803028,%eax
  8015a8:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8015ab:	81 c2 01 00 08 00    	add    $0x80001,%edx
  8015b1:	c1 e2 0c             	shl    $0xc,%edx
  8015b4:	89 15 04 30 80 00    	mov    %edx,0x803004
  8015ba:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8015c0:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  8015c7:	a1 28 30 80 00       	mov    0x803028,%eax
  8015cc:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8015d3:	89 c2                	mov    %eax,%edx
  8015d5:	a1 28 30 80 00       	mov    0x803028,%eax
  8015da:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  8015e1:	83 ec 08             	sub    $0x8,%esp
  8015e4:	52                   	push   %edx
  8015e5:	50                   	push   %eax
  8015e6:	e8 8b 02 00 00       	call   801876 <sys_allocateMem>
  8015eb:	83 c4 10             	add    $0x10,%esp

					idx++;
  8015ee:	a1 28 30 80 00       	mov    0x803028,%eax
  8015f3:	40                   	inc    %eax
  8015f4:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  8015f9:	a1 04 30 80 00       	mov    0x803004,%eax
  8015fe:	eb 16                	jmp    801616 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801600:	ff 45 f0             	incl   -0x10(%ebp)
  801603:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801606:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80160b:	0f 86 16 ff ff ff    	jbe    801527 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801611:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801616:	c9                   	leave  
  801617:	c3                   	ret    

00801618 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801618:	55                   	push   %ebp
  801619:	89 e5                	mov    %esp,%ebp
  80161b:	83 ec 18             	sub    $0x18,%esp
  80161e:	8b 45 10             	mov    0x10(%ebp),%eax
  801621:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801624:	83 ec 04             	sub    $0x4,%esp
  801627:	68 90 25 80 00       	push   $0x802590
  80162c:	6a 59                	push   $0x59
  80162e:	68 af 25 80 00       	push   $0x8025af
  801633:	e8 85 06 00 00       	call   801cbd <_panic>

00801638 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
  80163b:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  80163e:	83 ec 04             	sub    $0x4,%esp
  801641:	68 bb 25 80 00       	push   $0x8025bb
  801646:	6a 5f                	push   $0x5f
  801648:	68 af 25 80 00       	push   $0x8025af
  80164d:	e8 6b 06 00 00       	call   801cbd <_panic>

00801652 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801652:	55                   	push   %ebp
  801653:	89 e5                	mov    %esp,%ebp
  801655:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801658:	83 ec 04             	sub    $0x4,%esp
  80165b:	68 d8 25 80 00       	push   $0x8025d8
  801660:	6a 70                	push   $0x70
  801662:	68 af 25 80 00       	push   $0x8025af
  801667:	e8 51 06 00 00       	call   801cbd <_panic>

0080166c <sfree>:

}


void sfree(void* virtual_address)
{
  80166c:	55                   	push   %ebp
  80166d:	89 e5                	mov    %esp,%ebp
  80166f:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801672:	83 ec 04             	sub    $0x4,%esp
  801675:	68 fb 25 80 00       	push   $0x8025fb
  80167a:	6a 7b                	push   $0x7b
  80167c:	68 af 25 80 00       	push   $0x8025af
  801681:	e8 37 06 00 00       	call   801cbd <_panic>

00801686 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801686:	55                   	push   %ebp
  801687:	89 e5                	mov    %esp,%ebp
  801689:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80168c:	83 ec 04             	sub    $0x4,%esp
  80168f:	68 18 26 80 00       	push   $0x802618
  801694:	68 93 00 00 00       	push   $0x93
  801699:	68 af 25 80 00       	push   $0x8025af
  80169e:	e8 1a 06 00 00       	call   801cbd <_panic>

008016a3 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
  8016a6:	57                   	push   %edi
  8016a7:	56                   	push   %esi
  8016a8:	53                   	push   %ebx
  8016a9:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016b5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016b8:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016bb:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016be:	cd 30                	int    $0x30
  8016c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016c6:	83 c4 10             	add    $0x10,%esp
  8016c9:	5b                   	pop    %ebx
  8016ca:	5e                   	pop    %esi
  8016cb:	5f                   	pop    %edi
  8016cc:	5d                   	pop    %ebp
  8016cd:	c3                   	ret    

008016ce <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8016ce:	55                   	push   %ebp
  8016cf:	89 e5                	mov    %esp,%ebp
  8016d1:	83 ec 04             	sub    $0x4,%esp
  8016d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8016da:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	52                   	push   %edx
  8016e6:	ff 75 0c             	pushl  0xc(%ebp)
  8016e9:	50                   	push   %eax
  8016ea:	6a 00                	push   $0x0
  8016ec:	e8 b2 ff ff ff       	call   8016a3 <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
}
  8016f4:	90                   	nop
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 01                	push   $0x1
  801706:	e8 98 ff ff ff       	call   8016a3 <syscall>
  80170b:	83 c4 18             	add    $0x18,%esp
}
  80170e:	c9                   	leave  
  80170f:	c3                   	ret    

00801710 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801710:	55                   	push   %ebp
  801711:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	50                   	push   %eax
  80171f:	6a 05                	push   $0x5
  801721:	e8 7d ff ff ff       	call   8016a3 <syscall>
  801726:	83 c4 18             	add    $0x18,%esp
}
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <sys_getenvid>:

int32 sys_getenvid(void)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 02                	push   $0x2
  80173a:	e8 64 ff ff ff       	call   8016a3 <syscall>
  80173f:	83 c4 18             	add    $0x18,%esp
}
  801742:	c9                   	leave  
  801743:	c3                   	ret    

00801744 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801744:	55                   	push   %ebp
  801745:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 03                	push   $0x3
  801753:	e8 4b ff ff ff       	call   8016a3 <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
}
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 04                	push   $0x4
  80176c:	e8 32 ff ff ff       	call   8016a3 <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
}
  801774:	c9                   	leave  
  801775:	c3                   	ret    

00801776 <sys_env_exit>:


void sys_env_exit(void)
{
  801776:	55                   	push   %ebp
  801777:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 06                	push   $0x6
  801785:	e8 19 ff ff ff       	call   8016a3 <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
}
  80178d:	90                   	nop
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801793:	8b 55 0c             	mov    0xc(%ebp),%edx
  801796:	8b 45 08             	mov    0x8(%ebp),%eax
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	52                   	push   %edx
  8017a0:	50                   	push   %eax
  8017a1:	6a 07                	push   $0x7
  8017a3:	e8 fb fe ff ff       	call   8016a3 <syscall>
  8017a8:	83 c4 18             	add    $0x18,%esp
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
  8017b0:	56                   	push   %esi
  8017b1:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017b2:	8b 75 18             	mov    0x18(%ebp),%esi
  8017b5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017be:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c1:	56                   	push   %esi
  8017c2:	53                   	push   %ebx
  8017c3:	51                   	push   %ecx
  8017c4:	52                   	push   %edx
  8017c5:	50                   	push   %eax
  8017c6:	6a 08                	push   $0x8
  8017c8:	e8 d6 fe ff ff       	call   8016a3 <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
}
  8017d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017d3:	5b                   	pop    %ebx
  8017d4:	5e                   	pop    %esi
  8017d5:	5d                   	pop    %ebp
  8017d6:	c3                   	ret    

008017d7 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8017da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	52                   	push   %edx
  8017e7:	50                   	push   %eax
  8017e8:	6a 09                	push   $0x9
  8017ea:	e8 b4 fe ff ff       	call   8016a3 <syscall>
  8017ef:	83 c4 18             	add    $0x18,%esp
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	ff 75 0c             	pushl  0xc(%ebp)
  801800:	ff 75 08             	pushl  0x8(%ebp)
  801803:	6a 0a                	push   $0xa
  801805:	e8 99 fe ff ff       	call   8016a3 <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
}
  80180d:	c9                   	leave  
  80180e:	c3                   	ret    

0080180f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80180f:	55                   	push   %ebp
  801810:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 0b                	push   $0xb
  80181e:	e8 80 fe ff ff       	call   8016a3 <syscall>
  801823:	83 c4 18             	add    $0x18,%esp
}
  801826:	c9                   	leave  
  801827:	c3                   	ret    

00801828 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801828:	55                   	push   %ebp
  801829:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 0c                	push   $0xc
  801837:	e8 67 fe ff ff       	call   8016a3 <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
}
  80183f:	c9                   	leave  
  801840:	c3                   	ret    

00801841 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801841:	55                   	push   %ebp
  801842:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 0d                	push   $0xd
  801850:	e8 4e fe ff ff       	call   8016a3 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
}
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	ff 75 0c             	pushl  0xc(%ebp)
  801866:	ff 75 08             	pushl  0x8(%ebp)
  801869:	6a 11                	push   $0x11
  80186b:	e8 33 fe ff ff       	call   8016a3 <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
	return;
  801873:	90                   	nop
}
  801874:	c9                   	leave  
  801875:	c3                   	ret    

00801876 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801876:	55                   	push   %ebp
  801877:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	ff 75 0c             	pushl  0xc(%ebp)
  801882:	ff 75 08             	pushl  0x8(%ebp)
  801885:	6a 12                	push   $0x12
  801887:	e8 17 fe ff ff       	call   8016a3 <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
	return ;
  80188f:	90                   	nop
}
  801890:	c9                   	leave  
  801891:	c3                   	ret    

00801892 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 0e                	push   $0xe
  8018a1:	e8 fd fd ff ff       	call   8016a3 <syscall>
  8018a6:	83 c4 18             	add    $0x18,%esp
}
  8018a9:	c9                   	leave  
  8018aa:	c3                   	ret    

008018ab <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018ab:	55                   	push   %ebp
  8018ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	ff 75 08             	pushl  0x8(%ebp)
  8018b9:	6a 0f                	push   $0xf
  8018bb:	e8 e3 fd ff ff       	call   8016a3 <syscall>
  8018c0:	83 c4 18             	add    $0x18,%esp
}
  8018c3:	c9                   	leave  
  8018c4:	c3                   	ret    

008018c5 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 10                	push   $0x10
  8018d4:	e8 ca fd ff ff       	call   8016a3 <syscall>
  8018d9:	83 c4 18             	add    $0x18,%esp
}
  8018dc:	90                   	nop
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 14                	push   $0x14
  8018ee:	e8 b0 fd ff ff       	call   8016a3 <syscall>
  8018f3:	83 c4 18             	add    $0x18,%esp
}
  8018f6:	90                   	nop
  8018f7:	c9                   	leave  
  8018f8:	c3                   	ret    

008018f9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8018f9:	55                   	push   %ebp
  8018fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 15                	push   $0x15
  801908:	e8 96 fd ff ff       	call   8016a3 <syscall>
  80190d:	83 c4 18             	add    $0x18,%esp
}
  801910:	90                   	nop
  801911:	c9                   	leave  
  801912:	c3                   	ret    

00801913 <sys_cputc>:


void
sys_cputc(const char c)
{
  801913:	55                   	push   %ebp
  801914:	89 e5                	mov    %esp,%ebp
  801916:	83 ec 04             	sub    $0x4,%esp
  801919:	8b 45 08             	mov    0x8(%ebp),%eax
  80191c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80191f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	50                   	push   %eax
  80192c:	6a 16                	push   $0x16
  80192e:	e8 70 fd ff ff       	call   8016a3 <syscall>
  801933:	83 c4 18             	add    $0x18,%esp
}
  801936:	90                   	nop
  801937:	c9                   	leave  
  801938:	c3                   	ret    

00801939 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801939:	55                   	push   %ebp
  80193a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	6a 17                	push   $0x17
  801948:	e8 56 fd ff ff       	call   8016a3 <syscall>
  80194d:	83 c4 18             	add    $0x18,%esp
}
  801950:	90                   	nop
  801951:	c9                   	leave  
  801952:	c3                   	ret    

00801953 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801956:	8b 45 08             	mov    0x8(%ebp),%eax
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	ff 75 0c             	pushl  0xc(%ebp)
  801962:	50                   	push   %eax
  801963:	6a 18                	push   $0x18
  801965:	e8 39 fd ff ff       	call   8016a3 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
}
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801972:	8b 55 0c             	mov    0xc(%ebp),%edx
  801975:	8b 45 08             	mov    0x8(%ebp),%eax
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	52                   	push   %edx
  80197f:	50                   	push   %eax
  801980:	6a 1b                	push   $0x1b
  801982:	e8 1c fd ff ff       	call   8016a3 <syscall>
  801987:	83 c4 18             	add    $0x18,%esp
}
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80198f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	52                   	push   %edx
  80199c:	50                   	push   %eax
  80199d:	6a 19                	push   $0x19
  80199f:	e8 ff fc ff ff       	call   8016a3 <syscall>
  8019a4:	83 c4 18             	add    $0x18,%esp
}
  8019a7:	90                   	nop
  8019a8:	c9                   	leave  
  8019a9:	c3                   	ret    

008019aa <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019aa:	55                   	push   %ebp
  8019ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	52                   	push   %edx
  8019ba:	50                   	push   %eax
  8019bb:	6a 1a                	push   $0x1a
  8019bd:	e8 e1 fc ff ff       	call   8016a3 <syscall>
  8019c2:	83 c4 18             	add    $0x18,%esp
}
  8019c5:	90                   	nop
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
  8019cb:	83 ec 04             	sub    $0x4,%esp
  8019ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8019d4:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019d7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019db:	8b 45 08             	mov    0x8(%ebp),%eax
  8019de:	6a 00                	push   $0x0
  8019e0:	51                   	push   %ecx
  8019e1:	52                   	push   %edx
  8019e2:	ff 75 0c             	pushl  0xc(%ebp)
  8019e5:	50                   	push   %eax
  8019e6:	6a 1c                	push   $0x1c
  8019e8:	e8 b6 fc ff ff       	call   8016a3 <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8019f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	52                   	push   %edx
  801a02:	50                   	push   %eax
  801a03:	6a 1d                	push   $0x1d
  801a05:	e8 99 fc ff ff       	call   8016a3 <syscall>
  801a0a:	83 c4 18             	add    $0x18,%esp
}
  801a0d:	c9                   	leave  
  801a0e:	c3                   	ret    

00801a0f <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a0f:	55                   	push   %ebp
  801a10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a12:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a18:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	51                   	push   %ecx
  801a20:	52                   	push   %edx
  801a21:	50                   	push   %eax
  801a22:	6a 1e                	push   $0x1e
  801a24:	e8 7a fc ff ff       	call   8016a3 <syscall>
  801a29:	83 c4 18             	add    $0x18,%esp
}
  801a2c:	c9                   	leave  
  801a2d:	c3                   	ret    

00801a2e <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a2e:	55                   	push   %ebp
  801a2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a34:	8b 45 08             	mov    0x8(%ebp),%eax
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	52                   	push   %edx
  801a3e:	50                   	push   %eax
  801a3f:	6a 1f                	push   $0x1f
  801a41:	e8 5d fc ff ff       	call   8016a3 <syscall>
  801a46:	83 c4 18             	add    $0x18,%esp
}
  801a49:	c9                   	leave  
  801a4a:	c3                   	ret    

00801a4b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a4b:	55                   	push   %ebp
  801a4c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 20                	push   $0x20
  801a5a:	e8 44 fc ff ff       	call   8016a3 <syscall>
  801a5f:	83 c4 18             	add    $0x18,%esp
}
  801a62:	c9                   	leave  
  801a63:	c3                   	ret    

00801a64 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801a67:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	ff 75 10             	pushl  0x10(%ebp)
  801a71:	ff 75 0c             	pushl  0xc(%ebp)
  801a74:	50                   	push   %eax
  801a75:	6a 21                	push   $0x21
  801a77:	e8 27 fc ff ff       	call   8016a3 <syscall>
  801a7c:	83 c4 18             	add    $0x18,%esp
}
  801a7f:	c9                   	leave  
  801a80:	c3                   	ret    

00801a81 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801a81:	55                   	push   %ebp
  801a82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a84:	8b 45 08             	mov    0x8(%ebp),%eax
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	50                   	push   %eax
  801a90:	6a 22                	push   $0x22
  801a92:	e8 0c fc ff ff       	call   8016a3 <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
}
  801a9a:	90                   	nop
  801a9b:	c9                   	leave  
  801a9c:	c3                   	ret    

00801a9d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a9d:	55                   	push   %ebp
  801a9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	50                   	push   %eax
  801aac:	6a 23                	push   $0x23
  801aae:	e8 f0 fb ff ff       	call   8016a3 <syscall>
  801ab3:	83 c4 18             	add    $0x18,%esp
}
  801ab6:	90                   	nop
  801ab7:	c9                   	leave  
  801ab8:	c3                   	ret    

00801ab9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ab9:	55                   	push   %ebp
  801aba:	89 e5                	mov    %esp,%ebp
  801abc:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801abf:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ac2:	8d 50 04             	lea    0x4(%eax),%edx
  801ac5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	52                   	push   %edx
  801acf:	50                   	push   %eax
  801ad0:	6a 24                	push   $0x24
  801ad2:	e8 cc fb ff ff       	call   8016a3 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
	return result;
  801ada:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801add:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ae0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ae3:	89 01                	mov    %eax,(%ecx)
  801ae5:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  801aeb:	c9                   	leave  
  801aec:	c2 04 00             	ret    $0x4

00801aef <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	ff 75 10             	pushl  0x10(%ebp)
  801af9:	ff 75 0c             	pushl  0xc(%ebp)
  801afc:	ff 75 08             	pushl  0x8(%ebp)
  801aff:	6a 13                	push   $0x13
  801b01:	e8 9d fb ff ff       	call   8016a3 <syscall>
  801b06:	83 c4 18             	add    $0x18,%esp
	return ;
  801b09:	90                   	nop
}
  801b0a:	c9                   	leave  
  801b0b:	c3                   	ret    

00801b0c <sys_rcr2>:
uint32 sys_rcr2()
{
  801b0c:	55                   	push   %ebp
  801b0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 25                	push   $0x25
  801b1b:	e8 83 fb ff ff       	call   8016a3 <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
  801b28:	83 ec 04             	sub    $0x4,%esp
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b31:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	50                   	push   %eax
  801b3e:	6a 26                	push   $0x26
  801b40:	e8 5e fb ff ff       	call   8016a3 <syscall>
  801b45:	83 c4 18             	add    $0x18,%esp
	return ;
  801b48:	90                   	nop
}
  801b49:	c9                   	leave  
  801b4a:	c3                   	ret    

00801b4b <rsttst>:
void rsttst()
{
  801b4b:	55                   	push   %ebp
  801b4c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	6a 00                	push   $0x0
  801b56:	6a 00                	push   $0x0
  801b58:	6a 28                	push   $0x28
  801b5a:	e8 44 fb ff ff       	call   8016a3 <syscall>
  801b5f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b62:	90                   	nop
}
  801b63:	c9                   	leave  
  801b64:	c3                   	ret    

00801b65 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b65:	55                   	push   %ebp
  801b66:	89 e5                	mov    %esp,%ebp
  801b68:	83 ec 04             	sub    $0x4,%esp
  801b6b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b6e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b71:	8b 55 18             	mov    0x18(%ebp),%edx
  801b74:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b78:	52                   	push   %edx
  801b79:	50                   	push   %eax
  801b7a:	ff 75 10             	pushl  0x10(%ebp)
  801b7d:	ff 75 0c             	pushl  0xc(%ebp)
  801b80:	ff 75 08             	pushl  0x8(%ebp)
  801b83:	6a 27                	push   $0x27
  801b85:	e8 19 fb ff ff       	call   8016a3 <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b8d:	90                   	nop
}
  801b8e:	c9                   	leave  
  801b8f:	c3                   	ret    

00801b90 <chktst>:
void chktst(uint32 n)
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	ff 75 08             	pushl  0x8(%ebp)
  801b9e:	6a 29                	push   $0x29
  801ba0:	e8 fe fa ff ff       	call   8016a3 <syscall>
  801ba5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba8:	90                   	nop
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <inctst>:

void inctst()
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 2a                	push   $0x2a
  801bba:	e8 e4 fa ff ff       	call   8016a3 <syscall>
  801bbf:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc2:	90                   	nop
}
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <gettst>:
uint32 gettst()
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 2b                	push   $0x2b
  801bd4:	e8 ca fa ff ff       	call   8016a3 <syscall>
  801bd9:	83 c4 18             	add    $0x18,%esp
}
  801bdc:	c9                   	leave  
  801bdd:	c3                   	ret    

00801bde <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801bde:	55                   	push   %ebp
  801bdf:	89 e5                	mov    %esp,%ebp
  801be1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 2c                	push   $0x2c
  801bf0:	e8 ae fa ff ff       	call   8016a3 <syscall>
  801bf5:	83 c4 18             	add    $0x18,%esp
  801bf8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801bfb:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801bff:	75 07                	jne    801c08 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c01:	b8 01 00 00 00       	mov    $0x1,%eax
  801c06:	eb 05                	jmp    801c0d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c08:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c0d:	c9                   	leave  
  801c0e:	c3                   	ret    

00801c0f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c0f:	55                   	push   %ebp
  801c10:	89 e5                	mov    %esp,%ebp
  801c12:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 2c                	push   $0x2c
  801c21:	e8 7d fa ff ff       	call   8016a3 <syscall>
  801c26:	83 c4 18             	add    $0x18,%esp
  801c29:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c2c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c30:	75 07                	jne    801c39 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c32:	b8 01 00 00 00       	mov    $0x1,%eax
  801c37:	eb 05                	jmp    801c3e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c39:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c3e:	c9                   	leave  
  801c3f:	c3                   	ret    

00801c40 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c40:	55                   	push   %ebp
  801c41:	89 e5                	mov    %esp,%ebp
  801c43:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 2c                	push   $0x2c
  801c52:	e8 4c fa ff ff       	call   8016a3 <syscall>
  801c57:	83 c4 18             	add    $0x18,%esp
  801c5a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c5d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c61:	75 07                	jne    801c6a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c63:	b8 01 00 00 00       	mov    $0x1,%eax
  801c68:	eb 05                	jmp    801c6f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c6f:	c9                   	leave  
  801c70:	c3                   	ret    

00801c71 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c71:	55                   	push   %ebp
  801c72:	89 e5                	mov    %esp,%ebp
  801c74:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 2c                	push   $0x2c
  801c83:	e8 1b fa ff ff       	call   8016a3 <syscall>
  801c88:	83 c4 18             	add    $0x18,%esp
  801c8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801c8e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801c92:	75 07                	jne    801c9b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801c94:	b8 01 00 00 00       	mov    $0x1,%eax
  801c99:	eb 05                	jmp    801ca0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801c9b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	ff 75 08             	pushl  0x8(%ebp)
  801cb0:	6a 2d                	push   $0x2d
  801cb2:	e8 ec f9 ff ff       	call   8016a3 <syscall>
  801cb7:	83 c4 18             	add    $0x18,%esp
	return ;
  801cba:	90                   	nop
}
  801cbb:	c9                   	leave  
  801cbc:	c3                   	ret    

00801cbd <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801cbd:	55                   	push   %ebp
  801cbe:	89 e5                	mov    %esp,%ebp
  801cc0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801cc3:	8d 45 10             	lea    0x10(%ebp),%eax
  801cc6:	83 c0 04             	add    $0x4,%eax
  801cc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801ccc:	a1 40 50 88 00       	mov    0x885040,%eax
  801cd1:	85 c0                	test   %eax,%eax
  801cd3:	74 16                	je     801ceb <_panic+0x2e>
		cprintf("%s: ", argv0);
  801cd5:	a1 40 50 88 00       	mov    0x885040,%eax
  801cda:	83 ec 08             	sub    $0x8,%esp
  801cdd:	50                   	push   %eax
  801cde:	68 40 26 80 00       	push   $0x802640
  801ce3:	e8 28 ea ff ff       	call   800710 <cprintf>
  801ce8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801ceb:	a1 00 30 80 00       	mov    0x803000,%eax
  801cf0:	ff 75 0c             	pushl  0xc(%ebp)
  801cf3:	ff 75 08             	pushl  0x8(%ebp)
  801cf6:	50                   	push   %eax
  801cf7:	68 45 26 80 00       	push   $0x802645
  801cfc:	e8 0f ea ff ff       	call   800710 <cprintf>
  801d01:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801d04:	8b 45 10             	mov    0x10(%ebp),%eax
  801d07:	83 ec 08             	sub    $0x8,%esp
  801d0a:	ff 75 f4             	pushl  -0xc(%ebp)
  801d0d:	50                   	push   %eax
  801d0e:	e8 92 e9 ff ff       	call   8006a5 <vcprintf>
  801d13:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801d16:	83 ec 08             	sub    $0x8,%esp
  801d19:	6a 00                	push   $0x0
  801d1b:	68 61 26 80 00       	push   $0x802661
  801d20:	e8 80 e9 ff ff       	call   8006a5 <vcprintf>
  801d25:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801d28:	e8 01 e9 ff ff       	call   80062e <exit>

	// should not return here
	while (1) ;
  801d2d:	eb fe                	jmp    801d2d <_panic+0x70>

00801d2f <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801d2f:	55                   	push   %ebp
  801d30:	89 e5                	mov    %esp,%ebp
  801d32:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801d35:	a1 20 30 80 00       	mov    0x803020,%eax
  801d3a:	8b 50 74             	mov    0x74(%eax),%edx
  801d3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d40:	39 c2                	cmp    %eax,%edx
  801d42:	74 14                	je     801d58 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801d44:	83 ec 04             	sub    $0x4,%esp
  801d47:	68 64 26 80 00       	push   $0x802664
  801d4c:	6a 26                	push   $0x26
  801d4e:	68 b0 26 80 00       	push   $0x8026b0
  801d53:	e8 65 ff ff ff       	call   801cbd <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801d58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801d5f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801d66:	e9 c2 00 00 00       	jmp    801e2d <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801d6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d6e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d75:	8b 45 08             	mov    0x8(%ebp),%eax
  801d78:	01 d0                	add    %edx,%eax
  801d7a:	8b 00                	mov    (%eax),%eax
  801d7c:	85 c0                	test   %eax,%eax
  801d7e:	75 08                	jne    801d88 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801d80:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801d83:	e9 a2 00 00 00       	jmp    801e2a <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801d88:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d8f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801d96:	eb 69                	jmp    801e01 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801d98:	a1 20 30 80 00       	mov    0x803020,%eax
  801d9d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801da3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801da6:	89 d0                	mov    %edx,%eax
  801da8:	01 c0                	add    %eax,%eax
  801daa:	01 d0                	add    %edx,%eax
  801dac:	c1 e0 02             	shl    $0x2,%eax
  801daf:	01 c8                	add    %ecx,%eax
  801db1:	8a 40 04             	mov    0x4(%eax),%al
  801db4:	84 c0                	test   %al,%al
  801db6:	75 46                	jne    801dfe <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801db8:	a1 20 30 80 00       	mov    0x803020,%eax
  801dbd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801dc3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801dc6:	89 d0                	mov    %edx,%eax
  801dc8:	01 c0                	add    %eax,%eax
  801dca:	01 d0                	add    %edx,%eax
  801dcc:	c1 e0 02             	shl    $0x2,%eax
  801dcf:	01 c8                	add    %ecx,%eax
  801dd1:	8b 00                	mov    (%eax),%eax
  801dd3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801dd6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801dd9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801dde:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801de0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801de3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801dea:	8b 45 08             	mov    0x8(%ebp),%eax
  801ded:	01 c8                	add    %ecx,%eax
  801def:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801df1:	39 c2                	cmp    %eax,%edx
  801df3:	75 09                	jne    801dfe <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801df5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801dfc:	eb 12                	jmp    801e10 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801dfe:	ff 45 e8             	incl   -0x18(%ebp)
  801e01:	a1 20 30 80 00       	mov    0x803020,%eax
  801e06:	8b 50 74             	mov    0x74(%eax),%edx
  801e09:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e0c:	39 c2                	cmp    %eax,%edx
  801e0e:	77 88                	ja     801d98 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801e10:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801e14:	75 14                	jne    801e2a <CheckWSWithoutLastIndex+0xfb>
			panic(
  801e16:	83 ec 04             	sub    $0x4,%esp
  801e19:	68 bc 26 80 00       	push   $0x8026bc
  801e1e:	6a 3a                	push   $0x3a
  801e20:	68 b0 26 80 00       	push   $0x8026b0
  801e25:	e8 93 fe ff ff       	call   801cbd <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801e2a:	ff 45 f0             	incl   -0x10(%ebp)
  801e2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e30:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801e33:	0f 8c 32 ff ff ff    	jl     801d6b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801e39:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e40:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801e47:	eb 26                	jmp    801e6f <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801e49:	a1 20 30 80 00       	mov    0x803020,%eax
  801e4e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801e54:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801e57:	89 d0                	mov    %edx,%eax
  801e59:	01 c0                	add    %eax,%eax
  801e5b:	01 d0                	add    %edx,%eax
  801e5d:	c1 e0 02             	shl    $0x2,%eax
  801e60:	01 c8                	add    %ecx,%eax
  801e62:	8a 40 04             	mov    0x4(%eax),%al
  801e65:	3c 01                	cmp    $0x1,%al
  801e67:	75 03                	jne    801e6c <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801e69:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e6c:	ff 45 e0             	incl   -0x20(%ebp)
  801e6f:	a1 20 30 80 00       	mov    0x803020,%eax
  801e74:	8b 50 74             	mov    0x74(%eax),%edx
  801e77:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e7a:	39 c2                	cmp    %eax,%edx
  801e7c:	77 cb                	ja     801e49 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801e7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e81:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801e84:	74 14                	je     801e9a <CheckWSWithoutLastIndex+0x16b>
		panic(
  801e86:	83 ec 04             	sub    $0x4,%esp
  801e89:	68 10 27 80 00       	push   $0x802710
  801e8e:	6a 44                	push   $0x44
  801e90:	68 b0 26 80 00       	push   $0x8026b0
  801e95:	e8 23 fe ff ff       	call   801cbd <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801e9a:	90                   	nop
  801e9b:	c9                   	leave  
  801e9c:	c3                   	ret    
  801e9d:	66 90                	xchg   %ax,%ax
  801e9f:	90                   	nop

00801ea0 <__udivdi3>:
  801ea0:	55                   	push   %ebp
  801ea1:	57                   	push   %edi
  801ea2:	56                   	push   %esi
  801ea3:	53                   	push   %ebx
  801ea4:	83 ec 1c             	sub    $0x1c,%esp
  801ea7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801eab:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801eaf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801eb3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801eb7:	89 ca                	mov    %ecx,%edx
  801eb9:	89 f8                	mov    %edi,%eax
  801ebb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ebf:	85 f6                	test   %esi,%esi
  801ec1:	75 2d                	jne    801ef0 <__udivdi3+0x50>
  801ec3:	39 cf                	cmp    %ecx,%edi
  801ec5:	77 65                	ja     801f2c <__udivdi3+0x8c>
  801ec7:	89 fd                	mov    %edi,%ebp
  801ec9:	85 ff                	test   %edi,%edi
  801ecb:	75 0b                	jne    801ed8 <__udivdi3+0x38>
  801ecd:	b8 01 00 00 00       	mov    $0x1,%eax
  801ed2:	31 d2                	xor    %edx,%edx
  801ed4:	f7 f7                	div    %edi
  801ed6:	89 c5                	mov    %eax,%ebp
  801ed8:	31 d2                	xor    %edx,%edx
  801eda:	89 c8                	mov    %ecx,%eax
  801edc:	f7 f5                	div    %ebp
  801ede:	89 c1                	mov    %eax,%ecx
  801ee0:	89 d8                	mov    %ebx,%eax
  801ee2:	f7 f5                	div    %ebp
  801ee4:	89 cf                	mov    %ecx,%edi
  801ee6:	89 fa                	mov    %edi,%edx
  801ee8:	83 c4 1c             	add    $0x1c,%esp
  801eeb:	5b                   	pop    %ebx
  801eec:	5e                   	pop    %esi
  801eed:	5f                   	pop    %edi
  801eee:	5d                   	pop    %ebp
  801eef:	c3                   	ret    
  801ef0:	39 ce                	cmp    %ecx,%esi
  801ef2:	77 28                	ja     801f1c <__udivdi3+0x7c>
  801ef4:	0f bd fe             	bsr    %esi,%edi
  801ef7:	83 f7 1f             	xor    $0x1f,%edi
  801efa:	75 40                	jne    801f3c <__udivdi3+0x9c>
  801efc:	39 ce                	cmp    %ecx,%esi
  801efe:	72 0a                	jb     801f0a <__udivdi3+0x6a>
  801f00:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f04:	0f 87 9e 00 00 00    	ja     801fa8 <__udivdi3+0x108>
  801f0a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f0f:	89 fa                	mov    %edi,%edx
  801f11:	83 c4 1c             	add    $0x1c,%esp
  801f14:	5b                   	pop    %ebx
  801f15:	5e                   	pop    %esi
  801f16:	5f                   	pop    %edi
  801f17:	5d                   	pop    %ebp
  801f18:	c3                   	ret    
  801f19:	8d 76 00             	lea    0x0(%esi),%esi
  801f1c:	31 ff                	xor    %edi,%edi
  801f1e:	31 c0                	xor    %eax,%eax
  801f20:	89 fa                	mov    %edi,%edx
  801f22:	83 c4 1c             	add    $0x1c,%esp
  801f25:	5b                   	pop    %ebx
  801f26:	5e                   	pop    %esi
  801f27:	5f                   	pop    %edi
  801f28:	5d                   	pop    %ebp
  801f29:	c3                   	ret    
  801f2a:	66 90                	xchg   %ax,%ax
  801f2c:	89 d8                	mov    %ebx,%eax
  801f2e:	f7 f7                	div    %edi
  801f30:	31 ff                	xor    %edi,%edi
  801f32:	89 fa                	mov    %edi,%edx
  801f34:	83 c4 1c             	add    $0x1c,%esp
  801f37:	5b                   	pop    %ebx
  801f38:	5e                   	pop    %esi
  801f39:	5f                   	pop    %edi
  801f3a:	5d                   	pop    %ebp
  801f3b:	c3                   	ret    
  801f3c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f41:	89 eb                	mov    %ebp,%ebx
  801f43:	29 fb                	sub    %edi,%ebx
  801f45:	89 f9                	mov    %edi,%ecx
  801f47:	d3 e6                	shl    %cl,%esi
  801f49:	89 c5                	mov    %eax,%ebp
  801f4b:	88 d9                	mov    %bl,%cl
  801f4d:	d3 ed                	shr    %cl,%ebp
  801f4f:	89 e9                	mov    %ebp,%ecx
  801f51:	09 f1                	or     %esi,%ecx
  801f53:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f57:	89 f9                	mov    %edi,%ecx
  801f59:	d3 e0                	shl    %cl,%eax
  801f5b:	89 c5                	mov    %eax,%ebp
  801f5d:	89 d6                	mov    %edx,%esi
  801f5f:	88 d9                	mov    %bl,%cl
  801f61:	d3 ee                	shr    %cl,%esi
  801f63:	89 f9                	mov    %edi,%ecx
  801f65:	d3 e2                	shl    %cl,%edx
  801f67:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f6b:	88 d9                	mov    %bl,%cl
  801f6d:	d3 e8                	shr    %cl,%eax
  801f6f:	09 c2                	or     %eax,%edx
  801f71:	89 d0                	mov    %edx,%eax
  801f73:	89 f2                	mov    %esi,%edx
  801f75:	f7 74 24 0c          	divl   0xc(%esp)
  801f79:	89 d6                	mov    %edx,%esi
  801f7b:	89 c3                	mov    %eax,%ebx
  801f7d:	f7 e5                	mul    %ebp
  801f7f:	39 d6                	cmp    %edx,%esi
  801f81:	72 19                	jb     801f9c <__udivdi3+0xfc>
  801f83:	74 0b                	je     801f90 <__udivdi3+0xf0>
  801f85:	89 d8                	mov    %ebx,%eax
  801f87:	31 ff                	xor    %edi,%edi
  801f89:	e9 58 ff ff ff       	jmp    801ee6 <__udivdi3+0x46>
  801f8e:	66 90                	xchg   %ax,%ax
  801f90:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f94:	89 f9                	mov    %edi,%ecx
  801f96:	d3 e2                	shl    %cl,%edx
  801f98:	39 c2                	cmp    %eax,%edx
  801f9a:	73 e9                	jae    801f85 <__udivdi3+0xe5>
  801f9c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f9f:	31 ff                	xor    %edi,%edi
  801fa1:	e9 40 ff ff ff       	jmp    801ee6 <__udivdi3+0x46>
  801fa6:	66 90                	xchg   %ax,%ax
  801fa8:	31 c0                	xor    %eax,%eax
  801faa:	e9 37 ff ff ff       	jmp    801ee6 <__udivdi3+0x46>
  801faf:	90                   	nop

00801fb0 <__umoddi3>:
  801fb0:	55                   	push   %ebp
  801fb1:	57                   	push   %edi
  801fb2:	56                   	push   %esi
  801fb3:	53                   	push   %ebx
  801fb4:	83 ec 1c             	sub    $0x1c,%esp
  801fb7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801fbb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801fbf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fc3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801fc7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801fcb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801fcf:	89 f3                	mov    %esi,%ebx
  801fd1:	89 fa                	mov    %edi,%edx
  801fd3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fd7:	89 34 24             	mov    %esi,(%esp)
  801fda:	85 c0                	test   %eax,%eax
  801fdc:	75 1a                	jne    801ff8 <__umoddi3+0x48>
  801fde:	39 f7                	cmp    %esi,%edi
  801fe0:	0f 86 a2 00 00 00    	jbe    802088 <__umoddi3+0xd8>
  801fe6:	89 c8                	mov    %ecx,%eax
  801fe8:	89 f2                	mov    %esi,%edx
  801fea:	f7 f7                	div    %edi
  801fec:	89 d0                	mov    %edx,%eax
  801fee:	31 d2                	xor    %edx,%edx
  801ff0:	83 c4 1c             	add    $0x1c,%esp
  801ff3:	5b                   	pop    %ebx
  801ff4:	5e                   	pop    %esi
  801ff5:	5f                   	pop    %edi
  801ff6:	5d                   	pop    %ebp
  801ff7:	c3                   	ret    
  801ff8:	39 f0                	cmp    %esi,%eax
  801ffa:	0f 87 ac 00 00 00    	ja     8020ac <__umoddi3+0xfc>
  802000:	0f bd e8             	bsr    %eax,%ebp
  802003:	83 f5 1f             	xor    $0x1f,%ebp
  802006:	0f 84 ac 00 00 00    	je     8020b8 <__umoddi3+0x108>
  80200c:	bf 20 00 00 00       	mov    $0x20,%edi
  802011:	29 ef                	sub    %ebp,%edi
  802013:	89 fe                	mov    %edi,%esi
  802015:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802019:	89 e9                	mov    %ebp,%ecx
  80201b:	d3 e0                	shl    %cl,%eax
  80201d:	89 d7                	mov    %edx,%edi
  80201f:	89 f1                	mov    %esi,%ecx
  802021:	d3 ef                	shr    %cl,%edi
  802023:	09 c7                	or     %eax,%edi
  802025:	89 e9                	mov    %ebp,%ecx
  802027:	d3 e2                	shl    %cl,%edx
  802029:	89 14 24             	mov    %edx,(%esp)
  80202c:	89 d8                	mov    %ebx,%eax
  80202e:	d3 e0                	shl    %cl,%eax
  802030:	89 c2                	mov    %eax,%edx
  802032:	8b 44 24 08          	mov    0x8(%esp),%eax
  802036:	d3 e0                	shl    %cl,%eax
  802038:	89 44 24 04          	mov    %eax,0x4(%esp)
  80203c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802040:	89 f1                	mov    %esi,%ecx
  802042:	d3 e8                	shr    %cl,%eax
  802044:	09 d0                	or     %edx,%eax
  802046:	d3 eb                	shr    %cl,%ebx
  802048:	89 da                	mov    %ebx,%edx
  80204a:	f7 f7                	div    %edi
  80204c:	89 d3                	mov    %edx,%ebx
  80204e:	f7 24 24             	mull   (%esp)
  802051:	89 c6                	mov    %eax,%esi
  802053:	89 d1                	mov    %edx,%ecx
  802055:	39 d3                	cmp    %edx,%ebx
  802057:	0f 82 87 00 00 00    	jb     8020e4 <__umoddi3+0x134>
  80205d:	0f 84 91 00 00 00    	je     8020f4 <__umoddi3+0x144>
  802063:	8b 54 24 04          	mov    0x4(%esp),%edx
  802067:	29 f2                	sub    %esi,%edx
  802069:	19 cb                	sbb    %ecx,%ebx
  80206b:	89 d8                	mov    %ebx,%eax
  80206d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802071:	d3 e0                	shl    %cl,%eax
  802073:	89 e9                	mov    %ebp,%ecx
  802075:	d3 ea                	shr    %cl,%edx
  802077:	09 d0                	or     %edx,%eax
  802079:	89 e9                	mov    %ebp,%ecx
  80207b:	d3 eb                	shr    %cl,%ebx
  80207d:	89 da                	mov    %ebx,%edx
  80207f:	83 c4 1c             	add    $0x1c,%esp
  802082:	5b                   	pop    %ebx
  802083:	5e                   	pop    %esi
  802084:	5f                   	pop    %edi
  802085:	5d                   	pop    %ebp
  802086:	c3                   	ret    
  802087:	90                   	nop
  802088:	89 fd                	mov    %edi,%ebp
  80208a:	85 ff                	test   %edi,%edi
  80208c:	75 0b                	jne    802099 <__umoddi3+0xe9>
  80208e:	b8 01 00 00 00       	mov    $0x1,%eax
  802093:	31 d2                	xor    %edx,%edx
  802095:	f7 f7                	div    %edi
  802097:	89 c5                	mov    %eax,%ebp
  802099:	89 f0                	mov    %esi,%eax
  80209b:	31 d2                	xor    %edx,%edx
  80209d:	f7 f5                	div    %ebp
  80209f:	89 c8                	mov    %ecx,%eax
  8020a1:	f7 f5                	div    %ebp
  8020a3:	89 d0                	mov    %edx,%eax
  8020a5:	e9 44 ff ff ff       	jmp    801fee <__umoddi3+0x3e>
  8020aa:	66 90                	xchg   %ax,%ax
  8020ac:	89 c8                	mov    %ecx,%eax
  8020ae:	89 f2                	mov    %esi,%edx
  8020b0:	83 c4 1c             	add    $0x1c,%esp
  8020b3:	5b                   	pop    %ebx
  8020b4:	5e                   	pop    %esi
  8020b5:	5f                   	pop    %edi
  8020b6:	5d                   	pop    %ebp
  8020b7:	c3                   	ret    
  8020b8:	3b 04 24             	cmp    (%esp),%eax
  8020bb:	72 06                	jb     8020c3 <__umoddi3+0x113>
  8020bd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8020c1:	77 0f                	ja     8020d2 <__umoddi3+0x122>
  8020c3:	89 f2                	mov    %esi,%edx
  8020c5:	29 f9                	sub    %edi,%ecx
  8020c7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8020cb:	89 14 24             	mov    %edx,(%esp)
  8020ce:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020d2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8020d6:	8b 14 24             	mov    (%esp),%edx
  8020d9:	83 c4 1c             	add    $0x1c,%esp
  8020dc:	5b                   	pop    %ebx
  8020dd:	5e                   	pop    %esi
  8020de:	5f                   	pop    %edi
  8020df:	5d                   	pop    %ebp
  8020e0:	c3                   	ret    
  8020e1:	8d 76 00             	lea    0x0(%esi),%esi
  8020e4:	2b 04 24             	sub    (%esp),%eax
  8020e7:	19 fa                	sbb    %edi,%edx
  8020e9:	89 d1                	mov    %edx,%ecx
  8020eb:	89 c6                	mov    %eax,%esi
  8020ed:	e9 71 ff ff ff       	jmp    802063 <__umoddi3+0xb3>
  8020f2:	66 90                	xchg   %ax,%ax
  8020f4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8020f8:	72 ea                	jb     8020e4 <__umoddi3+0x134>
  8020fa:	89 d9                	mov    %ebx,%ecx
  8020fc:	e9 62 ff ff ff       	jmp    802063 <__umoddi3+0xb3>
