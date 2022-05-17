
obj/user/tst_malloc_2:     file format elf32-i386


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
  800031:	e8 6f 03 00 00       	call   8003a5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	81 ec 94 00 00 00    	sub    $0x94,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800042:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800046:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004d:	eb 29                	jmp    800078 <_main+0x40>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004f:	a1 20 30 80 00       	mov    0x803020,%eax
  800054:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80005a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005d:	89 d0                	mov    %edx,%eax
  80005f:	01 c0                	add    %eax,%eax
  800061:	01 d0                	add    %edx,%eax
  800063:	c1 e0 02             	shl    $0x2,%eax
  800066:	01 c8                	add    %ecx,%eax
  800068:	8a 40 04             	mov    0x4(%eax),%al
  80006b:	84 c0                	test   %al,%al
  80006d:	74 06                	je     800075 <_main+0x3d>
			{
				fullWS = 0;
  80006f:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800073:	eb 12                	jmp    800087 <_main+0x4f>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800075:	ff 45 f0             	incl   -0x10(%ebp)
  800078:	a1 20 30 80 00       	mov    0x803020,%eax
  80007d:	8b 50 74             	mov    0x74(%eax),%edx
  800080:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800083:	39 c2                	cmp    %eax,%edx
  800085:	77 c8                	ja     80004f <_main+0x17>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800087:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80008b:	74 14                	je     8000a1 <_main+0x69>
  80008d:	83 ec 04             	sub    $0x4,%esp
  800090:	68 c0 20 80 00       	push   $0x8020c0
  800095:	6a 1a                	push   $0x1a
  800097:	68 dc 20 80 00       	push   $0x8020dc
  80009c:	e8 13 04 00 00       	call   8004b4 <_panic>
	}


	int Mega = 1024*1024;
  8000a1:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000a8:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	char minByte = 1<<7;
  8000af:	c6 45 e7 80          	movb   $0x80,-0x19(%ebp)
	char maxByte = 0x7F;
  8000b3:	c6 45 e6 7f          	movb   $0x7f,-0x1a(%ebp)
	short minShort = 1<<15 ;
  8000b7:	66 c7 45 e4 00 80    	movw   $0x8000,-0x1c(%ebp)
	short maxShort = 0x7FFF;
  8000bd:	66 c7 45 e2 ff 7f    	movw   $0x7fff,-0x1e(%ebp)
	int minInt = 1<<31 ;
  8000c3:	c7 45 dc 00 00 00 80 	movl   $0x80000000,-0x24(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000ca:	c7 45 d8 ff ff ff 7f 	movl   $0x7fffffff,-0x28(%ebp)

	void* ptr_allocations[20] = {0};
  8000d1:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
  8000d7:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e1:	89 d7                	mov    %edx,%edi
  8000e3:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e8:	01 c0                	add    %eax,%eax
  8000ea:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000ed:	83 ec 0c             	sub    $0xc,%esp
  8000f0:	50                   	push   %eax
  8000f1:	e8 e1 15 00 00       	call   8016d7 <malloc>
  8000f6:	83 c4 10             	add    $0x10,%esp
  8000f9:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
		char *byteArr = (char *) ptr_allocations[0];
  8000ff:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800105:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800108:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80010b:	01 c0                	add    %eax,%eax
  80010d:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800110:	48                   	dec    %eax
  800111:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = minByte ;
  800114:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800117:	8a 55 e7             	mov    -0x19(%ebp),%dl
  80011a:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  80011c:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80011f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800122:	01 c2                	add    %eax,%edx
  800124:	8a 45 e6             	mov    -0x1a(%ebp),%al
  800127:	88 02                	mov    %al,(%edx)

		ptr_allocations[1] = malloc(2*Mega-kilo);
  800129:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80012c:	01 c0                	add    %eax,%eax
  80012e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	50                   	push   %eax
  800135:	e8 9d 15 00 00       	call   8016d7 <malloc>
  80013a:	83 c4 10             	add    $0x10,%esp
  80013d:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		short *shortArr = (short *) ptr_allocations[1];
  800143:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800149:	89 45 cc             	mov    %eax,-0x34(%ebp)
		int lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  80014c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80014f:	01 c0                	add    %eax,%eax
  800151:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800154:	d1 e8                	shr    %eax
  800156:	48                   	dec    %eax
  800157:	89 45 c8             	mov    %eax,-0x38(%ebp)
		shortArr[0] = minShort;
  80015a:	8b 55 cc             	mov    -0x34(%ebp),%edx
  80015d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800160:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800163:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800166:	01 c0                	add    %eax,%eax
  800168:	89 c2                	mov    %eax,%edx
  80016a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80016d:	01 c2                	add    %eax,%edx
  80016f:	66 8b 45 e2          	mov    -0x1e(%ebp),%ax
  800173:	66 89 02             	mov    %ax,(%edx)

		ptr_allocations[2] = malloc(2*kilo);
  800176:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800179:	01 c0                	add    %eax,%eax
  80017b:	83 ec 0c             	sub    $0xc,%esp
  80017e:	50                   	push   %eax
  80017f:	e8 53 15 00 00       	call   8016d7 <malloc>
  800184:	83 c4 10             	add    $0x10,%esp
  800187:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		int *intArr = (int *) ptr_allocations[2];
  80018d:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800193:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		int lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  800196:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800199:	01 c0                	add    %eax,%eax
  80019b:	c1 e8 02             	shr    $0x2,%eax
  80019e:	48                   	dec    %eax
  80019f:	89 45 c0             	mov    %eax,-0x40(%ebp)
		intArr[0] = minInt;
  8001a2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001a5:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8001a8:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8001aa:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001b4:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001b7:	01 c2                	add    %eax,%edx
  8001b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001bc:	89 02                	mov    %eax,(%edx)

		ptr_allocations[3] = malloc(7*kilo);
  8001be:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8001c1:	89 d0                	mov    %edx,%eax
  8001c3:	01 c0                	add    %eax,%eax
  8001c5:	01 d0                	add    %edx,%eax
  8001c7:	01 c0                	add    %eax,%eax
  8001c9:	01 d0                	add    %edx,%eax
  8001cb:	83 ec 0c             	sub    $0xc,%esp
  8001ce:	50                   	push   %eax
  8001cf:	e8 03 15 00 00       	call   8016d7 <malloc>
  8001d4:	83 c4 10             	add    $0x10,%esp
  8001d7:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		struct MyStruct *structArr = (struct MyStruct *) ptr_allocations[3];
  8001dd:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8001e3:	89 45 bc             	mov    %eax,-0x44(%ebp)
		int lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  8001e6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8001e9:	89 d0                	mov    %edx,%eax
  8001eb:	01 c0                	add    %eax,%eax
  8001ed:	01 d0                	add    %edx,%eax
  8001ef:	01 c0                	add    %eax,%eax
  8001f1:	01 d0                	add    %edx,%eax
  8001f3:	c1 e8 03             	shr    $0x3,%eax
  8001f6:	48                   	dec    %eax
  8001f7:	89 45 b8             	mov    %eax,-0x48(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  8001fa:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001fd:	8a 55 e7             	mov    -0x19(%ebp),%dl
  800200:	88 10                	mov    %dl,(%eax)
  800202:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800205:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800208:	66 89 42 02          	mov    %ax,0x2(%edx)
  80020c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80020f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800212:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  800215:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800218:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80021f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800222:	01 c2                	add    %eax,%edx
  800224:	8a 45 e6             	mov    -0x1a(%ebp),%al
  800227:	88 02                	mov    %al,(%edx)
  800229:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80022c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800233:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800236:	01 c2                	add    %eax,%edx
  800238:	66 8b 45 e2          	mov    -0x1e(%ebp),%ax
  80023c:	66 89 42 02          	mov    %ax,0x2(%edx)
  800240:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800243:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80024a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80024d:	01 c2                	add    %eax,%edx
  80024f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800252:	89 42 04             	mov    %eax,0x4(%edx)

		//Check that the values are successfully stored
		if (byteArr[0] 	!= minByte 	|| byteArr[lastIndexOfByte] 	!= maxByte) panic("Wrong allocation: stored values are wrongly changed!");
  800255:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800258:	8a 00                	mov    (%eax),%al
  80025a:	3a 45 e7             	cmp    -0x19(%ebp),%al
  80025d:	75 0f                	jne    80026e <_main+0x236>
  80025f:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800262:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800265:	01 d0                	add    %edx,%eax
  800267:	8a 00                	mov    (%eax),%al
  800269:	3a 45 e6             	cmp    -0x1a(%ebp),%al
  80026c:	74 14                	je     800282 <_main+0x24a>
  80026e:	83 ec 04             	sub    $0x4,%esp
  800271:	68 f0 20 80 00       	push   $0x8020f0
  800276:	6a 42                	push   $0x42
  800278:	68 dc 20 80 00       	push   $0x8020dc
  80027d:	e8 32 02 00 00       	call   8004b4 <_panic>
		if (shortArr[0] != minShort || shortArr[lastIndexOfShort] 	!= maxShort) panic("Wrong allocation: stored values are wrongly changed!");
  800282:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800285:	66 8b 00             	mov    (%eax),%ax
  800288:	66 3b 45 e4          	cmp    -0x1c(%ebp),%ax
  80028c:	75 15                	jne    8002a3 <_main+0x26b>
  80028e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800291:	01 c0                	add    %eax,%eax
  800293:	89 c2                	mov    %eax,%edx
  800295:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800298:	01 d0                	add    %edx,%eax
  80029a:	66 8b 00             	mov    (%eax),%ax
  80029d:	66 3b 45 e2          	cmp    -0x1e(%ebp),%ax
  8002a1:	74 14                	je     8002b7 <_main+0x27f>
  8002a3:	83 ec 04             	sub    $0x4,%esp
  8002a6:	68 f0 20 80 00       	push   $0x8020f0
  8002ab:	6a 43                	push   $0x43
  8002ad:	68 dc 20 80 00       	push   $0x8020dc
  8002b2:	e8 fd 01 00 00       	call   8004b4 <_panic>
		if (intArr[0] 	!= minInt 	|| intArr[lastIndexOfInt] 		!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  8002b7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002ba:	8b 00                	mov    (%eax),%eax
  8002bc:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8002bf:	75 16                	jne    8002d7 <_main+0x29f>
  8002c1:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002ce:	01 d0                	add    %edx,%eax
  8002d0:	8b 00                	mov    (%eax),%eax
  8002d2:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8002d5:	74 14                	je     8002eb <_main+0x2b3>
  8002d7:	83 ec 04             	sub    $0x4,%esp
  8002da:	68 f0 20 80 00       	push   $0x8020f0
  8002df:	6a 44                	push   $0x44
  8002e1:	68 dc 20 80 00       	push   $0x8020dc
  8002e6:	e8 c9 01 00 00       	call   8004b4 <_panic>

		if (structArr[0].a != minByte 	|| structArr[lastIndexOfStruct].a != maxByte) 	panic("Wrong allocation: stored values are wrongly changed!");
  8002eb:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8002ee:	8a 00                	mov    (%eax),%al
  8002f0:	3a 45 e7             	cmp    -0x19(%ebp),%al
  8002f3:	75 16                	jne    80030b <_main+0x2d3>
  8002f5:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8002f8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002ff:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800302:	01 d0                	add    %edx,%eax
  800304:	8a 00                	mov    (%eax),%al
  800306:	3a 45 e6             	cmp    -0x1a(%ebp),%al
  800309:	74 14                	je     80031f <_main+0x2e7>
  80030b:	83 ec 04             	sub    $0x4,%esp
  80030e:	68 f0 20 80 00       	push   $0x8020f0
  800313:	6a 46                	push   $0x46
  800315:	68 dc 20 80 00       	push   $0x8020dc
  80031a:	e8 95 01 00 00       	call   8004b4 <_panic>
		if (structArr[0].b != minShort 	|| structArr[lastIndexOfStruct].b != maxShort) 	panic("Wrong allocation: stored values are wrongly changed!");
  80031f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800322:	66 8b 40 02          	mov    0x2(%eax),%ax
  800326:	66 3b 45 e4          	cmp    -0x1c(%ebp),%ax
  80032a:	75 19                	jne    800345 <_main+0x30d>
  80032c:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80032f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800336:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800339:	01 d0                	add    %edx,%eax
  80033b:	66 8b 40 02          	mov    0x2(%eax),%ax
  80033f:	66 3b 45 e2          	cmp    -0x1e(%ebp),%ax
  800343:	74 14                	je     800359 <_main+0x321>
  800345:	83 ec 04             	sub    $0x4,%esp
  800348:	68 f0 20 80 00       	push   $0x8020f0
  80034d:	6a 47                	push   $0x47
  80034f:	68 dc 20 80 00       	push   $0x8020dc
  800354:	e8 5b 01 00 00       	call   8004b4 <_panic>
		if (structArr[0].c != minInt 	|| structArr[lastIndexOfStruct].c != maxInt) 	panic("Wrong allocation: stored values are wrongly changed!");
  800359:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80035c:	8b 40 04             	mov    0x4(%eax),%eax
  80035f:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800362:	75 17                	jne    80037b <_main+0x343>
  800364:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800367:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80036e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800371:	01 d0                	add    %edx,%eax
  800373:	8b 40 04             	mov    0x4(%eax),%eax
  800376:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800379:	74 14                	je     80038f <_main+0x357>
  80037b:	83 ec 04             	sub    $0x4,%esp
  80037e:	68 f0 20 80 00       	push   $0x8020f0
  800383:	6a 48                	push   $0x48
  800385:	68 dc 20 80 00       	push   $0x8020dc
  80038a:	e8 25 01 00 00       	call   8004b4 <_panic>


	}

	cprintf("Congratulations!! test malloc (2) completed successfully.\n");
  80038f:	83 ec 0c             	sub    $0xc,%esp
  800392:	68 28 21 80 00       	push   $0x802128
  800397:	e8 cc 03 00 00       	call   800768 <cprintf>
  80039c:	83 c4 10             	add    $0x10,%esp

	return;
  80039f:	90                   	nop
}
  8003a0:	8b 7d fc             	mov    -0x4(%ebp),%edi
  8003a3:	c9                   	leave  
  8003a4:	c3                   	ret    

008003a5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8003a5:	55                   	push   %ebp
  8003a6:	89 e5                	mov    %esp,%ebp
  8003a8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8003ab:	e8 1f 15 00 00       	call   8018cf <sys_getenvindex>
  8003b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003b6:	89 d0                	mov    %edx,%eax
  8003b8:	c1 e0 02             	shl    $0x2,%eax
  8003bb:	01 d0                	add    %edx,%eax
  8003bd:	01 c0                	add    %eax,%eax
  8003bf:	01 d0                	add    %edx,%eax
  8003c1:	01 c0                	add    %eax,%eax
  8003c3:	01 d0                	add    %edx,%eax
  8003c5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8003cc:	01 d0                	add    %edx,%eax
  8003ce:	c1 e0 02             	shl    $0x2,%eax
  8003d1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8003d6:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003db:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e0:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8003e6:	84 c0                	test   %al,%al
  8003e8:	74 0f                	je     8003f9 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8003ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ef:	05 f4 02 00 00       	add    $0x2f4,%eax
  8003f4:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003fd:	7e 0a                	jle    800409 <libmain+0x64>
		binaryname = argv[0];
  8003ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800402:	8b 00                	mov    (%eax),%eax
  800404:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800409:	83 ec 08             	sub    $0x8,%esp
  80040c:	ff 75 0c             	pushl  0xc(%ebp)
  80040f:	ff 75 08             	pushl  0x8(%ebp)
  800412:	e8 21 fc ff ff       	call   800038 <_main>
  800417:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80041a:	e8 4b 16 00 00       	call   801a6a <sys_disable_interrupt>
	cprintf("**************************************\n");
  80041f:	83 ec 0c             	sub    $0xc,%esp
  800422:	68 7c 21 80 00       	push   $0x80217c
  800427:	e8 3c 03 00 00       	call   800768 <cprintf>
  80042c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80042f:	a1 20 30 80 00       	mov    0x803020,%eax
  800434:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80043a:	a1 20 30 80 00       	mov    0x803020,%eax
  80043f:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800445:	83 ec 04             	sub    $0x4,%esp
  800448:	52                   	push   %edx
  800449:	50                   	push   %eax
  80044a:	68 a4 21 80 00       	push   $0x8021a4
  80044f:	e8 14 03 00 00       	call   800768 <cprintf>
  800454:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800457:	a1 20 30 80 00       	mov    0x803020,%eax
  80045c:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800462:	83 ec 08             	sub    $0x8,%esp
  800465:	50                   	push   %eax
  800466:	68 c9 21 80 00       	push   $0x8021c9
  80046b:	e8 f8 02 00 00       	call   800768 <cprintf>
  800470:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800473:	83 ec 0c             	sub    $0xc,%esp
  800476:	68 7c 21 80 00       	push   $0x80217c
  80047b:	e8 e8 02 00 00       	call   800768 <cprintf>
  800480:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800483:	e8 fc 15 00 00       	call   801a84 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800488:	e8 19 00 00 00       	call   8004a6 <exit>
}
  80048d:	90                   	nop
  80048e:	c9                   	leave  
  80048f:	c3                   	ret    

00800490 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800490:	55                   	push   %ebp
  800491:	89 e5                	mov    %esp,%ebp
  800493:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800496:	83 ec 0c             	sub    $0xc,%esp
  800499:	6a 00                	push   $0x0
  80049b:	e8 fb 13 00 00       	call   80189b <sys_env_destroy>
  8004a0:	83 c4 10             	add    $0x10,%esp
}
  8004a3:	90                   	nop
  8004a4:	c9                   	leave  
  8004a5:	c3                   	ret    

008004a6 <exit>:

void
exit(void)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004ac:	e8 50 14 00 00       	call   801901 <sys_env_exit>
}
  8004b1:	90                   	nop
  8004b2:	c9                   	leave  
  8004b3:	c3                   	ret    

008004b4 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004b4:	55                   	push   %ebp
  8004b5:	89 e5                	mov    %esp,%ebp
  8004b7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004ba:	8d 45 10             	lea    0x10(%ebp),%eax
  8004bd:	83 c0 04             	add    $0x4,%eax
  8004c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004c3:	a1 48 30 88 00       	mov    0x883048,%eax
  8004c8:	85 c0                	test   %eax,%eax
  8004ca:	74 16                	je     8004e2 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004cc:	a1 48 30 88 00       	mov    0x883048,%eax
  8004d1:	83 ec 08             	sub    $0x8,%esp
  8004d4:	50                   	push   %eax
  8004d5:	68 e0 21 80 00       	push   $0x8021e0
  8004da:	e8 89 02 00 00       	call   800768 <cprintf>
  8004df:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004e2:	a1 00 30 80 00       	mov    0x803000,%eax
  8004e7:	ff 75 0c             	pushl  0xc(%ebp)
  8004ea:	ff 75 08             	pushl  0x8(%ebp)
  8004ed:	50                   	push   %eax
  8004ee:	68 e5 21 80 00       	push   $0x8021e5
  8004f3:	e8 70 02 00 00       	call   800768 <cprintf>
  8004f8:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fe:	83 ec 08             	sub    $0x8,%esp
  800501:	ff 75 f4             	pushl  -0xc(%ebp)
  800504:	50                   	push   %eax
  800505:	e8 f3 01 00 00       	call   8006fd <vcprintf>
  80050a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80050d:	83 ec 08             	sub    $0x8,%esp
  800510:	6a 00                	push   $0x0
  800512:	68 01 22 80 00       	push   $0x802201
  800517:	e8 e1 01 00 00       	call   8006fd <vcprintf>
  80051c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80051f:	e8 82 ff ff ff       	call   8004a6 <exit>

	// should not return here
	while (1) ;
  800524:	eb fe                	jmp    800524 <_panic+0x70>

00800526 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800526:	55                   	push   %ebp
  800527:	89 e5                	mov    %esp,%ebp
  800529:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80052c:	a1 20 30 80 00       	mov    0x803020,%eax
  800531:	8b 50 74             	mov    0x74(%eax),%edx
  800534:	8b 45 0c             	mov    0xc(%ebp),%eax
  800537:	39 c2                	cmp    %eax,%edx
  800539:	74 14                	je     80054f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80053b:	83 ec 04             	sub    $0x4,%esp
  80053e:	68 04 22 80 00       	push   $0x802204
  800543:	6a 26                	push   $0x26
  800545:	68 50 22 80 00       	push   $0x802250
  80054a:	e8 65 ff ff ff       	call   8004b4 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80054f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800556:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80055d:	e9 c2 00 00 00       	jmp    800624 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800562:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800565:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056c:	8b 45 08             	mov    0x8(%ebp),%eax
  80056f:	01 d0                	add    %edx,%eax
  800571:	8b 00                	mov    (%eax),%eax
  800573:	85 c0                	test   %eax,%eax
  800575:	75 08                	jne    80057f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800577:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80057a:	e9 a2 00 00 00       	jmp    800621 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80057f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800586:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80058d:	eb 69                	jmp    8005f8 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80058f:	a1 20 30 80 00       	mov    0x803020,%eax
  800594:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80059a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80059d:	89 d0                	mov    %edx,%eax
  80059f:	01 c0                	add    %eax,%eax
  8005a1:	01 d0                	add    %edx,%eax
  8005a3:	c1 e0 02             	shl    $0x2,%eax
  8005a6:	01 c8                	add    %ecx,%eax
  8005a8:	8a 40 04             	mov    0x4(%eax),%al
  8005ab:	84 c0                	test   %al,%al
  8005ad:	75 46                	jne    8005f5 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005af:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8005ba:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005bd:	89 d0                	mov    %edx,%eax
  8005bf:	01 c0                	add    %eax,%eax
  8005c1:	01 d0                	add    %edx,%eax
  8005c3:	c1 e0 02             	shl    $0x2,%eax
  8005c6:	01 c8                	add    %ecx,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005cd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005d5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005da:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e4:	01 c8                	add    %ecx,%eax
  8005e6:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005e8:	39 c2                	cmp    %eax,%edx
  8005ea:	75 09                	jne    8005f5 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8005ec:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005f3:	eb 12                	jmp    800607 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f5:	ff 45 e8             	incl   -0x18(%ebp)
  8005f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fd:	8b 50 74             	mov    0x74(%eax),%edx
  800600:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800603:	39 c2                	cmp    %eax,%edx
  800605:	77 88                	ja     80058f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800607:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80060b:	75 14                	jne    800621 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80060d:	83 ec 04             	sub    $0x4,%esp
  800610:	68 5c 22 80 00       	push   $0x80225c
  800615:	6a 3a                	push   $0x3a
  800617:	68 50 22 80 00       	push   $0x802250
  80061c:	e8 93 fe ff ff       	call   8004b4 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800621:	ff 45 f0             	incl   -0x10(%ebp)
  800624:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800627:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80062a:	0f 8c 32 ff ff ff    	jl     800562 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800630:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800637:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80063e:	eb 26                	jmp    800666 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800640:	a1 20 30 80 00       	mov    0x803020,%eax
  800645:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80064b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80064e:	89 d0                	mov    %edx,%eax
  800650:	01 c0                	add    %eax,%eax
  800652:	01 d0                	add    %edx,%eax
  800654:	c1 e0 02             	shl    $0x2,%eax
  800657:	01 c8                	add    %ecx,%eax
  800659:	8a 40 04             	mov    0x4(%eax),%al
  80065c:	3c 01                	cmp    $0x1,%al
  80065e:	75 03                	jne    800663 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800660:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800663:	ff 45 e0             	incl   -0x20(%ebp)
  800666:	a1 20 30 80 00       	mov    0x803020,%eax
  80066b:	8b 50 74             	mov    0x74(%eax),%edx
  80066e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800671:	39 c2                	cmp    %eax,%edx
  800673:	77 cb                	ja     800640 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800675:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800678:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80067b:	74 14                	je     800691 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80067d:	83 ec 04             	sub    $0x4,%esp
  800680:	68 b0 22 80 00       	push   $0x8022b0
  800685:	6a 44                	push   $0x44
  800687:	68 50 22 80 00       	push   $0x802250
  80068c:	e8 23 fe ff ff       	call   8004b4 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800691:	90                   	nop
  800692:	c9                   	leave  
  800693:	c3                   	ret    

00800694 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800694:	55                   	push   %ebp
  800695:	89 e5                	mov    %esp,%ebp
  800697:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80069a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80069d:	8b 00                	mov    (%eax),%eax
  80069f:	8d 48 01             	lea    0x1(%eax),%ecx
  8006a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a5:	89 0a                	mov    %ecx,(%edx)
  8006a7:	8b 55 08             	mov    0x8(%ebp),%edx
  8006aa:	88 d1                	mov    %dl,%cl
  8006ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006af:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006b6:	8b 00                	mov    (%eax),%eax
  8006b8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006bd:	75 2c                	jne    8006eb <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006bf:	a0 24 30 80 00       	mov    0x803024,%al
  8006c4:	0f b6 c0             	movzbl %al,%eax
  8006c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006ca:	8b 12                	mov    (%edx),%edx
  8006cc:	89 d1                	mov    %edx,%ecx
  8006ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006d1:	83 c2 08             	add    $0x8,%edx
  8006d4:	83 ec 04             	sub    $0x4,%esp
  8006d7:	50                   	push   %eax
  8006d8:	51                   	push   %ecx
  8006d9:	52                   	push   %edx
  8006da:	e8 7a 11 00 00       	call   801859 <sys_cputs>
  8006df:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ee:	8b 40 04             	mov    0x4(%eax),%eax
  8006f1:	8d 50 01             	lea    0x1(%eax),%edx
  8006f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f7:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006fa:	90                   	nop
  8006fb:	c9                   	leave  
  8006fc:	c3                   	ret    

008006fd <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006fd:	55                   	push   %ebp
  8006fe:	89 e5                	mov    %esp,%ebp
  800700:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800706:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80070d:	00 00 00 
	b.cnt = 0;
  800710:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800717:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80071a:	ff 75 0c             	pushl  0xc(%ebp)
  80071d:	ff 75 08             	pushl  0x8(%ebp)
  800720:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800726:	50                   	push   %eax
  800727:	68 94 06 80 00       	push   $0x800694
  80072c:	e8 11 02 00 00       	call   800942 <vprintfmt>
  800731:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800734:	a0 24 30 80 00       	mov    0x803024,%al
  800739:	0f b6 c0             	movzbl %al,%eax
  80073c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800742:	83 ec 04             	sub    $0x4,%esp
  800745:	50                   	push   %eax
  800746:	52                   	push   %edx
  800747:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80074d:	83 c0 08             	add    $0x8,%eax
  800750:	50                   	push   %eax
  800751:	e8 03 11 00 00       	call   801859 <sys_cputs>
  800756:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800759:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800760:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800766:	c9                   	leave  
  800767:	c3                   	ret    

00800768 <cprintf>:

int cprintf(const char *fmt, ...) {
  800768:	55                   	push   %ebp
  800769:	89 e5                	mov    %esp,%ebp
  80076b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80076e:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800775:	8d 45 0c             	lea    0xc(%ebp),%eax
  800778:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80077b:	8b 45 08             	mov    0x8(%ebp),%eax
  80077e:	83 ec 08             	sub    $0x8,%esp
  800781:	ff 75 f4             	pushl  -0xc(%ebp)
  800784:	50                   	push   %eax
  800785:	e8 73 ff ff ff       	call   8006fd <vcprintf>
  80078a:	83 c4 10             	add    $0x10,%esp
  80078d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800790:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800793:	c9                   	leave  
  800794:	c3                   	ret    

00800795 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800795:	55                   	push   %ebp
  800796:	89 e5                	mov    %esp,%ebp
  800798:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80079b:	e8 ca 12 00 00       	call   801a6a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8007a0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a9:	83 ec 08             	sub    $0x8,%esp
  8007ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8007af:	50                   	push   %eax
  8007b0:	e8 48 ff ff ff       	call   8006fd <vcprintf>
  8007b5:	83 c4 10             	add    $0x10,%esp
  8007b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007bb:	e8 c4 12 00 00       	call   801a84 <sys_enable_interrupt>
	return cnt;
  8007c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007c3:	c9                   	leave  
  8007c4:	c3                   	ret    

008007c5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007c5:	55                   	push   %ebp
  8007c6:	89 e5                	mov    %esp,%ebp
  8007c8:	53                   	push   %ebx
  8007c9:	83 ec 14             	sub    $0x14,%esp
  8007cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8007cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007d8:	8b 45 18             	mov    0x18(%ebp),%eax
  8007db:	ba 00 00 00 00       	mov    $0x0,%edx
  8007e0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007e3:	77 55                	ja     80083a <printnum+0x75>
  8007e5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007e8:	72 05                	jb     8007ef <printnum+0x2a>
  8007ea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007ed:	77 4b                	ja     80083a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007ef:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007f2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007f5:	8b 45 18             	mov    0x18(%ebp),%eax
  8007f8:	ba 00 00 00 00       	mov    $0x0,%edx
  8007fd:	52                   	push   %edx
  8007fe:	50                   	push   %eax
  8007ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800802:	ff 75 f0             	pushl  -0x10(%ebp)
  800805:	e8 3e 16 00 00       	call   801e48 <__udivdi3>
  80080a:	83 c4 10             	add    $0x10,%esp
  80080d:	83 ec 04             	sub    $0x4,%esp
  800810:	ff 75 20             	pushl  0x20(%ebp)
  800813:	53                   	push   %ebx
  800814:	ff 75 18             	pushl  0x18(%ebp)
  800817:	52                   	push   %edx
  800818:	50                   	push   %eax
  800819:	ff 75 0c             	pushl  0xc(%ebp)
  80081c:	ff 75 08             	pushl  0x8(%ebp)
  80081f:	e8 a1 ff ff ff       	call   8007c5 <printnum>
  800824:	83 c4 20             	add    $0x20,%esp
  800827:	eb 1a                	jmp    800843 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800829:	83 ec 08             	sub    $0x8,%esp
  80082c:	ff 75 0c             	pushl  0xc(%ebp)
  80082f:	ff 75 20             	pushl  0x20(%ebp)
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	ff d0                	call   *%eax
  800837:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80083a:	ff 4d 1c             	decl   0x1c(%ebp)
  80083d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800841:	7f e6                	jg     800829 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800843:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800846:	bb 00 00 00 00       	mov    $0x0,%ebx
  80084b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80084e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800851:	53                   	push   %ebx
  800852:	51                   	push   %ecx
  800853:	52                   	push   %edx
  800854:	50                   	push   %eax
  800855:	e8 fe 16 00 00       	call   801f58 <__umoddi3>
  80085a:	83 c4 10             	add    $0x10,%esp
  80085d:	05 14 25 80 00       	add    $0x802514,%eax
  800862:	8a 00                	mov    (%eax),%al
  800864:	0f be c0             	movsbl %al,%eax
  800867:	83 ec 08             	sub    $0x8,%esp
  80086a:	ff 75 0c             	pushl  0xc(%ebp)
  80086d:	50                   	push   %eax
  80086e:	8b 45 08             	mov    0x8(%ebp),%eax
  800871:	ff d0                	call   *%eax
  800873:	83 c4 10             	add    $0x10,%esp
}
  800876:	90                   	nop
  800877:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80087a:	c9                   	leave  
  80087b:	c3                   	ret    

0080087c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80087c:	55                   	push   %ebp
  80087d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80087f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800883:	7e 1c                	jle    8008a1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800885:	8b 45 08             	mov    0x8(%ebp),%eax
  800888:	8b 00                	mov    (%eax),%eax
  80088a:	8d 50 08             	lea    0x8(%eax),%edx
  80088d:	8b 45 08             	mov    0x8(%ebp),%eax
  800890:	89 10                	mov    %edx,(%eax)
  800892:	8b 45 08             	mov    0x8(%ebp),%eax
  800895:	8b 00                	mov    (%eax),%eax
  800897:	83 e8 08             	sub    $0x8,%eax
  80089a:	8b 50 04             	mov    0x4(%eax),%edx
  80089d:	8b 00                	mov    (%eax),%eax
  80089f:	eb 40                	jmp    8008e1 <getuint+0x65>
	else if (lflag)
  8008a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008a5:	74 1e                	je     8008c5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8008a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008aa:	8b 00                	mov    (%eax),%eax
  8008ac:	8d 50 04             	lea    0x4(%eax),%edx
  8008af:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b2:	89 10                	mov    %edx,(%eax)
  8008b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b7:	8b 00                	mov    (%eax),%eax
  8008b9:	83 e8 04             	sub    $0x4,%eax
  8008bc:	8b 00                	mov    (%eax),%eax
  8008be:	ba 00 00 00 00       	mov    $0x0,%edx
  8008c3:	eb 1c                	jmp    8008e1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	8b 00                	mov    (%eax),%eax
  8008ca:	8d 50 04             	lea    0x4(%eax),%edx
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	89 10                	mov    %edx,(%eax)
  8008d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d5:	8b 00                	mov    (%eax),%eax
  8008d7:	83 e8 04             	sub    $0x4,%eax
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008e1:	5d                   	pop    %ebp
  8008e2:	c3                   	ret    

008008e3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008e3:	55                   	push   %ebp
  8008e4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008e6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008ea:	7e 1c                	jle    800908 <getint+0x25>
		return va_arg(*ap, long long);
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	8b 00                	mov    (%eax),%eax
  8008f1:	8d 50 08             	lea    0x8(%eax),%edx
  8008f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f7:	89 10                	mov    %edx,(%eax)
  8008f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fc:	8b 00                	mov    (%eax),%eax
  8008fe:	83 e8 08             	sub    $0x8,%eax
  800901:	8b 50 04             	mov    0x4(%eax),%edx
  800904:	8b 00                	mov    (%eax),%eax
  800906:	eb 38                	jmp    800940 <getint+0x5d>
	else if (lflag)
  800908:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80090c:	74 1a                	je     800928 <getint+0x45>
		return va_arg(*ap, long);
  80090e:	8b 45 08             	mov    0x8(%ebp),%eax
  800911:	8b 00                	mov    (%eax),%eax
  800913:	8d 50 04             	lea    0x4(%eax),%edx
  800916:	8b 45 08             	mov    0x8(%ebp),%eax
  800919:	89 10                	mov    %edx,(%eax)
  80091b:	8b 45 08             	mov    0x8(%ebp),%eax
  80091e:	8b 00                	mov    (%eax),%eax
  800920:	83 e8 04             	sub    $0x4,%eax
  800923:	8b 00                	mov    (%eax),%eax
  800925:	99                   	cltd   
  800926:	eb 18                	jmp    800940 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800928:	8b 45 08             	mov    0x8(%ebp),%eax
  80092b:	8b 00                	mov    (%eax),%eax
  80092d:	8d 50 04             	lea    0x4(%eax),%edx
  800930:	8b 45 08             	mov    0x8(%ebp),%eax
  800933:	89 10                	mov    %edx,(%eax)
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	8b 00                	mov    (%eax),%eax
  80093a:	83 e8 04             	sub    $0x4,%eax
  80093d:	8b 00                	mov    (%eax),%eax
  80093f:	99                   	cltd   
}
  800940:	5d                   	pop    %ebp
  800941:	c3                   	ret    

00800942 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800942:	55                   	push   %ebp
  800943:	89 e5                	mov    %esp,%ebp
  800945:	56                   	push   %esi
  800946:	53                   	push   %ebx
  800947:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80094a:	eb 17                	jmp    800963 <vprintfmt+0x21>
			if (ch == '\0')
  80094c:	85 db                	test   %ebx,%ebx
  80094e:	0f 84 af 03 00 00    	je     800d03 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800954:	83 ec 08             	sub    $0x8,%esp
  800957:	ff 75 0c             	pushl  0xc(%ebp)
  80095a:	53                   	push   %ebx
  80095b:	8b 45 08             	mov    0x8(%ebp),%eax
  80095e:	ff d0                	call   *%eax
  800960:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800963:	8b 45 10             	mov    0x10(%ebp),%eax
  800966:	8d 50 01             	lea    0x1(%eax),%edx
  800969:	89 55 10             	mov    %edx,0x10(%ebp)
  80096c:	8a 00                	mov    (%eax),%al
  80096e:	0f b6 d8             	movzbl %al,%ebx
  800971:	83 fb 25             	cmp    $0x25,%ebx
  800974:	75 d6                	jne    80094c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800976:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80097a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800981:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800988:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80098f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800996:	8b 45 10             	mov    0x10(%ebp),%eax
  800999:	8d 50 01             	lea    0x1(%eax),%edx
  80099c:	89 55 10             	mov    %edx,0x10(%ebp)
  80099f:	8a 00                	mov    (%eax),%al
  8009a1:	0f b6 d8             	movzbl %al,%ebx
  8009a4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8009a7:	83 f8 55             	cmp    $0x55,%eax
  8009aa:	0f 87 2b 03 00 00    	ja     800cdb <vprintfmt+0x399>
  8009b0:	8b 04 85 38 25 80 00 	mov    0x802538(,%eax,4),%eax
  8009b7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009b9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009bd:	eb d7                	jmp    800996 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009bf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009c3:	eb d1                	jmp    800996 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009c5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009cc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009cf:	89 d0                	mov    %edx,%eax
  8009d1:	c1 e0 02             	shl    $0x2,%eax
  8009d4:	01 d0                	add    %edx,%eax
  8009d6:	01 c0                	add    %eax,%eax
  8009d8:	01 d8                	add    %ebx,%eax
  8009da:	83 e8 30             	sub    $0x30,%eax
  8009dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e3:	8a 00                	mov    (%eax),%al
  8009e5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009e8:	83 fb 2f             	cmp    $0x2f,%ebx
  8009eb:	7e 3e                	jle    800a2b <vprintfmt+0xe9>
  8009ed:	83 fb 39             	cmp    $0x39,%ebx
  8009f0:	7f 39                	jg     800a2b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009f2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009f5:	eb d5                	jmp    8009cc <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fa:	83 c0 04             	add    $0x4,%eax
  8009fd:	89 45 14             	mov    %eax,0x14(%ebp)
  800a00:	8b 45 14             	mov    0x14(%ebp),%eax
  800a03:	83 e8 04             	sub    $0x4,%eax
  800a06:	8b 00                	mov    (%eax),%eax
  800a08:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a0b:	eb 1f                	jmp    800a2c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a0d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a11:	79 83                	jns    800996 <vprintfmt+0x54>
				width = 0;
  800a13:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a1a:	e9 77 ff ff ff       	jmp    800996 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a1f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a26:	e9 6b ff ff ff       	jmp    800996 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a2b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a2c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a30:	0f 89 60 ff ff ff    	jns    800996 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a36:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a39:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a3c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a43:	e9 4e ff ff ff       	jmp    800996 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a48:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a4b:	e9 46 ff ff ff       	jmp    800996 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a50:	8b 45 14             	mov    0x14(%ebp),%eax
  800a53:	83 c0 04             	add    $0x4,%eax
  800a56:	89 45 14             	mov    %eax,0x14(%ebp)
  800a59:	8b 45 14             	mov    0x14(%ebp),%eax
  800a5c:	83 e8 04             	sub    $0x4,%eax
  800a5f:	8b 00                	mov    (%eax),%eax
  800a61:	83 ec 08             	sub    $0x8,%esp
  800a64:	ff 75 0c             	pushl  0xc(%ebp)
  800a67:	50                   	push   %eax
  800a68:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6b:	ff d0                	call   *%eax
  800a6d:	83 c4 10             	add    $0x10,%esp
			break;
  800a70:	e9 89 02 00 00       	jmp    800cfe <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a75:	8b 45 14             	mov    0x14(%ebp),%eax
  800a78:	83 c0 04             	add    $0x4,%eax
  800a7b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a81:	83 e8 04             	sub    $0x4,%eax
  800a84:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a86:	85 db                	test   %ebx,%ebx
  800a88:	79 02                	jns    800a8c <vprintfmt+0x14a>
				err = -err;
  800a8a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a8c:	83 fb 64             	cmp    $0x64,%ebx
  800a8f:	7f 0b                	jg     800a9c <vprintfmt+0x15a>
  800a91:	8b 34 9d 80 23 80 00 	mov    0x802380(,%ebx,4),%esi
  800a98:	85 f6                	test   %esi,%esi
  800a9a:	75 19                	jne    800ab5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a9c:	53                   	push   %ebx
  800a9d:	68 25 25 80 00       	push   $0x802525
  800aa2:	ff 75 0c             	pushl  0xc(%ebp)
  800aa5:	ff 75 08             	pushl  0x8(%ebp)
  800aa8:	e8 5e 02 00 00       	call   800d0b <printfmt>
  800aad:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ab0:	e9 49 02 00 00       	jmp    800cfe <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ab5:	56                   	push   %esi
  800ab6:	68 2e 25 80 00       	push   $0x80252e
  800abb:	ff 75 0c             	pushl  0xc(%ebp)
  800abe:	ff 75 08             	pushl  0x8(%ebp)
  800ac1:	e8 45 02 00 00       	call   800d0b <printfmt>
  800ac6:	83 c4 10             	add    $0x10,%esp
			break;
  800ac9:	e9 30 02 00 00       	jmp    800cfe <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ace:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad1:	83 c0 04             	add    $0x4,%eax
  800ad4:	89 45 14             	mov    %eax,0x14(%ebp)
  800ad7:	8b 45 14             	mov    0x14(%ebp),%eax
  800ada:	83 e8 04             	sub    $0x4,%eax
  800add:	8b 30                	mov    (%eax),%esi
  800adf:	85 f6                	test   %esi,%esi
  800ae1:	75 05                	jne    800ae8 <vprintfmt+0x1a6>
				p = "(null)";
  800ae3:	be 31 25 80 00       	mov    $0x802531,%esi
			if (width > 0 && padc != '-')
  800ae8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aec:	7e 6d                	jle    800b5b <vprintfmt+0x219>
  800aee:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800af2:	74 67                	je     800b5b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800af4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800af7:	83 ec 08             	sub    $0x8,%esp
  800afa:	50                   	push   %eax
  800afb:	56                   	push   %esi
  800afc:	e8 0c 03 00 00       	call   800e0d <strnlen>
  800b01:	83 c4 10             	add    $0x10,%esp
  800b04:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b07:	eb 16                	jmp    800b1f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b09:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b0d:	83 ec 08             	sub    $0x8,%esp
  800b10:	ff 75 0c             	pushl  0xc(%ebp)
  800b13:	50                   	push   %eax
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	ff d0                	call   *%eax
  800b19:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b1c:	ff 4d e4             	decl   -0x1c(%ebp)
  800b1f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b23:	7f e4                	jg     800b09 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b25:	eb 34                	jmp    800b5b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b27:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b2b:	74 1c                	je     800b49 <vprintfmt+0x207>
  800b2d:	83 fb 1f             	cmp    $0x1f,%ebx
  800b30:	7e 05                	jle    800b37 <vprintfmt+0x1f5>
  800b32:	83 fb 7e             	cmp    $0x7e,%ebx
  800b35:	7e 12                	jle    800b49 <vprintfmt+0x207>
					putch('?', putdat);
  800b37:	83 ec 08             	sub    $0x8,%esp
  800b3a:	ff 75 0c             	pushl  0xc(%ebp)
  800b3d:	6a 3f                	push   $0x3f
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	ff d0                	call   *%eax
  800b44:	83 c4 10             	add    $0x10,%esp
  800b47:	eb 0f                	jmp    800b58 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b49:	83 ec 08             	sub    $0x8,%esp
  800b4c:	ff 75 0c             	pushl  0xc(%ebp)
  800b4f:	53                   	push   %ebx
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
  800b53:	ff d0                	call   *%eax
  800b55:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b58:	ff 4d e4             	decl   -0x1c(%ebp)
  800b5b:	89 f0                	mov    %esi,%eax
  800b5d:	8d 70 01             	lea    0x1(%eax),%esi
  800b60:	8a 00                	mov    (%eax),%al
  800b62:	0f be d8             	movsbl %al,%ebx
  800b65:	85 db                	test   %ebx,%ebx
  800b67:	74 24                	je     800b8d <vprintfmt+0x24b>
  800b69:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b6d:	78 b8                	js     800b27 <vprintfmt+0x1e5>
  800b6f:	ff 4d e0             	decl   -0x20(%ebp)
  800b72:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b76:	79 af                	jns    800b27 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b78:	eb 13                	jmp    800b8d <vprintfmt+0x24b>
				putch(' ', putdat);
  800b7a:	83 ec 08             	sub    $0x8,%esp
  800b7d:	ff 75 0c             	pushl  0xc(%ebp)
  800b80:	6a 20                	push   $0x20
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	ff d0                	call   *%eax
  800b87:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b8a:	ff 4d e4             	decl   -0x1c(%ebp)
  800b8d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b91:	7f e7                	jg     800b7a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b93:	e9 66 01 00 00       	jmp    800cfe <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b98:	83 ec 08             	sub    $0x8,%esp
  800b9b:	ff 75 e8             	pushl  -0x18(%ebp)
  800b9e:	8d 45 14             	lea    0x14(%ebp),%eax
  800ba1:	50                   	push   %eax
  800ba2:	e8 3c fd ff ff       	call   8008e3 <getint>
  800ba7:	83 c4 10             	add    $0x10,%esp
  800baa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bad:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800bb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bb3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bb6:	85 d2                	test   %edx,%edx
  800bb8:	79 23                	jns    800bdd <vprintfmt+0x29b>
				putch('-', putdat);
  800bba:	83 ec 08             	sub    $0x8,%esp
  800bbd:	ff 75 0c             	pushl  0xc(%ebp)
  800bc0:	6a 2d                	push   $0x2d
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	ff d0                	call   *%eax
  800bc7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800bca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bcd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bd0:	f7 d8                	neg    %eax
  800bd2:	83 d2 00             	adc    $0x0,%edx
  800bd5:	f7 da                	neg    %edx
  800bd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bda:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bdd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800be4:	e9 bc 00 00 00       	jmp    800ca5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800be9:	83 ec 08             	sub    $0x8,%esp
  800bec:	ff 75 e8             	pushl  -0x18(%ebp)
  800bef:	8d 45 14             	lea    0x14(%ebp),%eax
  800bf2:	50                   	push   %eax
  800bf3:	e8 84 fc ff ff       	call   80087c <getuint>
  800bf8:	83 c4 10             	add    $0x10,%esp
  800bfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bfe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c01:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c08:	e9 98 00 00 00       	jmp    800ca5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c0d:	83 ec 08             	sub    $0x8,%esp
  800c10:	ff 75 0c             	pushl  0xc(%ebp)
  800c13:	6a 58                	push   $0x58
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	ff d0                	call   *%eax
  800c1a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c1d:	83 ec 08             	sub    $0x8,%esp
  800c20:	ff 75 0c             	pushl  0xc(%ebp)
  800c23:	6a 58                	push   $0x58
  800c25:	8b 45 08             	mov    0x8(%ebp),%eax
  800c28:	ff d0                	call   *%eax
  800c2a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c2d:	83 ec 08             	sub    $0x8,%esp
  800c30:	ff 75 0c             	pushl  0xc(%ebp)
  800c33:	6a 58                	push   $0x58
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	ff d0                	call   *%eax
  800c3a:	83 c4 10             	add    $0x10,%esp
			break;
  800c3d:	e9 bc 00 00 00       	jmp    800cfe <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c42:	83 ec 08             	sub    $0x8,%esp
  800c45:	ff 75 0c             	pushl  0xc(%ebp)
  800c48:	6a 30                	push   $0x30
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	ff d0                	call   *%eax
  800c4f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c52:	83 ec 08             	sub    $0x8,%esp
  800c55:	ff 75 0c             	pushl  0xc(%ebp)
  800c58:	6a 78                	push   $0x78
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	ff d0                	call   *%eax
  800c5f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c62:	8b 45 14             	mov    0x14(%ebp),%eax
  800c65:	83 c0 04             	add    $0x4,%eax
  800c68:	89 45 14             	mov    %eax,0x14(%ebp)
  800c6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6e:	83 e8 04             	sub    $0x4,%eax
  800c71:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c76:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c7d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c84:	eb 1f                	jmp    800ca5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c86:	83 ec 08             	sub    $0x8,%esp
  800c89:	ff 75 e8             	pushl  -0x18(%ebp)
  800c8c:	8d 45 14             	lea    0x14(%ebp),%eax
  800c8f:	50                   	push   %eax
  800c90:	e8 e7 fb ff ff       	call   80087c <getuint>
  800c95:	83 c4 10             	add    $0x10,%esp
  800c98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c9b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c9e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ca5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ca9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cac:	83 ec 04             	sub    $0x4,%esp
  800caf:	52                   	push   %edx
  800cb0:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cb3:	50                   	push   %eax
  800cb4:	ff 75 f4             	pushl  -0xc(%ebp)
  800cb7:	ff 75 f0             	pushl  -0x10(%ebp)
  800cba:	ff 75 0c             	pushl  0xc(%ebp)
  800cbd:	ff 75 08             	pushl  0x8(%ebp)
  800cc0:	e8 00 fb ff ff       	call   8007c5 <printnum>
  800cc5:	83 c4 20             	add    $0x20,%esp
			break;
  800cc8:	eb 34                	jmp    800cfe <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800cca:	83 ec 08             	sub    $0x8,%esp
  800ccd:	ff 75 0c             	pushl  0xc(%ebp)
  800cd0:	53                   	push   %ebx
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	ff d0                	call   *%eax
  800cd6:	83 c4 10             	add    $0x10,%esp
			break;
  800cd9:	eb 23                	jmp    800cfe <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cdb:	83 ec 08             	sub    $0x8,%esp
  800cde:	ff 75 0c             	pushl  0xc(%ebp)
  800ce1:	6a 25                	push   $0x25
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	ff d0                	call   *%eax
  800ce8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ceb:	ff 4d 10             	decl   0x10(%ebp)
  800cee:	eb 03                	jmp    800cf3 <vprintfmt+0x3b1>
  800cf0:	ff 4d 10             	decl   0x10(%ebp)
  800cf3:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf6:	48                   	dec    %eax
  800cf7:	8a 00                	mov    (%eax),%al
  800cf9:	3c 25                	cmp    $0x25,%al
  800cfb:	75 f3                	jne    800cf0 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cfd:	90                   	nop
		}
	}
  800cfe:	e9 47 fc ff ff       	jmp    80094a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d03:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d04:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d07:	5b                   	pop    %ebx
  800d08:	5e                   	pop    %esi
  800d09:	5d                   	pop    %ebp
  800d0a:	c3                   	ret    

00800d0b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d0b:	55                   	push   %ebp
  800d0c:	89 e5                	mov    %esp,%ebp
  800d0e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d11:	8d 45 10             	lea    0x10(%ebp),%eax
  800d14:	83 c0 04             	add    $0x4,%eax
  800d17:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d1d:	ff 75 f4             	pushl  -0xc(%ebp)
  800d20:	50                   	push   %eax
  800d21:	ff 75 0c             	pushl  0xc(%ebp)
  800d24:	ff 75 08             	pushl  0x8(%ebp)
  800d27:	e8 16 fc ff ff       	call   800942 <vprintfmt>
  800d2c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d2f:	90                   	nop
  800d30:	c9                   	leave  
  800d31:	c3                   	ret    

00800d32 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d32:	55                   	push   %ebp
  800d33:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d38:	8b 40 08             	mov    0x8(%eax),%eax
  800d3b:	8d 50 01             	lea    0x1(%eax),%edx
  800d3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d41:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d47:	8b 10                	mov    (%eax),%edx
  800d49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4c:	8b 40 04             	mov    0x4(%eax),%eax
  800d4f:	39 c2                	cmp    %eax,%edx
  800d51:	73 12                	jae    800d65 <sprintputch+0x33>
		*b->buf++ = ch;
  800d53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d56:	8b 00                	mov    (%eax),%eax
  800d58:	8d 48 01             	lea    0x1(%eax),%ecx
  800d5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d5e:	89 0a                	mov    %ecx,(%edx)
  800d60:	8b 55 08             	mov    0x8(%ebp),%edx
  800d63:	88 10                	mov    %dl,(%eax)
}
  800d65:	90                   	nop
  800d66:	5d                   	pop    %ebp
  800d67:	c3                   	ret    

00800d68 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d68:	55                   	push   %ebp
  800d69:	89 e5                	mov    %esp,%ebp
  800d6b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d77:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	01 d0                	add    %edx,%eax
  800d7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d89:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d8d:	74 06                	je     800d95 <vsnprintf+0x2d>
  800d8f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d93:	7f 07                	jg     800d9c <vsnprintf+0x34>
		return -E_INVAL;
  800d95:	b8 03 00 00 00       	mov    $0x3,%eax
  800d9a:	eb 20                	jmp    800dbc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d9c:	ff 75 14             	pushl  0x14(%ebp)
  800d9f:	ff 75 10             	pushl  0x10(%ebp)
  800da2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800da5:	50                   	push   %eax
  800da6:	68 32 0d 80 00       	push   $0x800d32
  800dab:	e8 92 fb ff ff       	call   800942 <vprintfmt>
  800db0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800db3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800db6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800db9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800dbc:	c9                   	leave  
  800dbd:	c3                   	ret    

00800dbe <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800dbe:	55                   	push   %ebp
  800dbf:	89 e5                	mov    %esp,%ebp
  800dc1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800dc4:	8d 45 10             	lea    0x10(%ebp),%eax
  800dc7:	83 c0 04             	add    $0x4,%eax
  800dca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800dcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd0:	ff 75 f4             	pushl  -0xc(%ebp)
  800dd3:	50                   	push   %eax
  800dd4:	ff 75 0c             	pushl  0xc(%ebp)
  800dd7:	ff 75 08             	pushl  0x8(%ebp)
  800dda:	e8 89 ff ff ff       	call   800d68 <vsnprintf>
  800ddf:	83 c4 10             	add    $0x10,%esp
  800de2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800de5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800de8:	c9                   	leave  
  800de9:	c3                   	ret    

00800dea <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800dea:	55                   	push   %ebp
  800deb:	89 e5                	mov    %esp,%ebp
  800ded:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800df0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800df7:	eb 06                	jmp    800dff <strlen+0x15>
		n++;
  800df9:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dfc:	ff 45 08             	incl   0x8(%ebp)
  800dff:	8b 45 08             	mov    0x8(%ebp),%eax
  800e02:	8a 00                	mov    (%eax),%al
  800e04:	84 c0                	test   %al,%al
  800e06:	75 f1                	jne    800df9 <strlen+0xf>
		n++;
	return n;
  800e08:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e0b:	c9                   	leave  
  800e0c:	c3                   	ret    

00800e0d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e0d:	55                   	push   %ebp
  800e0e:	89 e5                	mov    %esp,%ebp
  800e10:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e1a:	eb 09                	jmp    800e25 <strnlen+0x18>
		n++;
  800e1c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e1f:	ff 45 08             	incl   0x8(%ebp)
  800e22:	ff 4d 0c             	decl   0xc(%ebp)
  800e25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e29:	74 09                	je     800e34 <strnlen+0x27>
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	8a 00                	mov    (%eax),%al
  800e30:	84 c0                	test   %al,%al
  800e32:	75 e8                	jne    800e1c <strnlen+0xf>
		n++;
	return n;
  800e34:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e37:	c9                   	leave  
  800e38:	c3                   	ret    

00800e39 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e39:	55                   	push   %ebp
  800e3a:	89 e5                	mov    %esp,%ebp
  800e3c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e45:	90                   	nop
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
  800e49:	8d 50 01             	lea    0x1(%eax),%edx
  800e4c:	89 55 08             	mov    %edx,0x8(%ebp)
  800e4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e52:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e55:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e58:	8a 12                	mov    (%edx),%dl
  800e5a:	88 10                	mov    %dl,(%eax)
  800e5c:	8a 00                	mov    (%eax),%al
  800e5e:	84 c0                	test   %al,%al
  800e60:	75 e4                	jne    800e46 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e62:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e65:	c9                   	leave  
  800e66:	c3                   	ret    

00800e67 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e67:	55                   	push   %ebp
  800e68:	89 e5                	mov    %esp,%ebp
  800e6a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e7a:	eb 1f                	jmp    800e9b <strncpy+0x34>
		*dst++ = *src;
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	8d 50 01             	lea    0x1(%eax),%edx
  800e82:	89 55 08             	mov    %edx,0x8(%ebp)
  800e85:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e88:	8a 12                	mov    (%edx),%dl
  800e8a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8f:	8a 00                	mov    (%eax),%al
  800e91:	84 c0                	test   %al,%al
  800e93:	74 03                	je     800e98 <strncpy+0x31>
			src++;
  800e95:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e98:	ff 45 fc             	incl   -0x4(%ebp)
  800e9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e9e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ea1:	72 d9                	jb     800e7c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ea3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ea6:	c9                   	leave  
  800ea7:	c3                   	ret    

00800ea8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ea8:	55                   	push   %ebp
  800ea9:	89 e5                	mov    %esp,%ebp
  800eab:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800eb4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eb8:	74 30                	je     800eea <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800eba:	eb 16                	jmp    800ed2 <strlcpy+0x2a>
			*dst++ = *src++;
  800ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebf:	8d 50 01             	lea    0x1(%eax),%edx
  800ec2:	89 55 08             	mov    %edx,0x8(%ebp)
  800ec5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ec8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ecb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ece:	8a 12                	mov    (%edx),%dl
  800ed0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ed2:	ff 4d 10             	decl   0x10(%ebp)
  800ed5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed9:	74 09                	je     800ee4 <strlcpy+0x3c>
  800edb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ede:	8a 00                	mov    (%eax),%al
  800ee0:	84 c0                	test   %al,%al
  800ee2:	75 d8                	jne    800ebc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800eea:	8b 55 08             	mov    0x8(%ebp),%edx
  800eed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef0:	29 c2                	sub    %eax,%edx
  800ef2:	89 d0                	mov    %edx,%eax
}
  800ef4:	c9                   	leave  
  800ef5:	c3                   	ret    

00800ef6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ef6:	55                   	push   %ebp
  800ef7:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ef9:	eb 06                	jmp    800f01 <strcmp+0xb>
		p++, q++;
  800efb:	ff 45 08             	incl   0x8(%ebp)
  800efe:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	8a 00                	mov    (%eax),%al
  800f06:	84 c0                	test   %al,%al
  800f08:	74 0e                	je     800f18 <strcmp+0x22>
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8a 10                	mov    (%eax),%dl
  800f0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	38 c2                	cmp    %al,%dl
  800f16:	74 e3                	je     800efb <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	0f b6 d0             	movzbl %al,%edx
  800f20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f23:	8a 00                	mov    (%eax),%al
  800f25:	0f b6 c0             	movzbl %al,%eax
  800f28:	29 c2                	sub    %eax,%edx
  800f2a:	89 d0                	mov    %edx,%eax
}
  800f2c:	5d                   	pop    %ebp
  800f2d:	c3                   	ret    

00800f2e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f31:	eb 09                	jmp    800f3c <strncmp+0xe>
		n--, p++, q++;
  800f33:	ff 4d 10             	decl   0x10(%ebp)
  800f36:	ff 45 08             	incl   0x8(%ebp)
  800f39:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f3c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f40:	74 17                	je     800f59 <strncmp+0x2b>
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	8a 00                	mov    (%eax),%al
  800f47:	84 c0                	test   %al,%al
  800f49:	74 0e                	je     800f59 <strncmp+0x2b>
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4e:	8a 10                	mov    (%eax),%dl
  800f50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	38 c2                	cmp    %al,%dl
  800f57:	74 da                	je     800f33 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5d:	75 07                	jne    800f66 <strncmp+0x38>
		return 0;
  800f5f:	b8 00 00 00 00       	mov    $0x0,%eax
  800f64:	eb 14                	jmp    800f7a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
  800f69:	8a 00                	mov    (%eax),%al
  800f6b:	0f b6 d0             	movzbl %al,%edx
  800f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	0f b6 c0             	movzbl %al,%eax
  800f76:	29 c2                	sub    %eax,%edx
  800f78:	89 d0                	mov    %edx,%eax
}
  800f7a:	5d                   	pop    %ebp
  800f7b:	c3                   	ret    

00800f7c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f7c:	55                   	push   %ebp
  800f7d:	89 e5                	mov    %esp,%ebp
  800f7f:	83 ec 04             	sub    $0x4,%esp
  800f82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f85:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f88:	eb 12                	jmp    800f9c <strchr+0x20>
		if (*s == c)
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f92:	75 05                	jne    800f99 <strchr+0x1d>
			return (char *) s;
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	eb 11                	jmp    800faa <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f99:	ff 45 08             	incl   0x8(%ebp)
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	84 c0                	test   %al,%al
  800fa3:	75 e5                	jne    800f8a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fa5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800faa:	c9                   	leave  
  800fab:	c3                   	ret    

00800fac <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fac:	55                   	push   %ebp
  800fad:	89 e5                	mov    %esp,%ebp
  800faf:	83 ec 04             	sub    $0x4,%esp
  800fb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fb8:	eb 0d                	jmp    800fc7 <strfind+0x1b>
		if (*s == c)
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	8a 00                	mov    (%eax),%al
  800fbf:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fc2:	74 0e                	je     800fd2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fc4:	ff 45 08             	incl   0x8(%ebp)
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	84 c0                	test   %al,%al
  800fce:	75 ea                	jne    800fba <strfind+0xe>
  800fd0:	eb 01                	jmp    800fd3 <strfind+0x27>
		if (*s == c)
			break;
  800fd2:	90                   	nop
	return (char *) s;
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fd6:	c9                   	leave  
  800fd7:	c3                   	ret    

00800fd8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fd8:	55                   	push   %ebp
  800fd9:	89 e5                	mov    %esp,%ebp
  800fdb:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fe4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fea:	eb 0e                	jmp    800ffa <memset+0x22>
		*p++ = c;
  800fec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fef:	8d 50 01             	lea    0x1(%eax),%edx
  800ff2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ff5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ff8:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ffa:	ff 4d f8             	decl   -0x8(%ebp)
  800ffd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801001:	79 e9                	jns    800fec <memset+0x14>
		*p++ = c;

	return v;
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801006:	c9                   	leave  
  801007:	c3                   	ret    

00801008 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801008:	55                   	push   %ebp
  801009:	89 e5                	mov    %esp,%ebp
  80100b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80100e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801011:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801014:	8b 45 08             	mov    0x8(%ebp),%eax
  801017:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80101a:	eb 16                	jmp    801032 <memcpy+0x2a>
		*d++ = *s++;
  80101c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101f:	8d 50 01             	lea    0x1(%eax),%edx
  801022:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801025:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801028:	8d 4a 01             	lea    0x1(%edx),%ecx
  80102b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80102e:	8a 12                	mov    (%edx),%dl
  801030:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801032:	8b 45 10             	mov    0x10(%ebp),%eax
  801035:	8d 50 ff             	lea    -0x1(%eax),%edx
  801038:	89 55 10             	mov    %edx,0x10(%ebp)
  80103b:	85 c0                	test   %eax,%eax
  80103d:	75 dd                	jne    80101c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801042:	c9                   	leave  
  801043:	c3                   	ret    

00801044 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801044:	55                   	push   %ebp
  801045:	89 e5                	mov    %esp,%ebp
  801047:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80104a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801050:	8b 45 08             	mov    0x8(%ebp),%eax
  801053:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801056:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801059:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80105c:	73 50                	jae    8010ae <memmove+0x6a>
  80105e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801061:	8b 45 10             	mov    0x10(%ebp),%eax
  801064:	01 d0                	add    %edx,%eax
  801066:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801069:	76 43                	jbe    8010ae <memmove+0x6a>
		s += n;
  80106b:	8b 45 10             	mov    0x10(%ebp),%eax
  80106e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801071:	8b 45 10             	mov    0x10(%ebp),%eax
  801074:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801077:	eb 10                	jmp    801089 <memmove+0x45>
			*--d = *--s;
  801079:	ff 4d f8             	decl   -0x8(%ebp)
  80107c:	ff 4d fc             	decl   -0x4(%ebp)
  80107f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801082:	8a 10                	mov    (%eax),%dl
  801084:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801087:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801089:	8b 45 10             	mov    0x10(%ebp),%eax
  80108c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80108f:	89 55 10             	mov    %edx,0x10(%ebp)
  801092:	85 c0                	test   %eax,%eax
  801094:	75 e3                	jne    801079 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801096:	eb 23                	jmp    8010bb <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801098:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109b:	8d 50 01             	lea    0x1(%eax),%edx
  80109e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010a4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010aa:	8a 12                	mov    (%edx),%dl
  8010ac:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010b4:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b7:	85 c0                	test   %eax,%eax
  8010b9:	75 dd                	jne    801098 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010be:	c9                   	leave  
  8010bf:	c3                   	ret    

008010c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
  8010c3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cf:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010d2:	eb 2a                	jmp    8010fe <memcmp+0x3e>
		if (*s1 != *s2)
  8010d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d7:	8a 10                	mov    (%eax),%dl
  8010d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010dc:	8a 00                	mov    (%eax),%al
  8010de:	38 c2                	cmp    %al,%dl
  8010e0:	74 16                	je     8010f8 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e5:	8a 00                	mov    (%eax),%al
  8010e7:	0f b6 d0             	movzbl %al,%edx
  8010ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	0f b6 c0             	movzbl %al,%eax
  8010f2:	29 c2                	sub    %eax,%edx
  8010f4:	89 d0                	mov    %edx,%eax
  8010f6:	eb 18                	jmp    801110 <memcmp+0x50>
		s1++, s2++;
  8010f8:	ff 45 fc             	incl   -0x4(%ebp)
  8010fb:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801101:	8d 50 ff             	lea    -0x1(%eax),%edx
  801104:	89 55 10             	mov    %edx,0x10(%ebp)
  801107:	85 c0                	test   %eax,%eax
  801109:	75 c9                	jne    8010d4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80110b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801110:	c9                   	leave  
  801111:	c3                   	ret    

00801112 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801112:	55                   	push   %ebp
  801113:	89 e5                	mov    %esp,%ebp
  801115:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801118:	8b 55 08             	mov    0x8(%ebp),%edx
  80111b:	8b 45 10             	mov    0x10(%ebp),%eax
  80111e:	01 d0                	add    %edx,%eax
  801120:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801123:	eb 15                	jmp    80113a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801125:	8b 45 08             	mov    0x8(%ebp),%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	0f b6 d0             	movzbl %al,%edx
  80112d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801130:	0f b6 c0             	movzbl %al,%eax
  801133:	39 c2                	cmp    %eax,%edx
  801135:	74 0d                	je     801144 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801137:	ff 45 08             	incl   0x8(%ebp)
  80113a:	8b 45 08             	mov    0x8(%ebp),%eax
  80113d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801140:	72 e3                	jb     801125 <memfind+0x13>
  801142:	eb 01                	jmp    801145 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801144:	90                   	nop
	return (void *) s;
  801145:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801148:	c9                   	leave  
  801149:	c3                   	ret    

0080114a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80114a:	55                   	push   %ebp
  80114b:	89 e5                	mov    %esp,%ebp
  80114d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801150:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801157:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80115e:	eb 03                	jmp    801163 <strtol+0x19>
		s++;
  801160:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
  801166:	8a 00                	mov    (%eax),%al
  801168:	3c 20                	cmp    $0x20,%al
  80116a:	74 f4                	je     801160 <strtol+0x16>
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	8a 00                	mov    (%eax),%al
  801171:	3c 09                	cmp    $0x9,%al
  801173:	74 eb                	je     801160 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	8a 00                	mov    (%eax),%al
  80117a:	3c 2b                	cmp    $0x2b,%al
  80117c:	75 05                	jne    801183 <strtol+0x39>
		s++;
  80117e:	ff 45 08             	incl   0x8(%ebp)
  801181:	eb 13                	jmp    801196 <strtol+0x4c>
	else if (*s == '-')
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	3c 2d                	cmp    $0x2d,%al
  80118a:	75 0a                	jne    801196 <strtol+0x4c>
		s++, neg = 1;
  80118c:	ff 45 08             	incl   0x8(%ebp)
  80118f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801196:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80119a:	74 06                	je     8011a2 <strtol+0x58>
  80119c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011a0:	75 20                	jne    8011c2 <strtol+0x78>
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	8a 00                	mov    (%eax),%al
  8011a7:	3c 30                	cmp    $0x30,%al
  8011a9:	75 17                	jne    8011c2 <strtol+0x78>
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	40                   	inc    %eax
  8011af:	8a 00                	mov    (%eax),%al
  8011b1:	3c 78                	cmp    $0x78,%al
  8011b3:	75 0d                	jne    8011c2 <strtol+0x78>
		s += 2, base = 16;
  8011b5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011b9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011c0:	eb 28                	jmp    8011ea <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011c6:	75 15                	jne    8011dd <strtol+0x93>
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cb:	8a 00                	mov    (%eax),%al
  8011cd:	3c 30                	cmp    $0x30,%al
  8011cf:	75 0c                	jne    8011dd <strtol+0x93>
		s++, base = 8;
  8011d1:	ff 45 08             	incl   0x8(%ebp)
  8011d4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011db:	eb 0d                	jmp    8011ea <strtol+0xa0>
	else if (base == 0)
  8011dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011e1:	75 07                	jne    8011ea <strtol+0xa0>
		base = 10;
  8011e3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	8a 00                	mov    (%eax),%al
  8011ef:	3c 2f                	cmp    $0x2f,%al
  8011f1:	7e 19                	jle    80120c <strtol+0xc2>
  8011f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f6:	8a 00                	mov    (%eax),%al
  8011f8:	3c 39                	cmp    $0x39,%al
  8011fa:	7f 10                	jg     80120c <strtol+0xc2>
			dig = *s - '0';
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	8a 00                	mov    (%eax),%al
  801201:	0f be c0             	movsbl %al,%eax
  801204:	83 e8 30             	sub    $0x30,%eax
  801207:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80120a:	eb 42                	jmp    80124e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	8a 00                	mov    (%eax),%al
  801211:	3c 60                	cmp    $0x60,%al
  801213:	7e 19                	jle    80122e <strtol+0xe4>
  801215:	8b 45 08             	mov    0x8(%ebp),%eax
  801218:	8a 00                	mov    (%eax),%al
  80121a:	3c 7a                	cmp    $0x7a,%al
  80121c:	7f 10                	jg     80122e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80121e:	8b 45 08             	mov    0x8(%ebp),%eax
  801221:	8a 00                	mov    (%eax),%al
  801223:	0f be c0             	movsbl %al,%eax
  801226:	83 e8 57             	sub    $0x57,%eax
  801229:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80122c:	eb 20                	jmp    80124e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8a 00                	mov    (%eax),%al
  801233:	3c 40                	cmp    $0x40,%al
  801235:	7e 39                	jle    801270 <strtol+0x126>
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	8a 00                	mov    (%eax),%al
  80123c:	3c 5a                	cmp    $0x5a,%al
  80123e:	7f 30                	jg     801270 <strtol+0x126>
			dig = *s - 'A' + 10;
  801240:	8b 45 08             	mov    0x8(%ebp),%eax
  801243:	8a 00                	mov    (%eax),%al
  801245:	0f be c0             	movsbl %al,%eax
  801248:	83 e8 37             	sub    $0x37,%eax
  80124b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80124e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801251:	3b 45 10             	cmp    0x10(%ebp),%eax
  801254:	7d 19                	jge    80126f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801256:	ff 45 08             	incl   0x8(%ebp)
  801259:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125c:	0f af 45 10          	imul   0x10(%ebp),%eax
  801260:	89 c2                	mov    %eax,%edx
  801262:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801265:	01 d0                	add    %edx,%eax
  801267:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80126a:	e9 7b ff ff ff       	jmp    8011ea <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80126f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801270:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801274:	74 08                	je     80127e <strtol+0x134>
		*endptr = (char *) s;
  801276:	8b 45 0c             	mov    0xc(%ebp),%eax
  801279:	8b 55 08             	mov    0x8(%ebp),%edx
  80127c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80127e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801282:	74 07                	je     80128b <strtol+0x141>
  801284:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801287:	f7 d8                	neg    %eax
  801289:	eb 03                	jmp    80128e <strtol+0x144>
  80128b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80128e:	c9                   	leave  
  80128f:	c3                   	ret    

00801290 <ltostr>:

void
ltostr(long value, char *str)
{
  801290:	55                   	push   %ebp
  801291:	89 e5                	mov    %esp,%ebp
  801293:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801296:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80129d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012a4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012a8:	79 13                	jns    8012bd <ltostr+0x2d>
	{
		neg = 1;
  8012aa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012b7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012ba:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012c5:	99                   	cltd   
  8012c6:	f7 f9                	idiv   %ecx
  8012c8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ce:	8d 50 01             	lea    0x1(%eax),%edx
  8012d1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012d4:	89 c2                	mov    %eax,%edx
  8012d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d9:	01 d0                	add    %edx,%eax
  8012db:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012de:	83 c2 30             	add    $0x30,%edx
  8012e1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012e6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012eb:	f7 e9                	imul   %ecx
  8012ed:	c1 fa 02             	sar    $0x2,%edx
  8012f0:	89 c8                	mov    %ecx,%eax
  8012f2:	c1 f8 1f             	sar    $0x1f,%eax
  8012f5:	29 c2                	sub    %eax,%edx
  8012f7:	89 d0                	mov    %edx,%eax
  8012f9:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012ff:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801304:	f7 e9                	imul   %ecx
  801306:	c1 fa 02             	sar    $0x2,%edx
  801309:	89 c8                	mov    %ecx,%eax
  80130b:	c1 f8 1f             	sar    $0x1f,%eax
  80130e:	29 c2                	sub    %eax,%edx
  801310:	89 d0                	mov    %edx,%eax
  801312:	c1 e0 02             	shl    $0x2,%eax
  801315:	01 d0                	add    %edx,%eax
  801317:	01 c0                	add    %eax,%eax
  801319:	29 c1                	sub    %eax,%ecx
  80131b:	89 ca                	mov    %ecx,%edx
  80131d:	85 d2                	test   %edx,%edx
  80131f:	75 9c                	jne    8012bd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801321:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801328:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80132b:	48                   	dec    %eax
  80132c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80132f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801333:	74 3d                	je     801372 <ltostr+0xe2>
		start = 1 ;
  801335:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80133c:	eb 34                	jmp    801372 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80133e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801341:	8b 45 0c             	mov    0xc(%ebp),%eax
  801344:	01 d0                	add    %edx,%eax
  801346:	8a 00                	mov    (%eax),%al
  801348:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80134b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80134e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801351:	01 c2                	add    %eax,%edx
  801353:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801356:	8b 45 0c             	mov    0xc(%ebp),%eax
  801359:	01 c8                	add    %ecx,%eax
  80135b:	8a 00                	mov    (%eax),%al
  80135d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80135f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801362:	8b 45 0c             	mov    0xc(%ebp),%eax
  801365:	01 c2                	add    %eax,%edx
  801367:	8a 45 eb             	mov    -0x15(%ebp),%al
  80136a:	88 02                	mov    %al,(%edx)
		start++ ;
  80136c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80136f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801372:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801375:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801378:	7c c4                	jl     80133e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80137a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80137d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801380:	01 d0                	add    %edx,%eax
  801382:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801385:	90                   	nop
  801386:	c9                   	leave  
  801387:	c3                   	ret    

00801388 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
  80138b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80138e:	ff 75 08             	pushl  0x8(%ebp)
  801391:	e8 54 fa ff ff       	call   800dea <strlen>
  801396:	83 c4 04             	add    $0x4,%esp
  801399:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80139c:	ff 75 0c             	pushl  0xc(%ebp)
  80139f:	e8 46 fa ff ff       	call   800dea <strlen>
  8013a4:	83 c4 04             	add    $0x4,%esp
  8013a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013b8:	eb 17                	jmp    8013d1 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013ba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c0:	01 c2                	add    %eax,%edx
  8013c2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	01 c8                	add    %ecx,%eax
  8013ca:	8a 00                	mov    (%eax),%al
  8013cc:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013ce:	ff 45 fc             	incl   -0x4(%ebp)
  8013d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013d4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013d7:	7c e1                	jl     8013ba <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013d9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013e7:	eb 1f                	jmp    801408 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ec:	8d 50 01             	lea    0x1(%eax),%edx
  8013ef:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013f2:	89 c2                	mov    %eax,%edx
  8013f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f7:	01 c2                	add    %eax,%edx
  8013f9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ff:	01 c8                	add    %ecx,%eax
  801401:	8a 00                	mov    (%eax),%al
  801403:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801405:	ff 45 f8             	incl   -0x8(%ebp)
  801408:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80140b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80140e:	7c d9                	jl     8013e9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801410:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801413:	8b 45 10             	mov    0x10(%ebp),%eax
  801416:	01 d0                	add    %edx,%eax
  801418:	c6 00 00             	movb   $0x0,(%eax)
}
  80141b:	90                   	nop
  80141c:	c9                   	leave  
  80141d:	c3                   	ret    

0080141e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80141e:	55                   	push   %ebp
  80141f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801421:	8b 45 14             	mov    0x14(%ebp),%eax
  801424:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80142a:	8b 45 14             	mov    0x14(%ebp),%eax
  80142d:	8b 00                	mov    (%eax),%eax
  80142f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801436:	8b 45 10             	mov    0x10(%ebp),%eax
  801439:	01 d0                	add    %edx,%eax
  80143b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801441:	eb 0c                	jmp    80144f <strsplit+0x31>
			*string++ = 0;
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	8d 50 01             	lea    0x1(%eax),%edx
  801449:	89 55 08             	mov    %edx,0x8(%ebp)
  80144c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	8a 00                	mov    (%eax),%al
  801454:	84 c0                	test   %al,%al
  801456:	74 18                	je     801470 <strsplit+0x52>
  801458:	8b 45 08             	mov    0x8(%ebp),%eax
  80145b:	8a 00                	mov    (%eax),%al
  80145d:	0f be c0             	movsbl %al,%eax
  801460:	50                   	push   %eax
  801461:	ff 75 0c             	pushl  0xc(%ebp)
  801464:	e8 13 fb ff ff       	call   800f7c <strchr>
  801469:	83 c4 08             	add    $0x8,%esp
  80146c:	85 c0                	test   %eax,%eax
  80146e:	75 d3                	jne    801443 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801470:	8b 45 08             	mov    0x8(%ebp),%eax
  801473:	8a 00                	mov    (%eax),%al
  801475:	84 c0                	test   %al,%al
  801477:	74 5a                	je     8014d3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801479:	8b 45 14             	mov    0x14(%ebp),%eax
  80147c:	8b 00                	mov    (%eax),%eax
  80147e:	83 f8 0f             	cmp    $0xf,%eax
  801481:	75 07                	jne    80148a <strsplit+0x6c>
		{
			return 0;
  801483:	b8 00 00 00 00       	mov    $0x0,%eax
  801488:	eb 66                	jmp    8014f0 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80148a:	8b 45 14             	mov    0x14(%ebp),%eax
  80148d:	8b 00                	mov    (%eax),%eax
  80148f:	8d 48 01             	lea    0x1(%eax),%ecx
  801492:	8b 55 14             	mov    0x14(%ebp),%edx
  801495:	89 0a                	mov    %ecx,(%edx)
  801497:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80149e:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a1:	01 c2                	add    %eax,%edx
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014a8:	eb 03                	jmp    8014ad <strsplit+0x8f>
			string++;
  8014aa:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b0:	8a 00                	mov    (%eax),%al
  8014b2:	84 c0                	test   %al,%al
  8014b4:	74 8b                	je     801441 <strsplit+0x23>
  8014b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b9:	8a 00                	mov    (%eax),%al
  8014bb:	0f be c0             	movsbl %al,%eax
  8014be:	50                   	push   %eax
  8014bf:	ff 75 0c             	pushl  0xc(%ebp)
  8014c2:	e8 b5 fa ff ff       	call   800f7c <strchr>
  8014c7:	83 c4 08             	add    $0x8,%esp
  8014ca:	85 c0                	test   %eax,%eax
  8014cc:	74 dc                	je     8014aa <strsplit+0x8c>
			string++;
	}
  8014ce:	e9 6e ff ff ff       	jmp    801441 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014d3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d7:	8b 00                	mov    (%eax),%eax
  8014d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e3:	01 d0                	add    %edx,%eax
  8014e5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014eb:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
  8014f5:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  8014f8:	a1 04 30 80 00       	mov    0x803004,%eax
  8014fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801500:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  801507:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80150e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  801515:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  80151c:	e9 f9 00 00 00       	jmp    80161a <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  801521:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801524:	05 00 00 00 80       	add    $0x80000000,%eax
  801529:	c1 e8 0c             	shr    $0xc,%eax
  80152c:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801533:	85 c0                	test   %eax,%eax
  801535:	75 1c                	jne    801553 <nextFitAlgo+0x61>
  801537:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  80153b:	74 16                	je     801553 <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  80153d:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801544:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  80154b:	ff 4d e0             	decl   -0x20(%ebp)
  80154e:	e9 90 00 00 00       	jmp    8015e3 <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  801553:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801556:	05 00 00 00 80       	add    $0x80000000,%eax
  80155b:	c1 e8 0c             	shr    $0xc,%eax
  80155e:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801565:	85 c0                	test   %eax,%eax
  801567:	75 26                	jne    80158f <nextFitAlgo+0x9d>
  801569:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  80156d:	75 20                	jne    80158f <nextFitAlgo+0x9d>
			flag = 1;
  80156f:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  801576:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801579:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  80157c:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801583:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  80158a:	ff 4d e0             	decl   -0x20(%ebp)
  80158d:	eb 54                	jmp    8015e3 <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  80158f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801592:	3b 45 08             	cmp    0x8(%ebp),%eax
  801595:	72 11                	jb     8015a8 <nextFitAlgo+0xb6>
				startAdd = tmp;
  801597:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80159a:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  80159f:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  8015a6:	eb 7c                	jmp    801624 <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  8015a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ab:	05 00 00 00 80       	add    $0x80000000,%eax
  8015b0:	c1 e8 0c             	shr    $0xc,%eax
  8015b3:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8015ba:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  8015bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015c0:	05 00 00 00 80       	add    $0x80000000,%eax
  8015c5:	c1 e8 0c             	shr    $0xc,%eax
  8015c8:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8015cf:	c1 e0 0c             	shl    $0xc,%eax
  8015d2:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  8015d5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015dc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  8015e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015e6:	3b 45 08             	cmp    0x8(%ebp),%eax
  8015e9:	72 11                	jb     8015fc <nextFitAlgo+0x10a>
			startAdd = tmp;
  8015eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015ee:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  8015f3:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  8015fa:	eb 28                	jmp    801624 <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  8015fc:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  801603:	76 15                	jbe    80161a <nextFitAlgo+0x128>
			flag = newSize = 0;
  801605:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80160c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  801613:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  80161a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80161e:	0f 85 fd fe ff ff    	jne    801521 <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  801624:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801628:	75 1a                	jne    801644 <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  80162a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80162d:	3b 45 08             	cmp    0x8(%ebp),%eax
  801630:	73 0a                	jae    80163c <nextFitAlgo+0x14a>
  801632:	b8 00 00 00 00       	mov    $0x0,%eax
  801637:	e9 99 00 00 00       	jmp    8016d5 <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  80163c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80163f:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  801644:	a1 04 30 80 00       	mov    0x803004,%eax
  801649:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  80164c:	a1 04 30 80 00       	mov    0x803004,%eax
  801651:	05 00 00 00 80       	add    $0x80000000,%eax
  801656:	c1 e8 0c             	shr    $0xc,%eax
  801659:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  80165c:	8b 45 08             	mov    0x8(%ebp),%eax
  80165f:	c1 e8 0c             	shr    $0xc,%eax
  801662:	89 c2                	mov    %eax,%edx
  801664:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801667:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  80166e:	a1 04 30 80 00       	mov    0x803004,%eax
  801673:	83 ec 08             	sub    $0x8,%esp
  801676:	ff 75 08             	pushl  0x8(%ebp)
  801679:	50                   	push   %eax
  80167a:	e8 82 03 00 00       	call   801a01 <sys_allocateMem>
  80167f:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  801682:	a1 04 30 80 00       	mov    0x803004,%eax
  801687:	05 00 00 00 80       	add    $0x80000000,%eax
  80168c:	c1 e8 0c             	shr    $0xc,%eax
  80168f:	89 c2                	mov    %eax,%edx
  801691:	a1 04 30 80 00       	mov    0x803004,%eax
  801696:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  80169d:	a1 04 30 80 00       	mov    0x803004,%eax
  8016a2:	05 00 00 00 80       	add    $0x80000000,%eax
  8016a7:	c1 e8 0c             	shr    $0xc,%eax
  8016aa:	89 c2                	mov    %eax,%edx
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  8016b6:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8016bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bf:	01 d0                	add    %edx,%eax
  8016c1:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  8016c6:	76 0a                	jbe    8016d2 <nextFitAlgo+0x1e0>
  8016c8:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  8016cf:	00 00 80 

	return (void*)returnHolder;
  8016d2:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  8016d5:	c9                   	leave  
  8016d6:	c3                   	ret    

008016d7 <malloc>:

void* malloc(uint32 size) {
  8016d7:	55                   	push   %ebp
  8016d8:	89 e5                	mov    %esp,%ebp
  8016da:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  8016dd:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  8016e4:	8b 55 08             	mov    0x8(%ebp),%edx
  8016e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016ea:	01 d0                	add    %edx,%eax
  8016ec:	48                   	dec    %eax
  8016ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016f3:	ba 00 00 00 00       	mov    $0x0,%edx
  8016f8:	f7 75 f4             	divl   -0xc(%ebp)
  8016fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016fe:	29 d0                	sub    %edx,%eax
  801700:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801703:	e8 c3 06 00 00       	call   801dcb <sys_isUHeapPlacementStrategyNEXTFIT>
  801708:	85 c0                	test   %eax,%eax
  80170a:	74 10                	je     80171c <malloc+0x45>
		return nextFitAlgo(size);
  80170c:	83 ec 0c             	sub    $0xc,%esp
  80170f:	ff 75 08             	pushl  0x8(%ebp)
  801712:	e8 db fd ff ff       	call   8014f2 <nextFitAlgo>
  801717:	83 c4 10             	add    $0x10,%esp
  80171a:	eb 0a                	jmp    801726 <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  80171c:	e8 79 06 00 00       	call   801d9a <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  801721:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
  80172b:	83 ec 18             	sub    $0x18,%esp
  80172e:	8b 45 10             	mov    0x10(%ebp),%eax
  801731:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801734:	83 ec 04             	sub    $0x4,%esp
  801737:	68 90 26 80 00       	push   $0x802690
  80173c:	6a 7e                	push   $0x7e
  80173e:	68 af 26 80 00       	push   $0x8026af
  801743:	e8 6c ed ff ff       	call   8004b4 <_panic>

00801748 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
  80174b:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  80174e:	83 ec 04             	sub    $0x4,%esp
  801751:	68 bb 26 80 00       	push   $0x8026bb
  801756:	68 84 00 00 00       	push   $0x84
  80175b:	68 af 26 80 00       	push   $0x8026af
  801760:	e8 4f ed ff ff       	call   8004b4 <_panic>

00801765 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
  801768:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  80176b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801772:	eb 61                	jmp    8017d5 <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  801774:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801777:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  80177e:	8b 45 08             	mov    0x8(%ebp),%eax
  801781:	39 c2                	cmp    %eax,%edx
  801783:	75 4d                	jne    8017d2 <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  801785:	8b 45 08             	mov    0x8(%ebp),%eax
  801788:	05 00 00 00 80       	add    $0x80000000,%eax
  80178d:	c1 e8 0c             	shr    $0xc,%eax
  801790:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801793:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801796:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  80179d:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  8017a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017a3:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  8017aa:	00 00 00 00 
  8017ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017b1:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  8017b8:	00 00 00 00 
  8017bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017bf:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  8017c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017c9:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  8017d0:	eb 0d                	jmp    8017df <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8017d2:	ff 45 f0             	incl   -0x10(%ebp)
  8017d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017d8:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8017dd:	76 95                	jbe    801774 <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  8017df:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e2:	83 ec 08             	sub    $0x8,%esp
  8017e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8017e8:	50                   	push   %eax
  8017e9:	e8 f7 01 00 00       	call   8019e5 <sys_freeMem>
  8017ee:	83 c4 10             	add    $0x10,%esp
}
  8017f1:	90                   	nop
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sfree>:


void sfree(void* virtual_address)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
  8017f7:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8017fa:	83 ec 04             	sub    $0x4,%esp
  8017fd:	68 d7 26 80 00       	push   $0x8026d7
  801802:	68 ac 00 00 00       	push   $0xac
  801807:	68 af 26 80 00       	push   $0x8026af
  80180c:	e8 a3 ec ff ff       	call   8004b4 <_panic>

00801811 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801811:	55                   	push   %ebp
  801812:	89 e5                	mov    %esp,%ebp
  801814:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801817:	83 ec 04             	sub    $0x4,%esp
  80181a:	68 f4 26 80 00       	push   $0x8026f4
  80181f:	68 c4 00 00 00       	push   $0xc4
  801824:	68 af 26 80 00       	push   $0x8026af
  801829:	e8 86 ec ff ff       	call   8004b4 <_panic>

0080182e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
  801831:	57                   	push   %edi
  801832:	56                   	push   %esi
  801833:	53                   	push   %ebx
  801834:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801837:	8b 45 08             	mov    0x8(%ebp),%eax
  80183a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801840:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801843:	8b 7d 18             	mov    0x18(%ebp),%edi
  801846:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801849:	cd 30                	int    $0x30
  80184b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80184e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801851:	83 c4 10             	add    $0x10,%esp
  801854:	5b                   	pop    %ebx
  801855:	5e                   	pop    %esi
  801856:	5f                   	pop    %edi
  801857:	5d                   	pop    %ebp
  801858:	c3                   	ret    

00801859 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801859:	55                   	push   %ebp
  80185a:	89 e5                	mov    %esp,%ebp
  80185c:	83 ec 04             	sub    $0x4,%esp
  80185f:	8b 45 10             	mov    0x10(%ebp),%eax
  801862:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801865:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801869:	8b 45 08             	mov    0x8(%ebp),%eax
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	52                   	push   %edx
  801871:	ff 75 0c             	pushl  0xc(%ebp)
  801874:	50                   	push   %eax
  801875:	6a 00                	push   $0x0
  801877:	e8 b2 ff ff ff       	call   80182e <syscall>
  80187c:	83 c4 18             	add    $0x18,%esp
}
  80187f:	90                   	nop
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <sys_cgetc>:

int
sys_cgetc(void)
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 01                	push   $0x1
  801891:	e8 98 ff ff ff       	call   80182e <syscall>
  801896:	83 c4 18             	add    $0x18,%esp
}
  801899:	c9                   	leave  
  80189a:	c3                   	ret    

0080189b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80189b:	55                   	push   %ebp
  80189c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80189e:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	50                   	push   %eax
  8018aa:	6a 05                	push   $0x5
  8018ac:	e8 7d ff ff ff       	call   80182e <syscall>
  8018b1:	83 c4 18             	add    $0x18,%esp
}
  8018b4:	c9                   	leave  
  8018b5:	c3                   	ret    

008018b6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 02                	push   $0x2
  8018c5:	e8 64 ff ff ff       	call   80182e <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 03                	push   $0x3
  8018de:	e8 4b ff ff ff       	call   80182e <syscall>
  8018e3:	83 c4 18             	add    $0x18,%esp
}
  8018e6:	c9                   	leave  
  8018e7:	c3                   	ret    

008018e8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018e8:	55                   	push   %ebp
  8018e9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 04                	push   $0x4
  8018f7:	e8 32 ff ff ff       	call   80182e <syscall>
  8018fc:	83 c4 18             	add    $0x18,%esp
}
  8018ff:	c9                   	leave  
  801900:	c3                   	ret    

00801901 <sys_env_exit>:


void sys_env_exit(void)
{
  801901:	55                   	push   %ebp
  801902:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 06                	push   $0x6
  801910:	e8 19 ff ff ff       	call   80182e <syscall>
  801915:	83 c4 18             	add    $0x18,%esp
}
  801918:	90                   	nop
  801919:	c9                   	leave  
  80191a:	c3                   	ret    

0080191b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80191b:	55                   	push   %ebp
  80191c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80191e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801921:	8b 45 08             	mov    0x8(%ebp),%eax
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	52                   	push   %edx
  80192b:	50                   	push   %eax
  80192c:	6a 07                	push   $0x7
  80192e:	e8 fb fe ff ff       	call   80182e <syscall>
  801933:	83 c4 18             	add    $0x18,%esp
}
  801936:	c9                   	leave  
  801937:	c3                   	ret    

00801938 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801938:	55                   	push   %ebp
  801939:	89 e5                	mov    %esp,%ebp
  80193b:	56                   	push   %esi
  80193c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80193d:	8b 75 18             	mov    0x18(%ebp),%esi
  801940:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801943:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801946:	8b 55 0c             	mov    0xc(%ebp),%edx
  801949:	8b 45 08             	mov    0x8(%ebp),%eax
  80194c:	56                   	push   %esi
  80194d:	53                   	push   %ebx
  80194e:	51                   	push   %ecx
  80194f:	52                   	push   %edx
  801950:	50                   	push   %eax
  801951:	6a 08                	push   $0x8
  801953:	e8 d6 fe ff ff       	call   80182e <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
}
  80195b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80195e:	5b                   	pop    %ebx
  80195f:	5e                   	pop    %esi
  801960:	5d                   	pop    %ebp
  801961:	c3                   	ret    

00801962 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801962:	55                   	push   %ebp
  801963:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801965:	8b 55 0c             	mov    0xc(%ebp),%edx
  801968:	8b 45 08             	mov    0x8(%ebp),%eax
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	52                   	push   %edx
  801972:	50                   	push   %eax
  801973:	6a 09                	push   $0x9
  801975:	e8 b4 fe ff ff       	call   80182e <syscall>
  80197a:	83 c4 18             	add    $0x18,%esp
}
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	ff 75 0c             	pushl  0xc(%ebp)
  80198b:	ff 75 08             	pushl  0x8(%ebp)
  80198e:	6a 0a                	push   $0xa
  801990:	e8 99 fe ff ff       	call   80182e <syscall>
  801995:	83 c4 18             	add    $0x18,%esp
}
  801998:	c9                   	leave  
  801999:	c3                   	ret    

0080199a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 0b                	push   $0xb
  8019a9:	e8 80 fe ff ff       	call   80182e <syscall>
  8019ae:	83 c4 18             	add    $0x18,%esp
}
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 0c                	push   $0xc
  8019c2:	e8 67 fe ff ff       	call   80182e <syscall>
  8019c7:	83 c4 18             	add    $0x18,%esp
}
  8019ca:	c9                   	leave  
  8019cb:	c3                   	ret    

008019cc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8019cc:	55                   	push   %ebp
  8019cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 0d                	push   $0xd
  8019db:	e8 4e fe ff ff       	call   80182e <syscall>
  8019e0:	83 c4 18             	add    $0x18,%esp
}
  8019e3:	c9                   	leave  
  8019e4:	c3                   	ret    

008019e5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019e5:	55                   	push   %ebp
  8019e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	ff 75 0c             	pushl  0xc(%ebp)
  8019f1:	ff 75 08             	pushl  0x8(%ebp)
  8019f4:	6a 11                	push   $0x11
  8019f6:	e8 33 fe ff ff       	call   80182e <syscall>
  8019fb:	83 c4 18             	add    $0x18,%esp
	return;
  8019fe:	90                   	nop
}
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	ff 75 0c             	pushl  0xc(%ebp)
  801a0d:	ff 75 08             	pushl  0x8(%ebp)
  801a10:	6a 12                	push   $0x12
  801a12:	e8 17 fe ff ff       	call   80182e <syscall>
  801a17:	83 c4 18             	add    $0x18,%esp
	return ;
  801a1a:	90                   	nop
}
  801a1b:	c9                   	leave  
  801a1c:	c3                   	ret    

00801a1d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a1d:	55                   	push   %ebp
  801a1e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 0e                	push   $0xe
  801a2c:	e8 fd fd ff ff       	call   80182e <syscall>
  801a31:	83 c4 18             	add    $0x18,%esp
}
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	ff 75 08             	pushl  0x8(%ebp)
  801a44:	6a 0f                	push   $0xf
  801a46:	e8 e3 fd ff ff       	call   80182e <syscall>
  801a4b:	83 c4 18             	add    $0x18,%esp
}
  801a4e:	c9                   	leave  
  801a4f:	c3                   	ret    

00801a50 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a50:	55                   	push   %ebp
  801a51:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 10                	push   $0x10
  801a5f:	e8 ca fd ff ff       	call   80182e <syscall>
  801a64:	83 c4 18             	add    $0x18,%esp
}
  801a67:	90                   	nop
  801a68:	c9                   	leave  
  801a69:	c3                   	ret    

00801a6a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a6a:	55                   	push   %ebp
  801a6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 14                	push   $0x14
  801a79:	e8 b0 fd ff ff       	call   80182e <syscall>
  801a7e:	83 c4 18             	add    $0x18,%esp
}
  801a81:	90                   	nop
  801a82:	c9                   	leave  
  801a83:	c3                   	ret    

00801a84 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a84:	55                   	push   %ebp
  801a85:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 15                	push   $0x15
  801a93:	e8 96 fd ff ff       	call   80182e <syscall>
  801a98:	83 c4 18             	add    $0x18,%esp
}
  801a9b:	90                   	nop
  801a9c:	c9                   	leave  
  801a9d:	c3                   	ret    

00801a9e <sys_cputc>:


void
sys_cputc(const char c)
{
  801a9e:	55                   	push   %ebp
  801a9f:	89 e5                	mov    %esp,%ebp
  801aa1:	83 ec 04             	sub    $0x4,%esp
  801aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801aaa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	50                   	push   %eax
  801ab7:	6a 16                	push   $0x16
  801ab9:	e8 70 fd ff ff       	call   80182e <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
}
  801ac1:	90                   	nop
  801ac2:	c9                   	leave  
  801ac3:	c3                   	ret    

00801ac4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ac4:	55                   	push   %ebp
  801ac5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 17                	push   $0x17
  801ad3:	e8 56 fd ff ff       	call   80182e <syscall>
  801ad8:	83 c4 18             	add    $0x18,%esp
}
  801adb:	90                   	nop
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	ff 75 0c             	pushl  0xc(%ebp)
  801aed:	50                   	push   %eax
  801aee:	6a 18                	push   $0x18
  801af0:	e8 39 fd ff ff       	call   80182e <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
}
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801afd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b00:	8b 45 08             	mov    0x8(%ebp),%eax
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	52                   	push   %edx
  801b0a:	50                   	push   %eax
  801b0b:	6a 1b                	push   $0x1b
  801b0d:	e8 1c fd ff ff       	call   80182e <syscall>
  801b12:	83 c4 18             	add    $0x18,%esp
}
  801b15:	c9                   	leave  
  801b16:	c3                   	ret    

00801b17 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b17:	55                   	push   %ebp
  801b18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	52                   	push   %edx
  801b27:	50                   	push   %eax
  801b28:	6a 19                	push   $0x19
  801b2a:	e8 ff fc ff ff       	call   80182e <syscall>
  801b2f:	83 c4 18             	add    $0x18,%esp
}
  801b32:	90                   	nop
  801b33:	c9                   	leave  
  801b34:	c3                   	ret    

00801b35 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b35:	55                   	push   %ebp
  801b36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b38:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	52                   	push   %edx
  801b45:	50                   	push   %eax
  801b46:	6a 1a                	push   $0x1a
  801b48:	e8 e1 fc ff ff       	call   80182e <syscall>
  801b4d:	83 c4 18             	add    $0x18,%esp
}
  801b50:	90                   	nop
  801b51:	c9                   	leave  
  801b52:	c3                   	ret    

00801b53 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b53:	55                   	push   %ebp
  801b54:	89 e5                	mov    %esp,%ebp
  801b56:	83 ec 04             	sub    $0x4,%esp
  801b59:	8b 45 10             	mov    0x10(%ebp),%eax
  801b5c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b5f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b62:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b66:	8b 45 08             	mov    0x8(%ebp),%eax
  801b69:	6a 00                	push   $0x0
  801b6b:	51                   	push   %ecx
  801b6c:	52                   	push   %edx
  801b6d:	ff 75 0c             	pushl  0xc(%ebp)
  801b70:	50                   	push   %eax
  801b71:	6a 1c                	push   $0x1c
  801b73:	e8 b6 fc ff ff       	call   80182e <syscall>
  801b78:	83 c4 18             	add    $0x18,%esp
}
  801b7b:	c9                   	leave  
  801b7c:	c3                   	ret    

00801b7d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b7d:	55                   	push   %ebp
  801b7e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b80:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b83:	8b 45 08             	mov    0x8(%ebp),%eax
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	52                   	push   %edx
  801b8d:	50                   	push   %eax
  801b8e:	6a 1d                	push   $0x1d
  801b90:	e8 99 fc ff ff       	call   80182e <syscall>
  801b95:	83 c4 18             	add    $0x18,%esp
}
  801b98:	c9                   	leave  
  801b99:	c3                   	ret    

00801b9a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b9a:	55                   	push   %ebp
  801b9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b9d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ba0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	51                   	push   %ecx
  801bab:	52                   	push   %edx
  801bac:	50                   	push   %eax
  801bad:	6a 1e                	push   $0x1e
  801baf:	e8 7a fc ff ff       	call   80182e <syscall>
  801bb4:	83 c4 18             	add    $0x18,%esp
}
  801bb7:	c9                   	leave  
  801bb8:	c3                   	ret    

00801bb9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801bb9:	55                   	push   %ebp
  801bba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801bbc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	52                   	push   %edx
  801bc9:	50                   	push   %eax
  801bca:	6a 1f                	push   $0x1f
  801bcc:	e8 5d fc ff ff       	call   80182e <syscall>
  801bd1:	83 c4 18             	add    $0x18,%esp
}
  801bd4:	c9                   	leave  
  801bd5:	c3                   	ret    

00801bd6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801bd6:	55                   	push   %ebp
  801bd7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 20                	push   $0x20
  801be5:	e8 44 fc ff ff       	call   80182e <syscall>
  801bea:	83 c4 18             	add    $0x18,%esp
}
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	ff 75 10             	pushl  0x10(%ebp)
  801bfc:	ff 75 0c             	pushl  0xc(%ebp)
  801bff:	50                   	push   %eax
  801c00:	6a 21                	push   $0x21
  801c02:	e8 27 fc ff ff       	call   80182e <syscall>
  801c07:	83 c4 18             	add    $0x18,%esp
}
  801c0a:	c9                   	leave  
  801c0b:	c3                   	ret    

00801c0c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	50                   	push   %eax
  801c1b:	6a 22                	push   $0x22
  801c1d:	e8 0c fc ff ff       	call   80182e <syscall>
  801c22:	83 c4 18             	add    $0x18,%esp
}
  801c25:	90                   	nop
  801c26:	c9                   	leave  
  801c27:	c3                   	ret    

00801c28 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c28:	55                   	push   %ebp
  801c29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	50                   	push   %eax
  801c37:	6a 23                	push   $0x23
  801c39:	e8 f0 fb ff ff       	call   80182e <syscall>
  801c3e:	83 c4 18             	add    $0x18,%esp
}
  801c41:	90                   	nop
  801c42:	c9                   	leave  
  801c43:	c3                   	ret    

00801c44 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c44:	55                   	push   %ebp
  801c45:	89 e5                	mov    %esp,%ebp
  801c47:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c4a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c4d:	8d 50 04             	lea    0x4(%eax),%edx
  801c50:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	52                   	push   %edx
  801c5a:	50                   	push   %eax
  801c5b:	6a 24                	push   $0x24
  801c5d:	e8 cc fb ff ff       	call   80182e <syscall>
  801c62:	83 c4 18             	add    $0x18,%esp
	return result;
  801c65:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c68:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c6b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c6e:	89 01                	mov    %eax,(%ecx)
  801c70:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c73:	8b 45 08             	mov    0x8(%ebp),%eax
  801c76:	c9                   	leave  
  801c77:	c2 04 00             	ret    $0x4

00801c7a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c7a:	55                   	push   %ebp
  801c7b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	ff 75 10             	pushl  0x10(%ebp)
  801c84:	ff 75 0c             	pushl  0xc(%ebp)
  801c87:	ff 75 08             	pushl  0x8(%ebp)
  801c8a:	6a 13                	push   $0x13
  801c8c:	e8 9d fb ff ff       	call   80182e <syscall>
  801c91:	83 c4 18             	add    $0x18,%esp
	return ;
  801c94:	90                   	nop
}
  801c95:	c9                   	leave  
  801c96:	c3                   	ret    

00801c97 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c97:	55                   	push   %ebp
  801c98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 25                	push   $0x25
  801ca6:	e8 83 fb ff ff       	call   80182e <syscall>
  801cab:	83 c4 18             	add    $0x18,%esp
}
  801cae:	c9                   	leave  
  801caf:	c3                   	ret    

00801cb0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801cb0:	55                   	push   %ebp
  801cb1:	89 e5                	mov    %esp,%ebp
  801cb3:	83 ec 04             	sub    $0x4,%esp
  801cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801cbc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	50                   	push   %eax
  801cc9:	6a 26                	push   $0x26
  801ccb:	e8 5e fb ff ff       	call   80182e <syscall>
  801cd0:	83 c4 18             	add    $0x18,%esp
	return ;
  801cd3:	90                   	nop
}
  801cd4:	c9                   	leave  
  801cd5:	c3                   	ret    

00801cd6 <rsttst>:
void rsttst()
{
  801cd6:	55                   	push   %ebp
  801cd7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 28                	push   $0x28
  801ce5:	e8 44 fb ff ff       	call   80182e <syscall>
  801cea:	83 c4 18             	add    $0x18,%esp
	return ;
  801ced:	90                   	nop
}
  801cee:	c9                   	leave  
  801cef:	c3                   	ret    

00801cf0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801cf0:	55                   	push   %ebp
  801cf1:	89 e5                	mov    %esp,%ebp
  801cf3:	83 ec 04             	sub    $0x4,%esp
  801cf6:	8b 45 14             	mov    0x14(%ebp),%eax
  801cf9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801cfc:	8b 55 18             	mov    0x18(%ebp),%edx
  801cff:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d03:	52                   	push   %edx
  801d04:	50                   	push   %eax
  801d05:	ff 75 10             	pushl  0x10(%ebp)
  801d08:	ff 75 0c             	pushl  0xc(%ebp)
  801d0b:	ff 75 08             	pushl  0x8(%ebp)
  801d0e:	6a 27                	push   $0x27
  801d10:	e8 19 fb ff ff       	call   80182e <syscall>
  801d15:	83 c4 18             	add    $0x18,%esp
	return ;
  801d18:	90                   	nop
}
  801d19:	c9                   	leave  
  801d1a:	c3                   	ret    

00801d1b <chktst>:
void chktst(uint32 n)
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	ff 75 08             	pushl  0x8(%ebp)
  801d29:	6a 29                	push   $0x29
  801d2b:	e8 fe fa ff ff       	call   80182e <syscall>
  801d30:	83 c4 18             	add    $0x18,%esp
	return ;
  801d33:	90                   	nop
}
  801d34:	c9                   	leave  
  801d35:	c3                   	ret    

00801d36 <inctst>:

void inctst()
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 2a                	push   $0x2a
  801d45:	e8 e4 fa ff ff       	call   80182e <syscall>
  801d4a:	83 c4 18             	add    $0x18,%esp
	return ;
  801d4d:	90                   	nop
}
  801d4e:	c9                   	leave  
  801d4f:	c3                   	ret    

00801d50 <gettst>:
uint32 gettst()
{
  801d50:	55                   	push   %ebp
  801d51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 2b                	push   $0x2b
  801d5f:	e8 ca fa ff ff       	call   80182e <syscall>
  801d64:	83 c4 18             	add    $0x18,%esp
}
  801d67:	c9                   	leave  
  801d68:	c3                   	ret    

00801d69 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d69:	55                   	push   %ebp
  801d6a:	89 e5                	mov    %esp,%ebp
  801d6c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 2c                	push   $0x2c
  801d7b:	e8 ae fa ff ff       	call   80182e <syscall>
  801d80:	83 c4 18             	add    $0x18,%esp
  801d83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d86:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d8a:	75 07                	jne    801d93 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d8c:	b8 01 00 00 00       	mov    $0x1,%eax
  801d91:	eb 05                	jmp    801d98 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d93:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d98:	c9                   	leave  
  801d99:	c3                   	ret    

00801d9a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d9a:	55                   	push   %ebp
  801d9b:	89 e5                	mov    %esp,%ebp
  801d9d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 2c                	push   $0x2c
  801dac:	e8 7d fa ff ff       	call   80182e <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
  801db4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801db7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801dbb:	75 07                	jne    801dc4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801dbd:	b8 01 00 00 00       	mov    $0x1,%eax
  801dc2:	eb 05                	jmp    801dc9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801dc4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dc9:	c9                   	leave  
  801dca:	c3                   	ret    

00801dcb <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801dcb:	55                   	push   %ebp
  801dcc:	89 e5                	mov    %esp,%ebp
  801dce:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 2c                	push   $0x2c
  801ddd:	e8 4c fa ff ff       	call   80182e <syscall>
  801de2:	83 c4 18             	add    $0x18,%esp
  801de5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801de8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801dec:	75 07                	jne    801df5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801dee:	b8 01 00 00 00       	mov    $0x1,%eax
  801df3:	eb 05                	jmp    801dfa <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801df5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dfa:	c9                   	leave  
  801dfb:	c3                   	ret    

00801dfc <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801dfc:	55                   	push   %ebp
  801dfd:	89 e5                	mov    %esp,%ebp
  801dff:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 2c                	push   $0x2c
  801e0e:	e8 1b fa ff ff       	call   80182e <syscall>
  801e13:	83 c4 18             	add    $0x18,%esp
  801e16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e19:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e1d:	75 07                	jne    801e26 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e1f:	b8 01 00 00 00       	mov    $0x1,%eax
  801e24:	eb 05                	jmp    801e2b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e26:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e2b:	c9                   	leave  
  801e2c:	c3                   	ret    

00801e2d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e2d:	55                   	push   %ebp
  801e2e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	ff 75 08             	pushl  0x8(%ebp)
  801e3b:	6a 2d                	push   $0x2d
  801e3d:	e8 ec f9 ff ff       	call   80182e <syscall>
  801e42:	83 c4 18             	add    $0x18,%esp
	return ;
  801e45:	90                   	nop
}
  801e46:	c9                   	leave  
  801e47:	c3                   	ret    

00801e48 <__udivdi3>:
  801e48:	55                   	push   %ebp
  801e49:	57                   	push   %edi
  801e4a:	56                   	push   %esi
  801e4b:	53                   	push   %ebx
  801e4c:	83 ec 1c             	sub    $0x1c,%esp
  801e4f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e53:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e57:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e5b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e5f:	89 ca                	mov    %ecx,%edx
  801e61:	89 f8                	mov    %edi,%eax
  801e63:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e67:	85 f6                	test   %esi,%esi
  801e69:	75 2d                	jne    801e98 <__udivdi3+0x50>
  801e6b:	39 cf                	cmp    %ecx,%edi
  801e6d:	77 65                	ja     801ed4 <__udivdi3+0x8c>
  801e6f:	89 fd                	mov    %edi,%ebp
  801e71:	85 ff                	test   %edi,%edi
  801e73:	75 0b                	jne    801e80 <__udivdi3+0x38>
  801e75:	b8 01 00 00 00       	mov    $0x1,%eax
  801e7a:	31 d2                	xor    %edx,%edx
  801e7c:	f7 f7                	div    %edi
  801e7e:	89 c5                	mov    %eax,%ebp
  801e80:	31 d2                	xor    %edx,%edx
  801e82:	89 c8                	mov    %ecx,%eax
  801e84:	f7 f5                	div    %ebp
  801e86:	89 c1                	mov    %eax,%ecx
  801e88:	89 d8                	mov    %ebx,%eax
  801e8a:	f7 f5                	div    %ebp
  801e8c:	89 cf                	mov    %ecx,%edi
  801e8e:	89 fa                	mov    %edi,%edx
  801e90:	83 c4 1c             	add    $0x1c,%esp
  801e93:	5b                   	pop    %ebx
  801e94:	5e                   	pop    %esi
  801e95:	5f                   	pop    %edi
  801e96:	5d                   	pop    %ebp
  801e97:	c3                   	ret    
  801e98:	39 ce                	cmp    %ecx,%esi
  801e9a:	77 28                	ja     801ec4 <__udivdi3+0x7c>
  801e9c:	0f bd fe             	bsr    %esi,%edi
  801e9f:	83 f7 1f             	xor    $0x1f,%edi
  801ea2:	75 40                	jne    801ee4 <__udivdi3+0x9c>
  801ea4:	39 ce                	cmp    %ecx,%esi
  801ea6:	72 0a                	jb     801eb2 <__udivdi3+0x6a>
  801ea8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801eac:	0f 87 9e 00 00 00    	ja     801f50 <__udivdi3+0x108>
  801eb2:	b8 01 00 00 00       	mov    $0x1,%eax
  801eb7:	89 fa                	mov    %edi,%edx
  801eb9:	83 c4 1c             	add    $0x1c,%esp
  801ebc:	5b                   	pop    %ebx
  801ebd:	5e                   	pop    %esi
  801ebe:	5f                   	pop    %edi
  801ebf:	5d                   	pop    %ebp
  801ec0:	c3                   	ret    
  801ec1:	8d 76 00             	lea    0x0(%esi),%esi
  801ec4:	31 ff                	xor    %edi,%edi
  801ec6:	31 c0                	xor    %eax,%eax
  801ec8:	89 fa                	mov    %edi,%edx
  801eca:	83 c4 1c             	add    $0x1c,%esp
  801ecd:	5b                   	pop    %ebx
  801ece:	5e                   	pop    %esi
  801ecf:	5f                   	pop    %edi
  801ed0:	5d                   	pop    %ebp
  801ed1:	c3                   	ret    
  801ed2:	66 90                	xchg   %ax,%ax
  801ed4:	89 d8                	mov    %ebx,%eax
  801ed6:	f7 f7                	div    %edi
  801ed8:	31 ff                	xor    %edi,%edi
  801eda:	89 fa                	mov    %edi,%edx
  801edc:	83 c4 1c             	add    $0x1c,%esp
  801edf:	5b                   	pop    %ebx
  801ee0:	5e                   	pop    %esi
  801ee1:	5f                   	pop    %edi
  801ee2:	5d                   	pop    %ebp
  801ee3:	c3                   	ret    
  801ee4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ee9:	89 eb                	mov    %ebp,%ebx
  801eeb:	29 fb                	sub    %edi,%ebx
  801eed:	89 f9                	mov    %edi,%ecx
  801eef:	d3 e6                	shl    %cl,%esi
  801ef1:	89 c5                	mov    %eax,%ebp
  801ef3:	88 d9                	mov    %bl,%cl
  801ef5:	d3 ed                	shr    %cl,%ebp
  801ef7:	89 e9                	mov    %ebp,%ecx
  801ef9:	09 f1                	or     %esi,%ecx
  801efb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801eff:	89 f9                	mov    %edi,%ecx
  801f01:	d3 e0                	shl    %cl,%eax
  801f03:	89 c5                	mov    %eax,%ebp
  801f05:	89 d6                	mov    %edx,%esi
  801f07:	88 d9                	mov    %bl,%cl
  801f09:	d3 ee                	shr    %cl,%esi
  801f0b:	89 f9                	mov    %edi,%ecx
  801f0d:	d3 e2                	shl    %cl,%edx
  801f0f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f13:	88 d9                	mov    %bl,%cl
  801f15:	d3 e8                	shr    %cl,%eax
  801f17:	09 c2                	or     %eax,%edx
  801f19:	89 d0                	mov    %edx,%eax
  801f1b:	89 f2                	mov    %esi,%edx
  801f1d:	f7 74 24 0c          	divl   0xc(%esp)
  801f21:	89 d6                	mov    %edx,%esi
  801f23:	89 c3                	mov    %eax,%ebx
  801f25:	f7 e5                	mul    %ebp
  801f27:	39 d6                	cmp    %edx,%esi
  801f29:	72 19                	jb     801f44 <__udivdi3+0xfc>
  801f2b:	74 0b                	je     801f38 <__udivdi3+0xf0>
  801f2d:	89 d8                	mov    %ebx,%eax
  801f2f:	31 ff                	xor    %edi,%edi
  801f31:	e9 58 ff ff ff       	jmp    801e8e <__udivdi3+0x46>
  801f36:	66 90                	xchg   %ax,%ax
  801f38:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f3c:	89 f9                	mov    %edi,%ecx
  801f3e:	d3 e2                	shl    %cl,%edx
  801f40:	39 c2                	cmp    %eax,%edx
  801f42:	73 e9                	jae    801f2d <__udivdi3+0xe5>
  801f44:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f47:	31 ff                	xor    %edi,%edi
  801f49:	e9 40 ff ff ff       	jmp    801e8e <__udivdi3+0x46>
  801f4e:	66 90                	xchg   %ax,%ax
  801f50:	31 c0                	xor    %eax,%eax
  801f52:	e9 37 ff ff ff       	jmp    801e8e <__udivdi3+0x46>
  801f57:	90                   	nop

00801f58 <__umoddi3>:
  801f58:	55                   	push   %ebp
  801f59:	57                   	push   %edi
  801f5a:	56                   	push   %esi
  801f5b:	53                   	push   %ebx
  801f5c:	83 ec 1c             	sub    $0x1c,%esp
  801f5f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f63:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f67:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f6b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f6f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f73:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f77:	89 f3                	mov    %esi,%ebx
  801f79:	89 fa                	mov    %edi,%edx
  801f7b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f7f:	89 34 24             	mov    %esi,(%esp)
  801f82:	85 c0                	test   %eax,%eax
  801f84:	75 1a                	jne    801fa0 <__umoddi3+0x48>
  801f86:	39 f7                	cmp    %esi,%edi
  801f88:	0f 86 a2 00 00 00    	jbe    802030 <__umoddi3+0xd8>
  801f8e:	89 c8                	mov    %ecx,%eax
  801f90:	89 f2                	mov    %esi,%edx
  801f92:	f7 f7                	div    %edi
  801f94:	89 d0                	mov    %edx,%eax
  801f96:	31 d2                	xor    %edx,%edx
  801f98:	83 c4 1c             	add    $0x1c,%esp
  801f9b:	5b                   	pop    %ebx
  801f9c:	5e                   	pop    %esi
  801f9d:	5f                   	pop    %edi
  801f9e:	5d                   	pop    %ebp
  801f9f:	c3                   	ret    
  801fa0:	39 f0                	cmp    %esi,%eax
  801fa2:	0f 87 ac 00 00 00    	ja     802054 <__umoddi3+0xfc>
  801fa8:	0f bd e8             	bsr    %eax,%ebp
  801fab:	83 f5 1f             	xor    $0x1f,%ebp
  801fae:	0f 84 ac 00 00 00    	je     802060 <__umoddi3+0x108>
  801fb4:	bf 20 00 00 00       	mov    $0x20,%edi
  801fb9:	29 ef                	sub    %ebp,%edi
  801fbb:	89 fe                	mov    %edi,%esi
  801fbd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801fc1:	89 e9                	mov    %ebp,%ecx
  801fc3:	d3 e0                	shl    %cl,%eax
  801fc5:	89 d7                	mov    %edx,%edi
  801fc7:	89 f1                	mov    %esi,%ecx
  801fc9:	d3 ef                	shr    %cl,%edi
  801fcb:	09 c7                	or     %eax,%edi
  801fcd:	89 e9                	mov    %ebp,%ecx
  801fcf:	d3 e2                	shl    %cl,%edx
  801fd1:	89 14 24             	mov    %edx,(%esp)
  801fd4:	89 d8                	mov    %ebx,%eax
  801fd6:	d3 e0                	shl    %cl,%eax
  801fd8:	89 c2                	mov    %eax,%edx
  801fda:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fde:	d3 e0                	shl    %cl,%eax
  801fe0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fe4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fe8:	89 f1                	mov    %esi,%ecx
  801fea:	d3 e8                	shr    %cl,%eax
  801fec:	09 d0                	or     %edx,%eax
  801fee:	d3 eb                	shr    %cl,%ebx
  801ff0:	89 da                	mov    %ebx,%edx
  801ff2:	f7 f7                	div    %edi
  801ff4:	89 d3                	mov    %edx,%ebx
  801ff6:	f7 24 24             	mull   (%esp)
  801ff9:	89 c6                	mov    %eax,%esi
  801ffb:	89 d1                	mov    %edx,%ecx
  801ffd:	39 d3                	cmp    %edx,%ebx
  801fff:	0f 82 87 00 00 00    	jb     80208c <__umoddi3+0x134>
  802005:	0f 84 91 00 00 00    	je     80209c <__umoddi3+0x144>
  80200b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80200f:	29 f2                	sub    %esi,%edx
  802011:	19 cb                	sbb    %ecx,%ebx
  802013:	89 d8                	mov    %ebx,%eax
  802015:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802019:	d3 e0                	shl    %cl,%eax
  80201b:	89 e9                	mov    %ebp,%ecx
  80201d:	d3 ea                	shr    %cl,%edx
  80201f:	09 d0                	or     %edx,%eax
  802021:	89 e9                	mov    %ebp,%ecx
  802023:	d3 eb                	shr    %cl,%ebx
  802025:	89 da                	mov    %ebx,%edx
  802027:	83 c4 1c             	add    $0x1c,%esp
  80202a:	5b                   	pop    %ebx
  80202b:	5e                   	pop    %esi
  80202c:	5f                   	pop    %edi
  80202d:	5d                   	pop    %ebp
  80202e:	c3                   	ret    
  80202f:	90                   	nop
  802030:	89 fd                	mov    %edi,%ebp
  802032:	85 ff                	test   %edi,%edi
  802034:	75 0b                	jne    802041 <__umoddi3+0xe9>
  802036:	b8 01 00 00 00       	mov    $0x1,%eax
  80203b:	31 d2                	xor    %edx,%edx
  80203d:	f7 f7                	div    %edi
  80203f:	89 c5                	mov    %eax,%ebp
  802041:	89 f0                	mov    %esi,%eax
  802043:	31 d2                	xor    %edx,%edx
  802045:	f7 f5                	div    %ebp
  802047:	89 c8                	mov    %ecx,%eax
  802049:	f7 f5                	div    %ebp
  80204b:	89 d0                	mov    %edx,%eax
  80204d:	e9 44 ff ff ff       	jmp    801f96 <__umoddi3+0x3e>
  802052:	66 90                	xchg   %ax,%ax
  802054:	89 c8                	mov    %ecx,%eax
  802056:	89 f2                	mov    %esi,%edx
  802058:	83 c4 1c             	add    $0x1c,%esp
  80205b:	5b                   	pop    %ebx
  80205c:	5e                   	pop    %esi
  80205d:	5f                   	pop    %edi
  80205e:	5d                   	pop    %ebp
  80205f:	c3                   	ret    
  802060:	3b 04 24             	cmp    (%esp),%eax
  802063:	72 06                	jb     80206b <__umoddi3+0x113>
  802065:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802069:	77 0f                	ja     80207a <__umoddi3+0x122>
  80206b:	89 f2                	mov    %esi,%edx
  80206d:	29 f9                	sub    %edi,%ecx
  80206f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802073:	89 14 24             	mov    %edx,(%esp)
  802076:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80207a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80207e:	8b 14 24             	mov    (%esp),%edx
  802081:	83 c4 1c             	add    $0x1c,%esp
  802084:	5b                   	pop    %ebx
  802085:	5e                   	pop    %esi
  802086:	5f                   	pop    %edi
  802087:	5d                   	pop    %ebp
  802088:	c3                   	ret    
  802089:	8d 76 00             	lea    0x0(%esi),%esi
  80208c:	2b 04 24             	sub    (%esp),%eax
  80208f:	19 fa                	sbb    %edi,%edx
  802091:	89 d1                	mov    %edx,%ecx
  802093:	89 c6                	mov    %eax,%esi
  802095:	e9 71 ff ff ff       	jmp    80200b <__umoddi3+0xb3>
  80209a:	66 90                	xchg   %ax,%ax
  80209c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8020a0:	72 ea                	jb     80208c <__umoddi3+0x134>
  8020a2:	89 d9                	mov    %ebx,%ecx
  8020a4:	e9 62 ff ff ff       	jmp    80200b <__umoddi3+0xb3>
