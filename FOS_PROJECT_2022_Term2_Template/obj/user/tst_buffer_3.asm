
obj/user/tst_buffer_3:     file format elf32-i386


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
  800031:	e8 82 02 00 00       	call   8002b8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp
//		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
//		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x804000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
//		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
//		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
	}
	int kilo = 1024;
  80003f:	c7 45 ec 00 04 00 00 	movl   $0x400,-0x14(%ebp)
	int Mega = 1024*1024;
  800046:	c7 45 e8 00 00 10 00 	movl   $0x100000,-0x18(%ebp)

	{
		int freeFrames = sys_calculate_free_frames() ;
  80004d:	e8 28 17 00 00       	call   80177a <sys_calculate_free_frames>
  800052:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int origFreeFrames = freeFrames ;
  800055:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800058:	89 45 e0             	mov    %eax,-0x20(%ebp)

		uint32 size = 10*Mega;
  80005b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80005e:	89 d0                	mov    %edx,%eax
  800060:	c1 e0 02             	shl    $0x2,%eax
  800063:	01 d0                	add    %edx,%eax
  800065:	01 c0                	add    %eax,%eax
  800067:	89 45 dc             	mov    %eax,-0x24(%ebp)
		unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  80006a:	83 ec 0c             	sub    $0xc,%esp
  80006d:	ff 75 dc             	pushl  -0x24(%ebp)
  800070:	e8 90 13 00 00       	call   801405 <malloc>
  800075:	83 c4 10             	add    $0x10,%esp
  800078:	89 45 d8             	mov    %eax,-0x28(%ebp)
		freeFrames = sys_calculate_free_frames() ;
  80007b:	e8 fa 16 00 00       	call   80177a <sys_calculate_free_frames>
  800080:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int modFrames = sys_calculate_modified_frames();
  800083:	e8 0b 17 00 00       	call   801793 <sys_calculate_modified_frames>
  800088:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		cprintf("all frames AFTER malloc = %d\n", freeFrames + modFrames);
  80008b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80008e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800091:	01 d0                	add    %edx,%eax
  800093:	83 ec 08             	sub    $0x8,%esp
  800096:	50                   	push   %eax
  800097:	68 a0 1e 80 00       	push   $0x801ea0
  80009c:	e8 da 05 00 00       	call   80067b <cprintf>
  8000a1:	83 c4 10             	add    $0x10,%esp
		x[1]=-1;
  8000a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000a7:	40                   	inc    %eax
  8000a8:	c6 00 ff             	movb   $0xff,(%eax)

		x[1*Mega] = -1;
  8000ab:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8000ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000b1:	01 d0                	add    %edx,%eax
  8000b3:	c6 00 ff             	movb   $0xff,(%eax)

		int i = x[2*Mega];
  8000b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000b9:	01 c0                	add    %eax,%eax
  8000bb:	89 c2                	mov    %eax,%edx
  8000bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000c0:	01 d0                	add    %edx,%eax
  8000c2:	8a 00                	mov    (%eax),%al
  8000c4:	0f b6 c0             	movzbl %al,%eax
  8000c7:	89 45 f4             	mov    %eax,-0xc(%ebp)

		int j = x[3*Mega];
  8000ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000cd:	89 c2                	mov    %eax,%edx
  8000cf:	01 d2                	add    %edx,%edx
  8000d1:	01 d0                	add    %edx,%eax
  8000d3:	89 c2                	mov    %eax,%edx
  8000d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000d8:	01 d0                	add    %edx,%eax
  8000da:	8a 00                	mov    (%eax),%al
  8000dc:	0f b6 c0             	movzbl %al,%eax
  8000df:	89 45 d0             	mov    %eax,-0x30(%ebp)

		x[4*Mega] = -1;
  8000e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e5:	c1 e0 02             	shl    $0x2,%eax
  8000e8:	89 c2                	mov    %eax,%edx
  8000ea:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000ed:	01 d0                	add    %edx,%eax
  8000ef:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega] = -1;
  8000f2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8000f5:	89 d0                	mov    %edx,%eax
  8000f7:	c1 e0 02             	shl    $0x2,%eax
  8000fa:	01 d0                	add    %edx,%eax
  8000fc:	89 c2                	mov    %eax,%edx
  8000fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800101:	01 d0                	add    %edx,%eax
  800103:	c6 00 ff             	movb   $0xff,(%eax)

		x[6*Mega] = -1;
  800106:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800109:	89 d0                	mov    %edx,%eax
  80010b:	01 c0                	add    %eax,%eax
  80010d:	01 d0                	add    %edx,%eax
  80010f:	01 c0                	add    %eax,%eax
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800116:	01 d0                	add    %edx,%eax
  800118:	c6 00 ff             	movb   $0xff,(%eax)

		x[7*Mega] = -1;
  80011b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80011e:	89 d0                	mov    %edx,%eax
  800120:	01 c0                	add    %eax,%eax
  800122:	01 d0                	add    %edx,%eax
  800124:	01 c0                	add    %eax,%eax
  800126:	01 d0                	add    %edx,%eax
  800128:	89 c2                	mov    %eax,%edx
  80012a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80012d:	01 d0                	add    %edx,%eax
  80012f:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  800132:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800135:	c1 e0 03             	shl    $0x3,%eax
  800138:	89 c2                	mov    %eax,%edx
  80013a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80013d:	01 d0                	add    %edx,%eax
  80013f:	c6 00 ff             	movb   $0xff,(%eax)

		x[9*Mega] = -1;
  800142:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800145:	89 d0                	mov    %edx,%eax
  800147:	c1 e0 03             	shl    $0x3,%eax
  80014a:	01 d0                	add    %edx,%eax
  80014c:	89 c2                	mov    %eax,%edx
  80014e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800151:	01 d0                	add    %edx,%eax
  800153:	c6 00 ff             	movb   $0xff,(%eax)

		free(x);
  800156:	83 ec 0c             	sub    $0xc,%esp
  800159:	ff 75 d8             	pushl  -0x28(%ebp)
  80015c:	e8 5c 14 00 00       	call   8015bd <free>
  800161:	83 c4 10             	add    $0x10,%esp

		int numOFEmptyLocInWS = 0;
  800164:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  80016b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800172:	eb 79                	jmp    8001ed <_main+0x1b5>
		{
			if (myEnv->__uptr_pws[i].empty)
  800174:	a1 20 30 80 00       	mov    0x803020,%eax
  800179:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80017f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800182:	89 d0                	mov    %edx,%eax
  800184:	01 c0                	add    %eax,%eax
  800186:	01 d0                	add    %edx,%eax
  800188:	c1 e0 02             	shl    $0x2,%eax
  80018b:	01 c8                	add    %ecx,%eax
  80018d:	8a 40 04             	mov    0x4(%eax),%al
  800190:	84 c0                	test   %al,%al
  800192:	74 05                	je     800199 <_main+0x161>
			{
				numOFEmptyLocInWS++;
  800194:	ff 45 f0             	incl   -0x10(%ebp)
  800197:	eb 51                	jmp    8001ea <_main+0x1b2>
			}
			else
			{
				uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
  800199:	a1 20 30 80 00       	mov    0x803020,%eax
  80019e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8001a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001a7:	89 d0                	mov    %edx,%eax
  8001a9:	01 c0                	add    %eax,%eax
  8001ab:	01 d0                	add    %edx,%eax
  8001ad:	c1 e0 02             	shl    $0x2,%eax
  8001b0:	01 c8                	add    %ecx,%eax
  8001b2:	8b 00                	mov    (%eax),%eax
  8001b4:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001b7:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001bf:	89 45 c8             	mov    %eax,-0x38(%ebp)
				if (va >= USER_HEAP_START && va < (USER_HEAP_START + size))
  8001c2:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001c5:	85 c0                	test   %eax,%eax
  8001c7:	79 21                	jns    8001ea <_main+0x1b2>
  8001c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001cc:	05 00 00 00 80       	add    $0x80000000,%eax
  8001d1:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  8001d4:	76 14                	jbe    8001ea <_main+0x1b2>
					panic("freeMem didn't remove its page(s) from the WS");
  8001d6:	83 ec 04             	sub    $0x4,%esp
  8001d9:	68 c0 1e 80 00       	push   $0x801ec0
  8001de:	6a 4e                	push   $0x4e
  8001e0:	68 ee 1e 80 00       	push   $0x801eee
  8001e5:	e8 dd 01 00 00       	call   8003c7 <_panic>
		x[9*Mega] = -1;

		free(x);

		int numOFEmptyLocInWS = 0;
		for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  8001ea:	ff 45 f4             	incl   -0xc(%ebp)
  8001ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f2:	8b 50 74             	mov    0x74(%eax),%edx
  8001f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001f8:	39 c2                	cmp    %eax,%edx
  8001fa:	0f 87 74 ff ff ff    	ja     800174 <_main+0x13c>
				uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
				if (va >= USER_HEAP_START && va < (USER_HEAP_START + size))
					panic("freeMem didn't remove its page(s) from the WS");
			}
		}
		int free_frames = sys_calculate_free_frames();
  800200:	e8 75 15 00 00       	call   80177a <sys_calculate_free_frames>
  800205:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		int mod_frames = sys_calculate_modified_frames();
  800208:	e8 86 15 00 00       	call   801793 <sys_calculate_modified_frames>
  80020d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((sys_calculate_modified_frames() + sys_calculate_free_frames() - numOFEmptyLocInWS) - (modFrames + freeFrames) != 0 ) panic("FreeMem didn't remove all modified frames in the given range from the modified list");
  800210:	e8 7e 15 00 00       	call   801793 <sys_calculate_modified_frames>
  800215:	89 c3                	mov    %eax,%ebx
  800217:	e8 5e 15 00 00       	call   80177a <sys_calculate_free_frames>
  80021c:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80021f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800222:	89 d1                	mov    %edx,%ecx
  800224:	29 c1                	sub    %eax,%ecx
  800226:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800229:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80022c:	01 d0                	add    %edx,%eax
  80022e:	39 c1                	cmp    %eax,%ecx
  800230:	74 14                	je     800246 <_main+0x20e>
  800232:	83 ec 04             	sub    $0x4,%esp
  800235:	68 04 1f 80 00       	push   $0x801f04
  80023a:	6a 53                	push   $0x53
  80023c:	68 ee 1e 80 00       	push   $0x801eee
  800241:	e8 81 01 00 00       	call   8003c7 <_panic>
		//if (sys_calculate_modified_frames() != 0 ) panic("FreeMem didn't remove all modified frames in the given range from the modified list");
		//if (sys_calculate_notmod_frames() != 7) panic("FreeMem didn't remove all un-modified frames in the given range from the free frame list");

		//if (sys_calculate_free_frames() - freeFrames != 3) panic("FreeMem didn't UN-BUFFER the removed BUFFERED frames in the given range.. (check updating of isBuffered");

		cprintf("Congratulations!! test of removing BUFFERED pages in freeHeap is completed successfully.\n");
  800246:	83 ec 0c             	sub    $0xc,%esp
  800249:	68 58 1f 80 00       	push   $0x801f58
  80024e:	e8 28 04 00 00       	call   80067b <cprintf>
  800253:	83 c4 10             	add    $0x10,%esp

		//Try to access any of the removed buffered pages in the Heap [It's ILLEGAL ACCESS now]
		{
			cprintf("\nNow, trying to access the removed BUFFERED pages, you should make the kernel PANIC with ILLEGAL MEMORY ACCESS in page_fault_handler() since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK.\n\n\n");
  800256:	83 ec 0c             	sub    $0xc,%esp
  800259:	68 b4 1f 80 00       	push   $0x801fb4
  80025e:	e8 18 04 00 00       	call   80067b <cprintf>
  800263:	83 c4 10             	add    $0x10,%esp

			x[1]=-1;
  800266:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800269:	40                   	inc    %eax
  80026a:	c6 00 ff             	movb   $0xff,(%eax)

			x[1*Mega] = -1;
  80026d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800270:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800273:	01 d0                	add    %edx,%eax
  800275:	c6 00 ff             	movb   $0xff,(%eax)

			int i = x[2*Mega];
  800278:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80027b:	01 c0                	add    %eax,%eax
  80027d:	89 c2                	mov    %eax,%edx
  80027f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800282:	01 d0                	add    %edx,%eax
  800284:	8a 00                	mov    (%eax),%al
  800286:	0f b6 c0             	movzbl %al,%eax
  800289:	89 45 bc             	mov    %eax,-0x44(%ebp)

			int j = x[3*Mega];
  80028c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80028f:	89 c2                	mov    %eax,%edx
  800291:	01 d2                	add    %edx,%edx
  800293:	01 d0                	add    %edx,%eax
  800295:	89 c2                	mov    %eax,%edx
  800297:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80029a:	01 d0                	add    %edx,%eax
  80029c:	8a 00                	mov    (%eax),%al
  80029e:	0f b6 c0             	movzbl %al,%eax
  8002a1:	89 45 b8             	mov    %eax,-0x48(%ebp)
		}
		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for stack pages\n");
  8002a4:	83 ec 04             	sub    $0x4,%esp
  8002a7:	68 98 20 80 00       	push   $0x802098
  8002ac:	6a 68                	push   $0x68
  8002ae:	68 ee 1e 80 00       	push   $0x801eee
  8002b3:	e8 0f 01 00 00       	call   8003c7 <_panic>

008002b8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002b8:	55                   	push   %ebp
  8002b9:	89 e5                	mov    %esp,%ebp
  8002bb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002be:	e8 ec 13 00 00       	call   8016af <sys_getenvindex>
  8002c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002c9:	89 d0                	mov    %edx,%eax
  8002cb:	c1 e0 02             	shl    $0x2,%eax
  8002ce:	01 d0                	add    %edx,%eax
  8002d0:	01 c0                	add    %eax,%eax
  8002d2:	01 d0                	add    %edx,%eax
  8002d4:	01 c0                	add    %eax,%eax
  8002d6:	01 d0                	add    %edx,%eax
  8002d8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002df:	01 d0                	add    %edx,%eax
  8002e1:	c1 e0 02             	shl    $0x2,%eax
  8002e4:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002e9:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f3:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8002f9:	84 c0                	test   %al,%al
  8002fb:	74 0f                	je     80030c <libmain+0x54>
		binaryname = myEnv->prog_name;
  8002fd:	a1 20 30 80 00       	mov    0x803020,%eax
  800302:	05 f4 02 00 00       	add    $0x2f4,%eax
  800307:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80030c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800310:	7e 0a                	jle    80031c <libmain+0x64>
		binaryname = argv[0];
  800312:	8b 45 0c             	mov    0xc(%ebp),%eax
  800315:	8b 00                	mov    (%eax),%eax
  800317:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80031c:	83 ec 08             	sub    $0x8,%esp
  80031f:	ff 75 0c             	pushl  0xc(%ebp)
  800322:	ff 75 08             	pushl  0x8(%ebp)
  800325:	e8 0e fd ff ff       	call   800038 <_main>
  80032a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80032d:	e8 18 15 00 00       	call   80184a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800332:	83 ec 0c             	sub    $0xc,%esp
  800335:	68 b8 21 80 00       	push   $0x8021b8
  80033a:	e8 3c 03 00 00       	call   80067b <cprintf>
  80033f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800342:	a1 20 30 80 00       	mov    0x803020,%eax
  800347:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80034d:	a1 20 30 80 00       	mov    0x803020,%eax
  800352:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800358:	83 ec 04             	sub    $0x4,%esp
  80035b:	52                   	push   %edx
  80035c:	50                   	push   %eax
  80035d:	68 e0 21 80 00       	push   $0x8021e0
  800362:	e8 14 03 00 00       	call   80067b <cprintf>
  800367:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80036a:	a1 20 30 80 00       	mov    0x803020,%eax
  80036f:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800375:	83 ec 08             	sub    $0x8,%esp
  800378:	50                   	push   %eax
  800379:	68 05 22 80 00       	push   $0x802205
  80037e:	e8 f8 02 00 00       	call   80067b <cprintf>
  800383:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800386:	83 ec 0c             	sub    $0xc,%esp
  800389:	68 b8 21 80 00       	push   $0x8021b8
  80038e:	e8 e8 02 00 00       	call   80067b <cprintf>
  800393:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800396:	e8 c9 14 00 00       	call   801864 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80039b:	e8 19 00 00 00       	call   8003b9 <exit>
}
  8003a0:	90                   	nop
  8003a1:	c9                   	leave  
  8003a2:	c3                   	ret    

008003a3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003a3:	55                   	push   %ebp
  8003a4:	89 e5                	mov    %esp,%ebp
  8003a6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8003a9:	83 ec 0c             	sub    $0xc,%esp
  8003ac:	6a 00                	push   $0x0
  8003ae:	e8 c8 12 00 00       	call   80167b <sys_env_destroy>
  8003b3:	83 c4 10             	add    $0x10,%esp
}
  8003b6:	90                   	nop
  8003b7:	c9                   	leave  
  8003b8:	c3                   	ret    

008003b9 <exit>:

void
exit(void)
{
  8003b9:	55                   	push   %ebp
  8003ba:	89 e5                	mov    %esp,%ebp
  8003bc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003bf:	e8 1d 13 00 00       	call   8016e1 <sys_env_exit>
}
  8003c4:	90                   	nop
  8003c5:	c9                   	leave  
  8003c6:	c3                   	ret    

008003c7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003c7:	55                   	push   %ebp
  8003c8:	89 e5                	mov    %esp,%ebp
  8003ca:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003cd:	8d 45 10             	lea    0x10(%ebp),%eax
  8003d0:	83 c0 04             	add    $0x4,%eax
  8003d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003d6:	a1 34 30 80 00       	mov    0x803034,%eax
  8003db:	85 c0                	test   %eax,%eax
  8003dd:	74 16                	je     8003f5 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003df:	a1 34 30 80 00       	mov    0x803034,%eax
  8003e4:	83 ec 08             	sub    $0x8,%esp
  8003e7:	50                   	push   %eax
  8003e8:	68 1c 22 80 00       	push   $0x80221c
  8003ed:	e8 89 02 00 00       	call   80067b <cprintf>
  8003f2:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8003f5:	a1 00 30 80 00       	mov    0x803000,%eax
  8003fa:	ff 75 0c             	pushl  0xc(%ebp)
  8003fd:	ff 75 08             	pushl  0x8(%ebp)
  800400:	50                   	push   %eax
  800401:	68 21 22 80 00       	push   $0x802221
  800406:	e8 70 02 00 00       	call   80067b <cprintf>
  80040b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80040e:	8b 45 10             	mov    0x10(%ebp),%eax
  800411:	83 ec 08             	sub    $0x8,%esp
  800414:	ff 75 f4             	pushl  -0xc(%ebp)
  800417:	50                   	push   %eax
  800418:	e8 f3 01 00 00       	call   800610 <vcprintf>
  80041d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800420:	83 ec 08             	sub    $0x8,%esp
  800423:	6a 00                	push   $0x0
  800425:	68 3d 22 80 00       	push   $0x80223d
  80042a:	e8 e1 01 00 00       	call   800610 <vcprintf>
  80042f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800432:	e8 82 ff ff ff       	call   8003b9 <exit>

	// should not return here
	while (1) ;
  800437:	eb fe                	jmp    800437 <_panic+0x70>

00800439 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800439:	55                   	push   %ebp
  80043a:	89 e5                	mov    %esp,%ebp
  80043c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80043f:	a1 20 30 80 00       	mov    0x803020,%eax
  800444:	8b 50 74             	mov    0x74(%eax),%edx
  800447:	8b 45 0c             	mov    0xc(%ebp),%eax
  80044a:	39 c2                	cmp    %eax,%edx
  80044c:	74 14                	je     800462 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80044e:	83 ec 04             	sub    $0x4,%esp
  800451:	68 40 22 80 00       	push   $0x802240
  800456:	6a 26                	push   $0x26
  800458:	68 8c 22 80 00       	push   $0x80228c
  80045d:	e8 65 ff ff ff       	call   8003c7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800462:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800469:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800470:	e9 c2 00 00 00       	jmp    800537 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800475:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800478:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80047f:	8b 45 08             	mov    0x8(%ebp),%eax
  800482:	01 d0                	add    %edx,%eax
  800484:	8b 00                	mov    (%eax),%eax
  800486:	85 c0                	test   %eax,%eax
  800488:	75 08                	jne    800492 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80048a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80048d:	e9 a2 00 00 00       	jmp    800534 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800492:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800499:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004a0:	eb 69                	jmp    80050b <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004ad:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004b0:	89 d0                	mov    %edx,%eax
  8004b2:	01 c0                	add    %eax,%eax
  8004b4:	01 d0                	add    %edx,%eax
  8004b6:	c1 e0 02             	shl    $0x2,%eax
  8004b9:	01 c8                	add    %ecx,%eax
  8004bb:	8a 40 04             	mov    0x4(%eax),%al
  8004be:	84 c0                	test   %al,%al
  8004c0:	75 46                	jne    800508 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004cd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004d0:	89 d0                	mov    %edx,%eax
  8004d2:	01 c0                	add    %eax,%eax
  8004d4:	01 d0                	add    %edx,%eax
  8004d6:	c1 e0 02             	shl    $0x2,%eax
  8004d9:	01 c8                	add    %ecx,%eax
  8004db:	8b 00                	mov    (%eax),%eax
  8004dd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004e3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004e8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004ed:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f7:	01 c8                	add    %ecx,%eax
  8004f9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004fb:	39 c2                	cmp    %eax,%edx
  8004fd:	75 09                	jne    800508 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8004ff:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800506:	eb 12                	jmp    80051a <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800508:	ff 45 e8             	incl   -0x18(%ebp)
  80050b:	a1 20 30 80 00       	mov    0x803020,%eax
  800510:	8b 50 74             	mov    0x74(%eax),%edx
  800513:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800516:	39 c2                	cmp    %eax,%edx
  800518:	77 88                	ja     8004a2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80051a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80051e:	75 14                	jne    800534 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800520:	83 ec 04             	sub    $0x4,%esp
  800523:	68 98 22 80 00       	push   $0x802298
  800528:	6a 3a                	push   $0x3a
  80052a:	68 8c 22 80 00       	push   $0x80228c
  80052f:	e8 93 fe ff ff       	call   8003c7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800534:	ff 45 f0             	incl   -0x10(%ebp)
  800537:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80053a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80053d:	0f 8c 32 ff ff ff    	jl     800475 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800543:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80054a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800551:	eb 26                	jmp    800579 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800553:	a1 20 30 80 00       	mov    0x803020,%eax
  800558:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80055e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800561:	89 d0                	mov    %edx,%eax
  800563:	01 c0                	add    %eax,%eax
  800565:	01 d0                	add    %edx,%eax
  800567:	c1 e0 02             	shl    $0x2,%eax
  80056a:	01 c8                	add    %ecx,%eax
  80056c:	8a 40 04             	mov    0x4(%eax),%al
  80056f:	3c 01                	cmp    $0x1,%al
  800571:	75 03                	jne    800576 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800573:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800576:	ff 45 e0             	incl   -0x20(%ebp)
  800579:	a1 20 30 80 00       	mov    0x803020,%eax
  80057e:	8b 50 74             	mov    0x74(%eax),%edx
  800581:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800584:	39 c2                	cmp    %eax,%edx
  800586:	77 cb                	ja     800553 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800588:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80058b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80058e:	74 14                	je     8005a4 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800590:	83 ec 04             	sub    $0x4,%esp
  800593:	68 ec 22 80 00       	push   $0x8022ec
  800598:	6a 44                	push   $0x44
  80059a:	68 8c 22 80 00       	push   $0x80228c
  80059f:	e8 23 fe ff ff       	call   8003c7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005a4:	90                   	nop
  8005a5:	c9                   	leave  
  8005a6:	c3                   	ret    

008005a7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005a7:	55                   	push   %ebp
  8005a8:	89 e5                	mov    %esp,%ebp
  8005aa:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005b0:	8b 00                	mov    (%eax),%eax
  8005b2:	8d 48 01             	lea    0x1(%eax),%ecx
  8005b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005b8:	89 0a                	mov    %ecx,(%edx)
  8005ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8005bd:	88 d1                	mov    %dl,%cl
  8005bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005c2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c9:	8b 00                	mov    (%eax),%eax
  8005cb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005d0:	75 2c                	jne    8005fe <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005d2:	a0 24 30 80 00       	mov    0x803024,%al
  8005d7:	0f b6 c0             	movzbl %al,%eax
  8005da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005dd:	8b 12                	mov    (%edx),%edx
  8005df:	89 d1                	mov    %edx,%ecx
  8005e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005e4:	83 c2 08             	add    $0x8,%edx
  8005e7:	83 ec 04             	sub    $0x4,%esp
  8005ea:	50                   	push   %eax
  8005eb:	51                   	push   %ecx
  8005ec:	52                   	push   %edx
  8005ed:	e8 47 10 00 00       	call   801639 <sys_cputs>
  8005f2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800601:	8b 40 04             	mov    0x4(%eax),%eax
  800604:	8d 50 01             	lea    0x1(%eax),%edx
  800607:	8b 45 0c             	mov    0xc(%ebp),%eax
  80060a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80060d:	90                   	nop
  80060e:	c9                   	leave  
  80060f:	c3                   	ret    

00800610 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800610:	55                   	push   %ebp
  800611:	89 e5                	mov    %esp,%ebp
  800613:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800619:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800620:	00 00 00 
	b.cnt = 0;
  800623:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80062a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80062d:	ff 75 0c             	pushl  0xc(%ebp)
  800630:	ff 75 08             	pushl  0x8(%ebp)
  800633:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800639:	50                   	push   %eax
  80063a:	68 a7 05 80 00       	push   $0x8005a7
  80063f:	e8 11 02 00 00       	call   800855 <vprintfmt>
  800644:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800647:	a0 24 30 80 00       	mov    0x803024,%al
  80064c:	0f b6 c0             	movzbl %al,%eax
  80064f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800655:	83 ec 04             	sub    $0x4,%esp
  800658:	50                   	push   %eax
  800659:	52                   	push   %edx
  80065a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800660:	83 c0 08             	add    $0x8,%eax
  800663:	50                   	push   %eax
  800664:	e8 d0 0f 00 00       	call   801639 <sys_cputs>
  800669:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80066c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800673:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800679:	c9                   	leave  
  80067a:	c3                   	ret    

0080067b <cprintf>:

int cprintf(const char *fmt, ...) {
  80067b:	55                   	push   %ebp
  80067c:	89 e5                	mov    %esp,%ebp
  80067e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800681:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800688:	8d 45 0c             	lea    0xc(%ebp),%eax
  80068b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80068e:	8b 45 08             	mov    0x8(%ebp),%eax
  800691:	83 ec 08             	sub    $0x8,%esp
  800694:	ff 75 f4             	pushl  -0xc(%ebp)
  800697:	50                   	push   %eax
  800698:	e8 73 ff ff ff       	call   800610 <vcprintf>
  80069d:	83 c4 10             	add    $0x10,%esp
  8006a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006a6:	c9                   	leave  
  8006a7:	c3                   	ret    

008006a8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006a8:	55                   	push   %ebp
  8006a9:	89 e5                	mov    %esp,%ebp
  8006ab:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006ae:	e8 97 11 00 00       	call   80184a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006b3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	83 ec 08             	sub    $0x8,%esp
  8006bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8006c2:	50                   	push   %eax
  8006c3:	e8 48 ff ff ff       	call   800610 <vcprintf>
  8006c8:	83 c4 10             	add    $0x10,%esp
  8006cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006ce:	e8 91 11 00 00       	call   801864 <sys_enable_interrupt>
	return cnt;
  8006d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006d6:	c9                   	leave  
  8006d7:	c3                   	ret    

008006d8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006d8:	55                   	push   %ebp
  8006d9:	89 e5                	mov    %esp,%ebp
  8006db:	53                   	push   %ebx
  8006dc:	83 ec 14             	sub    $0x14,%esp
  8006df:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006eb:	8b 45 18             	mov    0x18(%ebp),%eax
  8006ee:	ba 00 00 00 00       	mov    $0x0,%edx
  8006f3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006f6:	77 55                	ja     80074d <printnum+0x75>
  8006f8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006fb:	72 05                	jb     800702 <printnum+0x2a>
  8006fd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800700:	77 4b                	ja     80074d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800702:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800705:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800708:	8b 45 18             	mov    0x18(%ebp),%eax
  80070b:	ba 00 00 00 00       	mov    $0x0,%edx
  800710:	52                   	push   %edx
  800711:	50                   	push   %eax
  800712:	ff 75 f4             	pushl  -0xc(%ebp)
  800715:	ff 75 f0             	pushl  -0x10(%ebp)
  800718:	e8 0b 15 00 00       	call   801c28 <__udivdi3>
  80071d:	83 c4 10             	add    $0x10,%esp
  800720:	83 ec 04             	sub    $0x4,%esp
  800723:	ff 75 20             	pushl  0x20(%ebp)
  800726:	53                   	push   %ebx
  800727:	ff 75 18             	pushl  0x18(%ebp)
  80072a:	52                   	push   %edx
  80072b:	50                   	push   %eax
  80072c:	ff 75 0c             	pushl  0xc(%ebp)
  80072f:	ff 75 08             	pushl  0x8(%ebp)
  800732:	e8 a1 ff ff ff       	call   8006d8 <printnum>
  800737:	83 c4 20             	add    $0x20,%esp
  80073a:	eb 1a                	jmp    800756 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80073c:	83 ec 08             	sub    $0x8,%esp
  80073f:	ff 75 0c             	pushl  0xc(%ebp)
  800742:	ff 75 20             	pushl  0x20(%ebp)
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	ff d0                	call   *%eax
  80074a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80074d:	ff 4d 1c             	decl   0x1c(%ebp)
  800750:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800754:	7f e6                	jg     80073c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800756:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800759:	bb 00 00 00 00       	mov    $0x0,%ebx
  80075e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800761:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800764:	53                   	push   %ebx
  800765:	51                   	push   %ecx
  800766:	52                   	push   %edx
  800767:	50                   	push   %eax
  800768:	e8 cb 15 00 00       	call   801d38 <__umoddi3>
  80076d:	83 c4 10             	add    $0x10,%esp
  800770:	05 54 25 80 00       	add    $0x802554,%eax
  800775:	8a 00                	mov    (%eax),%al
  800777:	0f be c0             	movsbl %al,%eax
  80077a:	83 ec 08             	sub    $0x8,%esp
  80077d:	ff 75 0c             	pushl  0xc(%ebp)
  800780:	50                   	push   %eax
  800781:	8b 45 08             	mov    0x8(%ebp),%eax
  800784:	ff d0                	call   *%eax
  800786:	83 c4 10             	add    $0x10,%esp
}
  800789:	90                   	nop
  80078a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80078d:	c9                   	leave  
  80078e:	c3                   	ret    

0080078f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80078f:	55                   	push   %ebp
  800790:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800792:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800796:	7e 1c                	jle    8007b4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800798:	8b 45 08             	mov    0x8(%ebp),%eax
  80079b:	8b 00                	mov    (%eax),%eax
  80079d:	8d 50 08             	lea    0x8(%eax),%edx
  8007a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a3:	89 10                	mov    %edx,(%eax)
  8007a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a8:	8b 00                	mov    (%eax),%eax
  8007aa:	83 e8 08             	sub    $0x8,%eax
  8007ad:	8b 50 04             	mov    0x4(%eax),%edx
  8007b0:	8b 00                	mov    (%eax),%eax
  8007b2:	eb 40                	jmp    8007f4 <getuint+0x65>
	else if (lflag)
  8007b4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007b8:	74 1e                	je     8007d8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bd:	8b 00                	mov    (%eax),%eax
  8007bf:	8d 50 04             	lea    0x4(%eax),%edx
  8007c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c5:	89 10                	mov    %edx,(%eax)
  8007c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ca:	8b 00                	mov    (%eax),%eax
  8007cc:	83 e8 04             	sub    $0x4,%eax
  8007cf:	8b 00                	mov    (%eax),%eax
  8007d1:	ba 00 00 00 00       	mov    $0x0,%edx
  8007d6:	eb 1c                	jmp    8007f4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007db:	8b 00                	mov    (%eax),%eax
  8007dd:	8d 50 04             	lea    0x4(%eax),%edx
  8007e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e3:	89 10                	mov    %edx,(%eax)
  8007e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e8:	8b 00                	mov    (%eax),%eax
  8007ea:	83 e8 04             	sub    $0x4,%eax
  8007ed:	8b 00                	mov    (%eax),%eax
  8007ef:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007f4:	5d                   	pop    %ebp
  8007f5:	c3                   	ret    

008007f6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007f6:	55                   	push   %ebp
  8007f7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007f9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007fd:	7e 1c                	jle    80081b <getint+0x25>
		return va_arg(*ap, long long);
  8007ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800802:	8b 00                	mov    (%eax),%eax
  800804:	8d 50 08             	lea    0x8(%eax),%edx
  800807:	8b 45 08             	mov    0x8(%ebp),%eax
  80080a:	89 10                	mov    %edx,(%eax)
  80080c:	8b 45 08             	mov    0x8(%ebp),%eax
  80080f:	8b 00                	mov    (%eax),%eax
  800811:	83 e8 08             	sub    $0x8,%eax
  800814:	8b 50 04             	mov    0x4(%eax),%edx
  800817:	8b 00                	mov    (%eax),%eax
  800819:	eb 38                	jmp    800853 <getint+0x5d>
	else if (lflag)
  80081b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80081f:	74 1a                	je     80083b <getint+0x45>
		return va_arg(*ap, long);
  800821:	8b 45 08             	mov    0x8(%ebp),%eax
  800824:	8b 00                	mov    (%eax),%eax
  800826:	8d 50 04             	lea    0x4(%eax),%edx
  800829:	8b 45 08             	mov    0x8(%ebp),%eax
  80082c:	89 10                	mov    %edx,(%eax)
  80082e:	8b 45 08             	mov    0x8(%ebp),%eax
  800831:	8b 00                	mov    (%eax),%eax
  800833:	83 e8 04             	sub    $0x4,%eax
  800836:	8b 00                	mov    (%eax),%eax
  800838:	99                   	cltd   
  800839:	eb 18                	jmp    800853 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80083b:	8b 45 08             	mov    0x8(%ebp),%eax
  80083e:	8b 00                	mov    (%eax),%eax
  800840:	8d 50 04             	lea    0x4(%eax),%edx
  800843:	8b 45 08             	mov    0x8(%ebp),%eax
  800846:	89 10                	mov    %edx,(%eax)
  800848:	8b 45 08             	mov    0x8(%ebp),%eax
  80084b:	8b 00                	mov    (%eax),%eax
  80084d:	83 e8 04             	sub    $0x4,%eax
  800850:	8b 00                	mov    (%eax),%eax
  800852:	99                   	cltd   
}
  800853:	5d                   	pop    %ebp
  800854:	c3                   	ret    

00800855 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800855:	55                   	push   %ebp
  800856:	89 e5                	mov    %esp,%ebp
  800858:	56                   	push   %esi
  800859:	53                   	push   %ebx
  80085a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80085d:	eb 17                	jmp    800876 <vprintfmt+0x21>
			if (ch == '\0')
  80085f:	85 db                	test   %ebx,%ebx
  800861:	0f 84 af 03 00 00    	je     800c16 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800867:	83 ec 08             	sub    $0x8,%esp
  80086a:	ff 75 0c             	pushl  0xc(%ebp)
  80086d:	53                   	push   %ebx
  80086e:	8b 45 08             	mov    0x8(%ebp),%eax
  800871:	ff d0                	call   *%eax
  800873:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800876:	8b 45 10             	mov    0x10(%ebp),%eax
  800879:	8d 50 01             	lea    0x1(%eax),%edx
  80087c:	89 55 10             	mov    %edx,0x10(%ebp)
  80087f:	8a 00                	mov    (%eax),%al
  800881:	0f b6 d8             	movzbl %al,%ebx
  800884:	83 fb 25             	cmp    $0x25,%ebx
  800887:	75 d6                	jne    80085f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800889:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80088d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800894:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80089b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008a2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ac:	8d 50 01             	lea    0x1(%eax),%edx
  8008af:	89 55 10             	mov    %edx,0x10(%ebp)
  8008b2:	8a 00                	mov    (%eax),%al
  8008b4:	0f b6 d8             	movzbl %al,%ebx
  8008b7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008ba:	83 f8 55             	cmp    $0x55,%eax
  8008bd:	0f 87 2b 03 00 00    	ja     800bee <vprintfmt+0x399>
  8008c3:	8b 04 85 78 25 80 00 	mov    0x802578(,%eax,4),%eax
  8008ca:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008cc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008d0:	eb d7                	jmp    8008a9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008d2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008d6:	eb d1                	jmp    8008a9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008d8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008df:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008e2:	89 d0                	mov    %edx,%eax
  8008e4:	c1 e0 02             	shl    $0x2,%eax
  8008e7:	01 d0                	add    %edx,%eax
  8008e9:	01 c0                	add    %eax,%eax
  8008eb:	01 d8                	add    %ebx,%eax
  8008ed:	83 e8 30             	sub    $0x30,%eax
  8008f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f6:	8a 00                	mov    (%eax),%al
  8008f8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008fb:	83 fb 2f             	cmp    $0x2f,%ebx
  8008fe:	7e 3e                	jle    80093e <vprintfmt+0xe9>
  800900:	83 fb 39             	cmp    $0x39,%ebx
  800903:	7f 39                	jg     80093e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800905:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800908:	eb d5                	jmp    8008df <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80090a:	8b 45 14             	mov    0x14(%ebp),%eax
  80090d:	83 c0 04             	add    $0x4,%eax
  800910:	89 45 14             	mov    %eax,0x14(%ebp)
  800913:	8b 45 14             	mov    0x14(%ebp),%eax
  800916:	83 e8 04             	sub    $0x4,%eax
  800919:	8b 00                	mov    (%eax),%eax
  80091b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80091e:	eb 1f                	jmp    80093f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800920:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800924:	79 83                	jns    8008a9 <vprintfmt+0x54>
				width = 0;
  800926:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80092d:	e9 77 ff ff ff       	jmp    8008a9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800932:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800939:	e9 6b ff ff ff       	jmp    8008a9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80093e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80093f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800943:	0f 89 60 ff ff ff    	jns    8008a9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800949:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80094c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80094f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800956:	e9 4e ff ff ff       	jmp    8008a9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80095b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80095e:	e9 46 ff ff ff       	jmp    8008a9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800963:	8b 45 14             	mov    0x14(%ebp),%eax
  800966:	83 c0 04             	add    $0x4,%eax
  800969:	89 45 14             	mov    %eax,0x14(%ebp)
  80096c:	8b 45 14             	mov    0x14(%ebp),%eax
  80096f:	83 e8 04             	sub    $0x4,%eax
  800972:	8b 00                	mov    (%eax),%eax
  800974:	83 ec 08             	sub    $0x8,%esp
  800977:	ff 75 0c             	pushl  0xc(%ebp)
  80097a:	50                   	push   %eax
  80097b:	8b 45 08             	mov    0x8(%ebp),%eax
  80097e:	ff d0                	call   *%eax
  800980:	83 c4 10             	add    $0x10,%esp
			break;
  800983:	e9 89 02 00 00       	jmp    800c11 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800988:	8b 45 14             	mov    0x14(%ebp),%eax
  80098b:	83 c0 04             	add    $0x4,%eax
  80098e:	89 45 14             	mov    %eax,0x14(%ebp)
  800991:	8b 45 14             	mov    0x14(%ebp),%eax
  800994:	83 e8 04             	sub    $0x4,%eax
  800997:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800999:	85 db                	test   %ebx,%ebx
  80099b:	79 02                	jns    80099f <vprintfmt+0x14a>
				err = -err;
  80099d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80099f:	83 fb 64             	cmp    $0x64,%ebx
  8009a2:	7f 0b                	jg     8009af <vprintfmt+0x15a>
  8009a4:	8b 34 9d c0 23 80 00 	mov    0x8023c0(,%ebx,4),%esi
  8009ab:	85 f6                	test   %esi,%esi
  8009ad:	75 19                	jne    8009c8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009af:	53                   	push   %ebx
  8009b0:	68 65 25 80 00       	push   $0x802565
  8009b5:	ff 75 0c             	pushl  0xc(%ebp)
  8009b8:	ff 75 08             	pushl  0x8(%ebp)
  8009bb:	e8 5e 02 00 00       	call   800c1e <printfmt>
  8009c0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009c3:	e9 49 02 00 00       	jmp    800c11 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009c8:	56                   	push   %esi
  8009c9:	68 6e 25 80 00       	push   $0x80256e
  8009ce:	ff 75 0c             	pushl  0xc(%ebp)
  8009d1:	ff 75 08             	pushl  0x8(%ebp)
  8009d4:	e8 45 02 00 00       	call   800c1e <printfmt>
  8009d9:	83 c4 10             	add    $0x10,%esp
			break;
  8009dc:	e9 30 02 00 00       	jmp    800c11 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e4:	83 c0 04             	add    $0x4,%eax
  8009e7:	89 45 14             	mov    %eax,0x14(%ebp)
  8009ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ed:	83 e8 04             	sub    $0x4,%eax
  8009f0:	8b 30                	mov    (%eax),%esi
  8009f2:	85 f6                	test   %esi,%esi
  8009f4:	75 05                	jne    8009fb <vprintfmt+0x1a6>
				p = "(null)";
  8009f6:	be 71 25 80 00       	mov    $0x802571,%esi
			if (width > 0 && padc != '-')
  8009fb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ff:	7e 6d                	jle    800a6e <vprintfmt+0x219>
  800a01:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a05:	74 67                	je     800a6e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a0a:	83 ec 08             	sub    $0x8,%esp
  800a0d:	50                   	push   %eax
  800a0e:	56                   	push   %esi
  800a0f:	e8 0c 03 00 00       	call   800d20 <strnlen>
  800a14:	83 c4 10             	add    $0x10,%esp
  800a17:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a1a:	eb 16                	jmp    800a32 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a1c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a20:	83 ec 08             	sub    $0x8,%esp
  800a23:	ff 75 0c             	pushl  0xc(%ebp)
  800a26:	50                   	push   %eax
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	ff d0                	call   *%eax
  800a2c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a2f:	ff 4d e4             	decl   -0x1c(%ebp)
  800a32:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a36:	7f e4                	jg     800a1c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a38:	eb 34                	jmp    800a6e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a3a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a3e:	74 1c                	je     800a5c <vprintfmt+0x207>
  800a40:	83 fb 1f             	cmp    $0x1f,%ebx
  800a43:	7e 05                	jle    800a4a <vprintfmt+0x1f5>
  800a45:	83 fb 7e             	cmp    $0x7e,%ebx
  800a48:	7e 12                	jle    800a5c <vprintfmt+0x207>
					putch('?', putdat);
  800a4a:	83 ec 08             	sub    $0x8,%esp
  800a4d:	ff 75 0c             	pushl  0xc(%ebp)
  800a50:	6a 3f                	push   $0x3f
  800a52:	8b 45 08             	mov    0x8(%ebp),%eax
  800a55:	ff d0                	call   *%eax
  800a57:	83 c4 10             	add    $0x10,%esp
  800a5a:	eb 0f                	jmp    800a6b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a5c:	83 ec 08             	sub    $0x8,%esp
  800a5f:	ff 75 0c             	pushl  0xc(%ebp)
  800a62:	53                   	push   %ebx
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	ff d0                	call   *%eax
  800a68:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a6b:	ff 4d e4             	decl   -0x1c(%ebp)
  800a6e:	89 f0                	mov    %esi,%eax
  800a70:	8d 70 01             	lea    0x1(%eax),%esi
  800a73:	8a 00                	mov    (%eax),%al
  800a75:	0f be d8             	movsbl %al,%ebx
  800a78:	85 db                	test   %ebx,%ebx
  800a7a:	74 24                	je     800aa0 <vprintfmt+0x24b>
  800a7c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a80:	78 b8                	js     800a3a <vprintfmt+0x1e5>
  800a82:	ff 4d e0             	decl   -0x20(%ebp)
  800a85:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a89:	79 af                	jns    800a3a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a8b:	eb 13                	jmp    800aa0 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	ff 75 0c             	pushl  0xc(%ebp)
  800a93:	6a 20                	push   $0x20
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	ff d0                	call   *%eax
  800a9a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a9d:	ff 4d e4             	decl   -0x1c(%ebp)
  800aa0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa4:	7f e7                	jg     800a8d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800aa6:	e9 66 01 00 00       	jmp    800c11 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800aab:	83 ec 08             	sub    $0x8,%esp
  800aae:	ff 75 e8             	pushl  -0x18(%ebp)
  800ab1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ab4:	50                   	push   %eax
  800ab5:	e8 3c fd ff ff       	call   8007f6 <getint>
  800aba:	83 c4 10             	add    $0x10,%esp
  800abd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ac3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ac6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ac9:	85 d2                	test   %edx,%edx
  800acb:	79 23                	jns    800af0 <vprintfmt+0x29b>
				putch('-', putdat);
  800acd:	83 ec 08             	sub    $0x8,%esp
  800ad0:	ff 75 0c             	pushl  0xc(%ebp)
  800ad3:	6a 2d                	push   $0x2d
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	ff d0                	call   *%eax
  800ada:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800add:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ae0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ae3:	f7 d8                	neg    %eax
  800ae5:	83 d2 00             	adc    $0x0,%edx
  800ae8:	f7 da                	neg    %edx
  800aea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aed:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800af0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800af7:	e9 bc 00 00 00       	jmp    800bb8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800afc:	83 ec 08             	sub    $0x8,%esp
  800aff:	ff 75 e8             	pushl  -0x18(%ebp)
  800b02:	8d 45 14             	lea    0x14(%ebp),%eax
  800b05:	50                   	push   %eax
  800b06:	e8 84 fc ff ff       	call   80078f <getuint>
  800b0b:	83 c4 10             	add    $0x10,%esp
  800b0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b11:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b14:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b1b:	e9 98 00 00 00       	jmp    800bb8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b20:	83 ec 08             	sub    $0x8,%esp
  800b23:	ff 75 0c             	pushl  0xc(%ebp)
  800b26:	6a 58                	push   $0x58
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	ff d0                	call   *%eax
  800b2d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b30:	83 ec 08             	sub    $0x8,%esp
  800b33:	ff 75 0c             	pushl  0xc(%ebp)
  800b36:	6a 58                	push   $0x58
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	ff d0                	call   *%eax
  800b3d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b40:	83 ec 08             	sub    $0x8,%esp
  800b43:	ff 75 0c             	pushl  0xc(%ebp)
  800b46:	6a 58                	push   $0x58
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	ff d0                	call   *%eax
  800b4d:	83 c4 10             	add    $0x10,%esp
			break;
  800b50:	e9 bc 00 00 00       	jmp    800c11 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b55:	83 ec 08             	sub    $0x8,%esp
  800b58:	ff 75 0c             	pushl  0xc(%ebp)
  800b5b:	6a 30                	push   $0x30
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	ff d0                	call   *%eax
  800b62:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b65:	83 ec 08             	sub    $0x8,%esp
  800b68:	ff 75 0c             	pushl  0xc(%ebp)
  800b6b:	6a 78                	push   $0x78
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	ff d0                	call   *%eax
  800b72:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b75:	8b 45 14             	mov    0x14(%ebp),%eax
  800b78:	83 c0 04             	add    $0x4,%eax
  800b7b:	89 45 14             	mov    %eax,0x14(%ebp)
  800b7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800b81:	83 e8 04             	sub    $0x4,%eax
  800b84:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b89:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b90:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b97:	eb 1f                	jmp    800bb8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b99:	83 ec 08             	sub    $0x8,%esp
  800b9c:	ff 75 e8             	pushl  -0x18(%ebp)
  800b9f:	8d 45 14             	lea    0x14(%ebp),%eax
  800ba2:	50                   	push   %eax
  800ba3:	e8 e7 fb ff ff       	call   80078f <getuint>
  800ba8:	83 c4 10             	add    $0x10,%esp
  800bab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bae:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bb1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bb8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bbf:	83 ec 04             	sub    $0x4,%esp
  800bc2:	52                   	push   %edx
  800bc3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bc6:	50                   	push   %eax
  800bc7:	ff 75 f4             	pushl  -0xc(%ebp)
  800bca:	ff 75 f0             	pushl  -0x10(%ebp)
  800bcd:	ff 75 0c             	pushl  0xc(%ebp)
  800bd0:	ff 75 08             	pushl  0x8(%ebp)
  800bd3:	e8 00 fb ff ff       	call   8006d8 <printnum>
  800bd8:	83 c4 20             	add    $0x20,%esp
			break;
  800bdb:	eb 34                	jmp    800c11 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bdd:	83 ec 08             	sub    $0x8,%esp
  800be0:	ff 75 0c             	pushl  0xc(%ebp)
  800be3:	53                   	push   %ebx
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	ff d0                	call   *%eax
  800be9:	83 c4 10             	add    $0x10,%esp
			break;
  800bec:	eb 23                	jmp    800c11 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bee:	83 ec 08             	sub    $0x8,%esp
  800bf1:	ff 75 0c             	pushl  0xc(%ebp)
  800bf4:	6a 25                	push   $0x25
  800bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf9:	ff d0                	call   *%eax
  800bfb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bfe:	ff 4d 10             	decl   0x10(%ebp)
  800c01:	eb 03                	jmp    800c06 <vprintfmt+0x3b1>
  800c03:	ff 4d 10             	decl   0x10(%ebp)
  800c06:	8b 45 10             	mov    0x10(%ebp),%eax
  800c09:	48                   	dec    %eax
  800c0a:	8a 00                	mov    (%eax),%al
  800c0c:	3c 25                	cmp    $0x25,%al
  800c0e:	75 f3                	jne    800c03 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c10:	90                   	nop
		}
	}
  800c11:	e9 47 fc ff ff       	jmp    80085d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c16:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c17:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c1a:	5b                   	pop    %ebx
  800c1b:	5e                   	pop    %esi
  800c1c:	5d                   	pop    %ebp
  800c1d:	c3                   	ret    

00800c1e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c1e:	55                   	push   %ebp
  800c1f:	89 e5                	mov    %esp,%ebp
  800c21:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c24:	8d 45 10             	lea    0x10(%ebp),%eax
  800c27:	83 c0 04             	add    $0x4,%eax
  800c2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c30:	ff 75 f4             	pushl  -0xc(%ebp)
  800c33:	50                   	push   %eax
  800c34:	ff 75 0c             	pushl  0xc(%ebp)
  800c37:	ff 75 08             	pushl  0x8(%ebp)
  800c3a:	e8 16 fc ff ff       	call   800855 <vprintfmt>
  800c3f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c42:	90                   	nop
  800c43:	c9                   	leave  
  800c44:	c3                   	ret    

00800c45 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c45:	55                   	push   %ebp
  800c46:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4b:	8b 40 08             	mov    0x8(%eax),%eax
  800c4e:	8d 50 01             	lea    0x1(%eax),%edx
  800c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c54:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5a:	8b 10                	mov    (%eax),%edx
  800c5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5f:	8b 40 04             	mov    0x4(%eax),%eax
  800c62:	39 c2                	cmp    %eax,%edx
  800c64:	73 12                	jae    800c78 <sprintputch+0x33>
		*b->buf++ = ch;
  800c66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c69:	8b 00                	mov    (%eax),%eax
  800c6b:	8d 48 01             	lea    0x1(%eax),%ecx
  800c6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c71:	89 0a                	mov    %ecx,(%edx)
  800c73:	8b 55 08             	mov    0x8(%ebp),%edx
  800c76:	88 10                	mov    %dl,(%eax)
}
  800c78:	90                   	nop
  800c79:	5d                   	pop    %ebp
  800c7a:	c3                   	ret    

00800c7b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c7b:	55                   	push   %ebp
  800c7c:	89 e5                	mov    %esp,%ebp
  800c7e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	01 d0                	add    %edx,%eax
  800c92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c9c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ca0:	74 06                	je     800ca8 <vsnprintf+0x2d>
  800ca2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ca6:	7f 07                	jg     800caf <vsnprintf+0x34>
		return -E_INVAL;
  800ca8:	b8 03 00 00 00       	mov    $0x3,%eax
  800cad:	eb 20                	jmp    800ccf <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800caf:	ff 75 14             	pushl  0x14(%ebp)
  800cb2:	ff 75 10             	pushl  0x10(%ebp)
  800cb5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cb8:	50                   	push   %eax
  800cb9:	68 45 0c 80 00       	push   $0x800c45
  800cbe:	e8 92 fb ff ff       	call   800855 <vprintfmt>
  800cc3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cc9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ccc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ccf:	c9                   	leave  
  800cd0:	c3                   	ret    

00800cd1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800cd1:	55                   	push   %ebp
  800cd2:	89 e5                	mov    %esp,%ebp
  800cd4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cd7:	8d 45 10             	lea    0x10(%ebp),%eax
  800cda:	83 c0 04             	add    $0x4,%eax
  800cdd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ce0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce3:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce6:	50                   	push   %eax
  800ce7:	ff 75 0c             	pushl  0xc(%ebp)
  800cea:	ff 75 08             	pushl  0x8(%ebp)
  800ced:	e8 89 ff ff ff       	call   800c7b <vsnprintf>
  800cf2:	83 c4 10             	add    $0x10,%esp
  800cf5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cf8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cfb:	c9                   	leave  
  800cfc:	c3                   	ret    

00800cfd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
  800d00:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d03:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d0a:	eb 06                	jmp    800d12 <strlen+0x15>
		n++;
  800d0c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d0f:	ff 45 08             	incl   0x8(%ebp)
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
  800d15:	8a 00                	mov    (%eax),%al
  800d17:	84 c0                	test   %al,%al
  800d19:	75 f1                	jne    800d0c <strlen+0xf>
		n++;
	return n;
  800d1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d1e:	c9                   	leave  
  800d1f:	c3                   	ret    

00800d20 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d20:	55                   	push   %ebp
  800d21:	89 e5                	mov    %esp,%ebp
  800d23:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d26:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d2d:	eb 09                	jmp    800d38 <strnlen+0x18>
		n++;
  800d2f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d32:	ff 45 08             	incl   0x8(%ebp)
  800d35:	ff 4d 0c             	decl   0xc(%ebp)
  800d38:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d3c:	74 09                	je     800d47 <strnlen+0x27>
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8a 00                	mov    (%eax),%al
  800d43:	84 c0                	test   %al,%al
  800d45:	75 e8                	jne    800d2f <strnlen+0xf>
		n++;
	return n;
  800d47:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d4a:	c9                   	leave  
  800d4b:	c3                   	ret    

00800d4c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d4c:	55                   	push   %ebp
  800d4d:	89 e5                	mov    %esp,%ebp
  800d4f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d58:	90                   	nop
  800d59:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5c:	8d 50 01             	lea    0x1(%eax),%edx
  800d5f:	89 55 08             	mov    %edx,0x8(%ebp)
  800d62:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d65:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d68:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d6b:	8a 12                	mov    (%edx),%dl
  800d6d:	88 10                	mov    %dl,(%eax)
  800d6f:	8a 00                	mov    (%eax),%al
  800d71:	84 c0                	test   %al,%al
  800d73:	75 e4                	jne    800d59 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d75:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d78:	c9                   	leave  
  800d79:	c3                   	ret    

00800d7a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d7a:	55                   	push   %ebp
  800d7b:	89 e5                	mov    %esp,%ebp
  800d7d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d8d:	eb 1f                	jmp    800dae <strncpy+0x34>
		*dst++ = *src;
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	8d 50 01             	lea    0x1(%eax),%edx
  800d95:	89 55 08             	mov    %edx,0x8(%ebp)
  800d98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d9b:	8a 12                	mov    (%edx),%dl
  800d9d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da2:	8a 00                	mov    (%eax),%al
  800da4:	84 c0                	test   %al,%al
  800da6:	74 03                	je     800dab <strncpy+0x31>
			src++;
  800da8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800dab:	ff 45 fc             	incl   -0x4(%ebp)
  800dae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db1:	3b 45 10             	cmp    0x10(%ebp),%eax
  800db4:	72 d9                	jb     800d8f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800db6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800db9:	c9                   	leave  
  800dba:	c3                   	ret    

00800dbb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dbb:	55                   	push   %ebp
  800dbc:	89 e5                	mov    %esp,%ebp
  800dbe:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dc7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dcb:	74 30                	je     800dfd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dcd:	eb 16                	jmp    800de5 <strlcpy+0x2a>
			*dst++ = *src++;
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	8d 50 01             	lea    0x1(%eax),%edx
  800dd5:	89 55 08             	mov    %edx,0x8(%ebp)
  800dd8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ddb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dde:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800de1:	8a 12                	mov    (%edx),%dl
  800de3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800de5:	ff 4d 10             	decl   0x10(%ebp)
  800de8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dec:	74 09                	je     800df7 <strlcpy+0x3c>
  800dee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df1:	8a 00                	mov    (%eax),%al
  800df3:	84 c0                	test   %al,%al
  800df5:	75 d8                	jne    800dcf <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800dfd:	8b 55 08             	mov    0x8(%ebp),%edx
  800e00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e03:	29 c2                	sub    %eax,%edx
  800e05:	89 d0                	mov    %edx,%eax
}
  800e07:	c9                   	leave  
  800e08:	c3                   	ret    

00800e09 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e09:	55                   	push   %ebp
  800e0a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e0c:	eb 06                	jmp    800e14 <strcmp+0xb>
		p++, q++;
  800e0e:	ff 45 08             	incl   0x8(%ebp)
  800e11:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
  800e17:	8a 00                	mov    (%eax),%al
  800e19:	84 c0                	test   %al,%al
  800e1b:	74 0e                	je     800e2b <strcmp+0x22>
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	8a 10                	mov    (%eax),%dl
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	8a 00                	mov    (%eax),%al
  800e27:	38 c2                	cmp    %al,%dl
  800e29:	74 e3                	je     800e0e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	8a 00                	mov    (%eax),%al
  800e30:	0f b6 d0             	movzbl %al,%edx
  800e33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e36:	8a 00                	mov    (%eax),%al
  800e38:	0f b6 c0             	movzbl %al,%eax
  800e3b:	29 c2                	sub    %eax,%edx
  800e3d:	89 d0                	mov    %edx,%eax
}
  800e3f:	5d                   	pop    %ebp
  800e40:	c3                   	ret    

00800e41 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e41:	55                   	push   %ebp
  800e42:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e44:	eb 09                	jmp    800e4f <strncmp+0xe>
		n--, p++, q++;
  800e46:	ff 4d 10             	decl   0x10(%ebp)
  800e49:	ff 45 08             	incl   0x8(%ebp)
  800e4c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e53:	74 17                	je     800e6c <strncmp+0x2b>
  800e55:	8b 45 08             	mov    0x8(%ebp),%eax
  800e58:	8a 00                	mov    (%eax),%al
  800e5a:	84 c0                	test   %al,%al
  800e5c:	74 0e                	je     800e6c <strncmp+0x2b>
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	8a 10                	mov    (%eax),%dl
  800e63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e66:	8a 00                	mov    (%eax),%al
  800e68:	38 c2                	cmp    %al,%dl
  800e6a:	74 da                	je     800e46 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e6c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e70:	75 07                	jne    800e79 <strncmp+0x38>
		return 0;
  800e72:	b8 00 00 00 00       	mov    $0x0,%eax
  800e77:	eb 14                	jmp    800e8d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e79:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7c:	8a 00                	mov    (%eax),%al
  800e7e:	0f b6 d0             	movzbl %al,%edx
  800e81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e84:	8a 00                	mov    (%eax),%al
  800e86:	0f b6 c0             	movzbl %al,%eax
  800e89:	29 c2                	sub    %eax,%edx
  800e8b:	89 d0                	mov    %edx,%eax
}
  800e8d:	5d                   	pop    %ebp
  800e8e:	c3                   	ret    

00800e8f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e8f:	55                   	push   %ebp
  800e90:	89 e5                	mov    %esp,%ebp
  800e92:	83 ec 04             	sub    $0x4,%esp
  800e95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e98:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e9b:	eb 12                	jmp    800eaf <strchr+0x20>
		if (*s == c)
  800e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea0:	8a 00                	mov    (%eax),%al
  800ea2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ea5:	75 05                	jne    800eac <strchr+0x1d>
			return (char *) s;
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	eb 11                	jmp    800ebd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800eac:	ff 45 08             	incl   0x8(%ebp)
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	84 c0                	test   %al,%al
  800eb6:	75 e5                	jne    800e9d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800eb8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ebd:	c9                   	leave  
  800ebe:	c3                   	ret    

00800ebf <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ebf:	55                   	push   %ebp
  800ec0:	89 e5                	mov    %esp,%ebp
  800ec2:	83 ec 04             	sub    $0x4,%esp
  800ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ecb:	eb 0d                	jmp    800eda <strfind+0x1b>
		if (*s == c)
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	8a 00                	mov    (%eax),%al
  800ed2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ed5:	74 0e                	je     800ee5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ed7:	ff 45 08             	incl   0x8(%ebp)
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	8a 00                	mov    (%eax),%al
  800edf:	84 c0                	test   %al,%al
  800ee1:	75 ea                	jne    800ecd <strfind+0xe>
  800ee3:	eb 01                	jmp    800ee6 <strfind+0x27>
		if (*s == c)
			break;
  800ee5:	90                   	nop
	return (char *) s;
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee9:	c9                   	leave  
  800eea:	c3                   	ret    

00800eeb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800eeb:	55                   	push   %ebp
  800eec:	89 e5                	mov    %esp,%ebp
  800eee:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ef1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ef7:	8b 45 10             	mov    0x10(%ebp),%eax
  800efa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800efd:	eb 0e                	jmp    800f0d <memset+0x22>
		*p++ = c;
  800eff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f02:	8d 50 01             	lea    0x1(%eax),%edx
  800f05:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f08:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f0b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f0d:	ff 4d f8             	decl   -0x8(%ebp)
  800f10:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f14:	79 e9                	jns    800eff <memset+0x14>
		*p++ = c;

	return v;
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f19:	c9                   	leave  
  800f1a:	c3                   	ret    

00800f1b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f1b:	55                   	push   %ebp
  800f1c:	89 e5                	mov    %esp,%ebp
  800f1e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f2d:	eb 16                	jmp    800f45 <memcpy+0x2a>
		*d++ = *s++;
  800f2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f32:	8d 50 01             	lea    0x1(%eax),%edx
  800f35:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f38:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f3b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f3e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f41:	8a 12                	mov    (%edx),%dl
  800f43:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f45:	8b 45 10             	mov    0x10(%ebp),%eax
  800f48:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f4b:	89 55 10             	mov    %edx,0x10(%ebp)
  800f4e:	85 c0                	test   %eax,%eax
  800f50:	75 dd                	jne    800f2f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f55:	c9                   	leave  
  800f56:	c3                   	ret    

00800f57 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f57:	55                   	push   %ebp
  800f58:	89 e5                	mov    %esp,%ebp
  800f5a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800f5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f6c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f6f:	73 50                	jae    800fc1 <memmove+0x6a>
  800f71:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f74:	8b 45 10             	mov    0x10(%ebp),%eax
  800f77:	01 d0                	add    %edx,%eax
  800f79:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f7c:	76 43                	jbe    800fc1 <memmove+0x6a>
		s += n;
  800f7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f81:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f84:	8b 45 10             	mov    0x10(%ebp),%eax
  800f87:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f8a:	eb 10                	jmp    800f9c <memmove+0x45>
			*--d = *--s;
  800f8c:	ff 4d f8             	decl   -0x8(%ebp)
  800f8f:	ff 4d fc             	decl   -0x4(%ebp)
  800f92:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f95:	8a 10                	mov    (%eax),%dl
  800f97:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f9c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fa2:	89 55 10             	mov    %edx,0x10(%ebp)
  800fa5:	85 c0                	test   %eax,%eax
  800fa7:	75 e3                	jne    800f8c <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fa9:	eb 23                	jmp    800fce <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fae:	8d 50 01             	lea    0x1(%eax),%edx
  800fb1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fb4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fb7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fba:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fbd:	8a 12                	mov    (%edx),%dl
  800fbf:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fc1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc7:	89 55 10             	mov    %edx,0x10(%ebp)
  800fca:	85 c0                	test   %eax,%eax
  800fcc:	75 dd                	jne    800fab <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fd1:	c9                   	leave  
  800fd2:	c3                   	ret    

00800fd3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fd3:	55                   	push   %ebp
  800fd4:	89 e5                	mov    %esp,%ebp
  800fd6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fe5:	eb 2a                	jmp    801011 <memcmp+0x3e>
		if (*s1 != *s2)
  800fe7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fea:	8a 10                	mov    (%eax),%dl
  800fec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	38 c2                	cmp    %al,%dl
  800ff3:	74 16                	je     80100b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ff5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff8:	8a 00                	mov    (%eax),%al
  800ffa:	0f b6 d0             	movzbl %al,%edx
  800ffd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	0f b6 c0             	movzbl %al,%eax
  801005:	29 c2                	sub    %eax,%edx
  801007:	89 d0                	mov    %edx,%eax
  801009:	eb 18                	jmp    801023 <memcmp+0x50>
		s1++, s2++;
  80100b:	ff 45 fc             	incl   -0x4(%ebp)
  80100e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801011:	8b 45 10             	mov    0x10(%ebp),%eax
  801014:	8d 50 ff             	lea    -0x1(%eax),%edx
  801017:	89 55 10             	mov    %edx,0x10(%ebp)
  80101a:	85 c0                	test   %eax,%eax
  80101c:	75 c9                	jne    800fe7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80101e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801023:	c9                   	leave  
  801024:	c3                   	ret    

00801025 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801025:	55                   	push   %ebp
  801026:	89 e5                	mov    %esp,%ebp
  801028:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80102b:	8b 55 08             	mov    0x8(%ebp),%edx
  80102e:	8b 45 10             	mov    0x10(%ebp),%eax
  801031:	01 d0                	add    %edx,%eax
  801033:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801036:	eb 15                	jmp    80104d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801038:	8b 45 08             	mov    0x8(%ebp),%eax
  80103b:	8a 00                	mov    (%eax),%al
  80103d:	0f b6 d0             	movzbl %al,%edx
  801040:	8b 45 0c             	mov    0xc(%ebp),%eax
  801043:	0f b6 c0             	movzbl %al,%eax
  801046:	39 c2                	cmp    %eax,%edx
  801048:	74 0d                	je     801057 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80104a:	ff 45 08             	incl   0x8(%ebp)
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801053:	72 e3                	jb     801038 <memfind+0x13>
  801055:	eb 01                	jmp    801058 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801057:	90                   	nop
	return (void *) s;
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80105b:	c9                   	leave  
  80105c:	c3                   	ret    

0080105d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80105d:	55                   	push   %ebp
  80105e:	89 e5                	mov    %esp,%ebp
  801060:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801063:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80106a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801071:	eb 03                	jmp    801076 <strtol+0x19>
		s++;
  801073:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	8a 00                	mov    (%eax),%al
  80107b:	3c 20                	cmp    $0x20,%al
  80107d:	74 f4                	je     801073 <strtol+0x16>
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 00                	mov    (%eax),%al
  801084:	3c 09                	cmp    $0x9,%al
  801086:	74 eb                	je     801073 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	8a 00                	mov    (%eax),%al
  80108d:	3c 2b                	cmp    $0x2b,%al
  80108f:	75 05                	jne    801096 <strtol+0x39>
		s++;
  801091:	ff 45 08             	incl   0x8(%ebp)
  801094:	eb 13                	jmp    8010a9 <strtol+0x4c>
	else if (*s == '-')
  801096:	8b 45 08             	mov    0x8(%ebp),%eax
  801099:	8a 00                	mov    (%eax),%al
  80109b:	3c 2d                	cmp    $0x2d,%al
  80109d:	75 0a                	jne    8010a9 <strtol+0x4c>
		s++, neg = 1;
  80109f:	ff 45 08             	incl   0x8(%ebp)
  8010a2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ad:	74 06                	je     8010b5 <strtol+0x58>
  8010af:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010b3:	75 20                	jne    8010d5 <strtol+0x78>
  8010b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b8:	8a 00                	mov    (%eax),%al
  8010ba:	3c 30                	cmp    $0x30,%al
  8010bc:	75 17                	jne    8010d5 <strtol+0x78>
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	40                   	inc    %eax
  8010c2:	8a 00                	mov    (%eax),%al
  8010c4:	3c 78                	cmp    $0x78,%al
  8010c6:	75 0d                	jne    8010d5 <strtol+0x78>
		s += 2, base = 16;
  8010c8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010cc:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010d3:	eb 28                	jmp    8010fd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010d9:	75 15                	jne    8010f0 <strtol+0x93>
  8010db:	8b 45 08             	mov    0x8(%ebp),%eax
  8010de:	8a 00                	mov    (%eax),%al
  8010e0:	3c 30                	cmp    $0x30,%al
  8010e2:	75 0c                	jne    8010f0 <strtol+0x93>
		s++, base = 8;
  8010e4:	ff 45 08             	incl   0x8(%ebp)
  8010e7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010ee:	eb 0d                	jmp    8010fd <strtol+0xa0>
	else if (base == 0)
  8010f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f4:	75 07                	jne    8010fd <strtol+0xa0>
		base = 10;
  8010f6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	8a 00                	mov    (%eax),%al
  801102:	3c 2f                	cmp    $0x2f,%al
  801104:	7e 19                	jle    80111f <strtol+0xc2>
  801106:	8b 45 08             	mov    0x8(%ebp),%eax
  801109:	8a 00                	mov    (%eax),%al
  80110b:	3c 39                	cmp    $0x39,%al
  80110d:	7f 10                	jg     80111f <strtol+0xc2>
			dig = *s - '0';
  80110f:	8b 45 08             	mov    0x8(%ebp),%eax
  801112:	8a 00                	mov    (%eax),%al
  801114:	0f be c0             	movsbl %al,%eax
  801117:	83 e8 30             	sub    $0x30,%eax
  80111a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80111d:	eb 42                	jmp    801161 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80111f:	8b 45 08             	mov    0x8(%ebp),%eax
  801122:	8a 00                	mov    (%eax),%al
  801124:	3c 60                	cmp    $0x60,%al
  801126:	7e 19                	jle    801141 <strtol+0xe4>
  801128:	8b 45 08             	mov    0x8(%ebp),%eax
  80112b:	8a 00                	mov    (%eax),%al
  80112d:	3c 7a                	cmp    $0x7a,%al
  80112f:	7f 10                	jg     801141 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	8a 00                	mov    (%eax),%al
  801136:	0f be c0             	movsbl %al,%eax
  801139:	83 e8 57             	sub    $0x57,%eax
  80113c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80113f:	eb 20                	jmp    801161 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801141:	8b 45 08             	mov    0x8(%ebp),%eax
  801144:	8a 00                	mov    (%eax),%al
  801146:	3c 40                	cmp    $0x40,%al
  801148:	7e 39                	jle    801183 <strtol+0x126>
  80114a:	8b 45 08             	mov    0x8(%ebp),%eax
  80114d:	8a 00                	mov    (%eax),%al
  80114f:	3c 5a                	cmp    $0x5a,%al
  801151:	7f 30                	jg     801183 <strtol+0x126>
			dig = *s - 'A' + 10;
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	8a 00                	mov    (%eax),%al
  801158:	0f be c0             	movsbl %al,%eax
  80115b:	83 e8 37             	sub    $0x37,%eax
  80115e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801161:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801164:	3b 45 10             	cmp    0x10(%ebp),%eax
  801167:	7d 19                	jge    801182 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801169:	ff 45 08             	incl   0x8(%ebp)
  80116c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80116f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801173:	89 c2                	mov    %eax,%edx
  801175:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801178:	01 d0                	add    %edx,%eax
  80117a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80117d:	e9 7b ff ff ff       	jmp    8010fd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801182:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801183:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801187:	74 08                	je     801191 <strtol+0x134>
		*endptr = (char *) s;
  801189:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118c:	8b 55 08             	mov    0x8(%ebp),%edx
  80118f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801191:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801195:	74 07                	je     80119e <strtol+0x141>
  801197:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80119a:	f7 d8                	neg    %eax
  80119c:	eb 03                	jmp    8011a1 <strtol+0x144>
  80119e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011a1:	c9                   	leave  
  8011a2:	c3                   	ret    

008011a3 <ltostr>:

void
ltostr(long value, char *str)
{
  8011a3:	55                   	push   %ebp
  8011a4:	89 e5                	mov    %esp,%ebp
  8011a6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011bb:	79 13                	jns    8011d0 <ltostr+0x2d>
	{
		neg = 1;
  8011bd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011ca:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011cd:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011d8:	99                   	cltd   
  8011d9:	f7 f9                	idiv   %ecx
  8011db:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e1:	8d 50 01             	lea    0x1(%eax),%edx
  8011e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011e7:	89 c2                	mov    %eax,%edx
  8011e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ec:	01 d0                	add    %edx,%eax
  8011ee:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011f1:	83 c2 30             	add    $0x30,%edx
  8011f4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011f9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011fe:	f7 e9                	imul   %ecx
  801200:	c1 fa 02             	sar    $0x2,%edx
  801203:	89 c8                	mov    %ecx,%eax
  801205:	c1 f8 1f             	sar    $0x1f,%eax
  801208:	29 c2                	sub    %eax,%edx
  80120a:	89 d0                	mov    %edx,%eax
  80120c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80120f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801212:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801217:	f7 e9                	imul   %ecx
  801219:	c1 fa 02             	sar    $0x2,%edx
  80121c:	89 c8                	mov    %ecx,%eax
  80121e:	c1 f8 1f             	sar    $0x1f,%eax
  801221:	29 c2                	sub    %eax,%edx
  801223:	89 d0                	mov    %edx,%eax
  801225:	c1 e0 02             	shl    $0x2,%eax
  801228:	01 d0                	add    %edx,%eax
  80122a:	01 c0                	add    %eax,%eax
  80122c:	29 c1                	sub    %eax,%ecx
  80122e:	89 ca                	mov    %ecx,%edx
  801230:	85 d2                	test   %edx,%edx
  801232:	75 9c                	jne    8011d0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801234:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80123b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80123e:	48                   	dec    %eax
  80123f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801242:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801246:	74 3d                	je     801285 <ltostr+0xe2>
		start = 1 ;
  801248:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80124f:	eb 34                	jmp    801285 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801251:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801254:	8b 45 0c             	mov    0xc(%ebp),%eax
  801257:	01 d0                	add    %edx,%eax
  801259:	8a 00                	mov    (%eax),%al
  80125b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80125e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801261:	8b 45 0c             	mov    0xc(%ebp),%eax
  801264:	01 c2                	add    %eax,%edx
  801266:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801269:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126c:	01 c8                	add    %ecx,%eax
  80126e:	8a 00                	mov    (%eax),%al
  801270:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801272:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801275:	8b 45 0c             	mov    0xc(%ebp),%eax
  801278:	01 c2                	add    %eax,%edx
  80127a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80127d:	88 02                	mov    %al,(%edx)
		start++ ;
  80127f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801282:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801285:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801288:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80128b:	7c c4                	jl     801251 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80128d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801290:	8b 45 0c             	mov    0xc(%ebp),%eax
  801293:	01 d0                	add    %edx,%eax
  801295:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801298:	90                   	nop
  801299:	c9                   	leave  
  80129a:	c3                   	ret    

0080129b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80129b:	55                   	push   %ebp
  80129c:	89 e5                	mov    %esp,%ebp
  80129e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012a1:	ff 75 08             	pushl  0x8(%ebp)
  8012a4:	e8 54 fa ff ff       	call   800cfd <strlen>
  8012a9:	83 c4 04             	add    $0x4,%esp
  8012ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012af:	ff 75 0c             	pushl  0xc(%ebp)
  8012b2:	e8 46 fa ff ff       	call   800cfd <strlen>
  8012b7:	83 c4 04             	add    $0x4,%esp
  8012ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012cb:	eb 17                	jmp    8012e4 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d3:	01 c2                	add    %eax,%edx
  8012d5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	01 c8                	add    %ecx,%eax
  8012dd:	8a 00                	mov    (%eax),%al
  8012df:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012e1:	ff 45 fc             	incl   -0x4(%ebp)
  8012e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012ea:	7c e1                	jl     8012cd <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012f3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012fa:	eb 1f                	jmp    80131b <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ff:	8d 50 01             	lea    0x1(%eax),%edx
  801302:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801305:	89 c2                	mov    %eax,%edx
  801307:	8b 45 10             	mov    0x10(%ebp),%eax
  80130a:	01 c2                	add    %eax,%edx
  80130c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80130f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801312:	01 c8                	add    %ecx,%eax
  801314:	8a 00                	mov    (%eax),%al
  801316:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801318:	ff 45 f8             	incl   -0x8(%ebp)
  80131b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80131e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801321:	7c d9                	jl     8012fc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801323:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801326:	8b 45 10             	mov    0x10(%ebp),%eax
  801329:	01 d0                	add    %edx,%eax
  80132b:	c6 00 00             	movb   $0x0,(%eax)
}
  80132e:	90                   	nop
  80132f:	c9                   	leave  
  801330:	c3                   	ret    

00801331 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801331:	55                   	push   %ebp
  801332:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801334:	8b 45 14             	mov    0x14(%ebp),%eax
  801337:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80133d:	8b 45 14             	mov    0x14(%ebp),%eax
  801340:	8b 00                	mov    (%eax),%eax
  801342:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801349:	8b 45 10             	mov    0x10(%ebp),%eax
  80134c:	01 d0                	add    %edx,%eax
  80134e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801354:	eb 0c                	jmp    801362 <strsplit+0x31>
			*string++ = 0;
  801356:	8b 45 08             	mov    0x8(%ebp),%eax
  801359:	8d 50 01             	lea    0x1(%eax),%edx
  80135c:	89 55 08             	mov    %edx,0x8(%ebp)
  80135f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	8a 00                	mov    (%eax),%al
  801367:	84 c0                	test   %al,%al
  801369:	74 18                	je     801383 <strsplit+0x52>
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	8a 00                	mov    (%eax),%al
  801370:	0f be c0             	movsbl %al,%eax
  801373:	50                   	push   %eax
  801374:	ff 75 0c             	pushl  0xc(%ebp)
  801377:	e8 13 fb ff ff       	call   800e8f <strchr>
  80137c:	83 c4 08             	add    $0x8,%esp
  80137f:	85 c0                	test   %eax,%eax
  801381:	75 d3                	jne    801356 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801383:	8b 45 08             	mov    0x8(%ebp),%eax
  801386:	8a 00                	mov    (%eax),%al
  801388:	84 c0                	test   %al,%al
  80138a:	74 5a                	je     8013e6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80138c:	8b 45 14             	mov    0x14(%ebp),%eax
  80138f:	8b 00                	mov    (%eax),%eax
  801391:	83 f8 0f             	cmp    $0xf,%eax
  801394:	75 07                	jne    80139d <strsplit+0x6c>
		{
			return 0;
  801396:	b8 00 00 00 00       	mov    $0x0,%eax
  80139b:	eb 66                	jmp    801403 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80139d:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a0:	8b 00                	mov    (%eax),%eax
  8013a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8013a5:	8b 55 14             	mov    0x14(%ebp),%edx
  8013a8:	89 0a                	mov    %ecx,(%edx)
  8013aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b4:	01 c2                	add    %eax,%edx
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013bb:	eb 03                	jmp    8013c0 <strsplit+0x8f>
			string++;
  8013bd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	8a 00                	mov    (%eax),%al
  8013c5:	84 c0                	test   %al,%al
  8013c7:	74 8b                	je     801354 <strsplit+0x23>
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	8a 00                	mov    (%eax),%al
  8013ce:	0f be c0             	movsbl %al,%eax
  8013d1:	50                   	push   %eax
  8013d2:	ff 75 0c             	pushl  0xc(%ebp)
  8013d5:	e8 b5 fa ff ff       	call   800e8f <strchr>
  8013da:	83 c4 08             	add    $0x8,%esp
  8013dd:	85 c0                	test   %eax,%eax
  8013df:	74 dc                	je     8013bd <strsplit+0x8c>
			string++;
	}
  8013e1:	e9 6e ff ff ff       	jmp    801354 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013e6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8013ea:	8b 00                	mov    (%eax),%eax
  8013ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f6:	01 d0                	add    %edx,%eax
  8013f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013fe:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801403:	c9                   	leave  
  801404:	c3                   	ret    

00801405 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801405:	55                   	push   %ebp
  801406:	89 e5                	mov    %esp,%ebp
  801408:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  80140b:	e8 9b 07 00 00       	call   801bab <sys_isUHeapPlacementStrategyNEXTFIT>
  801410:	85 c0                	test   %eax,%eax
  801412:	0f 84 64 01 00 00    	je     80157c <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801418:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  80141e:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801425:	8b 55 08             	mov    0x8(%ebp),%edx
  801428:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80142b:	01 d0                	add    %edx,%eax
  80142d:	48                   	dec    %eax
  80142e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801431:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801434:	ba 00 00 00 00       	mov    $0x0,%edx
  801439:	f7 75 e8             	divl   -0x18(%ebp)
  80143c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80143f:	29 d0                	sub    %edx,%eax
  801441:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801448:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	01 d0                	add    %edx,%eax
  801453:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801456:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  80145d:	a1 28 30 80 00       	mov    0x803028,%eax
  801462:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801469:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80146c:	0f 83 0a 01 00 00    	jae    80157c <malloc+0x177>
  801472:	a1 28 30 80 00       	mov    0x803028,%eax
  801477:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80147e:	85 c0                	test   %eax,%eax
  801480:	0f 84 f6 00 00 00    	je     80157c <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801486:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80148d:	e9 dc 00 00 00       	jmp    80156e <malloc+0x169>
				flag++;
  801492:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801495:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801498:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80149f:	85 c0                	test   %eax,%eax
  8014a1:	74 07                	je     8014aa <malloc+0xa5>
					flag=0;
  8014a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  8014aa:	a1 28 30 80 00       	mov    0x803028,%eax
  8014af:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8014b6:	85 c0                	test   %eax,%eax
  8014b8:	79 05                	jns    8014bf <malloc+0xba>
  8014ba:	05 ff 0f 00 00       	add    $0xfff,%eax
  8014bf:	c1 f8 0c             	sar    $0xc,%eax
  8014c2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014c5:	0f 85 a0 00 00 00    	jne    80156b <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  8014cb:	a1 28 30 80 00       	mov    0x803028,%eax
  8014d0:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8014d7:	85 c0                	test   %eax,%eax
  8014d9:	79 05                	jns    8014e0 <malloc+0xdb>
  8014db:	05 ff 0f 00 00       	add    $0xfff,%eax
  8014e0:	c1 f8 0c             	sar    $0xc,%eax
  8014e3:	89 c2                	mov    %eax,%edx
  8014e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014e8:	29 d0                	sub    %edx,%eax
  8014ea:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  8014ed:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8014f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8014f3:	eb 11                	jmp    801506 <malloc+0x101>
						hFreeArr[j] = 1;
  8014f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014f8:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  8014ff:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801503:	ff 45 ec             	incl   -0x14(%ebp)
  801506:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801509:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80150c:	7e e7                	jle    8014f5 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  80150e:	a1 28 30 80 00       	mov    0x803028,%eax
  801513:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801516:	81 c2 01 00 08 00    	add    $0x80001,%edx
  80151c:	c1 e2 0c             	shl    $0xc,%edx
  80151f:	89 15 04 30 80 00    	mov    %edx,0x803004
  801525:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80152b:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801532:	a1 28 30 80 00       	mov    0x803028,%eax
  801537:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80153e:	89 c2                	mov    %eax,%edx
  801540:	a1 28 30 80 00       	mov    0x803028,%eax
  801545:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  80154c:	83 ec 08             	sub    $0x8,%esp
  80154f:	52                   	push   %edx
  801550:	50                   	push   %eax
  801551:	e8 8b 02 00 00       	call   8017e1 <sys_allocateMem>
  801556:	83 c4 10             	add    $0x10,%esp

					idx++;
  801559:	a1 28 30 80 00       	mov    0x803028,%eax
  80155e:	40                   	inc    %eax
  80155f:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  801564:	a1 04 30 80 00       	mov    0x803004,%eax
  801569:	eb 16                	jmp    801581 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  80156b:	ff 45 f0             	incl   -0x10(%ebp)
  80156e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801571:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801576:	0f 86 16 ff ff ff    	jbe    801492 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  80157c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801581:	c9                   	leave  
  801582:	c3                   	ret    

00801583 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801583:	55                   	push   %ebp
  801584:	89 e5                	mov    %esp,%ebp
  801586:	83 ec 18             	sub    $0x18,%esp
  801589:	8b 45 10             	mov    0x10(%ebp),%eax
  80158c:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  80158f:	83 ec 04             	sub    $0x4,%esp
  801592:	68 d0 26 80 00       	push   $0x8026d0
  801597:	6a 59                	push   $0x59
  801599:	68 ef 26 80 00       	push   $0x8026ef
  80159e:	e8 24 ee ff ff       	call   8003c7 <_panic>

008015a3 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8015a3:	55                   	push   %ebp
  8015a4:	89 e5                	mov    %esp,%ebp
  8015a6:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8015a9:	83 ec 04             	sub    $0x4,%esp
  8015ac:	68 fb 26 80 00       	push   $0x8026fb
  8015b1:	6a 5f                	push   $0x5f
  8015b3:	68 ef 26 80 00       	push   $0x8026ef
  8015b8:	e8 0a ee ff ff       	call   8003c7 <_panic>

008015bd <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
  8015c0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8015c3:	83 ec 04             	sub    $0x4,%esp
  8015c6:	68 18 27 80 00       	push   $0x802718
  8015cb:	6a 70                	push   $0x70
  8015cd:	68 ef 26 80 00       	push   $0x8026ef
  8015d2:	e8 f0 ed ff ff       	call   8003c7 <_panic>

008015d7 <sfree>:

}


void sfree(void* virtual_address)
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
  8015da:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8015dd:	83 ec 04             	sub    $0x4,%esp
  8015e0:	68 3b 27 80 00       	push   $0x80273b
  8015e5:	6a 7b                	push   $0x7b
  8015e7:	68 ef 26 80 00       	push   $0x8026ef
  8015ec:	e8 d6 ed ff ff       	call   8003c7 <_panic>

008015f1 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
  8015f4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8015f7:	83 ec 04             	sub    $0x4,%esp
  8015fa:	68 58 27 80 00       	push   $0x802758
  8015ff:	68 93 00 00 00       	push   $0x93
  801604:	68 ef 26 80 00       	push   $0x8026ef
  801609:	e8 b9 ed ff ff       	call   8003c7 <_panic>

0080160e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
  801611:	57                   	push   %edi
  801612:	56                   	push   %esi
  801613:	53                   	push   %ebx
  801614:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80161d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801620:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801623:	8b 7d 18             	mov    0x18(%ebp),%edi
  801626:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801629:	cd 30                	int    $0x30
  80162b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80162e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801631:	83 c4 10             	add    $0x10,%esp
  801634:	5b                   	pop    %ebx
  801635:	5e                   	pop    %esi
  801636:	5f                   	pop    %edi
  801637:	5d                   	pop    %ebp
  801638:	c3                   	ret    

00801639 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801639:	55                   	push   %ebp
  80163a:	89 e5                	mov    %esp,%ebp
  80163c:	83 ec 04             	sub    $0x4,%esp
  80163f:	8b 45 10             	mov    0x10(%ebp),%eax
  801642:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801645:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801649:	8b 45 08             	mov    0x8(%ebp),%eax
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	52                   	push   %edx
  801651:	ff 75 0c             	pushl  0xc(%ebp)
  801654:	50                   	push   %eax
  801655:	6a 00                	push   $0x0
  801657:	e8 b2 ff ff ff       	call   80160e <syscall>
  80165c:	83 c4 18             	add    $0x18,%esp
}
  80165f:	90                   	nop
  801660:	c9                   	leave  
  801661:	c3                   	ret    

00801662 <sys_cgetc>:

int
sys_cgetc(void)
{
  801662:	55                   	push   %ebp
  801663:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 01                	push   $0x1
  801671:	e8 98 ff ff ff       	call   80160e <syscall>
  801676:	83 c4 18             	add    $0x18,%esp
}
  801679:	c9                   	leave  
  80167a:	c3                   	ret    

0080167b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80167b:	55                   	push   %ebp
  80167c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	50                   	push   %eax
  80168a:	6a 05                	push   $0x5
  80168c:	e8 7d ff ff ff       	call   80160e <syscall>
  801691:	83 c4 18             	add    $0x18,%esp
}
  801694:	c9                   	leave  
  801695:	c3                   	ret    

00801696 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801696:	55                   	push   %ebp
  801697:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 02                	push   $0x2
  8016a5:	e8 64 ff ff ff       	call   80160e <syscall>
  8016aa:	83 c4 18             	add    $0x18,%esp
}
  8016ad:	c9                   	leave  
  8016ae:	c3                   	ret    

008016af <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8016af:	55                   	push   %ebp
  8016b0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 03                	push   $0x3
  8016be:	e8 4b ff ff ff       	call   80160e <syscall>
  8016c3:	83 c4 18             	add    $0x18,%esp
}
  8016c6:	c9                   	leave  
  8016c7:	c3                   	ret    

008016c8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016c8:	55                   	push   %ebp
  8016c9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 04                	push   $0x4
  8016d7:	e8 32 ff ff ff       	call   80160e <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
}
  8016df:	c9                   	leave  
  8016e0:	c3                   	ret    

008016e1 <sys_env_exit>:


void sys_env_exit(void)
{
  8016e1:	55                   	push   %ebp
  8016e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 06                	push   $0x6
  8016f0:	e8 19 ff ff ff       	call   80160e <syscall>
  8016f5:	83 c4 18             	add    $0x18,%esp
}
  8016f8:	90                   	nop
  8016f9:	c9                   	leave  
  8016fa:	c3                   	ret    

008016fb <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801701:	8b 45 08             	mov    0x8(%ebp),%eax
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	52                   	push   %edx
  80170b:	50                   	push   %eax
  80170c:	6a 07                	push   $0x7
  80170e:	e8 fb fe ff ff       	call   80160e <syscall>
  801713:	83 c4 18             	add    $0x18,%esp
}
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
  80171b:	56                   	push   %esi
  80171c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80171d:	8b 75 18             	mov    0x18(%ebp),%esi
  801720:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801723:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801726:	8b 55 0c             	mov    0xc(%ebp),%edx
  801729:	8b 45 08             	mov    0x8(%ebp),%eax
  80172c:	56                   	push   %esi
  80172d:	53                   	push   %ebx
  80172e:	51                   	push   %ecx
  80172f:	52                   	push   %edx
  801730:	50                   	push   %eax
  801731:	6a 08                	push   $0x8
  801733:	e8 d6 fe ff ff       	call   80160e <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
}
  80173b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80173e:	5b                   	pop    %ebx
  80173f:	5e                   	pop    %esi
  801740:	5d                   	pop    %ebp
  801741:	c3                   	ret    

00801742 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801745:	8b 55 0c             	mov    0xc(%ebp),%edx
  801748:	8b 45 08             	mov    0x8(%ebp),%eax
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	52                   	push   %edx
  801752:	50                   	push   %eax
  801753:	6a 09                	push   $0x9
  801755:	e8 b4 fe ff ff       	call   80160e <syscall>
  80175a:	83 c4 18             	add    $0x18,%esp
}
  80175d:	c9                   	leave  
  80175e:	c3                   	ret    

0080175f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80175f:	55                   	push   %ebp
  801760:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	ff 75 0c             	pushl  0xc(%ebp)
  80176b:	ff 75 08             	pushl  0x8(%ebp)
  80176e:	6a 0a                	push   $0xa
  801770:	e8 99 fe ff ff       	call   80160e <syscall>
  801775:	83 c4 18             	add    $0x18,%esp
}
  801778:	c9                   	leave  
  801779:	c3                   	ret    

0080177a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80177a:	55                   	push   %ebp
  80177b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 0b                	push   $0xb
  801789:	e8 80 fe ff ff       	call   80160e <syscall>
  80178e:	83 c4 18             	add    $0x18,%esp
}
  801791:	c9                   	leave  
  801792:	c3                   	ret    

00801793 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 0c                	push   $0xc
  8017a2:	e8 67 fe ff ff       	call   80160e <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
}
  8017aa:	c9                   	leave  
  8017ab:	c3                   	ret    

008017ac <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017ac:	55                   	push   %ebp
  8017ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 0d                	push   $0xd
  8017bb:	e8 4e fe ff ff       	call   80160e <syscall>
  8017c0:	83 c4 18             	add    $0x18,%esp
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	ff 75 0c             	pushl  0xc(%ebp)
  8017d1:	ff 75 08             	pushl  0x8(%ebp)
  8017d4:	6a 11                	push   $0x11
  8017d6:	e8 33 fe ff ff       	call   80160e <syscall>
  8017db:	83 c4 18             	add    $0x18,%esp
	return;
  8017de:	90                   	nop
}
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	ff 75 0c             	pushl  0xc(%ebp)
  8017ed:	ff 75 08             	pushl  0x8(%ebp)
  8017f0:	6a 12                	push   $0x12
  8017f2:	e8 17 fe ff ff       	call   80160e <syscall>
  8017f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017fa:	90                   	nop
}
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 0e                	push   $0xe
  80180c:	e8 fd fd ff ff       	call   80160e <syscall>
  801811:	83 c4 18             	add    $0x18,%esp
}
  801814:	c9                   	leave  
  801815:	c3                   	ret    

00801816 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801816:	55                   	push   %ebp
  801817:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	ff 75 08             	pushl  0x8(%ebp)
  801824:	6a 0f                	push   $0xf
  801826:	e8 e3 fd ff ff       	call   80160e <syscall>
  80182b:	83 c4 18             	add    $0x18,%esp
}
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 10                	push   $0x10
  80183f:	e8 ca fd ff ff       	call   80160e <syscall>
  801844:	83 c4 18             	add    $0x18,%esp
}
  801847:	90                   	nop
  801848:	c9                   	leave  
  801849:	c3                   	ret    

0080184a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 14                	push   $0x14
  801859:	e8 b0 fd ff ff       	call   80160e <syscall>
  80185e:	83 c4 18             	add    $0x18,%esp
}
  801861:	90                   	nop
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 15                	push   $0x15
  801873:	e8 96 fd ff ff       	call   80160e <syscall>
  801878:	83 c4 18             	add    $0x18,%esp
}
  80187b:	90                   	nop
  80187c:	c9                   	leave  
  80187d:	c3                   	ret    

0080187e <sys_cputc>:


void
sys_cputc(const char c)
{
  80187e:	55                   	push   %ebp
  80187f:	89 e5                	mov    %esp,%ebp
  801881:	83 ec 04             	sub    $0x4,%esp
  801884:	8b 45 08             	mov    0x8(%ebp),%eax
  801887:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80188a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	50                   	push   %eax
  801897:	6a 16                	push   $0x16
  801899:	e8 70 fd ff ff       	call   80160e <syscall>
  80189e:	83 c4 18             	add    $0x18,%esp
}
  8018a1:	90                   	nop
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 17                	push   $0x17
  8018b3:	e8 56 fd ff ff       	call   80160e <syscall>
  8018b8:	83 c4 18             	add    $0x18,%esp
}
  8018bb:	90                   	nop
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8018c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	ff 75 0c             	pushl  0xc(%ebp)
  8018cd:	50                   	push   %eax
  8018ce:	6a 18                	push   $0x18
  8018d0:	e8 39 fd ff ff       	call   80160e <syscall>
  8018d5:	83 c4 18             	add    $0x18,%esp
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 00                	push   $0x0
  8018e9:	52                   	push   %edx
  8018ea:	50                   	push   %eax
  8018eb:	6a 1b                	push   $0x1b
  8018ed:	e8 1c fd ff ff       	call   80160e <syscall>
  8018f2:	83 c4 18             	add    $0x18,%esp
}
  8018f5:	c9                   	leave  
  8018f6:	c3                   	ret    

008018f7 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018f7:	55                   	push   %ebp
  8018f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	52                   	push   %edx
  801907:	50                   	push   %eax
  801908:	6a 19                	push   $0x19
  80190a:	e8 ff fc ff ff       	call   80160e <syscall>
  80190f:	83 c4 18             	add    $0x18,%esp
}
  801912:	90                   	nop
  801913:	c9                   	leave  
  801914:	c3                   	ret    

00801915 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801915:	55                   	push   %ebp
  801916:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801918:	8b 55 0c             	mov    0xc(%ebp),%edx
  80191b:	8b 45 08             	mov    0x8(%ebp),%eax
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	52                   	push   %edx
  801925:	50                   	push   %eax
  801926:	6a 1a                	push   $0x1a
  801928:	e8 e1 fc ff ff       	call   80160e <syscall>
  80192d:	83 c4 18             	add    $0x18,%esp
}
  801930:	90                   	nop
  801931:	c9                   	leave  
  801932:	c3                   	ret    

00801933 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801933:	55                   	push   %ebp
  801934:	89 e5                	mov    %esp,%ebp
  801936:	83 ec 04             	sub    $0x4,%esp
  801939:	8b 45 10             	mov    0x10(%ebp),%eax
  80193c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80193f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801942:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801946:	8b 45 08             	mov    0x8(%ebp),%eax
  801949:	6a 00                	push   $0x0
  80194b:	51                   	push   %ecx
  80194c:	52                   	push   %edx
  80194d:	ff 75 0c             	pushl  0xc(%ebp)
  801950:	50                   	push   %eax
  801951:	6a 1c                	push   $0x1c
  801953:	e8 b6 fc ff ff       	call   80160e <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
}
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801960:	8b 55 0c             	mov    0xc(%ebp),%edx
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	52                   	push   %edx
  80196d:	50                   	push   %eax
  80196e:	6a 1d                	push   $0x1d
  801970:	e8 99 fc ff ff       	call   80160e <syscall>
  801975:	83 c4 18             	add    $0x18,%esp
}
  801978:	c9                   	leave  
  801979:	c3                   	ret    

0080197a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80197a:	55                   	push   %ebp
  80197b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80197d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801980:	8b 55 0c             	mov    0xc(%ebp),%edx
  801983:	8b 45 08             	mov    0x8(%ebp),%eax
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	51                   	push   %ecx
  80198b:	52                   	push   %edx
  80198c:	50                   	push   %eax
  80198d:	6a 1e                	push   $0x1e
  80198f:	e8 7a fc ff ff       	call   80160e <syscall>
  801994:	83 c4 18             	add    $0x18,%esp
}
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80199c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80199f:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	52                   	push   %edx
  8019a9:	50                   	push   %eax
  8019aa:	6a 1f                	push   $0x1f
  8019ac:	e8 5d fc ff ff       	call   80160e <syscall>
  8019b1:	83 c4 18             	add    $0x18,%esp
}
  8019b4:	c9                   	leave  
  8019b5:	c3                   	ret    

008019b6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8019b6:	55                   	push   %ebp
  8019b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 20                	push   $0x20
  8019c5:	e8 44 fc ff ff       	call   80160e <syscall>
  8019ca:	83 c4 18             	add    $0x18,%esp
}
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8019d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	ff 75 10             	pushl  0x10(%ebp)
  8019dc:	ff 75 0c             	pushl  0xc(%ebp)
  8019df:	50                   	push   %eax
  8019e0:	6a 21                	push   $0x21
  8019e2:	e8 27 fc ff ff       	call   80160e <syscall>
  8019e7:	83 c4 18             	add    $0x18,%esp
}
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	50                   	push   %eax
  8019fb:	6a 22                	push   $0x22
  8019fd:	e8 0c fc ff ff       	call   80160e <syscall>
  801a02:	83 c4 18             	add    $0x18,%esp
}
  801a05:	90                   	nop
  801a06:	c9                   	leave  
  801a07:	c3                   	ret    

00801a08 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a08:	55                   	push   %ebp
  801a09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	50                   	push   %eax
  801a17:	6a 23                	push   $0x23
  801a19:	e8 f0 fb ff ff       	call   80160e <syscall>
  801a1e:	83 c4 18             	add    $0x18,%esp
}
  801a21:	90                   	nop
  801a22:	c9                   	leave  
  801a23:	c3                   	ret    

00801a24 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a24:	55                   	push   %ebp
  801a25:	89 e5                	mov    %esp,%ebp
  801a27:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a2a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a2d:	8d 50 04             	lea    0x4(%eax),%edx
  801a30:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	52                   	push   %edx
  801a3a:	50                   	push   %eax
  801a3b:	6a 24                	push   $0x24
  801a3d:	e8 cc fb ff ff       	call   80160e <syscall>
  801a42:	83 c4 18             	add    $0x18,%esp
	return result;
  801a45:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a48:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a4b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a4e:	89 01                	mov    %eax,(%ecx)
  801a50:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a53:	8b 45 08             	mov    0x8(%ebp),%eax
  801a56:	c9                   	leave  
  801a57:	c2 04 00             	ret    $0x4

00801a5a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	ff 75 10             	pushl  0x10(%ebp)
  801a64:	ff 75 0c             	pushl  0xc(%ebp)
  801a67:	ff 75 08             	pushl  0x8(%ebp)
  801a6a:	6a 13                	push   $0x13
  801a6c:	e8 9d fb ff ff       	call   80160e <syscall>
  801a71:	83 c4 18             	add    $0x18,%esp
	return ;
  801a74:	90                   	nop
}
  801a75:	c9                   	leave  
  801a76:	c3                   	ret    

00801a77 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a77:	55                   	push   %ebp
  801a78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 25                	push   $0x25
  801a86:	e8 83 fb ff ff       	call   80160e <syscall>
  801a8b:	83 c4 18             	add    $0x18,%esp
}
  801a8e:	c9                   	leave  
  801a8f:	c3                   	ret    

00801a90 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a90:	55                   	push   %ebp
  801a91:	89 e5                	mov    %esp,%ebp
  801a93:	83 ec 04             	sub    $0x4,%esp
  801a96:	8b 45 08             	mov    0x8(%ebp),%eax
  801a99:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a9c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	50                   	push   %eax
  801aa9:	6a 26                	push   $0x26
  801aab:	e8 5e fb ff ff       	call   80160e <syscall>
  801ab0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab3:	90                   	nop
}
  801ab4:	c9                   	leave  
  801ab5:	c3                   	ret    

00801ab6 <rsttst>:
void rsttst()
{
  801ab6:	55                   	push   %ebp
  801ab7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 28                	push   $0x28
  801ac5:	e8 44 fb ff ff       	call   80160e <syscall>
  801aca:	83 c4 18             	add    $0x18,%esp
	return ;
  801acd:	90                   	nop
}
  801ace:	c9                   	leave  
  801acf:	c3                   	ret    

00801ad0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
  801ad3:	83 ec 04             	sub    $0x4,%esp
  801ad6:	8b 45 14             	mov    0x14(%ebp),%eax
  801ad9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801adc:	8b 55 18             	mov    0x18(%ebp),%edx
  801adf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ae3:	52                   	push   %edx
  801ae4:	50                   	push   %eax
  801ae5:	ff 75 10             	pushl  0x10(%ebp)
  801ae8:	ff 75 0c             	pushl  0xc(%ebp)
  801aeb:	ff 75 08             	pushl  0x8(%ebp)
  801aee:	6a 27                	push   $0x27
  801af0:	e8 19 fb ff ff       	call   80160e <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
	return ;
  801af8:	90                   	nop
}
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <chktst>:
void chktst(uint32 n)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	ff 75 08             	pushl  0x8(%ebp)
  801b09:	6a 29                	push   $0x29
  801b0b:	e8 fe fa ff ff       	call   80160e <syscall>
  801b10:	83 c4 18             	add    $0x18,%esp
	return ;
  801b13:	90                   	nop
}
  801b14:	c9                   	leave  
  801b15:	c3                   	ret    

00801b16 <inctst>:

void inctst()
{
  801b16:	55                   	push   %ebp
  801b17:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 2a                	push   $0x2a
  801b25:	e8 e4 fa ff ff       	call   80160e <syscall>
  801b2a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b2d:	90                   	nop
}
  801b2e:	c9                   	leave  
  801b2f:	c3                   	ret    

00801b30 <gettst>:
uint32 gettst()
{
  801b30:	55                   	push   %ebp
  801b31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 2b                	push   $0x2b
  801b3f:	e8 ca fa ff ff       	call   80160e <syscall>
  801b44:	83 c4 18             	add    $0x18,%esp
}
  801b47:	c9                   	leave  
  801b48:	c3                   	ret    

00801b49 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b49:	55                   	push   %ebp
  801b4a:	89 e5                	mov    %esp,%ebp
  801b4c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 2c                	push   $0x2c
  801b5b:	e8 ae fa ff ff       	call   80160e <syscall>
  801b60:	83 c4 18             	add    $0x18,%esp
  801b63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b66:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b6a:	75 07                	jne    801b73 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b6c:	b8 01 00 00 00       	mov    $0x1,%eax
  801b71:	eb 05                	jmp    801b78 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b73:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b78:	c9                   	leave  
  801b79:	c3                   	ret    

00801b7a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b7a:	55                   	push   %ebp
  801b7b:	89 e5                	mov    %esp,%ebp
  801b7d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 2c                	push   $0x2c
  801b8c:	e8 7d fa ff ff       	call   80160e <syscall>
  801b91:	83 c4 18             	add    $0x18,%esp
  801b94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b97:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b9b:	75 07                	jne    801ba4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b9d:	b8 01 00 00 00       	mov    $0x1,%eax
  801ba2:	eb 05                	jmp    801ba9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ba4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
  801bae:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 2c                	push   $0x2c
  801bbd:	e8 4c fa ff ff       	call   80160e <syscall>
  801bc2:	83 c4 18             	add    $0x18,%esp
  801bc5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801bc8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801bcc:	75 07                	jne    801bd5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801bce:	b8 01 00 00 00       	mov    $0x1,%eax
  801bd3:	eb 05                	jmp    801bda <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801bd5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bda:	c9                   	leave  
  801bdb:	c3                   	ret    

00801bdc <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801bdc:	55                   	push   %ebp
  801bdd:	89 e5                	mov    %esp,%ebp
  801bdf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 2c                	push   $0x2c
  801bee:	e8 1b fa ff ff       	call   80160e <syscall>
  801bf3:	83 c4 18             	add    $0x18,%esp
  801bf6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801bf9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bfd:	75 07                	jne    801c06 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bff:	b8 01 00 00 00       	mov    $0x1,%eax
  801c04:	eb 05                	jmp    801c0b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801c06:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c0b:	c9                   	leave  
  801c0c:	c3                   	ret    

00801c0d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c0d:	55                   	push   %ebp
  801c0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	ff 75 08             	pushl  0x8(%ebp)
  801c1b:	6a 2d                	push   $0x2d
  801c1d:	e8 ec f9 ff ff       	call   80160e <syscall>
  801c22:	83 c4 18             	add    $0x18,%esp
	return ;
  801c25:	90                   	nop
}
  801c26:	c9                   	leave  
  801c27:	c3                   	ret    

00801c28 <__udivdi3>:
  801c28:	55                   	push   %ebp
  801c29:	57                   	push   %edi
  801c2a:	56                   	push   %esi
  801c2b:	53                   	push   %ebx
  801c2c:	83 ec 1c             	sub    $0x1c,%esp
  801c2f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c33:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c3b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c3f:	89 ca                	mov    %ecx,%edx
  801c41:	89 f8                	mov    %edi,%eax
  801c43:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c47:	85 f6                	test   %esi,%esi
  801c49:	75 2d                	jne    801c78 <__udivdi3+0x50>
  801c4b:	39 cf                	cmp    %ecx,%edi
  801c4d:	77 65                	ja     801cb4 <__udivdi3+0x8c>
  801c4f:	89 fd                	mov    %edi,%ebp
  801c51:	85 ff                	test   %edi,%edi
  801c53:	75 0b                	jne    801c60 <__udivdi3+0x38>
  801c55:	b8 01 00 00 00       	mov    $0x1,%eax
  801c5a:	31 d2                	xor    %edx,%edx
  801c5c:	f7 f7                	div    %edi
  801c5e:	89 c5                	mov    %eax,%ebp
  801c60:	31 d2                	xor    %edx,%edx
  801c62:	89 c8                	mov    %ecx,%eax
  801c64:	f7 f5                	div    %ebp
  801c66:	89 c1                	mov    %eax,%ecx
  801c68:	89 d8                	mov    %ebx,%eax
  801c6a:	f7 f5                	div    %ebp
  801c6c:	89 cf                	mov    %ecx,%edi
  801c6e:	89 fa                	mov    %edi,%edx
  801c70:	83 c4 1c             	add    $0x1c,%esp
  801c73:	5b                   	pop    %ebx
  801c74:	5e                   	pop    %esi
  801c75:	5f                   	pop    %edi
  801c76:	5d                   	pop    %ebp
  801c77:	c3                   	ret    
  801c78:	39 ce                	cmp    %ecx,%esi
  801c7a:	77 28                	ja     801ca4 <__udivdi3+0x7c>
  801c7c:	0f bd fe             	bsr    %esi,%edi
  801c7f:	83 f7 1f             	xor    $0x1f,%edi
  801c82:	75 40                	jne    801cc4 <__udivdi3+0x9c>
  801c84:	39 ce                	cmp    %ecx,%esi
  801c86:	72 0a                	jb     801c92 <__udivdi3+0x6a>
  801c88:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c8c:	0f 87 9e 00 00 00    	ja     801d30 <__udivdi3+0x108>
  801c92:	b8 01 00 00 00       	mov    $0x1,%eax
  801c97:	89 fa                	mov    %edi,%edx
  801c99:	83 c4 1c             	add    $0x1c,%esp
  801c9c:	5b                   	pop    %ebx
  801c9d:	5e                   	pop    %esi
  801c9e:	5f                   	pop    %edi
  801c9f:	5d                   	pop    %ebp
  801ca0:	c3                   	ret    
  801ca1:	8d 76 00             	lea    0x0(%esi),%esi
  801ca4:	31 ff                	xor    %edi,%edi
  801ca6:	31 c0                	xor    %eax,%eax
  801ca8:	89 fa                	mov    %edi,%edx
  801caa:	83 c4 1c             	add    $0x1c,%esp
  801cad:	5b                   	pop    %ebx
  801cae:	5e                   	pop    %esi
  801caf:	5f                   	pop    %edi
  801cb0:	5d                   	pop    %ebp
  801cb1:	c3                   	ret    
  801cb2:	66 90                	xchg   %ax,%ax
  801cb4:	89 d8                	mov    %ebx,%eax
  801cb6:	f7 f7                	div    %edi
  801cb8:	31 ff                	xor    %edi,%edi
  801cba:	89 fa                	mov    %edi,%edx
  801cbc:	83 c4 1c             	add    $0x1c,%esp
  801cbf:	5b                   	pop    %ebx
  801cc0:	5e                   	pop    %esi
  801cc1:	5f                   	pop    %edi
  801cc2:	5d                   	pop    %ebp
  801cc3:	c3                   	ret    
  801cc4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cc9:	89 eb                	mov    %ebp,%ebx
  801ccb:	29 fb                	sub    %edi,%ebx
  801ccd:	89 f9                	mov    %edi,%ecx
  801ccf:	d3 e6                	shl    %cl,%esi
  801cd1:	89 c5                	mov    %eax,%ebp
  801cd3:	88 d9                	mov    %bl,%cl
  801cd5:	d3 ed                	shr    %cl,%ebp
  801cd7:	89 e9                	mov    %ebp,%ecx
  801cd9:	09 f1                	or     %esi,%ecx
  801cdb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cdf:	89 f9                	mov    %edi,%ecx
  801ce1:	d3 e0                	shl    %cl,%eax
  801ce3:	89 c5                	mov    %eax,%ebp
  801ce5:	89 d6                	mov    %edx,%esi
  801ce7:	88 d9                	mov    %bl,%cl
  801ce9:	d3 ee                	shr    %cl,%esi
  801ceb:	89 f9                	mov    %edi,%ecx
  801ced:	d3 e2                	shl    %cl,%edx
  801cef:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cf3:	88 d9                	mov    %bl,%cl
  801cf5:	d3 e8                	shr    %cl,%eax
  801cf7:	09 c2                	or     %eax,%edx
  801cf9:	89 d0                	mov    %edx,%eax
  801cfb:	89 f2                	mov    %esi,%edx
  801cfd:	f7 74 24 0c          	divl   0xc(%esp)
  801d01:	89 d6                	mov    %edx,%esi
  801d03:	89 c3                	mov    %eax,%ebx
  801d05:	f7 e5                	mul    %ebp
  801d07:	39 d6                	cmp    %edx,%esi
  801d09:	72 19                	jb     801d24 <__udivdi3+0xfc>
  801d0b:	74 0b                	je     801d18 <__udivdi3+0xf0>
  801d0d:	89 d8                	mov    %ebx,%eax
  801d0f:	31 ff                	xor    %edi,%edi
  801d11:	e9 58 ff ff ff       	jmp    801c6e <__udivdi3+0x46>
  801d16:	66 90                	xchg   %ax,%ax
  801d18:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d1c:	89 f9                	mov    %edi,%ecx
  801d1e:	d3 e2                	shl    %cl,%edx
  801d20:	39 c2                	cmp    %eax,%edx
  801d22:	73 e9                	jae    801d0d <__udivdi3+0xe5>
  801d24:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d27:	31 ff                	xor    %edi,%edi
  801d29:	e9 40 ff ff ff       	jmp    801c6e <__udivdi3+0x46>
  801d2e:	66 90                	xchg   %ax,%ax
  801d30:	31 c0                	xor    %eax,%eax
  801d32:	e9 37 ff ff ff       	jmp    801c6e <__udivdi3+0x46>
  801d37:	90                   	nop

00801d38 <__umoddi3>:
  801d38:	55                   	push   %ebp
  801d39:	57                   	push   %edi
  801d3a:	56                   	push   %esi
  801d3b:	53                   	push   %ebx
  801d3c:	83 ec 1c             	sub    $0x1c,%esp
  801d3f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d43:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d47:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d4b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d4f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d53:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d57:	89 f3                	mov    %esi,%ebx
  801d59:	89 fa                	mov    %edi,%edx
  801d5b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d5f:	89 34 24             	mov    %esi,(%esp)
  801d62:	85 c0                	test   %eax,%eax
  801d64:	75 1a                	jne    801d80 <__umoddi3+0x48>
  801d66:	39 f7                	cmp    %esi,%edi
  801d68:	0f 86 a2 00 00 00    	jbe    801e10 <__umoddi3+0xd8>
  801d6e:	89 c8                	mov    %ecx,%eax
  801d70:	89 f2                	mov    %esi,%edx
  801d72:	f7 f7                	div    %edi
  801d74:	89 d0                	mov    %edx,%eax
  801d76:	31 d2                	xor    %edx,%edx
  801d78:	83 c4 1c             	add    $0x1c,%esp
  801d7b:	5b                   	pop    %ebx
  801d7c:	5e                   	pop    %esi
  801d7d:	5f                   	pop    %edi
  801d7e:	5d                   	pop    %ebp
  801d7f:	c3                   	ret    
  801d80:	39 f0                	cmp    %esi,%eax
  801d82:	0f 87 ac 00 00 00    	ja     801e34 <__umoddi3+0xfc>
  801d88:	0f bd e8             	bsr    %eax,%ebp
  801d8b:	83 f5 1f             	xor    $0x1f,%ebp
  801d8e:	0f 84 ac 00 00 00    	je     801e40 <__umoddi3+0x108>
  801d94:	bf 20 00 00 00       	mov    $0x20,%edi
  801d99:	29 ef                	sub    %ebp,%edi
  801d9b:	89 fe                	mov    %edi,%esi
  801d9d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801da1:	89 e9                	mov    %ebp,%ecx
  801da3:	d3 e0                	shl    %cl,%eax
  801da5:	89 d7                	mov    %edx,%edi
  801da7:	89 f1                	mov    %esi,%ecx
  801da9:	d3 ef                	shr    %cl,%edi
  801dab:	09 c7                	or     %eax,%edi
  801dad:	89 e9                	mov    %ebp,%ecx
  801daf:	d3 e2                	shl    %cl,%edx
  801db1:	89 14 24             	mov    %edx,(%esp)
  801db4:	89 d8                	mov    %ebx,%eax
  801db6:	d3 e0                	shl    %cl,%eax
  801db8:	89 c2                	mov    %eax,%edx
  801dba:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dbe:	d3 e0                	shl    %cl,%eax
  801dc0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801dc4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dc8:	89 f1                	mov    %esi,%ecx
  801dca:	d3 e8                	shr    %cl,%eax
  801dcc:	09 d0                	or     %edx,%eax
  801dce:	d3 eb                	shr    %cl,%ebx
  801dd0:	89 da                	mov    %ebx,%edx
  801dd2:	f7 f7                	div    %edi
  801dd4:	89 d3                	mov    %edx,%ebx
  801dd6:	f7 24 24             	mull   (%esp)
  801dd9:	89 c6                	mov    %eax,%esi
  801ddb:	89 d1                	mov    %edx,%ecx
  801ddd:	39 d3                	cmp    %edx,%ebx
  801ddf:	0f 82 87 00 00 00    	jb     801e6c <__umoddi3+0x134>
  801de5:	0f 84 91 00 00 00    	je     801e7c <__umoddi3+0x144>
  801deb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801def:	29 f2                	sub    %esi,%edx
  801df1:	19 cb                	sbb    %ecx,%ebx
  801df3:	89 d8                	mov    %ebx,%eax
  801df5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801df9:	d3 e0                	shl    %cl,%eax
  801dfb:	89 e9                	mov    %ebp,%ecx
  801dfd:	d3 ea                	shr    %cl,%edx
  801dff:	09 d0                	or     %edx,%eax
  801e01:	89 e9                	mov    %ebp,%ecx
  801e03:	d3 eb                	shr    %cl,%ebx
  801e05:	89 da                	mov    %ebx,%edx
  801e07:	83 c4 1c             	add    $0x1c,%esp
  801e0a:	5b                   	pop    %ebx
  801e0b:	5e                   	pop    %esi
  801e0c:	5f                   	pop    %edi
  801e0d:	5d                   	pop    %ebp
  801e0e:	c3                   	ret    
  801e0f:	90                   	nop
  801e10:	89 fd                	mov    %edi,%ebp
  801e12:	85 ff                	test   %edi,%edi
  801e14:	75 0b                	jne    801e21 <__umoddi3+0xe9>
  801e16:	b8 01 00 00 00       	mov    $0x1,%eax
  801e1b:	31 d2                	xor    %edx,%edx
  801e1d:	f7 f7                	div    %edi
  801e1f:	89 c5                	mov    %eax,%ebp
  801e21:	89 f0                	mov    %esi,%eax
  801e23:	31 d2                	xor    %edx,%edx
  801e25:	f7 f5                	div    %ebp
  801e27:	89 c8                	mov    %ecx,%eax
  801e29:	f7 f5                	div    %ebp
  801e2b:	89 d0                	mov    %edx,%eax
  801e2d:	e9 44 ff ff ff       	jmp    801d76 <__umoddi3+0x3e>
  801e32:	66 90                	xchg   %ax,%ax
  801e34:	89 c8                	mov    %ecx,%eax
  801e36:	89 f2                	mov    %esi,%edx
  801e38:	83 c4 1c             	add    $0x1c,%esp
  801e3b:	5b                   	pop    %ebx
  801e3c:	5e                   	pop    %esi
  801e3d:	5f                   	pop    %edi
  801e3e:	5d                   	pop    %ebp
  801e3f:	c3                   	ret    
  801e40:	3b 04 24             	cmp    (%esp),%eax
  801e43:	72 06                	jb     801e4b <__umoddi3+0x113>
  801e45:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e49:	77 0f                	ja     801e5a <__umoddi3+0x122>
  801e4b:	89 f2                	mov    %esi,%edx
  801e4d:	29 f9                	sub    %edi,%ecx
  801e4f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e53:	89 14 24             	mov    %edx,(%esp)
  801e56:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e5a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e5e:	8b 14 24             	mov    (%esp),%edx
  801e61:	83 c4 1c             	add    $0x1c,%esp
  801e64:	5b                   	pop    %ebx
  801e65:	5e                   	pop    %esi
  801e66:	5f                   	pop    %edi
  801e67:	5d                   	pop    %ebp
  801e68:	c3                   	ret    
  801e69:	8d 76 00             	lea    0x0(%esi),%esi
  801e6c:	2b 04 24             	sub    (%esp),%eax
  801e6f:	19 fa                	sbb    %edi,%edx
  801e71:	89 d1                	mov    %edx,%ecx
  801e73:	89 c6                	mov    %eax,%esi
  801e75:	e9 71 ff ff ff       	jmp    801deb <__umoddi3+0xb3>
  801e7a:	66 90                	xchg   %ax,%ax
  801e7c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e80:	72 ea                	jb     801e6c <__umoddi3+0x134>
  801e82:	89 d9                	mov    %ebx,%ecx
  801e84:	e9 62 ff ff ff       	jmp    801deb <__umoddi3+0xb3>
