
obj/user/tst_freeRAM:     file format elf32-i386


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
  800031:	e8 2c 14 00 00       	call   801462 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

char arr[PAGE_SIZE*12];
uint32 WSEntries_before[1000];

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 8c 01 00 00    	sub    $0x18c,%esp
	vcprintf("\n\n===============================================================\n", NULL);
  800044:	83 ec 08             	sub    $0x8,%esp
  800047:	6a 00                	push   $0x0
  800049:	68 00 2f 80 00       	push   $0x802f00
  80004e:	e8 67 17 00 00       	call   8017ba <vcprintf>
  800053:	83 c4 10             	add    $0x10,%esp
	vcprintf("MAKE SURE to have a FRESH RUN for EACH SCENARIO of this test\n(i.e. don't run any program/test/multiple scenarios before it)\n", NULL);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	6a 00                	push   $0x0
  80005b:	68 44 2f 80 00       	push   $0x802f44
  800060:	e8 55 17 00 00       	call   8017ba <vcprintf>
  800065:	83 c4 10             	add    $0x10,%esp
	vcprintf("===============================================================\n\n\n", NULL);
  800068:	83 ec 08             	sub    $0x8,%esp
  80006b:	6a 00                	push   $0x0
  80006d:	68 c4 2f 80 00       	push   $0x802fc4
  800072:	e8 43 17 00 00       	call   8017ba <vcprintf>
  800077:	83 c4 10             	add    $0x10,%esp

	uint32 testCase;
	if (myEnv->page_WS_max_size == 1000)
  80007a:	a1 20 40 80 00       	mov    0x804020,%eax
  80007f:	8b 40 74             	mov    0x74(%eax),%eax
  800082:	3d e8 03 00 00       	cmp    $0x3e8,%eax
  800087:	75 09                	jne    800092 <_main+0x5a>
	{
		//EVALUATION [40%]
		testCase = 1 ;
  800089:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  800090:	eb 2a                	jmp    8000bc <_main+0x84>
	}
	else if (myEnv->page_WS_max_size == 10)
  800092:	a1 20 40 80 00       	mov    0x804020,%eax
  800097:	8b 40 74             	mov    0x74(%eax),%eax
  80009a:	83 f8 0a             	cmp    $0xa,%eax
  80009d:	75 09                	jne    8000a8 <_main+0x70>
	{
		//EVALUATION [30%]
		testCase = 2 ;
  80009f:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
  8000a6:	eb 14                	jmp    8000bc <_main+0x84>
	}
	else if (myEnv->page_WS_max_size == 26)
  8000a8:	a1 20 40 80 00       	mov    0x804020,%eax
  8000ad:	8b 40 74             	mov    0x74(%eax),%eax
  8000b0:	83 f8 1a             	cmp    $0x1a,%eax
  8000b3:	75 07                	jne    8000bc <_main+0x84>
	{
		//EVALUATION [30%]
		testCase = 3 ;
  8000b5:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
	}
	int32 envIdFib, envIdHelloWorld, helloWorldFrames;
	{
		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  8000bc:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8000c0:	74 0a                	je     8000cc <_main+0x94>
  8000c2:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8000c6:	0f 85 27 01 00 00    	jne    8001f3 <_main+0x1bb>
		{
			//Load "fib" & "fos_helloWorld" programs into RAM
			cprintf("Loading Fib & fos_helloWorld programs into RAM...");
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	68 08 30 80 00       	push   $0x803008
  8000d4:	e8 4c 17 00 00       	call   801825 <cprintf>
  8000d9:	83 c4 10             	add    $0x10,%esp
			envIdFib = sys_create_env("fib", (myEnv->page_WS_max_size), 0);
  8000dc:	a1 20 40 80 00       	mov    0x804020,%eax
  8000e1:	8b 40 74             	mov    0x74(%eax),%eax
  8000e4:	83 ec 04             	sub    $0x4,%esp
  8000e7:	6a 00                	push   $0x0
  8000e9:	50                   	push   %eax
  8000ea:	68 3a 30 80 00       	push   $0x80303a
  8000ef:	e8 7c 28 00 00       	call   802970 <sys_create_env>
  8000f4:	83 c4 10             	add    $0x10,%esp
  8000f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
			int freeFrames = sys_calculate_free_frames() ;
  8000fa:	e8 1c 26 00 00       	call   80271b <sys_calculate_free_frames>
  8000ff:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
			envIdHelloWorld = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), 0);
  800105:	a1 20 40 80 00       	mov    0x804020,%eax
  80010a:	8b 40 74             	mov    0x74(%eax),%eax
  80010d:	83 ec 04             	sub    $0x4,%esp
  800110:	6a 00                	push   $0x0
  800112:	50                   	push   %eax
  800113:	68 3e 30 80 00       	push   $0x80303e
  800118:	e8 53 28 00 00       	call   802970 <sys_create_env>
  80011d:	83 c4 10             	add    $0x10,%esp
  800120:	89 45 dc             	mov    %eax,-0x24(%ebp)
			helloWorldFrames = freeFrames - sys_calculate_free_frames() ;
  800123:	8b 9d 7c ff ff ff    	mov    -0x84(%ebp),%ebx
  800129:	e8 ed 25 00 00       	call   80271b <sys_calculate_free_frames>
  80012e:	29 c3                	sub    %eax,%ebx
  800130:	89 d8                	mov    %ebx,%eax
  800132:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
			env_sleep(2000);
  800138:	83 ec 0c             	sub    $0xc,%esp
  80013b:	68 d0 07 00 00       	push   $0x7d0
  800140:	e8 84 2a 00 00       	call   802bc9 <env_sleep>
  800145:	83 c4 10             	add    $0x10,%esp
			vcprintf("[DONE]\n\n", NULL);
  800148:	83 ec 08             	sub    $0x8,%esp
  80014b:	6a 00                	push   $0x0
  80014d:	68 4d 30 80 00       	push   $0x80304d
  800152:	e8 63 16 00 00       	call   8017ba <vcprintf>
  800157:	83 c4 10             	add    $0x10,%esp

			//Load and run "fos_add"
			cprintf("Loading fos_add program into RAM...");
  80015a:	83 ec 0c             	sub    $0xc,%esp
  80015d:	68 58 30 80 00       	push   $0x803058
  800162:	e8 be 16 00 00       	call   801825 <cprintf>
  800167:	83 c4 10             	add    $0x10,%esp
			int32 envIdFOSAdd= sys_create_env("fos_add", (myEnv->page_WS_max_size), 0);
  80016a:	a1 20 40 80 00       	mov    0x804020,%eax
  80016f:	8b 40 74             	mov    0x74(%eax),%eax
  800172:	83 ec 04             	sub    $0x4,%esp
  800175:	6a 00                	push   $0x0
  800177:	50                   	push   %eax
  800178:	68 7c 30 80 00       	push   $0x80307c
  80017d:	e8 ee 27 00 00       	call   802970 <sys_create_env>
  800182:	83 c4 10             	add    $0x10,%esp
  800185:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
			env_sleep(2000);
  80018b:	83 ec 0c             	sub    $0xc,%esp
  80018e:	68 d0 07 00 00       	push   $0x7d0
  800193:	e8 31 2a 00 00       	call   802bc9 <env_sleep>
  800198:	83 c4 10             	add    $0x10,%esp
			vcprintf("[DONE]\n\n", NULL);
  80019b:	83 ec 08             	sub    $0x8,%esp
  80019e:	6a 00                	push   $0x0
  8001a0:	68 4d 30 80 00       	push   $0x80304d
  8001a5:	e8 10 16 00 00       	call   8017ba <vcprintf>
  8001aa:	83 c4 10             	add    $0x10,%esp

			cprintf("running fos_add program...\n\n");
  8001ad:	83 ec 0c             	sub    $0xc,%esp
  8001b0:	68 84 30 80 00       	push   $0x803084
  8001b5:	e8 6b 16 00 00       	call   801825 <cprintf>
  8001ba:	83 c4 10             	add    $0x10,%esp
			sys_run_env(envIdFOSAdd);
  8001bd:	83 ec 0c             	sub    $0xc,%esp
  8001c0:	ff b5 74 ff ff ff    	pushl  -0x8c(%ebp)
  8001c6:	e8 c2 27 00 00       	call   80298d <sys_run_env>
  8001cb:	83 c4 10             	add    $0x10,%esp

			cprintf("please be patient ...\n");
  8001ce:	83 ec 0c             	sub    $0xc,%esp
  8001d1:	68 a1 30 80 00       	push   $0x8030a1
  8001d6:	e8 4a 16 00 00       	call   801825 <cprintf>
  8001db:	83 c4 10             	add    $0x10,%esp
			env_sleep(5000);
  8001de:	83 ec 0c             	sub    $0xc,%esp
  8001e1:	68 88 13 00 00       	push   $0x1388
  8001e6:	e8 de 29 00 00       	call   802bc9 <env_sleep>
  8001eb:	83 c4 10             	add    $0x10,%esp
	int32 envIdFib, envIdHelloWorld, helloWorldFrames;
	{
		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
		{
  8001ee:	e9 47 02 00 00       	jmp    80043a <_main+0x402>
				if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
			}
		}
		 */
		//CASE2: free the WS ONLY using FIFO algorithm
		else if (testCase == 2)
  8001f3:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  8001f7:	0f 85 3d 02 00 00    	jne    80043a <_main+0x402>
		{
			//("STEP 0: checking InitialWSError2: INITIAL WS entries ...\n");
			{
				if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x804000)  	panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001fd:	a1 20 40 80 00       	mov    0x804020,%eax
  800202:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800208:	8b 00                	mov    (%eax),%eax
  80020a:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  80020d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800210:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800215:	3d 00 40 80 00       	cmp    $0x804000,%eax
  80021a:	74 14                	je     800230 <_main+0x1f8>
  80021c:	83 ec 04             	sub    $0x4,%esp
  80021f:	68 b8 30 80 00       	push   $0x8030b8
  800224:	6a 57                	push   $0x57
  800226:	68 0a 31 80 00       	push   $0x80310a
  80022b:	e8 41 13 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800230:	a1 20 40 80 00       	mov    0x804020,%eax
  800235:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80023b:	83 c0 0c             	add    $0xc,%eax
  80023e:	8b 00                	mov    (%eax),%eax
  800240:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800243:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800246:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80024b:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800250:	74 14                	je     800266 <_main+0x22e>
  800252:	83 ec 04             	sub    $0x4,%esp
  800255:	68 b8 30 80 00       	push   $0x8030b8
  80025a:	6a 58                	push   $0x58
  80025c:	68 0a 31 80 00       	push   $0x80310a
  800261:	e8 0b 13 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800266:	a1 20 40 80 00       	mov    0x804020,%eax
  80026b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800271:	83 c0 18             	add    $0x18,%eax
  800274:	8b 00                	mov    (%eax),%eax
  800276:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800279:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80027c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800281:	3d 00 20 20 00       	cmp    $0x202000,%eax
  800286:	74 14                	je     80029c <_main+0x264>
  800288:	83 ec 04             	sub    $0x4,%esp
  80028b:	68 b8 30 80 00       	push   $0x8030b8
  800290:	6a 59                	push   $0x59
  800292:	68 0a 31 80 00       	push   $0x80310a
  800297:	e8 d5 12 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80029c:	a1 20 40 80 00       	mov    0x804020,%eax
  8002a1:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002a7:	83 c0 24             	add    $0x24,%eax
  8002aa:	8b 00                	mov    (%eax),%eax
  8002ac:	89 45 98             	mov    %eax,-0x68(%ebp)
  8002af:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002b7:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8002bc:	74 14                	je     8002d2 <_main+0x29a>
  8002be:	83 ec 04             	sub    $0x4,%esp
  8002c1:	68 b8 30 80 00       	push   $0x8030b8
  8002c6:	6a 5a                	push   $0x5a
  8002c8:	68 0a 31 80 00       	push   $0x80310a
  8002cd:	e8 9f 12 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002d2:	a1 20 40 80 00       	mov    0x804020,%eax
  8002d7:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002dd:	83 c0 30             	add    $0x30,%eax
  8002e0:	8b 00                	mov    (%eax),%eax
  8002e2:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8002e5:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8002e8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002ed:	3d 00 40 20 00       	cmp    $0x204000,%eax
  8002f2:	74 14                	je     800308 <_main+0x2d0>
  8002f4:	83 ec 04             	sub    $0x4,%esp
  8002f7:	68 b8 30 80 00       	push   $0x8030b8
  8002fc:	6a 5b                	push   $0x5b
  8002fe:	68 0a 31 80 00       	push   $0x80310a
  800303:	e8 69 12 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800308:	a1 20 40 80 00       	mov    0x804020,%eax
  80030d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800313:	83 c0 3c             	add    $0x3c,%eax
  800316:	8b 00                	mov    (%eax),%eax
  800318:	89 45 90             	mov    %eax,-0x70(%ebp)
  80031b:	8b 45 90             	mov    -0x70(%ebp),%eax
  80031e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800323:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800328:	74 14                	je     80033e <_main+0x306>
  80032a:	83 ec 04             	sub    $0x4,%esp
  80032d:	68 b8 30 80 00       	push   $0x8030b8
  800332:	6a 5c                	push   $0x5c
  800334:	68 0a 31 80 00       	push   $0x80310a
  800339:	e8 33 12 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80033e:	a1 20 40 80 00       	mov    0x804020,%eax
  800343:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800349:	83 c0 48             	add    $0x48,%eax
  80034c:	8b 00                	mov    (%eax),%eax
  80034e:	89 45 8c             	mov    %eax,-0x74(%ebp)
  800351:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800354:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800359:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80035e:	74 14                	je     800374 <_main+0x33c>
  800360:	83 ec 04             	sub    $0x4,%esp
  800363:	68 b8 30 80 00       	push   $0x8030b8
  800368:	6a 5d                	push   $0x5d
  80036a:	68 0a 31 80 00       	push   $0x80310a
  80036f:	e8 fd 11 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800374:	a1 20 40 80 00       	mov    0x804020,%eax
  800379:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80037f:	83 c0 54             	add    $0x54,%eax
  800382:	8b 00                	mov    (%eax),%eax
  800384:	89 45 88             	mov    %eax,-0x78(%ebp)
  800387:	8b 45 88             	mov    -0x78(%ebp),%eax
  80038a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80038f:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800394:	74 14                	je     8003aa <_main+0x372>
  800396:	83 ec 04             	sub    $0x4,%esp
  800399:	68 b8 30 80 00       	push   $0x8030b8
  80039e:	6a 5e                	push   $0x5e
  8003a0:	68 0a 31 80 00       	push   $0x80310a
  8003a5:	e8 c7 11 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8003aa:	a1 20 40 80 00       	mov    0x804020,%eax
  8003af:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003b5:	83 c0 60             	add    $0x60,%eax
  8003b8:	8b 00                	mov    (%eax),%eax
  8003ba:	89 45 84             	mov    %eax,-0x7c(%ebp)
  8003bd:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8003c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003c5:	3d 00 20 80 00       	cmp    $0x802000,%eax
  8003ca:	74 14                	je     8003e0 <_main+0x3a8>
  8003cc:	83 ec 04             	sub    $0x4,%esp
  8003cf:	68 b8 30 80 00       	push   $0x8030b8
  8003d4:	6a 5f                	push   $0x5f
  8003d6:	68 0a 31 80 00       	push   $0x80310a
  8003db:	e8 91 11 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8003e0:	a1 20 40 80 00       	mov    0x804020,%eax
  8003e5:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003eb:	83 c0 6c             	add    $0x6c,%eax
  8003ee:	8b 00                	mov    (%eax),%eax
  8003f0:	89 45 80             	mov    %eax,-0x80(%ebp)
  8003f3:	8b 45 80             	mov    -0x80(%ebp),%eax
  8003f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003fb:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800400:	74 14                	je     800416 <_main+0x3de>
  800402:	83 ec 04             	sub    $0x4,%esp
  800405:	68 b8 30 80 00       	push   $0x8030b8
  80040a:	6a 60                	push   $0x60
  80040c:	68 0a 31 80 00       	push   $0x80310a
  800411:	e8 5b 11 00 00       	call   801571 <_panic>
				if( myEnv->page_last_WS_index !=  1)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800416:	a1 20 40 80 00       	mov    0x804020,%eax
  80041b:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800421:	83 f8 01             	cmp    $0x1,%eax
  800424:	74 14                	je     80043a <_main+0x402>
  800426:	83 ec 04             	sub    $0x4,%esp
  800429:	68 20 31 80 00       	push   $0x803120
  80042e:	6a 61                	push   $0x61
  800430:	68 0a 31 80 00       	push   $0x80310a
  800435:	e8 37 11 00 00       	call   801571 <_panic>
			}
		}

		//Reading (Not Modified)
		char garbage1 = arr[PAGE_SIZE*10-1] ;
  80043a:	a0 3f e0 80 00       	mov    0x80e03f,%al
  80043f:	88 85 73 ff ff ff    	mov    %al,-0x8d(%ebp)
		char garbage2 = arr[PAGE_SIZE*11-1] ;
  800445:	a0 3f f0 80 00       	mov    0x80f03f,%al
  80044a:	88 85 72 ff ff ff    	mov    %al,-0x8e(%ebp)
		char garbage3 = arr[PAGE_SIZE*12-1] ;
  800450:	a0 3f 00 81 00       	mov    0x81003f,%al
  800455:	88 85 71 ff ff ff    	mov    %al,-0x8f(%ebp)

		char garbage4, garbage5 ;
		//Writing (Modified)
		int i ;
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  80045b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  800462:	eb 26                	jmp    80048a <_main+0x452>
		{
			arr[i] = -1 ;
  800464:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800467:	05 40 40 80 00       	add    $0x804040,%eax
  80046c:	c6 00 ff             	movb   $0xff,(%eax)
			//always use pages at 0x801000 and 0x804000
			garbage4 = *ptr ;
  80046f:	a1 00 40 80 00       	mov    0x804000,%eax
  800474:	8a 00                	mov    (%eax),%al
  800476:	88 45 db             	mov    %al,-0x25(%ebp)
			garbage5 = *ptr2 ;
  800479:	a1 04 40 80 00       	mov    0x804004,%eax
  80047e:	8a 00                	mov    (%eax),%al
  800480:	88 45 da             	mov    %al,-0x26(%ebp)
		char garbage3 = arr[PAGE_SIZE*12-1] ;

		char garbage4, garbage5 ;
		//Writing (Modified)
		int i ;
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  800483:	81 45 d4 00 08 00 00 	addl   $0x800,-0x2c(%ebp)
  80048a:	81 7d d4 ff 3f 00 00 	cmpl   $0x3fff,-0x2c(%ebp)
  800491:	7e d1                	jle    800464 <_main+0x42c>

		//===================

		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  800493:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  800497:	74 0a                	je     8004a3 <_main+0x46b>
  800499:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80049d:	0f 85 92 00 00 00    	jne    800535 <_main+0x4fd>
		{
			int i = 0;
  8004a3:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
			numOfExistPages = 0;
  8004aa:	c7 05 40 00 81 00 00 	movl   $0x0,0x810040
  8004b1:	00 00 00 
			for (i = 0; i < myEnv->page_WS_max_size; ++i)
  8004b4:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8004bb:	eb 64                	jmp    800521 <_main+0x4e9>
			{
				if (!myEnv->__uptr_pws[i].empty)
  8004bd:	a1 20 40 80 00       	mov    0x804020,%eax
  8004c2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004c8:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8004cb:	89 d0                	mov    %edx,%eax
  8004cd:	01 c0                	add    %eax,%eax
  8004cf:	01 d0                	add    %edx,%eax
  8004d1:	c1 e0 02             	shl    $0x2,%eax
  8004d4:	01 c8                	add    %ecx,%eax
  8004d6:	8a 40 04             	mov    0x4(%eax),%al
  8004d9:	84 c0                	test   %al,%al
  8004db:	75 41                	jne    80051e <_main+0x4e6>
				{
					WSEntries_before[numOfExistPages++] = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address, PAGE_SIZE);
  8004dd:	8b 15 40 00 81 00    	mov    0x810040,%edx
  8004e3:	8d 42 01             	lea    0x1(%edx),%eax
  8004e6:	a3 40 00 81 00       	mov    %eax,0x810040
  8004eb:	a1 20 40 80 00       	mov    0x804020,%eax
  8004f0:	8b 98 34 03 00 00    	mov    0x334(%eax),%ebx
  8004f6:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  8004f9:	89 c8                	mov    %ecx,%eax
  8004fb:	01 c0                	add    %eax,%eax
  8004fd:	01 c8                	add    %ecx,%eax
  8004ff:	c1 e0 02             	shl    $0x2,%eax
  800502:	01 d8                	add    %ebx,%eax
  800504:	8b 00                	mov    (%eax),%eax
  800506:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  80050c:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800512:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800517:	89 04 95 60 00 81 00 	mov    %eax,0x810060(,%edx,4)
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
		{
			int i = 0;
			numOfExistPages = 0;
			for (i = 0; i < myEnv->page_WS_max_size; ++i)
  80051e:	ff 45 d0             	incl   -0x30(%ebp)
  800521:	a1 20 40 80 00       	mov    0x804020,%eax
  800526:	8b 50 74             	mov    0x74(%eax),%edx
  800529:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80052c:	39 c2                	cmp    %eax,%edx
  80052e:	77 8d                	ja     8004bd <_main+0x485>
		//===================

		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
		{
  800530:	e9 a4 02 00 00       	jmp    8007d9 <_main+0x7a1>
				if(myEnv->page_last_WS_index != 9) panic("wrong PAGE WS pointer location");
			}
		}
		 */
		//CASE2: free the WS ONLY using FIFO algorithm
		else if (testCase == 2)
  800535:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  800539:	0f 85 9a 02 00 00    	jne    8007d9 <_main+0x7a1>
		{
			//cprintf("Checking PAGE FIFO algorithm... \n");
			{
				if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80053f:	a1 20 40 80 00       	mov    0x804020,%eax
  800544:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80054a:	8b 00                	mov    (%eax),%eax
  80054c:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800552:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800558:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80055d:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800562:	74 17                	je     80057b <_main+0x543>
  800564:	83 ec 04             	sub    $0x4,%esp
  800567:	68 78 31 80 00       	push   $0x803178
  80056c:	68 9e 00 00 00       	push   $0x9e
  800571:	68 0a 31 80 00       	push   $0x80310a
  800576:	e8 f6 0f 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80e000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80057b:	a1 20 40 80 00       	mov    0x804020,%eax
  800580:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800586:	83 c0 0c             	add    $0xc,%eax
  800589:	8b 00                	mov    (%eax),%eax
  80058b:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800591:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800597:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80059c:	3d 00 e0 80 00       	cmp    $0x80e000,%eax
  8005a1:	74 17                	je     8005ba <_main+0x582>
  8005a3:	83 ec 04             	sub    $0x4,%esp
  8005a6:	68 78 31 80 00       	push   $0x803178
  8005ab:	68 9f 00 00 00       	push   $0x9f
  8005b0:	68 0a 31 80 00       	push   $0x80310a
  8005b5:	e8 b7 0f 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x80f000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8005ba:	a1 20 40 80 00       	mov    0x804020,%eax
  8005bf:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8005c5:	83 c0 18             	add    $0x18,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  8005d0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  8005d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005db:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  8005e0:	74 17                	je     8005f9 <_main+0x5c1>
  8005e2:	83 ec 04             	sub    $0x4,%esp
  8005e5:	68 78 31 80 00       	push   $0x803178
  8005ea:	68 a0 00 00 00       	push   $0xa0
  8005ef:	68 0a 31 80 00       	push   $0x80310a
  8005f4:	e8 78 0f 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x810000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8005f9:	a1 20 40 80 00       	mov    0x804020,%eax
  8005fe:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800604:	83 c0 24             	add    $0x24,%eax
  800607:	8b 00                	mov    (%eax),%eax
  800609:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  80060f:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800615:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80061a:	3d 00 00 81 00       	cmp    $0x810000,%eax
  80061f:	74 17                	je     800638 <_main+0x600>
  800621:	83 ec 04             	sub    $0x4,%esp
  800624:	68 78 31 80 00       	push   $0x803178
  800629:	68 a1 00 00 00       	push   $0xa1
  80062e:	68 0a 31 80 00       	push   $0x80310a
  800633:	e8 39 0f 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x805000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800638:	a1 20 40 80 00       	mov    0x804020,%eax
  80063d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800643:	83 c0 30             	add    $0x30,%eax
  800646:	8b 00                	mov    (%eax),%eax
  800648:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  80064e:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800654:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800659:	3d 00 50 80 00       	cmp    $0x805000,%eax
  80065e:	74 17                	je     800677 <_main+0x63f>
  800660:	83 ec 04             	sub    $0x4,%esp
  800663:	68 78 31 80 00       	push   $0x803178
  800668:	68 a2 00 00 00       	push   $0xa2
  80066d:	68 0a 31 80 00       	push   $0x80310a
  800672:	e8 fa 0e 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x806000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800677:	a1 20 40 80 00       	mov    0x804020,%eax
  80067c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800682:	83 c0 3c             	add    $0x3c,%eax
  800685:	8b 00                	mov    (%eax),%eax
  800687:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  80068d:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800693:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800698:	3d 00 60 80 00       	cmp    $0x806000,%eax
  80069d:	74 17                	je     8006b6 <_main+0x67e>
  80069f:	83 ec 04             	sub    $0x4,%esp
  8006a2:	68 78 31 80 00       	push   $0x803178
  8006a7:	68 a3 00 00 00       	push   $0xa3
  8006ac:	68 0a 31 80 00       	push   $0x80310a
  8006b1:	e8 bb 0e 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8006b6:	a1 20 40 80 00       	mov    0x804020,%eax
  8006bb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8006c1:	83 c0 48             	add    $0x48,%eax
  8006c4:	8b 00                	mov    (%eax),%eax
  8006c6:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  8006cc:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  8006d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006d7:	3d 00 70 80 00       	cmp    $0x807000,%eax
  8006dc:	74 17                	je     8006f5 <_main+0x6bd>
  8006de:	83 ec 04             	sub    $0x4,%esp
  8006e1:	68 78 31 80 00       	push   $0x803178
  8006e6:	68 a4 00 00 00       	push   $0xa4
  8006eb:	68 0a 31 80 00       	push   $0x80310a
  8006f0:	e8 7c 0e 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8006f5:	a1 20 40 80 00       	mov    0x804020,%eax
  8006fa:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800700:	83 c0 54             	add    $0x54,%eax
  800703:	8b 00                	mov    (%eax),%eax
  800705:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  80070b:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800711:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800716:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80071b:	74 17                	je     800734 <_main+0x6fc>
  80071d:	83 ec 04             	sub    $0x4,%esp
  800720:	68 78 31 80 00       	push   $0x803178
  800725:	68 a5 00 00 00       	push   $0xa5
  80072a:	68 0a 31 80 00       	push   $0x80310a
  80072f:	e8 3d 0e 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800734:	a1 20 40 80 00       	mov    0x804020,%eax
  800739:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80073f:	83 c0 60             	add    $0x60,%eax
  800742:	8b 00                	mov    (%eax),%eax
  800744:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  80074a:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800750:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800755:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80075a:	74 17                	je     800773 <_main+0x73b>
  80075c:	83 ec 04             	sub    $0x4,%esp
  80075f:	68 78 31 80 00       	push   $0x803178
  800764:	68 a6 00 00 00       	push   $0xa6
  800769:	68 0a 31 80 00       	push   $0x80310a
  80076e:	e8 fe 0d 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800773:	a1 20 40 80 00       	mov    0x804020,%eax
  800778:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80077e:	83 c0 6c             	add    $0x6c,%eax
  800781:	8b 00                	mov    (%eax),%eax
  800783:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800789:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  80078f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800794:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800799:	74 17                	je     8007b2 <_main+0x77a>
  80079b:	83 ec 04             	sub    $0x4,%esp
  80079e:	68 78 31 80 00       	push   $0x803178
  8007a3:	68 a7 00 00 00       	push   $0xa7
  8007a8:	68 0a 31 80 00       	push   $0x80310a
  8007ad:	e8 bf 0d 00 00       	call   801571 <_panic>

				if(myEnv->page_last_WS_index != 9) panic("wrong PAGE WS pointer location");
  8007b2:	a1 20 40 80 00       	mov    0x804020,%eax
  8007b7:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  8007bd:	83 f8 09             	cmp    $0x9,%eax
  8007c0:	74 17                	je     8007d9 <_main+0x7a1>
  8007c2:	83 ec 04             	sub    $0x4,%esp
  8007c5:	68 c4 31 80 00       	push   $0x8031c4
  8007ca:	68 a9 00 00 00       	push   $0xa9
  8007cf:	68 0a 31 80 00       	push   $0x80310a
  8007d4:	e8 98 0d 00 00       	call   801571 <_panic>
			}
		}

		//=========================================================//
		//Clear the FFL
		sys_clear_ffl();
  8007d9:	e8 67 20 00 00       	call   802845 <sys_clear_ffl>
		//=========================================================//

		//Writing (Modified) after freeing the entire FFL:
		//	3 frames should be allocated (stack page, mem table, page file table)
		*ptr3 = garbage1 ;
  8007de:	a1 08 40 80 00       	mov    0x804008,%eax
  8007e3:	8a 95 73 ff ff ff    	mov    -0x8d(%ebp),%dl
  8007e9:	88 10                	mov    %dl,(%eax)
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  8007eb:	a1 00 40 80 00       	mov    0x804000,%eax
  8007f0:	8a 00                	mov    (%eax),%al
  8007f2:	88 45 db             	mov    %al,-0x25(%ebp)
		garbage5 = *ptr2 ;
  8007f5:	a1 04 40 80 00       	mov    0x804004,%eax
  8007fa:	8a 00                	mov    (%eax),%al
  8007fc:	88 45 da             	mov    %al,-0x26(%ebp)

		//CASE1: free the exited env's ONLY
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  8007ff:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  800803:	74 0a                	je     80080f <_main+0x7d7>
  800805:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800809:	0f 85 99 00 00 00    	jne    8008a8 <_main+0x870>
		{
			//Add the last reference to our WS
			WSEntries_before[numOfExistPages++] = ROUNDDOWN((uint32)(ptr3), PAGE_SIZE);
  80080f:	a1 40 00 81 00       	mov    0x810040,%eax
  800814:	8d 50 01             	lea    0x1(%eax),%edx
  800817:	89 15 40 00 81 00    	mov    %edx,0x810040
  80081d:	8b 15 08 40 80 00    	mov    0x804008,%edx
  800823:	89 95 3c ff ff ff    	mov    %edx,-0xc4(%ebp)
  800829:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  80082f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  800835:	89 14 85 60 00 81 00 	mov    %edx,0x810060(,%eax,4)

			//Make sure that WS is not affected
			for (i = 0; i < numOfExistPages; ++i)
  80083c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  800843:	eb 54                	jmp    800899 <_main+0x861>
			{
				if (WSEntries_before[i] != ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address, PAGE_SIZE))
  800845:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800848:	8b 0c 85 60 00 81 00 	mov    0x810060(,%eax,4),%ecx
  80084f:	a1 20 40 80 00       	mov    0x804020,%eax
  800854:	8b 98 34 03 00 00    	mov    0x334(%eax),%ebx
  80085a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80085d:	89 d0                	mov    %edx,%eax
  80085f:	01 c0                	add    %eax,%eax
  800861:	01 d0                	add    %edx,%eax
  800863:	c1 e0 02             	shl    $0x2,%eax
  800866:	01 d8                	add    %ebx,%eax
  800868:	8b 00                	mov    (%eax),%eax
  80086a:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  800870:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800876:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80087b:	39 c1                	cmp    %eax,%ecx
  80087d:	74 17                	je     800896 <_main+0x85e>
					panic("FreeRAM.Scenario1 or 3: WS is changed while not expected to!");
  80087f:	83 ec 04             	sub    $0x4,%esp
  800882:	68 e4 31 80 00       	push   $0x8031e4
  800887:	68 c4 00 00 00       	push   $0xc4
  80088c:	68 0a 31 80 00       	push   $0x80310a
  800891:	e8 db 0c 00 00       	call   801571 <_panic>
		{
			//Add the last reference to our WS
			WSEntries_before[numOfExistPages++] = ROUNDDOWN((uint32)(ptr3), PAGE_SIZE);

			//Make sure that WS is not affected
			for (i = 0; i < numOfExistPages; ++i)
  800896:	ff 45 d4             	incl   -0x2c(%ebp)
  800899:	a1 40 00 81 00       	mov    0x810040,%eax
  80089e:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  8008a1:	7c a2                	jl     800845 <_main+0x80d>
		garbage4 = *ptr ;
		garbage5 = *ptr2 ;

		//CASE1: free the exited env's ONLY
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  8008a3:	e9 45 01 00 00       	jmp    8009ed <_main+0x9b5>
				if (WSEntries_before[i] != ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address, PAGE_SIZE))
					panic("FreeRAM.Scenario1 or 3: WS is changed while not expected to!");
			}
		}
		//Case2: free the WS ONLY by clock algorithm
		else if (testCase == 2)
  8008a8:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  8008ac:	0f 85 3b 01 00 00    	jne    8009ed <_main+0x9b5>
			}
			 */

			//Check the WS after FIFO algorithm

			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");
  8008b2:	a1 00 40 80 00       	mov    0x804000,%eax
  8008b7:	8a 00                	mov    (%eax),%al
  8008b9:	3a 45 db             	cmp    -0x25(%ebp),%al
  8008bc:	75 0c                	jne    8008ca <_main+0x892>
  8008be:	a1 04 40 80 00       	mov    0x804004,%eax
  8008c3:	8a 00                	mov    (%eax),%al
  8008c5:	3a 45 da             	cmp    -0x26(%ebp),%al
  8008c8:	74 17                	je     8008e1 <_main+0x8a9>
  8008ca:	83 ec 04             	sub    $0x4,%esp
  8008cd:	68 21 32 80 00       	push   $0x803221
  8008d2:	68 d7 00 00 00       	push   $0xd7
  8008d7:	68 0a 31 80 00       	push   $0x80310a
  8008dc:	e8 90 0c 00 00       	call   801571 <_panic>

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
  8008e1:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8008e8:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  8008ef:	eb 26                	jmp    800917 <_main+0x8df>
			{
				if (myEnv->__uptr_pws[i].empty)
  8008f1:	a1 20 40 80 00       	mov    0x804020,%eax
  8008f6:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008fc:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8008ff:	89 d0                	mov    %edx,%eax
  800901:	01 c0                	add    %eax,%eax
  800903:	01 d0                	add    %edx,%eax
  800905:	c1 e0 02             	shl    $0x2,%eax
  800908:	01 c8                	add    %ecx,%eax
  80090a:	8a 40 04             	mov    0x4(%eax),%al
  80090d:	84 c0                	test   %al,%al
  80090f:	74 03                	je     800914 <_main+0x8dc>
					numOfEmptyLocs++ ;
  800911:	ff 45 cc             	incl   -0x34(%ebp)

			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800914:	ff 45 c8             	incl   -0x38(%ebp)
  800917:	a1 20 40 80 00       	mov    0x804020,%eax
  80091c:	8b 50 74             	mov    0x74(%eax),%edx
  80091f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800922:	39 c2                	cmp    %eax,%edx
  800924:	77 cb                	ja     8008f1 <_main+0x8b9>
			{
				if (myEnv->__uptr_pws[i].empty)
					numOfEmptyLocs++ ;
			}
			if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");
  800926:	83 7d cc 02          	cmpl   $0x2,-0x34(%ebp)
  80092a:	74 17                	je     800943 <_main+0x90b>
  80092c:	83 ec 04             	sub    $0x4,%esp
  80092f:	68 30 32 80 00       	push   $0x803230
  800934:	68 e0 00 00 00       	push   $0xe0
  800939:	68 0a 31 80 00       	push   $0x80310a
  80093e:	e8 2e 0c 00 00       	call   801571 <_panic>

			uint32 expectedAddresses[8] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x807000,0xee7fe000,0xeebfd000} ;
  800943:	8d 85 6c fe ff ff    	lea    -0x194(%ebp),%eax
  800949:	bb 40 33 80 00       	mov    $0x803340,%ebx
  80094e:	ba 08 00 00 00       	mov    $0x8,%edx
  800953:	89 c7                	mov    %eax,%edi
  800955:	89 de                	mov    %ebx,%esi
  800957:	89 d1                	mov    %edx,%ecx
  800959:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
			int numOfFoundedAddresses = 0;
  80095b:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
			for (int j = 0; j < 8; j++)
  800962:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
  800969:	eb 5f                	jmp    8009ca <_main+0x992>
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  80096b:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  800972:	eb 44                	jmp    8009b8 <_main+0x980>
				{
					if (ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == expectedAddresses[j])
  800974:	a1 20 40 80 00       	mov    0x804020,%eax
  800979:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80097f:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800982:	89 d0                	mov    %edx,%eax
  800984:	01 c0                	add    %eax,%eax
  800986:	01 d0                	add    %edx,%eax
  800988:	c1 e0 02             	shl    $0x2,%eax
  80098b:	01 c8                	add    %ecx,%eax
  80098d:	8b 00                	mov    (%eax),%eax
  80098f:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800995:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  80099b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009a0:	89 c2                	mov    %eax,%edx
  8009a2:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8009a5:	8b 84 85 6c fe ff ff 	mov    -0x194(%ebp,%eax,4),%eax
  8009ac:	39 c2                	cmp    %eax,%edx
  8009ae:	75 05                	jne    8009b5 <_main+0x97d>
					{
						numOfFoundedAddresses++;
  8009b0:	ff 45 c4             	incl   -0x3c(%ebp)
						break;
  8009b3:	eb 12                	jmp    8009c7 <_main+0x98f>

			uint32 expectedAddresses[8] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x807000,0xee7fe000,0xeebfd000} ;
			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 8; j++)
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8009b5:	ff 45 bc             	incl   -0x44(%ebp)
  8009b8:	a1 20 40 80 00       	mov    0x804020,%eax
  8009bd:	8b 50 74             	mov    0x74(%eax),%edx
  8009c0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8009c3:	39 c2                	cmp    %eax,%edx
  8009c5:	77 ad                	ja     800974 <_main+0x93c>
			}
			if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");

			uint32 expectedAddresses[8] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x807000,0xee7fe000,0xeebfd000} ;
			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 8; j++)
  8009c7:	ff 45 c0             	incl   -0x40(%ebp)
  8009ca:	83 7d c0 07          	cmpl   $0x7,-0x40(%ebp)
  8009ce:	7e 9b                	jle    80096b <_main+0x933>
						numOfFoundedAddresses++;
						break;
					}
				}
			}
			if (numOfFoundedAddresses != 8) panic("test failed! either wrong victim or victim is not removed from WS");
  8009d0:	83 7d c4 08          	cmpl   $0x8,-0x3c(%ebp)
  8009d4:	74 17                	je     8009ed <_main+0x9b5>
  8009d6:	83 ec 04             	sub    $0x4,%esp
  8009d9:	68 30 32 80 00       	push   $0x803230
  8009de:	68 ef 00 00 00       	push   $0xef
  8009e3:	68 0a 31 80 00       	push   $0x80310a
  8009e8:	e8 84 0b 00 00       	call   801571 <_panic>

		}


		//Case1: free the exited env's ONLY
		if (testCase ==1)
  8009ed:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8009f1:	0f 85 81 00 00 00    	jne    800a78 <_main+0xa40>
		{
			cprintf("running fos_helloWorld program...\n\n");
  8009f7:	83 ec 0c             	sub    $0xc,%esp
  8009fa:	68 74 32 80 00       	push   $0x803274
  8009ff:	e8 21 0e 00 00       	call   801825 <cprintf>
  800a04:	83 c4 10             	add    $0x10,%esp
			sys_run_env(envIdHelloWorld);
  800a07:	83 ec 0c             	sub    $0xc,%esp
  800a0a:	ff 75 dc             	pushl  -0x24(%ebp)
  800a0d:	e8 7b 1f 00 00       	call   80298d <sys_run_env>
  800a12:	83 c4 10             	add    $0x10,%esp
			cprintf("please be patient ...\n");
  800a15:	83 ec 0c             	sub    $0xc,%esp
  800a18:	68 a1 30 80 00       	push   $0x8030a1
  800a1d:	e8 03 0e 00 00       	call   801825 <cprintf>
  800a22:	83 c4 10             	add    $0x10,%esp
			env_sleep(3000);
  800a25:	83 ec 0c             	sub    $0xc,%esp
  800a28:	68 b8 0b 00 00       	push   $0xbb8
  800a2d:	e8 97 21 00 00       	call   802bc9 <env_sleep>
  800a32:	83 c4 10             	add    $0x10,%esp

			cprintf("running fos_fib program...\n\n");
  800a35:	83 ec 0c             	sub    $0xc,%esp
  800a38:	68 98 32 80 00       	push   $0x803298
  800a3d:	e8 e3 0d 00 00       	call   801825 <cprintf>
  800a42:	83 c4 10             	add    $0x10,%esp
			sys_run_env(envIdFib);
  800a45:	83 ec 0c             	sub    $0xc,%esp
  800a48:	ff 75 e0             	pushl  -0x20(%ebp)
  800a4b:	e8 3d 1f 00 00       	call   80298d <sys_run_env>
  800a50:	83 c4 10             	add    $0x10,%esp
			cprintf("please be patient ...\n");
  800a53:	83 ec 0c             	sub    $0xc,%esp
  800a56:	68 a1 30 80 00       	push   $0x8030a1
  800a5b:	e8 c5 0d 00 00       	call   801825 <cprintf>
  800a60:	83 c4 10             	add    $0x10,%esp
			env_sleep(5000);
  800a63:	83 ec 0c             	sub    $0xc,%esp
  800a66:	68 88 13 00 00       	push   $0x1388
  800a6b:	e8 59 21 00 00       	call   802bc9 <env_sleep>
  800a70:	83 c4 10             	add    $0x10,%esp
  800a73:	e9 56 08 00 00       	jmp    8012ce <_main+0x1296>
		}
		//CASE3: free BOTH exited env's and WS
		else if (testCase ==3)
  800a78:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800a7c:	0f 85 4c 08 00 00    	jne    8012ce <_main+0x1296>
				if( ROUNDDOWN(myEnv->__uptr_pws[24].virtual_address,PAGE_SIZE) !=   0xee7fe000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
				if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
			}
			 */

			cprintf("Checking PAGE FIFO algorithm... \n");
  800a82:	83 ec 0c             	sub    $0xc,%esp
  800a85:	68 b8 32 80 00       	push   $0x8032b8
  800a8a:	e8 96 0d 00 00       	call   801825 <cprintf>
  800a8f:	83 c4 10             	add    $0x10,%esp
			{
				if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800a92:	a1 20 40 80 00       	mov    0x804020,%eax
  800a97:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800a9d:	8b 00                	mov    (%eax),%eax
  800a9f:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800aa5:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800aab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ab0:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800ab5:	74 17                	je     800ace <_main+0xa96>
  800ab7:	83 ec 04             	sub    $0x4,%esp
  800aba:	68 b8 30 80 00       	push   $0x8030b8
  800abf:	68 25 01 00 00       	push   $0x125
  800ac4:	68 0a 31 80 00       	push   $0x80310a
  800ac9:	e8 a3 0a 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ace:	a1 20 40 80 00       	mov    0x804020,%eax
  800ad3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800ad9:	83 c0 0c             	add    $0xc,%eax
  800adc:	8b 00                	mov    (%eax),%eax
  800ade:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800ae4:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800aea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800aef:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800af4:	74 17                	je     800b0d <_main+0xad5>
  800af6:	83 ec 04             	sub    $0x4,%esp
  800af9:	68 b8 30 80 00       	push   $0x8030b8
  800afe:	68 26 01 00 00       	push   $0x126
  800b03:	68 0a 31 80 00       	push   $0x80310a
  800b08:	e8 64 0a 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800b0d:	a1 20 40 80 00       	mov    0x804020,%eax
  800b12:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800b18:	83 c0 18             	add    $0x18,%eax
  800b1b:	8b 00                	mov    (%eax),%eax
  800b1d:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800b23:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800b29:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b2e:	3d 00 20 20 00       	cmp    $0x202000,%eax
  800b33:	74 17                	je     800b4c <_main+0xb14>
  800b35:	83 ec 04             	sub    $0x4,%esp
  800b38:	68 b8 30 80 00       	push   $0x8030b8
  800b3d:	68 27 01 00 00       	push   $0x127
  800b42:	68 0a 31 80 00       	push   $0x80310a
  800b47:	e8 25 0a 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800b4c:	a1 20 40 80 00       	mov    0x804020,%eax
  800b51:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800b57:	83 c0 24             	add    $0x24,%eax
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800b62:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800b68:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b6d:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800b72:	74 17                	je     800b8b <_main+0xb53>
  800b74:	83 ec 04             	sub    $0x4,%esp
  800b77:	68 b8 30 80 00       	push   $0x8030b8
  800b7c:	68 28 01 00 00       	push   $0x128
  800b81:	68 0a 31 80 00       	push   $0x80310a
  800b86:	e8 e6 09 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800b8b:	a1 20 40 80 00       	mov    0x804020,%eax
  800b90:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800b96:	83 c0 30             	add    $0x30,%eax
  800b99:	8b 00                	mov    (%eax),%eax
  800b9b:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  800ba1:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800ba7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bac:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800bb1:	74 17                	je     800bca <_main+0xb92>
  800bb3:	83 ec 04             	sub    $0x4,%esp
  800bb6:	68 b8 30 80 00       	push   $0x8030b8
  800bbb:	68 29 01 00 00       	push   $0x129
  800bc0:	68 0a 31 80 00       	push   $0x80310a
  800bc5:	e8 a7 09 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800bca:	a1 20 40 80 00       	mov    0x804020,%eax
  800bcf:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800bd5:	83 c0 3c             	add    $0x3c,%eax
  800bd8:	8b 00                	mov    (%eax),%eax
  800bda:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
  800be0:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800be6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800beb:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800bf0:	74 17                	je     800c09 <_main+0xbd1>
  800bf2:	83 ec 04             	sub    $0x4,%esp
  800bf5:	68 b8 30 80 00       	push   $0x8030b8
  800bfa:	68 2a 01 00 00       	push   $0x12a
  800bff:	68 0a 31 80 00       	push   $0x80310a
  800c04:	e8 68 09 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800c09:	a1 20 40 80 00       	mov    0x804020,%eax
  800c0e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800c14:	83 c0 48             	add    $0x48,%eax
  800c17:	8b 00                	mov    (%eax),%eax
  800c19:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  800c1f:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  800c25:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c2a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800c2f:	74 17                	je     800c48 <_main+0xc10>
  800c31:	83 ec 04             	sub    $0x4,%esp
  800c34:	68 b8 30 80 00       	push   $0x8030b8
  800c39:	68 2b 01 00 00       	push   $0x12b
  800c3e:	68 0a 31 80 00       	push   $0x80310a
  800c43:	e8 29 09 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800c48:	a1 20 40 80 00       	mov    0x804020,%eax
  800c4d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800c53:	83 c0 54             	add    $0x54,%eax
  800c56:	8b 00                	mov    (%eax),%eax
  800c58:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  800c5e:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  800c64:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c69:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800c6e:	74 17                	je     800c87 <_main+0xc4f>
  800c70:	83 ec 04             	sub    $0x4,%esp
  800c73:	68 b8 30 80 00       	push   $0x8030b8
  800c78:	68 2c 01 00 00       	push   $0x12c
  800c7d:	68 0a 31 80 00       	push   $0x80310a
  800c82:	e8 ea 08 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800c87:	a1 20 40 80 00       	mov    0x804020,%eax
  800c8c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800c92:	83 c0 60             	add    $0x60,%eax
  800c95:	8b 00                	mov    (%eax),%eax
  800c97:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  800c9d:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  800ca3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ca8:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800cad:	74 17                	je     800cc6 <_main+0xc8e>
  800caf:	83 ec 04             	sub    $0x4,%esp
  800cb2:	68 b8 30 80 00       	push   $0x8030b8
  800cb7:	68 2d 01 00 00       	push   $0x12d
  800cbc:	68 0a 31 80 00       	push   $0x80310a
  800cc1:	e8 ab 08 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800cc6:	a1 20 40 80 00       	mov    0x804020,%eax
  800ccb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800cd1:	83 c0 6c             	add    $0x6c,%eax
  800cd4:	8b 00                	mov    (%eax),%eax
  800cd6:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  800cdc:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  800ce2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ce7:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800cec:	74 17                	je     800d05 <_main+0xccd>
  800cee:	83 ec 04             	sub    $0x4,%esp
  800cf1:	68 b8 30 80 00       	push   $0x8030b8
  800cf6:	68 2e 01 00 00       	push   $0x12e
  800cfb:	68 0a 31 80 00       	push   $0x80310a
  800d00:	e8 6c 08 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x804000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800d05:	a1 20 40 80 00       	mov    0x804020,%eax
  800d0a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800d10:	83 c0 78             	add    $0x78,%eax
  800d13:	8b 00                	mov    (%eax),%eax
  800d15:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
  800d1b:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  800d21:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d26:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800d2b:	74 17                	je     800d44 <_main+0xd0c>
  800d2d:	83 ec 04             	sub    $0x4,%esp
  800d30:	68 b8 30 80 00       	push   $0x8030b8
  800d35:	68 2f 01 00 00       	push   $0x12f
  800d3a:	68 0a 31 80 00       	push   $0x80310a
  800d3f:	e8 2d 08 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0x805000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800d44:	a1 20 40 80 00       	mov    0x804020,%eax
  800d49:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800d4f:	05 84 00 00 00       	add    $0x84,%eax
  800d54:	8b 00                	mov    (%eax),%eax
  800d56:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  800d5c:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  800d62:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d67:	3d 00 50 80 00       	cmp    $0x805000,%eax
  800d6c:	74 17                	je     800d85 <_main+0xd4d>
  800d6e:	83 ec 04             	sub    $0x4,%esp
  800d71:	68 b8 30 80 00       	push   $0x8030b8
  800d76:	68 30 01 00 00       	push   $0x130
  800d7b:	68 0a 31 80 00       	push   $0x80310a
  800d80:	e8 ec 07 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[12].virtual_address,PAGE_SIZE) !=   0x806000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800d85:	a1 20 40 80 00       	mov    0x804020,%eax
  800d8a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800d90:	05 90 00 00 00       	add    $0x90,%eax
  800d95:	8b 00                	mov    (%eax),%eax
  800d97:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  800d9d:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  800da3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800da8:	3d 00 60 80 00       	cmp    $0x806000,%eax
  800dad:	74 17                	je     800dc6 <_main+0xd8e>
  800daf:	83 ec 04             	sub    $0x4,%esp
  800db2:	68 b8 30 80 00       	push   $0x8030b8
  800db7:	68 31 01 00 00       	push   $0x131
  800dbc:	68 0a 31 80 00       	push   $0x80310a
  800dc1:	e8 ab 07 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[13].virtual_address,PAGE_SIZE) !=   0x807000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800dc6:	a1 20 40 80 00       	mov    0x804020,%eax
  800dcb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800dd1:	05 9c 00 00 00       	add    $0x9c,%eax
  800dd6:	8b 00                	mov    (%eax),%eax
  800dd8:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  800dde:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  800de4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800de9:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800dee:	74 17                	je     800e07 <_main+0xdcf>
  800df0:	83 ec 04             	sub    $0x4,%esp
  800df3:	68 b8 30 80 00       	push   $0x8030b8
  800df8:	68 32 01 00 00       	push   $0x132
  800dfd:	68 0a 31 80 00       	push   $0x80310a
  800e02:	e8 6a 07 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=   0x808000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800e07:	a1 20 40 80 00       	mov    0x804020,%eax
  800e0c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800e12:	05 a8 00 00 00       	add    $0xa8,%eax
  800e17:	8b 00                	mov    (%eax),%eax
  800e19:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  800e1f:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  800e25:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e2a:	3d 00 80 80 00       	cmp    $0x808000,%eax
  800e2f:	74 17                	je     800e48 <_main+0xe10>
  800e31:	83 ec 04             	sub    $0x4,%esp
  800e34:	68 b8 30 80 00       	push   $0x8030b8
  800e39:	68 33 01 00 00       	push   $0x133
  800e3e:	68 0a 31 80 00       	push   $0x80310a
  800e43:	e8 29 07 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=   0x809000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800e48:	a1 20 40 80 00       	mov    0x804020,%eax
  800e4d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800e53:	05 b4 00 00 00       	add    $0xb4,%eax
  800e58:	8b 00                	mov    (%eax),%eax
  800e5a:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
  800e60:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800e66:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e6b:	3d 00 90 80 00       	cmp    $0x809000,%eax
  800e70:	74 17                	je     800e89 <_main+0xe51>
  800e72:	83 ec 04             	sub    $0x4,%esp
  800e75:	68 b8 30 80 00       	push   $0x8030b8
  800e7a:	68 34 01 00 00       	push   $0x134
  800e7f:	68 0a 31 80 00       	push   $0x80310a
  800e84:	e8 e8 06 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[16].virtual_address,PAGE_SIZE) !=   0x80A000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800e89:	a1 20 40 80 00       	mov    0x804020,%eax
  800e8e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800e94:	05 c0 00 00 00       	add    $0xc0,%eax
  800e99:	8b 00                	mov    (%eax),%eax
  800e9b:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
  800ea1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800ea7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800eac:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  800eb1:	74 17                	je     800eca <_main+0xe92>
  800eb3:	83 ec 04             	sub    $0x4,%esp
  800eb6:	68 b8 30 80 00       	push   $0x8030b8
  800ebb:	68 35 01 00 00       	push   $0x135
  800ec0:	68 0a 31 80 00       	push   $0x80310a
  800ec5:	e8 a7 06 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[17].virtual_address,PAGE_SIZE) !=   0x80B000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800eca:	a1 20 40 80 00       	mov    0x804020,%eax
  800ecf:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800ed5:	05 cc 00 00 00       	add    $0xcc,%eax
  800eda:	8b 00                	mov    (%eax),%eax
  800edc:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
  800ee2:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  800ee8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800eed:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  800ef2:	74 17                	je     800f0b <_main+0xed3>
  800ef4:	83 ec 04             	sub    $0x4,%esp
  800ef7:	68 b8 30 80 00       	push   $0x8030b8
  800efc:	68 36 01 00 00       	push   $0x136
  800f01:	68 0a 31 80 00       	push   $0x80310a
  800f06:	e8 66 06 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[18].virtual_address,PAGE_SIZE) !=   0x80C000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800f0b:	a1 20 40 80 00       	mov    0x804020,%eax
  800f10:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800f16:	05 d8 00 00 00       	add    $0xd8,%eax
  800f1b:	8b 00                	mov    (%eax),%eax
  800f1d:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  800f23:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800f29:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f2e:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800f33:	74 17                	je     800f4c <_main+0xf14>
  800f35:	83 ec 04             	sub    $0x4,%esp
  800f38:	68 b8 30 80 00       	push   $0x8030b8
  800f3d:	68 37 01 00 00       	push   $0x137
  800f42:	68 0a 31 80 00       	push   $0x80310a
  800f47:	e8 25 06 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[19].virtual_address,PAGE_SIZE) !=   0x80D000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800f4c:	a1 20 40 80 00       	mov    0x804020,%eax
  800f51:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800f57:	05 e4 00 00 00       	add    $0xe4,%eax
  800f5c:	8b 00                	mov    (%eax),%eax
  800f5e:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
  800f64:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  800f6a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f6f:	3d 00 d0 80 00       	cmp    $0x80d000,%eax
  800f74:	74 17                	je     800f8d <_main+0xf55>
  800f76:	83 ec 04             	sub    $0x4,%esp
  800f79:	68 b8 30 80 00       	push   $0x8030b8
  800f7e:	68 38 01 00 00       	push   $0x138
  800f83:	68 0a 31 80 00       	push   $0x80310a
  800f88:	e8 e4 05 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[20].virtual_address,PAGE_SIZE) !=   0x80E000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800f8d:	a1 20 40 80 00       	mov    0x804020,%eax
  800f92:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800f98:	05 f0 00 00 00       	add    $0xf0,%eax
  800f9d:	8b 00                	mov    (%eax),%eax
  800f9f:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
  800fa5:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800fab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800fb0:	3d 00 e0 80 00       	cmp    $0x80e000,%eax
  800fb5:	74 17                	je     800fce <_main+0xf96>
  800fb7:	83 ec 04             	sub    $0x4,%esp
  800fba:	68 b8 30 80 00       	push   $0x8030b8
  800fbf:	68 39 01 00 00       	push   $0x139
  800fc4:	68 0a 31 80 00       	push   $0x80310a
  800fc9:	e8 a3 05 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[21].virtual_address,PAGE_SIZE) !=   0x80F000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800fce:	a1 20 40 80 00       	mov    0x804020,%eax
  800fd3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800fd9:	05 fc 00 00 00       	add    $0xfc,%eax
  800fde:	8b 00                	mov    (%eax),%eax
  800fe0:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
  800fe6:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800fec:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ff1:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  800ff6:	74 17                	je     80100f <_main+0xfd7>
  800ff8:	83 ec 04             	sub    $0x4,%esp
  800ffb:	68 b8 30 80 00       	push   $0x8030b8
  801000:	68 3a 01 00 00       	push   $0x13a
  801005:	68 0a 31 80 00       	push   $0x80310a
  80100a:	e8 62 05 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[22].virtual_address,PAGE_SIZE) !=   0x810000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80100f:	a1 20 40 80 00       	mov    0x804020,%eax
  801014:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80101a:	05 08 01 00 00       	add    $0x108,%eax
  80101f:	8b 00                	mov    (%eax),%eax
  801021:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
  801027:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  80102d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801032:	3d 00 00 81 00       	cmp    $0x810000,%eax
  801037:	74 17                	je     801050 <_main+0x1018>
  801039:	83 ec 04             	sub    $0x4,%esp
  80103c:	68 b8 30 80 00       	push   $0x8030b8
  801041:	68 3b 01 00 00       	push   $0x13b
  801046:	68 0a 31 80 00       	push   $0x80310a
  80104b:	e8 21 05 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[23].virtual_address,PAGE_SIZE) !=   0x811000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  801050:	a1 20 40 80 00       	mov    0x804020,%eax
  801055:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80105b:	05 14 01 00 00       	add    $0x114,%eax
  801060:	8b 00                	mov    (%eax),%eax
  801062:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
  801068:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80106e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801073:	3d 00 10 81 00       	cmp    $0x811000,%eax
  801078:	74 17                	je     801091 <_main+0x1059>
  80107a:	83 ec 04             	sub    $0x4,%esp
  80107d:	68 b8 30 80 00       	push   $0x8030b8
  801082:	68 3c 01 00 00       	push   $0x13c
  801087:	68 0a 31 80 00       	push   $0x80310a
  80108c:	e8 e0 04 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[24].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  801091:	a1 20 40 80 00       	mov    0x804020,%eax
  801096:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80109c:	05 20 01 00 00       	add    $0x120,%eax
  8010a1:	8b 00                	mov    (%eax),%eax
  8010a3:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
  8010a9:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8010af:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010b4:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8010b9:	74 17                	je     8010d2 <_main+0x109a>
  8010bb:	83 ec 04             	sub    $0x4,%esp
  8010be:	68 b8 30 80 00       	push   $0x8030b8
  8010c3:	68 3d 01 00 00       	push   $0x13d
  8010c8:	68 0a 31 80 00       	push   $0x80310a
  8010cd:	e8 9f 04 00 00       	call   801571 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[25].virtual_address,PAGE_SIZE) !=   0xee7fe000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8010d2:	a1 20 40 80 00       	mov    0x804020,%eax
  8010d7:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8010dd:	05 2c 01 00 00       	add    $0x12c,%eax
  8010e2:	8b 00                	mov    (%eax),%eax
  8010e4:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
  8010ea:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  8010f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010f5:	3d 00 e0 7f ee       	cmp    $0xee7fe000,%eax
  8010fa:	74 17                	je     801113 <_main+0x10db>
  8010fc:	83 ec 04             	sub    $0x4,%esp
  8010ff:	68 b8 30 80 00       	push   $0x8030b8
  801104:	68 3e 01 00 00       	push   $0x13e
  801109:	68 0a 31 80 00       	push   $0x80310a
  80110e:	e8 5e 04 00 00       	call   801571 <_panic>
				if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  801113:	a1 20 40 80 00       	mov    0x804020,%eax
  801118:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  80111e:	85 c0                	test   %eax,%eax
  801120:	74 17                	je     801139 <_main+0x1101>
  801122:	83 ec 04             	sub    $0x4,%esp
  801125:	68 20 31 80 00       	push   $0x803120
  80112a:	68 3f 01 00 00       	push   $0x13f
  80112f:	68 0a 31 80 00       	push   $0x80310a
  801134:	e8 38 04 00 00       	call   801571 <_panic>
			}

			//=========================================================//
			//Clear the FFL
			sys_clear_ffl();
  801139:	e8 07 17 00 00       	call   802845 <sys_clear_ffl>

			//NOW: it should take from WS

			//Writing (Modified) after freeing the entire FFL:
			//	3 frames should be allocated (stack page, mem table, page file table)
			*ptr4 = garbage2 ;
  80113e:	a1 0c 40 80 00       	mov    0x80400c,%eax
  801143:	8a 95 72 ff ff ff    	mov    -0x8e(%ebp),%dl
  801149:	88 10                	mov    %dl,(%eax)
			//always use pages at 0x801000 and 0x804000
			//			if (garbage4 != *ptr) panic("test failed!");
			//			if (garbage5 != *ptr2) panic("test failed!");

			garbage4 = *ptr ;
  80114b:	a1 00 40 80 00       	mov    0x804000,%eax
  801150:	8a 00                	mov    (%eax),%al
  801152:	88 45 db             	mov    %al,-0x25(%ebp)
			garbage5 = *ptr2 ;
  801155:	a1 04 40 80 00       	mov    0x804004,%eax
  80115a:	8a 00                	mov    (%eax),%al
  80115c:	88 45 da             	mov    %al,-0x26(%ebp)

			//Writing (Modified) after freeing the entire FFL:
			//	4 frames should be allocated (4 stack pages)
			*(ptr4+1*PAGE_SIZE) = 'A';
  80115f:	a1 0c 40 80 00       	mov    0x80400c,%eax
  801164:	05 00 10 00 00       	add    $0x1000,%eax
  801169:	c6 00 41             	movb   $0x41,(%eax)
			*(ptr4+2*PAGE_SIZE) = 'B';
  80116c:	a1 0c 40 80 00       	mov    0x80400c,%eax
  801171:	05 00 20 00 00       	add    $0x2000,%eax
  801176:	c6 00 42             	movb   $0x42,(%eax)
			*(ptr4+3*PAGE_SIZE) = 'C';
  801179:	a1 0c 40 80 00       	mov    0x80400c,%eax
  80117e:	05 00 30 00 00       	add    $0x3000,%eax
  801183:	c6 00 43             	movb   $0x43,(%eax)
			*(ptr4+4*PAGE_SIZE) = 'D';
  801186:	a1 0c 40 80 00       	mov    0x80400c,%eax
  80118b:	05 00 40 00 00       	add    $0x4000,%eax
  801190:	c6 00 44             	movb   $0x44,(%eax)
						ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ==  0x802000)
					panic("test failed! either wrong victim or victim is not removed from WS");
			}
			 */
			//Check the WS after FIFO algorithm
			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");
  801193:	a1 00 40 80 00       	mov    0x804000,%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	3a 45 db             	cmp    -0x25(%ebp),%al
  80119d:	75 0c                	jne    8011ab <_main+0x1173>
  80119f:	a1 04 40 80 00       	mov    0x804004,%eax
  8011a4:	8a 00                	mov    (%eax),%al
  8011a6:	3a 45 da             	cmp    -0x26(%ebp),%al
  8011a9:	74 17                	je     8011c2 <_main+0x118a>
  8011ab:	83 ec 04             	sub    $0x4,%esp
  8011ae:	68 21 32 80 00       	push   $0x803221
  8011b3:	68 69 01 00 00       	push   $0x169
  8011b8:	68 0a 31 80 00       	push   $0x80310a
  8011bd:	e8 af 03 00 00       	call   801571 <_panic>

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
  8011c2:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8011c9:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%ebp)
  8011d0:	eb 26                	jmp    8011f8 <_main+0x11c0>
			{
				if (myEnv->__uptr_pws[i].empty)
  8011d2:	a1 20 40 80 00       	mov    0x804020,%eax
  8011d7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8011dd:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  8011e0:	89 d0                	mov    %edx,%eax
  8011e2:	01 c0                	add    %eax,%eax
  8011e4:	01 d0                	add    %edx,%eax
  8011e6:	c1 e0 02             	shl    $0x2,%eax
  8011e9:	01 c8                	add    %ecx,%eax
  8011eb:	8a 40 04             	mov    0x4(%eax),%al
  8011ee:	84 c0                	test   %al,%al
  8011f0:	74 03                	je     8011f5 <_main+0x11bd>
					numOfEmptyLocs++ ;
  8011f2:	ff 45 b8             	incl   -0x48(%ebp)
			//Check the WS after FIFO algorithm
			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8011f5:	ff 45 b4             	incl   -0x4c(%ebp)
  8011f8:	a1 20 40 80 00       	mov    0x804020,%eax
  8011fd:	8b 50 74             	mov    0x74(%eax),%edx
  801200:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801203:	39 c2                	cmp    %eax,%edx
  801205:	77 cb                	ja     8011d2 <_main+0x119a>
			{
				if (myEnv->__uptr_pws[i].empty)
					numOfEmptyLocs++ ;
			}
			if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");
  801207:	83 7d b8 02          	cmpl   $0x2,-0x48(%ebp)
  80120b:	74 17                	je     801224 <_main+0x11ec>
  80120d:	83 ec 04             	sub    $0x4,%esp
  801210:	68 30 32 80 00       	push   $0x803230
  801215:	68 72 01 00 00       	push   $0x172
  80121a:	68 0a 31 80 00       	push   $0x80310a
  80121f:	e8 4d 03 00 00       	call   801571 <_panic>

			uint32 expectedAddresses[24] = {0x801000,0x802000,0x803000,0x804000,0x805000,0x806000,0x807000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0x80d000,0x80e000,0x80f000,0x810000,0x811000,
  801224:	8d 85 6c fe ff ff    	lea    -0x194(%ebp),%eax
  80122a:	bb 60 33 80 00       	mov    $0x803360,%ebx
  80122f:	ba 18 00 00 00       	mov    $0x18,%edx
  801234:	89 c7                	mov    %eax,%edi
  801236:	89 de                	mov    %ebx,%esi
  801238:	89 d1                	mov    %edx,%ecx
  80123a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
					0xee3f9000,0xee3fa000,0xee3fb000,0xee3fc000,0xee3fd000,0xee7fe000,0xeebfd000} ;

			int numOfFoundedAddresses = 0;
  80123c:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
			for (int j = 0; j < 24; j++)
  801243:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%ebp)
  80124a:	eb 5f                	jmp    8012ab <_main+0x1273>
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  80124c:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%ebp)
  801253:	eb 44                	jmp    801299 <_main+0x1261>
				{
					if (ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == expectedAddresses[j])
  801255:	a1 20 40 80 00       	mov    0x804020,%eax
  80125a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801260:	8b 55 a8             	mov    -0x58(%ebp),%edx
  801263:	89 d0                	mov    %edx,%eax
  801265:	01 c0                	add    %eax,%eax
  801267:	01 d0                	add    %edx,%eax
  801269:	c1 e0 02             	shl    $0x2,%eax
  80126c:	01 c8                	add    %ecx,%eax
  80126e:	8b 00                	mov    (%eax),%eax
  801270:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
  801276:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  80127c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801281:	89 c2                	mov    %eax,%edx
  801283:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801286:	8b 84 85 6c fe ff ff 	mov    -0x194(%ebp,%eax,4),%eax
  80128d:	39 c2                	cmp    %eax,%edx
  80128f:	75 05                	jne    801296 <_main+0x125e>
					{
						numOfFoundedAddresses++;
  801291:	ff 45 b0             	incl   -0x50(%ebp)
						break;
  801294:	eb 12                	jmp    8012a8 <_main+0x1270>
					0xee3f9000,0xee3fa000,0xee3fb000,0xee3fc000,0xee3fd000,0xee7fe000,0xeebfd000} ;

			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 24; j++)
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  801296:	ff 45 a8             	incl   -0x58(%ebp)
  801299:	a1 20 40 80 00       	mov    0x804020,%eax
  80129e:	8b 50 74             	mov    0x74(%eax),%edx
  8012a1:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8012a4:	39 c2                	cmp    %eax,%edx
  8012a6:	77 ad                	ja     801255 <_main+0x121d>

			uint32 expectedAddresses[24] = {0x801000,0x802000,0x803000,0x804000,0x805000,0x806000,0x807000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0x80d000,0x80e000,0x80f000,0x810000,0x811000,
					0xee3f9000,0xee3fa000,0xee3fb000,0xee3fc000,0xee3fd000,0xee7fe000,0xeebfd000} ;

			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 24; j++)
  8012a8:	ff 45 ac             	incl   -0x54(%ebp)
  8012ab:	83 7d ac 17          	cmpl   $0x17,-0x54(%ebp)
  8012af:	7e 9b                	jle    80124c <_main+0x1214>
						numOfFoundedAddresses++;
						break;
					}
				}
			}
			if (numOfFoundedAddresses != 24) panic("test failed! either wrong victim or victim is not removed from WS");
  8012b1:	83 7d b0 18          	cmpl   $0x18,-0x50(%ebp)
  8012b5:	74 17                	je     8012ce <_main+0x1296>
  8012b7:	83 ec 04             	sub    $0x4,%esp
  8012ba:	68 30 32 80 00       	push   $0x803230
  8012bf:	68 83 01 00 00       	push   $0x183
  8012c4:	68 0a 31 80 00       	push   $0x80310a
  8012c9:	e8 a3 02 00 00       	call   801571 <_panic>

		}


		//Check that the values are successfully stored
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  8012ce:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8012d5:	eb 2c                	jmp    801303 <_main+0x12cb>
		{
			//cprintf("i = %x, address = %x, arr[i] = %d\n", i, &(arr[i]), arr[i]);
			if (arr[i] != -1) panic("test failed!");
  8012d7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8012da:	05 40 40 80 00       	add    $0x804040,%eax
  8012df:	8a 00                	mov    (%eax),%al
  8012e1:	3c ff                	cmp    $0xff,%al
  8012e3:	74 17                	je     8012fc <_main+0x12c4>
  8012e5:	83 ec 04             	sub    $0x4,%esp
  8012e8:	68 21 32 80 00       	push   $0x803221
  8012ed:	68 8d 01 00 00       	push   $0x18d
  8012f2:	68 0a 31 80 00       	push   $0x80310a
  8012f7:	e8 75 02 00 00       	call   801571 <_panic>

		}


		//Check that the values are successfully stored
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  8012fc:	81 45 d4 00 08 00 00 	addl   $0x800,-0x2c(%ebp)
  801303:	81 7d d4 ff 3f 00 00 	cmpl   $0x3fff,-0x2c(%ebp)
  80130a:	7e cb                	jle    8012d7 <_main+0x129f>
		{
			//cprintf("i = %x, address = %x, arr[i] = %d\n", i, &(arr[i]), arr[i]);
			if (arr[i] != -1) panic("test failed!");
		}
		if (*ptr3 != arr[PAGE_SIZE*10-1]) panic("test failed!");
  80130c:	a1 08 40 80 00       	mov    0x804008,%eax
  801311:	8a 10                	mov    (%eax),%dl
  801313:	a0 3f e0 80 00       	mov    0x80e03f,%al
  801318:	38 c2                	cmp    %al,%dl
  80131a:	74 17                	je     801333 <_main+0x12fb>
  80131c:	83 ec 04             	sub    $0x4,%esp
  80131f:	68 21 32 80 00       	push   $0x803221
  801324:	68 8f 01 00 00       	push   $0x18f
  801329:	68 0a 31 80 00       	push   $0x80310a
  80132e:	e8 3e 02 00 00       	call   801571 <_panic>


		if (testCase ==3)
  801333:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  801337:	0f 85 09 01 00 00    	jne    801446 <_main+0x140e>
		{
			//			cprintf("garbage4 = %d, *ptr = %d\n",garbage4, *ptr);
			if (garbage4 != *ptr) panic("test failed!");
  80133d:	a1 00 40 80 00       	mov    0x804000,%eax
  801342:	8a 00                	mov    (%eax),%al
  801344:	3a 45 db             	cmp    -0x25(%ebp),%al
  801347:	74 17                	je     801360 <_main+0x1328>
  801349:	83 ec 04             	sub    $0x4,%esp
  80134c:	68 21 32 80 00       	push   $0x803221
  801351:	68 95 01 00 00       	push   $0x195
  801356:	68 0a 31 80 00       	push   $0x80310a
  80135b:	e8 11 02 00 00       	call   801571 <_panic>
			if (garbage5 != *ptr2) panic("test failed!");
  801360:	a1 04 40 80 00       	mov    0x804004,%eax
  801365:	8a 00                	mov    (%eax),%al
  801367:	3a 45 da             	cmp    -0x26(%ebp),%al
  80136a:	74 17                	je     801383 <_main+0x134b>
  80136c:	83 ec 04             	sub    $0x4,%esp
  80136f:	68 21 32 80 00       	push   $0x803221
  801374:	68 96 01 00 00       	push   $0x196
  801379:	68 0a 31 80 00       	push   $0x80310a
  80137e:	e8 ee 01 00 00       	call   801571 <_panic>

			if (*ptr4 != arr[PAGE_SIZE*11-1]) panic("test failed!");
  801383:	a1 0c 40 80 00       	mov    0x80400c,%eax
  801388:	8a 10                	mov    (%eax),%dl
  80138a:	a0 3f f0 80 00       	mov    0x80f03f,%al
  80138f:	38 c2                	cmp    %al,%dl
  801391:	74 17                	je     8013aa <_main+0x1372>
  801393:	83 ec 04             	sub    $0x4,%esp
  801396:	68 21 32 80 00       	push   $0x803221
  80139b:	68 98 01 00 00       	push   $0x198
  8013a0:	68 0a 31 80 00       	push   $0x80310a
  8013a5:	e8 c7 01 00 00       	call   801571 <_panic>
			if (*(ptr4+1*PAGE_SIZE) != 'A') panic("test failed!");
  8013aa:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8013af:	05 00 10 00 00       	add    $0x1000,%eax
  8013b4:	8a 00                	mov    (%eax),%al
  8013b6:	3c 41                	cmp    $0x41,%al
  8013b8:	74 17                	je     8013d1 <_main+0x1399>
  8013ba:	83 ec 04             	sub    $0x4,%esp
  8013bd:	68 21 32 80 00       	push   $0x803221
  8013c2:	68 99 01 00 00       	push   $0x199
  8013c7:	68 0a 31 80 00       	push   $0x80310a
  8013cc:	e8 a0 01 00 00       	call   801571 <_panic>
			if (*(ptr4+2*PAGE_SIZE) != 'B') panic("test failed!");
  8013d1:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8013d6:	05 00 20 00 00       	add    $0x2000,%eax
  8013db:	8a 00                	mov    (%eax),%al
  8013dd:	3c 42                	cmp    $0x42,%al
  8013df:	74 17                	je     8013f8 <_main+0x13c0>
  8013e1:	83 ec 04             	sub    $0x4,%esp
  8013e4:	68 21 32 80 00       	push   $0x803221
  8013e9:	68 9a 01 00 00       	push   $0x19a
  8013ee:	68 0a 31 80 00       	push   $0x80310a
  8013f3:	e8 79 01 00 00       	call   801571 <_panic>
			if (*(ptr4+3*PAGE_SIZE) != 'C') panic("test failed!");
  8013f8:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8013fd:	05 00 30 00 00       	add    $0x3000,%eax
  801402:	8a 00                	mov    (%eax),%al
  801404:	3c 43                	cmp    $0x43,%al
  801406:	74 17                	je     80141f <_main+0x13e7>
  801408:	83 ec 04             	sub    $0x4,%esp
  80140b:	68 21 32 80 00       	push   $0x803221
  801410:	68 9b 01 00 00       	push   $0x19b
  801415:	68 0a 31 80 00       	push   $0x80310a
  80141a:	e8 52 01 00 00       	call   801571 <_panic>
			if (*(ptr4+4*PAGE_SIZE) != 'D') panic("test failed!");
  80141f:	a1 0c 40 80 00       	mov    0x80400c,%eax
  801424:	05 00 40 00 00       	add    $0x4000,%eax
  801429:	8a 00                	mov    (%eax),%al
  80142b:	3c 44                	cmp    $0x44,%al
  80142d:	74 17                	je     801446 <_main+0x140e>
  80142f:	83 ec 04             	sub    $0x4,%esp
  801432:	68 21 32 80 00       	push   $0x803221
  801437:	68 9c 01 00 00       	push   $0x19c
  80143c:	68 0a 31 80 00       	push   $0x80310a
  801441:	e8 2b 01 00 00       	call   801571 <_panic>
		}
	}

	cprintf("Congratulations!! test freeRAM (Scenario# %d) completed successfully.\n", testCase);
  801446:	83 ec 08             	sub    $0x8,%esp
  801449:	ff 75 e4             	pushl  -0x1c(%ebp)
  80144c:	68 dc 32 80 00       	push   $0x8032dc
  801451:	e8 cf 03 00 00       	call   801825 <cprintf>
  801456:	83 c4 10             	add    $0x10,%esp

	return;
  801459:	90                   	nop
}
  80145a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80145d:	5b                   	pop    %ebx
  80145e:	5e                   	pop    %esi
  80145f:	5f                   	pop    %edi
  801460:	5d                   	pop    %ebp
  801461:	c3                   	ret    

00801462 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  801462:	55                   	push   %ebp
  801463:	89 e5                	mov    %esp,%ebp
  801465:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801468:	e8 e3 11 00 00       	call   802650 <sys_getenvindex>
  80146d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  801470:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801473:	89 d0                	mov    %edx,%eax
  801475:	c1 e0 02             	shl    $0x2,%eax
  801478:	01 d0                	add    %edx,%eax
  80147a:	01 c0                	add    %eax,%eax
  80147c:	01 d0                	add    %edx,%eax
  80147e:	01 c0                	add    %eax,%eax
  801480:	01 d0                	add    %edx,%eax
  801482:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  801489:	01 d0                	add    %edx,%eax
  80148b:	c1 e0 02             	shl    $0x2,%eax
  80148e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  801493:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801498:	a1 20 40 80 00       	mov    0x804020,%eax
  80149d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8014a3:	84 c0                	test   %al,%al
  8014a5:	74 0f                	je     8014b6 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8014a7:	a1 20 40 80 00       	mov    0x804020,%eax
  8014ac:	05 f4 02 00 00       	add    $0x2f4,%eax
  8014b1:	a3 10 40 80 00       	mov    %eax,0x804010

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8014b6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014ba:	7e 0a                	jle    8014c6 <libmain+0x64>
		binaryname = argv[0];
  8014bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bf:	8b 00                	mov    (%eax),%eax
  8014c1:	a3 10 40 80 00       	mov    %eax,0x804010

	// call user main routine
	_main(argc, argv);
  8014c6:	83 ec 08             	sub    $0x8,%esp
  8014c9:	ff 75 0c             	pushl  0xc(%ebp)
  8014cc:	ff 75 08             	pushl  0x8(%ebp)
  8014cf:	e8 64 eb ff ff       	call   800038 <_main>
  8014d4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8014d7:	e8 0f 13 00 00       	call   8027eb <sys_disable_interrupt>
	cprintf("**************************************\n");
  8014dc:	83 ec 0c             	sub    $0xc,%esp
  8014df:	68 d8 33 80 00       	push   $0x8033d8
  8014e4:	e8 3c 03 00 00       	call   801825 <cprintf>
  8014e9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8014ec:	a1 20 40 80 00       	mov    0x804020,%eax
  8014f1:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8014f7:	a1 20 40 80 00       	mov    0x804020,%eax
  8014fc:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  801502:	83 ec 04             	sub    $0x4,%esp
  801505:	52                   	push   %edx
  801506:	50                   	push   %eax
  801507:	68 00 34 80 00       	push   $0x803400
  80150c:	e8 14 03 00 00       	call   801825 <cprintf>
  801511:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801514:	a1 20 40 80 00       	mov    0x804020,%eax
  801519:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80151f:	83 ec 08             	sub    $0x8,%esp
  801522:	50                   	push   %eax
  801523:	68 25 34 80 00       	push   $0x803425
  801528:	e8 f8 02 00 00       	call   801825 <cprintf>
  80152d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  801530:	83 ec 0c             	sub    $0xc,%esp
  801533:	68 d8 33 80 00       	push   $0x8033d8
  801538:	e8 e8 02 00 00       	call   801825 <cprintf>
  80153d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801540:	e8 c0 12 00 00       	call   802805 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801545:	e8 19 00 00 00       	call   801563 <exit>
}
  80154a:	90                   	nop
  80154b:	c9                   	leave  
  80154c:	c3                   	ret    

0080154d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80154d:	55                   	push   %ebp
  80154e:	89 e5                	mov    %esp,%ebp
  801550:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801553:	83 ec 0c             	sub    $0xc,%esp
  801556:	6a 00                	push   $0x0
  801558:	e8 bf 10 00 00       	call   80261c <sys_env_destroy>
  80155d:	83 c4 10             	add    $0x10,%esp
}
  801560:	90                   	nop
  801561:	c9                   	leave  
  801562:	c3                   	ret    

00801563 <exit>:

void
exit(void)
{
  801563:	55                   	push   %ebp
  801564:	89 e5                	mov    %esp,%ebp
  801566:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801569:	e8 14 11 00 00       	call   802682 <sys_env_exit>
}
  80156e:	90                   	nop
  80156f:	c9                   	leave  
  801570:	c3                   	ret    

00801571 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801571:	55                   	push   %ebp
  801572:	89 e5                	mov    %esp,%ebp
  801574:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801577:	8d 45 10             	lea    0x10(%ebp),%eax
  80157a:	83 c0 04             	add    $0x4,%eax
  80157d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801580:	a1 04 10 81 00       	mov    0x811004,%eax
  801585:	85 c0                	test   %eax,%eax
  801587:	74 16                	je     80159f <_panic+0x2e>
		cprintf("%s: ", argv0);
  801589:	a1 04 10 81 00       	mov    0x811004,%eax
  80158e:	83 ec 08             	sub    $0x8,%esp
  801591:	50                   	push   %eax
  801592:	68 3c 34 80 00       	push   $0x80343c
  801597:	e8 89 02 00 00       	call   801825 <cprintf>
  80159c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80159f:	a1 10 40 80 00       	mov    0x804010,%eax
  8015a4:	ff 75 0c             	pushl  0xc(%ebp)
  8015a7:	ff 75 08             	pushl  0x8(%ebp)
  8015aa:	50                   	push   %eax
  8015ab:	68 41 34 80 00       	push   $0x803441
  8015b0:	e8 70 02 00 00       	call   801825 <cprintf>
  8015b5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8015b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bb:	83 ec 08             	sub    $0x8,%esp
  8015be:	ff 75 f4             	pushl  -0xc(%ebp)
  8015c1:	50                   	push   %eax
  8015c2:	e8 f3 01 00 00       	call   8017ba <vcprintf>
  8015c7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8015ca:	83 ec 08             	sub    $0x8,%esp
  8015cd:	6a 00                	push   $0x0
  8015cf:	68 5d 34 80 00       	push   $0x80345d
  8015d4:	e8 e1 01 00 00       	call   8017ba <vcprintf>
  8015d9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8015dc:	e8 82 ff ff ff       	call   801563 <exit>

	// should not return here
	while (1) ;
  8015e1:	eb fe                	jmp    8015e1 <_panic+0x70>

008015e3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8015e3:	55                   	push   %ebp
  8015e4:	89 e5                	mov    %esp,%ebp
  8015e6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8015e9:	a1 20 40 80 00       	mov    0x804020,%eax
  8015ee:	8b 50 74             	mov    0x74(%eax),%edx
  8015f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f4:	39 c2                	cmp    %eax,%edx
  8015f6:	74 14                	je     80160c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8015f8:	83 ec 04             	sub    $0x4,%esp
  8015fb:	68 60 34 80 00       	push   $0x803460
  801600:	6a 26                	push   $0x26
  801602:	68 ac 34 80 00       	push   $0x8034ac
  801607:	e8 65 ff ff ff       	call   801571 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80160c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801613:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80161a:	e9 c2 00 00 00       	jmp    8016e1 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80161f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801622:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	01 d0                	add    %edx,%eax
  80162e:	8b 00                	mov    (%eax),%eax
  801630:	85 c0                	test   %eax,%eax
  801632:	75 08                	jne    80163c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801634:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801637:	e9 a2 00 00 00       	jmp    8016de <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80163c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801643:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80164a:	eb 69                	jmp    8016b5 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80164c:	a1 20 40 80 00       	mov    0x804020,%eax
  801651:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801657:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80165a:	89 d0                	mov    %edx,%eax
  80165c:	01 c0                	add    %eax,%eax
  80165e:	01 d0                	add    %edx,%eax
  801660:	c1 e0 02             	shl    $0x2,%eax
  801663:	01 c8                	add    %ecx,%eax
  801665:	8a 40 04             	mov    0x4(%eax),%al
  801668:	84 c0                	test   %al,%al
  80166a:	75 46                	jne    8016b2 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80166c:	a1 20 40 80 00       	mov    0x804020,%eax
  801671:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801677:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80167a:	89 d0                	mov    %edx,%eax
  80167c:	01 c0                	add    %eax,%eax
  80167e:	01 d0                	add    %edx,%eax
  801680:	c1 e0 02             	shl    $0x2,%eax
  801683:	01 c8                	add    %ecx,%eax
  801685:	8b 00                	mov    (%eax),%eax
  801687:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80168a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80168d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801692:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801694:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801697:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	01 c8                	add    %ecx,%eax
  8016a3:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8016a5:	39 c2                	cmp    %eax,%edx
  8016a7:	75 09                	jne    8016b2 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8016a9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8016b0:	eb 12                	jmp    8016c4 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016b2:	ff 45 e8             	incl   -0x18(%ebp)
  8016b5:	a1 20 40 80 00       	mov    0x804020,%eax
  8016ba:	8b 50 74             	mov    0x74(%eax),%edx
  8016bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016c0:	39 c2                	cmp    %eax,%edx
  8016c2:	77 88                	ja     80164c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8016c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8016c8:	75 14                	jne    8016de <CheckWSWithoutLastIndex+0xfb>
			panic(
  8016ca:	83 ec 04             	sub    $0x4,%esp
  8016cd:	68 b8 34 80 00       	push   $0x8034b8
  8016d2:	6a 3a                	push   $0x3a
  8016d4:	68 ac 34 80 00       	push   $0x8034ac
  8016d9:	e8 93 fe ff ff       	call   801571 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8016de:	ff 45 f0             	incl   -0x10(%ebp)
  8016e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8016e7:	0f 8c 32 ff ff ff    	jl     80161f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8016ed:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016f4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8016fb:	eb 26                	jmp    801723 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8016fd:	a1 20 40 80 00       	mov    0x804020,%eax
  801702:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801708:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80170b:	89 d0                	mov    %edx,%eax
  80170d:	01 c0                	add    %eax,%eax
  80170f:	01 d0                	add    %edx,%eax
  801711:	c1 e0 02             	shl    $0x2,%eax
  801714:	01 c8                	add    %ecx,%eax
  801716:	8a 40 04             	mov    0x4(%eax),%al
  801719:	3c 01                	cmp    $0x1,%al
  80171b:	75 03                	jne    801720 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80171d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801720:	ff 45 e0             	incl   -0x20(%ebp)
  801723:	a1 20 40 80 00       	mov    0x804020,%eax
  801728:	8b 50 74             	mov    0x74(%eax),%edx
  80172b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80172e:	39 c2                	cmp    %eax,%edx
  801730:	77 cb                	ja     8016fd <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801732:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801735:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801738:	74 14                	je     80174e <CheckWSWithoutLastIndex+0x16b>
		panic(
  80173a:	83 ec 04             	sub    $0x4,%esp
  80173d:	68 0c 35 80 00       	push   $0x80350c
  801742:	6a 44                	push   $0x44
  801744:	68 ac 34 80 00       	push   $0x8034ac
  801749:	e8 23 fe ff ff       	call   801571 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80174e:	90                   	nop
  80174f:	c9                   	leave  
  801750:	c3                   	ret    

00801751 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
  801754:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801757:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175a:	8b 00                	mov    (%eax),%eax
  80175c:	8d 48 01             	lea    0x1(%eax),%ecx
  80175f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801762:	89 0a                	mov    %ecx,(%edx)
  801764:	8b 55 08             	mov    0x8(%ebp),%edx
  801767:	88 d1                	mov    %dl,%cl
  801769:	8b 55 0c             	mov    0xc(%ebp),%edx
  80176c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801770:	8b 45 0c             	mov    0xc(%ebp),%eax
  801773:	8b 00                	mov    (%eax),%eax
  801775:	3d ff 00 00 00       	cmp    $0xff,%eax
  80177a:	75 2c                	jne    8017a8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80177c:	a0 24 40 80 00       	mov    0x804024,%al
  801781:	0f b6 c0             	movzbl %al,%eax
  801784:	8b 55 0c             	mov    0xc(%ebp),%edx
  801787:	8b 12                	mov    (%edx),%edx
  801789:	89 d1                	mov    %edx,%ecx
  80178b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178e:	83 c2 08             	add    $0x8,%edx
  801791:	83 ec 04             	sub    $0x4,%esp
  801794:	50                   	push   %eax
  801795:	51                   	push   %ecx
  801796:	52                   	push   %edx
  801797:	e8 3e 0e 00 00       	call   8025da <sys_cputs>
  80179c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80179f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8017a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ab:	8b 40 04             	mov    0x4(%eax),%eax
  8017ae:	8d 50 01             	lea    0x1(%eax),%edx
  8017b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8017b7:	90                   	nop
  8017b8:	c9                   	leave  
  8017b9:	c3                   	ret    

008017ba <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
  8017bd:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8017c3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8017ca:	00 00 00 
	b.cnt = 0;
  8017cd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8017d4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8017d7:	ff 75 0c             	pushl  0xc(%ebp)
  8017da:	ff 75 08             	pushl  0x8(%ebp)
  8017dd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8017e3:	50                   	push   %eax
  8017e4:	68 51 17 80 00       	push   $0x801751
  8017e9:	e8 11 02 00 00       	call   8019ff <vprintfmt>
  8017ee:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8017f1:	a0 24 40 80 00       	mov    0x804024,%al
  8017f6:	0f b6 c0             	movzbl %al,%eax
  8017f9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8017ff:	83 ec 04             	sub    $0x4,%esp
  801802:	50                   	push   %eax
  801803:	52                   	push   %edx
  801804:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80180a:	83 c0 08             	add    $0x8,%eax
  80180d:	50                   	push   %eax
  80180e:	e8 c7 0d 00 00       	call   8025da <sys_cputs>
  801813:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801816:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  80181d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801823:	c9                   	leave  
  801824:	c3                   	ret    

00801825 <cprintf>:

int cprintf(const char *fmt, ...) {
  801825:	55                   	push   %ebp
  801826:	89 e5                	mov    %esp,%ebp
  801828:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80182b:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801832:	8d 45 0c             	lea    0xc(%ebp),%eax
  801835:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801838:	8b 45 08             	mov    0x8(%ebp),%eax
  80183b:	83 ec 08             	sub    $0x8,%esp
  80183e:	ff 75 f4             	pushl  -0xc(%ebp)
  801841:	50                   	push   %eax
  801842:	e8 73 ff ff ff       	call   8017ba <vcprintf>
  801847:	83 c4 10             	add    $0x10,%esp
  80184a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80184d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801850:	c9                   	leave  
  801851:	c3                   	ret    

00801852 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801852:	55                   	push   %ebp
  801853:	89 e5                	mov    %esp,%ebp
  801855:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801858:	e8 8e 0f 00 00       	call   8027eb <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80185d:	8d 45 0c             	lea    0xc(%ebp),%eax
  801860:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801863:	8b 45 08             	mov    0x8(%ebp),%eax
  801866:	83 ec 08             	sub    $0x8,%esp
  801869:	ff 75 f4             	pushl  -0xc(%ebp)
  80186c:	50                   	push   %eax
  80186d:	e8 48 ff ff ff       	call   8017ba <vcprintf>
  801872:	83 c4 10             	add    $0x10,%esp
  801875:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801878:	e8 88 0f 00 00       	call   802805 <sys_enable_interrupt>
	return cnt;
  80187d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
  801885:	53                   	push   %ebx
  801886:	83 ec 14             	sub    $0x14,%esp
  801889:	8b 45 10             	mov    0x10(%ebp),%eax
  80188c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80188f:	8b 45 14             	mov    0x14(%ebp),%eax
  801892:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801895:	8b 45 18             	mov    0x18(%ebp),%eax
  801898:	ba 00 00 00 00       	mov    $0x0,%edx
  80189d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8018a0:	77 55                	ja     8018f7 <printnum+0x75>
  8018a2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8018a5:	72 05                	jb     8018ac <printnum+0x2a>
  8018a7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018aa:	77 4b                	ja     8018f7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8018ac:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8018af:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8018b2:	8b 45 18             	mov    0x18(%ebp),%eax
  8018b5:	ba 00 00 00 00       	mov    $0x0,%edx
  8018ba:	52                   	push   %edx
  8018bb:	50                   	push   %eax
  8018bc:	ff 75 f4             	pushl  -0xc(%ebp)
  8018bf:	ff 75 f0             	pushl  -0x10(%ebp)
  8018c2:	e8 b9 13 00 00       	call   802c80 <__udivdi3>
  8018c7:	83 c4 10             	add    $0x10,%esp
  8018ca:	83 ec 04             	sub    $0x4,%esp
  8018cd:	ff 75 20             	pushl  0x20(%ebp)
  8018d0:	53                   	push   %ebx
  8018d1:	ff 75 18             	pushl  0x18(%ebp)
  8018d4:	52                   	push   %edx
  8018d5:	50                   	push   %eax
  8018d6:	ff 75 0c             	pushl  0xc(%ebp)
  8018d9:	ff 75 08             	pushl  0x8(%ebp)
  8018dc:	e8 a1 ff ff ff       	call   801882 <printnum>
  8018e1:	83 c4 20             	add    $0x20,%esp
  8018e4:	eb 1a                	jmp    801900 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8018e6:	83 ec 08             	sub    $0x8,%esp
  8018e9:	ff 75 0c             	pushl  0xc(%ebp)
  8018ec:	ff 75 20             	pushl  0x20(%ebp)
  8018ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f2:	ff d0                	call   *%eax
  8018f4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8018f7:	ff 4d 1c             	decl   0x1c(%ebp)
  8018fa:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8018fe:	7f e6                	jg     8018e6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801900:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801903:	bb 00 00 00 00       	mov    $0x0,%ebx
  801908:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80190b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80190e:	53                   	push   %ebx
  80190f:	51                   	push   %ecx
  801910:	52                   	push   %edx
  801911:	50                   	push   %eax
  801912:	e8 79 14 00 00       	call   802d90 <__umoddi3>
  801917:	83 c4 10             	add    $0x10,%esp
  80191a:	05 74 37 80 00       	add    $0x803774,%eax
  80191f:	8a 00                	mov    (%eax),%al
  801921:	0f be c0             	movsbl %al,%eax
  801924:	83 ec 08             	sub    $0x8,%esp
  801927:	ff 75 0c             	pushl  0xc(%ebp)
  80192a:	50                   	push   %eax
  80192b:	8b 45 08             	mov    0x8(%ebp),%eax
  80192e:	ff d0                	call   *%eax
  801930:	83 c4 10             	add    $0x10,%esp
}
  801933:	90                   	nop
  801934:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801937:	c9                   	leave  
  801938:	c3                   	ret    

00801939 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801939:	55                   	push   %ebp
  80193a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80193c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801940:	7e 1c                	jle    80195e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801942:	8b 45 08             	mov    0x8(%ebp),%eax
  801945:	8b 00                	mov    (%eax),%eax
  801947:	8d 50 08             	lea    0x8(%eax),%edx
  80194a:	8b 45 08             	mov    0x8(%ebp),%eax
  80194d:	89 10                	mov    %edx,(%eax)
  80194f:	8b 45 08             	mov    0x8(%ebp),%eax
  801952:	8b 00                	mov    (%eax),%eax
  801954:	83 e8 08             	sub    $0x8,%eax
  801957:	8b 50 04             	mov    0x4(%eax),%edx
  80195a:	8b 00                	mov    (%eax),%eax
  80195c:	eb 40                	jmp    80199e <getuint+0x65>
	else if (lflag)
  80195e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801962:	74 1e                	je     801982 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801964:	8b 45 08             	mov    0x8(%ebp),%eax
  801967:	8b 00                	mov    (%eax),%eax
  801969:	8d 50 04             	lea    0x4(%eax),%edx
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	89 10                	mov    %edx,(%eax)
  801971:	8b 45 08             	mov    0x8(%ebp),%eax
  801974:	8b 00                	mov    (%eax),%eax
  801976:	83 e8 04             	sub    $0x4,%eax
  801979:	8b 00                	mov    (%eax),%eax
  80197b:	ba 00 00 00 00       	mov    $0x0,%edx
  801980:	eb 1c                	jmp    80199e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801982:	8b 45 08             	mov    0x8(%ebp),%eax
  801985:	8b 00                	mov    (%eax),%eax
  801987:	8d 50 04             	lea    0x4(%eax),%edx
  80198a:	8b 45 08             	mov    0x8(%ebp),%eax
  80198d:	89 10                	mov    %edx,(%eax)
  80198f:	8b 45 08             	mov    0x8(%ebp),%eax
  801992:	8b 00                	mov    (%eax),%eax
  801994:	83 e8 04             	sub    $0x4,%eax
  801997:	8b 00                	mov    (%eax),%eax
  801999:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80199e:	5d                   	pop    %ebp
  80199f:	c3                   	ret    

008019a0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8019a3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8019a7:	7e 1c                	jle    8019c5 <getint+0x25>
		return va_arg(*ap, long long);
  8019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ac:	8b 00                	mov    (%eax),%eax
  8019ae:	8d 50 08             	lea    0x8(%eax),%edx
  8019b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b4:	89 10                	mov    %edx,(%eax)
  8019b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b9:	8b 00                	mov    (%eax),%eax
  8019bb:	83 e8 08             	sub    $0x8,%eax
  8019be:	8b 50 04             	mov    0x4(%eax),%edx
  8019c1:	8b 00                	mov    (%eax),%eax
  8019c3:	eb 38                	jmp    8019fd <getint+0x5d>
	else if (lflag)
  8019c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019c9:	74 1a                	je     8019e5 <getint+0x45>
		return va_arg(*ap, long);
  8019cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ce:	8b 00                	mov    (%eax),%eax
  8019d0:	8d 50 04             	lea    0x4(%eax),%edx
  8019d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d6:	89 10                	mov    %edx,(%eax)
  8019d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019db:	8b 00                	mov    (%eax),%eax
  8019dd:	83 e8 04             	sub    $0x4,%eax
  8019e0:	8b 00                	mov    (%eax),%eax
  8019e2:	99                   	cltd   
  8019e3:	eb 18                	jmp    8019fd <getint+0x5d>
	else
		return va_arg(*ap, int);
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	8b 00                	mov    (%eax),%eax
  8019ea:	8d 50 04             	lea    0x4(%eax),%edx
  8019ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f0:	89 10                	mov    %edx,(%eax)
  8019f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f5:	8b 00                	mov    (%eax),%eax
  8019f7:	83 e8 04             	sub    $0x4,%eax
  8019fa:	8b 00                	mov    (%eax),%eax
  8019fc:	99                   	cltd   
}
  8019fd:	5d                   	pop    %ebp
  8019fe:	c3                   	ret    

008019ff <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8019ff:	55                   	push   %ebp
  801a00:	89 e5                	mov    %esp,%ebp
  801a02:	56                   	push   %esi
  801a03:	53                   	push   %ebx
  801a04:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801a07:	eb 17                	jmp    801a20 <vprintfmt+0x21>
			if (ch == '\0')
  801a09:	85 db                	test   %ebx,%ebx
  801a0b:	0f 84 af 03 00 00    	je     801dc0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801a11:	83 ec 08             	sub    $0x8,%esp
  801a14:	ff 75 0c             	pushl  0xc(%ebp)
  801a17:	53                   	push   %ebx
  801a18:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1b:	ff d0                	call   *%eax
  801a1d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801a20:	8b 45 10             	mov    0x10(%ebp),%eax
  801a23:	8d 50 01             	lea    0x1(%eax),%edx
  801a26:	89 55 10             	mov    %edx,0x10(%ebp)
  801a29:	8a 00                	mov    (%eax),%al
  801a2b:	0f b6 d8             	movzbl %al,%ebx
  801a2e:	83 fb 25             	cmp    $0x25,%ebx
  801a31:	75 d6                	jne    801a09 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801a33:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801a37:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801a3e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801a45:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801a4c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801a53:	8b 45 10             	mov    0x10(%ebp),%eax
  801a56:	8d 50 01             	lea    0x1(%eax),%edx
  801a59:	89 55 10             	mov    %edx,0x10(%ebp)
  801a5c:	8a 00                	mov    (%eax),%al
  801a5e:	0f b6 d8             	movzbl %al,%ebx
  801a61:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801a64:	83 f8 55             	cmp    $0x55,%eax
  801a67:	0f 87 2b 03 00 00    	ja     801d98 <vprintfmt+0x399>
  801a6d:	8b 04 85 98 37 80 00 	mov    0x803798(,%eax,4),%eax
  801a74:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801a76:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801a7a:	eb d7                	jmp    801a53 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801a7c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801a80:	eb d1                	jmp    801a53 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801a82:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801a89:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a8c:	89 d0                	mov    %edx,%eax
  801a8e:	c1 e0 02             	shl    $0x2,%eax
  801a91:	01 d0                	add    %edx,%eax
  801a93:	01 c0                	add    %eax,%eax
  801a95:	01 d8                	add    %ebx,%eax
  801a97:	83 e8 30             	sub    $0x30,%eax
  801a9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801a9d:	8b 45 10             	mov    0x10(%ebp),%eax
  801aa0:	8a 00                	mov    (%eax),%al
  801aa2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801aa5:	83 fb 2f             	cmp    $0x2f,%ebx
  801aa8:	7e 3e                	jle    801ae8 <vprintfmt+0xe9>
  801aaa:	83 fb 39             	cmp    $0x39,%ebx
  801aad:	7f 39                	jg     801ae8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801aaf:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801ab2:	eb d5                	jmp    801a89 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801ab4:	8b 45 14             	mov    0x14(%ebp),%eax
  801ab7:	83 c0 04             	add    $0x4,%eax
  801aba:	89 45 14             	mov    %eax,0x14(%ebp)
  801abd:	8b 45 14             	mov    0x14(%ebp),%eax
  801ac0:	83 e8 04             	sub    $0x4,%eax
  801ac3:	8b 00                	mov    (%eax),%eax
  801ac5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801ac8:	eb 1f                	jmp    801ae9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801aca:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801ace:	79 83                	jns    801a53 <vprintfmt+0x54>
				width = 0;
  801ad0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801ad7:	e9 77 ff ff ff       	jmp    801a53 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801adc:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801ae3:	e9 6b ff ff ff       	jmp    801a53 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801ae8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801ae9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801aed:	0f 89 60 ff ff ff    	jns    801a53 <vprintfmt+0x54>
				width = precision, precision = -1;
  801af3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801af6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801af9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801b00:	e9 4e ff ff ff       	jmp    801a53 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801b05:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801b08:	e9 46 ff ff ff       	jmp    801a53 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801b0d:	8b 45 14             	mov    0x14(%ebp),%eax
  801b10:	83 c0 04             	add    $0x4,%eax
  801b13:	89 45 14             	mov    %eax,0x14(%ebp)
  801b16:	8b 45 14             	mov    0x14(%ebp),%eax
  801b19:	83 e8 04             	sub    $0x4,%eax
  801b1c:	8b 00                	mov    (%eax),%eax
  801b1e:	83 ec 08             	sub    $0x8,%esp
  801b21:	ff 75 0c             	pushl  0xc(%ebp)
  801b24:	50                   	push   %eax
  801b25:	8b 45 08             	mov    0x8(%ebp),%eax
  801b28:	ff d0                	call   *%eax
  801b2a:	83 c4 10             	add    $0x10,%esp
			break;
  801b2d:	e9 89 02 00 00       	jmp    801dbb <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801b32:	8b 45 14             	mov    0x14(%ebp),%eax
  801b35:	83 c0 04             	add    $0x4,%eax
  801b38:	89 45 14             	mov    %eax,0x14(%ebp)
  801b3b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b3e:	83 e8 04             	sub    $0x4,%eax
  801b41:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801b43:	85 db                	test   %ebx,%ebx
  801b45:	79 02                	jns    801b49 <vprintfmt+0x14a>
				err = -err;
  801b47:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801b49:	83 fb 64             	cmp    $0x64,%ebx
  801b4c:	7f 0b                	jg     801b59 <vprintfmt+0x15a>
  801b4e:	8b 34 9d e0 35 80 00 	mov    0x8035e0(,%ebx,4),%esi
  801b55:	85 f6                	test   %esi,%esi
  801b57:	75 19                	jne    801b72 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801b59:	53                   	push   %ebx
  801b5a:	68 85 37 80 00       	push   $0x803785
  801b5f:	ff 75 0c             	pushl  0xc(%ebp)
  801b62:	ff 75 08             	pushl  0x8(%ebp)
  801b65:	e8 5e 02 00 00       	call   801dc8 <printfmt>
  801b6a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801b6d:	e9 49 02 00 00       	jmp    801dbb <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801b72:	56                   	push   %esi
  801b73:	68 8e 37 80 00       	push   $0x80378e
  801b78:	ff 75 0c             	pushl  0xc(%ebp)
  801b7b:	ff 75 08             	pushl  0x8(%ebp)
  801b7e:	e8 45 02 00 00       	call   801dc8 <printfmt>
  801b83:	83 c4 10             	add    $0x10,%esp
			break;
  801b86:	e9 30 02 00 00       	jmp    801dbb <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801b8b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b8e:	83 c0 04             	add    $0x4,%eax
  801b91:	89 45 14             	mov    %eax,0x14(%ebp)
  801b94:	8b 45 14             	mov    0x14(%ebp),%eax
  801b97:	83 e8 04             	sub    $0x4,%eax
  801b9a:	8b 30                	mov    (%eax),%esi
  801b9c:	85 f6                	test   %esi,%esi
  801b9e:	75 05                	jne    801ba5 <vprintfmt+0x1a6>
				p = "(null)";
  801ba0:	be 91 37 80 00       	mov    $0x803791,%esi
			if (width > 0 && padc != '-')
  801ba5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801ba9:	7e 6d                	jle    801c18 <vprintfmt+0x219>
  801bab:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801baf:	74 67                	je     801c18 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801bb1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bb4:	83 ec 08             	sub    $0x8,%esp
  801bb7:	50                   	push   %eax
  801bb8:	56                   	push   %esi
  801bb9:	e8 0c 03 00 00       	call   801eca <strnlen>
  801bbe:	83 c4 10             	add    $0x10,%esp
  801bc1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801bc4:	eb 16                	jmp    801bdc <vprintfmt+0x1dd>
					putch(padc, putdat);
  801bc6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801bca:	83 ec 08             	sub    $0x8,%esp
  801bcd:	ff 75 0c             	pushl  0xc(%ebp)
  801bd0:	50                   	push   %eax
  801bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd4:	ff d0                	call   *%eax
  801bd6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801bd9:	ff 4d e4             	decl   -0x1c(%ebp)
  801bdc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801be0:	7f e4                	jg     801bc6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801be2:	eb 34                	jmp    801c18 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801be4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801be8:	74 1c                	je     801c06 <vprintfmt+0x207>
  801bea:	83 fb 1f             	cmp    $0x1f,%ebx
  801bed:	7e 05                	jle    801bf4 <vprintfmt+0x1f5>
  801bef:	83 fb 7e             	cmp    $0x7e,%ebx
  801bf2:	7e 12                	jle    801c06 <vprintfmt+0x207>
					putch('?', putdat);
  801bf4:	83 ec 08             	sub    $0x8,%esp
  801bf7:	ff 75 0c             	pushl  0xc(%ebp)
  801bfa:	6a 3f                	push   $0x3f
  801bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bff:	ff d0                	call   *%eax
  801c01:	83 c4 10             	add    $0x10,%esp
  801c04:	eb 0f                	jmp    801c15 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801c06:	83 ec 08             	sub    $0x8,%esp
  801c09:	ff 75 0c             	pushl  0xc(%ebp)
  801c0c:	53                   	push   %ebx
  801c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c10:	ff d0                	call   *%eax
  801c12:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801c15:	ff 4d e4             	decl   -0x1c(%ebp)
  801c18:	89 f0                	mov    %esi,%eax
  801c1a:	8d 70 01             	lea    0x1(%eax),%esi
  801c1d:	8a 00                	mov    (%eax),%al
  801c1f:	0f be d8             	movsbl %al,%ebx
  801c22:	85 db                	test   %ebx,%ebx
  801c24:	74 24                	je     801c4a <vprintfmt+0x24b>
  801c26:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c2a:	78 b8                	js     801be4 <vprintfmt+0x1e5>
  801c2c:	ff 4d e0             	decl   -0x20(%ebp)
  801c2f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c33:	79 af                	jns    801be4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c35:	eb 13                	jmp    801c4a <vprintfmt+0x24b>
				putch(' ', putdat);
  801c37:	83 ec 08             	sub    $0x8,%esp
  801c3a:	ff 75 0c             	pushl  0xc(%ebp)
  801c3d:	6a 20                	push   $0x20
  801c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c42:	ff d0                	call   *%eax
  801c44:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c47:	ff 4d e4             	decl   -0x1c(%ebp)
  801c4a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c4e:	7f e7                	jg     801c37 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801c50:	e9 66 01 00 00       	jmp    801dbb <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801c55:	83 ec 08             	sub    $0x8,%esp
  801c58:	ff 75 e8             	pushl  -0x18(%ebp)
  801c5b:	8d 45 14             	lea    0x14(%ebp),%eax
  801c5e:	50                   	push   %eax
  801c5f:	e8 3c fd ff ff       	call   8019a0 <getint>
  801c64:	83 c4 10             	add    $0x10,%esp
  801c67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c6a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801c6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c70:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c73:	85 d2                	test   %edx,%edx
  801c75:	79 23                	jns    801c9a <vprintfmt+0x29b>
				putch('-', putdat);
  801c77:	83 ec 08             	sub    $0x8,%esp
  801c7a:	ff 75 0c             	pushl  0xc(%ebp)
  801c7d:	6a 2d                	push   $0x2d
  801c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c82:	ff d0                	call   *%eax
  801c84:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801c87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c8d:	f7 d8                	neg    %eax
  801c8f:	83 d2 00             	adc    $0x0,%edx
  801c92:	f7 da                	neg    %edx
  801c94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c97:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801c9a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801ca1:	e9 bc 00 00 00       	jmp    801d62 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801ca6:	83 ec 08             	sub    $0x8,%esp
  801ca9:	ff 75 e8             	pushl  -0x18(%ebp)
  801cac:	8d 45 14             	lea    0x14(%ebp),%eax
  801caf:	50                   	push   %eax
  801cb0:	e8 84 fc ff ff       	call   801939 <getuint>
  801cb5:	83 c4 10             	add    $0x10,%esp
  801cb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cbb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801cbe:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801cc5:	e9 98 00 00 00       	jmp    801d62 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801cca:	83 ec 08             	sub    $0x8,%esp
  801ccd:	ff 75 0c             	pushl  0xc(%ebp)
  801cd0:	6a 58                	push   $0x58
  801cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd5:	ff d0                	call   *%eax
  801cd7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801cda:	83 ec 08             	sub    $0x8,%esp
  801cdd:	ff 75 0c             	pushl  0xc(%ebp)
  801ce0:	6a 58                	push   $0x58
  801ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce5:	ff d0                	call   *%eax
  801ce7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801cea:	83 ec 08             	sub    $0x8,%esp
  801ced:	ff 75 0c             	pushl  0xc(%ebp)
  801cf0:	6a 58                	push   $0x58
  801cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf5:	ff d0                	call   *%eax
  801cf7:	83 c4 10             	add    $0x10,%esp
			break;
  801cfa:	e9 bc 00 00 00       	jmp    801dbb <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801cff:	83 ec 08             	sub    $0x8,%esp
  801d02:	ff 75 0c             	pushl  0xc(%ebp)
  801d05:	6a 30                	push   $0x30
  801d07:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0a:	ff d0                	call   *%eax
  801d0c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801d0f:	83 ec 08             	sub    $0x8,%esp
  801d12:	ff 75 0c             	pushl  0xc(%ebp)
  801d15:	6a 78                	push   $0x78
  801d17:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1a:	ff d0                	call   *%eax
  801d1c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801d1f:	8b 45 14             	mov    0x14(%ebp),%eax
  801d22:	83 c0 04             	add    $0x4,%eax
  801d25:	89 45 14             	mov    %eax,0x14(%ebp)
  801d28:	8b 45 14             	mov    0x14(%ebp),%eax
  801d2b:	83 e8 04             	sub    $0x4,%eax
  801d2e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801d30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d33:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801d3a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801d41:	eb 1f                	jmp    801d62 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801d43:	83 ec 08             	sub    $0x8,%esp
  801d46:	ff 75 e8             	pushl  -0x18(%ebp)
  801d49:	8d 45 14             	lea    0x14(%ebp),%eax
  801d4c:	50                   	push   %eax
  801d4d:	e8 e7 fb ff ff       	call   801939 <getuint>
  801d52:	83 c4 10             	add    $0x10,%esp
  801d55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801d5b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801d62:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801d66:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d69:	83 ec 04             	sub    $0x4,%esp
  801d6c:	52                   	push   %edx
  801d6d:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d70:	50                   	push   %eax
  801d71:	ff 75 f4             	pushl  -0xc(%ebp)
  801d74:	ff 75 f0             	pushl  -0x10(%ebp)
  801d77:	ff 75 0c             	pushl  0xc(%ebp)
  801d7a:	ff 75 08             	pushl  0x8(%ebp)
  801d7d:	e8 00 fb ff ff       	call   801882 <printnum>
  801d82:	83 c4 20             	add    $0x20,%esp
			break;
  801d85:	eb 34                	jmp    801dbb <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801d87:	83 ec 08             	sub    $0x8,%esp
  801d8a:	ff 75 0c             	pushl  0xc(%ebp)
  801d8d:	53                   	push   %ebx
  801d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d91:	ff d0                	call   *%eax
  801d93:	83 c4 10             	add    $0x10,%esp
			break;
  801d96:	eb 23                	jmp    801dbb <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801d98:	83 ec 08             	sub    $0x8,%esp
  801d9b:	ff 75 0c             	pushl  0xc(%ebp)
  801d9e:	6a 25                	push   $0x25
  801da0:	8b 45 08             	mov    0x8(%ebp),%eax
  801da3:	ff d0                	call   *%eax
  801da5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801da8:	ff 4d 10             	decl   0x10(%ebp)
  801dab:	eb 03                	jmp    801db0 <vprintfmt+0x3b1>
  801dad:	ff 4d 10             	decl   0x10(%ebp)
  801db0:	8b 45 10             	mov    0x10(%ebp),%eax
  801db3:	48                   	dec    %eax
  801db4:	8a 00                	mov    (%eax),%al
  801db6:	3c 25                	cmp    $0x25,%al
  801db8:	75 f3                	jne    801dad <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801dba:	90                   	nop
		}
	}
  801dbb:	e9 47 fc ff ff       	jmp    801a07 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801dc0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801dc1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801dc4:	5b                   	pop    %ebx
  801dc5:	5e                   	pop    %esi
  801dc6:	5d                   	pop    %ebp
  801dc7:	c3                   	ret    

00801dc8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801dc8:	55                   	push   %ebp
  801dc9:	89 e5                	mov    %esp,%ebp
  801dcb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801dce:	8d 45 10             	lea    0x10(%ebp),%eax
  801dd1:	83 c0 04             	add    $0x4,%eax
  801dd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801dd7:	8b 45 10             	mov    0x10(%ebp),%eax
  801dda:	ff 75 f4             	pushl  -0xc(%ebp)
  801ddd:	50                   	push   %eax
  801dde:	ff 75 0c             	pushl  0xc(%ebp)
  801de1:	ff 75 08             	pushl  0x8(%ebp)
  801de4:	e8 16 fc ff ff       	call   8019ff <vprintfmt>
  801de9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801dec:	90                   	nop
  801ded:	c9                   	leave  
  801dee:	c3                   	ret    

00801def <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801def:	55                   	push   %ebp
  801df0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801df2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801df5:	8b 40 08             	mov    0x8(%eax),%eax
  801df8:	8d 50 01             	lea    0x1(%eax),%edx
  801dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dfe:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801e01:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e04:	8b 10                	mov    (%eax),%edx
  801e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e09:	8b 40 04             	mov    0x4(%eax),%eax
  801e0c:	39 c2                	cmp    %eax,%edx
  801e0e:	73 12                	jae    801e22 <sprintputch+0x33>
		*b->buf++ = ch;
  801e10:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e13:	8b 00                	mov    (%eax),%eax
  801e15:	8d 48 01             	lea    0x1(%eax),%ecx
  801e18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e1b:	89 0a                	mov    %ecx,(%edx)
  801e1d:	8b 55 08             	mov    0x8(%ebp),%edx
  801e20:	88 10                	mov    %dl,(%eax)
}
  801e22:	90                   	nop
  801e23:	5d                   	pop    %ebp
  801e24:	c3                   	ret    

00801e25 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801e25:	55                   	push   %ebp
  801e26:	89 e5                	mov    %esp,%ebp
  801e28:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e34:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e37:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3a:	01 d0                	add    %edx,%eax
  801e3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801e46:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e4a:	74 06                	je     801e52 <vsnprintf+0x2d>
  801e4c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801e50:	7f 07                	jg     801e59 <vsnprintf+0x34>
		return -E_INVAL;
  801e52:	b8 03 00 00 00       	mov    $0x3,%eax
  801e57:	eb 20                	jmp    801e79 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801e59:	ff 75 14             	pushl  0x14(%ebp)
  801e5c:	ff 75 10             	pushl  0x10(%ebp)
  801e5f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801e62:	50                   	push   %eax
  801e63:	68 ef 1d 80 00       	push   $0x801def
  801e68:	e8 92 fb ff ff       	call   8019ff <vprintfmt>
  801e6d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801e70:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e73:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801e79:	c9                   	leave  
  801e7a:	c3                   	ret    

00801e7b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801e7b:	55                   	push   %ebp
  801e7c:	89 e5                	mov    %esp,%ebp
  801e7e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801e81:	8d 45 10             	lea    0x10(%ebp),%eax
  801e84:	83 c0 04             	add    $0x4,%eax
  801e87:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801e8a:	8b 45 10             	mov    0x10(%ebp),%eax
  801e8d:	ff 75 f4             	pushl  -0xc(%ebp)
  801e90:	50                   	push   %eax
  801e91:	ff 75 0c             	pushl  0xc(%ebp)
  801e94:	ff 75 08             	pushl  0x8(%ebp)
  801e97:	e8 89 ff ff ff       	call   801e25 <vsnprintf>
  801e9c:	83 c4 10             	add    $0x10,%esp
  801e9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801ea2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ea5:	c9                   	leave  
  801ea6:	c3                   	ret    

00801ea7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801ea7:	55                   	push   %ebp
  801ea8:	89 e5                	mov    %esp,%ebp
  801eaa:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801ead:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801eb4:	eb 06                	jmp    801ebc <strlen+0x15>
		n++;
  801eb6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801eb9:	ff 45 08             	incl   0x8(%ebp)
  801ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebf:	8a 00                	mov    (%eax),%al
  801ec1:	84 c0                	test   %al,%al
  801ec3:	75 f1                	jne    801eb6 <strlen+0xf>
		n++;
	return n;
  801ec5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ec8:	c9                   	leave  
  801ec9:	c3                   	ret    

00801eca <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801eca:	55                   	push   %ebp
  801ecb:	89 e5                	mov    %esp,%ebp
  801ecd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801ed0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ed7:	eb 09                	jmp    801ee2 <strnlen+0x18>
		n++;
  801ed9:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801edc:	ff 45 08             	incl   0x8(%ebp)
  801edf:	ff 4d 0c             	decl   0xc(%ebp)
  801ee2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801ee6:	74 09                	je     801ef1 <strnlen+0x27>
  801ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  801eeb:	8a 00                	mov    (%eax),%al
  801eed:	84 c0                	test   %al,%al
  801eef:	75 e8                	jne    801ed9 <strnlen+0xf>
		n++;
	return n;
  801ef1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ef4:	c9                   	leave  
  801ef5:	c3                   	ret    

00801ef6 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801ef6:	55                   	push   %ebp
  801ef7:	89 e5                	mov    %esp,%ebp
  801ef9:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801efc:	8b 45 08             	mov    0x8(%ebp),%eax
  801eff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801f02:	90                   	nop
  801f03:	8b 45 08             	mov    0x8(%ebp),%eax
  801f06:	8d 50 01             	lea    0x1(%eax),%edx
  801f09:	89 55 08             	mov    %edx,0x8(%ebp)
  801f0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f0f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f12:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f15:	8a 12                	mov    (%edx),%dl
  801f17:	88 10                	mov    %dl,(%eax)
  801f19:	8a 00                	mov    (%eax),%al
  801f1b:	84 c0                	test   %al,%al
  801f1d:	75 e4                	jne    801f03 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801f1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f22:	c9                   	leave  
  801f23:	c3                   	ret    

00801f24 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801f24:	55                   	push   %ebp
  801f25:	89 e5                	mov    %esp,%ebp
  801f27:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801f30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801f37:	eb 1f                	jmp    801f58 <strncpy+0x34>
		*dst++ = *src;
  801f39:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3c:	8d 50 01             	lea    0x1(%eax),%edx
  801f3f:	89 55 08             	mov    %edx,0x8(%ebp)
  801f42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f45:	8a 12                	mov    (%edx),%dl
  801f47:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801f49:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f4c:	8a 00                	mov    (%eax),%al
  801f4e:	84 c0                	test   %al,%al
  801f50:	74 03                	je     801f55 <strncpy+0x31>
			src++;
  801f52:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801f55:	ff 45 fc             	incl   -0x4(%ebp)
  801f58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f5b:	3b 45 10             	cmp    0x10(%ebp),%eax
  801f5e:	72 d9                	jb     801f39 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801f60:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801f63:	c9                   	leave  
  801f64:	c3                   	ret    

00801f65 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801f65:	55                   	push   %ebp
  801f66:	89 e5                	mov    %esp,%ebp
  801f68:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801f71:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f75:	74 30                	je     801fa7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801f77:	eb 16                	jmp    801f8f <strlcpy+0x2a>
			*dst++ = *src++;
  801f79:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7c:	8d 50 01             	lea    0x1(%eax),%edx
  801f7f:	89 55 08             	mov    %edx,0x8(%ebp)
  801f82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f85:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f88:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f8b:	8a 12                	mov    (%edx),%dl
  801f8d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801f8f:	ff 4d 10             	decl   0x10(%ebp)
  801f92:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f96:	74 09                	je     801fa1 <strlcpy+0x3c>
  801f98:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f9b:	8a 00                	mov    (%eax),%al
  801f9d:	84 c0                	test   %al,%al
  801f9f:	75 d8                	jne    801f79 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801fa1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801fa7:	8b 55 08             	mov    0x8(%ebp),%edx
  801faa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801fad:	29 c2                	sub    %eax,%edx
  801faf:	89 d0                	mov    %edx,%eax
}
  801fb1:	c9                   	leave  
  801fb2:	c3                   	ret    

00801fb3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801fb3:	55                   	push   %ebp
  801fb4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801fb6:	eb 06                	jmp    801fbe <strcmp+0xb>
		p++, q++;
  801fb8:	ff 45 08             	incl   0x8(%ebp)
  801fbb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc1:	8a 00                	mov    (%eax),%al
  801fc3:	84 c0                	test   %al,%al
  801fc5:	74 0e                	je     801fd5 <strcmp+0x22>
  801fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fca:	8a 10                	mov    (%eax),%dl
  801fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fcf:	8a 00                	mov    (%eax),%al
  801fd1:	38 c2                	cmp    %al,%dl
  801fd3:	74 e3                	je     801fb8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd8:	8a 00                	mov    (%eax),%al
  801fda:	0f b6 d0             	movzbl %al,%edx
  801fdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fe0:	8a 00                	mov    (%eax),%al
  801fe2:	0f b6 c0             	movzbl %al,%eax
  801fe5:	29 c2                	sub    %eax,%edx
  801fe7:	89 d0                	mov    %edx,%eax
}
  801fe9:	5d                   	pop    %ebp
  801fea:	c3                   	ret    

00801feb <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801feb:	55                   	push   %ebp
  801fec:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801fee:	eb 09                	jmp    801ff9 <strncmp+0xe>
		n--, p++, q++;
  801ff0:	ff 4d 10             	decl   0x10(%ebp)
  801ff3:	ff 45 08             	incl   0x8(%ebp)
  801ff6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801ff9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801ffd:	74 17                	je     802016 <strncmp+0x2b>
  801fff:	8b 45 08             	mov    0x8(%ebp),%eax
  802002:	8a 00                	mov    (%eax),%al
  802004:	84 c0                	test   %al,%al
  802006:	74 0e                	je     802016 <strncmp+0x2b>
  802008:	8b 45 08             	mov    0x8(%ebp),%eax
  80200b:	8a 10                	mov    (%eax),%dl
  80200d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802010:	8a 00                	mov    (%eax),%al
  802012:	38 c2                	cmp    %al,%dl
  802014:	74 da                	je     801ff0 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  802016:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80201a:	75 07                	jne    802023 <strncmp+0x38>
		return 0;
  80201c:	b8 00 00 00 00       	mov    $0x0,%eax
  802021:	eb 14                	jmp    802037 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  802023:	8b 45 08             	mov    0x8(%ebp),%eax
  802026:	8a 00                	mov    (%eax),%al
  802028:	0f b6 d0             	movzbl %al,%edx
  80202b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80202e:	8a 00                	mov    (%eax),%al
  802030:	0f b6 c0             	movzbl %al,%eax
  802033:	29 c2                	sub    %eax,%edx
  802035:	89 d0                	mov    %edx,%eax
}
  802037:	5d                   	pop    %ebp
  802038:	c3                   	ret    

00802039 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  802039:	55                   	push   %ebp
  80203a:	89 e5                	mov    %esp,%ebp
  80203c:	83 ec 04             	sub    $0x4,%esp
  80203f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802042:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802045:	eb 12                	jmp    802059 <strchr+0x20>
		if (*s == c)
  802047:	8b 45 08             	mov    0x8(%ebp),%eax
  80204a:	8a 00                	mov    (%eax),%al
  80204c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80204f:	75 05                	jne    802056 <strchr+0x1d>
			return (char *) s;
  802051:	8b 45 08             	mov    0x8(%ebp),%eax
  802054:	eb 11                	jmp    802067 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802056:	ff 45 08             	incl   0x8(%ebp)
  802059:	8b 45 08             	mov    0x8(%ebp),%eax
  80205c:	8a 00                	mov    (%eax),%al
  80205e:	84 c0                	test   %al,%al
  802060:	75 e5                	jne    802047 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  802062:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802067:	c9                   	leave  
  802068:	c3                   	ret    

00802069 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  802069:	55                   	push   %ebp
  80206a:	89 e5                	mov    %esp,%ebp
  80206c:	83 ec 04             	sub    $0x4,%esp
  80206f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802072:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802075:	eb 0d                	jmp    802084 <strfind+0x1b>
		if (*s == c)
  802077:	8b 45 08             	mov    0x8(%ebp),%eax
  80207a:	8a 00                	mov    (%eax),%al
  80207c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80207f:	74 0e                	je     80208f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  802081:	ff 45 08             	incl   0x8(%ebp)
  802084:	8b 45 08             	mov    0x8(%ebp),%eax
  802087:	8a 00                	mov    (%eax),%al
  802089:	84 c0                	test   %al,%al
  80208b:	75 ea                	jne    802077 <strfind+0xe>
  80208d:	eb 01                	jmp    802090 <strfind+0x27>
		if (*s == c)
			break;
  80208f:	90                   	nop
	return (char *) s;
  802090:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802093:	c9                   	leave  
  802094:	c3                   	ret    

00802095 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  802095:	55                   	push   %ebp
  802096:	89 e5                	mov    %esp,%ebp
  802098:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80209b:	8b 45 08             	mov    0x8(%ebp),%eax
  80209e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8020a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8020a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8020a7:	eb 0e                	jmp    8020b7 <memset+0x22>
		*p++ = c;
  8020a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020ac:	8d 50 01             	lea    0x1(%eax),%edx
  8020af:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8020b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020b5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8020b7:	ff 4d f8             	decl   -0x8(%ebp)
  8020ba:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8020be:	79 e9                	jns    8020a9 <memset+0x14>
		*p++ = c;

	return v;
  8020c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020c3:	c9                   	leave  
  8020c4:	c3                   	ret    

008020c5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8020c5:	55                   	push   %ebp
  8020c6:	89 e5                	mov    %esp,%ebp
  8020c8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8020cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8020d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8020d7:	eb 16                	jmp    8020ef <memcpy+0x2a>
		*d++ = *s++;
  8020d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020dc:	8d 50 01             	lea    0x1(%eax),%edx
  8020df:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8020e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020e5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8020e8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8020eb:	8a 12                	mov    (%edx),%dl
  8020ed:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8020ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8020f2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8020f5:	89 55 10             	mov    %edx,0x10(%ebp)
  8020f8:	85 c0                	test   %eax,%eax
  8020fa:	75 dd                	jne    8020d9 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8020fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020ff:	c9                   	leave  
  802100:	c3                   	ret    

00802101 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802101:	55                   	push   %ebp
  802102:	89 e5                	mov    %esp,%ebp
  802104:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  802107:	8b 45 0c             	mov    0xc(%ebp),%eax
  80210a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80210d:	8b 45 08             	mov    0x8(%ebp),%eax
  802110:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  802113:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802116:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802119:	73 50                	jae    80216b <memmove+0x6a>
  80211b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80211e:	8b 45 10             	mov    0x10(%ebp),%eax
  802121:	01 d0                	add    %edx,%eax
  802123:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802126:	76 43                	jbe    80216b <memmove+0x6a>
		s += n;
  802128:	8b 45 10             	mov    0x10(%ebp),%eax
  80212b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80212e:	8b 45 10             	mov    0x10(%ebp),%eax
  802131:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802134:	eb 10                	jmp    802146 <memmove+0x45>
			*--d = *--s;
  802136:	ff 4d f8             	decl   -0x8(%ebp)
  802139:	ff 4d fc             	decl   -0x4(%ebp)
  80213c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80213f:	8a 10                	mov    (%eax),%dl
  802141:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802144:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802146:	8b 45 10             	mov    0x10(%ebp),%eax
  802149:	8d 50 ff             	lea    -0x1(%eax),%edx
  80214c:	89 55 10             	mov    %edx,0x10(%ebp)
  80214f:	85 c0                	test   %eax,%eax
  802151:	75 e3                	jne    802136 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802153:	eb 23                	jmp    802178 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802155:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802158:	8d 50 01             	lea    0x1(%eax),%edx
  80215b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80215e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802161:	8d 4a 01             	lea    0x1(%edx),%ecx
  802164:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802167:	8a 12                	mov    (%edx),%dl
  802169:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80216b:	8b 45 10             	mov    0x10(%ebp),%eax
  80216e:	8d 50 ff             	lea    -0x1(%eax),%edx
  802171:	89 55 10             	mov    %edx,0x10(%ebp)
  802174:	85 c0                	test   %eax,%eax
  802176:	75 dd                	jne    802155 <memmove+0x54>
			*d++ = *s++;

	return dst;
  802178:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80217b:	c9                   	leave  
  80217c:	c3                   	ret    

0080217d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80217d:	55                   	push   %ebp
  80217e:	89 e5                	mov    %esp,%ebp
  802180:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  802183:	8b 45 08             	mov    0x8(%ebp),%eax
  802186:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  802189:	8b 45 0c             	mov    0xc(%ebp),%eax
  80218c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80218f:	eb 2a                	jmp    8021bb <memcmp+0x3e>
		if (*s1 != *s2)
  802191:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802194:	8a 10                	mov    (%eax),%dl
  802196:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802199:	8a 00                	mov    (%eax),%al
  80219b:	38 c2                	cmp    %al,%dl
  80219d:	74 16                	je     8021b5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80219f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021a2:	8a 00                	mov    (%eax),%al
  8021a4:	0f b6 d0             	movzbl %al,%edx
  8021a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021aa:	8a 00                	mov    (%eax),%al
  8021ac:	0f b6 c0             	movzbl %al,%eax
  8021af:	29 c2                	sub    %eax,%edx
  8021b1:	89 d0                	mov    %edx,%eax
  8021b3:	eb 18                	jmp    8021cd <memcmp+0x50>
		s1++, s2++;
  8021b5:	ff 45 fc             	incl   -0x4(%ebp)
  8021b8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8021bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8021be:	8d 50 ff             	lea    -0x1(%eax),%edx
  8021c1:	89 55 10             	mov    %edx,0x10(%ebp)
  8021c4:	85 c0                	test   %eax,%eax
  8021c6:	75 c9                	jne    802191 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8021c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021cd:	c9                   	leave  
  8021ce:	c3                   	ret    

008021cf <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8021cf:	55                   	push   %ebp
  8021d0:	89 e5                	mov    %esp,%ebp
  8021d2:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8021d5:	8b 55 08             	mov    0x8(%ebp),%edx
  8021d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8021db:	01 d0                	add    %edx,%eax
  8021dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8021e0:	eb 15                	jmp    8021f7 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8021e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e5:	8a 00                	mov    (%eax),%al
  8021e7:	0f b6 d0             	movzbl %al,%edx
  8021ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021ed:	0f b6 c0             	movzbl %al,%eax
  8021f0:	39 c2                	cmp    %eax,%edx
  8021f2:	74 0d                	je     802201 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8021f4:	ff 45 08             	incl   0x8(%ebp)
  8021f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8021fd:	72 e3                	jb     8021e2 <memfind+0x13>
  8021ff:	eb 01                	jmp    802202 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802201:	90                   	nop
	return (void *) s;
  802202:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802205:	c9                   	leave  
  802206:	c3                   	ret    

00802207 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802207:	55                   	push   %ebp
  802208:	89 e5                	mov    %esp,%ebp
  80220a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80220d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802214:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80221b:	eb 03                	jmp    802220 <strtol+0x19>
		s++;
  80221d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802220:	8b 45 08             	mov    0x8(%ebp),%eax
  802223:	8a 00                	mov    (%eax),%al
  802225:	3c 20                	cmp    $0x20,%al
  802227:	74 f4                	je     80221d <strtol+0x16>
  802229:	8b 45 08             	mov    0x8(%ebp),%eax
  80222c:	8a 00                	mov    (%eax),%al
  80222e:	3c 09                	cmp    $0x9,%al
  802230:	74 eb                	je     80221d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802232:	8b 45 08             	mov    0x8(%ebp),%eax
  802235:	8a 00                	mov    (%eax),%al
  802237:	3c 2b                	cmp    $0x2b,%al
  802239:	75 05                	jne    802240 <strtol+0x39>
		s++;
  80223b:	ff 45 08             	incl   0x8(%ebp)
  80223e:	eb 13                	jmp    802253 <strtol+0x4c>
	else if (*s == '-')
  802240:	8b 45 08             	mov    0x8(%ebp),%eax
  802243:	8a 00                	mov    (%eax),%al
  802245:	3c 2d                	cmp    $0x2d,%al
  802247:	75 0a                	jne    802253 <strtol+0x4c>
		s++, neg = 1;
  802249:	ff 45 08             	incl   0x8(%ebp)
  80224c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802253:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802257:	74 06                	je     80225f <strtol+0x58>
  802259:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80225d:	75 20                	jne    80227f <strtol+0x78>
  80225f:	8b 45 08             	mov    0x8(%ebp),%eax
  802262:	8a 00                	mov    (%eax),%al
  802264:	3c 30                	cmp    $0x30,%al
  802266:	75 17                	jne    80227f <strtol+0x78>
  802268:	8b 45 08             	mov    0x8(%ebp),%eax
  80226b:	40                   	inc    %eax
  80226c:	8a 00                	mov    (%eax),%al
  80226e:	3c 78                	cmp    $0x78,%al
  802270:	75 0d                	jne    80227f <strtol+0x78>
		s += 2, base = 16;
  802272:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802276:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80227d:	eb 28                	jmp    8022a7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80227f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802283:	75 15                	jne    80229a <strtol+0x93>
  802285:	8b 45 08             	mov    0x8(%ebp),%eax
  802288:	8a 00                	mov    (%eax),%al
  80228a:	3c 30                	cmp    $0x30,%al
  80228c:	75 0c                	jne    80229a <strtol+0x93>
		s++, base = 8;
  80228e:	ff 45 08             	incl   0x8(%ebp)
  802291:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802298:	eb 0d                	jmp    8022a7 <strtol+0xa0>
	else if (base == 0)
  80229a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80229e:	75 07                	jne    8022a7 <strtol+0xa0>
		base = 10;
  8022a0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8022a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8022aa:	8a 00                	mov    (%eax),%al
  8022ac:	3c 2f                	cmp    $0x2f,%al
  8022ae:	7e 19                	jle    8022c9 <strtol+0xc2>
  8022b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b3:	8a 00                	mov    (%eax),%al
  8022b5:	3c 39                	cmp    $0x39,%al
  8022b7:	7f 10                	jg     8022c9 <strtol+0xc2>
			dig = *s - '0';
  8022b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022bc:	8a 00                	mov    (%eax),%al
  8022be:	0f be c0             	movsbl %al,%eax
  8022c1:	83 e8 30             	sub    $0x30,%eax
  8022c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022c7:	eb 42                	jmp    80230b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8022c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022cc:	8a 00                	mov    (%eax),%al
  8022ce:	3c 60                	cmp    $0x60,%al
  8022d0:	7e 19                	jle    8022eb <strtol+0xe4>
  8022d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d5:	8a 00                	mov    (%eax),%al
  8022d7:	3c 7a                	cmp    $0x7a,%al
  8022d9:	7f 10                	jg     8022eb <strtol+0xe4>
			dig = *s - 'a' + 10;
  8022db:	8b 45 08             	mov    0x8(%ebp),%eax
  8022de:	8a 00                	mov    (%eax),%al
  8022e0:	0f be c0             	movsbl %al,%eax
  8022e3:	83 e8 57             	sub    $0x57,%eax
  8022e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022e9:	eb 20                	jmp    80230b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8022eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ee:	8a 00                	mov    (%eax),%al
  8022f0:	3c 40                	cmp    $0x40,%al
  8022f2:	7e 39                	jle    80232d <strtol+0x126>
  8022f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f7:	8a 00                	mov    (%eax),%al
  8022f9:	3c 5a                	cmp    $0x5a,%al
  8022fb:	7f 30                	jg     80232d <strtol+0x126>
			dig = *s - 'A' + 10;
  8022fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802300:	8a 00                	mov    (%eax),%al
  802302:	0f be c0             	movsbl %al,%eax
  802305:	83 e8 37             	sub    $0x37,%eax
  802308:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80230b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80230e:	3b 45 10             	cmp    0x10(%ebp),%eax
  802311:	7d 19                	jge    80232c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802313:	ff 45 08             	incl   0x8(%ebp)
  802316:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802319:	0f af 45 10          	imul   0x10(%ebp),%eax
  80231d:	89 c2                	mov    %eax,%edx
  80231f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802322:	01 d0                	add    %edx,%eax
  802324:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802327:	e9 7b ff ff ff       	jmp    8022a7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80232c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80232d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802331:	74 08                	je     80233b <strtol+0x134>
		*endptr = (char *) s;
  802333:	8b 45 0c             	mov    0xc(%ebp),%eax
  802336:	8b 55 08             	mov    0x8(%ebp),%edx
  802339:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80233b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80233f:	74 07                	je     802348 <strtol+0x141>
  802341:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802344:	f7 d8                	neg    %eax
  802346:	eb 03                	jmp    80234b <strtol+0x144>
  802348:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80234b:	c9                   	leave  
  80234c:	c3                   	ret    

0080234d <ltostr>:

void
ltostr(long value, char *str)
{
  80234d:	55                   	push   %ebp
  80234e:	89 e5                	mov    %esp,%ebp
  802350:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802353:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80235a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802361:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802365:	79 13                	jns    80237a <ltostr+0x2d>
	{
		neg = 1;
  802367:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80236e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802371:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802374:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802377:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80237a:	8b 45 08             	mov    0x8(%ebp),%eax
  80237d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  802382:	99                   	cltd   
  802383:	f7 f9                	idiv   %ecx
  802385:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802388:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80238b:	8d 50 01             	lea    0x1(%eax),%edx
  80238e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802391:	89 c2                	mov    %eax,%edx
  802393:	8b 45 0c             	mov    0xc(%ebp),%eax
  802396:	01 d0                	add    %edx,%eax
  802398:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80239b:	83 c2 30             	add    $0x30,%edx
  80239e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8023a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023a3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8023a8:	f7 e9                	imul   %ecx
  8023aa:	c1 fa 02             	sar    $0x2,%edx
  8023ad:	89 c8                	mov    %ecx,%eax
  8023af:	c1 f8 1f             	sar    $0x1f,%eax
  8023b2:	29 c2                	sub    %eax,%edx
  8023b4:	89 d0                	mov    %edx,%eax
  8023b6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8023b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023bc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8023c1:	f7 e9                	imul   %ecx
  8023c3:	c1 fa 02             	sar    $0x2,%edx
  8023c6:	89 c8                	mov    %ecx,%eax
  8023c8:	c1 f8 1f             	sar    $0x1f,%eax
  8023cb:	29 c2                	sub    %eax,%edx
  8023cd:	89 d0                	mov    %edx,%eax
  8023cf:	c1 e0 02             	shl    $0x2,%eax
  8023d2:	01 d0                	add    %edx,%eax
  8023d4:	01 c0                	add    %eax,%eax
  8023d6:	29 c1                	sub    %eax,%ecx
  8023d8:	89 ca                	mov    %ecx,%edx
  8023da:	85 d2                	test   %edx,%edx
  8023dc:	75 9c                	jne    80237a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8023de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8023e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023e8:	48                   	dec    %eax
  8023e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8023ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8023f0:	74 3d                	je     80242f <ltostr+0xe2>
		start = 1 ;
  8023f2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8023f9:	eb 34                	jmp    80242f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8023fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8023fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  802401:	01 d0                	add    %edx,%eax
  802403:	8a 00                	mov    (%eax),%al
  802405:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802408:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80240b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80240e:	01 c2                	add    %eax,%edx
  802410:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802413:	8b 45 0c             	mov    0xc(%ebp),%eax
  802416:	01 c8                	add    %ecx,%eax
  802418:	8a 00                	mov    (%eax),%al
  80241a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80241c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80241f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802422:	01 c2                	add    %eax,%edx
  802424:	8a 45 eb             	mov    -0x15(%ebp),%al
  802427:	88 02                	mov    %al,(%edx)
		start++ ;
  802429:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80242c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80242f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802432:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802435:	7c c4                	jl     8023fb <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802437:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80243a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80243d:	01 d0                	add    %edx,%eax
  80243f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802442:	90                   	nop
  802443:	c9                   	leave  
  802444:	c3                   	ret    

00802445 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802445:	55                   	push   %ebp
  802446:	89 e5                	mov    %esp,%ebp
  802448:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80244b:	ff 75 08             	pushl  0x8(%ebp)
  80244e:	e8 54 fa ff ff       	call   801ea7 <strlen>
  802453:	83 c4 04             	add    $0x4,%esp
  802456:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802459:	ff 75 0c             	pushl  0xc(%ebp)
  80245c:	e8 46 fa ff ff       	call   801ea7 <strlen>
  802461:	83 c4 04             	add    $0x4,%esp
  802464:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802467:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80246e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802475:	eb 17                	jmp    80248e <strcconcat+0x49>
		final[s] = str1[s] ;
  802477:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80247a:	8b 45 10             	mov    0x10(%ebp),%eax
  80247d:	01 c2                	add    %eax,%edx
  80247f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802482:	8b 45 08             	mov    0x8(%ebp),%eax
  802485:	01 c8                	add    %ecx,%eax
  802487:	8a 00                	mov    (%eax),%al
  802489:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80248b:	ff 45 fc             	incl   -0x4(%ebp)
  80248e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802491:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802494:	7c e1                	jl     802477 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802496:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80249d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8024a4:	eb 1f                	jmp    8024c5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8024a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024a9:	8d 50 01             	lea    0x1(%eax),%edx
  8024ac:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8024af:	89 c2                	mov    %eax,%edx
  8024b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8024b4:	01 c2                	add    %eax,%edx
  8024b6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8024b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024bc:	01 c8                	add    %ecx,%eax
  8024be:	8a 00                	mov    (%eax),%al
  8024c0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8024c2:	ff 45 f8             	incl   -0x8(%ebp)
  8024c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024c8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8024cb:	7c d9                	jl     8024a6 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8024cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8024d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8024d3:	01 d0                	add    %edx,%eax
  8024d5:	c6 00 00             	movb   $0x0,(%eax)
}
  8024d8:	90                   	nop
  8024d9:	c9                   	leave  
  8024da:	c3                   	ret    

008024db <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8024db:	55                   	push   %ebp
  8024dc:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8024de:	8b 45 14             	mov    0x14(%ebp),%eax
  8024e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8024e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8024ea:	8b 00                	mov    (%eax),%eax
  8024ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8024f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8024f6:	01 d0                	add    %edx,%eax
  8024f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8024fe:	eb 0c                	jmp    80250c <strsplit+0x31>
			*string++ = 0;
  802500:	8b 45 08             	mov    0x8(%ebp),%eax
  802503:	8d 50 01             	lea    0x1(%eax),%edx
  802506:	89 55 08             	mov    %edx,0x8(%ebp)
  802509:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80250c:	8b 45 08             	mov    0x8(%ebp),%eax
  80250f:	8a 00                	mov    (%eax),%al
  802511:	84 c0                	test   %al,%al
  802513:	74 18                	je     80252d <strsplit+0x52>
  802515:	8b 45 08             	mov    0x8(%ebp),%eax
  802518:	8a 00                	mov    (%eax),%al
  80251a:	0f be c0             	movsbl %al,%eax
  80251d:	50                   	push   %eax
  80251e:	ff 75 0c             	pushl  0xc(%ebp)
  802521:	e8 13 fb ff ff       	call   802039 <strchr>
  802526:	83 c4 08             	add    $0x8,%esp
  802529:	85 c0                	test   %eax,%eax
  80252b:	75 d3                	jne    802500 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80252d:	8b 45 08             	mov    0x8(%ebp),%eax
  802530:	8a 00                	mov    (%eax),%al
  802532:	84 c0                	test   %al,%al
  802534:	74 5a                	je     802590 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  802536:	8b 45 14             	mov    0x14(%ebp),%eax
  802539:	8b 00                	mov    (%eax),%eax
  80253b:	83 f8 0f             	cmp    $0xf,%eax
  80253e:	75 07                	jne    802547 <strsplit+0x6c>
		{
			return 0;
  802540:	b8 00 00 00 00       	mov    $0x0,%eax
  802545:	eb 66                	jmp    8025ad <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802547:	8b 45 14             	mov    0x14(%ebp),%eax
  80254a:	8b 00                	mov    (%eax),%eax
  80254c:	8d 48 01             	lea    0x1(%eax),%ecx
  80254f:	8b 55 14             	mov    0x14(%ebp),%edx
  802552:	89 0a                	mov    %ecx,(%edx)
  802554:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80255b:	8b 45 10             	mov    0x10(%ebp),%eax
  80255e:	01 c2                	add    %eax,%edx
  802560:	8b 45 08             	mov    0x8(%ebp),%eax
  802563:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802565:	eb 03                	jmp    80256a <strsplit+0x8f>
			string++;
  802567:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80256a:	8b 45 08             	mov    0x8(%ebp),%eax
  80256d:	8a 00                	mov    (%eax),%al
  80256f:	84 c0                	test   %al,%al
  802571:	74 8b                	je     8024fe <strsplit+0x23>
  802573:	8b 45 08             	mov    0x8(%ebp),%eax
  802576:	8a 00                	mov    (%eax),%al
  802578:	0f be c0             	movsbl %al,%eax
  80257b:	50                   	push   %eax
  80257c:	ff 75 0c             	pushl  0xc(%ebp)
  80257f:	e8 b5 fa ff ff       	call   802039 <strchr>
  802584:	83 c4 08             	add    $0x8,%esp
  802587:	85 c0                	test   %eax,%eax
  802589:	74 dc                	je     802567 <strsplit+0x8c>
			string++;
	}
  80258b:	e9 6e ff ff ff       	jmp    8024fe <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  802590:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  802591:	8b 45 14             	mov    0x14(%ebp),%eax
  802594:	8b 00                	mov    (%eax),%eax
  802596:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80259d:	8b 45 10             	mov    0x10(%ebp),%eax
  8025a0:	01 d0                	add    %edx,%eax
  8025a2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8025a8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8025ad:	c9                   	leave  
  8025ae:	c3                   	ret    

008025af <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8025af:	55                   	push   %ebp
  8025b0:	89 e5                	mov    %esp,%ebp
  8025b2:	57                   	push   %edi
  8025b3:	56                   	push   %esi
  8025b4:	53                   	push   %ebx
  8025b5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8025b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8025bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8025be:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8025c1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8025c4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8025c7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8025ca:	cd 30                	int    $0x30
  8025cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8025cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8025d2:	83 c4 10             	add    $0x10,%esp
  8025d5:	5b                   	pop    %ebx
  8025d6:	5e                   	pop    %esi
  8025d7:	5f                   	pop    %edi
  8025d8:	5d                   	pop    %ebp
  8025d9:	c3                   	ret    

008025da <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8025da:	55                   	push   %ebp
  8025db:	89 e5                	mov    %esp,%ebp
  8025dd:	83 ec 04             	sub    $0x4,%esp
  8025e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8025e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8025e6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8025ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8025ed:	6a 00                	push   $0x0
  8025ef:	6a 00                	push   $0x0
  8025f1:	52                   	push   %edx
  8025f2:	ff 75 0c             	pushl  0xc(%ebp)
  8025f5:	50                   	push   %eax
  8025f6:	6a 00                	push   $0x0
  8025f8:	e8 b2 ff ff ff       	call   8025af <syscall>
  8025fd:	83 c4 18             	add    $0x18,%esp
}
  802600:	90                   	nop
  802601:	c9                   	leave  
  802602:	c3                   	ret    

00802603 <sys_cgetc>:

int
sys_cgetc(void)
{
  802603:	55                   	push   %ebp
  802604:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802606:	6a 00                	push   $0x0
  802608:	6a 00                	push   $0x0
  80260a:	6a 00                	push   $0x0
  80260c:	6a 00                	push   $0x0
  80260e:	6a 00                	push   $0x0
  802610:	6a 01                	push   $0x1
  802612:	e8 98 ff ff ff       	call   8025af <syscall>
  802617:	83 c4 18             	add    $0x18,%esp
}
  80261a:	c9                   	leave  
  80261b:	c3                   	ret    

0080261c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80261c:	55                   	push   %ebp
  80261d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80261f:	8b 45 08             	mov    0x8(%ebp),%eax
  802622:	6a 00                	push   $0x0
  802624:	6a 00                	push   $0x0
  802626:	6a 00                	push   $0x0
  802628:	6a 00                	push   $0x0
  80262a:	50                   	push   %eax
  80262b:	6a 05                	push   $0x5
  80262d:	e8 7d ff ff ff       	call   8025af <syscall>
  802632:	83 c4 18             	add    $0x18,%esp
}
  802635:	c9                   	leave  
  802636:	c3                   	ret    

00802637 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802637:	55                   	push   %ebp
  802638:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80263a:	6a 00                	push   $0x0
  80263c:	6a 00                	push   $0x0
  80263e:	6a 00                	push   $0x0
  802640:	6a 00                	push   $0x0
  802642:	6a 00                	push   $0x0
  802644:	6a 02                	push   $0x2
  802646:	e8 64 ff ff ff       	call   8025af <syscall>
  80264b:	83 c4 18             	add    $0x18,%esp
}
  80264e:	c9                   	leave  
  80264f:	c3                   	ret    

00802650 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802650:	55                   	push   %ebp
  802651:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802653:	6a 00                	push   $0x0
  802655:	6a 00                	push   $0x0
  802657:	6a 00                	push   $0x0
  802659:	6a 00                	push   $0x0
  80265b:	6a 00                	push   $0x0
  80265d:	6a 03                	push   $0x3
  80265f:	e8 4b ff ff ff       	call   8025af <syscall>
  802664:	83 c4 18             	add    $0x18,%esp
}
  802667:	c9                   	leave  
  802668:	c3                   	ret    

00802669 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802669:	55                   	push   %ebp
  80266a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80266c:	6a 00                	push   $0x0
  80266e:	6a 00                	push   $0x0
  802670:	6a 00                	push   $0x0
  802672:	6a 00                	push   $0x0
  802674:	6a 00                	push   $0x0
  802676:	6a 04                	push   $0x4
  802678:	e8 32 ff ff ff       	call   8025af <syscall>
  80267d:	83 c4 18             	add    $0x18,%esp
}
  802680:	c9                   	leave  
  802681:	c3                   	ret    

00802682 <sys_env_exit>:


void sys_env_exit(void)
{
  802682:	55                   	push   %ebp
  802683:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802685:	6a 00                	push   $0x0
  802687:	6a 00                	push   $0x0
  802689:	6a 00                	push   $0x0
  80268b:	6a 00                	push   $0x0
  80268d:	6a 00                	push   $0x0
  80268f:	6a 06                	push   $0x6
  802691:	e8 19 ff ff ff       	call   8025af <syscall>
  802696:	83 c4 18             	add    $0x18,%esp
}
  802699:	90                   	nop
  80269a:	c9                   	leave  
  80269b:	c3                   	ret    

0080269c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80269c:	55                   	push   %ebp
  80269d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80269f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8026a5:	6a 00                	push   $0x0
  8026a7:	6a 00                	push   $0x0
  8026a9:	6a 00                	push   $0x0
  8026ab:	52                   	push   %edx
  8026ac:	50                   	push   %eax
  8026ad:	6a 07                	push   $0x7
  8026af:	e8 fb fe ff ff       	call   8025af <syscall>
  8026b4:	83 c4 18             	add    $0x18,%esp
}
  8026b7:	c9                   	leave  
  8026b8:	c3                   	ret    

008026b9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8026b9:	55                   	push   %ebp
  8026ba:	89 e5                	mov    %esp,%ebp
  8026bc:	56                   	push   %esi
  8026bd:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8026be:	8b 75 18             	mov    0x18(%ebp),%esi
  8026c1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8026c4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8026c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8026cd:	56                   	push   %esi
  8026ce:	53                   	push   %ebx
  8026cf:	51                   	push   %ecx
  8026d0:	52                   	push   %edx
  8026d1:	50                   	push   %eax
  8026d2:	6a 08                	push   $0x8
  8026d4:	e8 d6 fe ff ff       	call   8025af <syscall>
  8026d9:	83 c4 18             	add    $0x18,%esp
}
  8026dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8026df:	5b                   	pop    %ebx
  8026e0:	5e                   	pop    %esi
  8026e1:	5d                   	pop    %ebp
  8026e2:	c3                   	ret    

008026e3 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8026e3:	55                   	push   %ebp
  8026e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8026e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ec:	6a 00                	push   $0x0
  8026ee:	6a 00                	push   $0x0
  8026f0:	6a 00                	push   $0x0
  8026f2:	52                   	push   %edx
  8026f3:	50                   	push   %eax
  8026f4:	6a 09                	push   $0x9
  8026f6:	e8 b4 fe ff ff       	call   8025af <syscall>
  8026fb:	83 c4 18             	add    $0x18,%esp
}
  8026fe:	c9                   	leave  
  8026ff:	c3                   	ret    

00802700 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802700:	55                   	push   %ebp
  802701:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802703:	6a 00                	push   $0x0
  802705:	6a 00                	push   $0x0
  802707:	6a 00                	push   $0x0
  802709:	ff 75 0c             	pushl  0xc(%ebp)
  80270c:	ff 75 08             	pushl  0x8(%ebp)
  80270f:	6a 0a                	push   $0xa
  802711:	e8 99 fe ff ff       	call   8025af <syscall>
  802716:	83 c4 18             	add    $0x18,%esp
}
  802719:	c9                   	leave  
  80271a:	c3                   	ret    

0080271b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80271b:	55                   	push   %ebp
  80271c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80271e:	6a 00                	push   $0x0
  802720:	6a 00                	push   $0x0
  802722:	6a 00                	push   $0x0
  802724:	6a 00                	push   $0x0
  802726:	6a 00                	push   $0x0
  802728:	6a 0b                	push   $0xb
  80272a:	e8 80 fe ff ff       	call   8025af <syscall>
  80272f:	83 c4 18             	add    $0x18,%esp
}
  802732:	c9                   	leave  
  802733:	c3                   	ret    

00802734 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802734:	55                   	push   %ebp
  802735:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802737:	6a 00                	push   $0x0
  802739:	6a 00                	push   $0x0
  80273b:	6a 00                	push   $0x0
  80273d:	6a 00                	push   $0x0
  80273f:	6a 00                	push   $0x0
  802741:	6a 0c                	push   $0xc
  802743:	e8 67 fe ff ff       	call   8025af <syscall>
  802748:	83 c4 18             	add    $0x18,%esp
}
  80274b:	c9                   	leave  
  80274c:	c3                   	ret    

0080274d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80274d:	55                   	push   %ebp
  80274e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802750:	6a 00                	push   $0x0
  802752:	6a 00                	push   $0x0
  802754:	6a 00                	push   $0x0
  802756:	6a 00                	push   $0x0
  802758:	6a 00                	push   $0x0
  80275a:	6a 0d                	push   $0xd
  80275c:	e8 4e fe ff ff       	call   8025af <syscall>
  802761:	83 c4 18             	add    $0x18,%esp
}
  802764:	c9                   	leave  
  802765:	c3                   	ret    

00802766 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802766:	55                   	push   %ebp
  802767:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802769:	6a 00                	push   $0x0
  80276b:	6a 00                	push   $0x0
  80276d:	6a 00                	push   $0x0
  80276f:	ff 75 0c             	pushl  0xc(%ebp)
  802772:	ff 75 08             	pushl  0x8(%ebp)
  802775:	6a 11                	push   $0x11
  802777:	e8 33 fe ff ff       	call   8025af <syscall>
  80277c:	83 c4 18             	add    $0x18,%esp
	return;
  80277f:	90                   	nop
}
  802780:	c9                   	leave  
  802781:	c3                   	ret    

00802782 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802782:	55                   	push   %ebp
  802783:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802785:	6a 00                	push   $0x0
  802787:	6a 00                	push   $0x0
  802789:	6a 00                	push   $0x0
  80278b:	ff 75 0c             	pushl  0xc(%ebp)
  80278e:	ff 75 08             	pushl  0x8(%ebp)
  802791:	6a 12                	push   $0x12
  802793:	e8 17 fe ff ff       	call   8025af <syscall>
  802798:	83 c4 18             	add    $0x18,%esp
	return ;
  80279b:	90                   	nop
}
  80279c:	c9                   	leave  
  80279d:	c3                   	ret    

0080279e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80279e:	55                   	push   %ebp
  80279f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8027a1:	6a 00                	push   $0x0
  8027a3:	6a 00                	push   $0x0
  8027a5:	6a 00                	push   $0x0
  8027a7:	6a 00                	push   $0x0
  8027a9:	6a 00                	push   $0x0
  8027ab:	6a 0e                	push   $0xe
  8027ad:	e8 fd fd ff ff       	call   8025af <syscall>
  8027b2:	83 c4 18             	add    $0x18,%esp
}
  8027b5:	c9                   	leave  
  8027b6:	c3                   	ret    

008027b7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8027b7:	55                   	push   %ebp
  8027b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8027ba:	6a 00                	push   $0x0
  8027bc:	6a 00                	push   $0x0
  8027be:	6a 00                	push   $0x0
  8027c0:	6a 00                	push   $0x0
  8027c2:	ff 75 08             	pushl  0x8(%ebp)
  8027c5:	6a 0f                	push   $0xf
  8027c7:	e8 e3 fd ff ff       	call   8025af <syscall>
  8027cc:	83 c4 18             	add    $0x18,%esp
}
  8027cf:	c9                   	leave  
  8027d0:	c3                   	ret    

008027d1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8027d1:	55                   	push   %ebp
  8027d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8027d4:	6a 00                	push   $0x0
  8027d6:	6a 00                	push   $0x0
  8027d8:	6a 00                	push   $0x0
  8027da:	6a 00                	push   $0x0
  8027dc:	6a 00                	push   $0x0
  8027de:	6a 10                	push   $0x10
  8027e0:	e8 ca fd ff ff       	call   8025af <syscall>
  8027e5:	83 c4 18             	add    $0x18,%esp
}
  8027e8:	90                   	nop
  8027e9:	c9                   	leave  
  8027ea:	c3                   	ret    

008027eb <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8027eb:	55                   	push   %ebp
  8027ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8027ee:	6a 00                	push   $0x0
  8027f0:	6a 00                	push   $0x0
  8027f2:	6a 00                	push   $0x0
  8027f4:	6a 00                	push   $0x0
  8027f6:	6a 00                	push   $0x0
  8027f8:	6a 14                	push   $0x14
  8027fa:	e8 b0 fd ff ff       	call   8025af <syscall>
  8027ff:	83 c4 18             	add    $0x18,%esp
}
  802802:	90                   	nop
  802803:	c9                   	leave  
  802804:	c3                   	ret    

00802805 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802805:	55                   	push   %ebp
  802806:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802808:	6a 00                	push   $0x0
  80280a:	6a 00                	push   $0x0
  80280c:	6a 00                	push   $0x0
  80280e:	6a 00                	push   $0x0
  802810:	6a 00                	push   $0x0
  802812:	6a 15                	push   $0x15
  802814:	e8 96 fd ff ff       	call   8025af <syscall>
  802819:	83 c4 18             	add    $0x18,%esp
}
  80281c:	90                   	nop
  80281d:	c9                   	leave  
  80281e:	c3                   	ret    

0080281f <sys_cputc>:


void
sys_cputc(const char c)
{
  80281f:	55                   	push   %ebp
  802820:	89 e5                	mov    %esp,%ebp
  802822:	83 ec 04             	sub    $0x4,%esp
  802825:	8b 45 08             	mov    0x8(%ebp),%eax
  802828:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80282b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80282f:	6a 00                	push   $0x0
  802831:	6a 00                	push   $0x0
  802833:	6a 00                	push   $0x0
  802835:	6a 00                	push   $0x0
  802837:	50                   	push   %eax
  802838:	6a 16                	push   $0x16
  80283a:	e8 70 fd ff ff       	call   8025af <syscall>
  80283f:	83 c4 18             	add    $0x18,%esp
}
  802842:	90                   	nop
  802843:	c9                   	leave  
  802844:	c3                   	ret    

00802845 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802845:	55                   	push   %ebp
  802846:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802848:	6a 00                	push   $0x0
  80284a:	6a 00                	push   $0x0
  80284c:	6a 00                	push   $0x0
  80284e:	6a 00                	push   $0x0
  802850:	6a 00                	push   $0x0
  802852:	6a 17                	push   $0x17
  802854:	e8 56 fd ff ff       	call   8025af <syscall>
  802859:	83 c4 18             	add    $0x18,%esp
}
  80285c:	90                   	nop
  80285d:	c9                   	leave  
  80285e:	c3                   	ret    

0080285f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80285f:	55                   	push   %ebp
  802860:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802862:	8b 45 08             	mov    0x8(%ebp),%eax
  802865:	6a 00                	push   $0x0
  802867:	6a 00                	push   $0x0
  802869:	6a 00                	push   $0x0
  80286b:	ff 75 0c             	pushl  0xc(%ebp)
  80286e:	50                   	push   %eax
  80286f:	6a 18                	push   $0x18
  802871:	e8 39 fd ff ff       	call   8025af <syscall>
  802876:	83 c4 18             	add    $0x18,%esp
}
  802879:	c9                   	leave  
  80287a:	c3                   	ret    

0080287b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80287b:	55                   	push   %ebp
  80287c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80287e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802881:	8b 45 08             	mov    0x8(%ebp),%eax
  802884:	6a 00                	push   $0x0
  802886:	6a 00                	push   $0x0
  802888:	6a 00                	push   $0x0
  80288a:	52                   	push   %edx
  80288b:	50                   	push   %eax
  80288c:	6a 1b                	push   $0x1b
  80288e:	e8 1c fd ff ff       	call   8025af <syscall>
  802893:	83 c4 18             	add    $0x18,%esp
}
  802896:	c9                   	leave  
  802897:	c3                   	ret    

00802898 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802898:	55                   	push   %ebp
  802899:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80289b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80289e:	8b 45 08             	mov    0x8(%ebp),%eax
  8028a1:	6a 00                	push   $0x0
  8028a3:	6a 00                	push   $0x0
  8028a5:	6a 00                	push   $0x0
  8028a7:	52                   	push   %edx
  8028a8:	50                   	push   %eax
  8028a9:	6a 19                	push   $0x19
  8028ab:	e8 ff fc ff ff       	call   8025af <syscall>
  8028b0:	83 c4 18             	add    $0x18,%esp
}
  8028b3:	90                   	nop
  8028b4:	c9                   	leave  
  8028b5:	c3                   	ret    

008028b6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8028b6:	55                   	push   %ebp
  8028b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8028b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8028bf:	6a 00                	push   $0x0
  8028c1:	6a 00                	push   $0x0
  8028c3:	6a 00                	push   $0x0
  8028c5:	52                   	push   %edx
  8028c6:	50                   	push   %eax
  8028c7:	6a 1a                	push   $0x1a
  8028c9:	e8 e1 fc ff ff       	call   8025af <syscall>
  8028ce:	83 c4 18             	add    $0x18,%esp
}
  8028d1:	90                   	nop
  8028d2:	c9                   	leave  
  8028d3:	c3                   	ret    

008028d4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8028d4:	55                   	push   %ebp
  8028d5:	89 e5                	mov    %esp,%ebp
  8028d7:	83 ec 04             	sub    $0x4,%esp
  8028da:	8b 45 10             	mov    0x10(%ebp),%eax
  8028dd:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8028e0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8028e3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8028e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8028ea:	6a 00                	push   $0x0
  8028ec:	51                   	push   %ecx
  8028ed:	52                   	push   %edx
  8028ee:	ff 75 0c             	pushl  0xc(%ebp)
  8028f1:	50                   	push   %eax
  8028f2:	6a 1c                	push   $0x1c
  8028f4:	e8 b6 fc ff ff       	call   8025af <syscall>
  8028f9:	83 c4 18             	add    $0x18,%esp
}
  8028fc:	c9                   	leave  
  8028fd:	c3                   	ret    

008028fe <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8028fe:	55                   	push   %ebp
  8028ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802901:	8b 55 0c             	mov    0xc(%ebp),%edx
  802904:	8b 45 08             	mov    0x8(%ebp),%eax
  802907:	6a 00                	push   $0x0
  802909:	6a 00                	push   $0x0
  80290b:	6a 00                	push   $0x0
  80290d:	52                   	push   %edx
  80290e:	50                   	push   %eax
  80290f:	6a 1d                	push   $0x1d
  802911:	e8 99 fc ff ff       	call   8025af <syscall>
  802916:	83 c4 18             	add    $0x18,%esp
}
  802919:	c9                   	leave  
  80291a:	c3                   	ret    

0080291b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80291b:	55                   	push   %ebp
  80291c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80291e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802921:	8b 55 0c             	mov    0xc(%ebp),%edx
  802924:	8b 45 08             	mov    0x8(%ebp),%eax
  802927:	6a 00                	push   $0x0
  802929:	6a 00                	push   $0x0
  80292b:	51                   	push   %ecx
  80292c:	52                   	push   %edx
  80292d:	50                   	push   %eax
  80292e:	6a 1e                	push   $0x1e
  802930:	e8 7a fc ff ff       	call   8025af <syscall>
  802935:	83 c4 18             	add    $0x18,%esp
}
  802938:	c9                   	leave  
  802939:	c3                   	ret    

0080293a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80293a:	55                   	push   %ebp
  80293b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80293d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802940:	8b 45 08             	mov    0x8(%ebp),%eax
  802943:	6a 00                	push   $0x0
  802945:	6a 00                	push   $0x0
  802947:	6a 00                	push   $0x0
  802949:	52                   	push   %edx
  80294a:	50                   	push   %eax
  80294b:	6a 1f                	push   $0x1f
  80294d:	e8 5d fc ff ff       	call   8025af <syscall>
  802952:	83 c4 18             	add    $0x18,%esp
}
  802955:	c9                   	leave  
  802956:	c3                   	ret    

00802957 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802957:	55                   	push   %ebp
  802958:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80295a:	6a 00                	push   $0x0
  80295c:	6a 00                	push   $0x0
  80295e:	6a 00                	push   $0x0
  802960:	6a 00                	push   $0x0
  802962:	6a 00                	push   $0x0
  802964:	6a 20                	push   $0x20
  802966:	e8 44 fc ff ff       	call   8025af <syscall>
  80296b:	83 c4 18             	add    $0x18,%esp
}
  80296e:	c9                   	leave  
  80296f:	c3                   	ret    

00802970 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802970:	55                   	push   %ebp
  802971:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802973:	8b 45 08             	mov    0x8(%ebp),%eax
  802976:	6a 00                	push   $0x0
  802978:	6a 00                	push   $0x0
  80297a:	ff 75 10             	pushl  0x10(%ebp)
  80297d:	ff 75 0c             	pushl  0xc(%ebp)
  802980:	50                   	push   %eax
  802981:	6a 21                	push   $0x21
  802983:	e8 27 fc ff ff       	call   8025af <syscall>
  802988:	83 c4 18             	add    $0x18,%esp
}
  80298b:	c9                   	leave  
  80298c:	c3                   	ret    

0080298d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80298d:	55                   	push   %ebp
  80298e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802990:	8b 45 08             	mov    0x8(%ebp),%eax
  802993:	6a 00                	push   $0x0
  802995:	6a 00                	push   $0x0
  802997:	6a 00                	push   $0x0
  802999:	6a 00                	push   $0x0
  80299b:	50                   	push   %eax
  80299c:	6a 22                	push   $0x22
  80299e:	e8 0c fc ff ff       	call   8025af <syscall>
  8029a3:	83 c4 18             	add    $0x18,%esp
}
  8029a6:	90                   	nop
  8029a7:	c9                   	leave  
  8029a8:	c3                   	ret    

008029a9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8029a9:	55                   	push   %ebp
  8029aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8029ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8029af:	6a 00                	push   $0x0
  8029b1:	6a 00                	push   $0x0
  8029b3:	6a 00                	push   $0x0
  8029b5:	6a 00                	push   $0x0
  8029b7:	50                   	push   %eax
  8029b8:	6a 23                	push   $0x23
  8029ba:	e8 f0 fb ff ff       	call   8025af <syscall>
  8029bf:	83 c4 18             	add    $0x18,%esp
}
  8029c2:	90                   	nop
  8029c3:	c9                   	leave  
  8029c4:	c3                   	ret    

008029c5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8029c5:	55                   	push   %ebp
  8029c6:	89 e5                	mov    %esp,%ebp
  8029c8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8029cb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8029ce:	8d 50 04             	lea    0x4(%eax),%edx
  8029d1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8029d4:	6a 00                	push   $0x0
  8029d6:	6a 00                	push   $0x0
  8029d8:	6a 00                	push   $0x0
  8029da:	52                   	push   %edx
  8029db:	50                   	push   %eax
  8029dc:	6a 24                	push   $0x24
  8029de:	e8 cc fb ff ff       	call   8025af <syscall>
  8029e3:	83 c4 18             	add    $0x18,%esp
	return result;
  8029e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8029e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8029ec:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8029ef:	89 01                	mov    %eax,(%ecx)
  8029f1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8029f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8029f7:	c9                   	leave  
  8029f8:	c2 04 00             	ret    $0x4

008029fb <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8029fb:	55                   	push   %ebp
  8029fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8029fe:	6a 00                	push   $0x0
  802a00:	6a 00                	push   $0x0
  802a02:	ff 75 10             	pushl  0x10(%ebp)
  802a05:	ff 75 0c             	pushl  0xc(%ebp)
  802a08:	ff 75 08             	pushl  0x8(%ebp)
  802a0b:	6a 13                	push   $0x13
  802a0d:	e8 9d fb ff ff       	call   8025af <syscall>
  802a12:	83 c4 18             	add    $0x18,%esp
	return ;
  802a15:	90                   	nop
}
  802a16:	c9                   	leave  
  802a17:	c3                   	ret    

00802a18 <sys_rcr2>:
uint32 sys_rcr2()
{
  802a18:	55                   	push   %ebp
  802a19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802a1b:	6a 00                	push   $0x0
  802a1d:	6a 00                	push   $0x0
  802a1f:	6a 00                	push   $0x0
  802a21:	6a 00                	push   $0x0
  802a23:	6a 00                	push   $0x0
  802a25:	6a 25                	push   $0x25
  802a27:	e8 83 fb ff ff       	call   8025af <syscall>
  802a2c:	83 c4 18             	add    $0x18,%esp
}
  802a2f:	c9                   	leave  
  802a30:	c3                   	ret    

00802a31 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802a31:	55                   	push   %ebp
  802a32:	89 e5                	mov    %esp,%ebp
  802a34:	83 ec 04             	sub    $0x4,%esp
  802a37:	8b 45 08             	mov    0x8(%ebp),%eax
  802a3a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802a3d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802a41:	6a 00                	push   $0x0
  802a43:	6a 00                	push   $0x0
  802a45:	6a 00                	push   $0x0
  802a47:	6a 00                	push   $0x0
  802a49:	50                   	push   %eax
  802a4a:	6a 26                	push   $0x26
  802a4c:	e8 5e fb ff ff       	call   8025af <syscall>
  802a51:	83 c4 18             	add    $0x18,%esp
	return ;
  802a54:	90                   	nop
}
  802a55:	c9                   	leave  
  802a56:	c3                   	ret    

00802a57 <rsttst>:
void rsttst()
{
  802a57:	55                   	push   %ebp
  802a58:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802a5a:	6a 00                	push   $0x0
  802a5c:	6a 00                	push   $0x0
  802a5e:	6a 00                	push   $0x0
  802a60:	6a 00                	push   $0x0
  802a62:	6a 00                	push   $0x0
  802a64:	6a 28                	push   $0x28
  802a66:	e8 44 fb ff ff       	call   8025af <syscall>
  802a6b:	83 c4 18             	add    $0x18,%esp
	return ;
  802a6e:	90                   	nop
}
  802a6f:	c9                   	leave  
  802a70:	c3                   	ret    

00802a71 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802a71:	55                   	push   %ebp
  802a72:	89 e5                	mov    %esp,%ebp
  802a74:	83 ec 04             	sub    $0x4,%esp
  802a77:	8b 45 14             	mov    0x14(%ebp),%eax
  802a7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802a7d:	8b 55 18             	mov    0x18(%ebp),%edx
  802a80:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802a84:	52                   	push   %edx
  802a85:	50                   	push   %eax
  802a86:	ff 75 10             	pushl  0x10(%ebp)
  802a89:	ff 75 0c             	pushl  0xc(%ebp)
  802a8c:	ff 75 08             	pushl  0x8(%ebp)
  802a8f:	6a 27                	push   $0x27
  802a91:	e8 19 fb ff ff       	call   8025af <syscall>
  802a96:	83 c4 18             	add    $0x18,%esp
	return ;
  802a99:	90                   	nop
}
  802a9a:	c9                   	leave  
  802a9b:	c3                   	ret    

00802a9c <chktst>:
void chktst(uint32 n)
{
  802a9c:	55                   	push   %ebp
  802a9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802a9f:	6a 00                	push   $0x0
  802aa1:	6a 00                	push   $0x0
  802aa3:	6a 00                	push   $0x0
  802aa5:	6a 00                	push   $0x0
  802aa7:	ff 75 08             	pushl  0x8(%ebp)
  802aaa:	6a 29                	push   $0x29
  802aac:	e8 fe fa ff ff       	call   8025af <syscall>
  802ab1:	83 c4 18             	add    $0x18,%esp
	return ;
  802ab4:	90                   	nop
}
  802ab5:	c9                   	leave  
  802ab6:	c3                   	ret    

00802ab7 <inctst>:

void inctst()
{
  802ab7:	55                   	push   %ebp
  802ab8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802aba:	6a 00                	push   $0x0
  802abc:	6a 00                	push   $0x0
  802abe:	6a 00                	push   $0x0
  802ac0:	6a 00                	push   $0x0
  802ac2:	6a 00                	push   $0x0
  802ac4:	6a 2a                	push   $0x2a
  802ac6:	e8 e4 fa ff ff       	call   8025af <syscall>
  802acb:	83 c4 18             	add    $0x18,%esp
	return ;
  802ace:	90                   	nop
}
  802acf:	c9                   	leave  
  802ad0:	c3                   	ret    

00802ad1 <gettst>:
uint32 gettst()
{
  802ad1:	55                   	push   %ebp
  802ad2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802ad4:	6a 00                	push   $0x0
  802ad6:	6a 00                	push   $0x0
  802ad8:	6a 00                	push   $0x0
  802ada:	6a 00                	push   $0x0
  802adc:	6a 00                	push   $0x0
  802ade:	6a 2b                	push   $0x2b
  802ae0:	e8 ca fa ff ff       	call   8025af <syscall>
  802ae5:	83 c4 18             	add    $0x18,%esp
}
  802ae8:	c9                   	leave  
  802ae9:	c3                   	ret    

00802aea <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802aea:	55                   	push   %ebp
  802aeb:	89 e5                	mov    %esp,%ebp
  802aed:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802af0:	6a 00                	push   $0x0
  802af2:	6a 00                	push   $0x0
  802af4:	6a 00                	push   $0x0
  802af6:	6a 00                	push   $0x0
  802af8:	6a 00                	push   $0x0
  802afa:	6a 2c                	push   $0x2c
  802afc:	e8 ae fa ff ff       	call   8025af <syscall>
  802b01:	83 c4 18             	add    $0x18,%esp
  802b04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802b07:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802b0b:	75 07                	jne    802b14 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802b0d:	b8 01 00 00 00       	mov    $0x1,%eax
  802b12:	eb 05                	jmp    802b19 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802b14:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b19:	c9                   	leave  
  802b1a:	c3                   	ret    

00802b1b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802b1b:	55                   	push   %ebp
  802b1c:	89 e5                	mov    %esp,%ebp
  802b1e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b21:	6a 00                	push   $0x0
  802b23:	6a 00                	push   $0x0
  802b25:	6a 00                	push   $0x0
  802b27:	6a 00                	push   $0x0
  802b29:	6a 00                	push   $0x0
  802b2b:	6a 2c                	push   $0x2c
  802b2d:	e8 7d fa ff ff       	call   8025af <syscall>
  802b32:	83 c4 18             	add    $0x18,%esp
  802b35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802b38:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802b3c:	75 07                	jne    802b45 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802b3e:	b8 01 00 00 00       	mov    $0x1,%eax
  802b43:	eb 05                	jmp    802b4a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802b45:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b4a:	c9                   	leave  
  802b4b:	c3                   	ret    

00802b4c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802b4c:	55                   	push   %ebp
  802b4d:	89 e5                	mov    %esp,%ebp
  802b4f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b52:	6a 00                	push   $0x0
  802b54:	6a 00                	push   $0x0
  802b56:	6a 00                	push   $0x0
  802b58:	6a 00                	push   $0x0
  802b5a:	6a 00                	push   $0x0
  802b5c:	6a 2c                	push   $0x2c
  802b5e:	e8 4c fa ff ff       	call   8025af <syscall>
  802b63:	83 c4 18             	add    $0x18,%esp
  802b66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802b69:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802b6d:	75 07                	jne    802b76 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802b6f:	b8 01 00 00 00       	mov    $0x1,%eax
  802b74:	eb 05                	jmp    802b7b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802b76:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b7b:	c9                   	leave  
  802b7c:	c3                   	ret    

00802b7d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802b7d:	55                   	push   %ebp
  802b7e:	89 e5                	mov    %esp,%ebp
  802b80:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b83:	6a 00                	push   $0x0
  802b85:	6a 00                	push   $0x0
  802b87:	6a 00                	push   $0x0
  802b89:	6a 00                	push   $0x0
  802b8b:	6a 00                	push   $0x0
  802b8d:	6a 2c                	push   $0x2c
  802b8f:	e8 1b fa ff ff       	call   8025af <syscall>
  802b94:	83 c4 18             	add    $0x18,%esp
  802b97:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802b9a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802b9e:	75 07                	jne    802ba7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802ba0:	b8 01 00 00 00       	mov    $0x1,%eax
  802ba5:	eb 05                	jmp    802bac <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802ba7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bac:	c9                   	leave  
  802bad:	c3                   	ret    

00802bae <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802bae:	55                   	push   %ebp
  802baf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802bb1:	6a 00                	push   $0x0
  802bb3:	6a 00                	push   $0x0
  802bb5:	6a 00                	push   $0x0
  802bb7:	6a 00                	push   $0x0
  802bb9:	ff 75 08             	pushl  0x8(%ebp)
  802bbc:	6a 2d                	push   $0x2d
  802bbe:	e8 ec f9 ff ff       	call   8025af <syscall>
  802bc3:	83 c4 18             	add    $0x18,%esp
	return ;
  802bc6:	90                   	nop
}
  802bc7:	c9                   	leave  
  802bc8:	c3                   	ret    

00802bc9 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  802bc9:	55                   	push   %ebp
  802bca:	89 e5                	mov    %esp,%ebp
  802bcc:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  802bcf:	8b 55 08             	mov    0x8(%ebp),%edx
  802bd2:	89 d0                	mov    %edx,%eax
  802bd4:	c1 e0 02             	shl    $0x2,%eax
  802bd7:	01 d0                	add    %edx,%eax
  802bd9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802be0:	01 d0                	add    %edx,%eax
  802be2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802be9:	01 d0                	add    %edx,%eax
  802beb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802bf2:	01 d0                	add    %edx,%eax
  802bf4:	c1 e0 04             	shl    $0x4,%eax
  802bf7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  802bfa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  802c01:	8d 45 e8             	lea    -0x18(%ebp),%eax
  802c04:	83 ec 0c             	sub    $0xc,%esp
  802c07:	50                   	push   %eax
  802c08:	e8 b8 fd ff ff       	call   8029c5 <sys_get_virtual_time>
  802c0d:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  802c10:	eb 41                	jmp    802c53 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  802c12:	8d 45 e0             	lea    -0x20(%ebp),%eax
  802c15:	83 ec 0c             	sub    $0xc,%esp
  802c18:	50                   	push   %eax
  802c19:	e8 a7 fd ff ff       	call   8029c5 <sys_get_virtual_time>
  802c1e:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  802c21:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802c24:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802c27:	29 c2                	sub    %eax,%edx
  802c29:	89 d0                	mov    %edx,%eax
  802c2b:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  802c2e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802c31:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802c34:	89 d1                	mov    %edx,%ecx
  802c36:	29 c1                	sub    %eax,%ecx
  802c38:	8b 55 d8             	mov    -0x28(%ebp),%edx
  802c3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802c3e:	39 c2                	cmp    %eax,%edx
  802c40:	0f 97 c0             	seta   %al
  802c43:	0f b6 c0             	movzbl %al,%eax
  802c46:	29 c1                	sub    %eax,%ecx
  802c48:	89 c8                	mov    %ecx,%eax
  802c4a:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  802c4d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802c50:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  802c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802c56:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802c59:	72 b7                	jb     802c12 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
//	cprintf("%s wake up now!\n", myEnv->prog_name);

}
  802c5b:	90                   	nop
  802c5c:	c9                   	leave  
  802c5d:	c3                   	ret    

00802c5e <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  802c5e:	55                   	push   %ebp
  802c5f:	89 e5                	mov    %esp,%ebp
  802c61:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  802c64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  802c6b:	eb 03                	jmp    802c70 <busy_wait+0x12>
  802c6d:	ff 45 fc             	incl   -0x4(%ebp)
  802c70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802c73:	3b 45 08             	cmp    0x8(%ebp),%eax
  802c76:	72 f5                	jb     802c6d <busy_wait+0xf>
	return i;
  802c78:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802c7b:	c9                   	leave  
  802c7c:	c3                   	ret    
  802c7d:	66 90                	xchg   %ax,%ax
  802c7f:	90                   	nop

00802c80 <__udivdi3>:
  802c80:	55                   	push   %ebp
  802c81:	57                   	push   %edi
  802c82:	56                   	push   %esi
  802c83:	53                   	push   %ebx
  802c84:	83 ec 1c             	sub    $0x1c,%esp
  802c87:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802c8b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802c8f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802c93:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802c97:	89 ca                	mov    %ecx,%edx
  802c99:	89 f8                	mov    %edi,%eax
  802c9b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802c9f:	85 f6                	test   %esi,%esi
  802ca1:	75 2d                	jne    802cd0 <__udivdi3+0x50>
  802ca3:	39 cf                	cmp    %ecx,%edi
  802ca5:	77 65                	ja     802d0c <__udivdi3+0x8c>
  802ca7:	89 fd                	mov    %edi,%ebp
  802ca9:	85 ff                	test   %edi,%edi
  802cab:	75 0b                	jne    802cb8 <__udivdi3+0x38>
  802cad:	b8 01 00 00 00       	mov    $0x1,%eax
  802cb2:	31 d2                	xor    %edx,%edx
  802cb4:	f7 f7                	div    %edi
  802cb6:	89 c5                	mov    %eax,%ebp
  802cb8:	31 d2                	xor    %edx,%edx
  802cba:	89 c8                	mov    %ecx,%eax
  802cbc:	f7 f5                	div    %ebp
  802cbe:	89 c1                	mov    %eax,%ecx
  802cc0:	89 d8                	mov    %ebx,%eax
  802cc2:	f7 f5                	div    %ebp
  802cc4:	89 cf                	mov    %ecx,%edi
  802cc6:	89 fa                	mov    %edi,%edx
  802cc8:	83 c4 1c             	add    $0x1c,%esp
  802ccb:	5b                   	pop    %ebx
  802ccc:	5e                   	pop    %esi
  802ccd:	5f                   	pop    %edi
  802cce:	5d                   	pop    %ebp
  802ccf:	c3                   	ret    
  802cd0:	39 ce                	cmp    %ecx,%esi
  802cd2:	77 28                	ja     802cfc <__udivdi3+0x7c>
  802cd4:	0f bd fe             	bsr    %esi,%edi
  802cd7:	83 f7 1f             	xor    $0x1f,%edi
  802cda:	75 40                	jne    802d1c <__udivdi3+0x9c>
  802cdc:	39 ce                	cmp    %ecx,%esi
  802cde:	72 0a                	jb     802cea <__udivdi3+0x6a>
  802ce0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802ce4:	0f 87 9e 00 00 00    	ja     802d88 <__udivdi3+0x108>
  802cea:	b8 01 00 00 00       	mov    $0x1,%eax
  802cef:	89 fa                	mov    %edi,%edx
  802cf1:	83 c4 1c             	add    $0x1c,%esp
  802cf4:	5b                   	pop    %ebx
  802cf5:	5e                   	pop    %esi
  802cf6:	5f                   	pop    %edi
  802cf7:	5d                   	pop    %ebp
  802cf8:	c3                   	ret    
  802cf9:	8d 76 00             	lea    0x0(%esi),%esi
  802cfc:	31 ff                	xor    %edi,%edi
  802cfe:	31 c0                	xor    %eax,%eax
  802d00:	89 fa                	mov    %edi,%edx
  802d02:	83 c4 1c             	add    $0x1c,%esp
  802d05:	5b                   	pop    %ebx
  802d06:	5e                   	pop    %esi
  802d07:	5f                   	pop    %edi
  802d08:	5d                   	pop    %ebp
  802d09:	c3                   	ret    
  802d0a:	66 90                	xchg   %ax,%ax
  802d0c:	89 d8                	mov    %ebx,%eax
  802d0e:	f7 f7                	div    %edi
  802d10:	31 ff                	xor    %edi,%edi
  802d12:	89 fa                	mov    %edi,%edx
  802d14:	83 c4 1c             	add    $0x1c,%esp
  802d17:	5b                   	pop    %ebx
  802d18:	5e                   	pop    %esi
  802d19:	5f                   	pop    %edi
  802d1a:	5d                   	pop    %ebp
  802d1b:	c3                   	ret    
  802d1c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802d21:	89 eb                	mov    %ebp,%ebx
  802d23:	29 fb                	sub    %edi,%ebx
  802d25:	89 f9                	mov    %edi,%ecx
  802d27:	d3 e6                	shl    %cl,%esi
  802d29:	89 c5                	mov    %eax,%ebp
  802d2b:	88 d9                	mov    %bl,%cl
  802d2d:	d3 ed                	shr    %cl,%ebp
  802d2f:	89 e9                	mov    %ebp,%ecx
  802d31:	09 f1                	or     %esi,%ecx
  802d33:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802d37:	89 f9                	mov    %edi,%ecx
  802d39:	d3 e0                	shl    %cl,%eax
  802d3b:	89 c5                	mov    %eax,%ebp
  802d3d:	89 d6                	mov    %edx,%esi
  802d3f:	88 d9                	mov    %bl,%cl
  802d41:	d3 ee                	shr    %cl,%esi
  802d43:	89 f9                	mov    %edi,%ecx
  802d45:	d3 e2                	shl    %cl,%edx
  802d47:	8b 44 24 08          	mov    0x8(%esp),%eax
  802d4b:	88 d9                	mov    %bl,%cl
  802d4d:	d3 e8                	shr    %cl,%eax
  802d4f:	09 c2                	or     %eax,%edx
  802d51:	89 d0                	mov    %edx,%eax
  802d53:	89 f2                	mov    %esi,%edx
  802d55:	f7 74 24 0c          	divl   0xc(%esp)
  802d59:	89 d6                	mov    %edx,%esi
  802d5b:	89 c3                	mov    %eax,%ebx
  802d5d:	f7 e5                	mul    %ebp
  802d5f:	39 d6                	cmp    %edx,%esi
  802d61:	72 19                	jb     802d7c <__udivdi3+0xfc>
  802d63:	74 0b                	je     802d70 <__udivdi3+0xf0>
  802d65:	89 d8                	mov    %ebx,%eax
  802d67:	31 ff                	xor    %edi,%edi
  802d69:	e9 58 ff ff ff       	jmp    802cc6 <__udivdi3+0x46>
  802d6e:	66 90                	xchg   %ax,%ax
  802d70:	8b 54 24 08          	mov    0x8(%esp),%edx
  802d74:	89 f9                	mov    %edi,%ecx
  802d76:	d3 e2                	shl    %cl,%edx
  802d78:	39 c2                	cmp    %eax,%edx
  802d7a:	73 e9                	jae    802d65 <__udivdi3+0xe5>
  802d7c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802d7f:	31 ff                	xor    %edi,%edi
  802d81:	e9 40 ff ff ff       	jmp    802cc6 <__udivdi3+0x46>
  802d86:	66 90                	xchg   %ax,%ax
  802d88:	31 c0                	xor    %eax,%eax
  802d8a:	e9 37 ff ff ff       	jmp    802cc6 <__udivdi3+0x46>
  802d8f:	90                   	nop

00802d90 <__umoddi3>:
  802d90:	55                   	push   %ebp
  802d91:	57                   	push   %edi
  802d92:	56                   	push   %esi
  802d93:	53                   	push   %ebx
  802d94:	83 ec 1c             	sub    $0x1c,%esp
  802d97:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802d9b:	8b 74 24 34          	mov    0x34(%esp),%esi
  802d9f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802da3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802da7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802dab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802daf:	89 f3                	mov    %esi,%ebx
  802db1:	89 fa                	mov    %edi,%edx
  802db3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802db7:	89 34 24             	mov    %esi,(%esp)
  802dba:	85 c0                	test   %eax,%eax
  802dbc:	75 1a                	jne    802dd8 <__umoddi3+0x48>
  802dbe:	39 f7                	cmp    %esi,%edi
  802dc0:	0f 86 a2 00 00 00    	jbe    802e68 <__umoddi3+0xd8>
  802dc6:	89 c8                	mov    %ecx,%eax
  802dc8:	89 f2                	mov    %esi,%edx
  802dca:	f7 f7                	div    %edi
  802dcc:	89 d0                	mov    %edx,%eax
  802dce:	31 d2                	xor    %edx,%edx
  802dd0:	83 c4 1c             	add    $0x1c,%esp
  802dd3:	5b                   	pop    %ebx
  802dd4:	5e                   	pop    %esi
  802dd5:	5f                   	pop    %edi
  802dd6:	5d                   	pop    %ebp
  802dd7:	c3                   	ret    
  802dd8:	39 f0                	cmp    %esi,%eax
  802dda:	0f 87 ac 00 00 00    	ja     802e8c <__umoddi3+0xfc>
  802de0:	0f bd e8             	bsr    %eax,%ebp
  802de3:	83 f5 1f             	xor    $0x1f,%ebp
  802de6:	0f 84 ac 00 00 00    	je     802e98 <__umoddi3+0x108>
  802dec:	bf 20 00 00 00       	mov    $0x20,%edi
  802df1:	29 ef                	sub    %ebp,%edi
  802df3:	89 fe                	mov    %edi,%esi
  802df5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802df9:	89 e9                	mov    %ebp,%ecx
  802dfb:	d3 e0                	shl    %cl,%eax
  802dfd:	89 d7                	mov    %edx,%edi
  802dff:	89 f1                	mov    %esi,%ecx
  802e01:	d3 ef                	shr    %cl,%edi
  802e03:	09 c7                	or     %eax,%edi
  802e05:	89 e9                	mov    %ebp,%ecx
  802e07:	d3 e2                	shl    %cl,%edx
  802e09:	89 14 24             	mov    %edx,(%esp)
  802e0c:	89 d8                	mov    %ebx,%eax
  802e0e:	d3 e0                	shl    %cl,%eax
  802e10:	89 c2                	mov    %eax,%edx
  802e12:	8b 44 24 08          	mov    0x8(%esp),%eax
  802e16:	d3 e0                	shl    %cl,%eax
  802e18:	89 44 24 04          	mov    %eax,0x4(%esp)
  802e1c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802e20:	89 f1                	mov    %esi,%ecx
  802e22:	d3 e8                	shr    %cl,%eax
  802e24:	09 d0                	or     %edx,%eax
  802e26:	d3 eb                	shr    %cl,%ebx
  802e28:	89 da                	mov    %ebx,%edx
  802e2a:	f7 f7                	div    %edi
  802e2c:	89 d3                	mov    %edx,%ebx
  802e2e:	f7 24 24             	mull   (%esp)
  802e31:	89 c6                	mov    %eax,%esi
  802e33:	89 d1                	mov    %edx,%ecx
  802e35:	39 d3                	cmp    %edx,%ebx
  802e37:	0f 82 87 00 00 00    	jb     802ec4 <__umoddi3+0x134>
  802e3d:	0f 84 91 00 00 00    	je     802ed4 <__umoddi3+0x144>
  802e43:	8b 54 24 04          	mov    0x4(%esp),%edx
  802e47:	29 f2                	sub    %esi,%edx
  802e49:	19 cb                	sbb    %ecx,%ebx
  802e4b:	89 d8                	mov    %ebx,%eax
  802e4d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802e51:	d3 e0                	shl    %cl,%eax
  802e53:	89 e9                	mov    %ebp,%ecx
  802e55:	d3 ea                	shr    %cl,%edx
  802e57:	09 d0                	or     %edx,%eax
  802e59:	89 e9                	mov    %ebp,%ecx
  802e5b:	d3 eb                	shr    %cl,%ebx
  802e5d:	89 da                	mov    %ebx,%edx
  802e5f:	83 c4 1c             	add    $0x1c,%esp
  802e62:	5b                   	pop    %ebx
  802e63:	5e                   	pop    %esi
  802e64:	5f                   	pop    %edi
  802e65:	5d                   	pop    %ebp
  802e66:	c3                   	ret    
  802e67:	90                   	nop
  802e68:	89 fd                	mov    %edi,%ebp
  802e6a:	85 ff                	test   %edi,%edi
  802e6c:	75 0b                	jne    802e79 <__umoddi3+0xe9>
  802e6e:	b8 01 00 00 00       	mov    $0x1,%eax
  802e73:	31 d2                	xor    %edx,%edx
  802e75:	f7 f7                	div    %edi
  802e77:	89 c5                	mov    %eax,%ebp
  802e79:	89 f0                	mov    %esi,%eax
  802e7b:	31 d2                	xor    %edx,%edx
  802e7d:	f7 f5                	div    %ebp
  802e7f:	89 c8                	mov    %ecx,%eax
  802e81:	f7 f5                	div    %ebp
  802e83:	89 d0                	mov    %edx,%eax
  802e85:	e9 44 ff ff ff       	jmp    802dce <__umoddi3+0x3e>
  802e8a:	66 90                	xchg   %ax,%ax
  802e8c:	89 c8                	mov    %ecx,%eax
  802e8e:	89 f2                	mov    %esi,%edx
  802e90:	83 c4 1c             	add    $0x1c,%esp
  802e93:	5b                   	pop    %ebx
  802e94:	5e                   	pop    %esi
  802e95:	5f                   	pop    %edi
  802e96:	5d                   	pop    %ebp
  802e97:	c3                   	ret    
  802e98:	3b 04 24             	cmp    (%esp),%eax
  802e9b:	72 06                	jb     802ea3 <__umoddi3+0x113>
  802e9d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802ea1:	77 0f                	ja     802eb2 <__umoddi3+0x122>
  802ea3:	89 f2                	mov    %esi,%edx
  802ea5:	29 f9                	sub    %edi,%ecx
  802ea7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802eab:	89 14 24             	mov    %edx,(%esp)
  802eae:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802eb2:	8b 44 24 04          	mov    0x4(%esp),%eax
  802eb6:	8b 14 24             	mov    (%esp),%edx
  802eb9:	83 c4 1c             	add    $0x1c,%esp
  802ebc:	5b                   	pop    %ebx
  802ebd:	5e                   	pop    %esi
  802ebe:	5f                   	pop    %edi
  802ebf:	5d                   	pop    %ebp
  802ec0:	c3                   	ret    
  802ec1:	8d 76 00             	lea    0x0(%esi),%esi
  802ec4:	2b 04 24             	sub    (%esp),%eax
  802ec7:	19 fa                	sbb    %edi,%edx
  802ec9:	89 d1                	mov    %edx,%ecx
  802ecb:	89 c6                	mov    %eax,%esi
  802ecd:	e9 71 ff ff ff       	jmp    802e43 <__umoddi3+0xb3>
  802ed2:	66 90                	xchg   %ax,%ax
  802ed4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802ed8:	72 ea                	jb     802ec4 <__umoddi3+0x134>
  802eda:	89 d9                	mov    %ebx,%ecx
  802edc:	e9 62 ff ff ff       	jmp    802e43 <__umoddi3+0xb3>
