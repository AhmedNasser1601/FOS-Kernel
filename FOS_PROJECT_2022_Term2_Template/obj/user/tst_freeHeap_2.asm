
obj/user/tst_freeHeap_2:     file format elf32-i386


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
  800031:	e8 a4 05 00 00       	call   8005da <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

char z[5*1024*1024] ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec cc 00 00 00    	sub    $0xcc,%esp
	
	

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x0)  		panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800044:	a1 20 30 80 00       	mov    0x803020,%eax
  800049:	8b 40 7c             	mov    0x7c(%eax),%eax
  80004c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  80004f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800052:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800057:	85 c0                	test   %eax,%eax
  800059:	74 14                	je     80006f <_main+0x37>
  80005b:	83 ec 04             	sub    $0x4,%esp
  80005e:	68 c0 21 80 00       	push   $0x8021c0
  800063:	6a 13                	push   $0x13
  800065:	68 09 22 80 00       	push   $0x802209
  80006a:	e8 7a 06 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x800000)  	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  80006f:	a1 20 30 80 00       	mov    0x803020,%eax
  800074:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  80007a:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80007d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800080:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800085:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80008a:	74 14                	je     8000a0 <_main+0x68>
  80008c:	83 ec 04             	sub    $0x4,%esp
  80008f:	68 c0 21 80 00       	push   $0x8021c0
  800094:	6a 14                	push   $0x14
  800096:	68 09 22 80 00       	push   $0x802209
  80009b:	e8 49 06 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a5:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  8000ab:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8000ae:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000b1:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b6:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000bb:	74 14                	je     8000d1 <_main+0x99>
  8000bd:	83 ec 04             	sub    $0x4,%esp
  8000c0:	68 c0 21 80 00       	push   $0x8021c0
  8000c5:	6a 15                	push   $0x15
  8000c7:	68 09 22 80 00       	push   $0x802209
  8000cc:	e8 18 06 00 00       	call   8006e9 <_panic>
		if( myEnv->__ptr_tws[3].empty !=  1)  											panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d6:	8a 80 a4 00 00 00    	mov    0xa4(%eax),%al
  8000dc:	3c 01                	cmp    $0x1,%al
  8000de:	74 14                	je     8000f4 <_main+0xbc>
  8000e0:	83 ec 04             	sub    $0x4,%esp
  8000e3:	68 c0 21 80 00       	push   $0x8021c0
  8000e8:	6a 16                	push   $0x16
  8000ea:	68 09 22 80 00       	push   $0x802209
  8000ef:	e8 f5 05 00 00       	call   8006e9 <_panic>

		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f9:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000ff:	8b 00                	mov    (%eax),%eax
  800101:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800104:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800107:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80010c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800111:	74 14                	je     800127 <_main+0xef>
  800113:	83 ec 04             	sub    $0x4,%esp
  800116:	68 20 22 80 00       	push   $0x802220
  80011b:	6a 18                	push   $0x18
  80011d:	68 09 22 80 00       	push   $0x802209
  800122:	e8 c2 05 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800127:	a1 20 30 80 00       	mov    0x803020,%eax
  80012c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800132:	83 c0 0c             	add    $0xc,%eax
  800135:	8b 00                	mov    (%eax),%eax
  800137:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80013a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80013d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800142:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800147:	74 14                	je     80015d <_main+0x125>
  800149:	83 ec 04             	sub    $0x4,%esp
  80014c:	68 20 22 80 00       	push   $0x802220
  800151:	6a 19                	push   $0x19
  800153:	68 09 22 80 00       	push   $0x802209
  800158:	e8 8c 05 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80015d:	a1 20 30 80 00       	mov    0x803020,%eax
  800162:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800168:	83 c0 18             	add    $0x18,%eax
  80016b:	8b 00                	mov    (%eax),%eax
  80016d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800170:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800173:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800178:	3d 00 20 20 00       	cmp    $0x202000,%eax
  80017d:	74 14                	je     800193 <_main+0x15b>
  80017f:	83 ec 04             	sub    $0x4,%esp
  800182:	68 20 22 80 00       	push   $0x802220
  800187:	6a 1a                	push   $0x1a
  800189:	68 09 22 80 00       	push   $0x802209
  80018e:	e8 56 05 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800193:	a1 20 30 80 00       	mov    0x803020,%eax
  800198:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80019e:	83 c0 24             	add    $0x24,%eax
  8001a1:	8b 00                	mov    (%eax),%eax
  8001a3:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001a6:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001a9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ae:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8001b3:	74 14                	je     8001c9 <_main+0x191>
  8001b5:	83 ec 04             	sub    $0x4,%esp
  8001b8:	68 20 22 80 00       	push   $0x802220
  8001bd:	6a 1b                	push   $0x1b
  8001bf:	68 09 22 80 00       	push   $0x802209
  8001c4:	e8 20 05 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ce:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001d4:	83 c0 30             	add    $0x30,%eax
  8001d7:	8b 00                	mov    (%eax),%eax
  8001d9:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001dc:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001df:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001e4:	3d 00 40 20 00       	cmp    $0x204000,%eax
  8001e9:	74 14                	je     8001ff <_main+0x1c7>
  8001eb:	83 ec 04             	sub    $0x4,%esp
  8001ee:	68 20 22 80 00       	push   $0x802220
  8001f3:	6a 1c                	push   $0x1c
  8001f5:	68 09 22 80 00       	push   $0x802209
  8001fa:	e8 ea 04 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001ff:	a1 20 30 80 00       	mov    0x803020,%eax
  800204:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80020a:	83 c0 3c             	add    $0x3c,%eax
  80020d:	8b 00                	mov    (%eax),%eax
  80020f:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800212:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800215:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80021a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80021f:	74 14                	je     800235 <_main+0x1fd>
  800221:	83 ec 04             	sub    $0x4,%esp
  800224:	68 20 22 80 00       	push   $0x802220
  800229:	6a 1d                	push   $0x1d
  80022b:	68 09 22 80 00       	push   $0x802209
  800230:	e8 b4 04 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800235:	a1 20 30 80 00       	mov    0x803020,%eax
  80023a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800240:	83 c0 48             	add    $0x48,%eax
  800243:	8b 00                	mov    (%eax),%eax
  800245:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800248:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80024b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800250:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800255:	74 14                	je     80026b <_main+0x233>
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	68 20 22 80 00       	push   $0x802220
  80025f:	6a 1e                	push   $0x1e
  800261:	68 09 22 80 00       	push   $0x802209
  800266:	e8 7e 04 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80026b:	a1 20 30 80 00       	mov    0x803020,%eax
  800270:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800276:	83 c0 54             	add    $0x54,%eax
  800279:	8b 00                	mov    (%eax),%eax
  80027b:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80027e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800281:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800286:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80028b:	74 14                	je     8002a1 <_main+0x269>
  80028d:	83 ec 04             	sub    $0x4,%esp
  800290:	68 20 22 80 00       	push   $0x802220
  800295:	6a 1f                	push   $0x1f
  800297:	68 09 22 80 00       	push   $0x802209
  80029c:	e8 48 04 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a6:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002ac:	83 c0 60             	add    $0x60,%eax
  8002af:	8b 00                	mov    (%eax),%eax
  8002b1:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8002b4:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8002b7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002bc:	3d 00 20 80 00       	cmp    $0x802000,%eax
  8002c1:	74 14                	je     8002d7 <_main+0x29f>
  8002c3:	83 ec 04             	sub    $0x4,%esp
  8002c6:	68 20 22 80 00       	push   $0x802220
  8002cb:	6a 20                	push   $0x20
  8002cd:	68 09 22 80 00       	push   $0x802209
  8002d2:	e8 12 04 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002dc:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002e2:	83 c0 6c             	add    $0x6c,%eax
  8002e5:	8b 00                	mov    (%eax),%eax
  8002e7:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8002ea:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8002ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002f2:	3d 00 30 80 00       	cmp    $0x803000,%eax
  8002f7:	74 14                	je     80030d <_main+0x2d5>
  8002f9:	83 ec 04             	sub    $0x4,%esp
  8002fc:	68 20 22 80 00       	push   $0x802220
  800301:	6a 21                	push   $0x21
  800303:	68 09 22 80 00       	push   $0x802209
  800308:	e8 dc 03 00 00       	call   8006e9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80030d:	a1 20 30 80 00       	mov    0x803020,%eax
  800312:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800318:	83 c0 78             	add    $0x78,%eax
  80031b:	8b 00                	mov    (%eax),%eax
  80031d:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800320:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800323:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800328:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80032d:	74 14                	je     800343 <_main+0x30b>
  80032f:	83 ec 04             	sub    $0x4,%esp
  800332:	68 20 22 80 00       	push   $0x802220
  800337:	6a 22                	push   $0x22
  800339:	68 09 22 80 00       	push   $0x802209
  80033e:	e8 a6 03 00 00       	call   8006e9 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  800343:	a1 20 30 80 00       	mov    0x803020,%eax
  800348:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  80034e:	85 c0                	test   %eax,%eax
  800350:	74 14                	je     800366 <_main+0x32e>
  800352:	83 ec 04             	sub    $0x4,%esp
  800355:	68 68 22 80 00       	push   $0x802268
  80035a:	6a 23                	push   $0x23
  80035c:	68 09 22 80 00       	push   $0x802209
  800361:	e8 83 03 00 00       	call   8006e9 <_panic>
	}


	int kilo = 1024;
  800366:	c7 45 9c 00 04 00 00 	movl   $0x400,-0x64(%ebp)
	int Mega = 1024*1024;
  80036d:	c7 45 98 00 00 10 00 	movl   $0x100000,-0x68(%ebp)

	/// testing freeHeap()
	{

		uint32 size = 13*Mega;
  800374:	8b 55 98             	mov    -0x68(%ebp),%edx
  800377:	89 d0                	mov    %edx,%eax
  800379:	01 c0                	add    %eax,%eax
  80037b:	01 d0                	add    %edx,%eax
  80037d:	c1 e0 02             	shl    $0x2,%eax
  800380:	01 d0                	add    %edx,%eax
  800382:	89 45 94             	mov    %eax,-0x6c(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  800385:	83 ec 0c             	sub    $0xc,%esp
  800388:	ff 75 94             	pushl  -0x6c(%ebp)
  80038b:	e8 97 13 00 00       	call   801727 <malloc>
  800390:	83 c4 10             	add    $0x10,%esp
  800393:	89 45 90             	mov    %eax,-0x70(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800396:	83 ec 0c             	sub    $0xc,%esp
  800399:	ff 75 94             	pushl  -0x6c(%ebp)
  80039c:	e8 86 13 00 00       	call   801727 <malloc>
  8003a1:	83 c4 10             	add    $0x10,%esp
  8003a4:	89 45 8c             	mov    %eax,-0x74(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003a7:	e8 73 17 00 00       	call   801b1f <sys_pf_calculate_allocated_pages>
  8003ac:	89 45 88             	mov    %eax,-0x78(%ebp)

		x[1]=-1;
  8003af:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003b2:	40                   	inc    %eax
  8003b3:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  8003b6:	8b 55 98             	mov    -0x68(%ebp),%edx
  8003b9:	89 d0                	mov    %edx,%eax
  8003bb:	c1 e0 02             	shl    $0x2,%eax
  8003be:	01 d0                	add    %edx,%eax
  8003c0:	89 c2                	mov    %eax,%edx
  8003c2:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003c5:	01 d0                	add    %edx,%eax
  8003c7:	c6 00 ff             	movb   $0xff,(%eax)

		z[4*Mega] = 'M' ;
  8003ca:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003cd:	c1 e0 02             	shl    $0x2,%eax
  8003d0:	c6 80 60 30 80 00 4d 	movb   $0x4d,0x803060(%eax)

		x[8*Mega] = -1;
  8003d7:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003da:	c1 e0 03             	shl    $0x3,%eax
  8003dd:	89 c2                	mov    %eax,%edx
  8003df:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003e2:	01 d0                	add    %edx,%eax
  8003e4:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8003e7:	8b 55 98             	mov    -0x68(%ebp),%edx
  8003ea:	89 d0                	mov    %edx,%eax
  8003ec:	01 c0                	add    %eax,%eax
  8003ee:	01 d0                	add    %edx,%eax
  8003f0:	c1 e0 02             	shl    $0x2,%eax
  8003f3:	89 c2                	mov    %eax,%edx
  8003f5:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003f8:	01 d0                	add    %edx,%eax
  8003fa:	c6 00 ff             	movb   $0xff,(%eax)


		free(x);
  8003fd:	83 ec 0c             	sub    $0xc,%esp
  800400:	ff 75 90             	pushl  -0x70(%ebp)
  800403:	e8 d7 14 00 00       	call   8018df <free>
  800408:	83 c4 10             	add    $0x10,%esp
		free(y);
  80040b:	83 ec 0c             	sub    $0xc,%esp
  80040e:	ff 75 8c             	pushl  -0x74(%ebp)
  800411:	e8 c9 14 00 00       	call   8018df <free>
  800416:	83 c4 10             	add    $0x10,%esp

		int freePages = sys_calculate_free_frames();
  800419:	e8 7e 16 00 00       	call   801a9c <sys_calculate_free_frames>
  80041e:	89 45 84             	mov    %eax,-0x7c(%ebp)

		x = malloc(sizeof(char)*size) ;
  800421:	83 ec 0c             	sub    $0xc,%esp
  800424:	ff 75 94             	pushl  -0x6c(%ebp)
  800427:	e8 fb 12 00 00       	call   801727 <malloc>
  80042c:	83 c4 10             	add    $0x10,%esp
  80042f:	89 45 90             	mov    %eax,-0x70(%ebp)

		x[1]=-2;
  800432:	8b 45 90             	mov    -0x70(%ebp),%eax
  800435:	40                   	inc    %eax
  800436:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  800439:	8b 55 98             	mov    -0x68(%ebp),%edx
  80043c:	89 d0                	mov    %edx,%eax
  80043e:	c1 e0 02             	shl    $0x2,%eax
  800441:	01 d0                	add    %edx,%eax
  800443:	89 c2                	mov    %eax,%edx
  800445:	8b 45 90             	mov    -0x70(%ebp),%eax
  800448:	01 d0                	add    %edx,%eax
  80044a:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  80044d:	8b 45 98             	mov    -0x68(%ebp),%eax
  800450:	c1 e0 03             	shl    $0x3,%eax
  800453:	89 c2                	mov    %eax,%edx
  800455:	8b 45 90             	mov    -0x70(%ebp),%eax
  800458:	01 d0                	add    %edx,%eax
  80045a:	c6 00 fe             	movb   $0xfe,(%eax)

		x[12*Mega]=-2;
  80045d:	8b 55 98             	mov    -0x68(%ebp),%edx
  800460:	89 d0                	mov    %edx,%eax
  800462:	01 c0                	add    %eax,%eax
  800464:	01 d0                	add    %edx,%eax
  800466:	c1 e0 02             	shl    $0x2,%eax
  800469:	89 c2                	mov    %eax,%edx
  80046b:	8b 45 90             	mov    -0x70(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	c6 00 fe             	movb   $0xfe,(%eax)


		uint32 pageWSEntries[11] = {0x800000,0x801000,0x802000,0x803000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0xc03000, 0x205000, 0xeebfd000};
  800473:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
  800479:	bb 20 24 80 00       	mov    $0x802420,%ebx
  80047e:	ba 0b 00 00 00       	mov    $0xb,%edx
  800483:	89 c7                	mov    %eax,%edi
  800485:	89 de                	mov    %ebx,%esi
  800487:	89 d1                	mov    %edx,%ecx
  800489:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  80048b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < (myEnv->page_WS_max_size); i++)
  800492:	eb 7c                	jmp    800510 <_main+0x4d8>
		{
			int found = 0 ;
  800494:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  80049b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004a2:	eb 40                	jmp    8004e4 <_main+0x4ac>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  8004a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004a7:	8b 8c 85 50 ff ff ff 	mov    -0xb0(%ebp,%eax,4),%ecx
  8004ae:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b3:	8b 98 34 03 00 00    	mov    0x334(%eax),%ebx
  8004b9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004bc:	89 d0                	mov    %edx,%eax
  8004be:	01 c0                	add    %eax,%eax
  8004c0:	01 d0                	add    %edx,%eax
  8004c2:	c1 e0 02             	shl    $0x2,%eax
  8004c5:	01 d8                	add    %ebx,%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	89 45 80             	mov    %eax,-0x80(%ebp)
  8004cc:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004cf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d4:	39 c1                	cmp    %eax,%ecx
  8004d6:	75 09                	jne    8004e1 <_main+0x4a9>
				{
					found = 1 ;
  8004d8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8004df:	eb 12                	jmp    8004f3 <_main+0x4bb>

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8004e1:	ff 45 e0             	incl   -0x20(%ebp)
  8004e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e9:	8b 50 74             	mov    0x74(%eax),%edx
  8004ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004ef:	39 c2                	cmp    %eax,%edx
  8004f1:	77 b1                	ja     8004a4 <_main+0x46c>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8004f3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8004f7:	75 14                	jne    80050d <_main+0x4d5>
				panic("PAGE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
  8004f9:	83 ec 04             	sub    $0x4,%esp
  8004fc:	68 b8 22 80 00       	push   $0x8022b8
  800501:	6a 5f                	push   $0x5f
  800503:	68 09 22 80 00       	push   $0x802209
  800508:	e8 dc 01 00 00       	call   8006e9 <_panic>


		uint32 pageWSEntries[11] = {0x800000,0x801000,0x802000,0x803000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0xc03000, 0x205000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  80050d:	ff 45 e4             	incl   -0x1c(%ebp)
  800510:	a1 20 30 80 00       	mov    0x803020,%eax
  800515:	8b 50 74             	mov    0x74(%eax),%edx
  800518:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80051b:	39 c2                	cmp    %eax,%edx
  80051d:	0f 87 71 ff ff ff    	ja     800494 <_main+0x45c>
			}
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
		}

		uint32 tableWSEntries[8] = {0x0, 0x80400000, 0x80800000, 0x80c00000, 0x80000000, 0x800000,0xc00000, 0xee800000};
  800523:	8d 85 30 ff ff ff    	lea    -0xd0(%ebp),%eax
  800529:	bb 60 24 80 00       	mov    $0x802460,%ebx
  80052e:	ba 08 00 00 00       	mov    $0x8,%edx
  800533:	89 c7                	mov    %eax,%edi
  800535:	89 de                	mov    %ebx,%esi
  800537:	89 d1                	mov    %edx,%ecx
  800539:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)


		for (i=0; i < __TWS_MAX_SIZE; i++)
  80053b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800542:	eb 77                	jmp    8005bb <_main+0x583>
		{
			int found = 0 ;
  800544:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for (j=0; j < __TWS_MAX_SIZE; j++)
  80054b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800552:	eb 44                	jmp    800598 <_main+0x560>
			{
				if (tableWSEntries[i] == ROUNDDOWN(myEnv->__ptr_tws[j].virtual_address,1024*PAGE_SIZE) )
  800554:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800557:	8b 8c 85 30 ff ff ff 	mov    -0xd0(%ebp,%eax,4),%ecx
  80055e:	8b 1d 20 30 80 00    	mov    0x803020,%ebx
  800564:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800567:	89 d0                	mov    %edx,%eax
  800569:	01 c0                	add    %eax,%eax
  80056b:	01 d0                	add    %edx,%eax
  80056d:	c1 e0 02             	shl    $0x2,%eax
  800570:	01 d8                	add    %ebx,%eax
  800572:	83 c0 7c             	add    $0x7c,%eax
  800575:	8b 00                	mov    (%eax),%eax
  800577:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80057d:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800583:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800588:	39 c1                	cmp    %eax,%ecx
  80058a:	75 09                	jne    800595 <_main+0x55d>
				{
					found = 1 ;
  80058c:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
					break;
  800593:	eb 09                	jmp    80059e <_main+0x566>


		for (i=0; i < __TWS_MAX_SIZE; i++)
		{
			int found = 0 ;
			for (j=0; j < __TWS_MAX_SIZE; j++)
  800595:	ff 45 e0             	incl   -0x20(%ebp)
  800598:	83 7d e0 31          	cmpl   $0x31,-0x20(%ebp)
  80059c:	7e b6                	jle    800554 <_main+0x51c>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  80059e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  8005a2:	75 14                	jne    8005b8 <_main+0x580>
				panic("TABLE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
  8005a4:	83 ec 04             	sub    $0x4,%esp
  8005a7:	68 3c 23 80 00       	push   $0x80233c
  8005ac:	6a 71                	push   $0x71
  8005ae:	68 09 22 80 00       	push   $0x802209
  8005b3:	e8 31 01 00 00       	call   8006e9 <_panic>
		}

		uint32 tableWSEntries[8] = {0x0, 0x80400000, 0x80800000, 0x80c00000, 0x80000000, 0x800000,0xc00000, 0xee800000};


		for (i=0; i < __TWS_MAX_SIZE; i++)
  8005b8:	ff 45 e4             	incl   -0x1c(%ebp)
  8005bb:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
  8005bf:	7e 83                	jle    800544 <_main+0x50c>


		//if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
	}

	cprintf("Congratulations!! test freeHeap 2 [WITH REPLACEMENT] completed successfully.\n");
  8005c1:	83 ec 0c             	sub    $0xc,%esp
  8005c4:	68 c0 23 80 00       	push   $0x8023c0
  8005c9:	e8 cf 03 00 00       	call   80099d <cprintf>
  8005ce:	83 c4 10             	add    $0x10,%esp


	return;
  8005d1:	90                   	nop
}
  8005d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8005d5:	5b                   	pop    %ebx
  8005d6:	5e                   	pop    %esi
  8005d7:	5f                   	pop    %edi
  8005d8:	5d                   	pop    %ebp
  8005d9:	c3                   	ret    

008005da <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005da:	55                   	push   %ebp
  8005db:	89 e5                	mov    %esp,%ebp
  8005dd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005e0:	e8 ec 13 00 00       	call   8019d1 <sys_getenvindex>
  8005e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005eb:	89 d0                	mov    %edx,%eax
  8005ed:	c1 e0 02             	shl    $0x2,%eax
  8005f0:	01 d0                	add    %edx,%eax
  8005f2:	01 c0                	add    %eax,%eax
  8005f4:	01 d0                	add    %edx,%eax
  8005f6:	01 c0                	add    %eax,%eax
  8005f8:	01 d0                	add    %edx,%eax
  8005fa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800601:	01 d0                	add    %edx,%eax
  800603:	c1 e0 02             	shl    $0x2,%eax
  800606:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80060b:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800610:	a1 20 30 80 00       	mov    0x803020,%eax
  800615:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80061b:	84 c0                	test   %al,%al
  80061d:	74 0f                	je     80062e <libmain+0x54>
		binaryname = myEnv->prog_name;
  80061f:	a1 20 30 80 00       	mov    0x803020,%eax
  800624:	05 f4 02 00 00       	add    $0x2f4,%eax
  800629:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80062e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800632:	7e 0a                	jle    80063e <libmain+0x64>
		binaryname = argv[0];
  800634:	8b 45 0c             	mov    0xc(%ebp),%eax
  800637:	8b 00                	mov    (%eax),%eax
  800639:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80063e:	83 ec 08             	sub    $0x8,%esp
  800641:	ff 75 0c             	pushl  0xc(%ebp)
  800644:	ff 75 08             	pushl  0x8(%ebp)
  800647:	e8 ec f9 ff ff       	call   800038 <_main>
  80064c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80064f:	e8 18 15 00 00       	call   801b6c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800654:	83 ec 0c             	sub    $0xc,%esp
  800657:	68 98 24 80 00       	push   $0x802498
  80065c:	e8 3c 03 00 00       	call   80099d <cprintf>
  800661:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800664:	a1 20 30 80 00       	mov    0x803020,%eax
  800669:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80066f:	a1 20 30 80 00       	mov    0x803020,%eax
  800674:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80067a:	83 ec 04             	sub    $0x4,%esp
  80067d:	52                   	push   %edx
  80067e:	50                   	push   %eax
  80067f:	68 c0 24 80 00       	push   $0x8024c0
  800684:	e8 14 03 00 00       	call   80099d <cprintf>
  800689:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80068c:	a1 20 30 80 00       	mov    0x803020,%eax
  800691:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800697:	83 ec 08             	sub    $0x8,%esp
  80069a:	50                   	push   %eax
  80069b:	68 e5 24 80 00       	push   $0x8024e5
  8006a0:	e8 f8 02 00 00       	call   80099d <cprintf>
  8006a5:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006a8:	83 ec 0c             	sub    $0xc,%esp
  8006ab:	68 98 24 80 00       	push   $0x802498
  8006b0:	e8 e8 02 00 00       	call   80099d <cprintf>
  8006b5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006b8:	e8 c9 14 00 00       	call   801b86 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006bd:	e8 19 00 00 00       	call   8006db <exit>
}
  8006c2:	90                   	nop
  8006c3:	c9                   	leave  
  8006c4:	c3                   	ret    

008006c5 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006c5:	55                   	push   %ebp
  8006c6:	89 e5                	mov    %esp,%ebp
  8006c8:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006cb:	83 ec 0c             	sub    $0xc,%esp
  8006ce:	6a 00                	push   $0x0
  8006d0:	e8 c8 12 00 00       	call   80199d <sys_env_destroy>
  8006d5:	83 c4 10             	add    $0x10,%esp
}
  8006d8:	90                   	nop
  8006d9:	c9                   	leave  
  8006da:	c3                   	ret    

008006db <exit>:

void
exit(void)
{
  8006db:	55                   	push   %ebp
  8006dc:	89 e5                	mov    %esp,%ebp
  8006de:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006e1:	e8 1d 13 00 00       	call   801a03 <sys_env_exit>
}
  8006e6:	90                   	nop
  8006e7:	c9                   	leave  
  8006e8:	c3                   	ret    

008006e9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006e9:	55                   	push   %ebp
  8006ea:	89 e5                	mov    %esp,%ebp
  8006ec:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006ef:	8d 45 10             	lea    0x10(%ebp),%eax
  8006f2:	83 c0 04             	add    $0x4,%eax
  8006f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006f8:	a1 64 30 d0 00       	mov    0xd03064,%eax
  8006fd:	85 c0                	test   %eax,%eax
  8006ff:	74 16                	je     800717 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800701:	a1 64 30 d0 00       	mov    0xd03064,%eax
  800706:	83 ec 08             	sub    $0x8,%esp
  800709:	50                   	push   %eax
  80070a:	68 fc 24 80 00       	push   $0x8024fc
  80070f:	e8 89 02 00 00       	call   80099d <cprintf>
  800714:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800717:	a1 00 30 80 00       	mov    0x803000,%eax
  80071c:	ff 75 0c             	pushl  0xc(%ebp)
  80071f:	ff 75 08             	pushl  0x8(%ebp)
  800722:	50                   	push   %eax
  800723:	68 01 25 80 00       	push   $0x802501
  800728:	e8 70 02 00 00       	call   80099d <cprintf>
  80072d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800730:	8b 45 10             	mov    0x10(%ebp),%eax
  800733:	83 ec 08             	sub    $0x8,%esp
  800736:	ff 75 f4             	pushl  -0xc(%ebp)
  800739:	50                   	push   %eax
  80073a:	e8 f3 01 00 00       	call   800932 <vcprintf>
  80073f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800742:	83 ec 08             	sub    $0x8,%esp
  800745:	6a 00                	push   $0x0
  800747:	68 1d 25 80 00       	push   $0x80251d
  80074c:	e8 e1 01 00 00       	call   800932 <vcprintf>
  800751:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800754:	e8 82 ff ff ff       	call   8006db <exit>

	// should not return here
	while (1) ;
  800759:	eb fe                	jmp    800759 <_panic+0x70>

0080075b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80075b:	55                   	push   %ebp
  80075c:	89 e5                	mov    %esp,%ebp
  80075e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800761:	a1 20 30 80 00       	mov    0x803020,%eax
  800766:	8b 50 74             	mov    0x74(%eax),%edx
  800769:	8b 45 0c             	mov    0xc(%ebp),%eax
  80076c:	39 c2                	cmp    %eax,%edx
  80076e:	74 14                	je     800784 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800770:	83 ec 04             	sub    $0x4,%esp
  800773:	68 20 25 80 00       	push   $0x802520
  800778:	6a 26                	push   $0x26
  80077a:	68 6c 25 80 00       	push   $0x80256c
  80077f:	e8 65 ff ff ff       	call   8006e9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800784:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80078b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800792:	e9 c2 00 00 00       	jmp    800859 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800797:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80079a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a4:	01 d0                	add    %edx,%eax
  8007a6:	8b 00                	mov    (%eax),%eax
  8007a8:	85 c0                	test   %eax,%eax
  8007aa:	75 08                	jne    8007b4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007ac:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007af:	e9 a2 00 00 00       	jmp    800856 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007bb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007c2:	eb 69                	jmp    80082d <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007cf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007d2:	89 d0                	mov    %edx,%eax
  8007d4:	01 c0                	add    %eax,%eax
  8007d6:	01 d0                	add    %edx,%eax
  8007d8:	c1 e0 02             	shl    $0x2,%eax
  8007db:	01 c8                	add    %ecx,%eax
  8007dd:	8a 40 04             	mov    0x4(%eax),%al
  8007e0:	84 c0                	test   %al,%al
  8007e2:	75 46                	jne    80082a <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007ef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007f2:	89 d0                	mov    %edx,%eax
  8007f4:	01 c0                	add    %eax,%eax
  8007f6:	01 d0                	add    %edx,%eax
  8007f8:	c1 e0 02             	shl    $0x2,%eax
  8007fb:	01 c8                	add    %ecx,%eax
  8007fd:	8b 00                	mov    (%eax),%eax
  8007ff:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800802:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800805:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80080a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80080c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80080f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800816:	8b 45 08             	mov    0x8(%ebp),%eax
  800819:	01 c8                	add    %ecx,%eax
  80081b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80081d:	39 c2                	cmp    %eax,%edx
  80081f:	75 09                	jne    80082a <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800821:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800828:	eb 12                	jmp    80083c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80082a:	ff 45 e8             	incl   -0x18(%ebp)
  80082d:	a1 20 30 80 00       	mov    0x803020,%eax
  800832:	8b 50 74             	mov    0x74(%eax),%edx
  800835:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800838:	39 c2                	cmp    %eax,%edx
  80083a:	77 88                	ja     8007c4 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80083c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800840:	75 14                	jne    800856 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800842:	83 ec 04             	sub    $0x4,%esp
  800845:	68 78 25 80 00       	push   $0x802578
  80084a:	6a 3a                	push   $0x3a
  80084c:	68 6c 25 80 00       	push   $0x80256c
  800851:	e8 93 fe ff ff       	call   8006e9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800856:	ff 45 f0             	incl   -0x10(%ebp)
  800859:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80085c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80085f:	0f 8c 32 ff ff ff    	jl     800797 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800865:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80086c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800873:	eb 26                	jmp    80089b <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800875:	a1 20 30 80 00       	mov    0x803020,%eax
  80087a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800880:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800883:	89 d0                	mov    %edx,%eax
  800885:	01 c0                	add    %eax,%eax
  800887:	01 d0                	add    %edx,%eax
  800889:	c1 e0 02             	shl    $0x2,%eax
  80088c:	01 c8                	add    %ecx,%eax
  80088e:	8a 40 04             	mov    0x4(%eax),%al
  800891:	3c 01                	cmp    $0x1,%al
  800893:	75 03                	jne    800898 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800895:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800898:	ff 45 e0             	incl   -0x20(%ebp)
  80089b:	a1 20 30 80 00       	mov    0x803020,%eax
  8008a0:	8b 50 74             	mov    0x74(%eax),%edx
  8008a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a6:	39 c2                	cmp    %eax,%edx
  8008a8:	77 cb                	ja     800875 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008ad:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008b0:	74 14                	je     8008c6 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008b2:	83 ec 04             	sub    $0x4,%esp
  8008b5:	68 cc 25 80 00       	push   $0x8025cc
  8008ba:	6a 44                	push   $0x44
  8008bc:	68 6c 25 80 00       	push   $0x80256c
  8008c1:	e8 23 fe ff ff       	call   8006e9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008c6:	90                   	nop
  8008c7:	c9                   	leave  
  8008c8:	c3                   	ret    

008008c9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008c9:	55                   	push   %ebp
  8008ca:	89 e5                	mov    %esp,%ebp
  8008cc:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d2:	8b 00                	mov    (%eax),%eax
  8008d4:	8d 48 01             	lea    0x1(%eax),%ecx
  8008d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008da:	89 0a                	mov    %ecx,(%edx)
  8008dc:	8b 55 08             	mov    0x8(%ebp),%edx
  8008df:	88 d1                	mov    %dl,%cl
  8008e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008eb:	8b 00                	mov    (%eax),%eax
  8008ed:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008f2:	75 2c                	jne    800920 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008f4:	a0 24 30 80 00       	mov    0x803024,%al
  8008f9:	0f b6 c0             	movzbl %al,%eax
  8008fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ff:	8b 12                	mov    (%edx),%edx
  800901:	89 d1                	mov    %edx,%ecx
  800903:	8b 55 0c             	mov    0xc(%ebp),%edx
  800906:	83 c2 08             	add    $0x8,%edx
  800909:	83 ec 04             	sub    $0x4,%esp
  80090c:	50                   	push   %eax
  80090d:	51                   	push   %ecx
  80090e:	52                   	push   %edx
  80090f:	e8 47 10 00 00       	call   80195b <sys_cputs>
  800914:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800917:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800920:	8b 45 0c             	mov    0xc(%ebp),%eax
  800923:	8b 40 04             	mov    0x4(%eax),%eax
  800926:	8d 50 01             	lea    0x1(%eax),%edx
  800929:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80092f:	90                   	nop
  800930:	c9                   	leave  
  800931:	c3                   	ret    

00800932 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800932:	55                   	push   %ebp
  800933:	89 e5                	mov    %esp,%ebp
  800935:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80093b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800942:	00 00 00 
	b.cnt = 0;
  800945:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80094c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80094f:	ff 75 0c             	pushl  0xc(%ebp)
  800952:	ff 75 08             	pushl  0x8(%ebp)
  800955:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80095b:	50                   	push   %eax
  80095c:	68 c9 08 80 00       	push   $0x8008c9
  800961:	e8 11 02 00 00       	call   800b77 <vprintfmt>
  800966:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800969:	a0 24 30 80 00       	mov    0x803024,%al
  80096e:	0f b6 c0             	movzbl %al,%eax
  800971:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800977:	83 ec 04             	sub    $0x4,%esp
  80097a:	50                   	push   %eax
  80097b:	52                   	push   %edx
  80097c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800982:	83 c0 08             	add    $0x8,%eax
  800985:	50                   	push   %eax
  800986:	e8 d0 0f 00 00       	call   80195b <sys_cputs>
  80098b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80098e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800995:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80099b:	c9                   	leave  
  80099c:	c3                   	ret    

0080099d <cprintf>:

int cprintf(const char *fmt, ...) {
  80099d:	55                   	push   %ebp
  80099e:	89 e5                	mov    %esp,%ebp
  8009a0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009a3:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009aa:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b3:	83 ec 08             	sub    $0x8,%esp
  8009b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8009b9:	50                   	push   %eax
  8009ba:	e8 73 ff ff ff       	call   800932 <vcprintf>
  8009bf:	83 c4 10             	add    $0x10,%esp
  8009c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009c8:	c9                   	leave  
  8009c9:	c3                   	ret    

008009ca <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009ca:	55                   	push   %ebp
  8009cb:	89 e5                	mov    %esp,%ebp
  8009cd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009d0:	e8 97 11 00 00       	call   801b6c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009d5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009db:	8b 45 08             	mov    0x8(%ebp),%eax
  8009de:	83 ec 08             	sub    $0x8,%esp
  8009e1:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e4:	50                   	push   %eax
  8009e5:	e8 48 ff ff ff       	call   800932 <vcprintf>
  8009ea:	83 c4 10             	add    $0x10,%esp
  8009ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009f0:	e8 91 11 00 00       	call   801b86 <sys_enable_interrupt>
	return cnt;
  8009f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009f8:	c9                   	leave  
  8009f9:	c3                   	ret    

008009fa <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009fa:	55                   	push   %ebp
  8009fb:	89 e5                	mov    %esp,%ebp
  8009fd:	53                   	push   %ebx
  8009fe:	83 ec 14             	sub    $0x14,%esp
  800a01:	8b 45 10             	mov    0x10(%ebp),%eax
  800a04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a07:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a0d:	8b 45 18             	mov    0x18(%ebp),%eax
  800a10:	ba 00 00 00 00       	mov    $0x0,%edx
  800a15:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a18:	77 55                	ja     800a6f <printnum+0x75>
  800a1a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a1d:	72 05                	jb     800a24 <printnum+0x2a>
  800a1f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a22:	77 4b                	ja     800a6f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a24:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a27:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a2a:	8b 45 18             	mov    0x18(%ebp),%eax
  800a2d:	ba 00 00 00 00       	mov    $0x0,%edx
  800a32:	52                   	push   %edx
  800a33:	50                   	push   %eax
  800a34:	ff 75 f4             	pushl  -0xc(%ebp)
  800a37:	ff 75 f0             	pushl  -0x10(%ebp)
  800a3a:	e8 0d 15 00 00       	call   801f4c <__udivdi3>
  800a3f:	83 c4 10             	add    $0x10,%esp
  800a42:	83 ec 04             	sub    $0x4,%esp
  800a45:	ff 75 20             	pushl  0x20(%ebp)
  800a48:	53                   	push   %ebx
  800a49:	ff 75 18             	pushl  0x18(%ebp)
  800a4c:	52                   	push   %edx
  800a4d:	50                   	push   %eax
  800a4e:	ff 75 0c             	pushl  0xc(%ebp)
  800a51:	ff 75 08             	pushl  0x8(%ebp)
  800a54:	e8 a1 ff ff ff       	call   8009fa <printnum>
  800a59:	83 c4 20             	add    $0x20,%esp
  800a5c:	eb 1a                	jmp    800a78 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a5e:	83 ec 08             	sub    $0x8,%esp
  800a61:	ff 75 0c             	pushl  0xc(%ebp)
  800a64:	ff 75 20             	pushl  0x20(%ebp)
  800a67:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6a:	ff d0                	call   *%eax
  800a6c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a6f:	ff 4d 1c             	decl   0x1c(%ebp)
  800a72:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a76:	7f e6                	jg     800a5e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a78:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a7b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a80:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a83:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a86:	53                   	push   %ebx
  800a87:	51                   	push   %ecx
  800a88:	52                   	push   %edx
  800a89:	50                   	push   %eax
  800a8a:	e8 cd 15 00 00       	call   80205c <__umoddi3>
  800a8f:	83 c4 10             	add    $0x10,%esp
  800a92:	05 34 28 80 00       	add    $0x802834,%eax
  800a97:	8a 00                	mov    (%eax),%al
  800a99:	0f be c0             	movsbl %al,%eax
  800a9c:	83 ec 08             	sub    $0x8,%esp
  800a9f:	ff 75 0c             	pushl  0xc(%ebp)
  800aa2:	50                   	push   %eax
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	ff d0                	call   *%eax
  800aa8:	83 c4 10             	add    $0x10,%esp
}
  800aab:	90                   	nop
  800aac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800aaf:	c9                   	leave  
  800ab0:	c3                   	ret    

00800ab1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ab1:	55                   	push   %ebp
  800ab2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ab4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ab8:	7e 1c                	jle    800ad6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	8b 00                	mov    (%eax),%eax
  800abf:	8d 50 08             	lea    0x8(%eax),%edx
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	89 10                	mov    %edx,(%eax)
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	8b 00                	mov    (%eax),%eax
  800acc:	83 e8 08             	sub    $0x8,%eax
  800acf:	8b 50 04             	mov    0x4(%eax),%edx
  800ad2:	8b 00                	mov    (%eax),%eax
  800ad4:	eb 40                	jmp    800b16 <getuint+0x65>
	else if (lflag)
  800ad6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ada:	74 1e                	je     800afa <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	8d 50 04             	lea    0x4(%eax),%edx
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	89 10                	mov    %edx,(%eax)
  800ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aec:	8b 00                	mov    (%eax),%eax
  800aee:	83 e8 04             	sub    $0x4,%eax
  800af1:	8b 00                	mov    (%eax),%eax
  800af3:	ba 00 00 00 00       	mov    $0x0,%edx
  800af8:	eb 1c                	jmp    800b16 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
  800afd:	8b 00                	mov    (%eax),%eax
  800aff:	8d 50 04             	lea    0x4(%eax),%edx
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	89 10                	mov    %edx,(%eax)
  800b07:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0a:	8b 00                	mov    (%eax),%eax
  800b0c:	83 e8 04             	sub    $0x4,%eax
  800b0f:	8b 00                	mov    (%eax),%eax
  800b11:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b16:	5d                   	pop    %ebp
  800b17:	c3                   	ret    

00800b18 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b18:	55                   	push   %ebp
  800b19:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b1b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b1f:	7e 1c                	jle    800b3d <getint+0x25>
		return va_arg(*ap, long long);
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	8b 00                	mov    (%eax),%eax
  800b26:	8d 50 08             	lea    0x8(%eax),%edx
  800b29:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2c:	89 10                	mov    %edx,(%eax)
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	8b 00                	mov    (%eax),%eax
  800b33:	83 e8 08             	sub    $0x8,%eax
  800b36:	8b 50 04             	mov    0x4(%eax),%edx
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	eb 38                	jmp    800b75 <getint+0x5d>
	else if (lflag)
  800b3d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b41:	74 1a                	je     800b5d <getint+0x45>
		return va_arg(*ap, long);
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	8b 00                	mov    (%eax),%eax
  800b48:	8d 50 04             	lea    0x4(%eax),%edx
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	89 10                	mov    %edx,(%eax)
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
  800b53:	8b 00                	mov    (%eax),%eax
  800b55:	83 e8 04             	sub    $0x4,%eax
  800b58:	8b 00                	mov    (%eax),%eax
  800b5a:	99                   	cltd   
  800b5b:	eb 18                	jmp    800b75 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	8b 00                	mov    (%eax),%eax
  800b62:	8d 50 04             	lea    0x4(%eax),%edx
  800b65:	8b 45 08             	mov    0x8(%ebp),%eax
  800b68:	89 10                	mov    %edx,(%eax)
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	8b 00                	mov    (%eax),%eax
  800b6f:	83 e8 04             	sub    $0x4,%eax
  800b72:	8b 00                	mov    (%eax),%eax
  800b74:	99                   	cltd   
}
  800b75:	5d                   	pop    %ebp
  800b76:	c3                   	ret    

00800b77 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b77:	55                   	push   %ebp
  800b78:	89 e5                	mov    %esp,%ebp
  800b7a:	56                   	push   %esi
  800b7b:	53                   	push   %ebx
  800b7c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b7f:	eb 17                	jmp    800b98 <vprintfmt+0x21>
			if (ch == '\0')
  800b81:	85 db                	test   %ebx,%ebx
  800b83:	0f 84 af 03 00 00    	je     800f38 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b89:	83 ec 08             	sub    $0x8,%esp
  800b8c:	ff 75 0c             	pushl  0xc(%ebp)
  800b8f:	53                   	push   %ebx
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	ff d0                	call   *%eax
  800b95:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b98:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9b:	8d 50 01             	lea    0x1(%eax),%edx
  800b9e:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba1:	8a 00                	mov    (%eax),%al
  800ba3:	0f b6 d8             	movzbl %al,%ebx
  800ba6:	83 fb 25             	cmp    $0x25,%ebx
  800ba9:	75 d6                	jne    800b81 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bab:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800baf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bb6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bbd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bc4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bcb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bce:	8d 50 01             	lea    0x1(%eax),%edx
  800bd1:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd4:	8a 00                	mov    (%eax),%al
  800bd6:	0f b6 d8             	movzbl %al,%ebx
  800bd9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bdc:	83 f8 55             	cmp    $0x55,%eax
  800bdf:	0f 87 2b 03 00 00    	ja     800f10 <vprintfmt+0x399>
  800be5:	8b 04 85 58 28 80 00 	mov    0x802858(,%eax,4),%eax
  800bec:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bee:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bf2:	eb d7                	jmp    800bcb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bf4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bf8:	eb d1                	jmp    800bcb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bfa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c01:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c04:	89 d0                	mov    %edx,%eax
  800c06:	c1 e0 02             	shl    $0x2,%eax
  800c09:	01 d0                	add    %edx,%eax
  800c0b:	01 c0                	add    %eax,%eax
  800c0d:	01 d8                	add    %ebx,%eax
  800c0f:	83 e8 30             	sub    $0x30,%eax
  800c12:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c15:	8b 45 10             	mov    0x10(%ebp),%eax
  800c18:	8a 00                	mov    (%eax),%al
  800c1a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c1d:	83 fb 2f             	cmp    $0x2f,%ebx
  800c20:	7e 3e                	jle    800c60 <vprintfmt+0xe9>
  800c22:	83 fb 39             	cmp    $0x39,%ebx
  800c25:	7f 39                	jg     800c60 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c27:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c2a:	eb d5                	jmp    800c01 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c2c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c2f:	83 c0 04             	add    $0x4,%eax
  800c32:	89 45 14             	mov    %eax,0x14(%ebp)
  800c35:	8b 45 14             	mov    0x14(%ebp),%eax
  800c38:	83 e8 04             	sub    $0x4,%eax
  800c3b:	8b 00                	mov    (%eax),%eax
  800c3d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c40:	eb 1f                	jmp    800c61 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c46:	79 83                	jns    800bcb <vprintfmt+0x54>
				width = 0;
  800c48:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c4f:	e9 77 ff ff ff       	jmp    800bcb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c54:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c5b:	e9 6b ff ff ff       	jmp    800bcb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c60:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c61:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c65:	0f 89 60 ff ff ff    	jns    800bcb <vprintfmt+0x54>
				width = precision, precision = -1;
  800c6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c71:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c78:	e9 4e ff ff ff       	jmp    800bcb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c7d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c80:	e9 46 ff ff ff       	jmp    800bcb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c85:	8b 45 14             	mov    0x14(%ebp),%eax
  800c88:	83 c0 04             	add    $0x4,%eax
  800c8b:	89 45 14             	mov    %eax,0x14(%ebp)
  800c8e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c91:	83 e8 04             	sub    $0x4,%eax
  800c94:	8b 00                	mov    (%eax),%eax
  800c96:	83 ec 08             	sub    $0x8,%esp
  800c99:	ff 75 0c             	pushl  0xc(%ebp)
  800c9c:	50                   	push   %eax
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca0:	ff d0                	call   *%eax
  800ca2:	83 c4 10             	add    $0x10,%esp
			break;
  800ca5:	e9 89 02 00 00       	jmp    800f33 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800caa:	8b 45 14             	mov    0x14(%ebp),%eax
  800cad:	83 c0 04             	add    $0x4,%eax
  800cb0:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb6:	83 e8 04             	sub    $0x4,%eax
  800cb9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cbb:	85 db                	test   %ebx,%ebx
  800cbd:	79 02                	jns    800cc1 <vprintfmt+0x14a>
				err = -err;
  800cbf:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cc1:	83 fb 64             	cmp    $0x64,%ebx
  800cc4:	7f 0b                	jg     800cd1 <vprintfmt+0x15a>
  800cc6:	8b 34 9d a0 26 80 00 	mov    0x8026a0(,%ebx,4),%esi
  800ccd:	85 f6                	test   %esi,%esi
  800ccf:	75 19                	jne    800cea <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cd1:	53                   	push   %ebx
  800cd2:	68 45 28 80 00       	push   $0x802845
  800cd7:	ff 75 0c             	pushl  0xc(%ebp)
  800cda:	ff 75 08             	pushl  0x8(%ebp)
  800cdd:	e8 5e 02 00 00       	call   800f40 <printfmt>
  800ce2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ce5:	e9 49 02 00 00       	jmp    800f33 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cea:	56                   	push   %esi
  800ceb:	68 4e 28 80 00       	push   $0x80284e
  800cf0:	ff 75 0c             	pushl  0xc(%ebp)
  800cf3:	ff 75 08             	pushl  0x8(%ebp)
  800cf6:	e8 45 02 00 00       	call   800f40 <printfmt>
  800cfb:	83 c4 10             	add    $0x10,%esp
			break;
  800cfe:	e9 30 02 00 00       	jmp    800f33 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d03:	8b 45 14             	mov    0x14(%ebp),%eax
  800d06:	83 c0 04             	add    $0x4,%eax
  800d09:	89 45 14             	mov    %eax,0x14(%ebp)
  800d0c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0f:	83 e8 04             	sub    $0x4,%eax
  800d12:	8b 30                	mov    (%eax),%esi
  800d14:	85 f6                	test   %esi,%esi
  800d16:	75 05                	jne    800d1d <vprintfmt+0x1a6>
				p = "(null)";
  800d18:	be 51 28 80 00       	mov    $0x802851,%esi
			if (width > 0 && padc != '-')
  800d1d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d21:	7e 6d                	jle    800d90 <vprintfmt+0x219>
  800d23:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d27:	74 67                	je     800d90 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d29:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d2c:	83 ec 08             	sub    $0x8,%esp
  800d2f:	50                   	push   %eax
  800d30:	56                   	push   %esi
  800d31:	e8 0c 03 00 00       	call   801042 <strnlen>
  800d36:	83 c4 10             	add    $0x10,%esp
  800d39:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d3c:	eb 16                	jmp    800d54 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d3e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d42:	83 ec 08             	sub    $0x8,%esp
  800d45:	ff 75 0c             	pushl  0xc(%ebp)
  800d48:	50                   	push   %eax
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	ff d0                	call   *%eax
  800d4e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d51:	ff 4d e4             	decl   -0x1c(%ebp)
  800d54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d58:	7f e4                	jg     800d3e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d5a:	eb 34                	jmp    800d90 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d5c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d60:	74 1c                	je     800d7e <vprintfmt+0x207>
  800d62:	83 fb 1f             	cmp    $0x1f,%ebx
  800d65:	7e 05                	jle    800d6c <vprintfmt+0x1f5>
  800d67:	83 fb 7e             	cmp    $0x7e,%ebx
  800d6a:	7e 12                	jle    800d7e <vprintfmt+0x207>
					putch('?', putdat);
  800d6c:	83 ec 08             	sub    $0x8,%esp
  800d6f:	ff 75 0c             	pushl  0xc(%ebp)
  800d72:	6a 3f                	push   $0x3f
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	ff d0                	call   *%eax
  800d79:	83 c4 10             	add    $0x10,%esp
  800d7c:	eb 0f                	jmp    800d8d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d7e:	83 ec 08             	sub    $0x8,%esp
  800d81:	ff 75 0c             	pushl  0xc(%ebp)
  800d84:	53                   	push   %ebx
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	ff d0                	call   *%eax
  800d8a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d8d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d90:	89 f0                	mov    %esi,%eax
  800d92:	8d 70 01             	lea    0x1(%eax),%esi
  800d95:	8a 00                	mov    (%eax),%al
  800d97:	0f be d8             	movsbl %al,%ebx
  800d9a:	85 db                	test   %ebx,%ebx
  800d9c:	74 24                	je     800dc2 <vprintfmt+0x24b>
  800d9e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800da2:	78 b8                	js     800d5c <vprintfmt+0x1e5>
  800da4:	ff 4d e0             	decl   -0x20(%ebp)
  800da7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dab:	79 af                	jns    800d5c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dad:	eb 13                	jmp    800dc2 <vprintfmt+0x24b>
				putch(' ', putdat);
  800daf:	83 ec 08             	sub    $0x8,%esp
  800db2:	ff 75 0c             	pushl  0xc(%ebp)
  800db5:	6a 20                	push   $0x20
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dba:	ff d0                	call   *%eax
  800dbc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dbf:	ff 4d e4             	decl   -0x1c(%ebp)
  800dc2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dc6:	7f e7                	jg     800daf <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dc8:	e9 66 01 00 00       	jmp    800f33 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dcd:	83 ec 08             	sub    $0x8,%esp
  800dd0:	ff 75 e8             	pushl  -0x18(%ebp)
  800dd3:	8d 45 14             	lea    0x14(%ebp),%eax
  800dd6:	50                   	push   %eax
  800dd7:	e8 3c fd ff ff       	call   800b18 <getint>
  800ddc:	83 c4 10             	add    $0x10,%esp
  800ddf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800de5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800deb:	85 d2                	test   %edx,%edx
  800ded:	79 23                	jns    800e12 <vprintfmt+0x29b>
				putch('-', putdat);
  800def:	83 ec 08             	sub    $0x8,%esp
  800df2:	ff 75 0c             	pushl  0xc(%ebp)
  800df5:	6a 2d                	push   $0x2d
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	ff d0                	call   *%eax
  800dfc:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e02:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e05:	f7 d8                	neg    %eax
  800e07:	83 d2 00             	adc    $0x0,%edx
  800e0a:	f7 da                	neg    %edx
  800e0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e12:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e19:	e9 bc 00 00 00       	jmp    800eda <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e1e:	83 ec 08             	sub    $0x8,%esp
  800e21:	ff 75 e8             	pushl  -0x18(%ebp)
  800e24:	8d 45 14             	lea    0x14(%ebp),%eax
  800e27:	50                   	push   %eax
  800e28:	e8 84 fc ff ff       	call   800ab1 <getuint>
  800e2d:	83 c4 10             	add    $0x10,%esp
  800e30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e33:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e36:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e3d:	e9 98 00 00 00       	jmp    800eda <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e42:	83 ec 08             	sub    $0x8,%esp
  800e45:	ff 75 0c             	pushl  0xc(%ebp)
  800e48:	6a 58                	push   $0x58
  800e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4d:	ff d0                	call   *%eax
  800e4f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e52:	83 ec 08             	sub    $0x8,%esp
  800e55:	ff 75 0c             	pushl  0xc(%ebp)
  800e58:	6a 58                	push   $0x58
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	ff d0                	call   *%eax
  800e5f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e62:	83 ec 08             	sub    $0x8,%esp
  800e65:	ff 75 0c             	pushl  0xc(%ebp)
  800e68:	6a 58                	push   $0x58
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	ff d0                	call   *%eax
  800e6f:	83 c4 10             	add    $0x10,%esp
			break;
  800e72:	e9 bc 00 00 00       	jmp    800f33 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e77:	83 ec 08             	sub    $0x8,%esp
  800e7a:	ff 75 0c             	pushl  0xc(%ebp)
  800e7d:	6a 30                	push   $0x30
  800e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e82:	ff d0                	call   *%eax
  800e84:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e87:	83 ec 08             	sub    $0x8,%esp
  800e8a:	ff 75 0c             	pushl  0xc(%ebp)
  800e8d:	6a 78                	push   $0x78
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	ff d0                	call   *%eax
  800e94:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e97:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9a:	83 c0 04             	add    $0x4,%eax
  800e9d:	89 45 14             	mov    %eax,0x14(%ebp)
  800ea0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea3:	83 e8 04             	sub    $0x4,%eax
  800ea6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ea8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800eb2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800eb9:	eb 1f                	jmp    800eda <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ebb:	83 ec 08             	sub    $0x8,%esp
  800ebe:	ff 75 e8             	pushl  -0x18(%ebp)
  800ec1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ec4:	50                   	push   %eax
  800ec5:	e8 e7 fb ff ff       	call   800ab1 <getuint>
  800eca:	83 c4 10             	add    $0x10,%esp
  800ecd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ed3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eda:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ede:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ee1:	83 ec 04             	sub    $0x4,%esp
  800ee4:	52                   	push   %edx
  800ee5:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ee8:	50                   	push   %eax
  800ee9:	ff 75 f4             	pushl  -0xc(%ebp)
  800eec:	ff 75 f0             	pushl  -0x10(%ebp)
  800eef:	ff 75 0c             	pushl  0xc(%ebp)
  800ef2:	ff 75 08             	pushl  0x8(%ebp)
  800ef5:	e8 00 fb ff ff       	call   8009fa <printnum>
  800efa:	83 c4 20             	add    $0x20,%esp
			break;
  800efd:	eb 34                	jmp    800f33 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800eff:	83 ec 08             	sub    $0x8,%esp
  800f02:	ff 75 0c             	pushl  0xc(%ebp)
  800f05:	53                   	push   %ebx
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	ff d0                	call   *%eax
  800f0b:	83 c4 10             	add    $0x10,%esp
			break;
  800f0e:	eb 23                	jmp    800f33 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f10:	83 ec 08             	sub    $0x8,%esp
  800f13:	ff 75 0c             	pushl  0xc(%ebp)
  800f16:	6a 25                	push   $0x25
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	ff d0                	call   *%eax
  800f1d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f20:	ff 4d 10             	decl   0x10(%ebp)
  800f23:	eb 03                	jmp    800f28 <vprintfmt+0x3b1>
  800f25:	ff 4d 10             	decl   0x10(%ebp)
  800f28:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2b:	48                   	dec    %eax
  800f2c:	8a 00                	mov    (%eax),%al
  800f2e:	3c 25                	cmp    $0x25,%al
  800f30:	75 f3                	jne    800f25 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f32:	90                   	nop
		}
	}
  800f33:	e9 47 fc ff ff       	jmp    800b7f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f38:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f39:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f3c:	5b                   	pop    %ebx
  800f3d:	5e                   	pop    %esi
  800f3e:	5d                   	pop    %ebp
  800f3f:	c3                   	ret    

00800f40 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f40:	55                   	push   %ebp
  800f41:	89 e5                	mov    %esp,%ebp
  800f43:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f46:	8d 45 10             	lea    0x10(%ebp),%eax
  800f49:	83 c0 04             	add    $0x4,%eax
  800f4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f52:	ff 75 f4             	pushl  -0xc(%ebp)
  800f55:	50                   	push   %eax
  800f56:	ff 75 0c             	pushl  0xc(%ebp)
  800f59:	ff 75 08             	pushl  0x8(%ebp)
  800f5c:	e8 16 fc ff ff       	call   800b77 <vprintfmt>
  800f61:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f64:	90                   	nop
  800f65:	c9                   	leave  
  800f66:	c3                   	ret    

00800f67 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f67:	55                   	push   %ebp
  800f68:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6d:	8b 40 08             	mov    0x8(%eax),%eax
  800f70:	8d 50 01             	lea    0x1(%eax),%edx
  800f73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f76:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7c:	8b 10                	mov    (%eax),%edx
  800f7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f81:	8b 40 04             	mov    0x4(%eax),%eax
  800f84:	39 c2                	cmp    %eax,%edx
  800f86:	73 12                	jae    800f9a <sprintputch+0x33>
		*b->buf++ = ch;
  800f88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8b:	8b 00                	mov    (%eax),%eax
  800f8d:	8d 48 01             	lea    0x1(%eax),%ecx
  800f90:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f93:	89 0a                	mov    %ecx,(%edx)
  800f95:	8b 55 08             	mov    0x8(%ebp),%edx
  800f98:	88 10                	mov    %dl,(%eax)
}
  800f9a:	90                   	nop
  800f9b:	5d                   	pop    %ebp
  800f9c:	c3                   	ret    

00800f9d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f9d:	55                   	push   %ebp
  800f9e:	89 e5                	mov    %esp,%ebp
  800fa0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fac:	8d 50 ff             	lea    -0x1(%eax),%edx
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	01 d0                	add    %edx,%eax
  800fb4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fbe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fc2:	74 06                	je     800fca <vsnprintf+0x2d>
  800fc4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fc8:	7f 07                	jg     800fd1 <vsnprintf+0x34>
		return -E_INVAL;
  800fca:	b8 03 00 00 00       	mov    $0x3,%eax
  800fcf:	eb 20                	jmp    800ff1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fd1:	ff 75 14             	pushl  0x14(%ebp)
  800fd4:	ff 75 10             	pushl  0x10(%ebp)
  800fd7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fda:	50                   	push   %eax
  800fdb:	68 67 0f 80 00       	push   $0x800f67
  800fe0:	e8 92 fb ff ff       	call   800b77 <vprintfmt>
  800fe5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fe8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800feb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ff1:	c9                   	leave  
  800ff2:	c3                   	ret    

00800ff3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ff3:	55                   	push   %ebp
  800ff4:	89 e5                	mov    %esp,%ebp
  800ff6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ff9:	8d 45 10             	lea    0x10(%ebp),%eax
  800ffc:	83 c0 04             	add    $0x4,%eax
  800fff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801002:	8b 45 10             	mov    0x10(%ebp),%eax
  801005:	ff 75 f4             	pushl  -0xc(%ebp)
  801008:	50                   	push   %eax
  801009:	ff 75 0c             	pushl  0xc(%ebp)
  80100c:	ff 75 08             	pushl  0x8(%ebp)
  80100f:	e8 89 ff ff ff       	call   800f9d <vsnprintf>
  801014:	83 c4 10             	add    $0x10,%esp
  801017:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80101a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80101d:	c9                   	leave  
  80101e:	c3                   	ret    

0080101f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80101f:	55                   	push   %ebp
  801020:	89 e5                	mov    %esp,%ebp
  801022:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801025:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80102c:	eb 06                	jmp    801034 <strlen+0x15>
		n++;
  80102e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801031:	ff 45 08             	incl   0x8(%ebp)
  801034:	8b 45 08             	mov    0x8(%ebp),%eax
  801037:	8a 00                	mov    (%eax),%al
  801039:	84 c0                	test   %al,%al
  80103b:	75 f1                	jne    80102e <strlen+0xf>
		n++;
	return n;
  80103d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801040:	c9                   	leave  
  801041:	c3                   	ret    

00801042 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801042:	55                   	push   %ebp
  801043:	89 e5                	mov    %esp,%ebp
  801045:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801048:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80104f:	eb 09                	jmp    80105a <strnlen+0x18>
		n++;
  801051:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801054:	ff 45 08             	incl   0x8(%ebp)
  801057:	ff 4d 0c             	decl   0xc(%ebp)
  80105a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80105e:	74 09                	je     801069 <strnlen+0x27>
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8a 00                	mov    (%eax),%al
  801065:	84 c0                	test   %al,%al
  801067:	75 e8                	jne    801051 <strnlen+0xf>
		n++;
	return n;
  801069:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80106c:	c9                   	leave  
  80106d:	c3                   	ret    

0080106e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80106e:	55                   	push   %ebp
  80106f:	89 e5                	mov    %esp,%ebp
  801071:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80107a:	90                   	nop
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8d 50 01             	lea    0x1(%eax),%edx
  801081:	89 55 08             	mov    %edx,0x8(%ebp)
  801084:	8b 55 0c             	mov    0xc(%ebp),%edx
  801087:	8d 4a 01             	lea    0x1(%edx),%ecx
  80108a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80108d:	8a 12                	mov    (%edx),%dl
  80108f:	88 10                	mov    %dl,(%eax)
  801091:	8a 00                	mov    (%eax),%al
  801093:	84 c0                	test   %al,%al
  801095:	75 e4                	jne    80107b <strcpy+0xd>
		/* do nothing */;
	return ret;
  801097:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80109a:	c9                   	leave  
  80109b:	c3                   	ret    

0080109c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80109c:	55                   	push   %ebp
  80109d:	89 e5                	mov    %esp,%ebp
  80109f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010af:	eb 1f                	jmp    8010d0 <strncpy+0x34>
		*dst++ = *src;
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	8d 50 01             	lea    0x1(%eax),%edx
  8010b7:	89 55 08             	mov    %edx,0x8(%ebp)
  8010ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010bd:	8a 12                	mov    (%edx),%dl
  8010bf:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c4:	8a 00                	mov    (%eax),%al
  8010c6:	84 c0                	test   %al,%al
  8010c8:	74 03                	je     8010cd <strncpy+0x31>
			src++;
  8010ca:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010cd:	ff 45 fc             	incl   -0x4(%ebp)
  8010d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010d6:	72 d9                	jb     8010b1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010db:	c9                   	leave  
  8010dc:	c3                   	ret    

008010dd <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010dd:	55                   	push   %ebp
  8010de:	89 e5                	mov    %esp,%ebp
  8010e0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ed:	74 30                	je     80111f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010ef:	eb 16                	jmp    801107 <strlcpy+0x2a>
			*dst++ = *src++;
  8010f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f4:	8d 50 01             	lea    0x1(%eax),%edx
  8010f7:	89 55 08             	mov    %edx,0x8(%ebp)
  8010fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010fd:	8d 4a 01             	lea    0x1(%edx),%ecx
  801100:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801103:	8a 12                	mov    (%edx),%dl
  801105:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801107:	ff 4d 10             	decl   0x10(%ebp)
  80110a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80110e:	74 09                	je     801119 <strlcpy+0x3c>
  801110:	8b 45 0c             	mov    0xc(%ebp),%eax
  801113:	8a 00                	mov    (%eax),%al
  801115:	84 c0                	test   %al,%al
  801117:	75 d8                	jne    8010f1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80111f:	8b 55 08             	mov    0x8(%ebp),%edx
  801122:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801125:	29 c2                	sub    %eax,%edx
  801127:	89 d0                	mov    %edx,%eax
}
  801129:	c9                   	leave  
  80112a:	c3                   	ret    

0080112b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80112b:	55                   	push   %ebp
  80112c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80112e:	eb 06                	jmp    801136 <strcmp+0xb>
		p++, q++;
  801130:	ff 45 08             	incl   0x8(%ebp)
  801133:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801136:	8b 45 08             	mov    0x8(%ebp),%eax
  801139:	8a 00                	mov    (%eax),%al
  80113b:	84 c0                	test   %al,%al
  80113d:	74 0e                	je     80114d <strcmp+0x22>
  80113f:	8b 45 08             	mov    0x8(%ebp),%eax
  801142:	8a 10                	mov    (%eax),%dl
  801144:	8b 45 0c             	mov    0xc(%ebp),%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	38 c2                	cmp    %al,%dl
  80114b:	74 e3                	je     801130 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	8a 00                	mov    (%eax),%al
  801152:	0f b6 d0             	movzbl %al,%edx
  801155:	8b 45 0c             	mov    0xc(%ebp),%eax
  801158:	8a 00                	mov    (%eax),%al
  80115a:	0f b6 c0             	movzbl %al,%eax
  80115d:	29 c2                	sub    %eax,%edx
  80115f:	89 d0                	mov    %edx,%eax
}
  801161:	5d                   	pop    %ebp
  801162:	c3                   	ret    

00801163 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801163:	55                   	push   %ebp
  801164:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801166:	eb 09                	jmp    801171 <strncmp+0xe>
		n--, p++, q++;
  801168:	ff 4d 10             	decl   0x10(%ebp)
  80116b:	ff 45 08             	incl   0x8(%ebp)
  80116e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801171:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801175:	74 17                	je     80118e <strncmp+0x2b>
  801177:	8b 45 08             	mov    0x8(%ebp),%eax
  80117a:	8a 00                	mov    (%eax),%al
  80117c:	84 c0                	test   %al,%al
  80117e:	74 0e                	je     80118e <strncmp+0x2b>
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	8a 10                	mov    (%eax),%dl
  801185:	8b 45 0c             	mov    0xc(%ebp),%eax
  801188:	8a 00                	mov    (%eax),%al
  80118a:	38 c2                	cmp    %al,%dl
  80118c:	74 da                	je     801168 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80118e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801192:	75 07                	jne    80119b <strncmp+0x38>
		return 0;
  801194:	b8 00 00 00 00       	mov    $0x0,%eax
  801199:	eb 14                	jmp    8011af <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	8a 00                	mov    (%eax),%al
  8011a0:	0f b6 d0             	movzbl %al,%edx
  8011a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a6:	8a 00                	mov    (%eax),%al
  8011a8:	0f b6 c0             	movzbl %al,%eax
  8011ab:	29 c2                	sub    %eax,%edx
  8011ad:	89 d0                	mov    %edx,%eax
}
  8011af:	5d                   	pop    %ebp
  8011b0:	c3                   	ret    

008011b1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011b1:	55                   	push   %ebp
  8011b2:	89 e5                	mov    %esp,%ebp
  8011b4:	83 ec 04             	sub    $0x4,%esp
  8011b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011bd:	eb 12                	jmp    8011d1 <strchr+0x20>
		if (*s == c)
  8011bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011c7:	75 05                	jne    8011ce <strchr+0x1d>
			return (char *) s;
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	eb 11                	jmp    8011df <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011ce:	ff 45 08             	incl   0x8(%ebp)
  8011d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d4:	8a 00                	mov    (%eax),%al
  8011d6:	84 c0                	test   %al,%al
  8011d8:	75 e5                	jne    8011bf <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011da:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011df:	c9                   	leave  
  8011e0:	c3                   	ret    

008011e1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011e1:	55                   	push   %ebp
  8011e2:	89 e5                	mov    %esp,%ebp
  8011e4:	83 ec 04             	sub    $0x4,%esp
  8011e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ea:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011ed:	eb 0d                	jmp    8011fc <strfind+0x1b>
		if (*s == c)
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011f7:	74 0e                	je     801207 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011f9:	ff 45 08             	incl   0x8(%ebp)
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	8a 00                	mov    (%eax),%al
  801201:	84 c0                	test   %al,%al
  801203:	75 ea                	jne    8011ef <strfind+0xe>
  801205:	eb 01                	jmp    801208 <strfind+0x27>
		if (*s == c)
			break;
  801207:	90                   	nop
	return (char *) s;
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80120b:	c9                   	leave  
  80120c:	c3                   	ret    

0080120d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80120d:	55                   	push   %ebp
  80120e:	89 e5                	mov    %esp,%ebp
  801210:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801219:	8b 45 10             	mov    0x10(%ebp),%eax
  80121c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80121f:	eb 0e                	jmp    80122f <memset+0x22>
		*p++ = c;
  801221:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801224:	8d 50 01             	lea    0x1(%eax),%edx
  801227:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80122a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80122d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80122f:	ff 4d f8             	decl   -0x8(%ebp)
  801232:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801236:	79 e9                	jns    801221 <memset+0x14>
		*p++ = c;

	return v;
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80123b:	c9                   	leave  
  80123c:	c3                   	ret    

0080123d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80123d:	55                   	push   %ebp
  80123e:	89 e5                	mov    %esp,%ebp
  801240:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801243:	8b 45 0c             	mov    0xc(%ebp),%eax
  801246:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80124f:	eb 16                	jmp    801267 <memcpy+0x2a>
		*d++ = *s++;
  801251:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801254:	8d 50 01             	lea    0x1(%eax),%edx
  801257:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80125a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80125d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801260:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801263:	8a 12                	mov    (%edx),%dl
  801265:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801267:	8b 45 10             	mov    0x10(%ebp),%eax
  80126a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80126d:	89 55 10             	mov    %edx,0x10(%ebp)
  801270:	85 c0                	test   %eax,%eax
  801272:	75 dd                	jne    801251 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801277:	c9                   	leave  
  801278:	c3                   	ret    

00801279 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
  80127c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80127f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801282:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
  801288:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80128b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80128e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801291:	73 50                	jae    8012e3 <memmove+0x6a>
  801293:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801296:	8b 45 10             	mov    0x10(%ebp),%eax
  801299:	01 d0                	add    %edx,%eax
  80129b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80129e:	76 43                	jbe    8012e3 <memmove+0x6a>
		s += n;
  8012a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012ac:	eb 10                	jmp    8012be <memmove+0x45>
			*--d = *--s;
  8012ae:	ff 4d f8             	decl   -0x8(%ebp)
  8012b1:	ff 4d fc             	decl   -0x4(%ebp)
  8012b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012b7:	8a 10                	mov    (%eax),%dl
  8012b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012bc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012be:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c4:	89 55 10             	mov    %edx,0x10(%ebp)
  8012c7:	85 c0                	test   %eax,%eax
  8012c9:	75 e3                	jne    8012ae <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012cb:	eb 23                	jmp    8012f0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d0:	8d 50 01             	lea    0x1(%eax),%edx
  8012d3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012dc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012df:	8a 12                	mov    (%edx),%dl
  8012e1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e9:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ec:	85 c0                	test   %eax,%eax
  8012ee:	75 dd                	jne    8012cd <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012f3:	c9                   	leave  
  8012f4:	c3                   	ret    

008012f5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012f5:	55                   	push   %ebp
  8012f6:	89 e5                	mov    %esp,%ebp
  8012f8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801301:	8b 45 0c             	mov    0xc(%ebp),%eax
  801304:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801307:	eb 2a                	jmp    801333 <memcmp+0x3e>
		if (*s1 != *s2)
  801309:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80130c:	8a 10                	mov    (%eax),%dl
  80130e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801311:	8a 00                	mov    (%eax),%al
  801313:	38 c2                	cmp    %al,%dl
  801315:	74 16                	je     80132d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801317:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131a:	8a 00                	mov    (%eax),%al
  80131c:	0f b6 d0             	movzbl %al,%edx
  80131f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801322:	8a 00                	mov    (%eax),%al
  801324:	0f b6 c0             	movzbl %al,%eax
  801327:	29 c2                	sub    %eax,%edx
  801329:	89 d0                	mov    %edx,%eax
  80132b:	eb 18                	jmp    801345 <memcmp+0x50>
		s1++, s2++;
  80132d:	ff 45 fc             	incl   -0x4(%ebp)
  801330:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801333:	8b 45 10             	mov    0x10(%ebp),%eax
  801336:	8d 50 ff             	lea    -0x1(%eax),%edx
  801339:	89 55 10             	mov    %edx,0x10(%ebp)
  80133c:	85 c0                	test   %eax,%eax
  80133e:	75 c9                	jne    801309 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801340:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801345:	c9                   	leave  
  801346:	c3                   	ret    

00801347 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801347:	55                   	push   %ebp
  801348:	89 e5                	mov    %esp,%ebp
  80134a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80134d:	8b 55 08             	mov    0x8(%ebp),%edx
  801350:	8b 45 10             	mov    0x10(%ebp),%eax
  801353:	01 d0                	add    %edx,%eax
  801355:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801358:	eb 15                	jmp    80136f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80135a:	8b 45 08             	mov    0x8(%ebp),%eax
  80135d:	8a 00                	mov    (%eax),%al
  80135f:	0f b6 d0             	movzbl %al,%edx
  801362:	8b 45 0c             	mov    0xc(%ebp),%eax
  801365:	0f b6 c0             	movzbl %al,%eax
  801368:	39 c2                	cmp    %eax,%edx
  80136a:	74 0d                	je     801379 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80136c:	ff 45 08             	incl   0x8(%ebp)
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801375:	72 e3                	jb     80135a <memfind+0x13>
  801377:	eb 01                	jmp    80137a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801379:	90                   	nop
	return (void *) s;
  80137a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
  801382:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801385:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80138c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801393:	eb 03                	jmp    801398 <strtol+0x19>
		s++;
  801395:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801398:	8b 45 08             	mov    0x8(%ebp),%eax
  80139b:	8a 00                	mov    (%eax),%al
  80139d:	3c 20                	cmp    $0x20,%al
  80139f:	74 f4                	je     801395 <strtol+0x16>
  8013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a4:	8a 00                	mov    (%eax),%al
  8013a6:	3c 09                	cmp    $0x9,%al
  8013a8:	74 eb                	je     801395 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ad:	8a 00                	mov    (%eax),%al
  8013af:	3c 2b                	cmp    $0x2b,%al
  8013b1:	75 05                	jne    8013b8 <strtol+0x39>
		s++;
  8013b3:	ff 45 08             	incl   0x8(%ebp)
  8013b6:	eb 13                	jmp    8013cb <strtol+0x4c>
	else if (*s == '-')
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	8a 00                	mov    (%eax),%al
  8013bd:	3c 2d                	cmp    $0x2d,%al
  8013bf:	75 0a                	jne    8013cb <strtol+0x4c>
		s++, neg = 1;
  8013c1:	ff 45 08             	incl   0x8(%ebp)
  8013c4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013cf:	74 06                	je     8013d7 <strtol+0x58>
  8013d1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013d5:	75 20                	jne    8013f7 <strtol+0x78>
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	8a 00                	mov    (%eax),%al
  8013dc:	3c 30                	cmp    $0x30,%al
  8013de:	75 17                	jne    8013f7 <strtol+0x78>
  8013e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e3:	40                   	inc    %eax
  8013e4:	8a 00                	mov    (%eax),%al
  8013e6:	3c 78                	cmp    $0x78,%al
  8013e8:	75 0d                	jne    8013f7 <strtol+0x78>
		s += 2, base = 16;
  8013ea:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013ee:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013f5:	eb 28                	jmp    80141f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013f7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013fb:	75 15                	jne    801412 <strtol+0x93>
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 00                	mov    (%eax),%al
  801402:	3c 30                	cmp    $0x30,%al
  801404:	75 0c                	jne    801412 <strtol+0x93>
		s++, base = 8;
  801406:	ff 45 08             	incl   0x8(%ebp)
  801409:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801410:	eb 0d                	jmp    80141f <strtol+0xa0>
	else if (base == 0)
  801412:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801416:	75 07                	jne    80141f <strtol+0xa0>
		base = 10;
  801418:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	3c 2f                	cmp    $0x2f,%al
  801426:	7e 19                	jle    801441 <strtol+0xc2>
  801428:	8b 45 08             	mov    0x8(%ebp),%eax
  80142b:	8a 00                	mov    (%eax),%al
  80142d:	3c 39                	cmp    $0x39,%al
  80142f:	7f 10                	jg     801441 <strtol+0xc2>
			dig = *s - '0';
  801431:	8b 45 08             	mov    0x8(%ebp),%eax
  801434:	8a 00                	mov    (%eax),%al
  801436:	0f be c0             	movsbl %al,%eax
  801439:	83 e8 30             	sub    $0x30,%eax
  80143c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80143f:	eb 42                	jmp    801483 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	8a 00                	mov    (%eax),%al
  801446:	3c 60                	cmp    $0x60,%al
  801448:	7e 19                	jle    801463 <strtol+0xe4>
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	8a 00                	mov    (%eax),%al
  80144f:	3c 7a                	cmp    $0x7a,%al
  801451:	7f 10                	jg     801463 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	8a 00                	mov    (%eax),%al
  801458:	0f be c0             	movsbl %al,%eax
  80145b:	83 e8 57             	sub    $0x57,%eax
  80145e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801461:	eb 20                	jmp    801483 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801463:	8b 45 08             	mov    0x8(%ebp),%eax
  801466:	8a 00                	mov    (%eax),%al
  801468:	3c 40                	cmp    $0x40,%al
  80146a:	7e 39                	jle    8014a5 <strtol+0x126>
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	8a 00                	mov    (%eax),%al
  801471:	3c 5a                	cmp    $0x5a,%al
  801473:	7f 30                	jg     8014a5 <strtol+0x126>
			dig = *s - 'A' + 10;
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
  801478:	8a 00                	mov    (%eax),%al
  80147a:	0f be c0             	movsbl %al,%eax
  80147d:	83 e8 37             	sub    $0x37,%eax
  801480:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801483:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801486:	3b 45 10             	cmp    0x10(%ebp),%eax
  801489:	7d 19                	jge    8014a4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80148b:	ff 45 08             	incl   0x8(%ebp)
  80148e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801491:	0f af 45 10          	imul   0x10(%ebp),%eax
  801495:	89 c2                	mov    %eax,%edx
  801497:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80149a:	01 d0                	add    %edx,%eax
  80149c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80149f:	e9 7b ff ff ff       	jmp    80141f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014a4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014a5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014a9:	74 08                	je     8014b3 <strtol+0x134>
		*endptr = (char *) s;
  8014ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ae:	8b 55 08             	mov    0x8(%ebp),%edx
  8014b1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014b3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014b7:	74 07                	je     8014c0 <strtol+0x141>
  8014b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014bc:	f7 d8                	neg    %eax
  8014be:	eb 03                	jmp    8014c3 <strtol+0x144>
  8014c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <ltostr>:

void
ltostr(long value, char *str)
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
  8014c8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014d2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014d9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014dd:	79 13                	jns    8014f2 <ltostr+0x2d>
	{
		neg = 1;
  8014df:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014ec:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014ef:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014fa:	99                   	cltd   
  8014fb:	f7 f9                	idiv   %ecx
  8014fd:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801500:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801503:	8d 50 01             	lea    0x1(%eax),%edx
  801506:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801509:	89 c2                	mov    %eax,%edx
  80150b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150e:	01 d0                	add    %edx,%eax
  801510:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801513:	83 c2 30             	add    $0x30,%edx
  801516:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801518:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80151b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801520:	f7 e9                	imul   %ecx
  801522:	c1 fa 02             	sar    $0x2,%edx
  801525:	89 c8                	mov    %ecx,%eax
  801527:	c1 f8 1f             	sar    $0x1f,%eax
  80152a:	29 c2                	sub    %eax,%edx
  80152c:	89 d0                	mov    %edx,%eax
  80152e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801531:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801534:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801539:	f7 e9                	imul   %ecx
  80153b:	c1 fa 02             	sar    $0x2,%edx
  80153e:	89 c8                	mov    %ecx,%eax
  801540:	c1 f8 1f             	sar    $0x1f,%eax
  801543:	29 c2                	sub    %eax,%edx
  801545:	89 d0                	mov    %edx,%eax
  801547:	c1 e0 02             	shl    $0x2,%eax
  80154a:	01 d0                	add    %edx,%eax
  80154c:	01 c0                	add    %eax,%eax
  80154e:	29 c1                	sub    %eax,%ecx
  801550:	89 ca                	mov    %ecx,%edx
  801552:	85 d2                	test   %edx,%edx
  801554:	75 9c                	jne    8014f2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801556:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80155d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801560:	48                   	dec    %eax
  801561:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801564:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801568:	74 3d                	je     8015a7 <ltostr+0xe2>
		start = 1 ;
  80156a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801571:	eb 34                	jmp    8015a7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801573:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801576:	8b 45 0c             	mov    0xc(%ebp),%eax
  801579:	01 d0                	add    %edx,%eax
  80157b:	8a 00                	mov    (%eax),%al
  80157d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801580:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801583:	8b 45 0c             	mov    0xc(%ebp),%eax
  801586:	01 c2                	add    %eax,%edx
  801588:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80158b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158e:	01 c8                	add    %ecx,%eax
  801590:	8a 00                	mov    (%eax),%al
  801592:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801594:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801597:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159a:	01 c2                	add    %eax,%edx
  80159c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80159f:	88 02                	mov    %al,(%edx)
		start++ ;
  8015a1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015a4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015ad:	7c c4                	jl     801573 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015af:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b5:	01 d0                	add    %edx,%eax
  8015b7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015ba:	90                   	nop
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
  8015c0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015c3:	ff 75 08             	pushl  0x8(%ebp)
  8015c6:	e8 54 fa ff ff       	call   80101f <strlen>
  8015cb:	83 c4 04             	add    $0x4,%esp
  8015ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015d1:	ff 75 0c             	pushl  0xc(%ebp)
  8015d4:	e8 46 fa ff ff       	call   80101f <strlen>
  8015d9:	83 c4 04             	add    $0x4,%esp
  8015dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015ed:	eb 17                	jmp    801606 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f5:	01 c2                	add    %eax,%edx
  8015f7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	01 c8                	add    %ecx,%eax
  8015ff:	8a 00                	mov    (%eax),%al
  801601:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801603:	ff 45 fc             	incl   -0x4(%ebp)
  801606:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801609:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80160c:	7c e1                	jl     8015ef <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80160e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801615:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80161c:	eb 1f                	jmp    80163d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80161e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801621:	8d 50 01             	lea    0x1(%eax),%edx
  801624:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801627:	89 c2                	mov    %eax,%edx
  801629:	8b 45 10             	mov    0x10(%ebp),%eax
  80162c:	01 c2                	add    %eax,%edx
  80162e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801631:	8b 45 0c             	mov    0xc(%ebp),%eax
  801634:	01 c8                	add    %ecx,%eax
  801636:	8a 00                	mov    (%eax),%al
  801638:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80163a:	ff 45 f8             	incl   -0x8(%ebp)
  80163d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801640:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801643:	7c d9                	jl     80161e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801645:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801648:	8b 45 10             	mov    0x10(%ebp),%eax
  80164b:	01 d0                	add    %edx,%eax
  80164d:	c6 00 00             	movb   $0x0,(%eax)
}
  801650:	90                   	nop
  801651:	c9                   	leave  
  801652:	c3                   	ret    

00801653 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801653:	55                   	push   %ebp
  801654:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801656:	8b 45 14             	mov    0x14(%ebp),%eax
  801659:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80165f:	8b 45 14             	mov    0x14(%ebp),%eax
  801662:	8b 00                	mov    (%eax),%eax
  801664:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80166b:	8b 45 10             	mov    0x10(%ebp),%eax
  80166e:	01 d0                	add    %edx,%eax
  801670:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801676:	eb 0c                	jmp    801684 <strsplit+0x31>
			*string++ = 0;
  801678:	8b 45 08             	mov    0x8(%ebp),%eax
  80167b:	8d 50 01             	lea    0x1(%eax),%edx
  80167e:	89 55 08             	mov    %edx,0x8(%ebp)
  801681:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801684:	8b 45 08             	mov    0x8(%ebp),%eax
  801687:	8a 00                	mov    (%eax),%al
  801689:	84 c0                	test   %al,%al
  80168b:	74 18                	je     8016a5 <strsplit+0x52>
  80168d:	8b 45 08             	mov    0x8(%ebp),%eax
  801690:	8a 00                	mov    (%eax),%al
  801692:	0f be c0             	movsbl %al,%eax
  801695:	50                   	push   %eax
  801696:	ff 75 0c             	pushl  0xc(%ebp)
  801699:	e8 13 fb ff ff       	call   8011b1 <strchr>
  80169e:	83 c4 08             	add    $0x8,%esp
  8016a1:	85 c0                	test   %eax,%eax
  8016a3:	75 d3                	jne    801678 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8016a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a8:	8a 00                	mov    (%eax),%al
  8016aa:	84 c0                	test   %al,%al
  8016ac:	74 5a                	je     801708 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8016ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8016b1:	8b 00                	mov    (%eax),%eax
  8016b3:	83 f8 0f             	cmp    $0xf,%eax
  8016b6:	75 07                	jne    8016bf <strsplit+0x6c>
		{
			return 0;
  8016b8:	b8 00 00 00 00       	mov    $0x0,%eax
  8016bd:	eb 66                	jmp    801725 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8016c2:	8b 00                	mov    (%eax),%eax
  8016c4:	8d 48 01             	lea    0x1(%eax),%ecx
  8016c7:	8b 55 14             	mov    0x14(%ebp),%edx
  8016ca:	89 0a                	mov    %ecx,(%edx)
  8016cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d6:	01 c2                	add    %eax,%edx
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016dd:	eb 03                	jmp    8016e2 <strsplit+0x8f>
			string++;
  8016df:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e5:	8a 00                	mov    (%eax),%al
  8016e7:	84 c0                	test   %al,%al
  8016e9:	74 8b                	je     801676 <strsplit+0x23>
  8016eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ee:	8a 00                	mov    (%eax),%al
  8016f0:	0f be c0             	movsbl %al,%eax
  8016f3:	50                   	push   %eax
  8016f4:	ff 75 0c             	pushl  0xc(%ebp)
  8016f7:	e8 b5 fa ff ff       	call   8011b1 <strchr>
  8016fc:	83 c4 08             	add    $0x8,%esp
  8016ff:	85 c0                	test   %eax,%eax
  801701:	74 dc                	je     8016df <strsplit+0x8c>
			string++;
	}
  801703:	e9 6e ff ff ff       	jmp    801676 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801708:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801709:	8b 45 14             	mov    0x14(%ebp),%eax
  80170c:	8b 00                	mov    (%eax),%eax
  80170e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801715:	8b 45 10             	mov    0x10(%ebp),%eax
  801718:	01 d0                	add    %edx,%eax
  80171a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801720:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801725:	c9                   	leave  
  801726:	c3                   	ret    

00801727 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801727:	55                   	push   %ebp
  801728:	89 e5                	mov    %esp,%ebp
  80172a:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  80172d:	e8 9b 07 00 00       	call   801ecd <sys_isUHeapPlacementStrategyNEXTFIT>
  801732:	85 c0                	test   %eax,%eax
  801734:	0f 84 64 01 00 00    	je     80189e <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  80173a:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  801740:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801747:	8b 55 08             	mov    0x8(%ebp),%edx
  80174a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80174d:	01 d0                	add    %edx,%eax
  80174f:	48                   	dec    %eax
  801750:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801753:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801756:	ba 00 00 00 00       	mov    $0x0,%edx
  80175b:	f7 75 e8             	divl   -0x18(%ebp)
  80175e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801761:	29 d0                	sub    %edx,%eax
  801763:	89 04 cd 84 30 d8 00 	mov    %eax,0xd83084(,%ecx,8)
		uint32 maxSize = startAdd+size;
  80176a:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801770:	8b 45 08             	mov    0x8(%ebp),%eax
  801773:	01 d0                	add    %edx,%eax
  801775:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801778:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  80177f:	a1 28 30 80 00       	mov    0x803028,%eax
  801784:	8b 04 c5 84 30 d8 00 	mov    0xd83084(,%eax,8),%eax
  80178b:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80178e:	0f 83 0a 01 00 00    	jae    80189e <malloc+0x177>
  801794:	a1 28 30 80 00       	mov    0x803028,%eax
  801799:	8b 04 c5 84 30 d8 00 	mov    0xd83084(,%eax,8),%eax
  8017a0:	85 c0                	test   %eax,%eax
  8017a2:	0f 84 f6 00 00 00    	je     80189e <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8017a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017af:	e9 dc 00 00 00       	jmp    801890 <malloc+0x169>
				flag++;
  8017b4:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  8017b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017ba:	8b 04 85 80 30 d0 00 	mov    0xd03080(,%eax,4),%eax
  8017c1:	85 c0                	test   %eax,%eax
  8017c3:	74 07                	je     8017cc <malloc+0xa5>
					flag=0;
  8017c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  8017cc:	a1 28 30 80 00       	mov    0x803028,%eax
  8017d1:	8b 04 c5 84 30 d8 00 	mov    0xd83084(,%eax,8),%eax
  8017d8:	85 c0                	test   %eax,%eax
  8017da:	79 05                	jns    8017e1 <malloc+0xba>
  8017dc:	05 ff 0f 00 00       	add    $0xfff,%eax
  8017e1:	c1 f8 0c             	sar    $0xc,%eax
  8017e4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8017e7:	0f 85 a0 00 00 00    	jne    80188d <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  8017ed:	a1 28 30 80 00       	mov    0x803028,%eax
  8017f2:	8b 04 c5 84 30 d8 00 	mov    0xd83084(,%eax,8),%eax
  8017f9:	85 c0                	test   %eax,%eax
  8017fb:	79 05                	jns    801802 <malloc+0xdb>
  8017fd:	05 ff 0f 00 00       	add    $0xfff,%eax
  801802:	c1 f8 0c             	sar    $0xc,%eax
  801805:	89 c2                	mov    %eax,%edx
  801807:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80180a:	29 d0                	sub    %edx,%eax
  80180c:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  80180f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801812:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801815:	eb 11                	jmp    801828 <malloc+0x101>
						hFreeArr[j] = 1;
  801817:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80181a:	c7 04 85 80 30 d0 00 	movl   $0x1,0xd03080(,%eax,4)
  801821:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801825:	ff 45 ec             	incl   -0x14(%ebp)
  801828:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80182b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80182e:	7e e7                	jle    801817 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801830:	a1 28 30 80 00       	mov    0x803028,%eax
  801835:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801838:	81 c2 01 00 08 00    	add    $0x80001,%edx
  80183e:	c1 e2 0c             	shl    $0xc,%edx
  801841:	89 15 04 30 80 00    	mov    %edx,0x803004
  801847:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80184d:	89 14 c5 80 30 d8 00 	mov    %edx,0xd83080(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801854:	a1 28 30 80 00       	mov    0x803028,%eax
  801859:	8b 04 c5 84 30 d8 00 	mov    0xd83084(,%eax,8),%eax
  801860:	89 c2                	mov    %eax,%edx
  801862:	a1 28 30 80 00       	mov    0x803028,%eax
  801867:	8b 04 c5 80 30 d8 00 	mov    0xd83080(,%eax,8),%eax
  80186e:	83 ec 08             	sub    $0x8,%esp
  801871:	52                   	push   %edx
  801872:	50                   	push   %eax
  801873:	e8 8b 02 00 00       	call   801b03 <sys_allocateMem>
  801878:	83 c4 10             	add    $0x10,%esp

					idx++;
  80187b:	a1 28 30 80 00       	mov    0x803028,%eax
  801880:	40                   	inc    %eax
  801881:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  801886:	a1 04 30 80 00       	mov    0x803004,%eax
  80188b:	eb 16                	jmp    8018a3 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  80188d:	ff 45 f0             	incl   -0x10(%ebp)
  801890:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801893:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801898:	0f 86 16 ff ff ff    	jbe    8017b4 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  80189e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018a3:	c9                   	leave  
  8018a4:	c3                   	ret    

008018a5 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8018a5:	55                   	push   %ebp
  8018a6:	89 e5                	mov    %esp,%ebp
  8018a8:	83 ec 18             	sub    $0x18,%esp
  8018ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ae:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8018b1:	83 ec 04             	sub    $0x4,%esp
  8018b4:	68 b0 29 80 00       	push   $0x8029b0
  8018b9:	6a 59                	push   $0x59
  8018bb:	68 cf 29 80 00       	push   $0x8029cf
  8018c0:	e8 24 ee ff ff       	call   8006e9 <_panic>

008018c5 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
  8018c8:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8018cb:	83 ec 04             	sub    $0x4,%esp
  8018ce:	68 db 29 80 00       	push   $0x8029db
  8018d3:	6a 5f                	push   $0x5f
  8018d5:	68 cf 29 80 00       	push   $0x8029cf
  8018da:	e8 0a ee ff ff       	call   8006e9 <_panic>

008018df <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
  8018e2:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8018e5:	83 ec 04             	sub    $0x4,%esp
  8018e8:	68 f8 29 80 00       	push   $0x8029f8
  8018ed:	6a 70                	push   $0x70
  8018ef:	68 cf 29 80 00       	push   $0x8029cf
  8018f4:	e8 f0 ed ff ff       	call   8006e9 <_panic>

008018f9 <sfree>:

}


void sfree(void* virtual_address)
{
  8018f9:	55                   	push   %ebp
  8018fa:	89 e5                	mov    %esp,%ebp
  8018fc:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8018ff:	83 ec 04             	sub    $0x4,%esp
  801902:	68 1b 2a 80 00       	push   $0x802a1b
  801907:	6a 7b                	push   $0x7b
  801909:	68 cf 29 80 00       	push   $0x8029cf
  80190e:	e8 d6 ed ff ff       	call   8006e9 <_panic>

00801913 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801913:	55                   	push   %ebp
  801914:	89 e5                	mov    %esp,%ebp
  801916:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801919:	83 ec 04             	sub    $0x4,%esp
  80191c:	68 38 2a 80 00       	push   $0x802a38
  801921:	68 93 00 00 00       	push   $0x93
  801926:	68 cf 29 80 00       	push   $0x8029cf
  80192b:	e8 b9 ed ff ff       	call   8006e9 <_panic>

00801930 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801930:	55                   	push   %ebp
  801931:	89 e5                	mov    %esp,%ebp
  801933:	57                   	push   %edi
  801934:	56                   	push   %esi
  801935:	53                   	push   %ebx
  801936:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80193f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801942:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801945:	8b 7d 18             	mov    0x18(%ebp),%edi
  801948:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80194b:	cd 30                	int    $0x30
  80194d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801950:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801953:	83 c4 10             	add    $0x10,%esp
  801956:	5b                   	pop    %ebx
  801957:	5e                   	pop    %esi
  801958:	5f                   	pop    %edi
  801959:	5d                   	pop    %ebp
  80195a:	c3                   	ret    

0080195b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
  80195e:	83 ec 04             	sub    $0x4,%esp
  801961:	8b 45 10             	mov    0x10(%ebp),%eax
  801964:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801967:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	52                   	push   %edx
  801973:	ff 75 0c             	pushl  0xc(%ebp)
  801976:	50                   	push   %eax
  801977:	6a 00                	push   $0x0
  801979:	e8 b2 ff ff ff       	call   801930 <syscall>
  80197e:	83 c4 18             	add    $0x18,%esp
}
  801981:	90                   	nop
  801982:	c9                   	leave  
  801983:	c3                   	ret    

00801984 <sys_cgetc>:

int
sys_cgetc(void)
{
  801984:	55                   	push   %ebp
  801985:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 01                	push   $0x1
  801993:	e8 98 ff ff ff       	call   801930 <syscall>
  801998:	83 c4 18             	add    $0x18,%esp
}
  80199b:	c9                   	leave  
  80199c:	c3                   	ret    

0080199d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80199d:	55                   	push   %ebp
  80199e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8019a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	50                   	push   %eax
  8019ac:	6a 05                	push   $0x5
  8019ae:	e8 7d ff ff ff       	call   801930 <syscall>
  8019b3:	83 c4 18             	add    $0x18,%esp
}
  8019b6:	c9                   	leave  
  8019b7:	c3                   	ret    

008019b8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8019b8:	55                   	push   %ebp
  8019b9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 02                	push   $0x2
  8019c7:	e8 64 ff ff ff       	call   801930 <syscall>
  8019cc:	83 c4 18             	add    $0x18,%esp
}
  8019cf:	c9                   	leave  
  8019d0:	c3                   	ret    

008019d1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019d1:	55                   	push   %ebp
  8019d2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 03                	push   $0x3
  8019e0:	e8 4b ff ff ff       	call   801930 <syscall>
  8019e5:	83 c4 18             	add    $0x18,%esp
}
  8019e8:	c9                   	leave  
  8019e9:	c3                   	ret    

008019ea <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019ea:	55                   	push   %ebp
  8019eb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 04                	push   $0x4
  8019f9:	e8 32 ff ff ff       	call   801930 <syscall>
  8019fe:	83 c4 18             	add    $0x18,%esp
}
  801a01:	c9                   	leave  
  801a02:	c3                   	ret    

00801a03 <sys_env_exit>:


void sys_env_exit(void)
{
  801a03:	55                   	push   %ebp
  801a04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 06                	push   $0x6
  801a12:	e8 19 ff ff ff       	call   801930 <syscall>
  801a17:	83 c4 18             	add    $0x18,%esp
}
  801a1a:	90                   	nop
  801a1b:	c9                   	leave  
  801a1c:	c3                   	ret    

00801a1d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801a1d:	55                   	push   %ebp
  801a1e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a20:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a23:	8b 45 08             	mov    0x8(%ebp),%eax
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	52                   	push   %edx
  801a2d:	50                   	push   %eax
  801a2e:	6a 07                	push   $0x7
  801a30:	e8 fb fe ff ff       	call   801930 <syscall>
  801a35:	83 c4 18             	add    $0x18,%esp
}
  801a38:	c9                   	leave  
  801a39:	c3                   	ret    

00801a3a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a3a:	55                   	push   %ebp
  801a3b:	89 e5                	mov    %esp,%ebp
  801a3d:	56                   	push   %esi
  801a3e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801a3f:	8b 75 18             	mov    0x18(%ebp),%esi
  801a42:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a45:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4e:	56                   	push   %esi
  801a4f:	53                   	push   %ebx
  801a50:	51                   	push   %ecx
  801a51:	52                   	push   %edx
  801a52:	50                   	push   %eax
  801a53:	6a 08                	push   $0x8
  801a55:	e8 d6 fe ff ff       	call   801930 <syscall>
  801a5a:	83 c4 18             	add    $0x18,%esp
}
  801a5d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801a60:	5b                   	pop    %ebx
  801a61:	5e                   	pop    %esi
  801a62:	5d                   	pop    %ebp
  801a63:	c3                   	ret    

00801a64 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801a67:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	52                   	push   %edx
  801a74:	50                   	push   %eax
  801a75:	6a 09                	push   $0x9
  801a77:	e8 b4 fe ff ff       	call   801930 <syscall>
  801a7c:	83 c4 18             	add    $0x18,%esp
}
  801a7f:	c9                   	leave  
  801a80:	c3                   	ret    

00801a81 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801a81:	55                   	push   %ebp
  801a82:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	ff 75 0c             	pushl  0xc(%ebp)
  801a8d:	ff 75 08             	pushl  0x8(%ebp)
  801a90:	6a 0a                	push   $0xa
  801a92:	e8 99 fe ff ff       	call   801930 <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
}
  801a9a:	c9                   	leave  
  801a9b:	c3                   	ret    

00801a9c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 0b                	push   $0xb
  801aab:	e8 80 fe ff ff       	call   801930 <syscall>
  801ab0:	83 c4 18             	add    $0x18,%esp
}
  801ab3:	c9                   	leave  
  801ab4:	c3                   	ret    

00801ab5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ab5:	55                   	push   %ebp
  801ab6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 0c                	push   $0xc
  801ac4:	e8 67 fe ff ff       	call   801930 <syscall>
  801ac9:	83 c4 18             	add    $0x18,%esp
}
  801acc:	c9                   	leave  
  801acd:	c3                   	ret    

00801ace <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ace:	55                   	push   %ebp
  801acf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 0d                	push   $0xd
  801add:	e8 4e fe ff ff       	call   801930 <syscall>
  801ae2:	83 c4 18             	add    $0x18,%esp
}
  801ae5:	c9                   	leave  
  801ae6:	c3                   	ret    

00801ae7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ae7:	55                   	push   %ebp
  801ae8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	ff 75 0c             	pushl  0xc(%ebp)
  801af3:	ff 75 08             	pushl  0x8(%ebp)
  801af6:	6a 11                	push   $0x11
  801af8:	e8 33 fe ff ff       	call   801930 <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
	return;
  801b00:	90                   	nop
}
  801b01:	c9                   	leave  
  801b02:	c3                   	ret    

00801b03 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801b03:	55                   	push   %ebp
  801b04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	ff 75 0c             	pushl  0xc(%ebp)
  801b0f:	ff 75 08             	pushl  0x8(%ebp)
  801b12:	6a 12                	push   $0x12
  801b14:	e8 17 fe ff ff       	call   801930 <syscall>
  801b19:	83 c4 18             	add    $0x18,%esp
	return ;
  801b1c:	90                   	nop
}
  801b1d:	c9                   	leave  
  801b1e:	c3                   	ret    

00801b1f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b1f:	55                   	push   %ebp
  801b20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 0e                	push   $0xe
  801b2e:	e8 fd fd ff ff       	call   801930 <syscall>
  801b33:	83 c4 18             	add    $0x18,%esp
}
  801b36:	c9                   	leave  
  801b37:	c3                   	ret    

00801b38 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b38:	55                   	push   %ebp
  801b39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	ff 75 08             	pushl  0x8(%ebp)
  801b46:	6a 0f                	push   $0xf
  801b48:	e8 e3 fd ff ff       	call   801930 <syscall>
  801b4d:	83 c4 18             	add    $0x18,%esp
}
  801b50:	c9                   	leave  
  801b51:	c3                   	ret    

00801b52 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801b52:	55                   	push   %ebp
  801b53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 10                	push   $0x10
  801b61:	e8 ca fd ff ff       	call   801930 <syscall>
  801b66:	83 c4 18             	add    $0x18,%esp
}
  801b69:	90                   	nop
  801b6a:	c9                   	leave  
  801b6b:	c3                   	ret    

00801b6c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801b6c:	55                   	push   %ebp
  801b6d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 14                	push   $0x14
  801b7b:	e8 b0 fd ff ff       	call   801930 <syscall>
  801b80:	83 c4 18             	add    $0x18,%esp
}
  801b83:	90                   	nop
  801b84:	c9                   	leave  
  801b85:	c3                   	ret    

00801b86 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801b86:	55                   	push   %ebp
  801b87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 15                	push   $0x15
  801b95:	e8 96 fd ff ff       	call   801930 <syscall>
  801b9a:	83 c4 18             	add    $0x18,%esp
}
  801b9d:	90                   	nop
  801b9e:	c9                   	leave  
  801b9f:	c3                   	ret    

00801ba0 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ba0:	55                   	push   %ebp
  801ba1:	89 e5                	mov    %esp,%ebp
  801ba3:	83 ec 04             	sub    $0x4,%esp
  801ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801bac:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	50                   	push   %eax
  801bb9:	6a 16                	push   $0x16
  801bbb:	e8 70 fd ff ff       	call   801930 <syscall>
  801bc0:	83 c4 18             	add    $0x18,%esp
}
  801bc3:	90                   	nop
  801bc4:	c9                   	leave  
  801bc5:	c3                   	ret    

00801bc6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801bc6:	55                   	push   %ebp
  801bc7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 17                	push   $0x17
  801bd5:	e8 56 fd ff ff       	call   801930 <syscall>
  801bda:	83 c4 18             	add    $0x18,%esp
}
  801bdd:	90                   	nop
  801bde:	c9                   	leave  
  801bdf:	c3                   	ret    

00801be0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801be0:	55                   	push   %ebp
  801be1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801be3:	8b 45 08             	mov    0x8(%ebp),%eax
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	ff 75 0c             	pushl  0xc(%ebp)
  801bef:	50                   	push   %eax
  801bf0:	6a 18                	push   $0x18
  801bf2:	e8 39 fd ff ff       	call   801930 <syscall>
  801bf7:	83 c4 18             	add    $0x18,%esp
}
  801bfa:	c9                   	leave  
  801bfb:	c3                   	ret    

00801bfc <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801bfc:	55                   	push   %ebp
  801bfd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801bff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c02:	8b 45 08             	mov    0x8(%ebp),%eax
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	52                   	push   %edx
  801c0c:	50                   	push   %eax
  801c0d:	6a 1b                	push   $0x1b
  801c0f:	e8 1c fd ff ff       	call   801930 <syscall>
  801c14:	83 c4 18             	add    $0x18,%esp
}
  801c17:	c9                   	leave  
  801c18:	c3                   	ret    

00801c19 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c19:	55                   	push   %ebp
  801c1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c22:	6a 00                	push   $0x0
  801c24:	6a 00                	push   $0x0
  801c26:	6a 00                	push   $0x0
  801c28:	52                   	push   %edx
  801c29:	50                   	push   %eax
  801c2a:	6a 19                	push   $0x19
  801c2c:	e8 ff fc ff ff       	call   801930 <syscall>
  801c31:	83 c4 18             	add    $0x18,%esp
}
  801c34:	90                   	nop
  801c35:	c9                   	leave  
  801c36:	c3                   	ret    

00801c37 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c37:	55                   	push   %ebp
  801c38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	52                   	push   %edx
  801c47:	50                   	push   %eax
  801c48:	6a 1a                	push   $0x1a
  801c4a:	e8 e1 fc ff ff       	call   801930 <syscall>
  801c4f:	83 c4 18             	add    $0x18,%esp
}
  801c52:	90                   	nop
  801c53:	c9                   	leave  
  801c54:	c3                   	ret    

00801c55 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801c55:	55                   	push   %ebp
  801c56:	89 e5                	mov    %esp,%ebp
  801c58:	83 ec 04             	sub    $0x4,%esp
  801c5b:	8b 45 10             	mov    0x10(%ebp),%eax
  801c5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801c61:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c64:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c68:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6b:	6a 00                	push   $0x0
  801c6d:	51                   	push   %ecx
  801c6e:	52                   	push   %edx
  801c6f:	ff 75 0c             	pushl  0xc(%ebp)
  801c72:	50                   	push   %eax
  801c73:	6a 1c                	push   $0x1c
  801c75:	e8 b6 fc ff ff       	call   801930 <syscall>
  801c7a:	83 c4 18             	add    $0x18,%esp
}
  801c7d:	c9                   	leave  
  801c7e:	c3                   	ret    

00801c7f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801c7f:	55                   	push   %ebp
  801c80:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801c82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c85:	8b 45 08             	mov    0x8(%ebp),%eax
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	52                   	push   %edx
  801c8f:	50                   	push   %eax
  801c90:	6a 1d                	push   $0x1d
  801c92:	e8 99 fc ff ff       	call   801930 <syscall>
  801c97:	83 c4 18             	add    $0x18,%esp
}
  801c9a:	c9                   	leave  
  801c9b:	c3                   	ret    

00801c9c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c9c:	55                   	push   %ebp
  801c9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c9f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ca2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	51                   	push   %ecx
  801cad:	52                   	push   %edx
  801cae:	50                   	push   %eax
  801caf:	6a 1e                	push   $0x1e
  801cb1:	e8 7a fc ff ff       	call   801930 <syscall>
  801cb6:	83 c4 18             	add    $0x18,%esp
}
  801cb9:	c9                   	leave  
  801cba:	c3                   	ret    

00801cbb <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801cbb:	55                   	push   %ebp
  801cbc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801cbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	52                   	push   %edx
  801ccb:	50                   	push   %eax
  801ccc:	6a 1f                	push   $0x1f
  801cce:	e8 5d fc ff ff       	call   801930 <syscall>
  801cd3:	83 c4 18             	add    $0x18,%esp
}
  801cd6:	c9                   	leave  
  801cd7:	c3                   	ret    

00801cd8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801cd8:	55                   	push   %ebp
  801cd9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 20                	push   $0x20
  801ce7:	e8 44 fc ff ff       	call   801930 <syscall>
  801cec:	83 c4 18             	add    $0x18,%esp
}
  801cef:	c9                   	leave  
  801cf0:	c3                   	ret    

00801cf1 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801cf1:	55                   	push   %ebp
  801cf2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801cf4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	ff 75 10             	pushl  0x10(%ebp)
  801cfe:	ff 75 0c             	pushl  0xc(%ebp)
  801d01:	50                   	push   %eax
  801d02:	6a 21                	push   $0x21
  801d04:	e8 27 fc ff ff       	call   801930 <syscall>
  801d09:	83 c4 18             	add    $0x18,%esp
}
  801d0c:	c9                   	leave  
  801d0d:	c3                   	ret    

00801d0e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801d0e:	55                   	push   %ebp
  801d0f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801d11:	8b 45 08             	mov    0x8(%ebp),%eax
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	50                   	push   %eax
  801d1d:	6a 22                	push   $0x22
  801d1f:	e8 0c fc ff ff       	call   801930 <syscall>
  801d24:	83 c4 18             	add    $0x18,%esp
}
  801d27:	90                   	nop
  801d28:	c9                   	leave  
  801d29:	c3                   	ret    

00801d2a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801d2a:	55                   	push   %ebp
  801d2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	50                   	push   %eax
  801d39:	6a 23                	push   $0x23
  801d3b:	e8 f0 fb ff ff       	call   801930 <syscall>
  801d40:	83 c4 18             	add    $0x18,%esp
}
  801d43:	90                   	nop
  801d44:	c9                   	leave  
  801d45:	c3                   	ret    

00801d46 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801d46:	55                   	push   %ebp
  801d47:	89 e5                	mov    %esp,%ebp
  801d49:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801d4c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d4f:	8d 50 04             	lea    0x4(%eax),%edx
  801d52:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	52                   	push   %edx
  801d5c:	50                   	push   %eax
  801d5d:	6a 24                	push   $0x24
  801d5f:	e8 cc fb ff ff       	call   801930 <syscall>
  801d64:	83 c4 18             	add    $0x18,%esp
	return result;
  801d67:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d6d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d70:	89 01                	mov    %eax,(%ecx)
  801d72:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801d75:	8b 45 08             	mov    0x8(%ebp),%eax
  801d78:	c9                   	leave  
  801d79:	c2 04 00             	ret    $0x4

00801d7c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d7c:	55                   	push   %ebp
  801d7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	ff 75 10             	pushl  0x10(%ebp)
  801d86:	ff 75 0c             	pushl  0xc(%ebp)
  801d89:	ff 75 08             	pushl  0x8(%ebp)
  801d8c:	6a 13                	push   $0x13
  801d8e:	e8 9d fb ff ff       	call   801930 <syscall>
  801d93:	83 c4 18             	add    $0x18,%esp
	return ;
  801d96:	90                   	nop
}
  801d97:	c9                   	leave  
  801d98:	c3                   	ret    

00801d99 <sys_rcr2>:
uint32 sys_rcr2()
{
  801d99:	55                   	push   %ebp
  801d9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 25                	push   $0x25
  801da8:	e8 83 fb ff ff       	call   801930 <syscall>
  801dad:	83 c4 18             	add    $0x18,%esp
}
  801db0:	c9                   	leave  
  801db1:	c3                   	ret    

00801db2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801db2:	55                   	push   %ebp
  801db3:	89 e5                	mov    %esp,%ebp
  801db5:	83 ec 04             	sub    $0x4,%esp
  801db8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801dbe:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	50                   	push   %eax
  801dcb:	6a 26                	push   $0x26
  801dcd:	e8 5e fb ff ff       	call   801930 <syscall>
  801dd2:	83 c4 18             	add    $0x18,%esp
	return ;
  801dd5:	90                   	nop
}
  801dd6:	c9                   	leave  
  801dd7:	c3                   	ret    

00801dd8 <rsttst>:
void rsttst()
{
  801dd8:	55                   	push   %ebp
  801dd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 28                	push   $0x28
  801de7:	e8 44 fb ff ff       	call   801930 <syscall>
  801dec:	83 c4 18             	add    $0x18,%esp
	return ;
  801def:	90                   	nop
}
  801df0:	c9                   	leave  
  801df1:	c3                   	ret    

00801df2 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801df2:	55                   	push   %ebp
  801df3:	89 e5                	mov    %esp,%ebp
  801df5:	83 ec 04             	sub    $0x4,%esp
  801df8:	8b 45 14             	mov    0x14(%ebp),%eax
  801dfb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801dfe:	8b 55 18             	mov    0x18(%ebp),%edx
  801e01:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e05:	52                   	push   %edx
  801e06:	50                   	push   %eax
  801e07:	ff 75 10             	pushl  0x10(%ebp)
  801e0a:	ff 75 0c             	pushl  0xc(%ebp)
  801e0d:	ff 75 08             	pushl  0x8(%ebp)
  801e10:	6a 27                	push   $0x27
  801e12:	e8 19 fb ff ff       	call   801930 <syscall>
  801e17:	83 c4 18             	add    $0x18,%esp
	return ;
  801e1a:	90                   	nop
}
  801e1b:	c9                   	leave  
  801e1c:	c3                   	ret    

00801e1d <chktst>:
void chktst(uint32 n)
{
  801e1d:	55                   	push   %ebp
  801e1e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	ff 75 08             	pushl  0x8(%ebp)
  801e2b:	6a 29                	push   $0x29
  801e2d:	e8 fe fa ff ff       	call   801930 <syscall>
  801e32:	83 c4 18             	add    $0x18,%esp
	return ;
  801e35:	90                   	nop
}
  801e36:	c9                   	leave  
  801e37:	c3                   	ret    

00801e38 <inctst>:

void inctst()
{
  801e38:	55                   	push   %ebp
  801e39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 2a                	push   $0x2a
  801e47:	e8 e4 fa ff ff       	call   801930 <syscall>
  801e4c:	83 c4 18             	add    $0x18,%esp
	return ;
  801e4f:	90                   	nop
}
  801e50:	c9                   	leave  
  801e51:	c3                   	ret    

00801e52 <gettst>:
uint32 gettst()
{
  801e52:	55                   	push   %ebp
  801e53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 2b                	push   $0x2b
  801e61:	e8 ca fa ff ff       	call   801930 <syscall>
  801e66:	83 c4 18             	add    $0x18,%esp
}
  801e69:	c9                   	leave  
  801e6a:	c3                   	ret    

00801e6b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801e6b:	55                   	push   %ebp
  801e6c:	89 e5                	mov    %esp,%ebp
  801e6e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e71:	6a 00                	push   $0x0
  801e73:	6a 00                	push   $0x0
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 2c                	push   $0x2c
  801e7d:	e8 ae fa ff ff       	call   801930 <syscall>
  801e82:	83 c4 18             	add    $0x18,%esp
  801e85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801e88:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801e8c:	75 07                	jne    801e95 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801e8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e93:	eb 05                	jmp    801e9a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801e95:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e9a:	c9                   	leave  
  801e9b:	c3                   	ret    

00801e9c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e9c:	55                   	push   %ebp
  801e9d:	89 e5                	mov    %esp,%ebp
  801e9f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 2c                	push   $0x2c
  801eae:	e8 7d fa ff ff       	call   801930 <syscall>
  801eb3:	83 c4 18             	add    $0x18,%esp
  801eb6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801eb9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ebd:	75 07                	jne    801ec6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ebf:	b8 01 00 00 00       	mov    $0x1,%eax
  801ec4:	eb 05                	jmp    801ecb <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ec6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ecb:	c9                   	leave  
  801ecc:	c3                   	ret    

00801ecd <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ecd:	55                   	push   %ebp
  801ece:	89 e5                	mov    %esp,%ebp
  801ed0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 2c                	push   $0x2c
  801edf:	e8 4c fa ff ff       	call   801930 <syscall>
  801ee4:	83 c4 18             	add    $0x18,%esp
  801ee7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801eea:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801eee:	75 07                	jne    801ef7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ef0:	b8 01 00 00 00       	mov    $0x1,%eax
  801ef5:	eb 05                	jmp    801efc <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ef7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801efc:	c9                   	leave  
  801efd:	c3                   	ret    

00801efe <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801efe:	55                   	push   %ebp
  801eff:	89 e5                	mov    %esp,%ebp
  801f01:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 2c                	push   $0x2c
  801f10:	e8 1b fa ff ff       	call   801930 <syscall>
  801f15:	83 c4 18             	add    $0x18,%esp
  801f18:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801f1b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801f1f:	75 07                	jne    801f28 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801f21:	b8 01 00 00 00       	mov    $0x1,%eax
  801f26:	eb 05                	jmp    801f2d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801f28:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f2d:	c9                   	leave  
  801f2e:	c3                   	ret    

00801f2f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f2f:	55                   	push   %ebp
  801f30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	ff 75 08             	pushl  0x8(%ebp)
  801f3d:	6a 2d                	push   $0x2d
  801f3f:	e8 ec f9 ff ff       	call   801930 <syscall>
  801f44:	83 c4 18             	add    $0x18,%esp
	return ;
  801f47:	90                   	nop
}
  801f48:	c9                   	leave  
  801f49:	c3                   	ret    
  801f4a:	66 90                	xchg   %ax,%ax

00801f4c <__udivdi3>:
  801f4c:	55                   	push   %ebp
  801f4d:	57                   	push   %edi
  801f4e:	56                   	push   %esi
  801f4f:	53                   	push   %ebx
  801f50:	83 ec 1c             	sub    $0x1c,%esp
  801f53:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f57:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f5b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f5f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f63:	89 ca                	mov    %ecx,%edx
  801f65:	89 f8                	mov    %edi,%eax
  801f67:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f6b:	85 f6                	test   %esi,%esi
  801f6d:	75 2d                	jne    801f9c <__udivdi3+0x50>
  801f6f:	39 cf                	cmp    %ecx,%edi
  801f71:	77 65                	ja     801fd8 <__udivdi3+0x8c>
  801f73:	89 fd                	mov    %edi,%ebp
  801f75:	85 ff                	test   %edi,%edi
  801f77:	75 0b                	jne    801f84 <__udivdi3+0x38>
  801f79:	b8 01 00 00 00       	mov    $0x1,%eax
  801f7e:	31 d2                	xor    %edx,%edx
  801f80:	f7 f7                	div    %edi
  801f82:	89 c5                	mov    %eax,%ebp
  801f84:	31 d2                	xor    %edx,%edx
  801f86:	89 c8                	mov    %ecx,%eax
  801f88:	f7 f5                	div    %ebp
  801f8a:	89 c1                	mov    %eax,%ecx
  801f8c:	89 d8                	mov    %ebx,%eax
  801f8e:	f7 f5                	div    %ebp
  801f90:	89 cf                	mov    %ecx,%edi
  801f92:	89 fa                	mov    %edi,%edx
  801f94:	83 c4 1c             	add    $0x1c,%esp
  801f97:	5b                   	pop    %ebx
  801f98:	5e                   	pop    %esi
  801f99:	5f                   	pop    %edi
  801f9a:	5d                   	pop    %ebp
  801f9b:	c3                   	ret    
  801f9c:	39 ce                	cmp    %ecx,%esi
  801f9e:	77 28                	ja     801fc8 <__udivdi3+0x7c>
  801fa0:	0f bd fe             	bsr    %esi,%edi
  801fa3:	83 f7 1f             	xor    $0x1f,%edi
  801fa6:	75 40                	jne    801fe8 <__udivdi3+0x9c>
  801fa8:	39 ce                	cmp    %ecx,%esi
  801faa:	72 0a                	jb     801fb6 <__udivdi3+0x6a>
  801fac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801fb0:	0f 87 9e 00 00 00    	ja     802054 <__udivdi3+0x108>
  801fb6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fbb:	89 fa                	mov    %edi,%edx
  801fbd:	83 c4 1c             	add    $0x1c,%esp
  801fc0:	5b                   	pop    %ebx
  801fc1:	5e                   	pop    %esi
  801fc2:	5f                   	pop    %edi
  801fc3:	5d                   	pop    %ebp
  801fc4:	c3                   	ret    
  801fc5:	8d 76 00             	lea    0x0(%esi),%esi
  801fc8:	31 ff                	xor    %edi,%edi
  801fca:	31 c0                	xor    %eax,%eax
  801fcc:	89 fa                	mov    %edi,%edx
  801fce:	83 c4 1c             	add    $0x1c,%esp
  801fd1:	5b                   	pop    %ebx
  801fd2:	5e                   	pop    %esi
  801fd3:	5f                   	pop    %edi
  801fd4:	5d                   	pop    %ebp
  801fd5:	c3                   	ret    
  801fd6:	66 90                	xchg   %ax,%ax
  801fd8:	89 d8                	mov    %ebx,%eax
  801fda:	f7 f7                	div    %edi
  801fdc:	31 ff                	xor    %edi,%edi
  801fde:	89 fa                	mov    %edi,%edx
  801fe0:	83 c4 1c             	add    $0x1c,%esp
  801fe3:	5b                   	pop    %ebx
  801fe4:	5e                   	pop    %esi
  801fe5:	5f                   	pop    %edi
  801fe6:	5d                   	pop    %ebp
  801fe7:	c3                   	ret    
  801fe8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801fed:	89 eb                	mov    %ebp,%ebx
  801fef:	29 fb                	sub    %edi,%ebx
  801ff1:	89 f9                	mov    %edi,%ecx
  801ff3:	d3 e6                	shl    %cl,%esi
  801ff5:	89 c5                	mov    %eax,%ebp
  801ff7:	88 d9                	mov    %bl,%cl
  801ff9:	d3 ed                	shr    %cl,%ebp
  801ffb:	89 e9                	mov    %ebp,%ecx
  801ffd:	09 f1                	or     %esi,%ecx
  801fff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802003:	89 f9                	mov    %edi,%ecx
  802005:	d3 e0                	shl    %cl,%eax
  802007:	89 c5                	mov    %eax,%ebp
  802009:	89 d6                	mov    %edx,%esi
  80200b:	88 d9                	mov    %bl,%cl
  80200d:	d3 ee                	shr    %cl,%esi
  80200f:	89 f9                	mov    %edi,%ecx
  802011:	d3 e2                	shl    %cl,%edx
  802013:	8b 44 24 08          	mov    0x8(%esp),%eax
  802017:	88 d9                	mov    %bl,%cl
  802019:	d3 e8                	shr    %cl,%eax
  80201b:	09 c2                	or     %eax,%edx
  80201d:	89 d0                	mov    %edx,%eax
  80201f:	89 f2                	mov    %esi,%edx
  802021:	f7 74 24 0c          	divl   0xc(%esp)
  802025:	89 d6                	mov    %edx,%esi
  802027:	89 c3                	mov    %eax,%ebx
  802029:	f7 e5                	mul    %ebp
  80202b:	39 d6                	cmp    %edx,%esi
  80202d:	72 19                	jb     802048 <__udivdi3+0xfc>
  80202f:	74 0b                	je     80203c <__udivdi3+0xf0>
  802031:	89 d8                	mov    %ebx,%eax
  802033:	31 ff                	xor    %edi,%edi
  802035:	e9 58 ff ff ff       	jmp    801f92 <__udivdi3+0x46>
  80203a:	66 90                	xchg   %ax,%ax
  80203c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802040:	89 f9                	mov    %edi,%ecx
  802042:	d3 e2                	shl    %cl,%edx
  802044:	39 c2                	cmp    %eax,%edx
  802046:	73 e9                	jae    802031 <__udivdi3+0xe5>
  802048:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80204b:	31 ff                	xor    %edi,%edi
  80204d:	e9 40 ff ff ff       	jmp    801f92 <__udivdi3+0x46>
  802052:	66 90                	xchg   %ax,%ax
  802054:	31 c0                	xor    %eax,%eax
  802056:	e9 37 ff ff ff       	jmp    801f92 <__udivdi3+0x46>
  80205b:	90                   	nop

0080205c <__umoddi3>:
  80205c:	55                   	push   %ebp
  80205d:	57                   	push   %edi
  80205e:	56                   	push   %esi
  80205f:	53                   	push   %ebx
  802060:	83 ec 1c             	sub    $0x1c,%esp
  802063:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802067:	8b 74 24 34          	mov    0x34(%esp),%esi
  80206b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80206f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802073:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802077:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80207b:	89 f3                	mov    %esi,%ebx
  80207d:	89 fa                	mov    %edi,%edx
  80207f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802083:	89 34 24             	mov    %esi,(%esp)
  802086:	85 c0                	test   %eax,%eax
  802088:	75 1a                	jne    8020a4 <__umoddi3+0x48>
  80208a:	39 f7                	cmp    %esi,%edi
  80208c:	0f 86 a2 00 00 00    	jbe    802134 <__umoddi3+0xd8>
  802092:	89 c8                	mov    %ecx,%eax
  802094:	89 f2                	mov    %esi,%edx
  802096:	f7 f7                	div    %edi
  802098:	89 d0                	mov    %edx,%eax
  80209a:	31 d2                	xor    %edx,%edx
  80209c:	83 c4 1c             	add    $0x1c,%esp
  80209f:	5b                   	pop    %ebx
  8020a0:	5e                   	pop    %esi
  8020a1:	5f                   	pop    %edi
  8020a2:	5d                   	pop    %ebp
  8020a3:	c3                   	ret    
  8020a4:	39 f0                	cmp    %esi,%eax
  8020a6:	0f 87 ac 00 00 00    	ja     802158 <__umoddi3+0xfc>
  8020ac:	0f bd e8             	bsr    %eax,%ebp
  8020af:	83 f5 1f             	xor    $0x1f,%ebp
  8020b2:	0f 84 ac 00 00 00    	je     802164 <__umoddi3+0x108>
  8020b8:	bf 20 00 00 00       	mov    $0x20,%edi
  8020bd:	29 ef                	sub    %ebp,%edi
  8020bf:	89 fe                	mov    %edi,%esi
  8020c1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020c5:	89 e9                	mov    %ebp,%ecx
  8020c7:	d3 e0                	shl    %cl,%eax
  8020c9:	89 d7                	mov    %edx,%edi
  8020cb:	89 f1                	mov    %esi,%ecx
  8020cd:	d3 ef                	shr    %cl,%edi
  8020cf:	09 c7                	or     %eax,%edi
  8020d1:	89 e9                	mov    %ebp,%ecx
  8020d3:	d3 e2                	shl    %cl,%edx
  8020d5:	89 14 24             	mov    %edx,(%esp)
  8020d8:	89 d8                	mov    %ebx,%eax
  8020da:	d3 e0                	shl    %cl,%eax
  8020dc:	89 c2                	mov    %eax,%edx
  8020de:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020e2:	d3 e0                	shl    %cl,%eax
  8020e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020e8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020ec:	89 f1                	mov    %esi,%ecx
  8020ee:	d3 e8                	shr    %cl,%eax
  8020f0:	09 d0                	or     %edx,%eax
  8020f2:	d3 eb                	shr    %cl,%ebx
  8020f4:	89 da                	mov    %ebx,%edx
  8020f6:	f7 f7                	div    %edi
  8020f8:	89 d3                	mov    %edx,%ebx
  8020fa:	f7 24 24             	mull   (%esp)
  8020fd:	89 c6                	mov    %eax,%esi
  8020ff:	89 d1                	mov    %edx,%ecx
  802101:	39 d3                	cmp    %edx,%ebx
  802103:	0f 82 87 00 00 00    	jb     802190 <__umoddi3+0x134>
  802109:	0f 84 91 00 00 00    	je     8021a0 <__umoddi3+0x144>
  80210f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802113:	29 f2                	sub    %esi,%edx
  802115:	19 cb                	sbb    %ecx,%ebx
  802117:	89 d8                	mov    %ebx,%eax
  802119:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80211d:	d3 e0                	shl    %cl,%eax
  80211f:	89 e9                	mov    %ebp,%ecx
  802121:	d3 ea                	shr    %cl,%edx
  802123:	09 d0                	or     %edx,%eax
  802125:	89 e9                	mov    %ebp,%ecx
  802127:	d3 eb                	shr    %cl,%ebx
  802129:	89 da                	mov    %ebx,%edx
  80212b:	83 c4 1c             	add    $0x1c,%esp
  80212e:	5b                   	pop    %ebx
  80212f:	5e                   	pop    %esi
  802130:	5f                   	pop    %edi
  802131:	5d                   	pop    %ebp
  802132:	c3                   	ret    
  802133:	90                   	nop
  802134:	89 fd                	mov    %edi,%ebp
  802136:	85 ff                	test   %edi,%edi
  802138:	75 0b                	jne    802145 <__umoddi3+0xe9>
  80213a:	b8 01 00 00 00       	mov    $0x1,%eax
  80213f:	31 d2                	xor    %edx,%edx
  802141:	f7 f7                	div    %edi
  802143:	89 c5                	mov    %eax,%ebp
  802145:	89 f0                	mov    %esi,%eax
  802147:	31 d2                	xor    %edx,%edx
  802149:	f7 f5                	div    %ebp
  80214b:	89 c8                	mov    %ecx,%eax
  80214d:	f7 f5                	div    %ebp
  80214f:	89 d0                	mov    %edx,%eax
  802151:	e9 44 ff ff ff       	jmp    80209a <__umoddi3+0x3e>
  802156:	66 90                	xchg   %ax,%ax
  802158:	89 c8                	mov    %ecx,%eax
  80215a:	89 f2                	mov    %esi,%edx
  80215c:	83 c4 1c             	add    $0x1c,%esp
  80215f:	5b                   	pop    %ebx
  802160:	5e                   	pop    %esi
  802161:	5f                   	pop    %edi
  802162:	5d                   	pop    %ebp
  802163:	c3                   	ret    
  802164:	3b 04 24             	cmp    (%esp),%eax
  802167:	72 06                	jb     80216f <__umoddi3+0x113>
  802169:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80216d:	77 0f                	ja     80217e <__umoddi3+0x122>
  80216f:	89 f2                	mov    %esi,%edx
  802171:	29 f9                	sub    %edi,%ecx
  802173:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802177:	89 14 24             	mov    %edx,(%esp)
  80217a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80217e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802182:	8b 14 24             	mov    (%esp),%edx
  802185:	83 c4 1c             	add    $0x1c,%esp
  802188:	5b                   	pop    %ebx
  802189:	5e                   	pop    %esi
  80218a:	5f                   	pop    %edi
  80218b:	5d                   	pop    %ebp
  80218c:	c3                   	ret    
  80218d:	8d 76 00             	lea    0x0(%esi),%esi
  802190:	2b 04 24             	sub    (%esp),%eax
  802193:	19 fa                	sbb    %edi,%edx
  802195:	89 d1                	mov    %edx,%ecx
  802197:	89 c6                	mov    %eax,%esi
  802199:	e9 71 ff ff ff       	jmp    80210f <__umoddi3+0xb3>
  80219e:	66 90                	xchg   %ax,%ax
  8021a0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021a4:	72 ea                	jb     802190 <__umoddi3+0x134>
  8021a6:	89 d9                	mov    %ebx,%ecx
  8021a8:	e9 62 ff ff ff       	jmp    80210f <__umoddi3+0xb3>
