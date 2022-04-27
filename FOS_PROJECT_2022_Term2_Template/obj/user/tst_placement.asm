
obj/user/tst_placement:     file format elf32-i386


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
  800031:	e8 7a 05 00 00       	call   8005b0 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 9c 00 00 01    	sub    $0x100009c,%esp

	char arr[PAGE_SIZE*1024*4];

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800044:	a1 04 30 80 00       	mov    0x803004,%eax
  800049:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80004f:	8b 00                	mov    (%eax),%eax
  800051:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800054:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800057:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80005c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800061:	74 14                	je     800077 <_main+0x3f>
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	68 80 1f 80 00       	push   $0x801f80
  80006b:	6a 10                	push   $0x10
  80006d:	68 c1 1f 80 00       	push   $0x801fc1
  800072:	e8 48 06 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800077:	a1 04 30 80 00       	mov    0x803004,%eax
  80007c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800082:	83 c0 0c             	add    $0xc,%eax
  800085:	8b 00                	mov    (%eax),%eax
  800087:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80008a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80008d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800092:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 80 1f 80 00       	push   $0x801f80
  8000a1:	6a 11                	push   $0x11
  8000a3:	68 c1 1f 80 00       	push   $0x801fc1
  8000a8:	e8 12 06 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ad:	a1 04 30 80 00       	mov    0x803004,%eax
  8000b2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b8:	83 c0 18             	add    $0x18,%eax
  8000bb:	8b 00                	mov    (%eax),%eax
  8000bd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000cd:	74 14                	je     8000e3 <_main+0xab>
  8000cf:	83 ec 04             	sub    $0x4,%esp
  8000d2:	68 80 1f 80 00       	push   $0x801f80
  8000d7:	6a 12                	push   $0x12
  8000d9:	68 c1 1f 80 00       	push   $0x801fc1
  8000de:	e8 dc 05 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e3:	a1 04 30 80 00       	mov    0x803004,%eax
  8000e8:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000ee:	83 c0 24             	add    $0x24,%eax
  8000f1:	8b 00                	mov    (%eax),%eax
  8000f3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fe:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 80 1f 80 00       	push   $0x801f80
  80010d:	6a 13                	push   $0x13
  80010f:	68 c1 1f 80 00       	push   $0x801fc1
  800114:	e8 a6 05 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800119:	a1 04 30 80 00       	mov    0x803004,%eax
  80011e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800124:	83 c0 30             	add    $0x30,%eax
  800127:	8b 00                	mov    (%eax),%eax
  800129:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80012c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80012f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800134:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 80 1f 80 00       	push   $0x801f80
  800143:	6a 14                	push   $0x14
  800145:	68 c1 1f 80 00       	push   $0x801fc1
  80014a:	e8 70 05 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014f:	a1 04 30 80 00       	mov    0x803004,%eax
  800154:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80015a:	83 c0 3c             	add    $0x3c,%eax
  80015d:	8b 00                	mov    (%eax),%eax
  80015f:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800162:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800165:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016f:	74 14                	je     800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 80 1f 80 00       	push   $0x801f80
  800179:	6a 15                	push   $0x15
  80017b:	68 c1 1f 80 00       	push   $0x801fc1
  800180:	e8 3a 05 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x206000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800185:	a1 04 30 80 00       	mov    0x803004,%eax
  80018a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800190:	83 c0 48             	add    $0x48,%eax
  800193:	8b 00                	mov    (%eax),%eax
  800195:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800198:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80019b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a0:	3d 00 60 20 00       	cmp    $0x206000,%eax
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 80 1f 80 00       	push   $0x801f80
  8001af:	6a 16                	push   $0x16
  8001b1:	68 c1 1f 80 00       	push   $0x801fc1
  8001b6:	e8 04 05 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bb:	a1 04 30 80 00       	mov    0x803004,%eax
  8001c0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c6:	83 c0 54             	add    $0x54,%eax
  8001c9:	8b 00                	mov    (%eax),%eax
  8001cb:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001ce:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d6:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001db:	74 14                	je     8001f1 <_main+0x1b9>
  8001dd:	83 ec 04             	sub    $0x4,%esp
  8001e0:	68 80 1f 80 00       	push   $0x801f80
  8001e5:	6a 17                	push   $0x17
  8001e7:	68 c1 1f 80 00       	push   $0x801fc1
  8001ec:	e8 ce 04 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f1:	a1 04 30 80 00       	mov    0x803004,%eax
  8001f6:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001fc:	83 c0 60             	add    $0x60,%eax
  8001ff:	8b 00                	mov    (%eax),%eax
  800201:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800204:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800207:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020c:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800211:	74 14                	je     800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 80 1f 80 00       	push   $0x801f80
  80021b:	6a 18                	push   $0x18
  80021d:	68 c1 1f 80 00       	push   $0x801fc1
  800222:	e8 98 04 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800227:	a1 04 30 80 00       	mov    0x803004,%eax
  80022c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800232:	83 c0 6c             	add    $0x6c,%eax
  800235:	8b 00                	mov    (%eax),%eax
  800237:	89 45 b8             	mov    %eax,-0x48(%ebp)
  80023a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80023d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800242:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800247:	74 14                	je     80025d <_main+0x225>
  800249:	83 ec 04             	sub    $0x4,%esp
  80024c:	68 80 1f 80 00       	push   $0x801f80
  800251:	6a 19                	push   $0x19
  800253:	68 c1 1f 80 00       	push   $0x801fc1
  800258:	e8 62 04 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025d:	a1 04 30 80 00       	mov    0x803004,%eax
  800262:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800268:	83 c0 78             	add    $0x78,%eax
  80026b:	8b 00                	mov    (%eax),%eax
  80026d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800270:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800273:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800278:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80027d:	74 14                	je     800293 <_main+0x25b>
  80027f:	83 ec 04             	sub    $0x4,%esp
  800282:	68 80 1f 80 00       	push   $0x801f80
  800287:	6a 1a                	push   $0x1a
  800289:	68 c1 1f 80 00       	push   $0x801fc1
  80028e:	e8 2c 04 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800293:	a1 04 30 80 00       	mov    0x803004,%eax
  800298:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80029e:	05 84 00 00 00       	add    $0x84,%eax
  8002a3:	8b 00                	mov    (%eax),%eax
  8002a5:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8002a8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002b0:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8002b5:	74 14                	je     8002cb <_main+0x293>
  8002b7:	83 ec 04             	sub    $0x4,%esp
  8002ba:	68 80 1f 80 00       	push   $0x801f80
  8002bf:	6a 1b                	push   $0x1b
  8002c1:	68 c1 1f 80 00       	push   $0x801fc1
  8002c6:	e8 f4 03 00 00       	call   8006bf <_panic>

		for (int k = 12; k < 20; k++)
  8002cb:	c7 45 e4 0c 00 00 00 	movl   $0xc,-0x1c(%ebp)
  8002d2:	eb 37                	jmp    80030b <_main+0x2d3>
			if( myEnv->__uptr_pws[k].empty !=  1)
  8002d4:	a1 04 30 80 00       	mov    0x803004,%eax
  8002d9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8002df:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002e2:	89 d0                	mov    %edx,%eax
  8002e4:	01 c0                	add    %eax,%eax
  8002e6:	01 d0                	add    %edx,%eax
  8002e8:	c1 e0 02             	shl    $0x2,%eax
  8002eb:	01 c8                	add    %ecx,%eax
  8002ed:	8a 40 04             	mov    0x4(%eax),%al
  8002f0:	3c 01                	cmp    $0x1,%al
  8002f2:	74 14                	je     800308 <_main+0x2d0>
				panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002f4:	83 ec 04             	sub    $0x4,%esp
  8002f7:	68 80 1f 80 00       	push   $0x801f80
  8002fc:	6a 1f                	push   $0x1f
  8002fe:	68 c1 1f 80 00       	push   $0x801fc1
  800303:	e8 b7 03 00 00       	call   8006bf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");

		for (int k = 12; k < 20; k++)
  800308:	ff 45 e4             	incl   -0x1c(%ebp)
  80030b:	83 7d e4 13          	cmpl   $0x13,-0x1c(%ebp)
  80030f:	7e c3                	jle    8002d4 <_main+0x29c>
		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if( myEnv->page_last_WS_index !=  12)  											panic("INITIAL PAGE last index checking failed! Review size of the WS..!!");
		/*====================================*/
	}

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800311:	e8 d6 15 00 00       	call   8018ec <sys_pf_calculate_allocated_pages>
  800316:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int freePages = sys_calculate_free_frames();
  800319:	e8 4b 15 00 00       	call   801869 <sys_calculate_free_frames>
  80031e:	89 45 a8             	mov    %eax,-0x58(%ebp)

	int i=0;
  800321:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(;i<=PAGE_SIZE;i++)
  800328:	eb 11                	jmp    80033b <_main+0x303>
	{
		arr[i] = -1;
  80032a:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  800330:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800333:	01 d0                	add    %edx,%eax
  800335:	c6 00 ff             	movb   $0xff,(%eax)

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
	int freePages = sys_calculate_free_frames();

	int i=0;
	for(;i<=PAGE_SIZE;i++)
  800338:	ff 45 e0             	incl   -0x20(%ebp)
  80033b:	81 7d e0 00 10 00 00 	cmpl   $0x1000,-0x20(%ebp)
  800342:	7e e6                	jle    80032a <_main+0x2f2>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
  800344:	c7 45 e0 00 00 40 00 	movl   $0x400000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  80034b:	eb 11                	jmp    80035e <_main+0x326>
	{
		arr[i] = -1;
  80034d:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  800353:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800356:	01 d0                	add    %edx,%eax
  800358:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  80035b:	ff 45 e0             	incl   -0x20(%ebp)
  80035e:	81 7d e0 00 10 40 00 	cmpl   $0x401000,-0x20(%ebp)
  800365:	7e e6                	jle    80034d <_main+0x315>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
  800367:	c7 45 e0 00 00 80 00 	movl   $0x800000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  80036e:	eb 11                	jmp    800381 <_main+0x349>
	{
		arr[i] = -1;
  800370:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  800376:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  80037e:	ff 45 e0             	incl   -0x20(%ebp)
  800381:	81 7d e0 00 10 80 00 	cmpl   $0x801000,-0x20(%ebp)
  800388:	7e e6                	jle    800370 <_main+0x338>
		arr[i] = -1;
	}



	cprintf("STEP A: checking PLACEMENT fault handling ... \n");
  80038a:	83 ec 0c             	sub    $0xc,%esp
  80038d:	68 d8 1f 80 00       	push   $0x801fd8
  800392:	e8 dc 05 00 00       	call   800973 <cprintf>
  800397:	83 c4 10             	add    $0x10,%esp
	{
		if( arr[0] !=  -1)  panic("PLACEMENT of stack page failed");
  80039a:	8a 85 a8 ff ff fe    	mov    -0x1000058(%ebp),%al
  8003a0:	3c ff                	cmp    $0xff,%al
  8003a2:	74 14                	je     8003b8 <_main+0x380>
  8003a4:	83 ec 04             	sub    $0x4,%esp
  8003a7:	68 08 20 80 00       	push   $0x802008
  8003ac:	6a 3f                	push   $0x3f
  8003ae:	68 c1 1f 80 00       	push   $0x801fc1
  8003b3:	e8 07 03 00 00       	call   8006bf <_panic>
		if( arr[PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  8003b8:	8a 85 a8 0f 00 ff    	mov    -0xfff058(%ebp),%al
  8003be:	3c ff                	cmp    $0xff,%al
  8003c0:	74 14                	je     8003d6 <_main+0x39e>
  8003c2:	83 ec 04             	sub    $0x4,%esp
  8003c5:	68 08 20 80 00       	push   $0x802008
  8003ca:	6a 40                	push   $0x40
  8003cc:	68 c1 1f 80 00       	push   $0x801fc1
  8003d1:	e8 e9 02 00 00       	call   8006bf <_panic>

		if( arr[PAGE_SIZE*1024] !=  -1)  panic("PLACEMENT of stack page failed");
  8003d6:	8a 85 a8 ff 3f ff    	mov    -0xc00058(%ebp),%al
  8003dc:	3c ff                	cmp    $0xff,%al
  8003de:	74 14                	je     8003f4 <_main+0x3bc>
  8003e0:	83 ec 04             	sub    $0x4,%esp
  8003e3:	68 08 20 80 00       	push   $0x802008
  8003e8:	6a 42                	push   $0x42
  8003ea:	68 c1 1f 80 00       	push   $0x801fc1
  8003ef:	e8 cb 02 00 00       	call   8006bf <_panic>
		if( arr[PAGE_SIZE*1025] !=  -1)  panic("PLACEMENT of stack page failed");
  8003f4:	8a 85 a8 0f 40 ff    	mov    -0xbff058(%ebp),%al
  8003fa:	3c ff                	cmp    $0xff,%al
  8003fc:	74 14                	je     800412 <_main+0x3da>
  8003fe:	83 ec 04             	sub    $0x4,%esp
  800401:	68 08 20 80 00       	push   $0x802008
  800406:	6a 43                	push   $0x43
  800408:	68 c1 1f 80 00       	push   $0x801fc1
  80040d:	e8 ad 02 00 00       	call   8006bf <_panic>

		if( arr[PAGE_SIZE*1024*2] !=  -1)  panic("PLACEMENT of stack page failed");
  800412:	8a 85 a8 ff 7f ff    	mov    -0x800058(%ebp),%al
  800418:	3c ff                	cmp    $0xff,%al
  80041a:	74 14                	je     800430 <_main+0x3f8>
  80041c:	83 ec 04             	sub    $0x4,%esp
  80041f:	68 08 20 80 00       	push   $0x802008
  800424:	6a 45                	push   $0x45
  800426:	68 c1 1f 80 00       	push   $0x801fc1
  80042b:	e8 8f 02 00 00       	call   8006bf <_panic>
		if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  800430:	8a 85 a8 0f 80 ff    	mov    -0x7ff058(%ebp),%al
  800436:	3c ff                	cmp    $0xff,%al
  800438:	74 14                	je     80044e <_main+0x416>
  80043a:	83 ec 04             	sub    $0x4,%esp
  80043d:	68 08 20 80 00       	push   $0x802008
  800442:	6a 46                	push   $0x46
  800444:	68 c1 1f 80 00       	push   $0x801fc1
  800449:	e8 71 02 00 00       	call   8006bf <_panic>


		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5) panic("new stack pages are not written to Page File");
  80044e:	e8 99 14 00 00       	call   8018ec <sys_pf_calculate_allocated_pages>
  800453:	2b 45 ac             	sub    -0x54(%ebp),%eax
  800456:	83 f8 05             	cmp    $0x5,%eax
  800459:	74 14                	je     80046f <_main+0x437>
  80045b:	83 ec 04             	sub    $0x4,%esp
  80045e:	68 28 20 80 00       	push   $0x802028
  800463:	6a 49                	push   $0x49
  800465:	68 c1 1f 80 00       	push   $0x801fc1
  80046a:	e8 50 02 00 00       	call   8006bf <_panic>

		if( (freePages - sys_calculate_free_frames() ) != 9 ) panic("allocated memory size incorrect");
  80046f:	8b 5d a8             	mov    -0x58(%ebp),%ebx
  800472:	e8 f2 13 00 00       	call   801869 <sys_calculate_free_frames>
  800477:	29 c3                	sub    %eax,%ebx
  800479:	89 d8                	mov    %ebx,%eax
  80047b:	83 f8 09             	cmp    $0x9,%eax
  80047e:	74 14                	je     800494 <_main+0x45c>
  800480:	83 ec 04             	sub    $0x4,%esp
  800483:	68 58 20 80 00       	push   $0x802058
  800488:	6a 4b                	push   $0x4b
  80048a:	68 c1 1f 80 00       	push   $0x801fc1
  80048f:	e8 2b 02 00 00       	call   8006bf <_panic>
	}
	cprintf("STEP A passed: PLACEMENT fault handling works!\n\n\n");
  800494:	83 ec 0c             	sub    $0xc,%esp
  800497:	68 78 20 80 00       	push   $0x802078
  80049c:	e8 d2 04 00 00       	call   800973 <cprintf>
  8004a1:	83 c4 10             	add    $0x10,%esp


	uint32 expectedPages[20] = {0x200000,0x201000,0x202000,0x203000,0x204000,0x205000,0x206000,0x800000,0x801000,0x802000,0x803000,0xeebfd000,0xedbfd000,0xedbfe000,0xedffd000,0xedffe000,0xee3fd000,0xee3fe000, 0, 0};
  8004a4:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  8004aa:	bb a0 21 80 00       	mov    $0x8021a0,%ebx
  8004af:	ba 14 00 00 00       	mov    $0x14,%edx
  8004b4:	89 c7                	mov    %eax,%edi
  8004b6:	89 de                	mov    %ebx,%esi
  8004b8:	89 d1                	mov    %edx,%ecx
  8004ba:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	cprintf("STEP B: checking WS entries ...\n");
  8004bc:	83 ec 0c             	sub    $0xc,%esp
  8004bf:	68 ac 20 80 00       	push   $0x8020ac
  8004c4:	e8 aa 04 00 00       	call   800973 <cprintf>
  8004c9:	83 c4 10             	add    $0x10,%esp
	{
		CheckWSWithoutLastIndex(expectedPages, 20);
  8004cc:	83 ec 08             	sub    $0x8,%esp
  8004cf:	6a 14                	push   $0x14
  8004d1:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  8004d7:	50                   	push   %eax
  8004d8:	e8 54 02 00 00       	call   800731 <CheckWSWithoutLastIndex>
  8004dd:	83 c4 10             	add    $0x10,%esp
	//		if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=  0xedffd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=  0xedffe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[16].virtual_address,PAGE_SIZE) !=  0xee3fd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[17].virtual_address,PAGE_SIZE) !=  0xee3fe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
}
cprintf("STEP B passed: WS entries test are correct\n\n\n");
  8004e0:	83 ec 0c             	sub    $0xc,%esp
  8004e3:	68 d0 20 80 00       	push   $0x8020d0
  8004e8:	e8 86 04 00 00       	call   800973 <cprintf>
  8004ed:	83 c4 10             	add    $0x10,%esp

cprintf("STEP C: checking working sets WHEN BECOMES FULL...\n");
  8004f0:	83 ec 0c             	sub    $0xc,%esp
  8004f3:	68 00 21 80 00       	push   $0x802100
  8004f8:	e8 76 04 00 00       	call   800973 <cprintf>
  8004fd:	83 c4 10             	add    $0x10,%esp
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
  800500:	c7 45 e0 00 00 c0 00 	movl   $0xc00000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800507:	eb 11                	jmp    80051a <_main+0x4e2>
	{
		arr[i] = -1;
  800509:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  80050f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	c6 00 ff             	movb   $0xff,(%eax)
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800517:	ff 45 e0             	incl   -0x20(%ebp)
  80051a:	81 7d e0 00 10 c0 00 	cmpl   $0xc01000,-0x20(%ebp)
  800521:	7e e6                	jle    800509 <_main+0x4d1>
	{
		arr[i] = -1;
	}

	if( arr[PAGE_SIZE*1024*3] !=  -1)  panic("PLACEMENT of stack page failed");
  800523:	8a 85 a8 ff bf ff    	mov    -0x400058(%ebp),%al
  800529:	3c ff                	cmp    $0xff,%al
  80052b:	74 14                	je     800541 <_main+0x509>
  80052d:	83 ec 04             	sub    $0x4,%esp
  800530:	68 08 20 80 00       	push   $0x802008
  800535:	6a 74                	push   $0x74
  800537:	68 c1 1f 80 00       	push   $0x801fc1
  80053c:	e8 7e 01 00 00       	call   8006bf <_panic>
	if( arr[PAGE_SIZE*1024*3 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  800541:	8a 85 a8 0f c0 ff    	mov    -0x3ff058(%ebp),%al
  800547:	3c ff                	cmp    $0xff,%al
  800549:	74 14                	je     80055f <_main+0x527>
  80054b:	83 ec 04             	sub    $0x4,%esp
  80054e:	68 08 20 80 00       	push   $0x802008
  800553:	6a 75                	push   $0x75
  800555:	68 c1 1f 80 00       	push   $0x801fc1
  80055a:	e8 60 01 00 00       	call   8006bf <_panic>

	expectedPages[18] = 0xee7fd000;
  80055f:	c7 85 a0 ff ff fe 00 	movl   $0xee7fd000,-0x1000060(%ebp)
  800566:	d0 7f ee 
	expectedPages[19] = 0xee7fe000;
  800569:	c7 85 a4 ff ff fe 00 	movl   $0xee7fe000,-0x100005c(%ebp)
  800570:	e0 7f ee 

	CheckWSWithoutLastIndex(expectedPages, 20);
  800573:	83 ec 08             	sub    $0x8,%esp
  800576:	6a 14                	push   $0x14
  800578:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  80057e:	50                   	push   %eax
  80057f:	e8 ad 01 00 00       	call   800731 <CheckWSWithoutLastIndex>
  800584:	83 c4 10             	add    $0x10,%esp

	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 0) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

}
cprintf("STEP C passed: WS is FULL now\n\n\n");
  800587:	83 ec 0c             	sub    $0xc,%esp
  80058a:	68 34 21 80 00       	push   $0x802134
  80058f:	e8 df 03 00 00       	call   800973 <cprintf>
  800594:	83 c4 10             	add    $0x10,%esp

cprintf("Congratulations!! Test of PAGE PLACEMENT completed successfully!!\n\n\n");
  800597:	83 ec 0c             	sub    $0xc,%esp
  80059a:	68 58 21 80 00       	push   $0x802158
  80059f:	e8 cf 03 00 00       	call   800973 <cprintf>
  8005a4:	83 c4 10             	add    $0x10,%esp
return;
  8005a7:	90                   	nop
}
  8005a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8005ab:	5b                   	pop    %ebx
  8005ac:	5e                   	pop    %esi
  8005ad:	5f                   	pop    %edi
  8005ae:	5d                   	pop    %ebp
  8005af:	c3                   	ret    

008005b0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005b0:	55                   	push   %ebp
  8005b1:	89 e5                	mov    %esp,%ebp
  8005b3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005b6:	e8 e3 11 00 00       	call   80179e <sys_getenvindex>
  8005bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005c1:	89 d0                	mov    %edx,%eax
  8005c3:	c1 e0 02             	shl    $0x2,%eax
  8005c6:	01 d0                	add    %edx,%eax
  8005c8:	01 c0                	add    %eax,%eax
  8005ca:	01 d0                	add    %edx,%eax
  8005cc:	01 c0                	add    %eax,%eax
  8005ce:	01 d0                	add    %edx,%eax
  8005d0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8005d7:	01 d0                	add    %edx,%eax
  8005d9:	c1 e0 02             	shl    $0x2,%eax
  8005dc:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005e1:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005e6:	a1 04 30 80 00       	mov    0x803004,%eax
  8005eb:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8005f1:	84 c0                	test   %al,%al
  8005f3:	74 0f                	je     800604 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8005f5:	a1 04 30 80 00       	mov    0x803004,%eax
  8005fa:	05 f4 02 00 00       	add    $0x2f4,%eax
  8005ff:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800604:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800608:	7e 0a                	jle    800614 <libmain+0x64>
		binaryname = argv[0];
  80060a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80060d:	8b 00                	mov    (%eax),%eax
  80060f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800614:	83 ec 08             	sub    $0x8,%esp
  800617:	ff 75 0c             	pushl  0xc(%ebp)
  80061a:	ff 75 08             	pushl  0x8(%ebp)
  80061d:	e8 16 fa ff ff       	call   800038 <_main>
  800622:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800625:	e8 0f 13 00 00       	call   801939 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80062a:	83 ec 0c             	sub    $0xc,%esp
  80062d:	68 08 22 80 00       	push   $0x802208
  800632:	e8 3c 03 00 00       	call   800973 <cprintf>
  800637:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80063a:	a1 04 30 80 00       	mov    0x803004,%eax
  80063f:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800645:	a1 04 30 80 00       	mov    0x803004,%eax
  80064a:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800650:	83 ec 04             	sub    $0x4,%esp
  800653:	52                   	push   %edx
  800654:	50                   	push   %eax
  800655:	68 30 22 80 00       	push   $0x802230
  80065a:	e8 14 03 00 00       	call   800973 <cprintf>
  80065f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800662:	a1 04 30 80 00       	mov    0x803004,%eax
  800667:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80066d:	83 ec 08             	sub    $0x8,%esp
  800670:	50                   	push   %eax
  800671:	68 55 22 80 00       	push   $0x802255
  800676:	e8 f8 02 00 00       	call   800973 <cprintf>
  80067b:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80067e:	83 ec 0c             	sub    $0xc,%esp
  800681:	68 08 22 80 00       	push   $0x802208
  800686:	e8 e8 02 00 00       	call   800973 <cprintf>
  80068b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80068e:	e8 c0 12 00 00       	call   801953 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800693:	e8 19 00 00 00       	call   8006b1 <exit>
}
  800698:	90                   	nop
  800699:	c9                   	leave  
  80069a:	c3                   	ret    

0080069b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80069b:	55                   	push   %ebp
  80069c:	89 e5                	mov    %esp,%ebp
  80069e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006a1:	83 ec 0c             	sub    $0xc,%esp
  8006a4:	6a 00                	push   $0x0
  8006a6:	e8 bf 10 00 00       	call   80176a <sys_env_destroy>
  8006ab:	83 c4 10             	add    $0x10,%esp
}
  8006ae:	90                   	nop
  8006af:	c9                   	leave  
  8006b0:	c3                   	ret    

008006b1 <exit>:

void
exit(void)
{
  8006b1:	55                   	push   %ebp
  8006b2:	89 e5                	mov    %esp,%ebp
  8006b4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006b7:	e8 14 11 00 00       	call   8017d0 <sys_env_exit>
}
  8006bc:	90                   	nop
  8006bd:	c9                   	leave  
  8006be:	c3                   	ret    

008006bf <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006bf:	55                   	push   %ebp
  8006c0:	89 e5                	mov    %esp,%ebp
  8006c2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006c5:	8d 45 10             	lea    0x10(%ebp),%eax
  8006c8:	83 c0 04             	add    $0x4,%eax
  8006cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006ce:	a1 14 30 80 00       	mov    0x803014,%eax
  8006d3:	85 c0                	test   %eax,%eax
  8006d5:	74 16                	je     8006ed <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006d7:	a1 14 30 80 00       	mov    0x803014,%eax
  8006dc:	83 ec 08             	sub    $0x8,%esp
  8006df:	50                   	push   %eax
  8006e0:	68 6c 22 80 00       	push   $0x80226c
  8006e5:	e8 89 02 00 00       	call   800973 <cprintf>
  8006ea:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006ed:	a1 00 30 80 00       	mov    0x803000,%eax
  8006f2:	ff 75 0c             	pushl  0xc(%ebp)
  8006f5:	ff 75 08             	pushl  0x8(%ebp)
  8006f8:	50                   	push   %eax
  8006f9:	68 71 22 80 00       	push   $0x802271
  8006fe:	e8 70 02 00 00       	call   800973 <cprintf>
  800703:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800706:	8b 45 10             	mov    0x10(%ebp),%eax
  800709:	83 ec 08             	sub    $0x8,%esp
  80070c:	ff 75 f4             	pushl  -0xc(%ebp)
  80070f:	50                   	push   %eax
  800710:	e8 f3 01 00 00       	call   800908 <vcprintf>
  800715:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800718:	83 ec 08             	sub    $0x8,%esp
  80071b:	6a 00                	push   $0x0
  80071d:	68 8d 22 80 00       	push   $0x80228d
  800722:	e8 e1 01 00 00       	call   800908 <vcprintf>
  800727:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80072a:	e8 82 ff ff ff       	call   8006b1 <exit>

	// should not return here
	while (1) ;
  80072f:	eb fe                	jmp    80072f <_panic+0x70>

00800731 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800731:	55                   	push   %ebp
  800732:	89 e5                	mov    %esp,%ebp
  800734:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800737:	a1 04 30 80 00       	mov    0x803004,%eax
  80073c:	8b 50 74             	mov    0x74(%eax),%edx
  80073f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800742:	39 c2                	cmp    %eax,%edx
  800744:	74 14                	je     80075a <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800746:	83 ec 04             	sub    $0x4,%esp
  800749:	68 90 22 80 00       	push   $0x802290
  80074e:	6a 26                	push   $0x26
  800750:	68 dc 22 80 00       	push   $0x8022dc
  800755:	e8 65 ff ff ff       	call   8006bf <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80075a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800761:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800768:	e9 c2 00 00 00       	jmp    80082f <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80076d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800770:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800777:	8b 45 08             	mov    0x8(%ebp),%eax
  80077a:	01 d0                	add    %edx,%eax
  80077c:	8b 00                	mov    (%eax),%eax
  80077e:	85 c0                	test   %eax,%eax
  800780:	75 08                	jne    80078a <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800782:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800785:	e9 a2 00 00 00       	jmp    80082c <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80078a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800791:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800798:	eb 69                	jmp    800803 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80079a:	a1 04 30 80 00       	mov    0x803004,%eax
  80079f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007a5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007a8:	89 d0                	mov    %edx,%eax
  8007aa:	01 c0                	add    %eax,%eax
  8007ac:	01 d0                	add    %edx,%eax
  8007ae:	c1 e0 02             	shl    $0x2,%eax
  8007b1:	01 c8                	add    %ecx,%eax
  8007b3:	8a 40 04             	mov    0x4(%eax),%al
  8007b6:	84 c0                	test   %al,%al
  8007b8:	75 46                	jne    800800 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007ba:	a1 04 30 80 00       	mov    0x803004,%eax
  8007bf:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007c5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007c8:	89 d0                	mov    %edx,%eax
  8007ca:	01 c0                	add    %eax,%eax
  8007cc:	01 d0                	add    %edx,%eax
  8007ce:	c1 e0 02             	shl    $0x2,%eax
  8007d1:	01 c8                	add    %ecx,%eax
  8007d3:	8b 00                	mov    (%eax),%eax
  8007d5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007e0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	01 c8                	add    %ecx,%eax
  8007f1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007f3:	39 c2                	cmp    %eax,%edx
  8007f5:	75 09                	jne    800800 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8007f7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007fe:	eb 12                	jmp    800812 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800800:	ff 45 e8             	incl   -0x18(%ebp)
  800803:	a1 04 30 80 00       	mov    0x803004,%eax
  800808:	8b 50 74             	mov    0x74(%eax),%edx
  80080b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80080e:	39 c2                	cmp    %eax,%edx
  800810:	77 88                	ja     80079a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800812:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800816:	75 14                	jne    80082c <CheckWSWithoutLastIndex+0xfb>
			panic(
  800818:	83 ec 04             	sub    $0x4,%esp
  80081b:	68 e8 22 80 00       	push   $0x8022e8
  800820:	6a 3a                	push   $0x3a
  800822:	68 dc 22 80 00       	push   $0x8022dc
  800827:	e8 93 fe ff ff       	call   8006bf <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80082c:	ff 45 f0             	incl   -0x10(%ebp)
  80082f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800832:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800835:	0f 8c 32 ff ff ff    	jl     80076d <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80083b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800842:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800849:	eb 26                	jmp    800871 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80084b:	a1 04 30 80 00       	mov    0x803004,%eax
  800850:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800856:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800859:	89 d0                	mov    %edx,%eax
  80085b:	01 c0                	add    %eax,%eax
  80085d:	01 d0                	add    %edx,%eax
  80085f:	c1 e0 02             	shl    $0x2,%eax
  800862:	01 c8                	add    %ecx,%eax
  800864:	8a 40 04             	mov    0x4(%eax),%al
  800867:	3c 01                	cmp    $0x1,%al
  800869:	75 03                	jne    80086e <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80086b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80086e:	ff 45 e0             	incl   -0x20(%ebp)
  800871:	a1 04 30 80 00       	mov    0x803004,%eax
  800876:	8b 50 74             	mov    0x74(%eax),%edx
  800879:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80087c:	39 c2                	cmp    %eax,%edx
  80087e:	77 cb                	ja     80084b <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800880:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800883:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800886:	74 14                	je     80089c <CheckWSWithoutLastIndex+0x16b>
		panic(
  800888:	83 ec 04             	sub    $0x4,%esp
  80088b:	68 3c 23 80 00       	push   $0x80233c
  800890:	6a 44                	push   $0x44
  800892:	68 dc 22 80 00       	push   $0x8022dc
  800897:	e8 23 fe ff ff       	call   8006bf <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80089c:	90                   	nop
  80089d:	c9                   	leave  
  80089e:	c3                   	ret    

0080089f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80089f:	55                   	push   %ebp
  8008a0:	89 e5                	mov    %esp,%ebp
  8008a2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a8:	8b 00                	mov    (%eax),%eax
  8008aa:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b0:	89 0a                	mov    %ecx,(%edx)
  8008b2:	8b 55 08             	mov    0x8(%ebp),%edx
  8008b5:	88 d1                	mov    %dl,%cl
  8008b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ba:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c1:	8b 00                	mov    (%eax),%eax
  8008c3:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008c8:	75 2c                	jne    8008f6 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008ca:	a0 08 30 80 00       	mov    0x803008,%al
  8008cf:	0f b6 c0             	movzbl %al,%eax
  8008d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d5:	8b 12                	mov    (%edx),%edx
  8008d7:	89 d1                	mov    %edx,%ecx
  8008d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008dc:	83 c2 08             	add    $0x8,%edx
  8008df:	83 ec 04             	sub    $0x4,%esp
  8008e2:	50                   	push   %eax
  8008e3:	51                   	push   %ecx
  8008e4:	52                   	push   %edx
  8008e5:	e8 3e 0e 00 00       	call   801728 <sys_cputs>
  8008ea:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f9:	8b 40 04             	mov    0x4(%eax),%eax
  8008fc:	8d 50 01             	lea    0x1(%eax),%edx
  8008ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800902:	89 50 04             	mov    %edx,0x4(%eax)
}
  800905:	90                   	nop
  800906:	c9                   	leave  
  800907:	c3                   	ret    

00800908 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800908:	55                   	push   %ebp
  800909:	89 e5                	mov    %esp,%ebp
  80090b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800911:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800918:	00 00 00 
	b.cnt = 0;
  80091b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800922:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800925:	ff 75 0c             	pushl  0xc(%ebp)
  800928:	ff 75 08             	pushl  0x8(%ebp)
  80092b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800931:	50                   	push   %eax
  800932:	68 9f 08 80 00       	push   $0x80089f
  800937:	e8 11 02 00 00       	call   800b4d <vprintfmt>
  80093c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80093f:	a0 08 30 80 00       	mov    0x803008,%al
  800944:	0f b6 c0             	movzbl %al,%eax
  800947:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80094d:	83 ec 04             	sub    $0x4,%esp
  800950:	50                   	push   %eax
  800951:	52                   	push   %edx
  800952:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800958:	83 c0 08             	add    $0x8,%eax
  80095b:	50                   	push   %eax
  80095c:	e8 c7 0d 00 00       	call   801728 <sys_cputs>
  800961:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800964:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  80096b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800971:	c9                   	leave  
  800972:	c3                   	ret    

00800973 <cprintf>:

int cprintf(const char *fmt, ...) {
  800973:	55                   	push   %ebp
  800974:	89 e5                	mov    %esp,%ebp
  800976:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800979:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800980:	8d 45 0c             	lea    0xc(%ebp),%eax
  800983:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800986:	8b 45 08             	mov    0x8(%ebp),%eax
  800989:	83 ec 08             	sub    $0x8,%esp
  80098c:	ff 75 f4             	pushl  -0xc(%ebp)
  80098f:	50                   	push   %eax
  800990:	e8 73 ff ff ff       	call   800908 <vcprintf>
  800995:	83 c4 10             	add    $0x10,%esp
  800998:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80099b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80099e:	c9                   	leave  
  80099f:	c3                   	ret    

008009a0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009a0:	55                   	push   %ebp
  8009a1:	89 e5                	mov    %esp,%ebp
  8009a3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009a6:	e8 8e 0f 00 00       	call   801939 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009ab:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b4:	83 ec 08             	sub    $0x8,%esp
  8009b7:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ba:	50                   	push   %eax
  8009bb:	e8 48 ff ff ff       	call   800908 <vcprintf>
  8009c0:	83 c4 10             	add    $0x10,%esp
  8009c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009c6:	e8 88 0f 00 00       	call   801953 <sys_enable_interrupt>
	return cnt;
  8009cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009ce:	c9                   	leave  
  8009cf:	c3                   	ret    

008009d0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009d0:	55                   	push   %ebp
  8009d1:	89 e5                	mov    %esp,%ebp
  8009d3:	53                   	push   %ebx
  8009d4:	83 ec 14             	sub    $0x14,%esp
  8009d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8009da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009e3:	8b 45 18             	mov    0x18(%ebp),%eax
  8009e6:	ba 00 00 00 00       	mov    $0x0,%edx
  8009eb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009ee:	77 55                	ja     800a45 <printnum+0x75>
  8009f0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f3:	72 05                	jb     8009fa <printnum+0x2a>
  8009f5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009f8:	77 4b                	ja     800a45 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009fa:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009fd:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a00:	8b 45 18             	mov    0x18(%ebp),%eax
  800a03:	ba 00 00 00 00       	mov    $0x0,%edx
  800a08:	52                   	push   %edx
  800a09:	50                   	push   %eax
  800a0a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a0d:	ff 75 f0             	pushl  -0x10(%ebp)
  800a10:	e8 03 13 00 00       	call   801d18 <__udivdi3>
  800a15:	83 c4 10             	add    $0x10,%esp
  800a18:	83 ec 04             	sub    $0x4,%esp
  800a1b:	ff 75 20             	pushl  0x20(%ebp)
  800a1e:	53                   	push   %ebx
  800a1f:	ff 75 18             	pushl  0x18(%ebp)
  800a22:	52                   	push   %edx
  800a23:	50                   	push   %eax
  800a24:	ff 75 0c             	pushl  0xc(%ebp)
  800a27:	ff 75 08             	pushl  0x8(%ebp)
  800a2a:	e8 a1 ff ff ff       	call   8009d0 <printnum>
  800a2f:	83 c4 20             	add    $0x20,%esp
  800a32:	eb 1a                	jmp    800a4e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a34:	83 ec 08             	sub    $0x8,%esp
  800a37:	ff 75 0c             	pushl  0xc(%ebp)
  800a3a:	ff 75 20             	pushl  0x20(%ebp)
  800a3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a40:	ff d0                	call   *%eax
  800a42:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a45:	ff 4d 1c             	decl   0x1c(%ebp)
  800a48:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a4c:	7f e6                	jg     800a34 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a4e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a51:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a56:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a59:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a5c:	53                   	push   %ebx
  800a5d:	51                   	push   %ecx
  800a5e:	52                   	push   %edx
  800a5f:	50                   	push   %eax
  800a60:	e8 c3 13 00 00       	call   801e28 <__umoddi3>
  800a65:	83 c4 10             	add    $0x10,%esp
  800a68:	05 b4 25 80 00       	add    $0x8025b4,%eax
  800a6d:	8a 00                	mov    (%eax),%al
  800a6f:	0f be c0             	movsbl %al,%eax
  800a72:	83 ec 08             	sub    $0x8,%esp
  800a75:	ff 75 0c             	pushl  0xc(%ebp)
  800a78:	50                   	push   %eax
  800a79:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7c:	ff d0                	call   *%eax
  800a7e:	83 c4 10             	add    $0x10,%esp
}
  800a81:	90                   	nop
  800a82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a85:	c9                   	leave  
  800a86:	c3                   	ret    

00800a87 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a87:	55                   	push   %ebp
  800a88:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a8a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a8e:	7e 1c                	jle    800aac <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a90:	8b 45 08             	mov    0x8(%ebp),%eax
  800a93:	8b 00                	mov    (%eax),%eax
  800a95:	8d 50 08             	lea    0x8(%eax),%edx
  800a98:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9b:	89 10                	mov    %edx,(%eax)
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	8b 00                	mov    (%eax),%eax
  800aa2:	83 e8 08             	sub    $0x8,%eax
  800aa5:	8b 50 04             	mov    0x4(%eax),%edx
  800aa8:	8b 00                	mov    (%eax),%eax
  800aaa:	eb 40                	jmp    800aec <getuint+0x65>
	else if (lflag)
  800aac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ab0:	74 1e                	je     800ad0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	8b 00                	mov    (%eax),%eax
  800ab7:	8d 50 04             	lea    0x4(%eax),%edx
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	89 10                	mov    %edx,(%eax)
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	8b 00                	mov    (%eax),%eax
  800ac4:	83 e8 04             	sub    $0x4,%eax
  800ac7:	8b 00                	mov    (%eax),%eax
  800ac9:	ba 00 00 00 00       	mov    $0x0,%edx
  800ace:	eb 1c                	jmp    800aec <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad3:	8b 00                	mov    (%eax),%eax
  800ad5:	8d 50 04             	lea    0x4(%eax),%edx
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	89 10                	mov    %edx,(%eax)
  800add:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae0:	8b 00                	mov    (%eax),%eax
  800ae2:	83 e8 04             	sub    $0x4,%eax
  800ae5:	8b 00                	mov    (%eax),%eax
  800ae7:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800aec:	5d                   	pop    %ebp
  800aed:	c3                   	ret    

00800aee <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800aee:	55                   	push   %ebp
  800aef:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800af1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800af5:	7e 1c                	jle    800b13 <getint+0x25>
		return va_arg(*ap, long long);
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	8b 00                	mov    (%eax),%eax
  800afc:	8d 50 08             	lea    0x8(%eax),%edx
  800aff:	8b 45 08             	mov    0x8(%ebp),%eax
  800b02:	89 10                	mov    %edx,(%eax)
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	8b 00                	mov    (%eax),%eax
  800b09:	83 e8 08             	sub    $0x8,%eax
  800b0c:	8b 50 04             	mov    0x4(%eax),%edx
  800b0f:	8b 00                	mov    (%eax),%eax
  800b11:	eb 38                	jmp    800b4b <getint+0x5d>
	else if (lflag)
  800b13:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b17:	74 1a                	je     800b33 <getint+0x45>
		return va_arg(*ap, long);
  800b19:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1c:	8b 00                	mov    (%eax),%eax
  800b1e:	8d 50 04             	lea    0x4(%eax),%edx
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	89 10                	mov    %edx,(%eax)
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	8b 00                	mov    (%eax),%eax
  800b2b:	83 e8 04             	sub    $0x4,%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	99                   	cltd   
  800b31:	eb 18                	jmp    800b4b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	8b 00                	mov    (%eax),%eax
  800b38:	8d 50 04             	lea    0x4(%eax),%edx
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	89 10                	mov    %edx,(%eax)
  800b40:	8b 45 08             	mov    0x8(%ebp),%eax
  800b43:	8b 00                	mov    (%eax),%eax
  800b45:	83 e8 04             	sub    $0x4,%eax
  800b48:	8b 00                	mov    (%eax),%eax
  800b4a:	99                   	cltd   
}
  800b4b:	5d                   	pop    %ebp
  800b4c:	c3                   	ret    

00800b4d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b4d:	55                   	push   %ebp
  800b4e:	89 e5                	mov    %esp,%ebp
  800b50:	56                   	push   %esi
  800b51:	53                   	push   %ebx
  800b52:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b55:	eb 17                	jmp    800b6e <vprintfmt+0x21>
			if (ch == '\0')
  800b57:	85 db                	test   %ebx,%ebx
  800b59:	0f 84 af 03 00 00    	je     800f0e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b5f:	83 ec 08             	sub    $0x8,%esp
  800b62:	ff 75 0c             	pushl  0xc(%ebp)
  800b65:	53                   	push   %ebx
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	ff d0                	call   *%eax
  800b6b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b6e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b71:	8d 50 01             	lea    0x1(%eax),%edx
  800b74:	89 55 10             	mov    %edx,0x10(%ebp)
  800b77:	8a 00                	mov    (%eax),%al
  800b79:	0f b6 d8             	movzbl %al,%ebx
  800b7c:	83 fb 25             	cmp    $0x25,%ebx
  800b7f:	75 d6                	jne    800b57 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b81:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b85:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b8c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b93:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b9a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ba1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba4:	8d 50 01             	lea    0x1(%eax),%edx
  800ba7:	89 55 10             	mov    %edx,0x10(%ebp)
  800baa:	8a 00                	mov    (%eax),%al
  800bac:	0f b6 d8             	movzbl %al,%ebx
  800baf:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bb2:	83 f8 55             	cmp    $0x55,%eax
  800bb5:	0f 87 2b 03 00 00    	ja     800ee6 <vprintfmt+0x399>
  800bbb:	8b 04 85 d8 25 80 00 	mov    0x8025d8(,%eax,4),%eax
  800bc2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bc4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bc8:	eb d7                	jmp    800ba1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bca:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bce:	eb d1                	jmp    800ba1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bd0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bd7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bda:	89 d0                	mov    %edx,%eax
  800bdc:	c1 e0 02             	shl    $0x2,%eax
  800bdf:	01 d0                	add    %edx,%eax
  800be1:	01 c0                	add    %eax,%eax
  800be3:	01 d8                	add    %ebx,%eax
  800be5:	83 e8 30             	sub    $0x30,%eax
  800be8:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800beb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bee:	8a 00                	mov    (%eax),%al
  800bf0:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bf3:	83 fb 2f             	cmp    $0x2f,%ebx
  800bf6:	7e 3e                	jle    800c36 <vprintfmt+0xe9>
  800bf8:	83 fb 39             	cmp    $0x39,%ebx
  800bfb:	7f 39                	jg     800c36 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bfd:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c00:	eb d5                	jmp    800bd7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c02:	8b 45 14             	mov    0x14(%ebp),%eax
  800c05:	83 c0 04             	add    $0x4,%eax
  800c08:	89 45 14             	mov    %eax,0x14(%ebp)
  800c0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0e:	83 e8 04             	sub    $0x4,%eax
  800c11:	8b 00                	mov    (%eax),%eax
  800c13:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c16:	eb 1f                	jmp    800c37 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c18:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c1c:	79 83                	jns    800ba1 <vprintfmt+0x54>
				width = 0;
  800c1e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c25:	e9 77 ff ff ff       	jmp    800ba1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c2a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c31:	e9 6b ff ff ff       	jmp    800ba1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c36:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c37:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c3b:	0f 89 60 ff ff ff    	jns    800ba1 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c41:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c44:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c47:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c4e:	e9 4e ff ff ff       	jmp    800ba1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c53:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c56:	e9 46 ff ff ff       	jmp    800ba1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c5b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5e:	83 c0 04             	add    $0x4,%eax
  800c61:	89 45 14             	mov    %eax,0x14(%ebp)
  800c64:	8b 45 14             	mov    0x14(%ebp),%eax
  800c67:	83 e8 04             	sub    $0x4,%eax
  800c6a:	8b 00                	mov    (%eax),%eax
  800c6c:	83 ec 08             	sub    $0x8,%esp
  800c6f:	ff 75 0c             	pushl  0xc(%ebp)
  800c72:	50                   	push   %eax
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	ff d0                	call   *%eax
  800c78:	83 c4 10             	add    $0x10,%esp
			break;
  800c7b:	e9 89 02 00 00       	jmp    800f09 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c80:	8b 45 14             	mov    0x14(%ebp),%eax
  800c83:	83 c0 04             	add    $0x4,%eax
  800c86:	89 45 14             	mov    %eax,0x14(%ebp)
  800c89:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8c:	83 e8 04             	sub    $0x4,%eax
  800c8f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c91:	85 db                	test   %ebx,%ebx
  800c93:	79 02                	jns    800c97 <vprintfmt+0x14a>
				err = -err;
  800c95:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c97:	83 fb 64             	cmp    $0x64,%ebx
  800c9a:	7f 0b                	jg     800ca7 <vprintfmt+0x15a>
  800c9c:	8b 34 9d 20 24 80 00 	mov    0x802420(,%ebx,4),%esi
  800ca3:	85 f6                	test   %esi,%esi
  800ca5:	75 19                	jne    800cc0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ca7:	53                   	push   %ebx
  800ca8:	68 c5 25 80 00       	push   $0x8025c5
  800cad:	ff 75 0c             	pushl  0xc(%ebp)
  800cb0:	ff 75 08             	pushl  0x8(%ebp)
  800cb3:	e8 5e 02 00 00       	call   800f16 <printfmt>
  800cb8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cbb:	e9 49 02 00 00       	jmp    800f09 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cc0:	56                   	push   %esi
  800cc1:	68 ce 25 80 00       	push   $0x8025ce
  800cc6:	ff 75 0c             	pushl  0xc(%ebp)
  800cc9:	ff 75 08             	pushl  0x8(%ebp)
  800ccc:	e8 45 02 00 00       	call   800f16 <printfmt>
  800cd1:	83 c4 10             	add    $0x10,%esp
			break;
  800cd4:	e9 30 02 00 00       	jmp    800f09 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cd9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cdc:	83 c0 04             	add    $0x4,%eax
  800cdf:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce5:	83 e8 04             	sub    $0x4,%eax
  800ce8:	8b 30                	mov    (%eax),%esi
  800cea:	85 f6                	test   %esi,%esi
  800cec:	75 05                	jne    800cf3 <vprintfmt+0x1a6>
				p = "(null)";
  800cee:	be d1 25 80 00       	mov    $0x8025d1,%esi
			if (width > 0 && padc != '-')
  800cf3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cf7:	7e 6d                	jle    800d66 <vprintfmt+0x219>
  800cf9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cfd:	74 67                	je     800d66 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d02:	83 ec 08             	sub    $0x8,%esp
  800d05:	50                   	push   %eax
  800d06:	56                   	push   %esi
  800d07:	e8 0c 03 00 00       	call   801018 <strnlen>
  800d0c:	83 c4 10             	add    $0x10,%esp
  800d0f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d12:	eb 16                	jmp    800d2a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d14:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d18:	83 ec 08             	sub    $0x8,%esp
  800d1b:	ff 75 0c             	pushl  0xc(%ebp)
  800d1e:	50                   	push   %eax
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	ff d0                	call   *%eax
  800d24:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d27:	ff 4d e4             	decl   -0x1c(%ebp)
  800d2a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d2e:	7f e4                	jg     800d14 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d30:	eb 34                	jmp    800d66 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d32:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d36:	74 1c                	je     800d54 <vprintfmt+0x207>
  800d38:	83 fb 1f             	cmp    $0x1f,%ebx
  800d3b:	7e 05                	jle    800d42 <vprintfmt+0x1f5>
  800d3d:	83 fb 7e             	cmp    $0x7e,%ebx
  800d40:	7e 12                	jle    800d54 <vprintfmt+0x207>
					putch('?', putdat);
  800d42:	83 ec 08             	sub    $0x8,%esp
  800d45:	ff 75 0c             	pushl  0xc(%ebp)
  800d48:	6a 3f                	push   $0x3f
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	ff d0                	call   *%eax
  800d4f:	83 c4 10             	add    $0x10,%esp
  800d52:	eb 0f                	jmp    800d63 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d54:	83 ec 08             	sub    $0x8,%esp
  800d57:	ff 75 0c             	pushl  0xc(%ebp)
  800d5a:	53                   	push   %ebx
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	ff d0                	call   *%eax
  800d60:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d63:	ff 4d e4             	decl   -0x1c(%ebp)
  800d66:	89 f0                	mov    %esi,%eax
  800d68:	8d 70 01             	lea    0x1(%eax),%esi
  800d6b:	8a 00                	mov    (%eax),%al
  800d6d:	0f be d8             	movsbl %al,%ebx
  800d70:	85 db                	test   %ebx,%ebx
  800d72:	74 24                	je     800d98 <vprintfmt+0x24b>
  800d74:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d78:	78 b8                	js     800d32 <vprintfmt+0x1e5>
  800d7a:	ff 4d e0             	decl   -0x20(%ebp)
  800d7d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d81:	79 af                	jns    800d32 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d83:	eb 13                	jmp    800d98 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d85:	83 ec 08             	sub    $0x8,%esp
  800d88:	ff 75 0c             	pushl  0xc(%ebp)
  800d8b:	6a 20                	push   $0x20
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	ff d0                	call   *%eax
  800d92:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d95:	ff 4d e4             	decl   -0x1c(%ebp)
  800d98:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d9c:	7f e7                	jg     800d85 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d9e:	e9 66 01 00 00       	jmp    800f09 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800da3:	83 ec 08             	sub    $0x8,%esp
  800da6:	ff 75 e8             	pushl  -0x18(%ebp)
  800da9:	8d 45 14             	lea    0x14(%ebp),%eax
  800dac:	50                   	push   %eax
  800dad:	e8 3c fd ff ff       	call   800aee <getint>
  800db2:	83 c4 10             	add    $0x10,%esp
  800db5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800db8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dbe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dc1:	85 d2                	test   %edx,%edx
  800dc3:	79 23                	jns    800de8 <vprintfmt+0x29b>
				putch('-', putdat);
  800dc5:	83 ec 08             	sub    $0x8,%esp
  800dc8:	ff 75 0c             	pushl  0xc(%ebp)
  800dcb:	6a 2d                	push   $0x2d
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	ff d0                	call   *%eax
  800dd2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dd8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ddb:	f7 d8                	neg    %eax
  800ddd:	83 d2 00             	adc    $0x0,%edx
  800de0:	f7 da                	neg    %edx
  800de2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800de8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800def:	e9 bc 00 00 00       	jmp    800eb0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800df4:	83 ec 08             	sub    $0x8,%esp
  800df7:	ff 75 e8             	pushl  -0x18(%ebp)
  800dfa:	8d 45 14             	lea    0x14(%ebp),%eax
  800dfd:	50                   	push   %eax
  800dfe:	e8 84 fc ff ff       	call   800a87 <getuint>
  800e03:	83 c4 10             	add    $0x10,%esp
  800e06:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e09:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e0c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e13:	e9 98 00 00 00       	jmp    800eb0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e18:	83 ec 08             	sub    $0x8,%esp
  800e1b:	ff 75 0c             	pushl  0xc(%ebp)
  800e1e:	6a 58                	push   $0x58
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
  800e23:	ff d0                	call   *%eax
  800e25:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e28:	83 ec 08             	sub    $0x8,%esp
  800e2b:	ff 75 0c             	pushl  0xc(%ebp)
  800e2e:	6a 58                	push   $0x58
  800e30:	8b 45 08             	mov    0x8(%ebp),%eax
  800e33:	ff d0                	call   *%eax
  800e35:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e38:	83 ec 08             	sub    $0x8,%esp
  800e3b:	ff 75 0c             	pushl  0xc(%ebp)
  800e3e:	6a 58                	push   $0x58
  800e40:	8b 45 08             	mov    0x8(%ebp),%eax
  800e43:	ff d0                	call   *%eax
  800e45:	83 c4 10             	add    $0x10,%esp
			break;
  800e48:	e9 bc 00 00 00       	jmp    800f09 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e4d:	83 ec 08             	sub    $0x8,%esp
  800e50:	ff 75 0c             	pushl  0xc(%ebp)
  800e53:	6a 30                	push   $0x30
  800e55:	8b 45 08             	mov    0x8(%ebp),%eax
  800e58:	ff d0                	call   *%eax
  800e5a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e5d:	83 ec 08             	sub    $0x8,%esp
  800e60:	ff 75 0c             	pushl  0xc(%ebp)
  800e63:	6a 78                	push   $0x78
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	ff d0                	call   *%eax
  800e6a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e70:	83 c0 04             	add    $0x4,%eax
  800e73:	89 45 14             	mov    %eax,0x14(%ebp)
  800e76:	8b 45 14             	mov    0x14(%ebp),%eax
  800e79:	83 e8 04             	sub    $0x4,%eax
  800e7c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e88:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e8f:	eb 1f                	jmp    800eb0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e91:	83 ec 08             	sub    $0x8,%esp
  800e94:	ff 75 e8             	pushl  -0x18(%ebp)
  800e97:	8d 45 14             	lea    0x14(%ebp),%eax
  800e9a:	50                   	push   %eax
  800e9b:	e8 e7 fb ff ff       	call   800a87 <getuint>
  800ea0:	83 c4 10             	add    $0x10,%esp
  800ea3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ea9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eb0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800eb4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800eb7:	83 ec 04             	sub    $0x4,%esp
  800eba:	52                   	push   %edx
  800ebb:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ebe:	50                   	push   %eax
  800ebf:	ff 75 f4             	pushl  -0xc(%ebp)
  800ec2:	ff 75 f0             	pushl  -0x10(%ebp)
  800ec5:	ff 75 0c             	pushl  0xc(%ebp)
  800ec8:	ff 75 08             	pushl  0x8(%ebp)
  800ecb:	e8 00 fb ff ff       	call   8009d0 <printnum>
  800ed0:	83 c4 20             	add    $0x20,%esp
			break;
  800ed3:	eb 34                	jmp    800f09 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ed5:	83 ec 08             	sub    $0x8,%esp
  800ed8:	ff 75 0c             	pushl  0xc(%ebp)
  800edb:	53                   	push   %ebx
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
  800edf:	ff d0                	call   *%eax
  800ee1:	83 c4 10             	add    $0x10,%esp
			break;
  800ee4:	eb 23                	jmp    800f09 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ee6:	83 ec 08             	sub    $0x8,%esp
  800ee9:	ff 75 0c             	pushl  0xc(%ebp)
  800eec:	6a 25                	push   $0x25
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	ff d0                	call   *%eax
  800ef3:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ef6:	ff 4d 10             	decl   0x10(%ebp)
  800ef9:	eb 03                	jmp    800efe <vprintfmt+0x3b1>
  800efb:	ff 4d 10             	decl   0x10(%ebp)
  800efe:	8b 45 10             	mov    0x10(%ebp),%eax
  800f01:	48                   	dec    %eax
  800f02:	8a 00                	mov    (%eax),%al
  800f04:	3c 25                	cmp    $0x25,%al
  800f06:	75 f3                	jne    800efb <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f08:	90                   	nop
		}
	}
  800f09:	e9 47 fc ff ff       	jmp    800b55 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f0e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f12:	5b                   	pop    %ebx
  800f13:	5e                   	pop    %esi
  800f14:	5d                   	pop    %ebp
  800f15:	c3                   	ret    

00800f16 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f16:	55                   	push   %ebp
  800f17:	89 e5                	mov    %esp,%ebp
  800f19:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f1c:	8d 45 10             	lea    0x10(%ebp),%eax
  800f1f:	83 c0 04             	add    $0x4,%eax
  800f22:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f25:	8b 45 10             	mov    0x10(%ebp),%eax
  800f28:	ff 75 f4             	pushl  -0xc(%ebp)
  800f2b:	50                   	push   %eax
  800f2c:	ff 75 0c             	pushl  0xc(%ebp)
  800f2f:	ff 75 08             	pushl  0x8(%ebp)
  800f32:	e8 16 fc ff ff       	call   800b4d <vprintfmt>
  800f37:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f3a:	90                   	nop
  800f3b:	c9                   	leave  
  800f3c:	c3                   	ret    

00800f3d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f3d:	55                   	push   %ebp
  800f3e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f43:	8b 40 08             	mov    0x8(%eax),%eax
  800f46:	8d 50 01             	lea    0x1(%eax),%edx
  800f49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f52:	8b 10                	mov    (%eax),%edx
  800f54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f57:	8b 40 04             	mov    0x4(%eax),%eax
  800f5a:	39 c2                	cmp    %eax,%edx
  800f5c:	73 12                	jae    800f70 <sprintputch+0x33>
		*b->buf++ = ch;
  800f5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f61:	8b 00                	mov    (%eax),%eax
  800f63:	8d 48 01             	lea    0x1(%eax),%ecx
  800f66:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f69:	89 0a                	mov    %ecx,(%edx)
  800f6b:	8b 55 08             	mov    0x8(%ebp),%edx
  800f6e:	88 10                	mov    %dl,(%eax)
}
  800f70:	90                   	nop
  800f71:	5d                   	pop    %ebp
  800f72:	c3                   	ret    

00800f73 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f73:	55                   	push   %ebp
  800f74:	89 e5                	mov    %esp,%ebp
  800f76:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f82:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	01 d0                	add    %edx,%eax
  800f8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f94:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f98:	74 06                	je     800fa0 <vsnprintf+0x2d>
  800f9a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f9e:	7f 07                	jg     800fa7 <vsnprintf+0x34>
		return -E_INVAL;
  800fa0:	b8 03 00 00 00       	mov    $0x3,%eax
  800fa5:	eb 20                	jmp    800fc7 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fa7:	ff 75 14             	pushl  0x14(%ebp)
  800faa:	ff 75 10             	pushl  0x10(%ebp)
  800fad:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fb0:	50                   	push   %eax
  800fb1:	68 3d 0f 80 00       	push   $0x800f3d
  800fb6:	e8 92 fb ff ff       	call   800b4d <vprintfmt>
  800fbb:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fbe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fc1:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fc7:	c9                   	leave  
  800fc8:	c3                   	ret    

00800fc9 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fc9:	55                   	push   %ebp
  800fca:	89 e5                	mov    %esp,%ebp
  800fcc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fcf:	8d 45 10             	lea    0x10(%ebp),%eax
  800fd2:	83 c0 04             	add    $0x4,%eax
  800fd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdb:	ff 75 f4             	pushl  -0xc(%ebp)
  800fde:	50                   	push   %eax
  800fdf:	ff 75 0c             	pushl  0xc(%ebp)
  800fe2:	ff 75 08             	pushl  0x8(%ebp)
  800fe5:	e8 89 ff ff ff       	call   800f73 <vsnprintf>
  800fea:	83 c4 10             	add    $0x10,%esp
  800fed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ff0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ff3:	c9                   	leave  
  800ff4:	c3                   	ret    

00800ff5 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ff5:	55                   	push   %ebp
  800ff6:	89 e5                	mov    %esp,%ebp
  800ff8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ffb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801002:	eb 06                	jmp    80100a <strlen+0x15>
		n++;
  801004:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801007:	ff 45 08             	incl   0x8(%ebp)
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	8a 00                	mov    (%eax),%al
  80100f:	84 c0                	test   %al,%al
  801011:	75 f1                	jne    801004 <strlen+0xf>
		n++;
	return n;
  801013:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801016:	c9                   	leave  
  801017:	c3                   	ret    

00801018 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801018:	55                   	push   %ebp
  801019:	89 e5                	mov    %esp,%ebp
  80101b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80101e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801025:	eb 09                	jmp    801030 <strnlen+0x18>
		n++;
  801027:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80102a:	ff 45 08             	incl   0x8(%ebp)
  80102d:	ff 4d 0c             	decl   0xc(%ebp)
  801030:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801034:	74 09                	je     80103f <strnlen+0x27>
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	8a 00                	mov    (%eax),%al
  80103b:	84 c0                	test   %al,%al
  80103d:	75 e8                	jne    801027 <strnlen+0xf>
		n++;
	return n;
  80103f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801042:	c9                   	leave  
  801043:	c3                   	ret    

00801044 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801044:	55                   	push   %ebp
  801045:	89 e5                	mov    %esp,%ebp
  801047:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80104a:	8b 45 08             	mov    0x8(%ebp),%eax
  80104d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801050:	90                   	nop
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	8d 50 01             	lea    0x1(%eax),%edx
  801057:	89 55 08             	mov    %edx,0x8(%ebp)
  80105a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80105d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801060:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801063:	8a 12                	mov    (%edx),%dl
  801065:	88 10                	mov    %dl,(%eax)
  801067:	8a 00                	mov    (%eax),%al
  801069:	84 c0                	test   %al,%al
  80106b:	75 e4                	jne    801051 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80106d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801070:	c9                   	leave  
  801071:	c3                   	ret    

00801072 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801072:	55                   	push   %ebp
  801073:	89 e5                	mov    %esp,%ebp
  801075:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
  80107b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80107e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801085:	eb 1f                	jmp    8010a6 <strncpy+0x34>
		*dst++ = *src;
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	8d 50 01             	lea    0x1(%eax),%edx
  80108d:	89 55 08             	mov    %edx,0x8(%ebp)
  801090:	8b 55 0c             	mov    0xc(%ebp),%edx
  801093:	8a 12                	mov    (%edx),%dl
  801095:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801097:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109a:	8a 00                	mov    (%eax),%al
  80109c:	84 c0                	test   %al,%al
  80109e:	74 03                	je     8010a3 <strncpy+0x31>
			src++;
  8010a0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010a3:	ff 45 fc             	incl   -0x4(%ebp)
  8010a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010ac:	72 d9                	jb     801087 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010b1:	c9                   	leave  
  8010b2:	c3                   	ret    

008010b3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010b3:	55                   	push   %ebp
  8010b4:	89 e5                	mov    %esp,%ebp
  8010b6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c3:	74 30                	je     8010f5 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010c5:	eb 16                	jmp    8010dd <strlcpy+0x2a>
			*dst++ = *src++;
  8010c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ca:	8d 50 01             	lea    0x1(%eax),%edx
  8010cd:	89 55 08             	mov    %edx,0x8(%ebp)
  8010d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010d6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010d9:	8a 12                	mov    (%edx),%dl
  8010db:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010dd:	ff 4d 10             	decl   0x10(%ebp)
  8010e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e4:	74 09                	je     8010ef <strlcpy+0x3c>
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	8a 00                	mov    (%eax),%al
  8010eb:	84 c0                	test   %al,%al
  8010ed:	75 d8                	jne    8010c7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f2:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010f5:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010fb:	29 c2                	sub    %eax,%edx
  8010fd:	89 d0                	mov    %edx,%eax
}
  8010ff:	c9                   	leave  
  801100:	c3                   	ret    

00801101 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801101:	55                   	push   %ebp
  801102:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801104:	eb 06                	jmp    80110c <strcmp+0xb>
		p++, q++;
  801106:	ff 45 08             	incl   0x8(%ebp)
  801109:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80110c:	8b 45 08             	mov    0x8(%ebp),%eax
  80110f:	8a 00                	mov    (%eax),%al
  801111:	84 c0                	test   %al,%al
  801113:	74 0e                	je     801123 <strcmp+0x22>
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	8a 10                	mov    (%eax),%dl
  80111a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111d:	8a 00                	mov    (%eax),%al
  80111f:	38 c2                	cmp    %al,%dl
  801121:	74 e3                	je     801106 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801123:	8b 45 08             	mov    0x8(%ebp),%eax
  801126:	8a 00                	mov    (%eax),%al
  801128:	0f b6 d0             	movzbl %al,%edx
  80112b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112e:	8a 00                	mov    (%eax),%al
  801130:	0f b6 c0             	movzbl %al,%eax
  801133:	29 c2                	sub    %eax,%edx
  801135:	89 d0                	mov    %edx,%eax
}
  801137:	5d                   	pop    %ebp
  801138:	c3                   	ret    

00801139 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801139:	55                   	push   %ebp
  80113a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80113c:	eb 09                	jmp    801147 <strncmp+0xe>
		n--, p++, q++;
  80113e:	ff 4d 10             	decl   0x10(%ebp)
  801141:	ff 45 08             	incl   0x8(%ebp)
  801144:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801147:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80114b:	74 17                	je     801164 <strncmp+0x2b>
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	8a 00                	mov    (%eax),%al
  801152:	84 c0                	test   %al,%al
  801154:	74 0e                	je     801164 <strncmp+0x2b>
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	8a 10                	mov    (%eax),%dl
  80115b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115e:	8a 00                	mov    (%eax),%al
  801160:	38 c2                	cmp    %al,%dl
  801162:	74 da                	je     80113e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801164:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801168:	75 07                	jne    801171 <strncmp+0x38>
		return 0;
  80116a:	b8 00 00 00 00       	mov    $0x0,%eax
  80116f:	eb 14                	jmp    801185 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	0f b6 d0             	movzbl %al,%edx
  801179:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	0f b6 c0             	movzbl %al,%eax
  801181:	29 c2                	sub    %eax,%edx
  801183:	89 d0                	mov    %edx,%eax
}
  801185:	5d                   	pop    %ebp
  801186:	c3                   	ret    

00801187 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801187:	55                   	push   %ebp
  801188:	89 e5                	mov    %esp,%ebp
  80118a:	83 ec 04             	sub    $0x4,%esp
  80118d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801190:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801193:	eb 12                	jmp    8011a7 <strchr+0x20>
		if (*s == c)
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80119d:	75 05                	jne    8011a4 <strchr+0x1d>
			return (char *) s;
  80119f:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a2:	eb 11                	jmp    8011b5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011a4:	ff 45 08             	incl   0x8(%ebp)
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	8a 00                	mov    (%eax),%al
  8011ac:	84 c0                	test   %al,%al
  8011ae:	75 e5                	jne    801195 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011b5:	c9                   	leave  
  8011b6:	c3                   	ret    

008011b7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011b7:	55                   	push   %ebp
  8011b8:	89 e5                	mov    %esp,%ebp
  8011ba:	83 ec 04             	sub    $0x4,%esp
  8011bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011c3:	eb 0d                	jmp    8011d2 <strfind+0x1b>
		if (*s == c)
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	8a 00                	mov    (%eax),%al
  8011ca:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011cd:	74 0e                	je     8011dd <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011cf:	ff 45 08             	incl   0x8(%ebp)
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	8a 00                	mov    (%eax),%al
  8011d7:	84 c0                	test   %al,%al
  8011d9:	75 ea                	jne    8011c5 <strfind+0xe>
  8011db:	eb 01                	jmp    8011de <strfind+0x27>
		if (*s == c)
			break;
  8011dd:	90                   	nop
	return (char *) s;
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
  8011e6:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011f5:	eb 0e                	jmp    801205 <memset+0x22>
		*p++ = c;
  8011f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011fa:	8d 50 01             	lea    0x1(%eax),%edx
  8011fd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801200:	8b 55 0c             	mov    0xc(%ebp),%edx
  801203:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801205:	ff 4d f8             	decl   -0x8(%ebp)
  801208:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80120c:	79 e9                	jns    8011f7 <memset+0x14>
		*p++ = c;

	return v;
  80120e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801211:	c9                   	leave  
  801212:	c3                   	ret    

00801213 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801213:	55                   	push   %ebp
  801214:	89 e5                	mov    %esp,%ebp
  801216:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801219:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801225:	eb 16                	jmp    80123d <memcpy+0x2a>
		*d++ = *s++;
  801227:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122a:	8d 50 01             	lea    0x1(%eax),%edx
  80122d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801230:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801233:	8d 4a 01             	lea    0x1(%edx),%ecx
  801236:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801239:	8a 12                	mov    (%edx),%dl
  80123b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80123d:	8b 45 10             	mov    0x10(%ebp),%eax
  801240:	8d 50 ff             	lea    -0x1(%eax),%edx
  801243:	89 55 10             	mov    %edx,0x10(%ebp)
  801246:	85 c0                	test   %eax,%eax
  801248:	75 dd                	jne    801227 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80124d:	c9                   	leave  
  80124e:	c3                   	ret    

0080124f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80124f:	55                   	push   %ebp
  801250:	89 e5                	mov    %esp,%ebp
  801252:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801255:	8b 45 0c             	mov    0xc(%ebp),%eax
  801258:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80125b:	8b 45 08             	mov    0x8(%ebp),%eax
  80125e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801261:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801264:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801267:	73 50                	jae    8012b9 <memmove+0x6a>
  801269:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80126c:	8b 45 10             	mov    0x10(%ebp),%eax
  80126f:	01 d0                	add    %edx,%eax
  801271:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801274:	76 43                	jbe    8012b9 <memmove+0x6a>
		s += n;
  801276:	8b 45 10             	mov    0x10(%ebp),%eax
  801279:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80127c:	8b 45 10             	mov    0x10(%ebp),%eax
  80127f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801282:	eb 10                	jmp    801294 <memmove+0x45>
			*--d = *--s;
  801284:	ff 4d f8             	decl   -0x8(%ebp)
  801287:	ff 4d fc             	decl   -0x4(%ebp)
  80128a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80128d:	8a 10                	mov    (%eax),%dl
  80128f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801292:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801294:	8b 45 10             	mov    0x10(%ebp),%eax
  801297:	8d 50 ff             	lea    -0x1(%eax),%edx
  80129a:	89 55 10             	mov    %edx,0x10(%ebp)
  80129d:	85 c0                	test   %eax,%eax
  80129f:	75 e3                	jne    801284 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012a1:	eb 23                	jmp    8012c6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a6:	8d 50 01             	lea    0x1(%eax),%edx
  8012a9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012af:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012b2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012b5:	8a 12                	mov    (%edx),%dl
  8012b7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012bf:	89 55 10             	mov    %edx,0x10(%ebp)
  8012c2:	85 c0                	test   %eax,%eax
  8012c4:	75 dd                	jne    8012a3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012c9:	c9                   	leave  
  8012ca:	c3                   	ret    

008012cb <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012cb:	55                   	push   %ebp
  8012cc:	89 e5                	mov    %esp,%ebp
  8012ce:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012da:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012dd:	eb 2a                	jmp    801309 <memcmp+0x3e>
		if (*s1 != *s2)
  8012df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e2:	8a 10                	mov    (%eax),%dl
  8012e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e7:	8a 00                	mov    (%eax),%al
  8012e9:	38 c2                	cmp    %al,%dl
  8012eb:	74 16                	je     801303 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f0:	8a 00                	mov    (%eax),%al
  8012f2:	0f b6 d0             	movzbl %al,%edx
  8012f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	0f b6 c0             	movzbl %al,%eax
  8012fd:	29 c2                	sub    %eax,%edx
  8012ff:	89 d0                	mov    %edx,%eax
  801301:	eb 18                	jmp    80131b <memcmp+0x50>
		s1++, s2++;
  801303:	ff 45 fc             	incl   -0x4(%ebp)
  801306:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801309:	8b 45 10             	mov    0x10(%ebp),%eax
  80130c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80130f:	89 55 10             	mov    %edx,0x10(%ebp)
  801312:	85 c0                	test   %eax,%eax
  801314:	75 c9                	jne    8012df <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801316:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
  801320:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801323:	8b 55 08             	mov    0x8(%ebp),%edx
  801326:	8b 45 10             	mov    0x10(%ebp),%eax
  801329:	01 d0                	add    %edx,%eax
  80132b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80132e:	eb 15                	jmp    801345 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	0f b6 d0             	movzbl %al,%edx
  801338:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133b:	0f b6 c0             	movzbl %al,%eax
  80133e:	39 c2                	cmp    %eax,%edx
  801340:	74 0d                	je     80134f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801342:	ff 45 08             	incl   0x8(%ebp)
  801345:	8b 45 08             	mov    0x8(%ebp),%eax
  801348:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80134b:	72 e3                	jb     801330 <memfind+0x13>
  80134d:	eb 01                	jmp    801350 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80134f:	90                   	nop
	return (void *) s;
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801353:	c9                   	leave  
  801354:	c3                   	ret    

00801355 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801355:	55                   	push   %ebp
  801356:	89 e5                	mov    %esp,%ebp
  801358:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80135b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801362:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801369:	eb 03                	jmp    80136e <strtol+0x19>
		s++;
  80136b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80136e:	8b 45 08             	mov    0x8(%ebp),%eax
  801371:	8a 00                	mov    (%eax),%al
  801373:	3c 20                	cmp    $0x20,%al
  801375:	74 f4                	je     80136b <strtol+0x16>
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	8a 00                	mov    (%eax),%al
  80137c:	3c 09                	cmp    $0x9,%al
  80137e:	74 eb                	je     80136b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801380:	8b 45 08             	mov    0x8(%ebp),%eax
  801383:	8a 00                	mov    (%eax),%al
  801385:	3c 2b                	cmp    $0x2b,%al
  801387:	75 05                	jne    80138e <strtol+0x39>
		s++;
  801389:	ff 45 08             	incl   0x8(%ebp)
  80138c:	eb 13                	jmp    8013a1 <strtol+0x4c>
	else if (*s == '-')
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	8a 00                	mov    (%eax),%al
  801393:	3c 2d                	cmp    $0x2d,%al
  801395:	75 0a                	jne    8013a1 <strtol+0x4c>
		s++, neg = 1;
  801397:	ff 45 08             	incl   0x8(%ebp)
  80139a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013a1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a5:	74 06                	je     8013ad <strtol+0x58>
  8013a7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013ab:	75 20                	jne    8013cd <strtol+0x78>
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	8a 00                	mov    (%eax),%al
  8013b2:	3c 30                	cmp    $0x30,%al
  8013b4:	75 17                	jne    8013cd <strtol+0x78>
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	40                   	inc    %eax
  8013ba:	8a 00                	mov    (%eax),%al
  8013bc:	3c 78                	cmp    $0x78,%al
  8013be:	75 0d                	jne    8013cd <strtol+0x78>
		s += 2, base = 16;
  8013c0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013c4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013cb:	eb 28                	jmp    8013f5 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013cd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d1:	75 15                	jne    8013e8 <strtol+0x93>
  8013d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d6:	8a 00                	mov    (%eax),%al
  8013d8:	3c 30                	cmp    $0x30,%al
  8013da:	75 0c                	jne    8013e8 <strtol+0x93>
		s++, base = 8;
  8013dc:	ff 45 08             	incl   0x8(%ebp)
  8013df:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013e6:	eb 0d                	jmp    8013f5 <strtol+0xa0>
	else if (base == 0)
  8013e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ec:	75 07                	jne    8013f5 <strtol+0xa0>
		base = 10;
  8013ee:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f8:	8a 00                	mov    (%eax),%al
  8013fa:	3c 2f                	cmp    $0x2f,%al
  8013fc:	7e 19                	jle    801417 <strtol+0xc2>
  8013fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801401:	8a 00                	mov    (%eax),%al
  801403:	3c 39                	cmp    $0x39,%al
  801405:	7f 10                	jg     801417 <strtol+0xc2>
			dig = *s - '0';
  801407:	8b 45 08             	mov    0x8(%ebp),%eax
  80140a:	8a 00                	mov    (%eax),%al
  80140c:	0f be c0             	movsbl %al,%eax
  80140f:	83 e8 30             	sub    $0x30,%eax
  801412:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801415:	eb 42                	jmp    801459 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	8a 00                	mov    (%eax),%al
  80141c:	3c 60                	cmp    $0x60,%al
  80141e:	7e 19                	jle    801439 <strtol+0xe4>
  801420:	8b 45 08             	mov    0x8(%ebp),%eax
  801423:	8a 00                	mov    (%eax),%al
  801425:	3c 7a                	cmp    $0x7a,%al
  801427:	7f 10                	jg     801439 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801429:	8b 45 08             	mov    0x8(%ebp),%eax
  80142c:	8a 00                	mov    (%eax),%al
  80142e:	0f be c0             	movsbl %al,%eax
  801431:	83 e8 57             	sub    $0x57,%eax
  801434:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801437:	eb 20                	jmp    801459 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	8a 00                	mov    (%eax),%al
  80143e:	3c 40                	cmp    $0x40,%al
  801440:	7e 39                	jle    80147b <strtol+0x126>
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	8a 00                	mov    (%eax),%al
  801447:	3c 5a                	cmp    $0x5a,%al
  801449:	7f 30                	jg     80147b <strtol+0x126>
			dig = *s - 'A' + 10;
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	0f be c0             	movsbl %al,%eax
  801453:	83 e8 37             	sub    $0x37,%eax
  801456:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801459:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80145c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80145f:	7d 19                	jge    80147a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801461:	ff 45 08             	incl   0x8(%ebp)
  801464:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801467:	0f af 45 10          	imul   0x10(%ebp),%eax
  80146b:	89 c2                	mov    %eax,%edx
  80146d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801470:	01 d0                	add    %edx,%eax
  801472:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801475:	e9 7b ff ff ff       	jmp    8013f5 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80147a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80147b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80147f:	74 08                	je     801489 <strtol+0x134>
		*endptr = (char *) s;
  801481:	8b 45 0c             	mov    0xc(%ebp),%eax
  801484:	8b 55 08             	mov    0x8(%ebp),%edx
  801487:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801489:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80148d:	74 07                	je     801496 <strtol+0x141>
  80148f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801492:	f7 d8                	neg    %eax
  801494:	eb 03                	jmp    801499 <strtol+0x144>
  801496:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801499:	c9                   	leave  
  80149a:	c3                   	ret    

0080149b <ltostr>:

void
ltostr(long value, char *str)
{
  80149b:	55                   	push   %ebp
  80149c:	89 e5                	mov    %esp,%ebp
  80149e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014af:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014b3:	79 13                	jns    8014c8 <ltostr+0x2d>
	{
		neg = 1;
  8014b5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bf:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014c2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014c5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014d0:	99                   	cltd   
  8014d1:	f7 f9                	idiv   %ecx
  8014d3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d9:	8d 50 01             	lea    0x1(%eax),%edx
  8014dc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014df:	89 c2                	mov    %eax,%edx
  8014e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e4:	01 d0                	add    %edx,%eax
  8014e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014e9:	83 c2 30             	add    $0x30,%edx
  8014ec:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014ee:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014f1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014f6:	f7 e9                	imul   %ecx
  8014f8:	c1 fa 02             	sar    $0x2,%edx
  8014fb:	89 c8                	mov    %ecx,%eax
  8014fd:	c1 f8 1f             	sar    $0x1f,%eax
  801500:	29 c2                	sub    %eax,%edx
  801502:	89 d0                	mov    %edx,%eax
  801504:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801507:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80150a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80150f:	f7 e9                	imul   %ecx
  801511:	c1 fa 02             	sar    $0x2,%edx
  801514:	89 c8                	mov    %ecx,%eax
  801516:	c1 f8 1f             	sar    $0x1f,%eax
  801519:	29 c2                	sub    %eax,%edx
  80151b:	89 d0                	mov    %edx,%eax
  80151d:	c1 e0 02             	shl    $0x2,%eax
  801520:	01 d0                	add    %edx,%eax
  801522:	01 c0                	add    %eax,%eax
  801524:	29 c1                	sub    %eax,%ecx
  801526:	89 ca                	mov    %ecx,%edx
  801528:	85 d2                	test   %edx,%edx
  80152a:	75 9c                	jne    8014c8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80152c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801533:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801536:	48                   	dec    %eax
  801537:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80153a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80153e:	74 3d                	je     80157d <ltostr+0xe2>
		start = 1 ;
  801540:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801547:	eb 34                	jmp    80157d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801549:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80154c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154f:	01 d0                	add    %edx,%eax
  801551:	8a 00                	mov    (%eax),%al
  801553:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801556:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801559:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155c:	01 c2                	add    %eax,%edx
  80155e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801561:	8b 45 0c             	mov    0xc(%ebp),%eax
  801564:	01 c8                	add    %ecx,%eax
  801566:	8a 00                	mov    (%eax),%al
  801568:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80156a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80156d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801570:	01 c2                	add    %eax,%edx
  801572:	8a 45 eb             	mov    -0x15(%ebp),%al
  801575:	88 02                	mov    %al,(%edx)
		start++ ;
  801577:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80157a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80157d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801580:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801583:	7c c4                	jl     801549 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801585:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801588:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158b:	01 d0                	add    %edx,%eax
  80158d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801590:	90                   	nop
  801591:	c9                   	leave  
  801592:	c3                   	ret    

00801593 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801593:	55                   	push   %ebp
  801594:	89 e5                	mov    %esp,%ebp
  801596:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801599:	ff 75 08             	pushl  0x8(%ebp)
  80159c:	e8 54 fa ff ff       	call   800ff5 <strlen>
  8015a1:	83 c4 04             	add    $0x4,%esp
  8015a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015a7:	ff 75 0c             	pushl  0xc(%ebp)
  8015aa:	e8 46 fa ff ff       	call   800ff5 <strlen>
  8015af:	83 c4 04             	add    $0x4,%esp
  8015b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015c3:	eb 17                	jmp    8015dc <strcconcat+0x49>
		final[s] = str1[s] ;
  8015c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8015cb:	01 c2                	add    %eax,%edx
  8015cd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	01 c8                	add    %ecx,%eax
  8015d5:	8a 00                	mov    (%eax),%al
  8015d7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015d9:	ff 45 fc             	incl   -0x4(%ebp)
  8015dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015df:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015e2:	7c e1                	jl     8015c5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015e4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015eb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015f2:	eb 1f                	jmp    801613 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f7:	8d 50 01             	lea    0x1(%eax),%edx
  8015fa:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015fd:	89 c2                	mov    %eax,%edx
  8015ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801602:	01 c2                	add    %eax,%edx
  801604:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801607:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160a:	01 c8                	add    %ecx,%eax
  80160c:	8a 00                	mov    (%eax),%al
  80160e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801610:	ff 45 f8             	incl   -0x8(%ebp)
  801613:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801616:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801619:	7c d9                	jl     8015f4 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80161b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80161e:	8b 45 10             	mov    0x10(%ebp),%eax
  801621:	01 d0                	add    %edx,%eax
  801623:	c6 00 00             	movb   $0x0,(%eax)
}
  801626:	90                   	nop
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80162c:	8b 45 14             	mov    0x14(%ebp),%eax
  80162f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801635:	8b 45 14             	mov    0x14(%ebp),%eax
  801638:	8b 00                	mov    (%eax),%eax
  80163a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801641:	8b 45 10             	mov    0x10(%ebp),%eax
  801644:	01 d0                	add    %edx,%eax
  801646:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80164c:	eb 0c                	jmp    80165a <strsplit+0x31>
			*string++ = 0;
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8d 50 01             	lea    0x1(%eax),%edx
  801654:	89 55 08             	mov    %edx,0x8(%ebp)
  801657:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	8a 00                	mov    (%eax),%al
  80165f:	84 c0                	test   %al,%al
  801661:	74 18                	je     80167b <strsplit+0x52>
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	8a 00                	mov    (%eax),%al
  801668:	0f be c0             	movsbl %al,%eax
  80166b:	50                   	push   %eax
  80166c:	ff 75 0c             	pushl  0xc(%ebp)
  80166f:	e8 13 fb ff ff       	call   801187 <strchr>
  801674:	83 c4 08             	add    $0x8,%esp
  801677:	85 c0                	test   %eax,%eax
  801679:	75 d3                	jne    80164e <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	8a 00                	mov    (%eax),%al
  801680:	84 c0                	test   %al,%al
  801682:	74 5a                	je     8016de <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801684:	8b 45 14             	mov    0x14(%ebp),%eax
  801687:	8b 00                	mov    (%eax),%eax
  801689:	83 f8 0f             	cmp    $0xf,%eax
  80168c:	75 07                	jne    801695 <strsplit+0x6c>
		{
			return 0;
  80168e:	b8 00 00 00 00       	mov    $0x0,%eax
  801693:	eb 66                	jmp    8016fb <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801695:	8b 45 14             	mov    0x14(%ebp),%eax
  801698:	8b 00                	mov    (%eax),%eax
  80169a:	8d 48 01             	lea    0x1(%eax),%ecx
  80169d:	8b 55 14             	mov    0x14(%ebp),%edx
  8016a0:	89 0a                	mov    %ecx,(%edx)
  8016a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ac:	01 c2                	add    %eax,%edx
  8016ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016b3:	eb 03                	jmp    8016b8 <strsplit+0x8f>
			string++;
  8016b5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bb:	8a 00                	mov    (%eax),%al
  8016bd:	84 c0                	test   %al,%al
  8016bf:	74 8b                	je     80164c <strsplit+0x23>
  8016c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c4:	8a 00                	mov    (%eax),%al
  8016c6:	0f be c0             	movsbl %al,%eax
  8016c9:	50                   	push   %eax
  8016ca:	ff 75 0c             	pushl  0xc(%ebp)
  8016cd:	e8 b5 fa ff ff       	call   801187 <strchr>
  8016d2:	83 c4 08             	add    $0x8,%esp
  8016d5:	85 c0                	test   %eax,%eax
  8016d7:	74 dc                	je     8016b5 <strsplit+0x8c>
			string++;
	}
  8016d9:	e9 6e ff ff ff       	jmp    80164c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016de:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016df:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e2:	8b 00                	mov    (%eax),%eax
  8016e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ee:	01 d0                	add    %edx,%eax
  8016f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016f6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016fb:	c9                   	leave  
  8016fc:	c3                   	ret    

008016fd <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016fd:	55                   	push   %ebp
  8016fe:	89 e5                	mov    %esp,%ebp
  801700:	57                   	push   %edi
  801701:	56                   	push   %esi
  801702:	53                   	push   %ebx
  801703:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801706:	8b 45 08             	mov    0x8(%ebp),%eax
  801709:	8b 55 0c             	mov    0xc(%ebp),%edx
  80170c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80170f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801712:	8b 7d 18             	mov    0x18(%ebp),%edi
  801715:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801718:	cd 30                	int    $0x30
  80171a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80171d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801720:	83 c4 10             	add    $0x10,%esp
  801723:	5b                   	pop    %ebx
  801724:	5e                   	pop    %esi
  801725:	5f                   	pop    %edi
  801726:	5d                   	pop    %ebp
  801727:	c3                   	ret    

00801728 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
  80172b:	83 ec 04             	sub    $0x4,%esp
  80172e:	8b 45 10             	mov    0x10(%ebp),%eax
  801731:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801734:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801738:	8b 45 08             	mov    0x8(%ebp),%eax
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	52                   	push   %edx
  801740:	ff 75 0c             	pushl  0xc(%ebp)
  801743:	50                   	push   %eax
  801744:	6a 00                	push   $0x0
  801746:	e8 b2 ff ff ff       	call   8016fd <syscall>
  80174b:	83 c4 18             	add    $0x18,%esp
}
  80174e:	90                   	nop
  80174f:	c9                   	leave  
  801750:	c3                   	ret    

00801751 <sys_cgetc>:

int
sys_cgetc(void)
{
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 01                	push   $0x1
  801760:	e8 98 ff ff ff       	call   8016fd <syscall>
  801765:	83 c4 18             	add    $0x18,%esp
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	50                   	push   %eax
  801779:	6a 05                	push   $0x5
  80177b:	e8 7d ff ff ff       	call   8016fd <syscall>
  801780:	83 c4 18             	add    $0x18,%esp
}
  801783:	c9                   	leave  
  801784:	c3                   	ret    

00801785 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 02                	push   $0x2
  801794:	e8 64 ff ff ff       	call   8016fd <syscall>
  801799:	83 c4 18             	add    $0x18,%esp
}
  80179c:	c9                   	leave  
  80179d:	c3                   	ret    

0080179e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80179e:	55                   	push   %ebp
  80179f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 03                	push   $0x3
  8017ad:	e8 4b ff ff ff       	call   8016fd <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
}
  8017b5:	c9                   	leave  
  8017b6:	c3                   	ret    

008017b7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017b7:	55                   	push   %ebp
  8017b8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 04                	push   $0x4
  8017c6:	e8 32 ff ff ff       	call   8016fd <syscall>
  8017cb:	83 c4 18             	add    $0x18,%esp
}
  8017ce:	c9                   	leave  
  8017cf:	c3                   	ret    

008017d0 <sys_env_exit>:


void sys_env_exit(void)
{
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 06                	push   $0x6
  8017df:	e8 19 ff ff ff       	call   8016fd <syscall>
  8017e4:	83 c4 18             	add    $0x18,%esp
}
  8017e7:	90                   	nop
  8017e8:	c9                   	leave  
  8017e9:	c3                   	ret    

008017ea <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017ea:	55                   	push   %ebp
  8017eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	52                   	push   %edx
  8017fa:	50                   	push   %eax
  8017fb:	6a 07                	push   $0x7
  8017fd:	e8 fb fe ff ff       	call   8016fd <syscall>
  801802:	83 c4 18             	add    $0x18,%esp
}
  801805:	c9                   	leave  
  801806:	c3                   	ret    

00801807 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801807:	55                   	push   %ebp
  801808:	89 e5                	mov    %esp,%ebp
  80180a:	56                   	push   %esi
  80180b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80180c:	8b 75 18             	mov    0x18(%ebp),%esi
  80180f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801812:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801815:	8b 55 0c             	mov    0xc(%ebp),%edx
  801818:	8b 45 08             	mov    0x8(%ebp),%eax
  80181b:	56                   	push   %esi
  80181c:	53                   	push   %ebx
  80181d:	51                   	push   %ecx
  80181e:	52                   	push   %edx
  80181f:	50                   	push   %eax
  801820:	6a 08                	push   $0x8
  801822:	e8 d6 fe ff ff       	call   8016fd <syscall>
  801827:	83 c4 18             	add    $0x18,%esp
}
  80182a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80182d:	5b                   	pop    %ebx
  80182e:	5e                   	pop    %esi
  80182f:	5d                   	pop    %ebp
  801830:	c3                   	ret    

00801831 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801831:	55                   	push   %ebp
  801832:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801834:	8b 55 0c             	mov    0xc(%ebp),%edx
  801837:	8b 45 08             	mov    0x8(%ebp),%eax
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	52                   	push   %edx
  801841:	50                   	push   %eax
  801842:	6a 09                	push   $0x9
  801844:	e8 b4 fe ff ff       	call   8016fd <syscall>
  801849:	83 c4 18             	add    $0x18,%esp
}
  80184c:	c9                   	leave  
  80184d:	c3                   	ret    

0080184e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	ff 75 0c             	pushl  0xc(%ebp)
  80185a:	ff 75 08             	pushl  0x8(%ebp)
  80185d:	6a 0a                	push   $0xa
  80185f:	e8 99 fe ff ff       	call   8016fd <syscall>
  801864:	83 c4 18             	add    $0x18,%esp
}
  801867:	c9                   	leave  
  801868:	c3                   	ret    

00801869 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 0b                	push   $0xb
  801878:	e8 80 fe ff ff       	call   8016fd <syscall>
  80187d:	83 c4 18             	add    $0x18,%esp
}
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 0c                	push   $0xc
  801891:	e8 67 fe ff ff       	call   8016fd <syscall>
  801896:	83 c4 18             	add    $0x18,%esp
}
  801899:	c9                   	leave  
  80189a:	c3                   	ret    

0080189b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80189b:	55                   	push   %ebp
  80189c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 0d                	push   $0xd
  8018aa:	e8 4e fe ff ff       	call   8016fd <syscall>
  8018af:	83 c4 18             	add    $0x18,%esp
}
  8018b2:	c9                   	leave  
  8018b3:	c3                   	ret    

008018b4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018b4:	55                   	push   %ebp
  8018b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	ff 75 0c             	pushl  0xc(%ebp)
  8018c0:	ff 75 08             	pushl  0x8(%ebp)
  8018c3:	6a 11                	push   $0x11
  8018c5:	e8 33 fe ff ff       	call   8016fd <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
	return;
  8018cd:	90                   	nop
}
  8018ce:	c9                   	leave  
  8018cf:	c3                   	ret    

008018d0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018d0:	55                   	push   %ebp
  8018d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	ff 75 0c             	pushl  0xc(%ebp)
  8018dc:	ff 75 08             	pushl  0x8(%ebp)
  8018df:	6a 12                	push   $0x12
  8018e1:	e8 17 fe ff ff       	call   8016fd <syscall>
  8018e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e9:	90                   	nop
}
  8018ea:	c9                   	leave  
  8018eb:	c3                   	ret    

008018ec <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018ec:	55                   	push   %ebp
  8018ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 0e                	push   $0xe
  8018fb:	e8 fd fd ff ff       	call   8016fd <syscall>
  801900:	83 c4 18             	add    $0x18,%esp
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	ff 75 08             	pushl  0x8(%ebp)
  801913:	6a 0f                	push   $0xf
  801915:	e8 e3 fd ff ff       	call   8016fd <syscall>
  80191a:	83 c4 18             	add    $0x18,%esp
}
  80191d:	c9                   	leave  
  80191e:	c3                   	ret    

0080191f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80191f:	55                   	push   %ebp
  801920:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 10                	push   $0x10
  80192e:	e8 ca fd ff ff       	call   8016fd <syscall>
  801933:	83 c4 18             	add    $0x18,%esp
}
  801936:	90                   	nop
  801937:	c9                   	leave  
  801938:	c3                   	ret    

00801939 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801939:	55                   	push   %ebp
  80193a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	6a 14                	push   $0x14
  801948:	e8 b0 fd ff ff       	call   8016fd <syscall>
  80194d:	83 c4 18             	add    $0x18,%esp
}
  801950:	90                   	nop
  801951:	c9                   	leave  
  801952:	c3                   	ret    

00801953 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 15                	push   $0x15
  801962:	e8 96 fd ff ff       	call   8016fd <syscall>
  801967:	83 c4 18             	add    $0x18,%esp
}
  80196a:	90                   	nop
  80196b:	c9                   	leave  
  80196c:	c3                   	ret    

0080196d <sys_cputc>:


void
sys_cputc(const char c)
{
  80196d:	55                   	push   %ebp
  80196e:	89 e5                	mov    %esp,%ebp
  801970:	83 ec 04             	sub    $0x4,%esp
  801973:	8b 45 08             	mov    0x8(%ebp),%eax
  801976:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801979:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	50                   	push   %eax
  801986:	6a 16                	push   $0x16
  801988:	e8 70 fd ff ff       	call   8016fd <syscall>
  80198d:	83 c4 18             	add    $0x18,%esp
}
  801990:	90                   	nop
  801991:	c9                   	leave  
  801992:	c3                   	ret    

00801993 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801993:	55                   	push   %ebp
  801994:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 17                	push   $0x17
  8019a2:	e8 56 fd ff ff       	call   8016fd <syscall>
  8019a7:	83 c4 18             	add    $0x18,%esp
}
  8019aa:	90                   	nop
  8019ab:	c9                   	leave  
  8019ac:	c3                   	ret    

008019ad <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019ad:	55                   	push   %ebp
  8019ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	ff 75 0c             	pushl  0xc(%ebp)
  8019bc:	50                   	push   %eax
  8019bd:	6a 18                	push   $0x18
  8019bf:	e8 39 fd ff ff       	call   8016fd <syscall>
  8019c4:	83 c4 18             	add    $0x18,%esp
}
  8019c7:	c9                   	leave  
  8019c8:	c3                   	ret    

008019c9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019c9:	55                   	push   %ebp
  8019ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	52                   	push   %edx
  8019d9:	50                   	push   %eax
  8019da:	6a 1b                	push   $0x1b
  8019dc:	e8 1c fd ff ff       	call   8016fd <syscall>
  8019e1:	83 c4 18             	add    $0x18,%esp
}
  8019e4:	c9                   	leave  
  8019e5:	c3                   	ret    

008019e6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019e6:	55                   	push   %ebp
  8019e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	52                   	push   %edx
  8019f6:	50                   	push   %eax
  8019f7:	6a 19                	push   $0x19
  8019f9:	e8 ff fc ff ff       	call   8016fd <syscall>
  8019fe:	83 c4 18             	add    $0x18,%esp
}
  801a01:	90                   	nop
  801a02:	c9                   	leave  
  801a03:	c3                   	ret    

00801a04 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a04:	55                   	push   %ebp
  801a05:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a07:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	52                   	push   %edx
  801a14:	50                   	push   %eax
  801a15:	6a 1a                	push   $0x1a
  801a17:	e8 e1 fc ff ff       	call   8016fd <syscall>
  801a1c:	83 c4 18             	add    $0x18,%esp
}
  801a1f:	90                   	nop
  801a20:	c9                   	leave  
  801a21:	c3                   	ret    

00801a22 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a22:	55                   	push   %ebp
  801a23:	89 e5                	mov    %esp,%ebp
  801a25:	83 ec 04             	sub    $0x4,%esp
  801a28:	8b 45 10             	mov    0x10(%ebp),%eax
  801a2b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a2e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a31:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a35:	8b 45 08             	mov    0x8(%ebp),%eax
  801a38:	6a 00                	push   $0x0
  801a3a:	51                   	push   %ecx
  801a3b:	52                   	push   %edx
  801a3c:	ff 75 0c             	pushl  0xc(%ebp)
  801a3f:	50                   	push   %eax
  801a40:	6a 1c                	push   $0x1c
  801a42:	e8 b6 fc ff ff       	call   8016fd <syscall>
  801a47:	83 c4 18             	add    $0x18,%esp
}
  801a4a:	c9                   	leave  
  801a4b:	c3                   	ret    

00801a4c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a4c:	55                   	push   %ebp
  801a4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a52:	8b 45 08             	mov    0x8(%ebp),%eax
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	52                   	push   %edx
  801a5c:	50                   	push   %eax
  801a5d:	6a 1d                	push   $0x1d
  801a5f:	e8 99 fc ff ff       	call   8016fd <syscall>
  801a64:	83 c4 18             	add    $0x18,%esp
}
  801a67:	c9                   	leave  
  801a68:	c3                   	ret    

00801a69 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a69:	55                   	push   %ebp
  801a6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a6c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a72:	8b 45 08             	mov    0x8(%ebp),%eax
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	51                   	push   %ecx
  801a7a:	52                   	push   %edx
  801a7b:	50                   	push   %eax
  801a7c:	6a 1e                	push   $0x1e
  801a7e:	e8 7a fc ff ff       	call   8016fd <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
}
  801a86:	c9                   	leave  
  801a87:	c3                   	ret    

00801a88 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	52                   	push   %edx
  801a98:	50                   	push   %eax
  801a99:	6a 1f                	push   $0x1f
  801a9b:	e8 5d fc ff ff       	call   8016fd <syscall>
  801aa0:	83 c4 18             	add    $0x18,%esp
}
  801aa3:	c9                   	leave  
  801aa4:	c3                   	ret    

00801aa5 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aa5:	55                   	push   %ebp
  801aa6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 20                	push   $0x20
  801ab4:	e8 44 fc ff ff       	call   8016fd <syscall>
  801ab9:	83 c4 18             	add    $0x18,%esp
}
  801abc:	c9                   	leave  
  801abd:	c3                   	ret    

00801abe <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801abe:	55                   	push   %ebp
  801abf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	ff 75 10             	pushl  0x10(%ebp)
  801acb:	ff 75 0c             	pushl  0xc(%ebp)
  801ace:	50                   	push   %eax
  801acf:	6a 21                	push   $0x21
  801ad1:	e8 27 fc ff ff       	call   8016fd <syscall>
  801ad6:	83 c4 18             	add    $0x18,%esp
}
  801ad9:	c9                   	leave  
  801ada:	c3                   	ret    

00801adb <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801adb:	55                   	push   %ebp
  801adc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ade:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	50                   	push   %eax
  801aea:	6a 22                	push   $0x22
  801aec:	e8 0c fc ff ff       	call   8016fd <syscall>
  801af1:	83 c4 18             	add    $0x18,%esp
}
  801af4:	90                   	nop
  801af5:	c9                   	leave  
  801af6:	c3                   	ret    

00801af7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801af7:	55                   	push   %ebp
  801af8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801afa:	8b 45 08             	mov    0x8(%ebp),%eax
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	50                   	push   %eax
  801b06:	6a 23                	push   $0x23
  801b08:	e8 f0 fb ff ff       	call   8016fd <syscall>
  801b0d:	83 c4 18             	add    $0x18,%esp
}
  801b10:	90                   	nop
  801b11:	c9                   	leave  
  801b12:	c3                   	ret    

00801b13 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b13:	55                   	push   %ebp
  801b14:	89 e5                	mov    %esp,%ebp
  801b16:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b19:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b1c:	8d 50 04             	lea    0x4(%eax),%edx
  801b1f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	52                   	push   %edx
  801b29:	50                   	push   %eax
  801b2a:	6a 24                	push   $0x24
  801b2c:	e8 cc fb ff ff       	call   8016fd <syscall>
  801b31:	83 c4 18             	add    $0x18,%esp
	return result;
  801b34:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b37:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b3a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b3d:	89 01                	mov    %eax,(%ecx)
  801b3f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b42:	8b 45 08             	mov    0x8(%ebp),%eax
  801b45:	c9                   	leave  
  801b46:	c2 04 00             	ret    $0x4

00801b49 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b49:	55                   	push   %ebp
  801b4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	ff 75 10             	pushl  0x10(%ebp)
  801b53:	ff 75 0c             	pushl  0xc(%ebp)
  801b56:	ff 75 08             	pushl  0x8(%ebp)
  801b59:	6a 13                	push   $0x13
  801b5b:	e8 9d fb ff ff       	call   8016fd <syscall>
  801b60:	83 c4 18             	add    $0x18,%esp
	return ;
  801b63:	90                   	nop
}
  801b64:	c9                   	leave  
  801b65:	c3                   	ret    

00801b66 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b66:	55                   	push   %ebp
  801b67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 25                	push   $0x25
  801b75:	e8 83 fb ff ff       	call   8016fd <syscall>
  801b7a:	83 c4 18             	add    $0x18,%esp
}
  801b7d:	c9                   	leave  
  801b7e:	c3                   	ret    

00801b7f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b7f:	55                   	push   %ebp
  801b80:	89 e5                	mov    %esp,%ebp
  801b82:	83 ec 04             	sub    $0x4,%esp
  801b85:	8b 45 08             	mov    0x8(%ebp),%eax
  801b88:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b8b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	50                   	push   %eax
  801b98:	6a 26                	push   $0x26
  801b9a:	e8 5e fb ff ff       	call   8016fd <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba2:	90                   	nop
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <rsttst>:
void rsttst()
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 28                	push   $0x28
  801bb4:	e8 44 fb ff ff       	call   8016fd <syscall>
  801bb9:	83 c4 18             	add    $0x18,%esp
	return ;
  801bbc:	90                   	nop
}
  801bbd:	c9                   	leave  
  801bbe:	c3                   	ret    

00801bbf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bbf:	55                   	push   %ebp
  801bc0:	89 e5                	mov    %esp,%ebp
  801bc2:	83 ec 04             	sub    $0x4,%esp
  801bc5:	8b 45 14             	mov    0x14(%ebp),%eax
  801bc8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bcb:	8b 55 18             	mov    0x18(%ebp),%edx
  801bce:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bd2:	52                   	push   %edx
  801bd3:	50                   	push   %eax
  801bd4:	ff 75 10             	pushl  0x10(%ebp)
  801bd7:	ff 75 0c             	pushl  0xc(%ebp)
  801bda:	ff 75 08             	pushl  0x8(%ebp)
  801bdd:	6a 27                	push   $0x27
  801bdf:	e8 19 fb ff ff       	call   8016fd <syscall>
  801be4:	83 c4 18             	add    $0x18,%esp
	return ;
  801be7:	90                   	nop
}
  801be8:	c9                   	leave  
  801be9:	c3                   	ret    

00801bea <chktst>:
void chktst(uint32 n)
{
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	ff 75 08             	pushl  0x8(%ebp)
  801bf8:	6a 29                	push   $0x29
  801bfa:	e8 fe fa ff ff       	call   8016fd <syscall>
  801bff:	83 c4 18             	add    $0x18,%esp
	return ;
  801c02:	90                   	nop
}
  801c03:	c9                   	leave  
  801c04:	c3                   	ret    

00801c05 <inctst>:

void inctst()
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 2a                	push   $0x2a
  801c14:	e8 e4 fa ff ff       	call   8016fd <syscall>
  801c19:	83 c4 18             	add    $0x18,%esp
	return ;
  801c1c:	90                   	nop
}
  801c1d:	c9                   	leave  
  801c1e:	c3                   	ret    

00801c1f <gettst>:
uint32 gettst()
{
  801c1f:	55                   	push   %ebp
  801c20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c22:	6a 00                	push   $0x0
  801c24:	6a 00                	push   $0x0
  801c26:	6a 00                	push   $0x0
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 2b                	push   $0x2b
  801c2e:	e8 ca fa ff ff       	call   8016fd <syscall>
  801c33:	83 c4 18             	add    $0x18,%esp
}
  801c36:	c9                   	leave  
  801c37:	c3                   	ret    

00801c38 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c38:	55                   	push   %ebp
  801c39:	89 e5                	mov    %esp,%ebp
  801c3b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 2c                	push   $0x2c
  801c4a:	e8 ae fa ff ff       	call   8016fd <syscall>
  801c4f:	83 c4 18             	add    $0x18,%esp
  801c52:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c55:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c59:	75 07                	jne    801c62 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c5b:	b8 01 00 00 00       	mov    $0x1,%eax
  801c60:	eb 05                	jmp    801c67 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c62:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c67:	c9                   	leave  
  801c68:	c3                   	ret    

00801c69 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c69:	55                   	push   %ebp
  801c6a:	89 e5                	mov    %esp,%ebp
  801c6c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 2c                	push   $0x2c
  801c7b:	e8 7d fa ff ff       	call   8016fd <syscall>
  801c80:	83 c4 18             	add    $0x18,%esp
  801c83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c86:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c8a:	75 07                	jne    801c93 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c8c:	b8 01 00 00 00       	mov    $0x1,%eax
  801c91:	eb 05                	jmp    801c98 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c93:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c98:	c9                   	leave  
  801c99:	c3                   	ret    

00801c9a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c9a:	55                   	push   %ebp
  801c9b:	89 e5                	mov    %esp,%ebp
  801c9d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 2c                	push   $0x2c
  801cac:	e8 4c fa ff ff       	call   8016fd <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
  801cb4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cb7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cbb:	75 07                	jne    801cc4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cbd:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc2:	eb 05                	jmp    801cc9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cc4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cc9:	c9                   	leave  
  801cca:	c3                   	ret    

00801ccb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ccb:	55                   	push   %ebp
  801ccc:	89 e5                	mov    %esp,%ebp
  801cce:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 2c                	push   $0x2c
  801cdd:	e8 1b fa ff ff       	call   8016fd <syscall>
  801ce2:	83 c4 18             	add    $0x18,%esp
  801ce5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ce8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cec:	75 07                	jne    801cf5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cee:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf3:	eb 05                	jmp    801cfa <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cf5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cfa:	c9                   	leave  
  801cfb:	c3                   	ret    

00801cfc <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cfc:	55                   	push   %ebp
  801cfd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	ff 75 08             	pushl  0x8(%ebp)
  801d0a:	6a 2d                	push   $0x2d
  801d0c:	e8 ec f9 ff ff       	call   8016fd <syscall>
  801d11:	83 c4 18             	add    $0x18,%esp
	return ;
  801d14:	90                   	nop
}
  801d15:	c9                   	leave  
  801d16:	c3                   	ret    
  801d17:	90                   	nop

00801d18 <__udivdi3>:
  801d18:	55                   	push   %ebp
  801d19:	57                   	push   %edi
  801d1a:	56                   	push   %esi
  801d1b:	53                   	push   %ebx
  801d1c:	83 ec 1c             	sub    $0x1c,%esp
  801d1f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d23:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d27:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d2b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d2f:	89 ca                	mov    %ecx,%edx
  801d31:	89 f8                	mov    %edi,%eax
  801d33:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d37:	85 f6                	test   %esi,%esi
  801d39:	75 2d                	jne    801d68 <__udivdi3+0x50>
  801d3b:	39 cf                	cmp    %ecx,%edi
  801d3d:	77 65                	ja     801da4 <__udivdi3+0x8c>
  801d3f:	89 fd                	mov    %edi,%ebp
  801d41:	85 ff                	test   %edi,%edi
  801d43:	75 0b                	jne    801d50 <__udivdi3+0x38>
  801d45:	b8 01 00 00 00       	mov    $0x1,%eax
  801d4a:	31 d2                	xor    %edx,%edx
  801d4c:	f7 f7                	div    %edi
  801d4e:	89 c5                	mov    %eax,%ebp
  801d50:	31 d2                	xor    %edx,%edx
  801d52:	89 c8                	mov    %ecx,%eax
  801d54:	f7 f5                	div    %ebp
  801d56:	89 c1                	mov    %eax,%ecx
  801d58:	89 d8                	mov    %ebx,%eax
  801d5a:	f7 f5                	div    %ebp
  801d5c:	89 cf                	mov    %ecx,%edi
  801d5e:	89 fa                	mov    %edi,%edx
  801d60:	83 c4 1c             	add    $0x1c,%esp
  801d63:	5b                   	pop    %ebx
  801d64:	5e                   	pop    %esi
  801d65:	5f                   	pop    %edi
  801d66:	5d                   	pop    %ebp
  801d67:	c3                   	ret    
  801d68:	39 ce                	cmp    %ecx,%esi
  801d6a:	77 28                	ja     801d94 <__udivdi3+0x7c>
  801d6c:	0f bd fe             	bsr    %esi,%edi
  801d6f:	83 f7 1f             	xor    $0x1f,%edi
  801d72:	75 40                	jne    801db4 <__udivdi3+0x9c>
  801d74:	39 ce                	cmp    %ecx,%esi
  801d76:	72 0a                	jb     801d82 <__udivdi3+0x6a>
  801d78:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d7c:	0f 87 9e 00 00 00    	ja     801e20 <__udivdi3+0x108>
  801d82:	b8 01 00 00 00       	mov    $0x1,%eax
  801d87:	89 fa                	mov    %edi,%edx
  801d89:	83 c4 1c             	add    $0x1c,%esp
  801d8c:	5b                   	pop    %ebx
  801d8d:	5e                   	pop    %esi
  801d8e:	5f                   	pop    %edi
  801d8f:	5d                   	pop    %ebp
  801d90:	c3                   	ret    
  801d91:	8d 76 00             	lea    0x0(%esi),%esi
  801d94:	31 ff                	xor    %edi,%edi
  801d96:	31 c0                	xor    %eax,%eax
  801d98:	89 fa                	mov    %edi,%edx
  801d9a:	83 c4 1c             	add    $0x1c,%esp
  801d9d:	5b                   	pop    %ebx
  801d9e:	5e                   	pop    %esi
  801d9f:	5f                   	pop    %edi
  801da0:	5d                   	pop    %ebp
  801da1:	c3                   	ret    
  801da2:	66 90                	xchg   %ax,%ax
  801da4:	89 d8                	mov    %ebx,%eax
  801da6:	f7 f7                	div    %edi
  801da8:	31 ff                	xor    %edi,%edi
  801daa:	89 fa                	mov    %edi,%edx
  801dac:	83 c4 1c             	add    $0x1c,%esp
  801daf:	5b                   	pop    %ebx
  801db0:	5e                   	pop    %esi
  801db1:	5f                   	pop    %edi
  801db2:	5d                   	pop    %ebp
  801db3:	c3                   	ret    
  801db4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801db9:	89 eb                	mov    %ebp,%ebx
  801dbb:	29 fb                	sub    %edi,%ebx
  801dbd:	89 f9                	mov    %edi,%ecx
  801dbf:	d3 e6                	shl    %cl,%esi
  801dc1:	89 c5                	mov    %eax,%ebp
  801dc3:	88 d9                	mov    %bl,%cl
  801dc5:	d3 ed                	shr    %cl,%ebp
  801dc7:	89 e9                	mov    %ebp,%ecx
  801dc9:	09 f1                	or     %esi,%ecx
  801dcb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801dcf:	89 f9                	mov    %edi,%ecx
  801dd1:	d3 e0                	shl    %cl,%eax
  801dd3:	89 c5                	mov    %eax,%ebp
  801dd5:	89 d6                	mov    %edx,%esi
  801dd7:	88 d9                	mov    %bl,%cl
  801dd9:	d3 ee                	shr    %cl,%esi
  801ddb:	89 f9                	mov    %edi,%ecx
  801ddd:	d3 e2                	shl    %cl,%edx
  801ddf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801de3:	88 d9                	mov    %bl,%cl
  801de5:	d3 e8                	shr    %cl,%eax
  801de7:	09 c2                	or     %eax,%edx
  801de9:	89 d0                	mov    %edx,%eax
  801deb:	89 f2                	mov    %esi,%edx
  801ded:	f7 74 24 0c          	divl   0xc(%esp)
  801df1:	89 d6                	mov    %edx,%esi
  801df3:	89 c3                	mov    %eax,%ebx
  801df5:	f7 e5                	mul    %ebp
  801df7:	39 d6                	cmp    %edx,%esi
  801df9:	72 19                	jb     801e14 <__udivdi3+0xfc>
  801dfb:	74 0b                	je     801e08 <__udivdi3+0xf0>
  801dfd:	89 d8                	mov    %ebx,%eax
  801dff:	31 ff                	xor    %edi,%edi
  801e01:	e9 58 ff ff ff       	jmp    801d5e <__udivdi3+0x46>
  801e06:	66 90                	xchg   %ax,%ax
  801e08:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e0c:	89 f9                	mov    %edi,%ecx
  801e0e:	d3 e2                	shl    %cl,%edx
  801e10:	39 c2                	cmp    %eax,%edx
  801e12:	73 e9                	jae    801dfd <__udivdi3+0xe5>
  801e14:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e17:	31 ff                	xor    %edi,%edi
  801e19:	e9 40 ff ff ff       	jmp    801d5e <__udivdi3+0x46>
  801e1e:	66 90                	xchg   %ax,%ax
  801e20:	31 c0                	xor    %eax,%eax
  801e22:	e9 37 ff ff ff       	jmp    801d5e <__udivdi3+0x46>
  801e27:	90                   	nop

00801e28 <__umoddi3>:
  801e28:	55                   	push   %ebp
  801e29:	57                   	push   %edi
  801e2a:	56                   	push   %esi
  801e2b:	53                   	push   %ebx
  801e2c:	83 ec 1c             	sub    $0x1c,%esp
  801e2f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e33:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e3b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e3f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e43:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e47:	89 f3                	mov    %esi,%ebx
  801e49:	89 fa                	mov    %edi,%edx
  801e4b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e4f:	89 34 24             	mov    %esi,(%esp)
  801e52:	85 c0                	test   %eax,%eax
  801e54:	75 1a                	jne    801e70 <__umoddi3+0x48>
  801e56:	39 f7                	cmp    %esi,%edi
  801e58:	0f 86 a2 00 00 00    	jbe    801f00 <__umoddi3+0xd8>
  801e5e:	89 c8                	mov    %ecx,%eax
  801e60:	89 f2                	mov    %esi,%edx
  801e62:	f7 f7                	div    %edi
  801e64:	89 d0                	mov    %edx,%eax
  801e66:	31 d2                	xor    %edx,%edx
  801e68:	83 c4 1c             	add    $0x1c,%esp
  801e6b:	5b                   	pop    %ebx
  801e6c:	5e                   	pop    %esi
  801e6d:	5f                   	pop    %edi
  801e6e:	5d                   	pop    %ebp
  801e6f:	c3                   	ret    
  801e70:	39 f0                	cmp    %esi,%eax
  801e72:	0f 87 ac 00 00 00    	ja     801f24 <__umoddi3+0xfc>
  801e78:	0f bd e8             	bsr    %eax,%ebp
  801e7b:	83 f5 1f             	xor    $0x1f,%ebp
  801e7e:	0f 84 ac 00 00 00    	je     801f30 <__umoddi3+0x108>
  801e84:	bf 20 00 00 00       	mov    $0x20,%edi
  801e89:	29 ef                	sub    %ebp,%edi
  801e8b:	89 fe                	mov    %edi,%esi
  801e8d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e91:	89 e9                	mov    %ebp,%ecx
  801e93:	d3 e0                	shl    %cl,%eax
  801e95:	89 d7                	mov    %edx,%edi
  801e97:	89 f1                	mov    %esi,%ecx
  801e99:	d3 ef                	shr    %cl,%edi
  801e9b:	09 c7                	or     %eax,%edi
  801e9d:	89 e9                	mov    %ebp,%ecx
  801e9f:	d3 e2                	shl    %cl,%edx
  801ea1:	89 14 24             	mov    %edx,(%esp)
  801ea4:	89 d8                	mov    %ebx,%eax
  801ea6:	d3 e0                	shl    %cl,%eax
  801ea8:	89 c2                	mov    %eax,%edx
  801eaa:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eae:	d3 e0                	shl    %cl,%eax
  801eb0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801eb4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eb8:	89 f1                	mov    %esi,%ecx
  801eba:	d3 e8                	shr    %cl,%eax
  801ebc:	09 d0                	or     %edx,%eax
  801ebe:	d3 eb                	shr    %cl,%ebx
  801ec0:	89 da                	mov    %ebx,%edx
  801ec2:	f7 f7                	div    %edi
  801ec4:	89 d3                	mov    %edx,%ebx
  801ec6:	f7 24 24             	mull   (%esp)
  801ec9:	89 c6                	mov    %eax,%esi
  801ecb:	89 d1                	mov    %edx,%ecx
  801ecd:	39 d3                	cmp    %edx,%ebx
  801ecf:	0f 82 87 00 00 00    	jb     801f5c <__umoddi3+0x134>
  801ed5:	0f 84 91 00 00 00    	je     801f6c <__umoddi3+0x144>
  801edb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801edf:	29 f2                	sub    %esi,%edx
  801ee1:	19 cb                	sbb    %ecx,%ebx
  801ee3:	89 d8                	mov    %ebx,%eax
  801ee5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ee9:	d3 e0                	shl    %cl,%eax
  801eeb:	89 e9                	mov    %ebp,%ecx
  801eed:	d3 ea                	shr    %cl,%edx
  801eef:	09 d0                	or     %edx,%eax
  801ef1:	89 e9                	mov    %ebp,%ecx
  801ef3:	d3 eb                	shr    %cl,%ebx
  801ef5:	89 da                	mov    %ebx,%edx
  801ef7:	83 c4 1c             	add    $0x1c,%esp
  801efa:	5b                   	pop    %ebx
  801efb:	5e                   	pop    %esi
  801efc:	5f                   	pop    %edi
  801efd:	5d                   	pop    %ebp
  801efe:	c3                   	ret    
  801eff:	90                   	nop
  801f00:	89 fd                	mov    %edi,%ebp
  801f02:	85 ff                	test   %edi,%edi
  801f04:	75 0b                	jne    801f11 <__umoddi3+0xe9>
  801f06:	b8 01 00 00 00       	mov    $0x1,%eax
  801f0b:	31 d2                	xor    %edx,%edx
  801f0d:	f7 f7                	div    %edi
  801f0f:	89 c5                	mov    %eax,%ebp
  801f11:	89 f0                	mov    %esi,%eax
  801f13:	31 d2                	xor    %edx,%edx
  801f15:	f7 f5                	div    %ebp
  801f17:	89 c8                	mov    %ecx,%eax
  801f19:	f7 f5                	div    %ebp
  801f1b:	89 d0                	mov    %edx,%eax
  801f1d:	e9 44 ff ff ff       	jmp    801e66 <__umoddi3+0x3e>
  801f22:	66 90                	xchg   %ax,%ax
  801f24:	89 c8                	mov    %ecx,%eax
  801f26:	89 f2                	mov    %esi,%edx
  801f28:	83 c4 1c             	add    $0x1c,%esp
  801f2b:	5b                   	pop    %ebx
  801f2c:	5e                   	pop    %esi
  801f2d:	5f                   	pop    %edi
  801f2e:	5d                   	pop    %ebp
  801f2f:	c3                   	ret    
  801f30:	3b 04 24             	cmp    (%esp),%eax
  801f33:	72 06                	jb     801f3b <__umoddi3+0x113>
  801f35:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f39:	77 0f                	ja     801f4a <__umoddi3+0x122>
  801f3b:	89 f2                	mov    %esi,%edx
  801f3d:	29 f9                	sub    %edi,%ecx
  801f3f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f43:	89 14 24             	mov    %edx,(%esp)
  801f46:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f4a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f4e:	8b 14 24             	mov    (%esp),%edx
  801f51:	83 c4 1c             	add    $0x1c,%esp
  801f54:	5b                   	pop    %ebx
  801f55:	5e                   	pop    %esi
  801f56:	5f                   	pop    %edi
  801f57:	5d                   	pop    %ebp
  801f58:	c3                   	ret    
  801f59:	8d 76 00             	lea    0x0(%esi),%esi
  801f5c:	2b 04 24             	sub    (%esp),%eax
  801f5f:	19 fa                	sbb    %edi,%edx
  801f61:	89 d1                	mov    %edx,%ecx
  801f63:	89 c6                	mov    %eax,%esi
  801f65:	e9 71 ff ff ff       	jmp    801edb <__umoddi3+0xb3>
  801f6a:	66 90                	xchg   %ax,%ax
  801f6c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f70:	72 ea                	jb     801f5c <__umoddi3+0x134>
  801f72:	89 d9                	mov    %ebx,%ecx
  801f74:	e9 62 ff ff ff       	jmp    801edb <__umoddi3+0xb3>
