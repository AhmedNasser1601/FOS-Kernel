
obj/user/tst_freeing_stack:     file format elf32-i386


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
  800031:	e8 77 02 00 00       	call   8002ad <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

#include <inc/lib.h>

int RecursiveFn(int numOfRec);
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 38             	sub    $0x38,%esp
	int res, numOfRec, expectedResult, r, i, j, freeFrames, usedDiskPages ;
	uint32 vaOf1stStackPage = USTACKTOP - PAGE_SIZE;
  80003e:	c7 45 dc 00 d0 bf ee 	movl   $0xeebfd000,-0x24(%ebp)

	int initNumOfEmptyWSEntries, curNumOfEmptyWSEntries ;

	/*Different number of recursive calls (each call takes 1 PAGE)*/
	for (r = 1; r <= 10; ++r)
  800045:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  80004c:	e9 c5 01 00 00       	jmp    800216 <_main+0x1de>
	{
		numOfRec = r;
  800051:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800054:	89 45 d8             	mov    %eax,-0x28(%ebp)

		initNumOfEmptyWSEntries = 0;
  800057:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  80005e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800065:	eb 26                	jmp    80008d <_main+0x55>
		{
			if (myEnv->__uptr_pws[j].empty==1)
  800067:	a1 04 30 80 00       	mov    0x803004,%eax
  80006c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800072:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800075:	89 d0                	mov    %edx,%eax
  800077:	01 c0                	add    %eax,%eax
  800079:	01 d0                	add    %edx,%eax
  80007b:	c1 e0 02             	shl    $0x2,%eax
  80007e:	01 c8                	add    %ecx,%eax
  800080:	8a 40 04             	mov    0x4(%eax),%al
  800083:	3c 01                	cmp    $0x1,%al
  800085:	75 03                	jne    80008a <_main+0x52>
				initNumOfEmptyWSEntries++;
  800087:	ff 45 e4             	incl   -0x1c(%ebp)
	for (r = 1; r <= 10; ++r)
	{
		numOfRec = r;

		initNumOfEmptyWSEntries = 0;
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  80008a:	ff 45 e8             	incl   -0x18(%ebp)
  80008d:	a1 04 30 80 00       	mov    0x803004,%eax
  800092:	8b 50 74             	mov    0x74(%eax),%edx
  800095:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800098:	39 c2                	cmp    %eax,%edx
  80009a:	77 cb                	ja     800067 <_main+0x2f>
		{
			if (myEnv->__uptr_pws[j].empty==1)
				initNumOfEmptyWSEntries++;
		}

		freeFrames = sys_calculate_free_frames() ;
  80009c:	e8 c5 14 00 00       	call   801566 <sys_calculate_free_frames>
  8000a1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000a4:	e8 40 15 00 00       	call   8015e9 <sys_pf_calculate_allocated_pages>
  8000a9:	89 45 d0             	mov    %eax,-0x30(%ebp)

		res = RecursiveFn(numOfRec);
  8000ac:	83 ec 0c             	sub    $0xc,%esp
  8000af:	ff 75 d8             	pushl  -0x28(%ebp)
  8000b2:	e8 7c 01 00 00       	call   800233 <RecursiveFn>
  8000b7:	83 c4 10             	add    $0x10,%esp
  8000ba:	89 45 cc             	mov    %eax,-0x34(%ebp)
		env_sleep(1) ;
  8000bd:	83 ec 0c             	sub    $0xc,%esp
  8000c0:	6a 01                	push   $0x1
  8000c2:	e8 4d 19 00 00       	call   801a14 <env_sleep>
  8000c7:	83 c4 10             	add    $0x10,%esp
		expectedResult = 0;
  8000ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for (i = 1; i <= numOfRec; ++i) {
  8000d1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  8000d8:	eb 0c                	jmp    8000e6 <_main+0xae>
			expectedResult += i * 1024;
  8000da:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000dd:	c1 e0 0a             	shl    $0xa,%eax
  8000e0:	01 45 f4             	add    %eax,-0xc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;

		res = RecursiveFn(numOfRec);
		env_sleep(1) ;
		expectedResult = 0;
		for (i = 1; i <= numOfRec; ++i) {
  8000e3:	ff 45 ec             	incl   -0x14(%ebp)
  8000e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e9:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8000ec:	7e ec                	jle    8000da <_main+0xa2>
			expectedResult += i * 1024;
		}
		//check correct answer & page file
		if (res != expectedResult) panic("Wrong result of the recursive function!\n");
  8000ee:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000f1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f4:	74 14                	je     80010a <_main+0xd2>
  8000f6:	83 ec 04             	sub    $0x4,%esp
  8000f9:	68 40 1d 80 00       	push   $0x801d40
  8000fe:	6a 28                	push   $0x28
  800100:	68 69 1d 80 00       	push   $0x801d69
  800105:	e8 b2 02 00 00       	call   8003bc <_panic>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 0) panic("Wrong freeing the stack pages from the page file!\n");
  80010a:	e8 da 14 00 00       	call   8015e9 <sys_pf_calculate_allocated_pages>
  80010f:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  800112:	74 14                	je     800128 <_main+0xf0>
  800114:	83 ec 04             	sub    $0x4,%esp
  800117:	68 84 1d 80 00       	push   $0x801d84
  80011c:	6a 29                	push   $0x29
  80011e:	68 69 1d 80 00       	push   $0x801d69
  800123:	e8 94 02 00 00       	call   8003bc <_panic>

		//check WS
		for (i = 1; i <= numOfRec; ++i)
  800128:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  80012f:	eb 6b                	jmp    80019c <_main+0x164>
		{
			for (j = 0; j < myEnv->page_WS_max_size; ++j)
  800131:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800138:	eb 50                	jmp    80018a <_main+0x152>
			{
				if (ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address, PAGE_SIZE) == vaOf1stStackPage - i*PAGE_SIZE)
  80013a:	a1 04 30 80 00       	mov    0x803004,%eax
  80013f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800145:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800148:	89 d0                	mov    %edx,%eax
  80014a:	01 c0                	add    %eax,%eax
  80014c:	01 d0                	add    %edx,%eax
  80014e:	c1 e0 02             	shl    $0x2,%eax
  800151:	01 c8                	add    %ecx,%eax
  800153:	8b 00                	mov    (%eax),%eax
  800155:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800158:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80015b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800160:	89 c2                	mov    %eax,%edx
  800162:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800165:	c1 e0 0c             	shl    $0xc,%eax
  800168:	89 c1                	mov    %eax,%ecx
  80016a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80016d:	29 c8                	sub    %ecx,%eax
  80016f:	39 c2                	cmp    %eax,%edx
  800171:	75 14                	jne    800187 <_main+0x14f>
					panic("Wrong freeing the stack pages from the working set!\n");
  800173:	83 ec 04             	sub    $0x4,%esp
  800176:	68 b8 1d 80 00       	push   $0x801db8
  80017b:	6a 31                	push   $0x31
  80017d:	68 69 1d 80 00       	push   $0x801d69
  800182:	e8 35 02 00 00       	call   8003bc <_panic>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 0) panic("Wrong freeing the stack pages from the page file!\n");

		//check WS
		for (i = 1; i <= numOfRec; ++i)
		{
			for (j = 0; j < myEnv->page_WS_max_size; ++j)
  800187:	ff 45 e8             	incl   -0x18(%ebp)
  80018a:	a1 04 30 80 00       	mov    0x803004,%eax
  80018f:	8b 50 74             	mov    0x74(%eax),%edx
  800192:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800195:	39 c2                	cmp    %eax,%edx
  800197:	77 a1                	ja     80013a <_main+0x102>
		//check correct answer & page file
		if (res != expectedResult) panic("Wrong result of the recursive function!\n");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 0) panic("Wrong freeing the stack pages from the page file!\n");

		//check WS
		for (i = 1; i <= numOfRec; ++i)
  800199:	ff 45 ec             	incl   -0x14(%ebp)
  80019c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80019f:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8001a2:	7e 8d                	jle    800131 <_main+0xf9>
					panic("Wrong freeing the stack pages from the working set!\n");
			}
		}

		//check free frames
		curNumOfEmptyWSEntries = 0;
  8001a4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  8001ab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8001b2:	eb 26                	jmp    8001da <_main+0x1a2>
		{
			if (myEnv->__uptr_pws[j].empty==1)
  8001b4:	a1 04 30 80 00       	mov    0x803004,%eax
  8001b9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8001bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8001c2:	89 d0                	mov    %edx,%eax
  8001c4:	01 c0                	add    %eax,%eax
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	c1 e0 02             	shl    $0x2,%eax
  8001cb:	01 c8                	add    %ecx,%eax
  8001cd:	8a 40 04             	mov    0x4(%eax),%al
  8001d0:	3c 01                	cmp    $0x1,%al
  8001d2:	75 03                	jne    8001d7 <_main+0x19f>
				curNumOfEmptyWSEntries++;
  8001d4:	ff 45 e0             	incl   -0x20(%ebp)
			}
		}

		//check free frames
		curNumOfEmptyWSEntries = 0;
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  8001d7:	ff 45 e8             	incl   -0x18(%ebp)
  8001da:	a1 04 30 80 00       	mov    0x803004,%eax
  8001df:	8b 50 74             	mov    0x74(%eax),%edx
  8001e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e5:	39 c2                	cmp    %eax,%edx
  8001e7:	77 cb                	ja     8001b4 <_main+0x17c>
			if (myEnv->__uptr_pws[j].empty==1)
				curNumOfEmptyWSEntries++;
		}

		//cprintf("diff in RAM = %d\n", sys_calculate_free_frames() - freeFrames);
		if ((sys_calculate_free_frames() - freeFrames) != curNumOfEmptyWSEntries - initNumOfEmptyWSEntries)
  8001e9:	e8 78 13 00 00       	call   801566 <sys_calculate_free_frames>
  8001ee:	89 c2                	mov    %eax,%edx
  8001f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001f3:	29 c2                	sub    %eax,%edx
  8001f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001f8:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8001fb:	39 c2                	cmp    %eax,%edx
  8001fd:	74 14                	je     800213 <_main+0x1db>
			panic("Wrong freeing the stack pages from memory!\n");
  8001ff:	83 ec 04             	sub    $0x4,%esp
  800202:	68 f0 1d 80 00       	push   $0x801df0
  800207:	6a 3f                	push   $0x3f
  800209:	68 69 1d 80 00       	push   $0x801d69
  80020e:	e8 a9 01 00 00       	call   8003bc <_panic>
	uint32 vaOf1stStackPage = USTACKTOP - PAGE_SIZE;

	int initNumOfEmptyWSEntries, curNumOfEmptyWSEntries ;

	/*Different number of recursive calls (each call takes 1 PAGE)*/
	for (r = 1; r <= 10; ++r)
  800213:	ff 45 f0             	incl   -0x10(%ebp)
  800216:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  80021a:	0f 8e 31 fe ff ff    	jle    800051 <_main+0x19>
		//cprintf("diff in RAM = %d\n", sys_calculate_free_frames() - freeFrames);
		if ((sys_calculate_free_frames() - freeFrames) != curNumOfEmptyWSEntries - initNumOfEmptyWSEntries)
			panic("Wrong freeing the stack pages from memory!\n");
	}

	cprintf("Congratulations!! test freeing the stack pages has completed successfully.\n");
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 1c 1e 80 00       	push   $0x801e1c
  800228:	e8 43 04 00 00       	call   800670 <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp

	return;
  800230:	90                   	nop
}
  800231:	c9                   	leave  
  800232:	c3                   	ret    

00800233 <RecursiveFn>:

int RecursiveFn(int numOfRec)
{
  800233:	55                   	push   %ebp
  800234:	89 e5                	mov    %esp,%ebp
  800236:	81 ec 18 10 00 00    	sub    $0x1018,%esp
	if (numOfRec == 0)
  80023c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800240:	75 07                	jne    800249 <RecursiveFn+0x16>
		return 0;
  800242:	b8 00 00 00 00       	mov    $0x0,%eax
  800247:	eb 62                	jmp    8002ab <RecursiveFn+0x78>

	int A[1024] ;
	int i, sum = 0 ;
  800249:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	for (i = 0; i < 1024; ++i) {
  800250:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800257:	eb 10                	jmp    800269 <RecursiveFn+0x36>
		A[i] = numOfRec;
  800259:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80025c:	8b 55 08             	mov    0x8(%ebp),%edx
  80025f:	89 94 85 f0 ef ff ff 	mov    %edx,-0x1010(%ebp,%eax,4)
	if (numOfRec == 0)
		return 0;

	int A[1024] ;
	int i, sum = 0 ;
	for (i = 0; i < 1024; ++i) {
  800266:	ff 45 f4             	incl   -0xc(%ebp)
  800269:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
  800270:	7e e7                	jle    800259 <RecursiveFn+0x26>
		A[i] = numOfRec;
	}
	for (i = 0; i < 1024; ++i) {
  800272:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800279:	eb 10                	jmp    80028b <RecursiveFn+0x58>
		sum += A[i] ;
  80027b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80027e:	8b 84 85 f0 ef ff ff 	mov    -0x1010(%ebp,%eax,4),%eax
  800285:	01 45 f0             	add    %eax,-0x10(%ebp)
	int A[1024] ;
	int i, sum = 0 ;
	for (i = 0; i < 1024; ++i) {
		A[i] = numOfRec;
	}
	for (i = 0; i < 1024; ++i) {
  800288:	ff 45 f4             	incl   -0xc(%ebp)
  80028b:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
  800292:	7e e7                	jle    80027b <RecursiveFn+0x48>
		sum += A[i] ;
	}
	return sum + RecursiveFn(numOfRec-1);
  800294:	8b 45 08             	mov    0x8(%ebp),%eax
  800297:	48                   	dec    %eax
  800298:	83 ec 0c             	sub    $0xc,%esp
  80029b:	50                   	push   %eax
  80029c:	e8 92 ff ff ff       	call   800233 <RecursiveFn>
  8002a1:	83 c4 10             	add    $0x10,%esp
  8002a4:	89 c2                	mov    %eax,%edx
  8002a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002a9:	01 d0                	add    %edx,%eax
}
  8002ab:	c9                   	leave  
  8002ac:	c3                   	ret    

008002ad <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002ad:	55                   	push   %ebp
  8002ae:	89 e5                	mov    %esp,%ebp
  8002b0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002b3:	e8 e3 11 00 00       	call   80149b <sys_getenvindex>
  8002b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002be:	89 d0                	mov    %edx,%eax
  8002c0:	c1 e0 02             	shl    $0x2,%eax
  8002c3:	01 d0                	add    %edx,%eax
  8002c5:	01 c0                	add    %eax,%eax
  8002c7:	01 d0                	add    %edx,%eax
  8002c9:	01 c0                	add    %eax,%eax
  8002cb:	01 d0                	add    %edx,%eax
  8002cd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002d4:	01 d0                	add    %edx,%eax
  8002d6:	c1 e0 02             	shl    $0x2,%eax
  8002d9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002de:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002e3:	a1 04 30 80 00       	mov    0x803004,%eax
  8002e8:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8002ee:	84 c0                	test   %al,%al
  8002f0:	74 0f                	je     800301 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8002f2:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f7:	05 f4 02 00 00       	add    $0x2f4,%eax
  8002fc:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800301:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800305:	7e 0a                	jle    800311 <libmain+0x64>
		binaryname = argv[0];
  800307:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030a:	8b 00                	mov    (%eax),%eax
  80030c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800311:	83 ec 08             	sub    $0x8,%esp
  800314:	ff 75 0c             	pushl  0xc(%ebp)
  800317:	ff 75 08             	pushl  0x8(%ebp)
  80031a:	e8 19 fd ff ff       	call   800038 <_main>
  80031f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800322:	e8 0f 13 00 00       	call   801636 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800327:	83 ec 0c             	sub    $0xc,%esp
  80032a:	68 80 1e 80 00       	push   $0x801e80
  80032f:	e8 3c 03 00 00       	call   800670 <cprintf>
  800334:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800337:	a1 04 30 80 00       	mov    0x803004,%eax
  80033c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800342:	a1 04 30 80 00       	mov    0x803004,%eax
  800347:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80034d:	83 ec 04             	sub    $0x4,%esp
  800350:	52                   	push   %edx
  800351:	50                   	push   %eax
  800352:	68 a8 1e 80 00       	push   $0x801ea8
  800357:	e8 14 03 00 00       	call   800670 <cprintf>
  80035c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80035f:	a1 04 30 80 00       	mov    0x803004,%eax
  800364:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80036a:	83 ec 08             	sub    $0x8,%esp
  80036d:	50                   	push   %eax
  80036e:	68 cd 1e 80 00       	push   $0x801ecd
  800373:	e8 f8 02 00 00       	call   800670 <cprintf>
  800378:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80037b:	83 ec 0c             	sub    $0xc,%esp
  80037e:	68 80 1e 80 00       	push   $0x801e80
  800383:	e8 e8 02 00 00       	call   800670 <cprintf>
  800388:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80038b:	e8 c0 12 00 00       	call   801650 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800390:	e8 19 00 00 00       	call   8003ae <exit>
}
  800395:	90                   	nop
  800396:	c9                   	leave  
  800397:	c3                   	ret    

00800398 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800398:	55                   	push   %ebp
  800399:	89 e5                	mov    %esp,%ebp
  80039b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80039e:	83 ec 0c             	sub    $0xc,%esp
  8003a1:	6a 00                	push   $0x0
  8003a3:	e8 bf 10 00 00       	call   801467 <sys_env_destroy>
  8003a8:	83 c4 10             	add    $0x10,%esp
}
  8003ab:	90                   	nop
  8003ac:	c9                   	leave  
  8003ad:	c3                   	ret    

008003ae <exit>:

void
exit(void)
{
  8003ae:	55                   	push   %ebp
  8003af:	89 e5                	mov    %esp,%ebp
  8003b1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003b4:	e8 14 11 00 00       	call   8014cd <sys_env_exit>
}
  8003b9:	90                   	nop
  8003ba:	c9                   	leave  
  8003bb:	c3                   	ret    

008003bc <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003bc:	55                   	push   %ebp
  8003bd:	89 e5                	mov    %esp,%ebp
  8003bf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003c2:	8d 45 10             	lea    0x10(%ebp),%eax
  8003c5:	83 c0 04             	add    $0x4,%eax
  8003c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003cb:	a1 14 30 80 00       	mov    0x803014,%eax
  8003d0:	85 c0                	test   %eax,%eax
  8003d2:	74 16                	je     8003ea <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003d4:	a1 14 30 80 00       	mov    0x803014,%eax
  8003d9:	83 ec 08             	sub    $0x8,%esp
  8003dc:	50                   	push   %eax
  8003dd:	68 e4 1e 80 00       	push   $0x801ee4
  8003e2:	e8 89 02 00 00       	call   800670 <cprintf>
  8003e7:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8003ea:	a1 00 30 80 00       	mov    0x803000,%eax
  8003ef:	ff 75 0c             	pushl  0xc(%ebp)
  8003f2:	ff 75 08             	pushl  0x8(%ebp)
  8003f5:	50                   	push   %eax
  8003f6:	68 e9 1e 80 00       	push   $0x801ee9
  8003fb:	e8 70 02 00 00       	call   800670 <cprintf>
  800400:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800403:	8b 45 10             	mov    0x10(%ebp),%eax
  800406:	83 ec 08             	sub    $0x8,%esp
  800409:	ff 75 f4             	pushl  -0xc(%ebp)
  80040c:	50                   	push   %eax
  80040d:	e8 f3 01 00 00       	call   800605 <vcprintf>
  800412:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800415:	83 ec 08             	sub    $0x8,%esp
  800418:	6a 00                	push   $0x0
  80041a:	68 05 1f 80 00       	push   $0x801f05
  80041f:	e8 e1 01 00 00       	call   800605 <vcprintf>
  800424:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800427:	e8 82 ff ff ff       	call   8003ae <exit>

	// should not return here
	while (1) ;
  80042c:	eb fe                	jmp    80042c <_panic+0x70>

0080042e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
  800431:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800434:	a1 04 30 80 00       	mov    0x803004,%eax
  800439:	8b 50 74             	mov    0x74(%eax),%edx
  80043c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80043f:	39 c2                	cmp    %eax,%edx
  800441:	74 14                	je     800457 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800443:	83 ec 04             	sub    $0x4,%esp
  800446:	68 08 1f 80 00       	push   $0x801f08
  80044b:	6a 26                	push   $0x26
  80044d:	68 54 1f 80 00       	push   $0x801f54
  800452:	e8 65 ff ff ff       	call   8003bc <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800457:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80045e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800465:	e9 c2 00 00 00       	jmp    80052c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80046a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80046d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800474:	8b 45 08             	mov    0x8(%ebp),%eax
  800477:	01 d0                	add    %edx,%eax
  800479:	8b 00                	mov    (%eax),%eax
  80047b:	85 c0                	test   %eax,%eax
  80047d:	75 08                	jne    800487 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80047f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800482:	e9 a2 00 00 00       	jmp    800529 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800487:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80048e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800495:	eb 69                	jmp    800500 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800497:	a1 04 30 80 00       	mov    0x803004,%eax
  80049c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004a2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004a5:	89 d0                	mov    %edx,%eax
  8004a7:	01 c0                	add    %eax,%eax
  8004a9:	01 d0                	add    %edx,%eax
  8004ab:	c1 e0 02             	shl    $0x2,%eax
  8004ae:	01 c8                	add    %ecx,%eax
  8004b0:	8a 40 04             	mov    0x4(%eax),%al
  8004b3:	84 c0                	test   %al,%al
  8004b5:	75 46                	jne    8004fd <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004b7:	a1 04 30 80 00       	mov    0x803004,%eax
  8004bc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004c2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004c5:	89 d0                	mov    %edx,%eax
  8004c7:	01 c0                	add    %eax,%eax
  8004c9:	01 d0                	add    %edx,%eax
  8004cb:	c1 e0 02             	shl    $0x2,%eax
  8004ce:	01 c8                	add    %ecx,%eax
  8004d0:	8b 00                	mov    (%eax),%eax
  8004d2:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004d5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004dd:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004e2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ec:	01 c8                	add    %ecx,%eax
  8004ee:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004f0:	39 c2                	cmp    %eax,%edx
  8004f2:	75 09                	jne    8004fd <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8004f4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8004fb:	eb 12                	jmp    80050f <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004fd:	ff 45 e8             	incl   -0x18(%ebp)
  800500:	a1 04 30 80 00       	mov    0x803004,%eax
  800505:	8b 50 74             	mov    0x74(%eax),%edx
  800508:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80050b:	39 c2                	cmp    %eax,%edx
  80050d:	77 88                	ja     800497 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80050f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800513:	75 14                	jne    800529 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800515:	83 ec 04             	sub    $0x4,%esp
  800518:	68 60 1f 80 00       	push   $0x801f60
  80051d:	6a 3a                	push   $0x3a
  80051f:	68 54 1f 80 00       	push   $0x801f54
  800524:	e8 93 fe ff ff       	call   8003bc <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800529:	ff 45 f0             	incl   -0x10(%ebp)
  80052c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80052f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800532:	0f 8c 32 ff ff ff    	jl     80046a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800538:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80053f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800546:	eb 26                	jmp    80056e <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800548:	a1 04 30 80 00       	mov    0x803004,%eax
  80054d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800553:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800556:	89 d0                	mov    %edx,%eax
  800558:	01 c0                	add    %eax,%eax
  80055a:	01 d0                	add    %edx,%eax
  80055c:	c1 e0 02             	shl    $0x2,%eax
  80055f:	01 c8                	add    %ecx,%eax
  800561:	8a 40 04             	mov    0x4(%eax),%al
  800564:	3c 01                	cmp    $0x1,%al
  800566:	75 03                	jne    80056b <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800568:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80056b:	ff 45 e0             	incl   -0x20(%ebp)
  80056e:	a1 04 30 80 00       	mov    0x803004,%eax
  800573:	8b 50 74             	mov    0x74(%eax),%edx
  800576:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800579:	39 c2                	cmp    %eax,%edx
  80057b:	77 cb                	ja     800548 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80057d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800580:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800583:	74 14                	je     800599 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800585:	83 ec 04             	sub    $0x4,%esp
  800588:	68 b4 1f 80 00       	push   $0x801fb4
  80058d:	6a 44                	push   $0x44
  80058f:	68 54 1f 80 00       	push   $0x801f54
  800594:	e8 23 fe ff ff       	call   8003bc <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800599:	90                   	nop
  80059a:	c9                   	leave  
  80059b:	c3                   	ret    

0080059c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80059c:	55                   	push   %ebp
  80059d:	89 e5                	mov    %esp,%ebp
  80059f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a5:	8b 00                	mov    (%eax),%eax
  8005a7:	8d 48 01             	lea    0x1(%eax),%ecx
  8005aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ad:	89 0a                	mov    %ecx,(%edx)
  8005af:	8b 55 08             	mov    0x8(%ebp),%edx
  8005b2:	88 d1                	mov    %dl,%cl
  8005b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005b7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005be:	8b 00                	mov    (%eax),%eax
  8005c0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005c5:	75 2c                	jne    8005f3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005c7:	a0 08 30 80 00       	mov    0x803008,%al
  8005cc:	0f b6 c0             	movzbl %al,%eax
  8005cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d2:	8b 12                	mov    (%edx),%edx
  8005d4:	89 d1                	mov    %edx,%ecx
  8005d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d9:	83 c2 08             	add    $0x8,%edx
  8005dc:	83 ec 04             	sub    $0x4,%esp
  8005df:	50                   	push   %eax
  8005e0:	51                   	push   %ecx
  8005e1:	52                   	push   %edx
  8005e2:	e8 3e 0e 00 00       	call   801425 <sys_cputs>
  8005e7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005f6:	8b 40 04             	mov    0x4(%eax),%eax
  8005f9:	8d 50 01             	lea    0x1(%eax),%edx
  8005fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ff:	89 50 04             	mov    %edx,0x4(%eax)
}
  800602:	90                   	nop
  800603:	c9                   	leave  
  800604:	c3                   	ret    

00800605 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800605:	55                   	push   %ebp
  800606:	89 e5                	mov    %esp,%ebp
  800608:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80060e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800615:	00 00 00 
	b.cnt = 0;
  800618:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80061f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800622:	ff 75 0c             	pushl  0xc(%ebp)
  800625:	ff 75 08             	pushl  0x8(%ebp)
  800628:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80062e:	50                   	push   %eax
  80062f:	68 9c 05 80 00       	push   $0x80059c
  800634:	e8 11 02 00 00       	call   80084a <vprintfmt>
  800639:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80063c:	a0 08 30 80 00       	mov    0x803008,%al
  800641:	0f b6 c0             	movzbl %al,%eax
  800644:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80064a:	83 ec 04             	sub    $0x4,%esp
  80064d:	50                   	push   %eax
  80064e:	52                   	push   %edx
  80064f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800655:	83 c0 08             	add    $0x8,%eax
  800658:	50                   	push   %eax
  800659:	e8 c7 0d 00 00       	call   801425 <sys_cputs>
  80065e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800661:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  800668:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80066e:	c9                   	leave  
  80066f:	c3                   	ret    

00800670 <cprintf>:

int cprintf(const char *fmt, ...) {
  800670:	55                   	push   %ebp
  800671:	89 e5                	mov    %esp,%ebp
  800673:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800676:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  80067d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800680:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800683:	8b 45 08             	mov    0x8(%ebp),%eax
  800686:	83 ec 08             	sub    $0x8,%esp
  800689:	ff 75 f4             	pushl  -0xc(%ebp)
  80068c:	50                   	push   %eax
  80068d:	e8 73 ff ff ff       	call   800605 <vcprintf>
  800692:	83 c4 10             	add    $0x10,%esp
  800695:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800698:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80069b:	c9                   	leave  
  80069c:	c3                   	ret    

0080069d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80069d:	55                   	push   %ebp
  80069e:	89 e5                	mov    %esp,%ebp
  8006a0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006a3:	e8 8e 0f 00 00       	call   801636 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006a8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b1:	83 ec 08             	sub    $0x8,%esp
  8006b4:	ff 75 f4             	pushl  -0xc(%ebp)
  8006b7:	50                   	push   %eax
  8006b8:	e8 48 ff ff ff       	call   800605 <vcprintf>
  8006bd:	83 c4 10             	add    $0x10,%esp
  8006c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006c3:	e8 88 0f 00 00       	call   801650 <sys_enable_interrupt>
	return cnt;
  8006c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006cb:	c9                   	leave  
  8006cc:	c3                   	ret    

008006cd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006cd:	55                   	push   %ebp
  8006ce:	89 e5                	mov    %esp,%ebp
  8006d0:	53                   	push   %ebx
  8006d1:	83 ec 14             	sub    $0x14,%esp
  8006d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8006d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006da:	8b 45 14             	mov    0x14(%ebp),%eax
  8006dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006e0:	8b 45 18             	mov    0x18(%ebp),%eax
  8006e3:	ba 00 00 00 00       	mov    $0x0,%edx
  8006e8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006eb:	77 55                	ja     800742 <printnum+0x75>
  8006ed:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006f0:	72 05                	jb     8006f7 <printnum+0x2a>
  8006f2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006f5:	77 4b                	ja     800742 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006f7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006fa:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006fd:	8b 45 18             	mov    0x18(%ebp),%eax
  800700:	ba 00 00 00 00       	mov    $0x0,%edx
  800705:	52                   	push   %edx
  800706:	50                   	push   %eax
  800707:	ff 75 f4             	pushl  -0xc(%ebp)
  80070a:	ff 75 f0             	pushl  -0x10(%ebp)
  80070d:	e8 b6 13 00 00       	call   801ac8 <__udivdi3>
  800712:	83 c4 10             	add    $0x10,%esp
  800715:	83 ec 04             	sub    $0x4,%esp
  800718:	ff 75 20             	pushl  0x20(%ebp)
  80071b:	53                   	push   %ebx
  80071c:	ff 75 18             	pushl  0x18(%ebp)
  80071f:	52                   	push   %edx
  800720:	50                   	push   %eax
  800721:	ff 75 0c             	pushl  0xc(%ebp)
  800724:	ff 75 08             	pushl  0x8(%ebp)
  800727:	e8 a1 ff ff ff       	call   8006cd <printnum>
  80072c:	83 c4 20             	add    $0x20,%esp
  80072f:	eb 1a                	jmp    80074b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	ff 75 0c             	pushl  0xc(%ebp)
  800737:	ff 75 20             	pushl  0x20(%ebp)
  80073a:	8b 45 08             	mov    0x8(%ebp),%eax
  80073d:	ff d0                	call   *%eax
  80073f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800742:	ff 4d 1c             	decl   0x1c(%ebp)
  800745:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800749:	7f e6                	jg     800731 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80074b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80074e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800753:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800756:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800759:	53                   	push   %ebx
  80075a:	51                   	push   %ecx
  80075b:	52                   	push   %edx
  80075c:	50                   	push   %eax
  80075d:	e8 76 14 00 00       	call   801bd8 <__umoddi3>
  800762:	83 c4 10             	add    $0x10,%esp
  800765:	05 14 22 80 00       	add    $0x802214,%eax
  80076a:	8a 00                	mov    (%eax),%al
  80076c:	0f be c0             	movsbl %al,%eax
  80076f:	83 ec 08             	sub    $0x8,%esp
  800772:	ff 75 0c             	pushl  0xc(%ebp)
  800775:	50                   	push   %eax
  800776:	8b 45 08             	mov    0x8(%ebp),%eax
  800779:	ff d0                	call   *%eax
  80077b:	83 c4 10             	add    $0x10,%esp
}
  80077e:	90                   	nop
  80077f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800782:	c9                   	leave  
  800783:	c3                   	ret    

00800784 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800784:	55                   	push   %ebp
  800785:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800787:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80078b:	7e 1c                	jle    8007a9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	8b 00                	mov    (%eax),%eax
  800792:	8d 50 08             	lea    0x8(%eax),%edx
  800795:	8b 45 08             	mov    0x8(%ebp),%eax
  800798:	89 10                	mov    %edx,(%eax)
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	8b 00                	mov    (%eax),%eax
  80079f:	83 e8 08             	sub    $0x8,%eax
  8007a2:	8b 50 04             	mov    0x4(%eax),%edx
  8007a5:	8b 00                	mov    (%eax),%eax
  8007a7:	eb 40                	jmp    8007e9 <getuint+0x65>
	else if (lflag)
  8007a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007ad:	74 1e                	je     8007cd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007af:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b2:	8b 00                	mov    (%eax),%eax
  8007b4:	8d 50 04             	lea    0x4(%eax),%edx
  8007b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ba:	89 10                	mov    %edx,(%eax)
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	8b 00                	mov    (%eax),%eax
  8007c1:	83 e8 04             	sub    $0x4,%eax
  8007c4:	8b 00                	mov    (%eax),%eax
  8007c6:	ba 00 00 00 00       	mov    $0x0,%edx
  8007cb:	eb 1c                	jmp    8007e9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	8b 00                	mov    (%eax),%eax
  8007d2:	8d 50 04             	lea    0x4(%eax),%edx
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	89 10                	mov    %edx,(%eax)
  8007da:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dd:	8b 00                	mov    (%eax),%eax
  8007df:	83 e8 04             	sub    $0x4,%eax
  8007e2:	8b 00                	mov    (%eax),%eax
  8007e4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007e9:	5d                   	pop    %ebp
  8007ea:	c3                   	ret    

008007eb <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007eb:	55                   	push   %ebp
  8007ec:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007ee:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007f2:	7e 1c                	jle    800810 <getint+0x25>
		return va_arg(*ap, long long);
  8007f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f7:	8b 00                	mov    (%eax),%eax
  8007f9:	8d 50 08             	lea    0x8(%eax),%edx
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	89 10                	mov    %edx,(%eax)
  800801:	8b 45 08             	mov    0x8(%ebp),%eax
  800804:	8b 00                	mov    (%eax),%eax
  800806:	83 e8 08             	sub    $0x8,%eax
  800809:	8b 50 04             	mov    0x4(%eax),%edx
  80080c:	8b 00                	mov    (%eax),%eax
  80080e:	eb 38                	jmp    800848 <getint+0x5d>
	else if (lflag)
  800810:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800814:	74 1a                	je     800830 <getint+0x45>
		return va_arg(*ap, long);
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
  80082e:	eb 18                	jmp    800848 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800830:	8b 45 08             	mov    0x8(%ebp),%eax
  800833:	8b 00                	mov    (%eax),%eax
  800835:	8d 50 04             	lea    0x4(%eax),%edx
  800838:	8b 45 08             	mov    0x8(%ebp),%eax
  80083b:	89 10                	mov    %edx,(%eax)
  80083d:	8b 45 08             	mov    0x8(%ebp),%eax
  800840:	8b 00                	mov    (%eax),%eax
  800842:	83 e8 04             	sub    $0x4,%eax
  800845:	8b 00                	mov    (%eax),%eax
  800847:	99                   	cltd   
}
  800848:	5d                   	pop    %ebp
  800849:	c3                   	ret    

0080084a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80084a:	55                   	push   %ebp
  80084b:	89 e5                	mov    %esp,%ebp
  80084d:	56                   	push   %esi
  80084e:	53                   	push   %ebx
  80084f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800852:	eb 17                	jmp    80086b <vprintfmt+0x21>
			if (ch == '\0')
  800854:	85 db                	test   %ebx,%ebx
  800856:	0f 84 af 03 00 00    	je     800c0b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80085c:	83 ec 08             	sub    $0x8,%esp
  80085f:	ff 75 0c             	pushl  0xc(%ebp)
  800862:	53                   	push   %ebx
  800863:	8b 45 08             	mov    0x8(%ebp),%eax
  800866:	ff d0                	call   *%eax
  800868:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80086b:	8b 45 10             	mov    0x10(%ebp),%eax
  80086e:	8d 50 01             	lea    0x1(%eax),%edx
  800871:	89 55 10             	mov    %edx,0x10(%ebp)
  800874:	8a 00                	mov    (%eax),%al
  800876:	0f b6 d8             	movzbl %al,%ebx
  800879:	83 fb 25             	cmp    $0x25,%ebx
  80087c:	75 d6                	jne    800854 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80087e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800882:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800889:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800890:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800897:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80089e:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a1:	8d 50 01             	lea    0x1(%eax),%edx
  8008a4:	89 55 10             	mov    %edx,0x10(%ebp)
  8008a7:	8a 00                	mov    (%eax),%al
  8008a9:	0f b6 d8             	movzbl %al,%ebx
  8008ac:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008af:	83 f8 55             	cmp    $0x55,%eax
  8008b2:	0f 87 2b 03 00 00    	ja     800be3 <vprintfmt+0x399>
  8008b8:	8b 04 85 38 22 80 00 	mov    0x802238(,%eax,4),%eax
  8008bf:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008c1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008c5:	eb d7                	jmp    80089e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008c7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008cb:	eb d1                	jmp    80089e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008cd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008d4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008d7:	89 d0                	mov    %edx,%eax
  8008d9:	c1 e0 02             	shl    $0x2,%eax
  8008dc:	01 d0                	add    %edx,%eax
  8008de:	01 c0                	add    %eax,%eax
  8008e0:	01 d8                	add    %ebx,%eax
  8008e2:	83 e8 30             	sub    $0x30,%eax
  8008e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8008eb:	8a 00                	mov    (%eax),%al
  8008ed:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008f0:	83 fb 2f             	cmp    $0x2f,%ebx
  8008f3:	7e 3e                	jle    800933 <vprintfmt+0xe9>
  8008f5:	83 fb 39             	cmp    $0x39,%ebx
  8008f8:	7f 39                	jg     800933 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008fa:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008fd:	eb d5                	jmp    8008d4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008ff:	8b 45 14             	mov    0x14(%ebp),%eax
  800902:	83 c0 04             	add    $0x4,%eax
  800905:	89 45 14             	mov    %eax,0x14(%ebp)
  800908:	8b 45 14             	mov    0x14(%ebp),%eax
  80090b:	83 e8 04             	sub    $0x4,%eax
  80090e:	8b 00                	mov    (%eax),%eax
  800910:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800913:	eb 1f                	jmp    800934 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800915:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800919:	79 83                	jns    80089e <vprintfmt+0x54>
				width = 0;
  80091b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800922:	e9 77 ff ff ff       	jmp    80089e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800927:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80092e:	e9 6b ff ff ff       	jmp    80089e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800933:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800934:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800938:	0f 89 60 ff ff ff    	jns    80089e <vprintfmt+0x54>
				width = precision, precision = -1;
  80093e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800941:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800944:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80094b:	e9 4e ff ff ff       	jmp    80089e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800950:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800953:	e9 46 ff ff ff       	jmp    80089e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800958:	8b 45 14             	mov    0x14(%ebp),%eax
  80095b:	83 c0 04             	add    $0x4,%eax
  80095e:	89 45 14             	mov    %eax,0x14(%ebp)
  800961:	8b 45 14             	mov    0x14(%ebp),%eax
  800964:	83 e8 04             	sub    $0x4,%eax
  800967:	8b 00                	mov    (%eax),%eax
  800969:	83 ec 08             	sub    $0x8,%esp
  80096c:	ff 75 0c             	pushl  0xc(%ebp)
  80096f:	50                   	push   %eax
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	ff d0                	call   *%eax
  800975:	83 c4 10             	add    $0x10,%esp
			break;
  800978:	e9 89 02 00 00       	jmp    800c06 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80097d:	8b 45 14             	mov    0x14(%ebp),%eax
  800980:	83 c0 04             	add    $0x4,%eax
  800983:	89 45 14             	mov    %eax,0x14(%ebp)
  800986:	8b 45 14             	mov    0x14(%ebp),%eax
  800989:	83 e8 04             	sub    $0x4,%eax
  80098c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80098e:	85 db                	test   %ebx,%ebx
  800990:	79 02                	jns    800994 <vprintfmt+0x14a>
				err = -err;
  800992:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800994:	83 fb 64             	cmp    $0x64,%ebx
  800997:	7f 0b                	jg     8009a4 <vprintfmt+0x15a>
  800999:	8b 34 9d 80 20 80 00 	mov    0x802080(,%ebx,4),%esi
  8009a0:	85 f6                	test   %esi,%esi
  8009a2:	75 19                	jne    8009bd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009a4:	53                   	push   %ebx
  8009a5:	68 25 22 80 00       	push   $0x802225
  8009aa:	ff 75 0c             	pushl  0xc(%ebp)
  8009ad:	ff 75 08             	pushl  0x8(%ebp)
  8009b0:	e8 5e 02 00 00       	call   800c13 <printfmt>
  8009b5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009b8:	e9 49 02 00 00       	jmp    800c06 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009bd:	56                   	push   %esi
  8009be:	68 2e 22 80 00       	push   $0x80222e
  8009c3:	ff 75 0c             	pushl  0xc(%ebp)
  8009c6:	ff 75 08             	pushl  0x8(%ebp)
  8009c9:	e8 45 02 00 00       	call   800c13 <printfmt>
  8009ce:	83 c4 10             	add    $0x10,%esp
			break;
  8009d1:	e9 30 02 00 00       	jmp    800c06 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d9:	83 c0 04             	add    $0x4,%eax
  8009dc:	89 45 14             	mov    %eax,0x14(%ebp)
  8009df:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e2:	83 e8 04             	sub    $0x4,%eax
  8009e5:	8b 30                	mov    (%eax),%esi
  8009e7:	85 f6                	test   %esi,%esi
  8009e9:	75 05                	jne    8009f0 <vprintfmt+0x1a6>
				p = "(null)";
  8009eb:	be 31 22 80 00       	mov    $0x802231,%esi
			if (width > 0 && padc != '-')
  8009f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009f4:	7e 6d                	jle    800a63 <vprintfmt+0x219>
  8009f6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009fa:	74 67                	je     800a63 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009ff:	83 ec 08             	sub    $0x8,%esp
  800a02:	50                   	push   %eax
  800a03:	56                   	push   %esi
  800a04:	e8 0c 03 00 00       	call   800d15 <strnlen>
  800a09:	83 c4 10             	add    $0x10,%esp
  800a0c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a0f:	eb 16                	jmp    800a27 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a11:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a15:	83 ec 08             	sub    $0x8,%esp
  800a18:	ff 75 0c             	pushl  0xc(%ebp)
  800a1b:	50                   	push   %eax
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	ff d0                	call   *%eax
  800a21:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a24:	ff 4d e4             	decl   -0x1c(%ebp)
  800a27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a2b:	7f e4                	jg     800a11 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a2d:	eb 34                	jmp    800a63 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a2f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a33:	74 1c                	je     800a51 <vprintfmt+0x207>
  800a35:	83 fb 1f             	cmp    $0x1f,%ebx
  800a38:	7e 05                	jle    800a3f <vprintfmt+0x1f5>
  800a3a:	83 fb 7e             	cmp    $0x7e,%ebx
  800a3d:	7e 12                	jle    800a51 <vprintfmt+0x207>
					putch('?', putdat);
  800a3f:	83 ec 08             	sub    $0x8,%esp
  800a42:	ff 75 0c             	pushl  0xc(%ebp)
  800a45:	6a 3f                	push   $0x3f
  800a47:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4a:	ff d0                	call   *%eax
  800a4c:	83 c4 10             	add    $0x10,%esp
  800a4f:	eb 0f                	jmp    800a60 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	53                   	push   %ebx
  800a58:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5b:	ff d0                	call   *%eax
  800a5d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a60:	ff 4d e4             	decl   -0x1c(%ebp)
  800a63:	89 f0                	mov    %esi,%eax
  800a65:	8d 70 01             	lea    0x1(%eax),%esi
  800a68:	8a 00                	mov    (%eax),%al
  800a6a:	0f be d8             	movsbl %al,%ebx
  800a6d:	85 db                	test   %ebx,%ebx
  800a6f:	74 24                	je     800a95 <vprintfmt+0x24b>
  800a71:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a75:	78 b8                	js     800a2f <vprintfmt+0x1e5>
  800a77:	ff 4d e0             	decl   -0x20(%ebp)
  800a7a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a7e:	79 af                	jns    800a2f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a80:	eb 13                	jmp    800a95 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a82:	83 ec 08             	sub    $0x8,%esp
  800a85:	ff 75 0c             	pushl  0xc(%ebp)
  800a88:	6a 20                	push   $0x20
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	ff d0                	call   *%eax
  800a8f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a92:	ff 4d e4             	decl   -0x1c(%ebp)
  800a95:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a99:	7f e7                	jg     800a82 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a9b:	e9 66 01 00 00       	jmp    800c06 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800aa0:	83 ec 08             	sub    $0x8,%esp
  800aa3:	ff 75 e8             	pushl  -0x18(%ebp)
  800aa6:	8d 45 14             	lea    0x14(%ebp),%eax
  800aa9:	50                   	push   %eax
  800aaa:	e8 3c fd ff ff       	call   8007eb <getint>
  800aaf:	83 c4 10             	add    $0x10,%esp
  800ab2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ab5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ab8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800abb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800abe:	85 d2                	test   %edx,%edx
  800ac0:	79 23                	jns    800ae5 <vprintfmt+0x29b>
				putch('-', putdat);
  800ac2:	83 ec 08             	sub    $0x8,%esp
  800ac5:	ff 75 0c             	pushl  0xc(%ebp)
  800ac8:	6a 2d                	push   $0x2d
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	ff d0                	call   *%eax
  800acf:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ad2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ad5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ad8:	f7 d8                	neg    %eax
  800ada:	83 d2 00             	adc    $0x0,%edx
  800add:	f7 da                	neg    %edx
  800adf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ae2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ae5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aec:	e9 bc 00 00 00       	jmp    800bad <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800af1:	83 ec 08             	sub    $0x8,%esp
  800af4:	ff 75 e8             	pushl  -0x18(%ebp)
  800af7:	8d 45 14             	lea    0x14(%ebp),%eax
  800afa:	50                   	push   %eax
  800afb:	e8 84 fc ff ff       	call   800784 <getuint>
  800b00:	83 c4 10             	add    $0x10,%esp
  800b03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b06:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b09:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b10:	e9 98 00 00 00       	jmp    800bad <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b15:	83 ec 08             	sub    $0x8,%esp
  800b18:	ff 75 0c             	pushl  0xc(%ebp)
  800b1b:	6a 58                	push   $0x58
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	ff d0                	call   *%eax
  800b22:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b25:	83 ec 08             	sub    $0x8,%esp
  800b28:	ff 75 0c             	pushl  0xc(%ebp)
  800b2b:	6a 58                	push   $0x58
  800b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b30:	ff d0                	call   *%eax
  800b32:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b35:	83 ec 08             	sub    $0x8,%esp
  800b38:	ff 75 0c             	pushl  0xc(%ebp)
  800b3b:	6a 58                	push   $0x58
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	ff d0                	call   *%eax
  800b42:	83 c4 10             	add    $0x10,%esp
			break;
  800b45:	e9 bc 00 00 00       	jmp    800c06 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b4a:	83 ec 08             	sub    $0x8,%esp
  800b4d:	ff 75 0c             	pushl  0xc(%ebp)
  800b50:	6a 30                	push   $0x30
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	ff d0                	call   *%eax
  800b57:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b5a:	83 ec 08             	sub    $0x8,%esp
  800b5d:	ff 75 0c             	pushl  0xc(%ebp)
  800b60:	6a 78                	push   $0x78
  800b62:	8b 45 08             	mov    0x8(%ebp),%eax
  800b65:	ff d0                	call   *%eax
  800b67:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b6a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b6d:	83 c0 04             	add    $0x4,%eax
  800b70:	89 45 14             	mov    %eax,0x14(%ebp)
  800b73:	8b 45 14             	mov    0x14(%ebp),%eax
  800b76:	83 e8 04             	sub    $0x4,%eax
  800b79:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b85:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b8c:	eb 1f                	jmp    800bad <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b8e:	83 ec 08             	sub    $0x8,%esp
  800b91:	ff 75 e8             	pushl  -0x18(%ebp)
  800b94:	8d 45 14             	lea    0x14(%ebp),%eax
  800b97:	50                   	push   %eax
  800b98:	e8 e7 fb ff ff       	call   800784 <getuint>
  800b9d:	83 c4 10             	add    $0x10,%esp
  800ba0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ba6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bad:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bb1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bb4:	83 ec 04             	sub    $0x4,%esp
  800bb7:	52                   	push   %edx
  800bb8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bbb:	50                   	push   %eax
  800bbc:	ff 75 f4             	pushl  -0xc(%ebp)
  800bbf:	ff 75 f0             	pushl  -0x10(%ebp)
  800bc2:	ff 75 0c             	pushl  0xc(%ebp)
  800bc5:	ff 75 08             	pushl  0x8(%ebp)
  800bc8:	e8 00 fb ff ff       	call   8006cd <printnum>
  800bcd:	83 c4 20             	add    $0x20,%esp
			break;
  800bd0:	eb 34                	jmp    800c06 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bd2:	83 ec 08             	sub    $0x8,%esp
  800bd5:	ff 75 0c             	pushl  0xc(%ebp)
  800bd8:	53                   	push   %ebx
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdc:	ff d0                	call   *%eax
  800bde:	83 c4 10             	add    $0x10,%esp
			break;
  800be1:	eb 23                	jmp    800c06 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800be3:	83 ec 08             	sub    $0x8,%esp
  800be6:	ff 75 0c             	pushl  0xc(%ebp)
  800be9:	6a 25                	push   $0x25
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	ff d0                	call   *%eax
  800bf0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bf3:	ff 4d 10             	decl   0x10(%ebp)
  800bf6:	eb 03                	jmp    800bfb <vprintfmt+0x3b1>
  800bf8:	ff 4d 10             	decl   0x10(%ebp)
  800bfb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfe:	48                   	dec    %eax
  800bff:	8a 00                	mov    (%eax),%al
  800c01:	3c 25                	cmp    $0x25,%al
  800c03:	75 f3                	jne    800bf8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c05:	90                   	nop
		}
	}
  800c06:	e9 47 fc ff ff       	jmp    800852 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c0b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c0c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c0f:	5b                   	pop    %ebx
  800c10:	5e                   	pop    %esi
  800c11:	5d                   	pop    %ebp
  800c12:	c3                   	ret    

00800c13 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c13:	55                   	push   %ebp
  800c14:	89 e5                	mov    %esp,%ebp
  800c16:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c19:	8d 45 10             	lea    0x10(%ebp),%eax
  800c1c:	83 c0 04             	add    $0x4,%eax
  800c1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c22:	8b 45 10             	mov    0x10(%ebp),%eax
  800c25:	ff 75 f4             	pushl  -0xc(%ebp)
  800c28:	50                   	push   %eax
  800c29:	ff 75 0c             	pushl  0xc(%ebp)
  800c2c:	ff 75 08             	pushl  0x8(%ebp)
  800c2f:	e8 16 fc ff ff       	call   80084a <vprintfmt>
  800c34:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c37:	90                   	nop
  800c38:	c9                   	leave  
  800c39:	c3                   	ret    

00800c3a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c3a:	55                   	push   %ebp
  800c3b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c40:	8b 40 08             	mov    0x8(%eax),%eax
  800c43:	8d 50 01             	lea    0x1(%eax),%edx
  800c46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c49:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4f:	8b 10                	mov    (%eax),%edx
  800c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c54:	8b 40 04             	mov    0x4(%eax),%eax
  800c57:	39 c2                	cmp    %eax,%edx
  800c59:	73 12                	jae    800c6d <sprintputch+0x33>
		*b->buf++ = ch;
  800c5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5e:	8b 00                	mov    (%eax),%eax
  800c60:	8d 48 01             	lea    0x1(%eax),%ecx
  800c63:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c66:	89 0a                	mov    %ecx,(%edx)
  800c68:	8b 55 08             	mov    0x8(%ebp),%edx
  800c6b:	88 10                	mov    %dl,(%eax)
}
  800c6d:	90                   	nop
  800c6e:	5d                   	pop    %ebp
  800c6f:	c3                   	ret    

00800c70 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c70:	55                   	push   %ebp
  800c71:	89 e5                	mov    %esp,%ebp
  800c73:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c82:	8b 45 08             	mov    0x8(%ebp),%eax
  800c85:	01 d0                	add    %edx,%eax
  800c87:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c91:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c95:	74 06                	je     800c9d <vsnprintf+0x2d>
  800c97:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c9b:	7f 07                	jg     800ca4 <vsnprintf+0x34>
		return -E_INVAL;
  800c9d:	b8 03 00 00 00       	mov    $0x3,%eax
  800ca2:	eb 20                	jmp    800cc4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ca4:	ff 75 14             	pushl  0x14(%ebp)
  800ca7:	ff 75 10             	pushl  0x10(%ebp)
  800caa:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cad:	50                   	push   %eax
  800cae:	68 3a 0c 80 00       	push   $0x800c3a
  800cb3:	e8 92 fb ff ff       	call   80084a <vprintfmt>
  800cb8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cbb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cbe:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800cc4:	c9                   	leave  
  800cc5:	c3                   	ret    

00800cc6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800cc6:	55                   	push   %ebp
  800cc7:	89 e5                	mov    %esp,%ebp
  800cc9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ccc:	8d 45 10             	lea    0x10(%ebp),%eax
  800ccf:	83 c0 04             	add    $0x4,%eax
  800cd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd8:	ff 75 f4             	pushl  -0xc(%ebp)
  800cdb:	50                   	push   %eax
  800cdc:	ff 75 0c             	pushl  0xc(%ebp)
  800cdf:	ff 75 08             	pushl  0x8(%ebp)
  800ce2:	e8 89 ff ff ff       	call   800c70 <vsnprintf>
  800ce7:	83 c4 10             	add    $0x10,%esp
  800cea:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ced:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cf0:	c9                   	leave  
  800cf1:	c3                   	ret    

00800cf2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cf2:	55                   	push   %ebp
  800cf3:	89 e5                	mov    %esp,%ebp
  800cf5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cf8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cff:	eb 06                	jmp    800d07 <strlen+0x15>
		n++;
  800d01:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d04:	ff 45 08             	incl   0x8(%ebp)
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	84 c0                	test   %al,%al
  800d0e:	75 f1                	jne    800d01 <strlen+0xf>
		n++;
	return n;
  800d10:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d13:	c9                   	leave  
  800d14:	c3                   	ret    

00800d15 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d15:	55                   	push   %ebp
  800d16:	89 e5                	mov    %esp,%ebp
  800d18:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d1b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d22:	eb 09                	jmp    800d2d <strnlen+0x18>
		n++;
  800d24:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d27:	ff 45 08             	incl   0x8(%ebp)
  800d2a:	ff 4d 0c             	decl   0xc(%ebp)
  800d2d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d31:	74 09                	je     800d3c <strnlen+0x27>
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	84 c0                	test   %al,%al
  800d3a:	75 e8                	jne    800d24 <strnlen+0xf>
		n++;
	return n;
  800d3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d3f:	c9                   	leave  
  800d40:	c3                   	ret    

00800d41 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d41:	55                   	push   %ebp
  800d42:	89 e5                	mov    %esp,%ebp
  800d44:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d4d:	90                   	nop
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	8d 50 01             	lea    0x1(%eax),%edx
  800d54:	89 55 08             	mov    %edx,0x8(%ebp)
  800d57:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d5a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d5d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d60:	8a 12                	mov    (%edx),%dl
  800d62:	88 10                	mov    %dl,(%eax)
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	84 c0                	test   %al,%al
  800d68:	75 e4                	jne    800d4e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d6d:	c9                   	leave  
  800d6e:	c3                   	ret    

00800d6f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d6f:	55                   	push   %ebp
  800d70:	89 e5                	mov    %esp,%ebp
  800d72:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d82:	eb 1f                	jmp    800da3 <strncpy+0x34>
		*dst++ = *src;
  800d84:	8b 45 08             	mov    0x8(%ebp),%eax
  800d87:	8d 50 01             	lea    0x1(%eax),%edx
  800d8a:	89 55 08             	mov    %edx,0x8(%ebp)
  800d8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d90:	8a 12                	mov    (%edx),%dl
  800d92:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d97:	8a 00                	mov    (%eax),%al
  800d99:	84 c0                	test   %al,%al
  800d9b:	74 03                	je     800da0 <strncpy+0x31>
			src++;
  800d9d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800da0:	ff 45 fc             	incl   -0x4(%ebp)
  800da3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800da6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800da9:	72 d9                	jb     800d84 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dab:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dae:	c9                   	leave  
  800daf:	c3                   	ret    

00800db0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800db0:	55                   	push   %ebp
  800db1:	89 e5                	mov    %esp,%ebp
  800db3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800db6:	8b 45 08             	mov    0x8(%ebp),%eax
  800db9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dbc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc0:	74 30                	je     800df2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dc2:	eb 16                	jmp    800dda <strlcpy+0x2a>
			*dst++ = *src++;
  800dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc7:	8d 50 01             	lea    0x1(%eax),%edx
  800dca:	89 55 08             	mov    %edx,0x8(%ebp)
  800dcd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800dd6:	8a 12                	mov    (%edx),%dl
  800dd8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800dda:	ff 4d 10             	decl   0x10(%ebp)
  800ddd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de1:	74 09                	je     800dec <strlcpy+0x3c>
  800de3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de6:	8a 00                	mov    (%eax),%al
  800de8:	84 c0                	test   %al,%al
  800dea:	75 d8                	jne    800dc4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800df2:	8b 55 08             	mov    0x8(%ebp),%edx
  800df5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df8:	29 c2                	sub    %eax,%edx
  800dfa:	89 d0                	mov    %edx,%eax
}
  800dfc:	c9                   	leave  
  800dfd:	c3                   	ret    

00800dfe <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800dfe:	55                   	push   %ebp
  800dff:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e01:	eb 06                	jmp    800e09 <strcmp+0xb>
		p++, q++;
  800e03:	ff 45 08             	incl   0x8(%ebp)
  800e06:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e09:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0c:	8a 00                	mov    (%eax),%al
  800e0e:	84 c0                	test   %al,%al
  800e10:	74 0e                	je     800e20 <strcmp+0x22>
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	8a 10                	mov    (%eax),%dl
  800e17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1a:	8a 00                	mov    (%eax),%al
  800e1c:	38 c2                	cmp    %al,%dl
  800e1e:	74 e3                	je     800e03 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
  800e23:	8a 00                	mov    (%eax),%al
  800e25:	0f b6 d0             	movzbl %al,%edx
  800e28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2b:	8a 00                	mov    (%eax),%al
  800e2d:	0f b6 c0             	movzbl %al,%eax
  800e30:	29 c2                	sub    %eax,%edx
  800e32:	89 d0                	mov    %edx,%eax
}
  800e34:	5d                   	pop    %ebp
  800e35:	c3                   	ret    

00800e36 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e36:	55                   	push   %ebp
  800e37:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e39:	eb 09                	jmp    800e44 <strncmp+0xe>
		n--, p++, q++;
  800e3b:	ff 4d 10             	decl   0x10(%ebp)
  800e3e:	ff 45 08             	incl   0x8(%ebp)
  800e41:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e44:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e48:	74 17                	je     800e61 <strncmp+0x2b>
  800e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4d:	8a 00                	mov    (%eax),%al
  800e4f:	84 c0                	test   %al,%al
  800e51:	74 0e                	je     800e61 <strncmp+0x2b>
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
  800e56:	8a 10                	mov    (%eax),%dl
  800e58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5b:	8a 00                	mov    (%eax),%al
  800e5d:	38 c2                	cmp    %al,%dl
  800e5f:	74 da                	je     800e3b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e61:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e65:	75 07                	jne    800e6e <strncmp+0x38>
		return 0;
  800e67:	b8 00 00 00 00       	mov    $0x0,%eax
  800e6c:	eb 14                	jmp    800e82 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	8a 00                	mov    (%eax),%al
  800e73:	0f b6 d0             	movzbl %al,%edx
  800e76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e79:	8a 00                	mov    (%eax),%al
  800e7b:	0f b6 c0             	movzbl %al,%eax
  800e7e:	29 c2                	sub    %eax,%edx
  800e80:	89 d0                	mov    %edx,%eax
}
  800e82:	5d                   	pop    %ebp
  800e83:	c3                   	ret    

00800e84 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e84:	55                   	push   %ebp
  800e85:	89 e5                	mov    %esp,%ebp
  800e87:	83 ec 04             	sub    $0x4,%esp
  800e8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e90:	eb 12                	jmp    800ea4 <strchr+0x20>
		if (*s == c)
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	8a 00                	mov    (%eax),%al
  800e97:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e9a:	75 05                	jne    800ea1 <strchr+0x1d>
			return (char *) s;
  800e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9f:	eb 11                	jmp    800eb2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ea1:	ff 45 08             	incl   0x8(%ebp)
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	8a 00                	mov    (%eax),%al
  800ea9:	84 c0                	test   %al,%al
  800eab:	75 e5                	jne    800e92 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ead:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eb2:	c9                   	leave  
  800eb3:	c3                   	ret    

00800eb4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800eb4:	55                   	push   %ebp
  800eb5:	89 e5                	mov    %esp,%ebp
  800eb7:	83 ec 04             	sub    $0x4,%esp
  800eba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ec0:	eb 0d                	jmp    800ecf <strfind+0x1b>
		if (*s == c)
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	8a 00                	mov    (%eax),%al
  800ec7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eca:	74 0e                	je     800eda <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ecc:	ff 45 08             	incl   0x8(%ebp)
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed2:	8a 00                	mov    (%eax),%al
  800ed4:	84 c0                	test   %al,%al
  800ed6:	75 ea                	jne    800ec2 <strfind+0xe>
  800ed8:	eb 01                	jmp    800edb <strfind+0x27>
		if (*s == c)
			break;
  800eda:	90                   	nop
	return (char *) s;
  800edb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ede:	c9                   	leave  
  800edf:	c3                   	ret    

00800ee0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ee0:	55                   	push   %ebp
  800ee1:	89 e5                	mov    %esp,%ebp
  800ee3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800eec:	8b 45 10             	mov    0x10(%ebp),%eax
  800eef:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ef2:	eb 0e                	jmp    800f02 <memset+0x22>
		*p++ = c;
  800ef4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef7:	8d 50 01             	lea    0x1(%eax),%edx
  800efa:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800efd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f00:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f02:	ff 4d f8             	decl   -0x8(%ebp)
  800f05:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f09:	79 e9                	jns    800ef4 <memset+0x14>
		*p++ = c;

	return v;
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0e:	c9                   	leave  
  800f0f:	c3                   	ret    

00800f10 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f10:	55                   	push   %ebp
  800f11:	89 e5                	mov    %esp,%ebp
  800f13:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f19:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f22:	eb 16                	jmp    800f3a <memcpy+0x2a>
		*d++ = *s++;
  800f24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f27:	8d 50 01             	lea    0x1(%eax),%edx
  800f2a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f2d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f30:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f33:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f36:	8a 12                	mov    (%edx),%dl
  800f38:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f40:	89 55 10             	mov    %edx,0x10(%ebp)
  800f43:	85 c0                	test   %eax,%eax
  800f45:	75 dd                	jne    800f24 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4a:	c9                   	leave  
  800f4b:	c3                   	ret    

00800f4c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f4c:	55                   	push   %ebp
  800f4d:	89 e5                	mov    %esp,%ebp
  800f4f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800f52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f61:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f64:	73 50                	jae    800fb6 <memmove+0x6a>
  800f66:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f69:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6c:	01 d0                	add    %edx,%eax
  800f6e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f71:	76 43                	jbe    800fb6 <memmove+0x6a>
		s += n;
  800f73:	8b 45 10             	mov    0x10(%ebp),%eax
  800f76:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f79:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f7f:	eb 10                	jmp    800f91 <memmove+0x45>
			*--d = *--s;
  800f81:	ff 4d f8             	decl   -0x8(%ebp)
  800f84:	ff 4d fc             	decl   -0x4(%ebp)
  800f87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f8a:	8a 10                	mov    (%eax),%dl
  800f8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f8f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f91:	8b 45 10             	mov    0x10(%ebp),%eax
  800f94:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f97:	89 55 10             	mov    %edx,0x10(%ebp)
  800f9a:	85 c0                	test   %eax,%eax
  800f9c:	75 e3                	jne    800f81 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f9e:	eb 23                	jmp    800fc3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fa0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa3:	8d 50 01             	lea    0x1(%eax),%edx
  800fa6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fa9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fac:	8d 4a 01             	lea    0x1(%edx),%ecx
  800faf:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fb2:	8a 12                	mov    (%edx),%dl
  800fb4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fbc:	89 55 10             	mov    %edx,0x10(%ebp)
  800fbf:	85 c0                	test   %eax,%eax
  800fc1:	75 dd                	jne    800fa0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc6:	c9                   	leave  
  800fc7:	c3                   	ret    

00800fc8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fc8:	55                   	push   %ebp
  800fc9:	89 e5                	mov    %esp,%ebp
  800fcb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fda:	eb 2a                	jmp    801006 <memcmp+0x3e>
		if (*s1 != *s2)
  800fdc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fdf:	8a 10                	mov    (%eax),%dl
  800fe1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe4:	8a 00                	mov    (%eax),%al
  800fe6:	38 c2                	cmp    %al,%dl
  800fe8:	74 16                	je     801000 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800fea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fed:	8a 00                	mov    (%eax),%al
  800fef:	0f b6 d0             	movzbl %al,%edx
  800ff2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff5:	8a 00                	mov    (%eax),%al
  800ff7:	0f b6 c0             	movzbl %al,%eax
  800ffa:	29 c2                	sub    %eax,%edx
  800ffc:	89 d0                	mov    %edx,%eax
  800ffe:	eb 18                	jmp    801018 <memcmp+0x50>
		s1++, s2++;
  801000:	ff 45 fc             	incl   -0x4(%ebp)
  801003:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801006:	8b 45 10             	mov    0x10(%ebp),%eax
  801009:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100c:	89 55 10             	mov    %edx,0x10(%ebp)
  80100f:	85 c0                	test   %eax,%eax
  801011:	75 c9                	jne    800fdc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801013:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801018:	c9                   	leave  
  801019:	c3                   	ret    

0080101a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80101a:	55                   	push   %ebp
  80101b:	89 e5                	mov    %esp,%ebp
  80101d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801020:	8b 55 08             	mov    0x8(%ebp),%edx
  801023:	8b 45 10             	mov    0x10(%ebp),%eax
  801026:	01 d0                	add    %edx,%eax
  801028:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80102b:	eb 15                	jmp    801042 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80102d:	8b 45 08             	mov    0x8(%ebp),%eax
  801030:	8a 00                	mov    (%eax),%al
  801032:	0f b6 d0             	movzbl %al,%edx
  801035:	8b 45 0c             	mov    0xc(%ebp),%eax
  801038:	0f b6 c0             	movzbl %al,%eax
  80103b:	39 c2                	cmp    %eax,%edx
  80103d:	74 0d                	je     80104c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80103f:	ff 45 08             	incl   0x8(%ebp)
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801048:	72 e3                	jb     80102d <memfind+0x13>
  80104a:	eb 01                	jmp    80104d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80104c:	90                   	nop
	return (void *) s;
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801050:	c9                   	leave  
  801051:	c3                   	ret    

00801052 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801052:	55                   	push   %ebp
  801053:	89 e5                	mov    %esp,%ebp
  801055:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801058:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80105f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801066:	eb 03                	jmp    80106b <strtol+0x19>
		s++;
  801068:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	8a 00                	mov    (%eax),%al
  801070:	3c 20                	cmp    $0x20,%al
  801072:	74 f4                	je     801068 <strtol+0x16>
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	8a 00                	mov    (%eax),%al
  801079:	3c 09                	cmp    $0x9,%al
  80107b:	74 eb                	je     801068 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
  801080:	8a 00                	mov    (%eax),%al
  801082:	3c 2b                	cmp    $0x2b,%al
  801084:	75 05                	jne    80108b <strtol+0x39>
		s++;
  801086:	ff 45 08             	incl   0x8(%ebp)
  801089:	eb 13                	jmp    80109e <strtol+0x4c>
	else if (*s == '-')
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	8a 00                	mov    (%eax),%al
  801090:	3c 2d                	cmp    $0x2d,%al
  801092:	75 0a                	jne    80109e <strtol+0x4c>
		s++, neg = 1;
  801094:	ff 45 08             	incl   0x8(%ebp)
  801097:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80109e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010a2:	74 06                	je     8010aa <strtol+0x58>
  8010a4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010a8:	75 20                	jne    8010ca <strtol+0x78>
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	8a 00                	mov    (%eax),%al
  8010af:	3c 30                	cmp    $0x30,%al
  8010b1:	75 17                	jne    8010ca <strtol+0x78>
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	40                   	inc    %eax
  8010b7:	8a 00                	mov    (%eax),%al
  8010b9:	3c 78                	cmp    $0x78,%al
  8010bb:	75 0d                	jne    8010ca <strtol+0x78>
		s += 2, base = 16;
  8010bd:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010c1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010c8:	eb 28                	jmp    8010f2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ce:	75 15                	jne    8010e5 <strtol+0x93>
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	3c 30                	cmp    $0x30,%al
  8010d7:	75 0c                	jne    8010e5 <strtol+0x93>
		s++, base = 8;
  8010d9:	ff 45 08             	incl   0x8(%ebp)
  8010dc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010e3:	eb 0d                	jmp    8010f2 <strtol+0xa0>
	else if (base == 0)
  8010e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e9:	75 07                	jne    8010f2 <strtol+0xa0>
		base = 10;
  8010eb:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f5:	8a 00                	mov    (%eax),%al
  8010f7:	3c 2f                	cmp    $0x2f,%al
  8010f9:	7e 19                	jle    801114 <strtol+0xc2>
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	8a 00                	mov    (%eax),%al
  801100:	3c 39                	cmp    $0x39,%al
  801102:	7f 10                	jg     801114 <strtol+0xc2>
			dig = *s - '0';
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	8a 00                	mov    (%eax),%al
  801109:	0f be c0             	movsbl %al,%eax
  80110c:	83 e8 30             	sub    $0x30,%eax
  80110f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801112:	eb 42                	jmp    801156 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	3c 60                	cmp    $0x60,%al
  80111b:	7e 19                	jle    801136 <strtol+0xe4>
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8a 00                	mov    (%eax),%al
  801122:	3c 7a                	cmp    $0x7a,%al
  801124:	7f 10                	jg     801136 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	8a 00                	mov    (%eax),%al
  80112b:	0f be c0             	movsbl %al,%eax
  80112e:	83 e8 57             	sub    $0x57,%eax
  801131:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801134:	eb 20                	jmp    801156 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801136:	8b 45 08             	mov    0x8(%ebp),%eax
  801139:	8a 00                	mov    (%eax),%al
  80113b:	3c 40                	cmp    $0x40,%al
  80113d:	7e 39                	jle    801178 <strtol+0x126>
  80113f:	8b 45 08             	mov    0x8(%ebp),%eax
  801142:	8a 00                	mov    (%eax),%al
  801144:	3c 5a                	cmp    $0x5a,%al
  801146:	7f 30                	jg     801178 <strtol+0x126>
			dig = *s - 'A' + 10;
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	0f be c0             	movsbl %al,%eax
  801150:	83 e8 37             	sub    $0x37,%eax
  801153:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801156:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801159:	3b 45 10             	cmp    0x10(%ebp),%eax
  80115c:	7d 19                	jge    801177 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80115e:	ff 45 08             	incl   0x8(%ebp)
  801161:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801164:	0f af 45 10          	imul   0x10(%ebp),%eax
  801168:	89 c2                	mov    %eax,%edx
  80116a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80116d:	01 d0                	add    %edx,%eax
  80116f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801172:	e9 7b ff ff ff       	jmp    8010f2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801177:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801178:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80117c:	74 08                	je     801186 <strtol+0x134>
		*endptr = (char *) s;
  80117e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801181:	8b 55 08             	mov    0x8(%ebp),%edx
  801184:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801186:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80118a:	74 07                	je     801193 <strtol+0x141>
  80118c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80118f:	f7 d8                	neg    %eax
  801191:	eb 03                	jmp    801196 <strtol+0x144>
  801193:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801196:	c9                   	leave  
  801197:	c3                   	ret    

00801198 <ltostr>:

void
ltostr(long value, char *str)
{
  801198:	55                   	push   %ebp
  801199:	89 e5                	mov    %esp,%ebp
  80119b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80119e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011a5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011ac:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011b0:	79 13                	jns    8011c5 <ltostr+0x2d>
	{
		neg = 1;
  8011b2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bc:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011bf:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011c2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011cd:	99                   	cltd   
  8011ce:	f7 f9                	idiv   %ecx
  8011d0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d6:	8d 50 01             	lea    0x1(%eax),%edx
  8011d9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011dc:	89 c2                	mov    %eax,%edx
  8011de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e1:	01 d0                	add    %edx,%eax
  8011e3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011e6:	83 c2 30             	add    $0x30,%edx
  8011e9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011ee:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011f3:	f7 e9                	imul   %ecx
  8011f5:	c1 fa 02             	sar    $0x2,%edx
  8011f8:	89 c8                	mov    %ecx,%eax
  8011fa:	c1 f8 1f             	sar    $0x1f,%eax
  8011fd:	29 c2                	sub    %eax,%edx
  8011ff:	89 d0                	mov    %edx,%eax
  801201:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801204:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801207:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80120c:	f7 e9                	imul   %ecx
  80120e:	c1 fa 02             	sar    $0x2,%edx
  801211:	89 c8                	mov    %ecx,%eax
  801213:	c1 f8 1f             	sar    $0x1f,%eax
  801216:	29 c2                	sub    %eax,%edx
  801218:	89 d0                	mov    %edx,%eax
  80121a:	c1 e0 02             	shl    $0x2,%eax
  80121d:	01 d0                	add    %edx,%eax
  80121f:	01 c0                	add    %eax,%eax
  801221:	29 c1                	sub    %eax,%ecx
  801223:	89 ca                	mov    %ecx,%edx
  801225:	85 d2                	test   %edx,%edx
  801227:	75 9c                	jne    8011c5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801229:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801230:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801233:	48                   	dec    %eax
  801234:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801237:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80123b:	74 3d                	je     80127a <ltostr+0xe2>
		start = 1 ;
  80123d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801244:	eb 34                	jmp    80127a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801246:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801249:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124c:	01 d0                	add    %edx,%eax
  80124e:	8a 00                	mov    (%eax),%al
  801250:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801253:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801256:	8b 45 0c             	mov    0xc(%ebp),%eax
  801259:	01 c2                	add    %eax,%edx
  80125b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80125e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801261:	01 c8                	add    %ecx,%eax
  801263:	8a 00                	mov    (%eax),%al
  801265:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801267:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80126a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126d:	01 c2                	add    %eax,%edx
  80126f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801272:	88 02                	mov    %al,(%edx)
		start++ ;
  801274:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801277:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80127a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80127d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801280:	7c c4                	jl     801246 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801282:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801285:	8b 45 0c             	mov    0xc(%ebp),%eax
  801288:	01 d0                	add    %edx,%eax
  80128a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80128d:	90                   	nop
  80128e:	c9                   	leave  
  80128f:	c3                   	ret    

00801290 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801290:	55                   	push   %ebp
  801291:	89 e5                	mov    %esp,%ebp
  801293:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801296:	ff 75 08             	pushl  0x8(%ebp)
  801299:	e8 54 fa ff ff       	call   800cf2 <strlen>
  80129e:	83 c4 04             	add    $0x4,%esp
  8012a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012a4:	ff 75 0c             	pushl  0xc(%ebp)
  8012a7:	e8 46 fa ff ff       	call   800cf2 <strlen>
  8012ac:	83 c4 04             	add    $0x4,%esp
  8012af:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012c0:	eb 17                	jmp    8012d9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c8:	01 c2                	add    %eax,%edx
  8012ca:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	01 c8                	add    %ecx,%eax
  8012d2:	8a 00                	mov    (%eax),%al
  8012d4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012d6:	ff 45 fc             	incl   -0x4(%ebp)
  8012d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012df:	7c e1                	jl     8012c2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012e1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012ef:	eb 1f                	jmp    801310 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f4:	8d 50 01             	lea    0x1(%eax),%edx
  8012f7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012fa:	89 c2                	mov    %eax,%edx
  8012fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ff:	01 c2                	add    %eax,%edx
  801301:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801304:	8b 45 0c             	mov    0xc(%ebp),%eax
  801307:	01 c8                	add    %ecx,%eax
  801309:	8a 00                	mov    (%eax),%al
  80130b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80130d:	ff 45 f8             	incl   -0x8(%ebp)
  801310:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801313:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801316:	7c d9                	jl     8012f1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801318:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80131b:	8b 45 10             	mov    0x10(%ebp),%eax
  80131e:	01 d0                	add    %edx,%eax
  801320:	c6 00 00             	movb   $0x0,(%eax)
}
  801323:	90                   	nop
  801324:	c9                   	leave  
  801325:	c3                   	ret    

00801326 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801326:	55                   	push   %ebp
  801327:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801329:	8b 45 14             	mov    0x14(%ebp),%eax
  80132c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801332:	8b 45 14             	mov    0x14(%ebp),%eax
  801335:	8b 00                	mov    (%eax),%eax
  801337:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80133e:	8b 45 10             	mov    0x10(%ebp),%eax
  801341:	01 d0                	add    %edx,%eax
  801343:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801349:	eb 0c                	jmp    801357 <strsplit+0x31>
			*string++ = 0;
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
  80134e:	8d 50 01             	lea    0x1(%eax),%edx
  801351:	89 55 08             	mov    %edx,0x8(%ebp)
  801354:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	8a 00                	mov    (%eax),%al
  80135c:	84 c0                	test   %al,%al
  80135e:	74 18                	je     801378 <strsplit+0x52>
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	8a 00                	mov    (%eax),%al
  801365:	0f be c0             	movsbl %al,%eax
  801368:	50                   	push   %eax
  801369:	ff 75 0c             	pushl  0xc(%ebp)
  80136c:	e8 13 fb ff ff       	call   800e84 <strchr>
  801371:	83 c4 08             	add    $0x8,%esp
  801374:	85 c0                	test   %eax,%eax
  801376:	75 d3                	jne    80134b <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	8a 00                	mov    (%eax),%al
  80137d:	84 c0                	test   %al,%al
  80137f:	74 5a                	je     8013db <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801381:	8b 45 14             	mov    0x14(%ebp),%eax
  801384:	8b 00                	mov    (%eax),%eax
  801386:	83 f8 0f             	cmp    $0xf,%eax
  801389:	75 07                	jne    801392 <strsplit+0x6c>
		{
			return 0;
  80138b:	b8 00 00 00 00       	mov    $0x0,%eax
  801390:	eb 66                	jmp    8013f8 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801392:	8b 45 14             	mov    0x14(%ebp),%eax
  801395:	8b 00                	mov    (%eax),%eax
  801397:	8d 48 01             	lea    0x1(%eax),%ecx
  80139a:	8b 55 14             	mov    0x14(%ebp),%edx
  80139d:	89 0a                	mov    %ecx,(%edx)
  80139f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a9:	01 c2                	add    %eax,%edx
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013b0:	eb 03                	jmp    8013b5 <strsplit+0x8f>
			string++;
  8013b2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b8:	8a 00                	mov    (%eax),%al
  8013ba:	84 c0                	test   %al,%al
  8013bc:	74 8b                	je     801349 <strsplit+0x23>
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	8a 00                	mov    (%eax),%al
  8013c3:	0f be c0             	movsbl %al,%eax
  8013c6:	50                   	push   %eax
  8013c7:	ff 75 0c             	pushl  0xc(%ebp)
  8013ca:	e8 b5 fa ff ff       	call   800e84 <strchr>
  8013cf:	83 c4 08             	add    $0x8,%esp
  8013d2:	85 c0                	test   %eax,%eax
  8013d4:	74 dc                	je     8013b2 <strsplit+0x8c>
			string++;
	}
  8013d6:	e9 6e ff ff ff       	jmp    801349 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013db:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013df:	8b 00                	mov    (%eax),%eax
  8013e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013eb:	01 d0                	add    %edx,%eax
  8013ed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013f3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013f8:	c9                   	leave  
  8013f9:	c3                   	ret    

008013fa <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8013fa:	55                   	push   %ebp
  8013fb:	89 e5                	mov    %esp,%ebp
  8013fd:	57                   	push   %edi
  8013fe:	56                   	push   %esi
  8013ff:	53                   	push   %ebx
  801400:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	8b 55 0c             	mov    0xc(%ebp),%edx
  801409:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80140c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80140f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801412:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801415:	cd 30                	int    $0x30
  801417:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80141a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80141d:	83 c4 10             	add    $0x10,%esp
  801420:	5b                   	pop    %ebx
  801421:	5e                   	pop    %esi
  801422:	5f                   	pop    %edi
  801423:	5d                   	pop    %ebp
  801424:	c3                   	ret    

00801425 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801425:	55                   	push   %ebp
  801426:	89 e5                	mov    %esp,%ebp
  801428:	83 ec 04             	sub    $0x4,%esp
  80142b:	8b 45 10             	mov    0x10(%ebp),%eax
  80142e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801431:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	52                   	push   %edx
  80143d:	ff 75 0c             	pushl  0xc(%ebp)
  801440:	50                   	push   %eax
  801441:	6a 00                	push   $0x0
  801443:	e8 b2 ff ff ff       	call   8013fa <syscall>
  801448:	83 c4 18             	add    $0x18,%esp
}
  80144b:	90                   	nop
  80144c:	c9                   	leave  
  80144d:	c3                   	ret    

0080144e <sys_cgetc>:

int
sys_cgetc(void)
{
  80144e:	55                   	push   %ebp
  80144f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	6a 01                	push   $0x1
  80145d:	e8 98 ff ff ff       	call   8013fa <syscall>
  801462:	83 c4 18             	add    $0x18,%esp
}
  801465:	c9                   	leave  
  801466:	c3                   	ret    

00801467 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801467:	55                   	push   %ebp
  801468:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	50                   	push   %eax
  801476:	6a 05                	push   $0x5
  801478:	e8 7d ff ff ff       	call   8013fa <syscall>
  80147d:	83 c4 18             	add    $0x18,%esp
}
  801480:	c9                   	leave  
  801481:	c3                   	ret    

00801482 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801482:	55                   	push   %ebp
  801483:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801485:	6a 00                	push   $0x0
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 02                	push   $0x2
  801491:	e8 64 ff ff ff       	call   8013fa <syscall>
  801496:	83 c4 18             	add    $0x18,%esp
}
  801499:	c9                   	leave  
  80149a:	c3                   	ret    

0080149b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80149b:	55                   	push   %ebp
  80149c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 03                	push   $0x3
  8014aa:	e8 4b ff ff ff       	call   8013fa <syscall>
  8014af:	83 c4 18             	add    $0x18,%esp
}
  8014b2:	c9                   	leave  
  8014b3:	c3                   	ret    

008014b4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014b4:	55                   	push   %ebp
  8014b5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 04                	push   $0x4
  8014c3:	e8 32 ff ff ff       	call   8013fa <syscall>
  8014c8:	83 c4 18             	add    $0x18,%esp
}
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <sys_env_exit>:


void sys_env_exit(void)
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 06                	push   $0x6
  8014dc:	e8 19 ff ff ff       	call   8013fa <syscall>
  8014e1:	83 c4 18             	add    $0x18,%esp
}
  8014e4:	90                   	nop
  8014e5:	c9                   	leave  
  8014e6:	c3                   	ret    

008014e7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8014e7:	55                   	push   %ebp
  8014e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8014ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	52                   	push   %edx
  8014f7:	50                   	push   %eax
  8014f8:	6a 07                	push   $0x7
  8014fa:	e8 fb fe ff ff       	call   8013fa <syscall>
  8014ff:	83 c4 18             	add    $0x18,%esp
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
  801507:	56                   	push   %esi
  801508:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801509:	8b 75 18             	mov    0x18(%ebp),%esi
  80150c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80150f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801512:	8b 55 0c             	mov    0xc(%ebp),%edx
  801515:	8b 45 08             	mov    0x8(%ebp),%eax
  801518:	56                   	push   %esi
  801519:	53                   	push   %ebx
  80151a:	51                   	push   %ecx
  80151b:	52                   	push   %edx
  80151c:	50                   	push   %eax
  80151d:	6a 08                	push   $0x8
  80151f:	e8 d6 fe ff ff       	call   8013fa <syscall>
  801524:	83 c4 18             	add    $0x18,%esp
}
  801527:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80152a:	5b                   	pop    %ebx
  80152b:	5e                   	pop    %esi
  80152c:	5d                   	pop    %ebp
  80152d:	c3                   	ret    

0080152e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801531:	8b 55 0c             	mov    0xc(%ebp),%edx
  801534:	8b 45 08             	mov    0x8(%ebp),%eax
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	52                   	push   %edx
  80153e:	50                   	push   %eax
  80153f:	6a 09                	push   $0x9
  801541:	e8 b4 fe ff ff       	call   8013fa <syscall>
  801546:	83 c4 18             	add    $0x18,%esp
}
  801549:	c9                   	leave  
  80154a:	c3                   	ret    

0080154b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80154b:	55                   	push   %ebp
  80154c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	ff 75 0c             	pushl  0xc(%ebp)
  801557:	ff 75 08             	pushl  0x8(%ebp)
  80155a:	6a 0a                	push   $0xa
  80155c:	e8 99 fe ff ff       	call   8013fa <syscall>
  801561:	83 c4 18             	add    $0x18,%esp
}
  801564:	c9                   	leave  
  801565:	c3                   	ret    

00801566 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801566:	55                   	push   %ebp
  801567:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 0b                	push   $0xb
  801575:	e8 80 fe ff ff       	call   8013fa <syscall>
  80157a:	83 c4 18             	add    $0x18,%esp
}
  80157d:	c9                   	leave  
  80157e:	c3                   	ret    

0080157f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80157f:	55                   	push   %ebp
  801580:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	6a 0c                	push   $0xc
  80158e:	e8 67 fe ff ff       	call   8013fa <syscall>
  801593:	83 c4 18             	add    $0x18,%esp
}
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 0d                	push   $0xd
  8015a7:	e8 4e fe ff ff       	call   8013fa <syscall>
  8015ac:	83 c4 18             	add    $0x18,%esp
}
  8015af:	c9                   	leave  
  8015b0:	c3                   	ret    

008015b1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015b1:	55                   	push   %ebp
  8015b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	ff 75 0c             	pushl  0xc(%ebp)
  8015bd:	ff 75 08             	pushl  0x8(%ebp)
  8015c0:	6a 11                	push   $0x11
  8015c2:	e8 33 fe ff ff       	call   8013fa <syscall>
  8015c7:	83 c4 18             	add    $0x18,%esp
	return;
  8015ca:	90                   	nop
}
  8015cb:	c9                   	leave  
  8015cc:	c3                   	ret    

008015cd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015cd:	55                   	push   %ebp
  8015ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	ff 75 0c             	pushl  0xc(%ebp)
  8015d9:	ff 75 08             	pushl  0x8(%ebp)
  8015dc:	6a 12                	push   $0x12
  8015de:	e8 17 fe ff ff       	call   8013fa <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8015e6:	90                   	nop
}
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 0e                	push   $0xe
  8015f8:	e8 fd fd ff ff       	call   8013fa <syscall>
  8015fd:	83 c4 18             	add    $0x18,%esp
}
  801600:	c9                   	leave  
  801601:	c3                   	ret    

00801602 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801602:	55                   	push   %ebp
  801603:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	ff 75 08             	pushl  0x8(%ebp)
  801610:	6a 0f                	push   $0xf
  801612:	e8 e3 fd ff ff       	call   8013fa <syscall>
  801617:	83 c4 18             	add    $0x18,%esp
}
  80161a:	c9                   	leave  
  80161b:	c3                   	ret    

0080161c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80161c:	55                   	push   %ebp
  80161d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80161f:	6a 00                	push   $0x0
  801621:	6a 00                	push   $0x0
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 10                	push   $0x10
  80162b:	e8 ca fd ff ff       	call   8013fa <syscall>
  801630:	83 c4 18             	add    $0x18,%esp
}
  801633:	90                   	nop
  801634:	c9                   	leave  
  801635:	c3                   	ret    

00801636 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801636:	55                   	push   %ebp
  801637:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 14                	push   $0x14
  801645:	e8 b0 fd ff ff       	call   8013fa <syscall>
  80164a:	83 c4 18             	add    $0x18,%esp
}
  80164d:	90                   	nop
  80164e:	c9                   	leave  
  80164f:	c3                   	ret    

00801650 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801650:	55                   	push   %ebp
  801651:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 15                	push   $0x15
  80165f:	e8 96 fd ff ff       	call   8013fa <syscall>
  801664:	83 c4 18             	add    $0x18,%esp
}
  801667:	90                   	nop
  801668:	c9                   	leave  
  801669:	c3                   	ret    

0080166a <sys_cputc>:


void
sys_cputc(const char c)
{
  80166a:	55                   	push   %ebp
  80166b:	89 e5                	mov    %esp,%ebp
  80166d:	83 ec 04             	sub    $0x4,%esp
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801676:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	50                   	push   %eax
  801683:	6a 16                	push   $0x16
  801685:	e8 70 fd ff ff       	call   8013fa <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
}
  80168d:	90                   	nop
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 17                	push   $0x17
  80169f:	e8 56 fd ff ff       	call   8013fa <syscall>
  8016a4:	83 c4 18             	add    $0x18,%esp
}
  8016a7:	90                   	nop
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	ff 75 0c             	pushl  0xc(%ebp)
  8016b9:	50                   	push   %eax
  8016ba:	6a 18                	push   $0x18
  8016bc:	e8 39 fd ff ff       	call   8013fa <syscall>
  8016c1:	83 c4 18             	add    $0x18,%esp
}
  8016c4:	c9                   	leave  
  8016c5:	c3                   	ret    

008016c6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	52                   	push   %edx
  8016d6:	50                   	push   %eax
  8016d7:	6a 1b                	push   $0x1b
  8016d9:	e8 1c fd ff ff       	call   8013fa <syscall>
  8016de:	83 c4 18             	add    $0x18,%esp
}
  8016e1:	c9                   	leave  
  8016e2:	c3                   	ret    

008016e3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8016e3:	55                   	push   %ebp
  8016e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	52                   	push   %edx
  8016f3:	50                   	push   %eax
  8016f4:	6a 19                	push   $0x19
  8016f6:	e8 ff fc ff ff       	call   8013fa <syscall>
  8016fb:	83 c4 18             	add    $0x18,%esp
}
  8016fe:	90                   	nop
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801704:	8b 55 0c             	mov    0xc(%ebp),%edx
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	52                   	push   %edx
  801711:	50                   	push   %eax
  801712:	6a 1a                	push   $0x1a
  801714:	e8 e1 fc ff ff       	call   8013fa <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
}
  80171c:	90                   	nop
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
  801722:	83 ec 04             	sub    $0x4,%esp
  801725:	8b 45 10             	mov    0x10(%ebp),%eax
  801728:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80172b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80172e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801732:	8b 45 08             	mov    0x8(%ebp),%eax
  801735:	6a 00                	push   $0x0
  801737:	51                   	push   %ecx
  801738:	52                   	push   %edx
  801739:	ff 75 0c             	pushl  0xc(%ebp)
  80173c:	50                   	push   %eax
  80173d:	6a 1c                	push   $0x1c
  80173f:	e8 b6 fc ff ff       	call   8013fa <syscall>
  801744:	83 c4 18             	add    $0x18,%esp
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80174c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80174f:	8b 45 08             	mov    0x8(%ebp),%eax
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	52                   	push   %edx
  801759:	50                   	push   %eax
  80175a:	6a 1d                	push   $0x1d
  80175c:	e8 99 fc ff ff       	call   8013fa <syscall>
  801761:	83 c4 18             	add    $0x18,%esp
}
  801764:	c9                   	leave  
  801765:	c3                   	ret    

00801766 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801766:	55                   	push   %ebp
  801767:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801769:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80176c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80176f:	8b 45 08             	mov    0x8(%ebp),%eax
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	51                   	push   %ecx
  801777:	52                   	push   %edx
  801778:	50                   	push   %eax
  801779:	6a 1e                	push   $0x1e
  80177b:	e8 7a fc ff ff       	call   8013fa <syscall>
  801780:	83 c4 18             	add    $0x18,%esp
}
  801783:	c9                   	leave  
  801784:	c3                   	ret    

00801785 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801788:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178b:	8b 45 08             	mov    0x8(%ebp),%eax
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	52                   	push   %edx
  801795:	50                   	push   %eax
  801796:	6a 1f                	push   $0x1f
  801798:	e8 5d fc ff ff       	call   8013fa <syscall>
  80179d:	83 c4 18             	add    $0x18,%esp
}
  8017a0:	c9                   	leave  
  8017a1:	c3                   	ret    

008017a2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017a2:	55                   	push   %ebp
  8017a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 20                	push   $0x20
  8017b1:	e8 44 fc ff ff       	call   8013fa <syscall>
  8017b6:	83 c4 18             	add    $0x18,%esp
}
  8017b9:	c9                   	leave  
  8017ba:	c3                   	ret    

008017bb <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8017bb:	55                   	push   %ebp
  8017bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8017be:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	ff 75 10             	pushl  0x10(%ebp)
  8017c8:	ff 75 0c             	pushl  0xc(%ebp)
  8017cb:	50                   	push   %eax
  8017cc:	6a 21                	push   $0x21
  8017ce:	e8 27 fc ff ff       	call   8013fa <syscall>
  8017d3:	83 c4 18             	add    $0x18,%esp
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017db:	8b 45 08             	mov    0x8(%ebp),%eax
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	50                   	push   %eax
  8017e7:	6a 22                	push   $0x22
  8017e9:	e8 0c fc ff ff       	call   8013fa <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
}
  8017f1:	90                   	nop
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8017f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	50                   	push   %eax
  801803:	6a 23                	push   $0x23
  801805:	e8 f0 fb ff ff       	call   8013fa <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
}
  80180d:	90                   	nop
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
  801813:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801816:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801819:	8d 50 04             	lea    0x4(%eax),%edx
  80181c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	52                   	push   %edx
  801826:	50                   	push   %eax
  801827:	6a 24                	push   $0x24
  801829:	e8 cc fb ff ff       	call   8013fa <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
	return result;
  801831:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801834:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801837:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80183a:	89 01                	mov    %eax,(%ecx)
  80183c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80183f:	8b 45 08             	mov    0x8(%ebp),%eax
  801842:	c9                   	leave  
  801843:	c2 04 00             	ret    $0x4

00801846 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	ff 75 10             	pushl  0x10(%ebp)
  801850:	ff 75 0c             	pushl  0xc(%ebp)
  801853:	ff 75 08             	pushl  0x8(%ebp)
  801856:	6a 13                	push   $0x13
  801858:	e8 9d fb ff ff       	call   8013fa <syscall>
  80185d:	83 c4 18             	add    $0x18,%esp
	return ;
  801860:	90                   	nop
}
  801861:	c9                   	leave  
  801862:	c3                   	ret    

00801863 <sys_rcr2>:
uint32 sys_rcr2()
{
  801863:	55                   	push   %ebp
  801864:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 25                	push   $0x25
  801872:	e8 83 fb ff ff       	call   8013fa <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
}
  80187a:	c9                   	leave  
  80187b:	c3                   	ret    

0080187c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80187c:	55                   	push   %ebp
  80187d:	89 e5                	mov    %esp,%ebp
  80187f:	83 ec 04             	sub    $0x4,%esp
  801882:	8b 45 08             	mov    0x8(%ebp),%eax
  801885:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801888:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	50                   	push   %eax
  801895:	6a 26                	push   $0x26
  801897:	e8 5e fb ff ff       	call   8013fa <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
	return ;
  80189f:	90                   	nop
}
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <rsttst>:
void rsttst()
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 28                	push   $0x28
  8018b1:	e8 44 fb ff ff       	call   8013fa <syscall>
  8018b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8018b9:	90                   	nop
}
  8018ba:	c9                   	leave  
  8018bb:	c3                   	ret    

008018bc <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018bc:	55                   	push   %ebp
  8018bd:	89 e5                	mov    %esp,%ebp
  8018bf:	83 ec 04             	sub    $0x4,%esp
  8018c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018c8:	8b 55 18             	mov    0x18(%ebp),%edx
  8018cb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018cf:	52                   	push   %edx
  8018d0:	50                   	push   %eax
  8018d1:	ff 75 10             	pushl  0x10(%ebp)
  8018d4:	ff 75 0c             	pushl  0xc(%ebp)
  8018d7:	ff 75 08             	pushl  0x8(%ebp)
  8018da:	6a 27                	push   $0x27
  8018dc:	e8 19 fb ff ff       	call   8013fa <syscall>
  8018e1:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e4:	90                   	nop
}
  8018e5:	c9                   	leave  
  8018e6:	c3                   	ret    

008018e7 <chktst>:
void chktst(uint32 n)
{
  8018e7:	55                   	push   %ebp
  8018e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	ff 75 08             	pushl  0x8(%ebp)
  8018f5:	6a 29                	push   $0x29
  8018f7:	e8 fe fa ff ff       	call   8013fa <syscall>
  8018fc:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ff:	90                   	nop
}
  801900:	c9                   	leave  
  801901:	c3                   	ret    

00801902 <inctst>:

void inctst()
{
  801902:	55                   	push   %ebp
  801903:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 2a                	push   $0x2a
  801911:	e8 e4 fa ff ff       	call   8013fa <syscall>
  801916:	83 c4 18             	add    $0x18,%esp
	return ;
  801919:	90                   	nop
}
  80191a:	c9                   	leave  
  80191b:	c3                   	ret    

0080191c <gettst>:
uint32 gettst()
{
  80191c:	55                   	push   %ebp
  80191d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 2b                	push   $0x2b
  80192b:	e8 ca fa ff ff       	call   8013fa <syscall>
  801930:	83 c4 18             	add    $0x18,%esp
}
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
  801938:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 2c                	push   $0x2c
  801947:	e8 ae fa ff ff       	call   8013fa <syscall>
  80194c:	83 c4 18             	add    $0x18,%esp
  80194f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801952:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801956:	75 07                	jne    80195f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801958:	b8 01 00 00 00       	mov    $0x1,%eax
  80195d:	eb 05                	jmp    801964 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80195f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
  801969:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 2c                	push   $0x2c
  801978:	e8 7d fa ff ff       	call   8013fa <syscall>
  80197d:	83 c4 18             	add    $0x18,%esp
  801980:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801983:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801987:	75 07                	jne    801990 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801989:	b8 01 00 00 00       	mov    $0x1,%eax
  80198e:	eb 05                	jmp    801995 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801990:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801995:	c9                   	leave  
  801996:	c3                   	ret    

00801997 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801997:	55                   	push   %ebp
  801998:	89 e5                	mov    %esp,%ebp
  80199a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 2c                	push   $0x2c
  8019a9:	e8 4c fa ff ff       	call   8013fa <syscall>
  8019ae:	83 c4 18             	add    $0x18,%esp
  8019b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019b4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019b8:	75 07                	jne    8019c1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8019bf:	eb 05                	jmp    8019c6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
  8019cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 2c                	push   $0x2c
  8019da:	e8 1b fa ff ff       	call   8013fa <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
  8019e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8019e5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8019e9:	75 07                	jne    8019f2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8019eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8019f0:	eb 05                	jmp    8019f7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8019f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019f7:	c9                   	leave  
  8019f8:	c3                   	ret    

008019f9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8019f9:	55                   	push   %ebp
  8019fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	ff 75 08             	pushl  0x8(%ebp)
  801a07:	6a 2d                	push   $0x2d
  801a09:	e8 ec f9 ff ff       	call   8013fa <syscall>
  801a0e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a11:	90                   	nop
}
  801a12:	c9                   	leave  
  801a13:	c3                   	ret    

00801a14 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801a14:	55                   	push   %ebp
  801a15:	89 e5                	mov    %esp,%ebp
  801a17:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801a1a:	8b 55 08             	mov    0x8(%ebp),%edx
  801a1d:	89 d0                	mov    %edx,%eax
  801a1f:	c1 e0 02             	shl    $0x2,%eax
  801a22:	01 d0                	add    %edx,%eax
  801a24:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a2b:	01 d0                	add    %edx,%eax
  801a2d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a34:	01 d0                	add    %edx,%eax
  801a36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a3d:	01 d0                	add    %edx,%eax
  801a3f:	c1 e0 04             	shl    $0x4,%eax
  801a42:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801a45:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801a4c:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801a4f:	83 ec 0c             	sub    $0xc,%esp
  801a52:	50                   	push   %eax
  801a53:	e8 b8 fd ff ff       	call   801810 <sys_get_virtual_time>
  801a58:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801a5b:	eb 41                	jmp    801a9e <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801a5d:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801a60:	83 ec 0c             	sub    $0xc,%esp
  801a63:	50                   	push   %eax
  801a64:	e8 a7 fd ff ff       	call   801810 <sys_get_virtual_time>
  801a69:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801a6c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a72:	29 c2                	sub    %eax,%edx
  801a74:	89 d0                	mov    %edx,%eax
  801a76:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801a79:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a7f:	89 d1                	mov    %edx,%ecx
  801a81:	29 c1                	sub    %eax,%ecx
  801a83:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a86:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a89:	39 c2                	cmp    %eax,%edx
  801a8b:	0f 97 c0             	seta   %al
  801a8e:	0f b6 c0             	movzbl %al,%eax
  801a91:	29 c1                	sub    %eax,%ecx
  801a93:	89 c8                	mov    %ecx,%eax
  801a95:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801a98:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801aa1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801aa4:	72 b7                	jb     801a5d <env_sleep+0x49>
//				,cycles_counter
//				);
	}
//	cprintf("%s wake up now!\n", myEnv->prog_name);

}
  801aa6:	90                   	nop
  801aa7:	c9                   	leave  
  801aa8:	c3                   	ret    

00801aa9 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801aa9:	55                   	push   %ebp
  801aaa:	89 e5                	mov    %esp,%ebp
  801aac:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801aaf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801ab6:	eb 03                	jmp    801abb <busy_wait+0x12>
  801ab8:	ff 45 fc             	incl   -0x4(%ebp)
  801abb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801abe:	3b 45 08             	cmp    0x8(%ebp),%eax
  801ac1:	72 f5                	jb     801ab8 <busy_wait+0xf>
	return i;
  801ac3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <__udivdi3>:
  801ac8:	55                   	push   %ebp
  801ac9:	57                   	push   %edi
  801aca:	56                   	push   %esi
  801acb:	53                   	push   %ebx
  801acc:	83 ec 1c             	sub    $0x1c,%esp
  801acf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ad3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ad7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801adb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801adf:	89 ca                	mov    %ecx,%edx
  801ae1:	89 f8                	mov    %edi,%eax
  801ae3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ae7:	85 f6                	test   %esi,%esi
  801ae9:	75 2d                	jne    801b18 <__udivdi3+0x50>
  801aeb:	39 cf                	cmp    %ecx,%edi
  801aed:	77 65                	ja     801b54 <__udivdi3+0x8c>
  801aef:	89 fd                	mov    %edi,%ebp
  801af1:	85 ff                	test   %edi,%edi
  801af3:	75 0b                	jne    801b00 <__udivdi3+0x38>
  801af5:	b8 01 00 00 00       	mov    $0x1,%eax
  801afa:	31 d2                	xor    %edx,%edx
  801afc:	f7 f7                	div    %edi
  801afe:	89 c5                	mov    %eax,%ebp
  801b00:	31 d2                	xor    %edx,%edx
  801b02:	89 c8                	mov    %ecx,%eax
  801b04:	f7 f5                	div    %ebp
  801b06:	89 c1                	mov    %eax,%ecx
  801b08:	89 d8                	mov    %ebx,%eax
  801b0a:	f7 f5                	div    %ebp
  801b0c:	89 cf                	mov    %ecx,%edi
  801b0e:	89 fa                	mov    %edi,%edx
  801b10:	83 c4 1c             	add    $0x1c,%esp
  801b13:	5b                   	pop    %ebx
  801b14:	5e                   	pop    %esi
  801b15:	5f                   	pop    %edi
  801b16:	5d                   	pop    %ebp
  801b17:	c3                   	ret    
  801b18:	39 ce                	cmp    %ecx,%esi
  801b1a:	77 28                	ja     801b44 <__udivdi3+0x7c>
  801b1c:	0f bd fe             	bsr    %esi,%edi
  801b1f:	83 f7 1f             	xor    $0x1f,%edi
  801b22:	75 40                	jne    801b64 <__udivdi3+0x9c>
  801b24:	39 ce                	cmp    %ecx,%esi
  801b26:	72 0a                	jb     801b32 <__udivdi3+0x6a>
  801b28:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b2c:	0f 87 9e 00 00 00    	ja     801bd0 <__udivdi3+0x108>
  801b32:	b8 01 00 00 00       	mov    $0x1,%eax
  801b37:	89 fa                	mov    %edi,%edx
  801b39:	83 c4 1c             	add    $0x1c,%esp
  801b3c:	5b                   	pop    %ebx
  801b3d:	5e                   	pop    %esi
  801b3e:	5f                   	pop    %edi
  801b3f:	5d                   	pop    %ebp
  801b40:	c3                   	ret    
  801b41:	8d 76 00             	lea    0x0(%esi),%esi
  801b44:	31 ff                	xor    %edi,%edi
  801b46:	31 c0                	xor    %eax,%eax
  801b48:	89 fa                	mov    %edi,%edx
  801b4a:	83 c4 1c             	add    $0x1c,%esp
  801b4d:	5b                   	pop    %ebx
  801b4e:	5e                   	pop    %esi
  801b4f:	5f                   	pop    %edi
  801b50:	5d                   	pop    %ebp
  801b51:	c3                   	ret    
  801b52:	66 90                	xchg   %ax,%ax
  801b54:	89 d8                	mov    %ebx,%eax
  801b56:	f7 f7                	div    %edi
  801b58:	31 ff                	xor    %edi,%edi
  801b5a:	89 fa                	mov    %edi,%edx
  801b5c:	83 c4 1c             	add    $0x1c,%esp
  801b5f:	5b                   	pop    %ebx
  801b60:	5e                   	pop    %esi
  801b61:	5f                   	pop    %edi
  801b62:	5d                   	pop    %ebp
  801b63:	c3                   	ret    
  801b64:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b69:	89 eb                	mov    %ebp,%ebx
  801b6b:	29 fb                	sub    %edi,%ebx
  801b6d:	89 f9                	mov    %edi,%ecx
  801b6f:	d3 e6                	shl    %cl,%esi
  801b71:	89 c5                	mov    %eax,%ebp
  801b73:	88 d9                	mov    %bl,%cl
  801b75:	d3 ed                	shr    %cl,%ebp
  801b77:	89 e9                	mov    %ebp,%ecx
  801b79:	09 f1                	or     %esi,%ecx
  801b7b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b7f:	89 f9                	mov    %edi,%ecx
  801b81:	d3 e0                	shl    %cl,%eax
  801b83:	89 c5                	mov    %eax,%ebp
  801b85:	89 d6                	mov    %edx,%esi
  801b87:	88 d9                	mov    %bl,%cl
  801b89:	d3 ee                	shr    %cl,%esi
  801b8b:	89 f9                	mov    %edi,%ecx
  801b8d:	d3 e2                	shl    %cl,%edx
  801b8f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b93:	88 d9                	mov    %bl,%cl
  801b95:	d3 e8                	shr    %cl,%eax
  801b97:	09 c2                	or     %eax,%edx
  801b99:	89 d0                	mov    %edx,%eax
  801b9b:	89 f2                	mov    %esi,%edx
  801b9d:	f7 74 24 0c          	divl   0xc(%esp)
  801ba1:	89 d6                	mov    %edx,%esi
  801ba3:	89 c3                	mov    %eax,%ebx
  801ba5:	f7 e5                	mul    %ebp
  801ba7:	39 d6                	cmp    %edx,%esi
  801ba9:	72 19                	jb     801bc4 <__udivdi3+0xfc>
  801bab:	74 0b                	je     801bb8 <__udivdi3+0xf0>
  801bad:	89 d8                	mov    %ebx,%eax
  801baf:	31 ff                	xor    %edi,%edi
  801bb1:	e9 58 ff ff ff       	jmp    801b0e <__udivdi3+0x46>
  801bb6:	66 90                	xchg   %ax,%ax
  801bb8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bbc:	89 f9                	mov    %edi,%ecx
  801bbe:	d3 e2                	shl    %cl,%edx
  801bc0:	39 c2                	cmp    %eax,%edx
  801bc2:	73 e9                	jae    801bad <__udivdi3+0xe5>
  801bc4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801bc7:	31 ff                	xor    %edi,%edi
  801bc9:	e9 40 ff ff ff       	jmp    801b0e <__udivdi3+0x46>
  801bce:	66 90                	xchg   %ax,%ax
  801bd0:	31 c0                	xor    %eax,%eax
  801bd2:	e9 37 ff ff ff       	jmp    801b0e <__udivdi3+0x46>
  801bd7:	90                   	nop

00801bd8 <__umoddi3>:
  801bd8:	55                   	push   %ebp
  801bd9:	57                   	push   %edi
  801bda:	56                   	push   %esi
  801bdb:	53                   	push   %ebx
  801bdc:	83 ec 1c             	sub    $0x1c,%esp
  801bdf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801be3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801be7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801beb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801bf3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bf7:	89 f3                	mov    %esi,%ebx
  801bf9:	89 fa                	mov    %edi,%edx
  801bfb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bff:	89 34 24             	mov    %esi,(%esp)
  801c02:	85 c0                	test   %eax,%eax
  801c04:	75 1a                	jne    801c20 <__umoddi3+0x48>
  801c06:	39 f7                	cmp    %esi,%edi
  801c08:	0f 86 a2 00 00 00    	jbe    801cb0 <__umoddi3+0xd8>
  801c0e:	89 c8                	mov    %ecx,%eax
  801c10:	89 f2                	mov    %esi,%edx
  801c12:	f7 f7                	div    %edi
  801c14:	89 d0                	mov    %edx,%eax
  801c16:	31 d2                	xor    %edx,%edx
  801c18:	83 c4 1c             	add    $0x1c,%esp
  801c1b:	5b                   	pop    %ebx
  801c1c:	5e                   	pop    %esi
  801c1d:	5f                   	pop    %edi
  801c1e:	5d                   	pop    %ebp
  801c1f:	c3                   	ret    
  801c20:	39 f0                	cmp    %esi,%eax
  801c22:	0f 87 ac 00 00 00    	ja     801cd4 <__umoddi3+0xfc>
  801c28:	0f bd e8             	bsr    %eax,%ebp
  801c2b:	83 f5 1f             	xor    $0x1f,%ebp
  801c2e:	0f 84 ac 00 00 00    	je     801ce0 <__umoddi3+0x108>
  801c34:	bf 20 00 00 00       	mov    $0x20,%edi
  801c39:	29 ef                	sub    %ebp,%edi
  801c3b:	89 fe                	mov    %edi,%esi
  801c3d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c41:	89 e9                	mov    %ebp,%ecx
  801c43:	d3 e0                	shl    %cl,%eax
  801c45:	89 d7                	mov    %edx,%edi
  801c47:	89 f1                	mov    %esi,%ecx
  801c49:	d3 ef                	shr    %cl,%edi
  801c4b:	09 c7                	or     %eax,%edi
  801c4d:	89 e9                	mov    %ebp,%ecx
  801c4f:	d3 e2                	shl    %cl,%edx
  801c51:	89 14 24             	mov    %edx,(%esp)
  801c54:	89 d8                	mov    %ebx,%eax
  801c56:	d3 e0                	shl    %cl,%eax
  801c58:	89 c2                	mov    %eax,%edx
  801c5a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c5e:	d3 e0                	shl    %cl,%eax
  801c60:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c64:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c68:	89 f1                	mov    %esi,%ecx
  801c6a:	d3 e8                	shr    %cl,%eax
  801c6c:	09 d0                	or     %edx,%eax
  801c6e:	d3 eb                	shr    %cl,%ebx
  801c70:	89 da                	mov    %ebx,%edx
  801c72:	f7 f7                	div    %edi
  801c74:	89 d3                	mov    %edx,%ebx
  801c76:	f7 24 24             	mull   (%esp)
  801c79:	89 c6                	mov    %eax,%esi
  801c7b:	89 d1                	mov    %edx,%ecx
  801c7d:	39 d3                	cmp    %edx,%ebx
  801c7f:	0f 82 87 00 00 00    	jb     801d0c <__umoddi3+0x134>
  801c85:	0f 84 91 00 00 00    	je     801d1c <__umoddi3+0x144>
  801c8b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c8f:	29 f2                	sub    %esi,%edx
  801c91:	19 cb                	sbb    %ecx,%ebx
  801c93:	89 d8                	mov    %ebx,%eax
  801c95:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c99:	d3 e0                	shl    %cl,%eax
  801c9b:	89 e9                	mov    %ebp,%ecx
  801c9d:	d3 ea                	shr    %cl,%edx
  801c9f:	09 d0                	or     %edx,%eax
  801ca1:	89 e9                	mov    %ebp,%ecx
  801ca3:	d3 eb                	shr    %cl,%ebx
  801ca5:	89 da                	mov    %ebx,%edx
  801ca7:	83 c4 1c             	add    $0x1c,%esp
  801caa:	5b                   	pop    %ebx
  801cab:	5e                   	pop    %esi
  801cac:	5f                   	pop    %edi
  801cad:	5d                   	pop    %ebp
  801cae:	c3                   	ret    
  801caf:	90                   	nop
  801cb0:	89 fd                	mov    %edi,%ebp
  801cb2:	85 ff                	test   %edi,%edi
  801cb4:	75 0b                	jne    801cc1 <__umoddi3+0xe9>
  801cb6:	b8 01 00 00 00       	mov    $0x1,%eax
  801cbb:	31 d2                	xor    %edx,%edx
  801cbd:	f7 f7                	div    %edi
  801cbf:	89 c5                	mov    %eax,%ebp
  801cc1:	89 f0                	mov    %esi,%eax
  801cc3:	31 d2                	xor    %edx,%edx
  801cc5:	f7 f5                	div    %ebp
  801cc7:	89 c8                	mov    %ecx,%eax
  801cc9:	f7 f5                	div    %ebp
  801ccb:	89 d0                	mov    %edx,%eax
  801ccd:	e9 44 ff ff ff       	jmp    801c16 <__umoddi3+0x3e>
  801cd2:	66 90                	xchg   %ax,%ax
  801cd4:	89 c8                	mov    %ecx,%eax
  801cd6:	89 f2                	mov    %esi,%edx
  801cd8:	83 c4 1c             	add    $0x1c,%esp
  801cdb:	5b                   	pop    %ebx
  801cdc:	5e                   	pop    %esi
  801cdd:	5f                   	pop    %edi
  801cde:	5d                   	pop    %ebp
  801cdf:	c3                   	ret    
  801ce0:	3b 04 24             	cmp    (%esp),%eax
  801ce3:	72 06                	jb     801ceb <__umoddi3+0x113>
  801ce5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ce9:	77 0f                	ja     801cfa <__umoddi3+0x122>
  801ceb:	89 f2                	mov    %esi,%edx
  801ced:	29 f9                	sub    %edi,%ecx
  801cef:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801cf3:	89 14 24             	mov    %edx,(%esp)
  801cf6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cfa:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cfe:	8b 14 24             	mov    (%esp),%edx
  801d01:	83 c4 1c             	add    $0x1c,%esp
  801d04:	5b                   	pop    %ebx
  801d05:	5e                   	pop    %esi
  801d06:	5f                   	pop    %edi
  801d07:	5d                   	pop    %ebp
  801d08:	c3                   	ret    
  801d09:	8d 76 00             	lea    0x0(%esi),%esi
  801d0c:	2b 04 24             	sub    (%esp),%eax
  801d0f:	19 fa                	sbb    %edi,%edx
  801d11:	89 d1                	mov    %edx,%ecx
  801d13:	89 c6                	mov    %eax,%esi
  801d15:	e9 71 ff ff ff       	jmp    801c8b <__umoddi3+0xb3>
  801d1a:	66 90                	xchg   %ax,%ax
  801d1c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d20:	72 ea                	jb     801d0c <__umoddi3+0x134>
  801d22:	89 d9                	mov    %ebx,%ecx
  801d24:	e9 62 ff ff ff       	jmp    801c8b <__umoddi3+0xb3>
