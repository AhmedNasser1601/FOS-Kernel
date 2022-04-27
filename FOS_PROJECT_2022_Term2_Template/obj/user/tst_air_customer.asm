
obj/user/tst_air_customer:     file format elf32-i386


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
  800031:	e8 dc 03 00 00       	call   800412 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>
#include <user/air.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 8c 01 00 00    	sub    $0x18c,%esp
	int32 parentenvID = sys_getparentenvid();
  800044:	e8 92 14 00 00       	call   8014db <sys_getparentenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	char _customers[] = "customers";
  80004c:	8d 45 c2             	lea    -0x3e(%ebp),%eax
  80004f:	bb c9 1e 80 00       	mov    $0x801ec9,%ebx
  800054:	ba 0a 00 00 00       	mov    $0xa,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custCounter[] = "custCounter";
  800061:	8d 45 b6             	lea    -0x4a(%ebp),%eax
  800064:	bb d3 1e 80 00       	mov    $0x801ed3,%ebx
  800069:	ba 03 00 00 00       	mov    $0x3,%edx
  80006e:	89 c7                	mov    %eax,%edi
  800070:	89 de                	mov    %ebx,%esi
  800072:	89 d1                	mov    %edx,%ecx
  800074:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1Counter[] = "flight1Counter";
  800076:	8d 45 a7             	lea    -0x59(%ebp),%eax
  800079:	bb df 1e 80 00       	mov    $0x801edf,%ebx
  80007e:	ba 0f 00 00 00       	mov    $0xf,%edx
  800083:	89 c7                	mov    %eax,%edi
  800085:	89 de                	mov    %ebx,%esi
  800087:	89 d1                	mov    %edx,%ecx
  800089:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2Counter[] = "flight2Counter";
  80008b:	8d 45 98             	lea    -0x68(%ebp),%eax
  80008e:	bb ee 1e 80 00       	mov    $0x801eee,%ebx
  800093:	ba 0f 00 00 00       	mov    $0xf,%edx
  800098:	89 c7                	mov    %eax,%edi
  80009a:	89 de                	mov    %ebx,%esi
  80009c:	89 d1                	mov    %edx,%ecx
  80009e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Counter[] = "flightBooked1Counter";
  8000a0:	8d 45 83             	lea    -0x7d(%ebp),%eax
  8000a3:	bb fd 1e 80 00       	mov    $0x801efd,%ebx
  8000a8:	ba 15 00 00 00       	mov    $0x15,%edx
  8000ad:	89 c7                	mov    %eax,%edi
  8000af:	89 de                	mov    %ebx,%esi
  8000b1:	89 d1                	mov    %edx,%ecx
  8000b3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Counter[] = "flightBooked2Counter";
  8000b5:	8d 85 6e ff ff ff    	lea    -0x92(%ebp),%eax
  8000bb:	bb 12 1f 80 00       	mov    $0x801f12,%ebx
  8000c0:	ba 15 00 00 00       	mov    $0x15,%edx
  8000c5:	89 c7                	mov    %eax,%edi
  8000c7:	89 de                	mov    %ebx,%esi
  8000c9:	89 d1                	mov    %edx,%ecx
  8000cb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Arr[] = "flightBooked1Arr";
  8000cd:	8d 85 5d ff ff ff    	lea    -0xa3(%ebp),%eax
  8000d3:	bb 27 1f 80 00       	mov    $0x801f27,%ebx
  8000d8:	ba 11 00 00 00       	mov    $0x11,%edx
  8000dd:	89 c7                	mov    %eax,%edi
  8000df:	89 de                	mov    %ebx,%esi
  8000e1:	89 d1                	mov    %edx,%ecx
  8000e3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Arr[] = "flightBooked2Arr";
  8000e5:	8d 85 4c ff ff ff    	lea    -0xb4(%ebp),%eax
  8000eb:	bb 38 1f 80 00       	mov    $0x801f38,%ebx
  8000f0:	ba 11 00 00 00       	mov    $0x11,%edx
  8000f5:	89 c7                	mov    %eax,%edi
  8000f7:	89 de                	mov    %ebx,%esi
  8000f9:	89 d1                	mov    %edx,%ecx
  8000fb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _cust_ready_queue[] = "cust_ready_queue";
  8000fd:	8d 85 3b ff ff ff    	lea    -0xc5(%ebp),%eax
  800103:	bb 49 1f 80 00       	mov    $0x801f49,%ebx
  800108:	ba 11 00 00 00       	mov    $0x11,%edx
  80010d:	89 c7                	mov    %eax,%edi
  80010f:	89 de                	mov    %ebx,%esi
  800111:	89 d1                	mov    %edx,%ecx
  800113:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_in[] = "queue_in";
  800115:	8d 85 32 ff ff ff    	lea    -0xce(%ebp),%eax
  80011b:	bb 5a 1f 80 00       	mov    $0x801f5a,%ebx
  800120:	ba 09 00 00 00       	mov    $0x9,%edx
  800125:	89 c7                	mov    %eax,%edi
  800127:	89 de                	mov    %ebx,%esi
  800129:	89 d1                	mov    %edx,%ecx
  80012b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_out[] = "queue_out";
  80012d:	8d 85 28 ff ff ff    	lea    -0xd8(%ebp),%eax
  800133:	bb 63 1f 80 00       	mov    $0x801f63,%ebx
  800138:	ba 0a 00 00 00       	mov    $0xa,%edx
  80013d:	89 c7                	mov    %eax,%edi
  80013f:	89 de                	mov    %ebx,%esi
  800141:	89 d1                	mov    %edx,%ecx
  800143:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _cust_ready[] = "cust_ready";
  800145:	8d 85 1d ff ff ff    	lea    -0xe3(%ebp),%eax
  80014b:	bb 6d 1f 80 00       	mov    $0x801f6d,%ebx
  800150:	ba 0b 00 00 00       	mov    $0xb,%edx
  800155:	89 c7                	mov    %eax,%edi
  800157:	89 de                	mov    %ebx,%esi
  800159:	89 d1                	mov    %edx,%ecx
  80015b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custQueueCS[] = "custQueueCS";
  80015d:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  800163:	bb 78 1f 80 00       	mov    $0x801f78,%ebx
  800168:	ba 03 00 00 00       	mov    $0x3,%edx
  80016d:	89 c7                	mov    %eax,%edi
  80016f:	89 de                	mov    %ebx,%esi
  800171:	89 d1                	mov    %edx,%ecx
  800173:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1CS[] = "flight1CS";
  800175:	8d 85 07 ff ff ff    	lea    -0xf9(%ebp),%eax
  80017b:	bb 84 1f 80 00       	mov    $0x801f84,%ebx
  800180:	ba 0a 00 00 00       	mov    $0xa,%edx
  800185:	89 c7                	mov    %eax,%edi
  800187:	89 de                	mov    %ebx,%esi
  800189:	89 d1                	mov    %edx,%ecx
  80018b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2CS[] = "flight2CS";
  80018d:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800193:	bb 8e 1f 80 00       	mov    $0x801f8e,%ebx
  800198:	ba 0a 00 00 00       	mov    $0xa,%edx
  80019d:	89 c7                	mov    %eax,%edi
  80019f:	89 de                	mov    %ebx,%esi
  8001a1:	89 d1                	mov    %edx,%ecx
  8001a3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _clerk[] = "clerk";
  8001a5:	c7 85 f7 fe ff ff 63 	movl   $0x72656c63,-0x109(%ebp)
  8001ac:	6c 65 72 
  8001af:	66 c7 85 fb fe ff ff 	movw   $0x6b,-0x105(%ebp)
  8001b6:	6b 00 
	char _custCounterCS[] = "custCounterCS";
  8001b8:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8001be:	bb 98 1f 80 00       	mov    $0x801f98,%ebx
  8001c3:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001c8:	89 c7                	mov    %eax,%edi
  8001ca:	89 de                	mov    %ebx,%esi
  8001cc:	89 d1                	mov    %edx,%ecx
  8001ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custTerminated[] = "custTerminated";
  8001d0:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  8001d6:	bb a6 1f 80 00       	mov    $0x801fa6,%ebx
  8001db:	ba 0f 00 00 00       	mov    $0xf,%edx
  8001e0:	89 c7                	mov    %eax,%edi
  8001e2:	89 de                	mov    %ebx,%esi
  8001e4:	89 d1                	mov    %edx,%ecx
  8001e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _taircl[] = "taircl";
  8001e8:	8d 85 d3 fe ff ff    	lea    -0x12d(%ebp),%eax
  8001ee:	bb b5 1f 80 00       	mov    $0x801fb5,%ebx
  8001f3:	ba 07 00 00 00       	mov    $0x7,%edx
  8001f8:	89 c7                	mov    %eax,%edi
  8001fa:	89 de                	mov    %ebx,%esi
  8001fc:	89 d1                	mov    %edx,%ecx
  8001fe:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _taircu[] = "taircu";
  800200:	8d 85 cc fe ff ff    	lea    -0x134(%ebp),%eax
  800206:	bb bc 1f 80 00       	mov    $0x801fbc,%ebx
  80020b:	ba 07 00 00 00       	mov    $0x7,%edx
  800210:	89 c7                	mov    %eax,%edi
  800212:	89 de                	mov    %ebx,%esi
  800214:	89 d1                	mov    %edx,%ecx
  800216:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	// Get the shared variables from the main program ***********************************

	struct Customer * customers = sget(parentenvID, _customers);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	8d 45 c2             	lea    -0x3e(%ebp),%eax
  80021e:	50                   	push   %eax
  80021f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800222:	e8 92 11 00 00       	call   8013b9 <sget>
  800227:	83 c4 10             	add    $0x10,%esp
  80022a:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int* custCounter = sget(parentenvID, _custCounter);
  80022d:	83 ec 08             	sub    $0x8,%esp
  800230:	8d 45 b6             	lea    -0x4a(%ebp),%eax
  800233:	50                   	push   %eax
  800234:	ff 75 e4             	pushl  -0x1c(%ebp)
  800237:	e8 7d 11 00 00       	call   8013b9 <sget>
  80023c:	83 c4 10             	add    $0x10,%esp
  80023f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int* cust_ready_queue = sget(parentenvID, _cust_ready_queue);
  800242:	83 ec 08             	sub    $0x8,%esp
  800245:	8d 85 3b ff ff ff    	lea    -0xc5(%ebp),%eax
  80024b:	50                   	push   %eax
  80024c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80024f:	e8 65 11 00 00       	call   8013b9 <sget>
  800254:	83 c4 10             	add    $0x10,%esp
  800257:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* queue_in = sget(parentenvID, _queue_in);
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	8d 85 32 ff ff ff    	lea    -0xce(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	ff 75 e4             	pushl  -0x1c(%ebp)
  800267:	e8 4d 11 00 00       	call   8013b9 <sget>
  80026c:	83 c4 10             	add    $0x10,%esp
  80026f:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	// *********************************************************************************

	int custId, flightType;
	sys_waitSemaphore(parentenvID, _custCounterCS);
  800272:	83 ec 08             	sub    $0x8,%esp
  800275:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80027b:	50                   	push   %eax
  80027c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80027f:	e8 86 14 00 00       	call   80170a <sys_waitSemaphore>
  800284:	83 c4 10             	add    $0x10,%esp
	{
		custId = *custCounter;
  800287:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80028a:	8b 00                	mov    (%eax),%eax
  80028c:	89 45 d0             	mov    %eax,-0x30(%ebp)
		//cprintf("custCounter= %d\n", *custCounter);
		*custCounter = *custCounter +1;
  80028f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800292:	8b 00                	mov    (%eax),%eax
  800294:	8d 50 01             	lea    0x1(%eax),%edx
  800297:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80029a:	89 10                	mov    %edx,(%eax)
	}
	sys_signalSemaphore(parentenvID, _custCounterCS);
  80029c:	83 ec 08             	sub    $0x8,%esp
  80029f:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8002a5:	50                   	push   %eax
  8002a6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002a9:	e8 7a 14 00 00       	call   801728 <sys_signalSemaphore>
  8002ae:	83 c4 10             	add    $0x10,%esp

	//wait on one of the clerks
	sys_waitSemaphore(parentenvID, _clerk);
  8002b1:	83 ec 08             	sub    $0x8,%esp
  8002b4:	8d 85 f7 fe ff ff    	lea    -0x109(%ebp),%eax
  8002ba:	50                   	push   %eax
  8002bb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002be:	e8 47 14 00 00       	call   80170a <sys_waitSemaphore>
  8002c3:	83 c4 10             	add    $0x10,%esp

	//enqueue the request
	flightType = customers[custId].flightType;
  8002c6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8002c9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002d3:	01 d0                	add    %edx,%eax
  8002d5:	8b 00                	mov    (%eax),%eax
  8002d7:	89 45 cc             	mov    %eax,-0x34(%ebp)
	sys_waitSemaphore(parentenvID, _custQueueCS);
  8002da:	83 ec 08             	sub    $0x8,%esp
  8002dd:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  8002e3:	50                   	push   %eax
  8002e4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002e7:	e8 1e 14 00 00       	call   80170a <sys_waitSemaphore>
  8002ec:	83 c4 10             	add    $0x10,%esp
	{
		cust_ready_queue[*queue_in] = custId;
  8002ef:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8002f2:	8b 00                	mov    (%eax),%eax
  8002f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002fb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002fe:	01 c2                	add    %eax,%edx
  800300:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800303:	89 02                	mov    %eax,(%edx)
		*queue_in = *queue_in +1;
  800305:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800308:	8b 00                	mov    (%eax),%eax
  80030a:	8d 50 01             	lea    0x1(%eax),%edx
  80030d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800310:	89 10                	mov    %edx,(%eax)
	}
	sys_signalSemaphore(parentenvID, _custQueueCS);
  800312:	83 ec 08             	sub    $0x8,%esp
  800315:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  80031b:	50                   	push   %eax
  80031c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80031f:	e8 04 14 00 00       	call   801728 <sys_signalSemaphore>
  800324:	83 c4 10             	add    $0x10,%esp

	//signal ready
	sys_signalSemaphore(parentenvID, _cust_ready);
  800327:	83 ec 08             	sub    $0x8,%esp
  80032a:	8d 85 1d ff ff ff    	lea    -0xe3(%ebp),%eax
  800330:	50                   	push   %eax
  800331:	ff 75 e4             	pushl  -0x1c(%ebp)
  800334:	e8 ef 13 00 00       	call   801728 <sys_signalSemaphore>
  800339:	83 c4 10             	add    $0x10,%esp

	//wait on finished
	char prefix[30]="cust_finished";
  80033c:	8d 85 ae fe ff ff    	lea    -0x152(%ebp),%eax
  800342:	bb c3 1f 80 00       	mov    $0x801fc3,%ebx
  800347:	ba 0e 00 00 00       	mov    $0xe,%edx
  80034c:	89 c7                	mov    %eax,%edi
  80034e:	89 de                	mov    %ebx,%esi
  800350:	89 d1                	mov    %edx,%ecx
  800352:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800354:	8d 95 bc fe ff ff    	lea    -0x144(%ebp),%edx
  80035a:	b9 04 00 00 00       	mov    $0x4,%ecx
  80035f:	b8 00 00 00 00       	mov    $0x0,%eax
  800364:	89 d7                	mov    %edx,%edi
  800366:	f3 ab                	rep stos %eax,%es:(%edi)
	char id[5]; char sname[50];
	ltostr(custId, id);
  800368:	83 ec 08             	sub    $0x8,%esp
  80036b:	8d 85 a9 fe ff ff    	lea    -0x157(%ebp),%eax
  800371:	50                   	push   %eax
  800372:	ff 75 d0             	pushl  -0x30(%ebp)
  800375:	e8 a3 0d 00 00       	call   80111d <ltostr>
  80037a:	83 c4 10             	add    $0x10,%esp
	strcconcat(prefix, id, sname);
  80037d:	83 ec 04             	sub    $0x4,%esp
  800380:	8d 85 77 fe ff ff    	lea    -0x189(%ebp),%eax
  800386:	50                   	push   %eax
  800387:	8d 85 a9 fe ff ff    	lea    -0x157(%ebp),%eax
  80038d:	50                   	push   %eax
  80038e:	8d 85 ae fe ff ff    	lea    -0x152(%ebp),%eax
  800394:	50                   	push   %eax
  800395:	e8 7b 0e 00 00       	call   801215 <strcconcat>
  80039a:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(parentenvID, sname);
  80039d:	83 ec 08             	sub    $0x8,%esp
  8003a0:	8d 85 77 fe ff ff    	lea    -0x189(%ebp),%eax
  8003a6:	50                   	push   %eax
  8003a7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8003aa:	e8 5b 13 00 00       	call   80170a <sys_waitSemaphore>
  8003af:	83 c4 10             	add    $0x10,%esp

	//print the customer status
	if(customers[custId].booked == 1)
  8003b2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003b5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8003bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003bf:	01 d0                	add    %edx,%eax
  8003c1:	8b 40 04             	mov    0x4(%eax),%eax
  8003c4:	83 f8 01             	cmp    $0x1,%eax
  8003c7:	75 18                	jne    8003e1 <_main+0x3a9>
	{
		cprintf("cust %d: finished (BOOKED flight %d) \n", custId, flightType);
  8003c9:	83 ec 04             	sub    $0x4,%esp
  8003cc:	ff 75 cc             	pushl  -0x34(%ebp)
  8003cf:	ff 75 d0             	pushl  -0x30(%ebp)
  8003d2:	68 80 1e 80 00       	push   $0x801e80
  8003d7:	e8 19 02 00 00       	call   8005f5 <cprintf>
  8003dc:	83 c4 10             	add    $0x10,%esp
  8003df:	eb 13                	jmp    8003f4 <_main+0x3bc>
	}
	else
	{
		cprintf("cust %d: finished (NOT BOOKED) \n", custId);
  8003e1:	83 ec 08             	sub    $0x8,%esp
  8003e4:	ff 75 d0             	pushl  -0x30(%ebp)
  8003e7:	68 a8 1e 80 00       	push   $0x801ea8
  8003ec:	e8 04 02 00 00       	call   8005f5 <cprintf>
  8003f1:	83 c4 10             	add    $0x10,%esp
	}

	//customer is terminated
	sys_signalSemaphore(parentenvID, _custTerminated);
  8003f4:	83 ec 08             	sub    $0x8,%esp
  8003f7:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  8003fd:	50                   	push   %eax
  8003fe:	ff 75 e4             	pushl  -0x1c(%ebp)
  800401:	e8 22 13 00 00       	call   801728 <sys_signalSemaphore>
  800406:	83 c4 10             	add    $0x10,%esp

	return;
  800409:	90                   	nop
}
  80040a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80040d:	5b                   	pop    %ebx
  80040e:	5e                   	pop    %esi
  80040f:	5f                   	pop    %edi
  800410:	5d                   	pop    %ebp
  800411:	c3                   	ret    

00800412 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800412:	55                   	push   %ebp
  800413:	89 e5                	mov    %esp,%ebp
  800415:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800418:	e8 a5 10 00 00       	call   8014c2 <sys_getenvindex>
  80041d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800420:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800423:	89 d0                	mov    %edx,%eax
  800425:	c1 e0 02             	shl    $0x2,%eax
  800428:	01 d0                	add    %edx,%eax
  80042a:	01 c0                	add    %eax,%eax
  80042c:	01 d0                	add    %edx,%eax
  80042e:	01 c0                	add    %eax,%eax
  800430:	01 d0                	add    %edx,%eax
  800432:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800439:	01 d0                	add    %edx,%eax
  80043b:	c1 e0 02             	shl    $0x2,%eax
  80043e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800443:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800448:	a1 04 30 80 00       	mov    0x803004,%eax
  80044d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800453:	84 c0                	test   %al,%al
  800455:	74 0f                	je     800466 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800457:	a1 04 30 80 00       	mov    0x803004,%eax
  80045c:	05 f4 02 00 00       	add    $0x2f4,%eax
  800461:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800466:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80046a:	7e 0a                	jle    800476 <libmain+0x64>
		binaryname = argv[0];
  80046c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046f:	8b 00                	mov    (%eax),%eax
  800471:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800476:	83 ec 08             	sub    $0x8,%esp
  800479:	ff 75 0c             	pushl  0xc(%ebp)
  80047c:	ff 75 08             	pushl  0x8(%ebp)
  80047f:	e8 b4 fb ff ff       	call   800038 <_main>
  800484:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800487:	e8 d1 11 00 00       	call   80165d <sys_disable_interrupt>
	cprintf("**************************************\n");
  80048c:	83 ec 0c             	sub    $0xc,%esp
  80048f:	68 fc 1f 80 00       	push   $0x801ffc
  800494:	e8 5c 01 00 00       	call   8005f5 <cprintf>
  800499:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80049c:	a1 04 30 80 00       	mov    0x803004,%eax
  8004a1:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8004a7:	a1 04 30 80 00       	mov    0x803004,%eax
  8004ac:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8004b2:	83 ec 04             	sub    $0x4,%esp
  8004b5:	52                   	push   %edx
  8004b6:	50                   	push   %eax
  8004b7:	68 24 20 80 00       	push   $0x802024
  8004bc:	e8 34 01 00 00       	call   8005f5 <cprintf>
  8004c1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004c4:	a1 04 30 80 00       	mov    0x803004,%eax
  8004c9:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8004cf:	83 ec 08             	sub    $0x8,%esp
  8004d2:	50                   	push   %eax
  8004d3:	68 49 20 80 00       	push   $0x802049
  8004d8:	e8 18 01 00 00       	call   8005f5 <cprintf>
  8004dd:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004e0:	83 ec 0c             	sub    $0xc,%esp
  8004e3:	68 fc 1f 80 00       	push   $0x801ffc
  8004e8:	e8 08 01 00 00       	call   8005f5 <cprintf>
  8004ed:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004f0:	e8 82 11 00 00       	call   801677 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004f5:	e8 19 00 00 00       	call   800513 <exit>
}
  8004fa:	90                   	nop
  8004fb:	c9                   	leave  
  8004fc:	c3                   	ret    

008004fd <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004fd:	55                   	push   %ebp
  8004fe:	89 e5                	mov    %esp,%ebp
  800500:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800503:	83 ec 0c             	sub    $0xc,%esp
  800506:	6a 00                	push   $0x0
  800508:	e8 81 0f 00 00       	call   80148e <sys_env_destroy>
  80050d:	83 c4 10             	add    $0x10,%esp
}
  800510:	90                   	nop
  800511:	c9                   	leave  
  800512:	c3                   	ret    

00800513 <exit>:

void
exit(void)
{
  800513:	55                   	push   %ebp
  800514:	89 e5                	mov    %esp,%ebp
  800516:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800519:	e8 d6 0f 00 00       	call   8014f4 <sys_env_exit>
}
  80051e:	90                   	nop
  80051f:	c9                   	leave  
  800520:	c3                   	ret    

00800521 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800521:	55                   	push   %ebp
  800522:	89 e5                	mov    %esp,%ebp
  800524:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800527:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052a:	8b 00                	mov    (%eax),%eax
  80052c:	8d 48 01             	lea    0x1(%eax),%ecx
  80052f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800532:	89 0a                	mov    %ecx,(%edx)
  800534:	8b 55 08             	mov    0x8(%ebp),%edx
  800537:	88 d1                	mov    %dl,%cl
  800539:	8b 55 0c             	mov    0xc(%ebp),%edx
  80053c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800540:	8b 45 0c             	mov    0xc(%ebp),%eax
  800543:	8b 00                	mov    (%eax),%eax
  800545:	3d ff 00 00 00       	cmp    $0xff,%eax
  80054a:	75 2c                	jne    800578 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80054c:	a0 08 30 80 00       	mov    0x803008,%al
  800551:	0f b6 c0             	movzbl %al,%eax
  800554:	8b 55 0c             	mov    0xc(%ebp),%edx
  800557:	8b 12                	mov    (%edx),%edx
  800559:	89 d1                	mov    %edx,%ecx
  80055b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80055e:	83 c2 08             	add    $0x8,%edx
  800561:	83 ec 04             	sub    $0x4,%esp
  800564:	50                   	push   %eax
  800565:	51                   	push   %ecx
  800566:	52                   	push   %edx
  800567:	e8 e0 0e 00 00       	call   80144c <sys_cputs>
  80056c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80056f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800572:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800578:	8b 45 0c             	mov    0xc(%ebp),%eax
  80057b:	8b 40 04             	mov    0x4(%eax),%eax
  80057e:	8d 50 01             	lea    0x1(%eax),%edx
  800581:	8b 45 0c             	mov    0xc(%ebp),%eax
  800584:	89 50 04             	mov    %edx,0x4(%eax)
}
  800587:	90                   	nop
  800588:	c9                   	leave  
  800589:	c3                   	ret    

0080058a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80058a:	55                   	push   %ebp
  80058b:	89 e5                	mov    %esp,%ebp
  80058d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800593:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80059a:	00 00 00 
	b.cnt = 0;
  80059d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005a4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005a7:	ff 75 0c             	pushl  0xc(%ebp)
  8005aa:	ff 75 08             	pushl  0x8(%ebp)
  8005ad:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005b3:	50                   	push   %eax
  8005b4:	68 21 05 80 00       	push   $0x800521
  8005b9:	e8 11 02 00 00       	call   8007cf <vprintfmt>
  8005be:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005c1:	a0 08 30 80 00       	mov    0x803008,%al
  8005c6:	0f b6 c0             	movzbl %al,%eax
  8005c9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005cf:	83 ec 04             	sub    $0x4,%esp
  8005d2:	50                   	push   %eax
  8005d3:	52                   	push   %edx
  8005d4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005da:	83 c0 08             	add    $0x8,%eax
  8005dd:	50                   	push   %eax
  8005de:	e8 69 0e 00 00       	call   80144c <sys_cputs>
  8005e3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005e6:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  8005ed:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005f3:	c9                   	leave  
  8005f4:	c3                   	ret    

008005f5 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005f5:	55                   	push   %ebp
  8005f6:	89 e5                	mov    %esp,%ebp
  8005f8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005fb:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800602:	8d 45 0c             	lea    0xc(%ebp),%eax
  800605:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800608:	8b 45 08             	mov    0x8(%ebp),%eax
  80060b:	83 ec 08             	sub    $0x8,%esp
  80060e:	ff 75 f4             	pushl  -0xc(%ebp)
  800611:	50                   	push   %eax
  800612:	e8 73 ff ff ff       	call   80058a <vcprintf>
  800617:	83 c4 10             	add    $0x10,%esp
  80061a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80061d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800620:	c9                   	leave  
  800621:	c3                   	ret    

00800622 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800622:	55                   	push   %ebp
  800623:	89 e5                	mov    %esp,%ebp
  800625:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800628:	e8 30 10 00 00       	call   80165d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80062d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800630:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800633:	8b 45 08             	mov    0x8(%ebp),%eax
  800636:	83 ec 08             	sub    $0x8,%esp
  800639:	ff 75 f4             	pushl  -0xc(%ebp)
  80063c:	50                   	push   %eax
  80063d:	e8 48 ff ff ff       	call   80058a <vcprintf>
  800642:	83 c4 10             	add    $0x10,%esp
  800645:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800648:	e8 2a 10 00 00       	call   801677 <sys_enable_interrupt>
	return cnt;
  80064d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800650:	c9                   	leave  
  800651:	c3                   	ret    

00800652 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800652:	55                   	push   %ebp
  800653:	89 e5                	mov    %esp,%ebp
  800655:	53                   	push   %ebx
  800656:	83 ec 14             	sub    $0x14,%esp
  800659:	8b 45 10             	mov    0x10(%ebp),%eax
  80065c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80065f:	8b 45 14             	mov    0x14(%ebp),%eax
  800662:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800665:	8b 45 18             	mov    0x18(%ebp),%eax
  800668:	ba 00 00 00 00       	mov    $0x0,%edx
  80066d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800670:	77 55                	ja     8006c7 <printnum+0x75>
  800672:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800675:	72 05                	jb     80067c <printnum+0x2a>
  800677:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80067a:	77 4b                	ja     8006c7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80067c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80067f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800682:	8b 45 18             	mov    0x18(%ebp),%eax
  800685:	ba 00 00 00 00       	mov    $0x0,%edx
  80068a:	52                   	push   %edx
  80068b:	50                   	push   %eax
  80068c:	ff 75 f4             	pushl  -0xc(%ebp)
  80068f:	ff 75 f0             	pushl  -0x10(%ebp)
  800692:	e8 85 15 00 00       	call   801c1c <__udivdi3>
  800697:	83 c4 10             	add    $0x10,%esp
  80069a:	83 ec 04             	sub    $0x4,%esp
  80069d:	ff 75 20             	pushl  0x20(%ebp)
  8006a0:	53                   	push   %ebx
  8006a1:	ff 75 18             	pushl  0x18(%ebp)
  8006a4:	52                   	push   %edx
  8006a5:	50                   	push   %eax
  8006a6:	ff 75 0c             	pushl  0xc(%ebp)
  8006a9:	ff 75 08             	pushl  0x8(%ebp)
  8006ac:	e8 a1 ff ff ff       	call   800652 <printnum>
  8006b1:	83 c4 20             	add    $0x20,%esp
  8006b4:	eb 1a                	jmp    8006d0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006b6:	83 ec 08             	sub    $0x8,%esp
  8006b9:	ff 75 0c             	pushl  0xc(%ebp)
  8006bc:	ff 75 20             	pushl  0x20(%ebp)
  8006bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c2:	ff d0                	call   *%eax
  8006c4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006c7:	ff 4d 1c             	decl   0x1c(%ebp)
  8006ca:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006ce:	7f e6                	jg     8006b6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006d0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006d3:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006db:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006de:	53                   	push   %ebx
  8006df:	51                   	push   %ecx
  8006e0:	52                   	push   %edx
  8006e1:	50                   	push   %eax
  8006e2:	e8 45 16 00 00       	call   801d2c <__umoddi3>
  8006e7:	83 c4 10             	add    $0x10,%esp
  8006ea:	05 74 22 80 00       	add    $0x802274,%eax
  8006ef:	8a 00                	mov    (%eax),%al
  8006f1:	0f be c0             	movsbl %al,%eax
  8006f4:	83 ec 08             	sub    $0x8,%esp
  8006f7:	ff 75 0c             	pushl  0xc(%ebp)
  8006fa:	50                   	push   %eax
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	ff d0                	call   *%eax
  800700:	83 c4 10             	add    $0x10,%esp
}
  800703:	90                   	nop
  800704:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80070c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800710:	7e 1c                	jle    80072e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800712:	8b 45 08             	mov    0x8(%ebp),%eax
  800715:	8b 00                	mov    (%eax),%eax
  800717:	8d 50 08             	lea    0x8(%eax),%edx
  80071a:	8b 45 08             	mov    0x8(%ebp),%eax
  80071d:	89 10                	mov    %edx,(%eax)
  80071f:	8b 45 08             	mov    0x8(%ebp),%eax
  800722:	8b 00                	mov    (%eax),%eax
  800724:	83 e8 08             	sub    $0x8,%eax
  800727:	8b 50 04             	mov    0x4(%eax),%edx
  80072a:	8b 00                	mov    (%eax),%eax
  80072c:	eb 40                	jmp    80076e <getuint+0x65>
	else if (lflag)
  80072e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800732:	74 1e                	je     800752 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800734:	8b 45 08             	mov    0x8(%ebp),%eax
  800737:	8b 00                	mov    (%eax),%eax
  800739:	8d 50 04             	lea    0x4(%eax),%edx
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	89 10                	mov    %edx,(%eax)
  800741:	8b 45 08             	mov    0x8(%ebp),%eax
  800744:	8b 00                	mov    (%eax),%eax
  800746:	83 e8 04             	sub    $0x4,%eax
  800749:	8b 00                	mov    (%eax),%eax
  80074b:	ba 00 00 00 00       	mov    $0x0,%edx
  800750:	eb 1c                	jmp    80076e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800752:	8b 45 08             	mov    0x8(%ebp),%eax
  800755:	8b 00                	mov    (%eax),%eax
  800757:	8d 50 04             	lea    0x4(%eax),%edx
  80075a:	8b 45 08             	mov    0x8(%ebp),%eax
  80075d:	89 10                	mov    %edx,(%eax)
  80075f:	8b 45 08             	mov    0x8(%ebp),%eax
  800762:	8b 00                	mov    (%eax),%eax
  800764:	83 e8 04             	sub    $0x4,%eax
  800767:	8b 00                	mov    (%eax),%eax
  800769:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80076e:	5d                   	pop    %ebp
  80076f:	c3                   	ret    

00800770 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800770:	55                   	push   %ebp
  800771:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800773:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800777:	7e 1c                	jle    800795 <getint+0x25>
		return va_arg(*ap, long long);
  800779:	8b 45 08             	mov    0x8(%ebp),%eax
  80077c:	8b 00                	mov    (%eax),%eax
  80077e:	8d 50 08             	lea    0x8(%eax),%edx
  800781:	8b 45 08             	mov    0x8(%ebp),%eax
  800784:	89 10                	mov    %edx,(%eax)
  800786:	8b 45 08             	mov    0x8(%ebp),%eax
  800789:	8b 00                	mov    (%eax),%eax
  80078b:	83 e8 08             	sub    $0x8,%eax
  80078e:	8b 50 04             	mov    0x4(%eax),%edx
  800791:	8b 00                	mov    (%eax),%eax
  800793:	eb 38                	jmp    8007cd <getint+0x5d>
	else if (lflag)
  800795:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800799:	74 1a                	je     8007b5 <getint+0x45>
		return va_arg(*ap, long);
  80079b:	8b 45 08             	mov    0x8(%ebp),%eax
  80079e:	8b 00                	mov    (%eax),%eax
  8007a0:	8d 50 04             	lea    0x4(%eax),%edx
  8007a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a6:	89 10                	mov    %edx,(%eax)
  8007a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ab:	8b 00                	mov    (%eax),%eax
  8007ad:	83 e8 04             	sub    $0x4,%eax
  8007b0:	8b 00                	mov    (%eax),%eax
  8007b2:	99                   	cltd   
  8007b3:	eb 18                	jmp    8007cd <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b8:	8b 00                	mov    (%eax),%eax
  8007ba:	8d 50 04             	lea    0x4(%eax),%edx
  8007bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c0:	89 10                	mov    %edx,(%eax)
  8007c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c5:	8b 00                	mov    (%eax),%eax
  8007c7:	83 e8 04             	sub    $0x4,%eax
  8007ca:	8b 00                	mov    (%eax),%eax
  8007cc:	99                   	cltd   
}
  8007cd:	5d                   	pop    %ebp
  8007ce:	c3                   	ret    

008007cf <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007cf:	55                   	push   %ebp
  8007d0:	89 e5                	mov    %esp,%ebp
  8007d2:	56                   	push   %esi
  8007d3:	53                   	push   %ebx
  8007d4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007d7:	eb 17                	jmp    8007f0 <vprintfmt+0x21>
			if (ch == '\0')
  8007d9:	85 db                	test   %ebx,%ebx
  8007db:	0f 84 af 03 00 00    	je     800b90 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007e1:	83 ec 08             	sub    $0x8,%esp
  8007e4:	ff 75 0c             	pushl  0xc(%ebp)
  8007e7:	53                   	push   %ebx
  8007e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007eb:	ff d0                	call   *%eax
  8007ed:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f3:	8d 50 01             	lea    0x1(%eax),%edx
  8007f6:	89 55 10             	mov    %edx,0x10(%ebp)
  8007f9:	8a 00                	mov    (%eax),%al
  8007fb:	0f b6 d8             	movzbl %al,%ebx
  8007fe:	83 fb 25             	cmp    $0x25,%ebx
  800801:	75 d6                	jne    8007d9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800803:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800807:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80080e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800815:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80081c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800823:	8b 45 10             	mov    0x10(%ebp),%eax
  800826:	8d 50 01             	lea    0x1(%eax),%edx
  800829:	89 55 10             	mov    %edx,0x10(%ebp)
  80082c:	8a 00                	mov    (%eax),%al
  80082e:	0f b6 d8             	movzbl %al,%ebx
  800831:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800834:	83 f8 55             	cmp    $0x55,%eax
  800837:	0f 87 2b 03 00 00    	ja     800b68 <vprintfmt+0x399>
  80083d:	8b 04 85 98 22 80 00 	mov    0x802298(,%eax,4),%eax
  800844:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800846:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80084a:	eb d7                	jmp    800823 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80084c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800850:	eb d1                	jmp    800823 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800852:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800859:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80085c:	89 d0                	mov    %edx,%eax
  80085e:	c1 e0 02             	shl    $0x2,%eax
  800861:	01 d0                	add    %edx,%eax
  800863:	01 c0                	add    %eax,%eax
  800865:	01 d8                	add    %ebx,%eax
  800867:	83 e8 30             	sub    $0x30,%eax
  80086a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80086d:	8b 45 10             	mov    0x10(%ebp),%eax
  800870:	8a 00                	mov    (%eax),%al
  800872:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800875:	83 fb 2f             	cmp    $0x2f,%ebx
  800878:	7e 3e                	jle    8008b8 <vprintfmt+0xe9>
  80087a:	83 fb 39             	cmp    $0x39,%ebx
  80087d:	7f 39                	jg     8008b8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80087f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800882:	eb d5                	jmp    800859 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800884:	8b 45 14             	mov    0x14(%ebp),%eax
  800887:	83 c0 04             	add    $0x4,%eax
  80088a:	89 45 14             	mov    %eax,0x14(%ebp)
  80088d:	8b 45 14             	mov    0x14(%ebp),%eax
  800890:	83 e8 04             	sub    $0x4,%eax
  800893:	8b 00                	mov    (%eax),%eax
  800895:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800898:	eb 1f                	jmp    8008b9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80089a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80089e:	79 83                	jns    800823 <vprintfmt+0x54>
				width = 0;
  8008a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008a7:	e9 77 ff ff ff       	jmp    800823 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008ac:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008b3:	e9 6b ff ff ff       	jmp    800823 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008b8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008b9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008bd:	0f 89 60 ff ff ff    	jns    800823 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008c9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008d0:	e9 4e ff ff ff       	jmp    800823 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008d5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008d8:	e9 46 ff ff ff       	jmp    800823 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e0:	83 c0 04             	add    $0x4,%eax
  8008e3:	89 45 14             	mov    %eax,0x14(%ebp)
  8008e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e9:	83 e8 04             	sub    $0x4,%eax
  8008ec:	8b 00                	mov    (%eax),%eax
  8008ee:	83 ec 08             	sub    $0x8,%esp
  8008f1:	ff 75 0c             	pushl  0xc(%ebp)
  8008f4:	50                   	push   %eax
  8008f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f8:	ff d0                	call   *%eax
  8008fa:	83 c4 10             	add    $0x10,%esp
			break;
  8008fd:	e9 89 02 00 00       	jmp    800b8b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800902:	8b 45 14             	mov    0x14(%ebp),%eax
  800905:	83 c0 04             	add    $0x4,%eax
  800908:	89 45 14             	mov    %eax,0x14(%ebp)
  80090b:	8b 45 14             	mov    0x14(%ebp),%eax
  80090e:	83 e8 04             	sub    $0x4,%eax
  800911:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800913:	85 db                	test   %ebx,%ebx
  800915:	79 02                	jns    800919 <vprintfmt+0x14a>
				err = -err;
  800917:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800919:	83 fb 64             	cmp    $0x64,%ebx
  80091c:	7f 0b                	jg     800929 <vprintfmt+0x15a>
  80091e:	8b 34 9d e0 20 80 00 	mov    0x8020e0(,%ebx,4),%esi
  800925:	85 f6                	test   %esi,%esi
  800927:	75 19                	jne    800942 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800929:	53                   	push   %ebx
  80092a:	68 85 22 80 00       	push   $0x802285
  80092f:	ff 75 0c             	pushl  0xc(%ebp)
  800932:	ff 75 08             	pushl  0x8(%ebp)
  800935:	e8 5e 02 00 00       	call   800b98 <printfmt>
  80093a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80093d:	e9 49 02 00 00       	jmp    800b8b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800942:	56                   	push   %esi
  800943:	68 8e 22 80 00       	push   $0x80228e
  800948:	ff 75 0c             	pushl  0xc(%ebp)
  80094b:	ff 75 08             	pushl  0x8(%ebp)
  80094e:	e8 45 02 00 00       	call   800b98 <printfmt>
  800953:	83 c4 10             	add    $0x10,%esp
			break;
  800956:	e9 30 02 00 00       	jmp    800b8b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80095b:	8b 45 14             	mov    0x14(%ebp),%eax
  80095e:	83 c0 04             	add    $0x4,%eax
  800961:	89 45 14             	mov    %eax,0x14(%ebp)
  800964:	8b 45 14             	mov    0x14(%ebp),%eax
  800967:	83 e8 04             	sub    $0x4,%eax
  80096a:	8b 30                	mov    (%eax),%esi
  80096c:	85 f6                	test   %esi,%esi
  80096e:	75 05                	jne    800975 <vprintfmt+0x1a6>
				p = "(null)";
  800970:	be 91 22 80 00       	mov    $0x802291,%esi
			if (width > 0 && padc != '-')
  800975:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800979:	7e 6d                	jle    8009e8 <vprintfmt+0x219>
  80097b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80097f:	74 67                	je     8009e8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800981:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800984:	83 ec 08             	sub    $0x8,%esp
  800987:	50                   	push   %eax
  800988:	56                   	push   %esi
  800989:	e8 0c 03 00 00       	call   800c9a <strnlen>
  80098e:	83 c4 10             	add    $0x10,%esp
  800991:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800994:	eb 16                	jmp    8009ac <vprintfmt+0x1dd>
					putch(padc, putdat);
  800996:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80099a:	83 ec 08             	sub    $0x8,%esp
  80099d:	ff 75 0c             	pushl  0xc(%ebp)
  8009a0:	50                   	push   %eax
  8009a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a4:	ff d0                	call   *%eax
  8009a6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009a9:	ff 4d e4             	decl   -0x1c(%ebp)
  8009ac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009b0:	7f e4                	jg     800996 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009b2:	eb 34                	jmp    8009e8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009b4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009b8:	74 1c                	je     8009d6 <vprintfmt+0x207>
  8009ba:	83 fb 1f             	cmp    $0x1f,%ebx
  8009bd:	7e 05                	jle    8009c4 <vprintfmt+0x1f5>
  8009bf:	83 fb 7e             	cmp    $0x7e,%ebx
  8009c2:	7e 12                	jle    8009d6 <vprintfmt+0x207>
					putch('?', putdat);
  8009c4:	83 ec 08             	sub    $0x8,%esp
  8009c7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ca:	6a 3f                	push   $0x3f
  8009cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cf:	ff d0                	call   *%eax
  8009d1:	83 c4 10             	add    $0x10,%esp
  8009d4:	eb 0f                	jmp    8009e5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009d6:	83 ec 08             	sub    $0x8,%esp
  8009d9:	ff 75 0c             	pushl  0xc(%ebp)
  8009dc:	53                   	push   %ebx
  8009dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e0:	ff d0                	call   *%eax
  8009e2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009e5:	ff 4d e4             	decl   -0x1c(%ebp)
  8009e8:	89 f0                	mov    %esi,%eax
  8009ea:	8d 70 01             	lea    0x1(%eax),%esi
  8009ed:	8a 00                	mov    (%eax),%al
  8009ef:	0f be d8             	movsbl %al,%ebx
  8009f2:	85 db                	test   %ebx,%ebx
  8009f4:	74 24                	je     800a1a <vprintfmt+0x24b>
  8009f6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009fa:	78 b8                	js     8009b4 <vprintfmt+0x1e5>
  8009fc:	ff 4d e0             	decl   -0x20(%ebp)
  8009ff:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a03:	79 af                	jns    8009b4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a05:	eb 13                	jmp    800a1a <vprintfmt+0x24b>
				putch(' ', putdat);
  800a07:	83 ec 08             	sub    $0x8,%esp
  800a0a:	ff 75 0c             	pushl  0xc(%ebp)
  800a0d:	6a 20                	push   $0x20
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	ff d0                	call   *%eax
  800a14:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a17:	ff 4d e4             	decl   -0x1c(%ebp)
  800a1a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a1e:	7f e7                	jg     800a07 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a20:	e9 66 01 00 00       	jmp    800b8b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a25:	83 ec 08             	sub    $0x8,%esp
  800a28:	ff 75 e8             	pushl  -0x18(%ebp)
  800a2b:	8d 45 14             	lea    0x14(%ebp),%eax
  800a2e:	50                   	push   %eax
  800a2f:	e8 3c fd ff ff       	call   800770 <getint>
  800a34:	83 c4 10             	add    $0x10,%esp
  800a37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a40:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a43:	85 d2                	test   %edx,%edx
  800a45:	79 23                	jns    800a6a <vprintfmt+0x29b>
				putch('-', putdat);
  800a47:	83 ec 08             	sub    $0x8,%esp
  800a4a:	ff 75 0c             	pushl  0xc(%ebp)
  800a4d:	6a 2d                	push   $0x2d
  800a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a52:	ff d0                	call   *%eax
  800a54:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a5d:	f7 d8                	neg    %eax
  800a5f:	83 d2 00             	adc    $0x0,%edx
  800a62:	f7 da                	neg    %edx
  800a64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a67:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a6a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a71:	e9 bc 00 00 00       	jmp    800b32 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a76:	83 ec 08             	sub    $0x8,%esp
  800a79:	ff 75 e8             	pushl  -0x18(%ebp)
  800a7c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a7f:	50                   	push   %eax
  800a80:	e8 84 fc ff ff       	call   800709 <getuint>
  800a85:	83 c4 10             	add    $0x10,%esp
  800a88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a8e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a95:	e9 98 00 00 00       	jmp    800b32 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a9a:	83 ec 08             	sub    $0x8,%esp
  800a9d:	ff 75 0c             	pushl  0xc(%ebp)
  800aa0:	6a 58                	push   $0x58
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa5:	ff d0                	call   *%eax
  800aa7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aaa:	83 ec 08             	sub    $0x8,%esp
  800aad:	ff 75 0c             	pushl  0xc(%ebp)
  800ab0:	6a 58                	push   $0x58
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	ff d0                	call   *%eax
  800ab7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aba:	83 ec 08             	sub    $0x8,%esp
  800abd:	ff 75 0c             	pushl  0xc(%ebp)
  800ac0:	6a 58                	push   $0x58
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	ff d0                	call   *%eax
  800ac7:	83 c4 10             	add    $0x10,%esp
			break;
  800aca:	e9 bc 00 00 00       	jmp    800b8b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800acf:	83 ec 08             	sub    $0x8,%esp
  800ad2:	ff 75 0c             	pushl  0xc(%ebp)
  800ad5:	6a 30                	push   $0x30
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	ff d0                	call   *%eax
  800adc:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800adf:	83 ec 08             	sub    $0x8,%esp
  800ae2:	ff 75 0c             	pushl  0xc(%ebp)
  800ae5:	6a 78                	push   $0x78
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	ff d0                	call   *%eax
  800aec:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800aef:	8b 45 14             	mov    0x14(%ebp),%eax
  800af2:	83 c0 04             	add    $0x4,%eax
  800af5:	89 45 14             	mov    %eax,0x14(%ebp)
  800af8:	8b 45 14             	mov    0x14(%ebp),%eax
  800afb:	83 e8 04             	sub    $0x4,%eax
  800afe:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b00:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b03:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b0a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b11:	eb 1f                	jmp    800b32 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b13:	83 ec 08             	sub    $0x8,%esp
  800b16:	ff 75 e8             	pushl  -0x18(%ebp)
  800b19:	8d 45 14             	lea    0x14(%ebp),%eax
  800b1c:	50                   	push   %eax
  800b1d:	e8 e7 fb ff ff       	call   800709 <getuint>
  800b22:	83 c4 10             	add    $0x10,%esp
  800b25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b28:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b2b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b32:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b36:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b39:	83 ec 04             	sub    $0x4,%esp
  800b3c:	52                   	push   %edx
  800b3d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b40:	50                   	push   %eax
  800b41:	ff 75 f4             	pushl  -0xc(%ebp)
  800b44:	ff 75 f0             	pushl  -0x10(%ebp)
  800b47:	ff 75 0c             	pushl  0xc(%ebp)
  800b4a:	ff 75 08             	pushl  0x8(%ebp)
  800b4d:	e8 00 fb ff ff       	call   800652 <printnum>
  800b52:	83 c4 20             	add    $0x20,%esp
			break;
  800b55:	eb 34                	jmp    800b8b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b57:	83 ec 08             	sub    $0x8,%esp
  800b5a:	ff 75 0c             	pushl  0xc(%ebp)
  800b5d:	53                   	push   %ebx
  800b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b61:	ff d0                	call   *%eax
  800b63:	83 c4 10             	add    $0x10,%esp
			break;
  800b66:	eb 23                	jmp    800b8b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b68:	83 ec 08             	sub    $0x8,%esp
  800b6b:	ff 75 0c             	pushl  0xc(%ebp)
  800b6e:	6a 25                	push   $0x25
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
  800b73:	ff d0                	call   *%eax
  800b75:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b78:	ff 4d 10             	decl   0x10(%ebp)
  800b7b:	eb 03                	jmp    800b80 <vprintfmt+0x3b1>
  800b7d:	ff 4d 10             	decl   0x10(%ebp)
  800b80:	8b 45 10             	mov    0x10(%ebp),%eax
  800b83:	48                   	dec    %eax
  800b84:	8a 00                	mov    (%eax),%al
  800b86:	3c 25                	cmp    $0x25,%al
  800b88:	75 f3                	jne    800b7d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b8a:	90                   	nop
		}
	}
  800b8b:	e9 47 fc ff ff       	jmp    8007d7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b90:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b91:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b94:	5b                   	pop    %ebx
  800b95:	5e                   	pop    %esi
  800b96:	5d                   	pop    %ebp
  800b97:	c3                   	ret    

00800b98 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b98:	55                   	push   %ebp
  800b99:	89 e5                	mov    %esp,%ebp
  800b9b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b9e:	8d 45 10             	lea    0x10(%ebp),%eax
  800ba1:	83 c0 04             	add    $0x4,%eax
  800ba4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ba7:	8b 45 10             	mov    0x10(%ebp),%eax
  800baa:	ff 75 f4             	pushl  -0xc(%ebp)
  800bad:	50                   	push   %eax
  800bae:	ff 75 0c             	pushl  0xc(%ebp)
  800bb1:	ff 75 08             	pushl  0x8(%ebp)
  800bb4:	e8 16 fc ff ff       	call   8007cf <vprintfmt>
  800bb9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bbc:	90                   	nop
  800bbd:	c9                   	leave  
  800bbe:	c3                   	ret    

00800bbf <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bbf:	55                   	push   %ebp
  800bc0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc5:	8b 40 08             	mov    0x8(%eax),%eax
  800bc8:	8d 50 01             	lea    0x1(%eax),%edx
  800bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bce:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd4:	8b 10                	mov    (%eax),%edx
  800bd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd9:	8b 40 04             	mov    0x4(%eax),%eax
  800bdc:	39 c2                	cmp    %eax,%edx
  800bde:	73 12                	jae    800bf2 <sprintputch+0x33>
		*b->buf++ = ch;
  800be0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be3:	8b 00                	mov    (%eax),%eax
  800be5:	8d 48 01             	lea    0x1(%eax),%ecx
  800be8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800beb:	89 0a                	mov    %ecx,(%edx)
  800bed:	8b 55 08             	mov    0x8(%ebp),%edx
  800bf0:	88 10                	mov    %dl,(%eax)
}
  800bf2:	90                   	nop
  800bf3:	5d                   	pop    %ebp
  800bf4:	c3                   	ret    

00800bf5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bf5:	55                   	push   %ebp
  800bf6:	89 e5                	mov    %esp,%ebp
  800bf8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c04:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	01 d0                	add    %edx,%eax
  800c0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c16:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c1a:	74 06                	je     800c22 <vsnprintf+0x2d>
  800c1c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c20:	7f 07                	jg     800c29 <vsnprintf+0x34>
		return -E_INVAL;
  800c22:	b8 03 00 00 00       	mov    $0x3,%eax
  800c27:	eb 20                	jmp    800c49 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c29:	ff 75 14             	pushl  0x14(%ebp)
  800c2c:	ff 75 10             	pushl  0x10(%ebp)
  800c2f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c32:	50                   	push   %eax
  800c33:	68 bf 0b 80 00       	push   $0x800bbf
  800c38:	e8 92 fb ff ff       	call   8007cf <vprintfmt>
  800c3d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c40:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c43:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c46:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c49:	c9                   	leave  
  800c4a:	c3                   	ret    

00800c4b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c4b:	55                   	push   %ebp
  800c4c:	89 e5                	mov    %esp,%ebp
  800c4e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c51:	8d 45 10             	lea    0x10(%ebp),%eax
  800c54:	83 c0 04             	add    $0x4,%eax
  800c57:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5d:	ff 75 f4             	pushl  -0xc(%ebp)
  800c60:	50                   	push   %eax
  800c61:	ff 75 0c             	pushl  0xc(%ebp)
  800c64:	ff 75 08             	pushl  0x8(%ebp)
  800c67:	e8 89 ff ff ff       	call   800bf5 <vsnprintf>
  800c6c:	83 c4 10             	add    $0x10,%esp
  800c6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c72:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c75:	c9                   	leave  
  800c76:	c3                   	ret    

00800c77 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c77:	55                   	push   %ebp
  800c78:	89 e5                	mov    %esp,%ebp
  800c7a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c84:	eb 06                	jmp    800c8c <strlen+0x15>
		n++;
  800c86:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c89:	ff 45 08             	incl   0x8(%ebp)
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8f:	8a 00                	mov    (%eax),%al
  800c91:	84 c0                	test   %al,%al
  800c93:	75 f1                	jne    800c86 <strlen+0xf>
		n++;
	return n;
  800c95:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c98:	c9                   	leave  
  800c99:	c3                   	ret    

00800c9a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c9a:	55                   	push   %ebp
  800c9b:	89 e5                	mov    %esp,%ebp
  800c9d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ca0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ca7:	eb 09                	jmp    800cb2 <strnlen+0x18>
		n++;
  800ca9:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cac:	ff 45 08             	incl   0x8(%ebp)
  800caf:	ff 4d 0c             	decl   0xc(%ebp)
  800cb2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cb6:	74 09                	je     800cc1 <strnlen+0x27>
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	8a 00                	mov    (%eax),%al
  800cbd:	84 c0                	test   %al,%al
  800cbf:	75 e8                	jne    800ca9 <strnlen+0xf>
		n++;
	return n;
  800cc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cc4:	c9                   	leave  
  800cc5:	c3                   	ret    

00800cc6 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cc6:	55                   	push   %ebp
  800cc7:	89 e5                	mov    %esp,%ebp
  800cc9:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cd2:	90                   	nop
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	8d 50 01             	lea    0x1(%eax),%edx
  800cd9:	89 55 08             	mov    %edx,0x8(%ebp)
  800cdc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cdf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ce2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ce5:	8a 12                	mov    (%edx),%dl
  800ce7:	88 10                	mov    %dl,(%eax)
  800ce9:	8a 00                	mov    (%eax),%al
  800ceb:	84 c0                	test   %al,%al
  800ced:	75 e4                	jne    800cd3 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cf2:	c9                   	leave  
  800cf3:	c3                   	ret    

00800cf4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cf4:	55                   	push   %ebp
  800cf5:	89 e5                	mov    %esp,%ebp
  800cf7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d00:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d07:	eb 1f                	jmp    800d28 <strncpy+0x34>
		*dst++ = *src;
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8d 50 01             	lea    0x1(%eax),%edx
  800d0f:	89 55 08             	mov    %edx,0x8(%ebp)
  800d12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d15:	8a 12                	mov    (%edx),%dl
  800d17:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	84 c0                	test   %al,%al
  800d20:	74 03                	je     800d25 <strncpy+0x31>
			src++;
  800d22:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d25:	ff 45 fc             	incl   -0x4(%ebp)
  800d28:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d2b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d2e:	72 d9                	jb     800d09 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d30:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d33:	c9                   	leave  
  800d34:	c3                   	ret    

00800d35 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d35:	55                   	push   %ebp
  800d36:	89 e5                	mov    %esp,%ebp
  800d38:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d41:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d45:	74 30                	je     800d77 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d47:	eb 16                	jmp    800d5f <strlcpy+0x2a>
			*dst++ = *src++;
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	8d 50 01             	lea    0x1(%eax),%edx
  800d4f:	89 55 08             	mov    %edx,0x8(%ebp)
  800d52:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d55:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d58:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d5b:	8a 12                	mov    (%edx),%dl
  800d5d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d5f:	ff 4d 10             	decl   0x10(%ebp)
  800d62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d66:	74 09                	je     800d71 <strlcpy+0x3c>
  800d68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6b:	8a 00                	mov    (%eax),%al
  800d6d:	84 c0                	test   %al,%al
  800d6f:	75 d8                	jne    800d49 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d77:	8b 55 08             	mov    0x8(%ebp),%edx
  800d7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d7d:	29 c2                	sub    %eax,%edx
  800d7f:	89 d0                	mov    %edx,%eax
}
  800d81:	c9                   	leave  
  800d82:	c3                   	ret    

00800d83 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d83:	55                   	push   %ebp
  800d84:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d86:	eb 06                	jmp    800d8e <strcmp+0xb>
		p++, q++;
  800d88:	ff 45 08             	incl   0x8(%ebp)
  800d8b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	8a 00                	mov    (%eax),%al
  800d93:	84 c0                	test   %al,%al
  800d95:	74 0e                	je     800da5 <strcmp+0x22>
  800d97:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9a:	8a 10                	mov    (%eax),%dl
  800d9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	38 c2                	cmp    %al,%dl
  800da3:	74 e3                	je     800d88 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	8a 00                	mov    (%eax),%al
  800daa:	0f b6 d0             	movzbl %al,%edx
  800dad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db0:	8a 00                	mov    (%eax),%al
  800db2:	0f b6 c0             	movzbl %al,%eax
  800db5:	29 c2                	sub    %eax,%edx
  800db7:	89 d0                	mov    %edx,%eax
}
  800db9:	5d                   	pop    %ebp
  800dba:	c3                   	ret    

00800dbb <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800dbb:	55                   	push   %ebp
  800dbc:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800dbe:	eb 09                	jmp    800dc9 <strncmp+0xe>
		n--, p++, q++;
  800dc0:	ff 4d 10             	decl   0x10(%ebp)
  800dc3:	ff 45 08             	incl   0x8(%ebp)
  800dc6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dc9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dcd:	74 17                	je     800de6 <strncmp+0x2b>
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	8a 00                	mov    (%eax),%al
  800dd4:	84 c0                	test   %al,%al
  800dd6:	74 0e                	je     800de6 <strncmp+0x2b>
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	8a 10                	mov    (%eax),%dl
  800ddd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	38 c2                	cmp    %al,%dl
  800de4:	74 da                	je     800dc0 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800de6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dea:	75 07                	jne    800df3 <strncmp+0x38>
		return 0;
  800dec:	b8 00 00 00 00       	mov    $0x0,%eax
  800df1:	eb 14                	jmp    800e07 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	8a 00                	mov    (%eax),%al
  800df8:	0f b6 d0             	movzbl %al,%edx
  800dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfe:	8a 00                	mov    (%eax),%al
  800e00:	0f b6 c0             	movzbl %al,%eax
  800e03:	29 c2                	sub    %eax,%edx
  800e05:	89 d0                	mov    %edx,%eax
}
  800e07:	5d                   	pop    %ebp
  800e08:	c3                   	ret    

00800e09 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e09:	55                   	push   %ebp
  800e0a:	89 e5                	mov    %esp,%ebp
  800e0c:	83 ec 04             	sub    $0x4,%esp
  800e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e12:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e15:	eb 12                	jmp    800e29 <strchr+0x20>
		if (*s == c)
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	8a 00                	mov    (%eax),%al
  800e1c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e1f:	75 05                	jne    800e26 <strchr+0x1d>
			return (char *) s;
  800e21:	8b 45 08             	mov    0x8(%ebp),%eax
  800e24:	eb 11                	jmp    800e37 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e26:	ff 45 08             	incl   0x8(%ebp)
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	84 c0                	test   %al,%al
  800e30:	75 e5                	jne    800e17 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e32:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e37:	c9                   	leave  
  800e38:	c3                   	ret    

00800e39 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e39:	55                   	push   %ebp
  800e3a:	89 e5                	mov    %esp,%ebp
  800e3c:	83 ec 04             	sub    $0x4,%esp
  800e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e42:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e45:	eb 0d                	jmp    800e54 <strfind+0x1b>
		if (*s == c)
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e4f:	74 0e                	je     800e5f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e51:	ff 45 08             	incl   0x8(%ebp)
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	8a 00                	mov    (%eax),%al
  800e59:	84 c0                	test   %al,%al
  800e5b:	75 ea                	jne    800e47 <strfind+0xe>
  800e5d:	eb 01                	jmp    800e60 <strfind+0x27>
		if (*s == c)
			break;
  800e5f:	90                   	nop
	return (char *) s;
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e63:	c9                   	leave  
  800e64:	c3                   	ret    

00800e65 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e65:	55                   	push   %ebp
  800e66:	89 e5                	mov    %esp,%ebp
  800e68:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e71:	8b 45 10             	mov    0x10(%ebp),%eax
  800e74:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e77:	eb 0e                	jmp    800e87 <memset+0x22>
		*p++ = c;
  800e79:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7c:	8d 50 01             	lea    0x1(%eax),%edx
  800e7f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e82:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e85:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e87:	ff 4d f8             	decl   -0x8(%ebp)
  800e8a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e8e:	79 e9                	jns    800e79 <memset+0x14>
		*p++ = c;

	return v;
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e93:	c9                   	leave  
  800e94:	c3                   	ret    

00800e95 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e95:	55                   	push   %ebp
  800e96:	89 e5                	mov    %esp,%ebp
  800e98:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ea7:	eb 16                	jmp    800ebf <memcpy+0x2a>
		*d++ = *s++;
  800ea9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eac:	8d 50 01             	lea    0x1(%eax),%edx
  800eaf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eb2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eb5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eb8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ebb:	8a 12                	mov    (%edx),%dl
  800ebd:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ebf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec5:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec8:	85 c0                	test   %eax,%eax
  800eca:	75 dd                	jne    800ea9 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ecf:	c9                   	leave  
  800ed0:	c3                   	ret    

00800ed1 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ed1:	55                   	push   %ebp
  800ed2:	89 e5                	mov    %esp,%ebp
  800ed4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800ed7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ee3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ee9:	73 50                	jae    800f3b <memmove+0x6a>
  800eeb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eee:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef1:	01 d0                	add    %edx,%eax
  800ef3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ef6:	76 43                	jbe    800f3b <memmove+0x6a>
		s += n;
  800ef8:	8b 45 10             	mov    0x10(%ebp),%eax
  800efb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800efe:	8b 45 10             	mov    0x10(%ebp),%eax
  800f01:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f04:	eb 10                	jmp    800f16 <memmove+0x45>
			*--d = *--s;
  800f06:	ff 4d f8             	decl   -0x8(%ebp)
  800f09:	ff 4d fc             	decl   -0x4(%ebp)
  800f0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0f:	8a 10                	mov    (%eax),%dl
  800f11:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f14:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f16:	8b 45 10             	mov    0x10(%ebp),%eax
  800f19:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f1c:	89 55 10             	mov    %edx,0x10(%ebp)
  800f1f:	85 c0                	test   %eax,%eax
  800f21:	75 e3                	jne    800f06 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f23:	eb 23                	jmp    800f48 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f25:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f28:	8d 50 01             	lea    0x1(%eax),%edx
  800f2b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f2e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f31:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f34:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f37:	8a 12                	mov    (%edx),%dl
  800f39:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f41:	89 55 10             	mov    %edx,0x10(%ebp)
  800f44:	85 c0                	test   %eax,%eax
  800f46:	75 dd                	jne    800f25 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f48:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4b:	c9                   	leave  
  800f4c:	c3                   	ret    

00800f4d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f4d:	55                   	push   %ebp
  800f4e:	89 e5                	mov    %esp,%ebp
  800f50:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f5f:	eb 2a                	jmp    800f8b <memcmp+0x3e>
		if (*s1 != *s2)
  800f61:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f64:	8a 10                	mov    (%eax),%dl
  800f66:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f69:	8a 00                	mov    (%eax),%al
  800f6b:	38 c2                	cmp    %al,%dl
  800f6d:	74 16                	je     800f85 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f6f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	0f b6 d0             	movzbl %al,%edx
  800f77:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	0f b6 c0             	movzbl %al,%eax
  800f7f:	29 c2                	sub    %eax,%edx
  800f81:	89 d0                	mov    %edx,%eax
  800f83:	eb 18                	jmp    800f9d <memcmp+0x50>
		s1++, s2++;
  800f85:	ff 45 fc             	incl   -0x4(%ebp)
  800f88:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f91:	89 55 10             	mov    %edx,0x10(%ebp)
  800f94:	85 c0                	test   %eax,%eax
  800f96:	75 c9                	jne    800f61 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f98:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f9d:	c9                   	leave  
  800f9e:	c3                   	ret    

00800f9f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f9f:	55                   	push   %ebp
  800fa0:	89 e5                	mov    %esp,%ebp
  800fa2:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800fa5:	8b 55 08             	mov    0x8(%ebp),%edx
  800fa8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fab:	01 d0                	add    %edx,%eax
  800fad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fb0:	eb 15                	jmp    800fc7 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	8a 00                	mov    (%eax),%al
  800fb7:	0f b6 d0             	movzbl %al,%edx
  800fba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbd:	0f b6 c0             	movzbl %al,%eax
  800fc0:	39 c2                	cmp    %eax,%edx
  800fc2:	74 0d                	je     800fd1 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fc4:	ff 45 08             	incl   0x8(%ebp)
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fcd:	72 e3                	jb     800fb2 <memfind+0x13>
  800fcf:	eb 01                	jmp    800fd2 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fd1:	90                   	nop
	return (void *) s;
  800fd2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fd5:	c9                   	leave  
  800fd6:	c3                   	ret    

00800fd7 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fd7:	55                   	push   %ebp
  800fd8:	89 e5                	mov    %esp,%ebp
  800fda:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fdd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fe4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800feb:	eb 03                	jmp    800ff0 <strtol+0x19>
		s++;
  800fed:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff3:	8a 00                	mov    (%eax),%al
  800ff5:	3c 20                	cmp    $0x20,%al
  800ff7:	74 f4                	je     800fed <strtol+0x16>
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	3c 09                	cmp    $0x9,%al
  801000:	74 eb                	je     800fed <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8a 00                	mov    (%eax),%al
  801007:	3c 2b                	cmp    $0x2b,%al
  801009:	75 05                	jne    801010 <strtol+0x39>
		s++;
  80100b:	ff 45 08             	incl   0x8(%ebp)
  80100e:	eb 13                	jmp    801023 <strtol+0x4c>
	else if (*s == '-')
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	8a 00                	mov    (%eax),%al
  801015:	3c 2d                	cmp    $0x2d,%al
  801017:	75 0a                	jne    801023 <strtol+0x4c>
		s++, neg = 1;
  801019:	ff 45 08             	incl   0x8(%ebp)
  80101c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801023:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801027:	74 06                	je     80102f <strtol+0x58>
  801029:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80102d:	75 20                	jne    80104f <strtol+0x78>
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	8a 00                	mov    (%eax),%al
  801034:	3c 30                	cmp    $0x30,%al
  801036:	75 17                	jne    80104f <strtol+0x78>
  801038:	8b 45 08             	mov    0x8(%ebp),%eax
  80103b:	40                   	inc    %eax
  80103c:	8a 00                	mov    (%eax),%al
  80103e:	3c 78                	cmp    $0x78,%al
  801040:	75 0d                	jne    80104f <strtol+0x78>
		s += 2, base = 16;
  801042:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801046:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80104d:	eb 28                	jmp    801077 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80104f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801053:	75 15                	jne    80106a <strtol+0x93>
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	8a 00                	mov    (%eax),%al
  80105a:	3c 30                	cmp    $0x30,%al
  80105c:	75 0c                	jne    80106a <strtol+0x93>
		s++, base = 8;
  80105e:	ff 45 08             	incl   0x8(%ebp)
  801061:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801068:	eb 0d                	jmp    801077 <strtol+0xa0>
	else if (base == 0)
  80106a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80106e:	75 07                	jne    801077 <strtol+0xa0>
		base = 10;
  801070:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	8a 00                	mov    (%eax),%al
  80107c:	3c 2f                	cmp    $0x2f,%al
  80107e:	7e 19                	jle    801099 <strtol+0xc2>
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	8a 00                	mov    (%eax),%al
  801085:	3c 39                	cmp    $0x39,%al
  801087:	7f 10                	jg     801099 <strtol+0xc2>
			dig = *s - '0';
  801089:	8b 45 08             	mov    0x8(%ebp),%eax
  80108c:	8a 00                	mov    (%eax),%al
  80108e:	0f be c0             	movsbl %al,%eax
  801091:	83 e8 30             	sub    $0x30,%eax
  801094:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801097:	eb 42                	jmp    8010db <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	8a 00                	mov    (%eax),%al
  80109e:	3c 60                	cmp    $0x60,%al
  8010a0:	7e 19                	jle    8010bb <strtol+0xe4>
  8010a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a5:	8a 00                	mov    (%eax),%al
  8010a7:	3c 7a                	cmp    $0x7a,%al
  8010a9:	7f 10                	jg     8010bb <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ae:	8a 00                	mov    (%eax),%al
  8010b0:	0f be c0             	movsbl %al,%eax
  8010b3:	83 e8 57             	sub    $0x57,%eax
  8010b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010b9:	eb 20                	jmp    8010db <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	8a 00                	mov    (%eax),%al
  8010c0:	3c 40                	cmp    $0x40,%al
  8010c2:	7e 39                	jle    8010fd <strtol+0x126>
  8010c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c7:	8a 00                	mov    (%eax),%al
  8010c9:	3c 5a                	cmp    $0x5a,%al
  8010cb:	7f 30                	jg     8010fd <strtol+0x126>
			dig = *s - 'A' + 10;
  8010cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d0:	8a 00                	mov    (%eax),%al
  8010d2:	0f be c0             	movsbl %al,%eax
  8010d5:	83 e8 37             	sub    $0x37,%eax
  8010d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010de:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010e1:	7d 19                	jge    8010fc <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010e3:	ff 45 08             	incl   0x8(%ebp)
  8010e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e9:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010ed:	89 c2                	mov    %eax,%edx
  8010ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010f2:	01 d0                	add    %edx,%eax
  8010f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010f7:	e9 7b ff ff ff       	jmp    801077 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010fc:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801101:	74 08                	je     80110b <strtol+0x134>
		*endptr = (char *) s;
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	8b 55 08             	mov    0x8(%ebp),%edx
  801109:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80110b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80110f:	74 07                	je     801118 <strtol+0x141>
  801111:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801114:	f7 d8                	neg    %eax
  801116:	eb 03                	jmp    80111b <strtol+0x144>
  801118:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <ltostr>:

void
ltostr(long value, char *str)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
  801120:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801123:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80112a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801131:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801135:	79 13                	jns    80114a <ltostr+0x2d>
	{
		neg = 1;
  801137:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80113e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801141:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801144:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801147:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80114a:	8b 45 08             	mov    0x8(%ebp),%eax
  80114d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801152:	99                   	cltd   
  801153:	f7 f9                	idiv   %ecx
  801155:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801158:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80115b:	8d 50 01             	lea    0x1(%eax),%edx
  80115e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801161:	89 c2                	mov    %eax,%edx
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	01 d0                	add    %edx,%eax
  801168:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80116b:	83 c2 30             	add    $0x30,%edx
  80116e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801170:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801173:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801178:	f7 e9                	imul   %ecx
  80117a:	c1 fa 02             	sar    $0x2,%edx
  80117d:	89 c8                	mov    %ecx,%eax
  80117f:	c1 f8 1f             	sar    $0x1f,%eax
  801182:	29 c2                	sub    %eax,%edx
  801184:	89 d0                	mov    %edx,%eax
  801186:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801189:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80118c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801191:	f7 e9                	imul   %ecx
  801193:	c1 fa 02             	sar    $0x2,%edx
  801196:	89 c8                	mov    %ecx,%eax
  801198:	c1 f8 1f             	sar    $0x1f,%eax
  80119b:	29 c2                	sub    %eax,%edx
  80119d:	89 d0                	mov    %edx,%eax
  80119f:	c1 e0 02             	shl    $0x2,%eax
  8011a2:	01 d0                	add    %edx,%eax
  8011a4:	01 c0                	add    %eax,%eax
  8011a6:	29 c1                	sub    %eax,%ecx
  8011a8:	89 ca                	mov    %ecx,%edx
  8011aa:	85 d2                	test   %edx,%edx
  8011ac:	75 9c                	jne    80114a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011b8:	48                   	dec    %eax
  8011b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011bc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011c0:	74 3d                	je     8011ff <ltostr+0xe2>
		start = 1 ;
  8011c2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011c9:	eb 34                	jmp    8011ff <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d1:	01 d0                	add    %edx,%eax
  8011d3:	8a 00                	mov    (%eax),%al
  8011d5:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011de:	01 c2                	add    %eax,%edx
  8011e0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e6:	01 c8                	add    %ecx,%eax
  8011e8:	8a 00                	mov    (%eax),%al
  8011ea:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011ec:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f2:	01 c2                	add    %eax,%edx
  8011f4:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011f7:	88 02                	mov    %al,(%edx)
		start++ ;
  8011f9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011fc:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801202:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801205:	7c c4                	jl     8011cb <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801207:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80120a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120d:	01 d0                	add    %edx,%eax
  80120f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801212:	90                   	nop
  801213:	c9                   	leave  
  801214:	c3                   	ret    

00801215 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801215:	55                   	push   %ebp
  801216:	89 e5                	mov    %esp,%ebp
  801218:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80121b:	ff 75 08             	pushl  0x8(%ebp)
  80121e:	e8 54 fa ff ff       	call   800c77 <strlen>
  801223:	83 c4 04             	add    $0x4,%esp
  801226:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801229:	ff 75 0c             	pushl  0xc(%ebp)
  80122c:	e8 46 fa ff ff       	call   800c77 <strlen>
  801231:	83 c4 04             	add    $0x4,%esp
  801234:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801237:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80123e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801245:	eb 17                	jmp    80125e <strcconcat+0x49>
		final[s] = str1[s] ;
  801247:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80124a:	8b 45 10             	mov    0x10(%ebp),%eax
  80124d:	01 c2                	add    %eax,%edx
  80124f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801252:	8b 45 08             	mov    0x8(%ebp),%eax
  801255:	01 c8                	add    %ecx,%eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80125b:	ff 45 fc             	incl   -0x4(%ebp)
  80125e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801261:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801264:	7c e1                	jl     801247 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801266:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80126d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801274:	eb 1f                	jmp    801295 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801276:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801279:	8d 50 01             	lea    0x1(%eax),%edx
  80127c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80127f:	89 c2                	mov    %eax,%edx
  801281:	8b 45 10             	mov    0x10(%ebp),%eax
  801284:	01 c2                	add    %eax,%edx
  801286:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128c:	01 c8                	add    %ecx,%eax
  80128e:	8a 00                	mov    (%eax),%al
  801290:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801292:	ff 45 f8             	incl   -0x8(%ebp)
  801295:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801298:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80129b:	7c d9                	jl     801276 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80129d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a3:	01 d0                	add    %edx,%eax
  8012a5:	c6 00 00             	movb   $0x0,(%eax)
}
  8012a8:	90                   	nop
  8012a9:	c9                   	leave  
  8012aa:	c3                   	ret    

008012ab <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012ab:	55                   	push   %ebp
  8012ac:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ba:	8b 00                	mov    (%eax),%eax
  8012bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c6:	01 d0                	add    %edx,%eax
  8012c8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012ce:	eb 0c                	jmp    8012dc <strsplit+0x31>
			*string++ = 0;
  8012d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d3:	8d 50 01             	lea    0x1(%eax),%edx
  8012d6:	89 55 08             	mov    %edx,0x8(%ebp)
  8012d9:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	8a 00                	mov    (%eax),%al
  8012e1:	84 c0                	test   %al,%al
  8012e3:	74 18                	je     8012fd <strsplit+0x52>
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	8a 00                	mov    (%eax),%al
  8012ea:	0f be c0             	movsbl %al,%eax
  8012ed:	50                   	push   %eax
  8012ee:	ff 75 0c             	pushl  0xc(%ebp)
  8012f1:	e8 13 fb ff ff       	call   800e09 <strchr>
  8012f6:	83 c4 08             	add    $0x8,%esp
  8012f9:	85 c0                	test   %eax,%eax
  8012fb:	75 d3                	jne    8012d0 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	8a 00                	mov    (%eax),%al
  801302:	84 c0                	test   %al,%al
  801304:	74 5a                	je     801360 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801306:	8b 45 14             	mov    0x14(%ebp),%eax
  801309:	8b 00                	mov    (%eax),%eax
  80130b:	83 f8 0f             	cmp    $0xf,%eax
  80130e:	75 07                	jne    801317 <strsplit+0x6c>
		{
			return 0;
  801310:	b8 00 00 00 00       	mov    $0x0,%eax
  801315:	eb 66                	jmp    80137d <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801317:	8b 45 14             	mov    0x14(%ebp),%eax
  80131a:	8b 00                	mov    (%eax),%eax
  80131c:	8d 48 01             	lea    0x1(%eax),%ecx
  80131f:	8b 55 14             	mov    0x14(%ebp),%edx
  801322:	89 0a                	mov    %ecx,(%edx)
  801324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80132b:	8b 45 10             	mov    0x10(%ebp),%eax
  80132e:	01 c2                	add    %eax,%edx
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801335:	eb 03                	jmp    80133a <strsplit+0x8f>
			string++;
  801337:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	8a 00                	mov    (%eax),%al
  80133f:	84 c0                	test   %al,%al
  801341:	74 8b                	je     8012ce <strsplit+0x23>
  801343:	8b 45 08             	mov    0x8(%ebp),%eax
  801346:	8a 00                	mov    (%eax),%al
  801348:	0f be c0             	movsbl %al,%eax
  80134b:	50                   	push   %eax
  80134c:	ff 75 0c             	pushl  0xc(%ebp)
  80134f:	e8 b5 fa ff ff       	call   800e09 <strchr>
  801354:	83 c4 08             	add    $0x8,%esp
  801357:	85 c0                	test   %eax,%eax
  801359:	74 dc                	je     801337 <strsplit+0x8c>
			string++;
	}
  80135b:	e9 6e ff ff ff       	jmp    8012ce <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801360:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801361:	8b 45 14             	mov    0x14(%ebp),%eax
  801364:	8b 00                	mov    (%eax),%eax
  801366:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80136d:	8b 45 10             	mov    0x10(%ebp),%eax
  801370:	01 d0                	add    %edx,%eax
  801372:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801378:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
  801382:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801385:	83 ec 04             	sub    $0x4,%esp
  801388:	68 f0 23 80 00       	push   $0x8023f0
  80138d:	6a 19                	push   $0x19
  80138f:	68 15 24 80 00       	push   $0x802415
  801394:	e8 a2 06 00 00       	call   801a3b <_panic>

00801399 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801399:	55                   	push   %ebp
  80139a:	89 e5                	mov    %esp,%ebp
  80139c:	83 ec 18             	sub    $0x18,%esp
  80139f:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a2:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8013a5:	83 ec 04             	sub    $0x4,%esp
  8013a8:	68 24 24 80 00       	push   $0x802424
  8013ad:	6a 30                	push   $0x30
  8013af:	68 15 24 80 00       	push   $0x802415
  8013b4:	e8 82 06 00 00       	call   801a3b <_panic>

008013b9 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8013b9:	55                   	push   %ebp
  8013ba:	89 e5                	mov    %esp,%ebp
  8013bc:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8013bf:	83 ec 04             	sub    $0x4,%esp
  8013c2:	68 43 24 80 00       	push   $0x802443
  8013c7:	6a 36                	push   $0x36
  8013c9:	68 15 24 80 00       	push   $0x802415
  8013ce:	e8 68 06 00 00       	call   801a3b <_panic>

008013d3 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8013d3:	55                   	push   %ebp
  8013d4:	89 e5                	mov    %esp,%ebp
  8013d6:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8013d9:	83 ec 04             	sub    $0x4,%esp
  8013dc:	68 60 24 80 00       	push   $0x802460
  8013e1:	6a 48                	push   $0x48
  8013e3:	68 15 24 80 00       	push   $0x802415
  8013e8:	e8 4e 06 00 00       	call   801a3b <_panic>

008013ed <sfree>:

}


void sfree(void* virtual_address)
{
  8013ed:	55                   	push   %ebp
  8013ee:	89 e5                	mov    %esp,%ebp
  8013f0:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8013f3:	83 ec 04             	sub    $0x4,%esp
  8013f6:	68 83 24 80 00       	push   $0x802483
  8013fb:	6a 53                	push   $0x53
  8013fd:	68 15 24 80 00       	push   $0x802415
  801402:	e8 34 06 00 00       	call   801a3b <_panic>

00801407 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801407:	55                   	push   %ebp
  801408:	89 e5                	mov    %esp,%ebp
  80140a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80140d:	83 ec 04             	sub    $0x4,%esp
  801410:	68 a0 24 80 00       	push   $0x8024a0
  801415:	6a 6c                	push   $0x6c
  801417:	68 15 24 80 00       	push   $0x802415
  80141c:	e8 1a 06 00 00       	call   801a3b <_panic>

00801421 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
  801424:	57                   	push   %edi
  801425:	56                   	push   %esi
  801426:	53                   	push   %ebx
  801427:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801430:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801433:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801436:	8b 7d 18             	mov    0x18(%ebp),%edi
  801439:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80143c:	cd 30                	int    $0x30
  80143e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801441:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801444:	83 c4 10             	add    $0x10,%esp
  801447:	5b                   	pop    %ebx
  801448:	5e                   	pop    %esi
  801449:	5f                   	pop    %edi
  80144a:	5d                   	pop    %ebp
  80144b:	c3                   	ret    

0080144c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
  80144f:	83 ec 04             	sub    $0x4,%esp
  801452:	8b 45 10             	mov    0x10(%ebp),%eax
  801455:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801458:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80145c:	8b 45 08             	mov    0x8(%ebp),%eax
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	52                   	push   %edx
  801464:	ff 75 0c             	pushl  0xc(%ebp)
  801467:	50                   	push   %eax
  801468:	6a 00                	push   $0x0
  80146a:	e8 b2 ff ff ff       	call   801421 <syscall>
  80146f:	83 c4 18             	add    $0x18,%esp
}
  801472:	90                   	nop
  801473:	c9                   	leave  
  801474:	c3                   	ret    

00801475 <sys_cgetc>:

int
sys_cgetc(void)
{
  801475:	55                   	push   %ebp
  801476:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 01                	push   $0x1
  801484:	e8 98 ff ff ff       	call   801421 <syscall>
  801489:	83 c4 18             	add    $0x18,%esp
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	50                   	push   %eax
  80149d:	6a 05                	push   $0x5
  80149f:	e8 7d ff ff ff       	call   801421 <syscall>
  8014a4:	83 c4 18             	add    $0x18,%esp
}
  8014a7:	c9                   	leave  
  8014a8:	c3                   	ret    

008014a9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014a9:	55                   	push   %ebp
  8014aa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 02                	push   $0x2
  8014b8:	e8 64 ff ff ff       	call   801421 <syscall>
  8014bd:	83 c4 18             	add    $0x18,%esp
}
  8014c0:	c9                   	leave  
  8014c1:	c3                   	ret    

008014c2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 03                	push   $0x3
  8014d1:	e8 4b ff ff ff       	call   801421 <syscall>
  8014d6:	83 c4 18             	add    $0x18,%esp
}
  8014d9:	c9                   	leave  
  8014da:	c3                   	ret    

008014db <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 04                	push   $0x4
  8014ea:	e8 32 ff ff ff       	call   801421 <syscall>
  8014ef:	83 c4 18             	add    $0x18,%esp
}
  8014f2:	c9                   	leave  
  8014f3:	c3                   	ret    

008014f4 <sys_env_exit>:


void sys_env_exit(void)
{
  8014f4:	55                   	push   %ebp
  8014f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 06                	push   $0x6
  801503:	e8 19 ff ff ff       	call   801421 <syscall>
  801508:	83 c4 18             	add    $0x18,%esp
}
  80150b:	90                   	nop
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801511:	8b 55 0c             	mov    0xc(%ebp),%edx
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	52                   	push   %edx
  80151e:	50                   	push   %eax
  80151f:	6a 07                	push   $0x7
  801521:	e8 fb fe ff ff       	call   801421 <syscall>
  801526:	83 c4 18             	add    $0x18,%esp
}
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
  80152e:	56                   	push   %esi
  80152f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801530:	8b 75 18             	mov    0x18(%ebp),%esi
  801533:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801536:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801539:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153c:	8b 45 08             	mov    0x8(%ebp),%eax
  80153f:	56                   	push   %esi
  801540:	53                   	push   %ebx
  801541:	51                   	push   %ecx
  801542:	52                   	push   %edx
  801543:	50                   	push   %eax
  801544:	6a 08                	push   $0x8
  801546:	e8 d6 fe ff ff       	call   801421 <syscall>
  80154b:	83 c4 18             	add    $0x18,%esp
}
  80154e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801551:	5b                   	pop    %ebx
  801552:	5e                   	pop    %esi
  801553:	5d                   	pop    %ebp
  801554:	c3                   	ret    

00801555 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801558:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	52                   	push   %edx
  801565:	50                   	push   %eax
  801566:	6a 09                	push   $0x9
  801568:	e8 b4 fe ff ff       	call   801421 <syscall>
  80156d:	83 c4 18             	add    $0x18,%esp
}
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	ff 75 0c             	pushl  0xc(%ebp)
  80157e:	ff 75 08             	pushl  0x8(%ebp)
  801581:	6a 0a                	push   $0xa
  801583:	e8 99 fe ff ff       	call   801421 <syscall>
  801588:	83 c4 18             	add    $0x18,%esp
}
  80158b:	c9                   	leave  
  80158c:	c3                   	ret    

0080158d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80158d:	55                   	push   %ebp
  80158e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 0b                	push   $0xb
  80159c:	e8 80 fe ff ff       	call   801421 <syscall>
  8015a1:	83 c4 18             	add    $0x18,%esp
}
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 0c                	push   $0xc
  8015b5:	e8 67 fe ff ff       	call   801421 <syscall>
  8015ba:	83 c4 18             	add    $0x18,%esp
}
  8015bd:	c9                   	leave  
  8015be:	c3                   	ret    

008015bf <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 0d                	push   $0xd
  8015ce:	e8 4e fe ff ff       	call   801421 <syscall>
  8015d3:	83 c4 18             	add    $0x18,%esp
}
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	ff 75 0c             	pushl  0xc(%ebp)
  8015e4:	ff 75 08             	pushl  0x8(%ebp)
  8015e7:	6a 11                	push   $0x11
  8015e9:	e8 33 fe ff ff       	call   801421 <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
	return;
  8015f1:	90                   	nop
}
  8015f2:	c9                   	leave  
  8015f3:	c3                   	ret    

008015f4 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015f4:	55                   	push   %ebp
  8015f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	ff 75 0c             	pushl  0xc(%ebp)
  801600:	ff 75 08             	pushl  0x8(%ebp)
  801603:	6a 12                	push   $0x12
  801605:	e8 17 fe ff ff       	call   801421 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
	return ;
  80160d:	90                   	nop
}
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 0e                	push   $0xe
  80161f:	e8 fd fd ff ff       	call   801421 <syscall>
  801624:	83 c4 18             	add    $0x18,%esp
}
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	ff 75 08             	pushl  0x8(%ebp)
  801637:	6a 0f                	push   $0xf
  801639:	e8 e3 fd ff ff       	call   801421 <syscall>
  80163e:	83 c4 18             	add    $0x18,%esp
}
  801641:	c9                   	leave  
  801642:	c3                   	ret    

00801643 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 10                	push   $0x10
  801652:	e8 ca fd ff ff       	call   801421 <syscall>
  801657:	83 c4 18             	add    $0x18,%esp
}
  80165a:	90                   	nop
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 14                	push   $0x14
  80166c:	e8 b0 fd ff ff       	call   801421 <syscall>
  801671:	83 c4 18             	add    $0x18,%esp
}
  801674:	90                   	nop
  801675:	c9                   	leave  
  801676:	c3                   	ret    

00801677 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801677:	55                   	push   %ebp
  801678:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 15                	push   $0x15
  801686:	e8 96 fd ff ff       	call   801421 <syscall>
  80168b:	83 c4 18             	add    $0x18,%esp
}
  80168e:	90                   	nop
  80168f:	c9                   	leave  
  801690:	c3                   	ret    

00801691 <sys_cputc>:


void
sys_cputc(const char c)
{
  801691:	55                   	push   %ebp
  801692:	89 e5                	mov    %esp,%ebp
  801694:	83 ec 04             	sub    $0x4,%esp
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80169d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	50                   	push   %eax
  8016aa:	6a 16                	push   $0x16
  8016ac:	e8 70 fd ff ff       	call   801421 <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
}
  8016b4:	90                   	nop
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 17                	push   $0x17
  8016c6:	e8 56 fd ff ff       	call   801421 <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
}
  8016ce:	90                   	nop
  8016cf:	c9                   	leave  
  8016d0:	c3                   	ret    

008016d1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016d1:	55                   	push   %ebp
  8016d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	ff 75 0c             	pushl  0xc(%ebp)
  8016e0:	50                   	push   %eax
  8016e1:	6a 18                	push   $0x18
  8016e3:	e8 39 fd ff ff       	call   801421 <syscall>
  8016e8:	83 c4 18             	add    $0x18,%esp
}
  8016eb:	c9                   	leave  
  8016ec:	c3                   	ret    

008016ed <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016ed:	55                   	push   %ebp
  8016ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	52                   	push   %edx
  8016fd:	50                   	push   %eax
  8016fe:	6a 1b                	push   $0x1b
  801700:	e8 1c fd ff ff       	call   801421 <syscall>
  801705:	83 c4 18             	add    $0x18,%esp
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80170d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801710:	8b 45 08             	mov    0x8(%ebp),%eax
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	52                   	push   %edx
  80171a:	50                   	push   %eax
  80171b:	6a 19                	push   $0x19
  80171d:	e8 ff fc ff ff       	call   801421 <syscall>
  801722:	83 c4 18             	add    $0x18,%esp
}
  801725:	90                   	nop
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80172b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80172e:	8b 45 08             	mov    0x8(%ebp),%eax
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	52                   	push   %edx
  801738:	50                   	push   %eax
  801739:	6a 1a                	push   $0x1a
  80173b:	e8 e1 fc ff ff       	call   801421 <syscall>
  801740:	83 c4 18             	add    $0x18,%esp
}
  801743:	90                   	nop
  801744:	c9                   	leave  
  801745:	c3                   	ret    

00801746 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
  801749:	83 ec 04             	sub    $0x4,%esp
  80174c:	8b 45 10             	mov    0x10(%ebp),%eax
  80174f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801752:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801755:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801759:	8b 45 08             	mov    0x8(%ebp),%eax
  80175c:	6a 00                	push   $0x0
  80175e:	51                   	push   %ecx
  80175f:	52                   	push   %edx
  801760:	ff 75 0c             	pushl  0xc(%ebp)
  801763:	50                   	push   %eax
  801764:	6a 1c                	push   $0x1c
  801766:	e8 b6 fc ff ff       	call   801421 <syscall>
  80176b:	83 c4 18             	add    $0x18,%esp
}
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801773:	8b 55 0c             	mov    0xc(%ebp),%edx
  801776:	8b 45 08             	mov    0x8(%ebp),%eax
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	52                   	push   %edx
  801780:	50                   	push   %eax
  801781:	6a 1d                	push   $0x1d
  801783:	e8 99 fc ff ff       	call   801421 <syscall>
  801788:	83 c4 18             	add    $0x18,%esp
}
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801790:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801793:	8b 55 0c             	mov    0xc(%ebp),%edx
  801796:	8b 45 08             	mov    0x8(%ebp),%eax
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	51                   	push   %ecx
  80179e:	52                   	push   %edx
  80179f:	50                   	push   %eax
  8017a0:	6a 1e                	push   $0x1e
  8017a2:	e8 7a fc ff ff       	call   801421 <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
}
  8017aa:	c9                   	leave  
  8017ab:	c3                   	ret    

008017ac <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017ac:	55                   	push   %ebp
  8017ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	52                   	push   %edx
  8017bc:	50                   	push   %eax
  8017bd:	6a 1f                	push   $0x1f
  8017bf:	e8 5d fc ff ff       	call   801421 <syscall>
  8017c4:	83 c4 18             	add    $0x18,%esp
}
  8017c7:	c9                   	leave  
  8017c8:	c3                   	ret    

008017c9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017c9:	55                   	push   %ebp
  8017ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 20                	push   $0x20
  8017d8:	e8 44 fc ff ff       	call   801421 <syscall>
  8017dd:	83 c4 18             	add    $0x18,%esp
}
  8017e0:	c9                   	leave  
  8017e1:	c3                   	ret    

008017e2 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8017e2:	55                   	push   %ebp
  8017e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8017e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	ff 75 10             	pushl  0x10(%ebp)
  8017ef:	ff 75 0c             	pushl  0xc(%ebp)
  8017f2:	50                   	push   %eax
  8017f3:	6a 21                	push   $0x21
  8017f5:	e8 27 fc ff ff       	call   801421 <syscall>
  8017fa:	83 c4 18             	add    $0x18,%esp
}
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801802:	8b 45 08             	mov    0x8(%ebp),%eax
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	50                   	push   %eax
  80180e:	6a 22                	push   $0x22
  801810:	e8 0c fc ff ff       	call   801421 <syscall>
  801815:	83 c4 18             	add    $0x18,%esp
}
  801818:	90                   	nop
  801819:	c9                   	leave  
  80181a:	c3                   	ret    

0080181b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80181b:	55                   	push   %ebp
  80181c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80181e:	8b 45 08             	mov    0x8(%ebp),%eax
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	50                   	push   %eax
  80182a:	6a 23                	push   $0x23
  80182c:	e8 f0 fb ff ff       	call   801421 <syscall>
  801831:	83 c4 18             	add    $0x18,%esp
}
  801834:	90                   	nop
  801835:	c9                   	leave  
  801836:	c3                   	ret    

00801837 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801837:	55                   	push   %ebp
  801838:	89 e5                	mov    %esp,%ebp
  80183a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80183d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801840:	8d 50 04             	lea    0x4(%eax),%edx
  801843:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	52                   	push   %edx
  80184d:	50                   	push   %eax
  80184e:	6a 24                	push   $0x24
  801850:	e8 cc fb ff ff       	call   801421 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
	return result;
  801858:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80185b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80185e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801861:	89 01                	mov    %eax,(%ecx)
  801863:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801866:	8b 45 08             	mov    0x8(%ebp),%eax
  801869:	c9                   	leave  
  80186a:	c2 04 00             	ret    $0x4

0080186d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	ff 75 10             	pushl  0x10(%ebp)
  801877:	ff 75 0c             	pushl  0xc(%ebp)
  80187a:	ff 75 08             	pushl  0x8(%ebp)
  80187d:	6a 13                	push   $0x13
  80187f:	e8 9d fb ff ff       	call   801421 <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
	return ;
  801887:	90                   	nop
}
  801888:	c9                   	leave  
  801889:	c3                   	ret    

0080188a <sys_rcr2>:
uint32 sys_rcr2()
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 25                	push   $0x25
  801899:	e8 83 fb ff ff       	call   801421 <syscall>
  80189e:	83 c4 18             	add    $0x18,%esp
}
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
  8018a6:	83 ec 04             	sub    $0x4,%esp
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018af:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	50                   	push   %eax
  8018bc:	6a 26                	push   $0x26
  8018be:	e8 5e fb ff ff       	call   801421 <syscall>
  8018c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c6:	90                   	nop
}
  8018c7:	c9                   	leave  
  8018c8:	c3                   	ret    

008018c9 <rsttst>:
void rsttst()
{
  8018c9:	55                   	push   %ebp
  8018ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 28                	push   $0x28
  8018d8:	e8 44 fb ff ff       	call   801421 <syscall>
  8018dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e0:	90                   	nop
}
  8018e1:	c9                   	leave  
  8018e2:	c3                   	ret    

008018e3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018e3:	55                   	push   %ebp
  8018e4:	89 e5                	mov    %esp,%ebp
  8018e6:	83 ec 04             	sub    $0x4,%esp
  8018e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018ef:	8b 55 18             	mov    0x18(%ebp),%edx
  8018f2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018f6:	52                   	push   %edx
  8018f7:	50                   	push   %eax
  8018f8:	ff 75 10             	pushl  0x10(%ebp)
  8018fb:	ff 75 0c             	pushl  0xc(%ebp)
  8018fe:	ff 75 08             	pushl  0x8(%ebp)
  801901:	6a 27                	push   $0x27
  801903:	e8 19 fb ff ff       	call   801421 <syscall>
  801908:	83 c4 18             	add    $0x18,%esp
	return ;
  80190b:	90                   	nop
}
  80190c:	c9                   	leave  
  80190d:	c3                   	ret    

0080190e <chktst>:
void chktst(uint32 n)
{
  80190e:	55                   	push   %ebp
  80190f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	ff 75 08             	pushl  0x8(%ebp)
  80191c:	6a 29                	push   $0x29
  80191e:	e8 fe fa ff ff       	call   801421 <syscall>
  801923:	83 c4 18             	add    $0x18,%esp
	return ;
  801926:	90                   	nop
}
  801927:	c9                   	leave  
  801928:	c3                   	ret    

00801929 <inctst>:

void inctst()
{
  801929:	55                   	push   %ebp
  80192a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 2a                	push   $0x2a
  801938:	e8 e4 fa ff ff       	call   801421 <syscall>
  80193d:	83 c4 18             	add    $0x18,%esp
	return ;
  801940:	90                   	nop
}
  801941:	c9                   	leave  
  801942:	c3                   	ret    

00801943 <gettst>:
uint32 gettst()
{
  801943:	55                   	push   %ebp
  801944:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 2b                	push   $0x2b
  801952:	e8 ca fa ff ff       	call   801421 <syscall>
  801957:	83 c4 18             	add    $0x18,%esp
}
  80195a:	c9                   	leave  
  80195b:	c3                   	ret    

0080195c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80195c:	55                   	push   %ebp
  80195d:	89 e5                	mov    %esp,%ebp
  80195f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 2c                	push   $0x2c
  80196e:	e8 ae fa ff ff       	call   801421 <syscall>
  801973:	83 c4 18             	add    $0x18,%esp
  801976:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801979:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80197d:	75 07                	jne    801986 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80197f:	b8 01 00 00 00       	mov    $0x1,%eax
  801984:	eb 05                	jmp    80198b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801986:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80198b:	c9                   	leave  
  80198c:	c3                   	ret    

0080198d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80198d:	55                   	push   %ebp
  80198e:	89 e5                	mov    %esp,%ebp
  801990:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 2c                	push   $0x2c
  80199f:	e8 7d fa ff ff       	call   801421 <syscall>
  8019a4:	83 c4 18             	add    $0x18,%esp
  8019a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019aa:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019ae:	75 07                	jne    8019b7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019b0:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b5:	eb 05                	jmp    8019bc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019bc:	c9                   	leave  
  8019bd:	c3                   	ret    

008019be <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019be:	55                   	push   %ebp
  8019bf:	89 e5                	mov    %esp,%ebp
  8019c1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	6a 2c                	push   $0x2c
  8019d0:	e8 4c fa ff ff       	call   801421 <syscall>
  8019d5:	83 c4 18             	add    $0x18,%esp
  8019d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019db:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019df:	75 07                	jne    8019e8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019e1:	b8 01 00 00 00       	mov    $0x1,%eax
  8019e6:	eb 05                	jmp    8019ed <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019ed:	c9                   	leave  
  8019ee:	c3                   	ret    

008019ef <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019ef:	55                   	push   %ebp
  8019f0:	89 e5                	mov    %esp,%ebp
  8019f2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 2c                	push   $0x2c
  801a01:	e8 1b fa ff ff       	call   801421 <syscall>
  801a06:	83 c4 18             	add    $0x18,%esp
  801a09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a0c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a10:	75 07                	jne    801a19 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a12:	b8 01 00 00 00       	mov    $0x1,%eax
  801a17:	eb 05                	jmp    801a1e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a19:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a1e:	c9                   	leave  
  801a1f:	c3                   	ret    

00801a20 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a20:	55                   	push   %ebp
  801a21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	ff 75 08             	pushl  0x8(%ebp)
  801a2e:	6a 2d                	push   $0x2d
  801a30:	e8 ec f9 ff ff       	call   801421 <syscall>
  801a35:	83 c4 18             	add    $0x18,%esp
	return ;
  801a38:	90                   	nop
}
  801a39:	c9                   	leave  
  801a3a:	c3                   	ret    

00801a3b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801a3b:	55                   	push   %ebp
  801a3c:	89 e5                	mov    %esp,%ebp
  801a3e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801a41:	8d 45 10             	lea    0x10(%ebp),%eax
  801a44:	83 c0 04             	add    $0x4,%eax
  801a47:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801a4a:	a1 14 30 80 00       	mov    0x803014,%eax
  801a4f:	85 c0                	test   %eax,%eax
  801a51:	74 16                	je     801a69 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801a53:	a1 14 30 80 00       	mov    0x803014,%eax
  801a58:	83 ec 08             	sub    $0x8,%esp
  801a5b:	50                   	push   %eax
  801a5c:	68 c8 24 80 00       	push   $0x8024c8
  801a61:	e8 8f eb ff ff       	call   8005f5 <cprintf>
  801a66:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801a69:	a1 00 30 80 00       	mov    0x803000,%eax
  801a6e:	ff 75 0c             	pushl  0xc(%ebp)
  801a71:	ff 75 08             	pushl  0x8(%ebp)
  801a74:	50                   	push   %eax
  801a75:	68 cd 24 80 00       	push   $0x8024cd
  801a7a:	e8 76 eb ff ff       	call   8005f5 <cprintf>
  801a7f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801a82:	8b 45 10             	mov    0x10(%ebp),%eax
  801a85:	83 ec 08             	sub    $0x8,%esp
  801a88:	ff 75 f4             	pushl  -0xc(%ebp)
  801a8b:	50                   	push   %eax
  801a8c:	e8 f9 ea ff ff       	call   80058a <vcprintf>
  801a91:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801a94:	83 ec 08             	sub    $0x8,%esp
  801a97:	6a 00                	push   $0x0
  801a99:	68 e9 24 80 00       	push   $0x8024e9
  801a9e:	e8 e7 ea ff ff       	call   80058a <vcprintf>
  801aa3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801aa6:	e8 68 ea ff ff       	call   800513 <exit>

	// should not return here
	while (1) ;
  801aab:	eb fe                	jmp    801aab <_panic+0x70>

00801aad <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801aad:	55                   	push   %ebp
  801aae:	89 e5                	mov    %esp,%ebp
  801ab0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801ab3:	a1 04 30 80 00       	mov    0x803004,%eax
  801ab8:	8b 50 74             	mov    0x74(%eax),%edx
  801abb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801abe:	39 c2                	cmp    %eax,%edx
  801ac0:	74 14                	je     801ad6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ac2:	83 ec 04             	sub    $0x4,%esp
  801ac5:	68 ec 24 80 00       	push   $0x8024ec
  801aca:	6a 26                	push   $0x26
  801acc:	68 38 25 80 00       	push   $0x802538
  801ad1:	e8 65 ff ff ff       	call   801a3b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801ad6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801add:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ae4:	e9 c2 00 00 00       	jmp    801bab <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801ae9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801af3:	8b 45 08             	mov    0x8(%ebp),%eax
  801af6:	01 d0                	add    %edx,%eax
  801af8:	8b 00                	mov    (%eax),%eax
  801afa:	85 c0                	test   %eax,%eax
  801afc:	75 08                	jne    801b06 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801afe:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801b01:	e9 a2 00 00 00       	jmp    801ba8 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801b06:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b0d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801b14:	eb 69                	jmp    801b7f <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801b16:	a1 04 30 80 00       	mov    0x803004,%eax
  801b1b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b21:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b24:	89 d0                	mov    %edx,%eax
  801b26:	01 c0                	add    %eax,%eax
  801b28:	01 d0                	add    %edx,%eax
  801b2a:	c1 e0 02             	shl    $0x2,%eax
  801b2d:	01 c8                	add    %ecx,%eax
  801b2f:	8a 40 04             	mov    0x4(%eax),%al
  801b32:	84 c0                	test   %al,%al
  801b34:	75 46                	jne    801b7c <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b36:	a1 04 30 80 00       	mov    0x803004,%eax
  801b3b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b41:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b44:	89 d0                	mov    %edx,%eax
  801b46:	01 c0                	add    %eax,%eax
  801b48:	01 d0                	add    %edx,%eax
  801b4a:	c1 e0 02             	shl    $0x2,%eax
  801b4d:	01 c8                	add    %ecx,%eax
  801b4f:	8b 00                	mov    (%eax),%eax
  801b51:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801b54:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b57:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801b5c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801b5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b61:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801b68:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6b:	01 c8                	add    %ecx,%eax
  801b6d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b6f:	39 c2                	cmp    %eax,%edx
  801b71:	75 09                	jne    801b7c <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801b73:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801b7a:	eb 12                	jmp    801b8e <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b7c:	ff 45 e8             	incl   -0x18(%ebp)
  801b7f:	a1 04 30 80 00       	mov    0x803004,%eax
  801b84:	8b 50 74             	mov    0x74(%eax),%edx
  801b87:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b8a:	39 c2                	cmp    %eax,%edx
  801b8c:	77 88                	ja     801b16 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801b8e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801b92:	75 14                	jne    801ba8 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801b94:	83 ec 04             	sub    $0x4,%esp
  801b97:	68 44 25 80 00       	push   $0x802544
  801b9c:	6a 3a                	push   $0x3a
  801b9e:	68 38 25 80 00       	push   $0x802538
  801ba3:	e8 93 fe ff ff       	call   801a3b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801ba8:	ff 45 f0             	incl   -0x10(%ebp)
  801bab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bae:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801bb1:	0f 8c 32 ff ff ff    	jl     801ae9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801bb7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bbe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801bc5:	eb 26                	jmp    801bed <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801bc7:	a1 04 30 80 00       	mov    0x803004,%eax
  801bcc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801bd2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801bd5:	89 d0                	mov    %edx,%eax
  801bd7:	01 c0                	add    %eax,%eax
  801bd9:	01 d0                	add    %edx,%eax
  801bdb:	c1 e0 02             	shl    $0x2,%eax
  801bde:	01 c8                	add    %ecx,%eax
  801be0:	8a 40 04             	mov    0x4(%eax),%al
  801be3:	3c 01                	cmp    $0x1,%al
  801be5:	75 03                	jne    801bea <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801be7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bea:	ff 45 e0             	incl   -0x20(%ebp)
  801bed:	a1 04 30 80 00       	mov    0x803004,%eax
  801bf2:	8b 50 74             	mov    0x74(%eax),%edx
  801bf5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bf8:	39 c2                	cmp    %eax,%edx
  801bfa:	77 cb                	ja     801bc7 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bff:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c02:	74 14                	je     801c18 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801c04:	83 ec 04             	sub    $0x4,%esp
  801c07:	68 98 25 80 00       	push   $0x802598
  801c0c:	6a 44                	push   $0x44
  801c0e:	68 38 25 80 00       	push   $0x802538
  801c13:	e8 23 fe ff ff       	call   801a3b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801c18:	90                   	nop
  801c19:	c9                   	leave  
  801c1a:	c3                   	ret    
  801c1b:	90                   	nop

00801c1c <__udivdi3>:
  801c1c:	55                   	push   %ebp
  801c1d:	57                   	push   %edi
  801c1e:	56                   	push   %esi
  801c1f:	53                   	push   %ebx
  801c20:	83 ec 1c             	sub    $0x1c,%esp
  801c23:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c27:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c2b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c2f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c33:	89 ca                	mov    %ecx,%edx
  801c35:	89 f8                	mov    %edi,%eax
  801c37:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c3b:	85 f6                	test   %esi,%esi
  801c3d:	75 2d                	jne    801c6c <__udivdi3+0x50>
  801c3f:	39 cf                	cmp    %ecx,%edi
  801c41:	77 65                	ja     801ca8 <__udivdi3+0x8c>
  801c43:	89 fd                	mov    %edi,%ebp
  801c45:	85 ff                	test   %edi,%edi
  801c47:	75 0b                	jne    801c54 <__udivdi3+0x38>
  801c49:	b8 01 00 00 00       	mov    $0x1,%eax
  801c4e:	31 d2                	xor    %edx,%edx
  801c50:	f7 f7                	div    %edi
  801c52:	89 c5                	mov    %eax,%ebp
  801c54:	31 d2                	xor    %edx,%edx
  801c56:	89 c8                	mov    %ecx,%eax
  801c58:	f7 f5                	div    %ebp
  801c5a:	89 c1                	mov    %eax,%ecx
  801c5c:	89 d8                	mov    %ebx,%eax
  801c5e:	f7 f5                	div    %ebp
  801c60:	89 cf                	mov    %ecx,%edi
  801c62:	89 fa                	mov    %edi,%edx
  801c64:	83 c4 1c             	add    $0x1c,%esp
  801c67:	5b                   	pop    %ebx
  801c68:	5e                   	pop    %esi
  801c69:	5f                   	pop    %edi
  801c6a:	5d                   	pop    %ebp
  801c6b:	c3                   	ret    
  801c6c:	39 ce                	cmp    %ecx,%esi
  801c6e:	77 28                	ja     801c98 <__udivdi3+0x7c>
  801c70:	0f bd fe             	bsr    %esi,%edi
  801c73:	83 f7 1f             	xor    $0x1f,%edi
  801c76:	75 40                	jne    801cb8 <__udivdi3+0x9c>
  801c78:	39 ce                	cmp    %ecx,%esi
  801c7a:	72 0a                	jb     801c86 <__udivdi3+0x6a>
  801c7c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c80:	0f 87 9e 00 00 00    	ja     801d24 <__udivdi3+0x108>
  801c86:	b8 01 00 00 00       	mov    $0x1,%eax
  801c8b:	89 fa                	mov    %edi,%edx
  801c8d:	83 c4 1c             	add    $0x1c,%esp
  801c90:	5b                   	pop    %ebx
  801c91:	5e                   	pop    %esi
  801c92:	5f                   	pop    %edi
  801c93:	5d                   	pop    %ebp
  801c94:	c3                   	ret    
  801c95:	8d 76 00             	lea    0x0(%esi),%esi
  801c98:	31 ff                	xor    %edi,%edi
  801c9a:	31 c0                	xor    %eax,%eax
  801c9c:	89 fa                	mov    %edi,%edx
  801c9e:	83 c4 1c             	add    $0x1c,%esp
  801ca1:	5b                   	pop    %ebx
  801ca2:	5e                   	pop    %esi
  801ca3:	5f                   	pop    %edi
  801ca4:	5d                   	pop    %ebp
  801ca5:	c3                   	ret    
  801ca6:	66 90                	xchg   %ax,%ax
  801ca8:	89 d8                	mov    %ebx,%eax
  801caa:	f7 f7                	div    %edi
  801cac:	31 ff                	xor    %edi,%edi
  801cae:	89 fa                	mov    %edi,%edx
  801cb0:	83 c4 1c             	add    $0x1c,%esp
  801cb3:	5b                   	pop    %ebx
  801cb4:	5e                   	pop    %esi
  801cb5:	5f                   	pop    %edi
  801cb6:	5d                   	pop    %ebp
  801cb7:	c3                   	ret    
  801cb8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cbd:	89 eb                	mov    %ebp,%ebx
  801cbf:	29 fb                	sub    %edi,%ebx
  801cc1:	89 f9                	mov    %edi,%ecx
  801cc3:	d3 e6                	shl    %cl,%esi
  801cc5:	89 c5                	mov    %eax,%ebp
  801cc7:	88 d9                	mov    %bl,%cl
  801cc9:	d3 ed                	shr    %cl,%ebp
  801ccb:	89 e9                	mov    %ebp,%ecx
  801ccd:	09 f1                	or     %esi,%ecx
  801ccf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cd3:	89 f9                	mov    %edi,%ecx
  801cd5:	d3 e0                	shl    %cl,%eax
  801cd7:	89 c5                	mov    %eax,%ebp
  801cd9:	89 d6                	mov    %edx,%esi
  801cdb:	88 d9                	mov    %bl,%cl
  801cdd:	d3 ee                	shr    %cl,%esi
  801cdf:	89 f9                	mov    %edi,%ecx
  801ce1:	d3 e2                	shl    %cl,%edx
  801ce3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ce7:	88 d9                	mov    %bl,%cl
  801ce9:	d3 e8                	shr    %cl,%eax
  801ceb:	09 c2                	or     %eax,%edx
  801ced:	89 d0                	mov    %edx,%eax
  801cef:	89 f2                	mov    %esi,%edx
  801cf1:	f7 74 24 0c          	divl   0xc(%esp)
  801cf5:	89 d6                	mov    %edx,%esi
  801cf7:	89 c3                	mov    %eax,%ebx
  801cf9:	f7 e5                	mul    %ebp
  801cfb:	39 d6                	cmp    %edx,%esi
  801cfd:	72 19                	jb     801d18 <__udivdi3+0xfc>
  801cff:	74 0b                	je     801d0c <__udivdi3+0xf0>
  801d01:	89 d8                	mov    %ebx,%eax
  801d03:	31 ff                	xor    %edi,%edi
  801d05:	e9 58 ff ff ff       	jmp    801c62 <__udivdi3+0x46>
  801d0a:	66 90                	xchg   %ax,%ax
  801d0c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d10:	89 f9                	mov    %edi,%ecx
  801d12:	d3 e2                	shl    %cl,%edx
  801d14:	39 c2                	cmp    %eax,%edx
  801d16:	73 e9                	jae    801d01 <__udivdi3+0xe5>
  801d18:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d1b:	31 ff                	xor    %edi,%edi
  801d1d:	e9 40 ff ff ff       	jmp    801c62 <__udivdi3+0x46>
  801d22:	66 90                	xchg   %ax,%ax
  801d24:	31 c0                	xor    %eax,%eax
  801d26:	e9 37 ff ff ff       	jmp    801c62 <__udivdi3+0x46>
  801d2b:	90                   	nop

00801d2c <__umoddi3>:
  801d2c:	55                   	push   %ebp
  801d2d:	57                   	push   %edi
  801d2e:	56                   	push   %esi
  801d2f:	53                   	push   %ebx
  801d30:	83 ec 1c             	sub    $0x1c,%esp
  801d33:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d37:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d3b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d3f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d43:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d47:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d4b:	89 f3                	mov    %esi,%ebx
  801d4d:	89 fa                	mov    %edi,%edx
  801d4f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d53:	89 34 24             	mov    %esi,(%esp)
  801d56:	85 c0                	test   %eax,%eax
  801d58:	75 1a                	jne    801d74 <__umoddi3+0x48>
  801d5a:	39 f7                	cmp    %esi,%edi
  801d5c:	0f 86 a2 00 00 00    	jbe    801e04 <__umoddi3+0xd8>
  801d62:	89 c8                	mov    %ecx,%eax
  801d64:	89 f2                	mov    %esi,%edx
  801d66:	f7 f7                	div    %edi
  801d68:	89 d0                	mov    %edx,%eax
  801d6a:	31 d2                	xor    %edx,%edx
  801d6c:	83 c4 1c             	add    $0x1c,%esp
  801d6f:	5b                   	pop    %ebx
  801d70:	5e                   	pop    %esi
  801d71:	5f                   	pop    %edi
  801d72:	5d                   	pop    %ebp
  801d73:	c3                   	ret    
  801d74:	39 f0                	cmp    %esi,%eax
  801d76:	0f 87 ac 00 00 00    	ja     801e28 <__umoddi3+0xfc>
  801d7c:	0f bd e8             	bsr    %eax,%ebp
  801d7f:	83 f5 1f             	xor    $0x1f,%ebp
  801d82:	0f 84 ac 00 00 00    	je     801e34 <__umoddi3+0x108>
  801d88:	bf 20 00 00 00       	mov    $0x20,%edi
  801d8d:	29 ef                	sub    %ebp,%edi
  801d8f:	89 fe                	mov    %edi,%esi
  801d91:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d95:	89 e9                	mov    %ebp,%ecx
  801d97:	d3 e0                	shl    %cl,%eax
  801d99:	89 d7                	mov    %edx,%edi
  801d9b:	89 f1                	mov    %esi,%ecx
  801d9d:	d3 ef                	shr    %cl,%edi
  801d9f:	09 c7                	or     %eax,%edi
  801da1:	89 e9                	mov    %ebp,%ecx
  801da3:	d3 e2                	shl    %cl,%edx
  801da5:	89 14 24             	mov    %edx,(%esp)
  801da8:	89 d8                	mov    %ebx,%eax
  801daa:	d3 e0                	shl    %cl,%eax
  801dac:	89 c2                	mov    %eax,%edx
  801dae:	8b 44 24 08          	mov    0x8(%esp),%eax
  801db2:	d3 e0                	shl    %cl,%eax
  801db4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801db8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dbc:	89 f1                	mov    %esi,%ecx
  801dbe:	d3 e8                	shr    %cl,%eax
  801dc0:	09 d0                	or     %edx,%eax
  801dc2:	d3 eb                	shr    %cl,%ebx
  801dc4:	89 da                	mov    %ebx,%edx
  801dc6:	f7 f7                	div    %edi
  801dc8:	89 d3                	mov    %edx,%ebx
  801dca:	f7 24 24             	mull   (%esp)
  801dcd:	89 c6                	mov    %eax,%esi
  801dcf:	89 d1                	mov    %edx,%ecx
  801dd1:	39 d3                	cmp    %edx,%ebx
  801dd3:	0f 82 87 00 00 00    	jb     801e60 <__umoddi3+0x134>
  801dd9:	0f 84 91 00 00 00    	je     801e70 <__umoddi3+0x144>
  801ddf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801de3:	29 f2                	sub    %esi,%edx
  801de5:	19 cb                	sbb    %ecx,%ebx
  801de7:	89 d8                	mov    %ebx,%eax
  801de9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ded:	d3 e0                	shl    %cl,%eax
  801def:	89 e9                	mov    %ebp,%ecx
  801df1:	d3 ea                	shr    %cl,%edx
  801df3:	09 d0                	or     %edx,%eax
  801df5:	89 e9                	mov    %ebp,%ecx
  801df7:	d3 eb                	shr    %cl,%ebx
  801df9:	89 da                	mov    %ebx,%edx
  801dfb:	83 c4 1c             	add    $0x1c,%esp
  801dfe:	5b                   	pop    %ebx
  801dff:	5e                   	pop    %esi
  801e00:	5f                   	pop    %edi
  801e01:	5d                   	pop    %ebp
  801e02:	c3                   	ret    
  801e03:	90                   	nop
  801e04:	89 fd                	mov    %edi,%ebp
  801e06:	85 ff                	test   %edi,%edi
  801e08:	75 0b                	jne    801e15 <__umoddi3+0xe9>
  801e0a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e0f:	31 d2                	xor    %edx,%edx
  801e11:	f7 f7                	div    %edi
  801e13:	89 c5                	mov    %eax,%ebp
  801e15:	89 f0                	mov    %esi,%eax
  801e17:	31 d2                	xor    %edx,%edx
  801e19:	f7 f5                	div    %ebp
  801e1b:	89 c8                	mov    %ecx,%eax
  801e1d:	f7 f5                	div    %ebp
  801e1f:	89 d0                	mov    %edx,%eax
  801e21:	e9 44 ff ff ff       	jmp    801d6a <__umoddi3+0x3e>
  801e26:	66 90                	xchg   %ax,%ax
  801e28:	89 c8                	mov    %ecx,%eax
  801e2a:	89 f2                	mov    %esi,%edx
  801e2c:	83 c4 1c             	add    $0x1c,%esp
  801e2f:	5b                   	pop    %ebx
  801e30:	5e                   	pop    %esi
  801e31:	5f                   	pop    %edi
  801e32:	5d                   	pop    %ebp
  801e33:	c3                   	ret    
  801e34:	3b 04 24             	cmp    (%esp),%eax
  801e37:	72 06                	jb     801e3f <__umoddi3+0x113>
  801e39:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e3d:	77 0f                	ja     801e4e <__umoddi3+0x122>
  801e3f:	89 f2                	mov    %esi,%edx
  801e41:	29 f9                	sub    %edi,%ecx
  801e43:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e47:	89 14 24             	mov    %edx,(%esp)
  801e4a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e4e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e52:	8b 14 24             	mov    (%esp),%edx
  801e55:	83 c4 1c             	add    $0x1c,%esp
  801e58:	5b                   	pop    %ebx
  801e59:	5e                   	pop    %esi
  801e5a:	5f                   	pop    %edi
  801e5b:	5d                   	pop    %ebp
  801e5c:	c3                   	ret    
  801e5d:	8d 76 00             	lea    0x0(%esi),%esi
  801e60:	2b 04 24             	sub    (%esp),%eax
  801e63:	19 fa                	sbb    %edi,%edx
  801e65:	89 d1                	mov    %edx,%ecx
  801e67:	89 c6                	mov    %eax,%esi
  801e69:	e9 71 ff ff ff       	jmp    801ddf <__umoddi3+0xb3>
  801e6e:	66 90                	xchg   %ax,%ax
  801e70:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e74:	72 ea                	jb     801e60 <__umoddi3+0x134>
  801e76:	89 d9                	mov    %ebx,%ecx
  801e78:	e9 62 ff ff ff       	jmp    801ddf <__umoddi3+0xb3>
