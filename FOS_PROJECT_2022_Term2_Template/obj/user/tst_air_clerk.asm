
obj/user/tst_air_clerk:     file format elf32-i386


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
  800031:	e8 e7 05 00 00       	call   80061d <libmain>
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
  80003e:	81 ec 9c 01 00 00    	sub    $0x19c,%esp
	int parentenvID = sys_getparentenvid();
  800044:	e8 7a 1a 00 00       	call   801ac3 <sys_getparentenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	// Get the shared variables from the main program ***********************************

	char _customers[] = "customers";
  80004c:	8d 45 ae             	lea    -0x52(%ebp),%eax
  80004f:	bb d5 22 80 00       	mov    $0x8022d5,%ebx
  800054:	ba 0a 00 00 00       	mov    $0xa,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custCounter[] = "custCounter";
  800061:	8d 45 a2             	lea    -0x5e(%ebp),%eax
  800064:	bb df 22 80 00       	mov    $0x8022df,%ebx
  800069:	ba 03 00 00 00       	mov    $0x3,%edx
  80006e:	89 c7                	mov    %eax,%edi
  800070:	89 de                	mov    %ebx,%esi
  800072:	89 d1                	mov    %edx,%ecx
  800074:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1Counter[] = "flight1Counter";
  800076:	8d 45 93             	lea    -0x6d(%ebp),%eax
  800079:	bb eb 22 80 00       	mov    $0x8022eb,%ebx
  80007e:	ba 0f 00 00 00       	mov    $0xf,%edx
  800083:	89 c7                	mov    %eax,%edi
  800085:	89 de                	mov    %ebx,%esi
  800087:	89 d1                	mov    %edx,%ecx
  800089:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2Counter[] = "flight2Counter";
  80008b:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80008e:	bb fa 22 80 00       	mov    $0x8022fa,%ebx
  800093:	ba 0f 00 00 00       	mov    $0xf,%edx
  800098:	89 c7                	mov    %eax,%edi
  80009a:	89 de                	mov    %ebx,%esi
  80009c:	89 d1                	mov    %edx,%ecx
  80009e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Counter[] = "flightBooked1Counter";
  8000a0:	8d 85 6f ff ff ff    	lea    -0x91(%ebp),%eax
  8000a6:	bb 09 23 80 00       	mov    $0x802309,%ebx
  8000ab:	ba 15 00 00 00       	mov    $0x15,%edx
  8000b0:	89 c7                	mov    %eax,%edi
  8000b2:	89 de                	mov    %ebx,%esi
  8000b4:	89 d1                	mov    %edx,%ecx
  8000b6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Counter[] = "flightBooked2Counter";
  8000b8:	8d 85 5a ff ff ff    	lea    -0xa6(%ebp),%eax
  8000be:	bb 1e 23 80 00       	mov    $0x80231e,%ebx
  8000c3:	ba 15 00 00 00       	mov    $0x15,%edx
  8000c8:	89 c7                	mov    %eax,%edi
  8000ca:	89 de                	mov    %ebx,%esi
  8000cc:	89 d1                	mov    %edx,%ecx
  8000ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Arr[] = "flightBooked1Arr";
  8000d0:	8d 85 49 ff ff ff    	lea    -0xb7(%ebp),%eax
  8000d6:	bb 33 23 80 00       	mov    $0x802333,%ebx
  8000db:	ba 11 00 00 00       	mov    $0x11,%edx
  8000e0:	89 c7                	mov    %eax,%edi
  8000e2:	89 de                	mov    %ebx,%esi
  8000e4:	89 d1                	mov    %edx,%ecx
  8000e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Arr[] = "flightBooked2Arr";
  8000e8:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  8000ee:	bb 44 23 80 00       	mov    $0x802344,%ebx
  8000f3:	ba 11 00 00 00       	mov    $0x11,%edx
  8000f8:	89 c7                	mov    %eax,%edi
  8000fa:	89 de                	mov    %ebx,%esi
  8000fc:	89 d1                	mov    %edx,%ecx
  8000fe:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _cust_ready_queue[] = "cust_ready_queue";
  800100:	8d 85 27 ff ff ff    	lea    -0xd9(%ebp),%eax
  800106:	bb 55 23 80 00       	mov    $0x802355,%ebx
  80010b:	ba 11 00 00 00       	mov    $0x11,%edx
  800110:	89 c7                	mov    %eax,%edi
  800112:	89 de                	mov    %ebx,%esi
  800114:	89 d1                	mov    %edx,%ecx
  800116:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_in[] = "queue_in";
  800118:	8d 85 1e ff ff ff    	lea    -0xe2(%ebp),%eax
  80011e:	bb 66 23 80 00       	mov    $0x802366,%ebx
  800123:	ba 09 00 00 00       	mov    $0x9,%edx
  800128:	89 c7                	mov    %eax,%edi
  80012a:	89 de                	mov    %ebx,%esi
  80012c:	89 d1                	mov    %edx,%ecx
  80012e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_out[] = "queue_out";
  800130:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
  800136:	bb 6f 23 80 00       	mov    $0x80236f,%ebx
  80013b:	ba 0a 00 00 00       	mov    $0xa,%edx
  800140:	89 c7                	mov    %eax,%edi
  800142:	89 de                	mov    %ebx,%esi
  800144:	89 d1                	mov    %edx,%ecx
  800146:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _cust_ready[] = "cust_ready";
  800148:	8d 85 09 ff ff ff    	lea    -0xf7(%ebp),%eax
  80014e:	bb 79 23 80 00       	mov    $0x802379,%ebx
  800153:	ba 0b 00 00 00       	mov    $0xb,%edx
  800158:	89 c7                	mov    %eax,%edi
  80015a:	89 de                	mov    %ebx,%esi
  80015c:	89 d1                	mov    %edx,%ecx
  80015e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custQueueCS[] = "custQueueCS";
  800160:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800166:	bb 84 23 80 00       	mov    $0x802384,%ebx
  80016b:	ba 03 00 00 00       	mov    $0x3,%edx
  800170:	89 c7                	mov    %eax,%edi
  800172:	89 de                	mov    %ebx,%esi
  800174:	89 d1                	mov    %edx,%ecx
  800176:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1CS[] = "flight1CS";
  800178:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  80017e:	bb 90 23 80 00       	mov    $0x802390,%ebx
  800183:	ba 0a 00 00 00       	mov    $0xa,%edx
  800188:	89 c7                	mov    %eax,%edi
  80018a:	89 de                	mov    %ebx,%esi
  80018c:	89 d1                	mov    %edx,%ecx
  80018e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2CS[] = "flight2CS";
  800190:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800196:	bb 9a 23 80 00       	mov    $0x80239a,%ebx
  80019b:	ba 0a 00 00 00       	mov    $0xa,%edx
  8001a0:	89 c7                	mov    %eax,%edi
  8001a2:	89 de                	mov    %ebx,%esi
  8001a4:	89 d1                	mov    %edx,%ecx
  8001a6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _clerk[] = "clerk";
  8001a8:	c7 85 e3 fe ff ff 63 	movl   $0x72656c63,-0x11d(%ebp)
  8001af:	6c 65 72 
  8001b2:	66 c7 85 e7 fe ff ff 	movw   $0x6b,-0x119(%ebp)
  8001b9:	6b 00 
	char _custCounterCS[] = "custCounterCS";
  8001bb:	8d 85 d5 fe ff ff    	lea    -0x12b(%ebp),%eax
  8001c1:	bb a4 23 80 00       	mov    $0x8023a4,%ebx
  8001c6:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001cb:	89 c7                	mov    %eax,%edi
  8001cd:	89 de                	mov    %ebx,%esi
  8001cf:	89 d1                	mov    %edx,%ecx
  8001d1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custTerminated[] = "custTerminated";
  8001d3:	8d 85 c6 fe ff ff    	lea    -0x13a(%ebp),%eax
  8001d9:	bb b2 23 80 00       	mov    $0x8023b2,%ebx
  8001de:	ba 0f 00 00 00       	mov    $0xf,%edx
  8001e3:	89 c7                	mov    %eax,%edi
  8001e5:	89 de                	mov    %ebx,%esi
  8001e7:	89 d1                	mov    %edx,%ecx
  8001e9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _taircl[] = "taircl";
  8001eb:	8d 85 bf fe ff ff    	lea    -0x141(%ebp),%eax
  8001f1:	bb c1 23 80 00       	mov    $0x8023c1,%ebx
  8001f6:	ba 07 00 00 00       	mov    $0x7,%edx
  8001fb:	89 c7                	mov    %eax,%edi
  8001fd:	89 de                	mov    %ebx,%esi
  8001ff:	89 d1                	mov    %edx,%ecx
  800201:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _taircu[] = "taircu";
  800203:	8d 85 b8 fe ff ff    	lea    -0x148(%ebp),%eax
  800209:	bb c8 23 80 00       	mov    $0x8023c8,%ebx
  80020e:	ba 07 00 00 00       	mov    $0x7,%edx
  800213:	89 c7                	mov    %eax,%edi
  800215:	89 de                	mov    %ebx,%esi
  800217:	89 d1                	mov    %edx,%ecx
  800219:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	struct Customer * customers = sget(parentenvID, _customers);
  80021b:	83 ec 08             	sub    $0x8,%esp
  80021e:	8d 45 ae             	lea    -0x52(%ebp),%eax
  800221:	50                   	push   %eax
  800222:	ff 75 e4             	pushl  -0x1c(%ebp)
  800225:	e8 de 16 00 00       	call   801908 <sget>
  80022a:	83 c4 10             	add    $0x10,%esp
  80022d:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int* flight1Counter = sget(parentenvID, _flight1Counter);
  800230:	83 ec 08             	sub    $0x8,%esp
  800233:	8d 45 93             	lea    -0x6d(%ebp),%eax
  800236:	50                   	push   %eax
  800237:	ff 75 e4             	pushl  -0x1c(%ebp)
  80023a:	e8 c9 16 00 00       	call   801908 <sget>
  80023f:	83 c4 10             	add    $0x10,%esp
  800242:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int* flight2Counter = sget(parentenvID, _flight2Counter);
  800245:	83 ec 08             	sub    $0x8,%esp
  800248:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80024b:	50                   	push   %eax
  80024c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80024f:	e8 b4 16 00 00       	call   801908 <sget>
  800254:	83 c4 10             	add    $0x10,%esp
  800257:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* flight1BookedCounter = sget(parentenvID, _flightBooked1Counter);
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	8d 85 6f ff ff ff    	lea    -0x91(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	ff 75 e4             	pushl  -0x1c(%ebp)
  800267:	e8 9c 16 00 00       	call   801908 <sget>
  80026c:	83 c4 10             	add    $0x10,%esp
  80026f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	int* flight2BookedCounter = sget(parentenvID, _flightBooked2Counter);
  800272:	83 ec 08             	sub    $0x8,%esp
  800275:	8d 85 5a ff ff ff    	lea    -0xa6(%ebp),%eax
  80027b:	50                   	push   %eax
  80027c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80027f:	e8 84 16 00 00       	call   801908 <sget>
  800284:	83 c4 10             	add    $0x10,%esp
  800287:	89 45 d0             	mov    %eax,-0x30(%ebp)

	int* flight1BookedArr = sget(parentenvID, _flightBooked1Arr);
  80028a:	83 ec 08             	sub    $0x8,%esp
  80028d:	8d 85 49 ff ff ff    	lea    -0xb7(%ebp),%eax
  800293:	50                   	push   %eax
  800294:	ff 75 e4             	pushl  -0x1c(%ebp)
  800297:	e8 6c 16 00 00       	call   801908 <sget>
  80029c:	83 c4 10             	add    $0x10,%esp
  80029f:	89 45 cc             	mov    %eax,-0x34(%ebp)
	int* flight2BookedArr = sget(parentenvID, _flightBooked2Arr);
  8002a2:	83 ec 08             	sub    $0x8,%esp
  8002a5:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  8002ab:	50                   	push   %eax
  8002ac:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002af:	e8 54 16 00 00       	call   801908 <sget>
  8002b4:	83 c4 10             	add    $0x10,%esp
  8002b7:	89 45 c8             	mov    %eax,-0x38(%ebp)

	int* cust_ready_queue = sget(parentenvID, _cust_ready_queue);
  8002ba:	83 ec 08             	sub    $0x8,%esp
  8002bd:	8d 85 27 ff ff ff    	lea    -0xd9(%ebp),%eax
  8002c3:	50                   	push   %eax
  8002c4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002c7:	e8 3c 16 00 00       	call   801908 <sget>
  8002cc:	83 c4 10             	add    $0x10,%esp
  8002cf:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	int* queue_out = sget(parentenvID, _queue_out);
  8002d2:	83 ec 08             	sub    $0x8,%esp
  8002d5:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
  8002db:	50                   	push   %eax
  8002dc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002df:	e8 24 16 00 00       	call   801908 <sget>
  8002e4:	83 c4 10             	add    $0x10,%esp
  8002e7:	89 45 c0             	mov    %eax,-0x40(%ebp)

	while(1==1)
	{
		int custId;
		//wait for a customer
		sys_waitSemaphore(parentenvID, _cust_ready);
  8002ea:	83 ec 08             	sub    $0x8,%esp
  8002ed:	8d 85 09 ff ff ff    	lea    -0xf7(%ebp),%eax
  8002f3:	50                   	push   %eax
  8002f4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002f7:	e8 f6 19 00 00       	call   801cf2 <sys_waitSemaphore>
  8002fc:	83 c4 10             	add    $0x10,%esp

		//dequeue the customer info
		sys_waitSemaphore(parentenvID, _custQueueCS);
  8002ff:	83 ec 08             	sub    $0x8,%esp
  800302:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800308:	50                   	push   %eax
  800309:	ff 75 e4             	pushl  -0x1c(%ebp)
  80030c:	e8 e1 19 00 00       	call   801cf2 <sys_waitSemaphore>
  800311:	83 c4 10             	add    $0x10,%esp
		{
			//cprintf("*queue_out = %d\n", *queue_out);
			custId = cust_ready_queue[*queue_out];
  800314:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800317:	8b 00                	mov    (%eax),%eax
  800319:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800320:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800323:	01 d0                	add    %edx,%eax
  800325:	8b 00                	mov    (%eax),%eax
  800327:	89 45 bc             	mov    %eax,-0x44(%ebp)
			*queue_out = *queue_out +1;
  80032a:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80032d:	8b 00                	mov    (%eax),%eax
  80032f:	8d 50 01             	lea    0x1(%eax),%edx
  800332:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800335:	89 10                	mov    %edx,(%eax)
		}
		sys_signalSemaphore(parentenvID, _custQueueCS);
  800337:	83 ec 08             	sub    $0x8,%esp
  80033a:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800340:	50                   	push   %eax
  800341:	ff 75 e4             	pushl  -0x1c(%ebp)
  800344:	e8 c7 19 00 00       	call   801d10 <sys_signalSemaphore>
  800349:	83 c4 10             	add    $0x10,%esp

		//try reserving on the required flight
		int custFlightType = customers[custId].flightType;
  80034c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80034f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800356:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800359:	01 d0                	add    %edx,%eax
  80035b:	8b 00                	mov    (%eax),%eax
  80035d:	89 45 b8             	mov    %eax,-0x48(%ebp)
		//cprintf("custId dequeued = %d, ft = %d\n", custId, customers[custId].flightType);

		switch (custFlightType)
  800360:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800363:	83 f8 02             	cmp    $0x2,%eax
  800366:	0f 84 90 00 00 00    	je     8003fc <_main+0x3c4>
  80036c:	83 f8 03             	cmp    $0x3,%eax
  80036f:	0f 84 05 01 00 00    	je     80047a <_main+0x442>
  800375:	83 f8 01             	cmp    $0x1,%eax
  800378:	0f 85 f8 01 00 00    	jne    800576 <_main+0x53e>
		{
		case 1:
		{
			//Check and update Flight1
			sys_waitSemaphore(parentenvID, _flight1CS);
  80037e:	83 ec 08             	sub    $0x8,%esp
  800381:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800387:	50                   	push   %eax
  800388:	ff 75 e4             	pushl  -0x1c(%ebp)
  80038b:	e8 62 19 00 00       	call   801cf2 <sys_waitSemaphore>
  800390:	83 c4 10             	add    $0x10,%esp
			{
				if(*flight1Counter > 0)
  800393:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800396:	8b 00                	mov    (%eax),%eax
  800398:	85 c0                	test   %eax,%eax
  80039a:	7e 46                	jle    8003e2 <_main+0x3aa>
				{
					*flight1Counter = *flight1Counter - 1;
  80039c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80039f:	8b 00                	mov    (%eax),%eax
  8003a1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8003a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003a7:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  8003a9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8003ac:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8003b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003b6:	01 d0                	add    %edx,%eax
  8003b8:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight1BookedArr[*flight1BookedCounter] = custId;
  8003bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003c2:	8b 00                	mov    (%eax),%eax
  8003c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cb:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8003ce:	01 c2                	add    %eax,%edx
  8003d0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8003d3:	89 02                	mov    %eax,(%edx)
					*flight1BookedCounter =*flight1BookedCounter+1;
  8003d5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003d8:	8b 00                	mov    (%eax),%eax
  8003da:	8d 50 01             	lea    0x1(%eax),%edx
  8003dd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003e0:	89 10                	mov    %edx,(%eax)
				else
				{

				}
			}
			sys_signalSemaphore(parentenvID, _flight1CS);
  8003e2:	83 ec 08             	sub    $0x8,%esp
  8003e5:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  8003eb:	50                   	push   %eax
  8003ec:	ff 75 e4             	pushl  -0x1c(%ebp)
  8003ef:	e8 1c 19 00 00       	call   801d10 <sys_signalSemaphore>
  8003f4:	83 c4 10             	add    $0x10,%esp
		}

		break;
  8003f7:	e9 91 01 00 00       	jmp    80058d <_main+0x555>
		case 2:
		{
			//Check and update Flight2
			sys_waitSemaphore(parentenvID, _flight2CS);
  8003fc:	83 ec 08             	sub    $0x8,%esp
  8003ff:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800405:	50                   	push   %eax
  800406:	ff 75 e4             	pushl  -0x1c(%ebp)
  800409:	e8 e4 18 00 00       	call   801cf2 <sys_waitSemaphore>
  80040e:	83 c4 10             	add    $0x10,%esp
			{
				if(*flight2Counter > 0)
  800411:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800414:	8b 00                	mov    (%eax),%eax
  800416:	85 c0                	test   %eax,%eax
  800418:	7e 46                	jle    800460 <_main+0x428>
				{
					*flight2Counter = *flight2Counter - 1;
  80041a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80041d:	8b 00                	mov    (%eax),%eax
  80041f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800422:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800425:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  800427:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80042a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800431:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800434:	01 d0                	add    %edx,%eax
  800436:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight2BookedArr[*flight2BookedCounter] = custId;
  80043d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800440:	8b 00                	mov    (%eax),%eax
  800442:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800449:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80044c:	01 c2                	add    %eax,%edx
  80044e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800451:	89 02                	mov    %eax,(%edx)
					*flight2BookedCounter =*flight2BookedCounter+1;
  800453:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800456:	8b 00                	mov    (%eax),%eax
  800458:	8d 50 01             	lea    0x1(%eax),%edx
  80045b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80045e:	89 10                	mov    %edx,(%eax)
				else
				{

				}
			}
			sys_signalSemaphore(parentenvID, _flight2CS);
  800460:	83 ec 08             	sub    $0x8,%esp
  800463:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800469:	50                   	push   %eax
  80046a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80046d:	e8 9e 18 00 00       	call   801d10 <sys_signalSemaphore>
  800472:	83 c4 10             	add    $0x10,%esp
		}
		break;
  800475:	e9 13 01 00 00       	jmp    80058d <_main+0x555>
		case 3:
		{
			//Check and update Both Flights
			sys_waitSemaphore(parentenvID, _flight1CS); sys_waitSemaphore(parentenvID, _flight2CS);
  80047a:	83 ec 08             	sub    $0x8,%esp
  80047d:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800483:	50                   	push   %eax
  800484:	ff 75 e4             	pushl  -0x1c(%ebp)
  800487:	e8 66 18 00 00       	call   801cf2 <sys_waitSemaphore>
  80048c:	83 c4 10             	add    $0x10,%esp
  80048f:	83 ec 08             	sub    $0x8,%esp
  800492:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800498:	50                   	push   %eax
  800499:	ff 75 e4             	pushl  -0x1c(%ebp)
  80049c:	e8 51 18 00 00       	call   801cf2 <sys_waitSemaphore>
  8004a1:	83 c4 10             	add    $0x10,%esp
			{
				if(*flight1Counter > 0 && *flight2Counter >0 )
  8004a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004a7:	8b 00                	mov    (%eax),%eax
  8004a9:	85 c0                	test   %eax,%eax
  8004ab:	0f 8e 99 00 00 00    	jle    80054a <_main+0x512>
  8004b1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8004b4:	8b 00                	mov    (%eax),%eax
  8004b6:	85 c0                	test   %eax,%eax
  8004b8:	0f 8e 8c 00 00 00    	jle    80054a <_main+0x512>
				{
					*flight1Counter = *flight1Counter - 1;
  8004be:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004c1:	8b 00                	mov    (%eax),%eax
  8004c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8004c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004c9:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  8004cb:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8004ce:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8004d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004d8:	01 d0                	add    %edx,%eax
  8004da:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight1BookedArr[*flight1BookedCounter] = custId;
  8004e1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8004e4:	8b 00                	mov    (%eax),%eax
  8004e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ed:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8004f0:	01 c2                	add    %eax,%edx
  8004f2:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8004f5:	89 02                	mov    %eax,(%edx)
					*flight1BookedCounter =*flight1BookedCounter+1;
  8004f7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8004fa:	8b 00                	mov    (%eax),%eax
  8004fc:	8d 50 01             	lea    0x1(%eax),%edx
  8004ff:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800502:	89 10                	mov    %edx,(%eax)

					*flight2Counter = *flight2Counter - 1;
  800504:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800507:	8b 00                	mov    (%eax),%eax
  800509:	8d 50 ff             	lea    -0x1(%eax),%edx
  80050c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80050f:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  800511:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800514:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80051b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80051e:	01 d0                	add    %edx,%eax
  800520:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight2BookedArr[*flight2BookedCounter] = custId;
  800527:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80052a:	8b 00                	mov    (%eax),%eax
  80052c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800533:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800536:	01 c2                	add    %eax,%edx
  800538:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80053b:	89 02                	mov    %eax,(%edx)
					*flight2BookedCounter =*flight2BookedCounter+1;
  80053d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800540:	8b 00                	mov    (%eax),%eax
  800542:	8d 50 01             	lea    0x1(%eax),%edx
  800545:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800548:	89 10                	mov    %edx,(%eax)
				else
				{

				}
			}
			sys_signalSemaphore(parentenvID, _flight2CS); sys_signalSemaphore(parentenvID, _flight1CS);
  80054a:	83 ec 08             	sub    $0x8,%esp
  80054d:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800553:	50                   	push   %eax
  800554:	ff 75 e4             	pushl  -0x1c(%ebp)
  800557:	e8 b4 17 00 00       	call   801d10 <sys_signalSemaphore>
  80055c:	83 c4 10             	add    $0x10,%esp
  80055f:	83 ec 08             	sub    $0x8,%esp
  800562:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800568:	50                   	push   %eax
  800569:	ff 75 e4             	pushl  -0x1c(%ebp)
  80056c:	e8 9f 17 00 00       	call   801d10 <sys_signalSemaphore>
  800571:	83 c4 10             	add    $0x10,%esp
		}
		break;
  800574:	eb 17                	jmp    80058d <_main+0x555>
		default:
			panic("customer must have flight type\n");
  800576:	83 ec 04             	sub    $0x4,%esp
  800579:	68 a0 22 80 00       	push   $0x8022a0
  80057e:	68 8f 00 00 00       	push   $0x8f
  800583:	68 c0 22 80 00       	push   $0x8022c0
  800588:	e8 9f 01 00 00       	call   80072c <_panic>
		}

		//signal finished
		char prefix[30]="cust_finished";
  80058d:	8d 85 9a fe ff ff    	lea    -0x166(%ebp),%eax
  800593:	bb cf 23 80 00       	mov    $0x8023cf,%ebx
  800598:	ba 0e 00 00 00       	mov    $0xe,%edx
  80059d:	89 c7                	mov    %eax,%edi
  80059f:	89 de                	mov    %ebx,%esi
  8005a1:	89 d1                	mov    %edx,%ecx
  8005a3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8005a5:	8d 95 a8 fe ff ff    	lea    -0x158(%ebp),%edx
  8005ab:	b9 04 00 00 00       	mov    $0x4,%ecx
  8005b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8005b5:	89 d7                	mov    %edx,%edi
  8005b7:	f3 ab                	rep stos %eax,%es:(%edi)
		char id[5]; char sname[50];
		ltostr(custId, id);
  8005b9:	83 ec 08             	sub    $0x8,%esp
  8005bc:	8d 85 95 fe ff ff    	lea    -0x16b(%ebp),%eax
  8005c2:	50                   	push   %eax
  8005c3:	ff 75 bc             	pushl  -0x44(%ebp)
  8005c6:	e8 3d 0f 00 00       	call   801508 <ltostr>
  8005cb:	83 c4 10             	add    $0x10,%esp
		strcconcat(prefix, id, sname);
  8005ce:	83 ec 04             	sub    $0x4,%esp
  8005d1:	8d 85 63 fe ff ff    	lea    -0x19d(%ebp),%eax
  8005d7:	50                   	push   %eax
  8005d8:	8d 85 95 fe ff ff    	lea    -0x16b(%ebp),%eax
  8005de:	50                   	push   %eax
  8005df:	8d 85 9a fe ff ff    	lea    -0x166(%ebp),%eax
  8005e5:	50                   	push   %eax
  8005e6:	e8 15 10 00 00       	call   801600 <strcconcat>
  8005eb:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(parentenvID, sname);
  8005ee:	83 ec 08             	sub    $0x8,%esp
  8005f1:	8d 85 63 fe ff ff    	lea    -0x19d(%ebp),%eax
  8005f7:	50                   	push   %eax
  8005f8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8005fb:	e8 10 17 00 00       	call   801d10 <sys_signalSemaphore>
  800600:	83 c4 10             	add    $0x10,%esp

		//signal the clerk
		sys_signalSemaphore(parentenvID, _clerk);
  800603:	83 ec 08             	sub    $0x8,%esp
  800606:	8d 85 e3 fe ff ff    	lea    -0x11d(%ebp),%eax
  80060c:	50                   	push   %eax
  80060d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800610:	e8 fb 16 00 00       	call   801d10 <sys_signalSemaphore>
  800615:	83 c4 10             	add    $0x10,%esp
	}
  800618:	e9 cd fc ff ff       	jmp    8002ea <_main+0x2b2>

0080061d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80061d:	55                   	push   %ebp
  80061e:	89 e5                	mov    %esp,%ebp
  800620:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800623:	e8 82 14 00 00       	call   801aaa <sys_getenvindex>
  800628:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80062b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80062e:	89 d0                	mov    %edx,%eax
  800630:	c1 e0 02             	shl    $0x2,%eax
  800633:	01 d0                	add    %edx,%eax
  800635:	01 c0                	add    %eax,%eax
  800637:	01 d0                	add    %edx,%eax
  800639:	01 c0                	add    %eax,%eax
  80063b:	01 d0                	add    %edx,%eax
  80063d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800644:	01 d0                	add    %edx,%eax
  800646:	c1 e0 02             	shl    $0x2,%eax
  800649:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80064e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800653:	a1 20 30 80 00       	mov    0x803020,%eax
  800658:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80065e:	84 c0                	test   %al,%al
  800660:	74 0f                	je     800671 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800662:	a1 20 30 80 00       	mov    0x803020,%eax
  800667:	05 f4 02 00 00       	add    $0x2f4,%eax
  80066c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800671:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800675:	7e 0a                	jle    800681 <libmain+0x64>
		binaryname = argv[0];
  800677:	8b 45 0c             	mov    0xc(%ebp),%eax
  80067a:	8b 00                	mov    (%eax),%eax
  80067c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800681:	83 ec 08             	sub    $0x8,%esp
  800684:	ff 75 0c             	pushl  0xc(%ebp)
  800687:	ff 75 08             	pushl  0x8(%ebp)
  80068a:	e8 a9 f9 ff ff       	call   800038 <_main>
  80068f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800692:	e8 ae 15 00 00       	call   801c45 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800697:	83 ec 0c             	sub    $0xc,%esp
  80069a:	68 08 24 80 00       	push   $0x802408
  80069f:	e8 3c 03 00 00       	call   8009e0 <cprintf>
  8006a4:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ac:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8006b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b7:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006bd:	83 ec 04             	sub    $0x4,%esp
  8006c0:	52                   	push   %edx
  8006c1:	50                   	push   %eax
  8006c2:	68 30 24 80 00       	push   $0x802430
  8006c7:	e8 14 03 00 00       	call   8009e0 <cprintf>
  8006cc:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8006d4:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8006da:	83 ec 08             	sub    $0x8,%esp
  8006dd:	50                   	push   %eax
  8006de:	68 55 24 80 00       	push   $0x802455
  8006e3:	e8 f8 02 00 00       	call   8009e0 <cprintf>
  8006e8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006eb:	83 ec 0c             	sub    $0xc,%esp
  8006ee:	68 08 24 80 00       	push   $0x802408
  8006f3:	e8 e8 02 00 00       	call   8009e0 <cprintf>
  8006f8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006fb:	e8 5f 15 00 00       	call   801c5f <sys_enable_interrupt>

	// exit gracefully
	exit();
  800700:	e8 19 00 00 00       	call   80071e <exit>
}
  800705:	90                   	nop
  800706:	c9                   	leave  
  800707:	c3                   	ret    

00800708 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800708:	55                   	push   %ebp
  800709:	89 e5                	mov    %esp,%ebp
  80070b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80070e:	83 ec 0c             	sub    $0xc,%esp
  800711:	6a 00                	push   $0x0
  800713:	e8 5e 13 00 00       	call   801a76 <sys_env_destroy>
  800718:	83 c4 10             	add    $0x10,%esp
}
  80071b:	90                   	nop
  80071c:	c9                   	leave  
  80071d:	c3                   	ret    

0080071e <exit>:

void
exit(void)
{
  80071e:	55                   	push   %ebp
  80071f:	89 e5                	mov    %esp,%ebp
  800721:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800724:	e8 b3 13 00 00       	call   801adc <sys_env_exit>
}
  800729:	90                   	nop
  80072a:	c9                   	leave  
  80072b:	c3                   	ret    

0080072c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80072c:	55                   	push   %ebp
  80072d:	89 e5                	mov    %esp,%ebp
  80072f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800732:	8d 45 10             	lea    0x10(%ebp),%eax
  800735:	83 c0 04             	add    $0x4,%eax
  800738:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80073b:	a1 34 30 80 00       	mov    0x803034,%eax
  800740:	85 c0                	test   %eax,%eax
  800742:	74 16                	je     80075a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800744:	a1 34 30 80 00       	mov    0x803034,%eax
  800749:	83 ec 08             	sub    $0x8,%esp
  80074c:	50                   	push   %eax
  80074d:	68 6c 24 80 00       	push   $0x80246c
  800752:	e8 89 02 00 00       	call   8009e0 <cprintf>
  800757:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80075a:	a1 00 30 80 00       	mov    0x803000,%eax
  80075f:	ff 75 0c             	pushl  0xc(%ebp)
  800762:	ff 75 08             	pushl  0x8(%ebp)
  800765:	50                   	push   %eax
  800766:	68 71 24 80 00       	push   $0x802471
  80076b:	e8 70 02 00 00       	call   8009e0 <cprintf>
  800770:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800773:	8b 45 10             	mov    0x10(%ebp),%eax
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	ff 75 f4             	pushl  -0xc(%ebp)
  80077c:	50                   	push   %eax
  80077d:	e8 f3 01 00 00       	call   800975 <vcprintf>
  800782:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800785:	83 ec 08             	sub    $0x8,%esp
  800788:	6a 00                	push   $0x0
  80078a:	68 8d 24 80 00       	push   $0x80248d
  80078f:	e8 e1 01 00 00       	call   800975 <vcprintf>
  800794:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800797:	e8 82 ff ff ff       	call   80071e <exit>

	// should not return here
	while (1) ;
  80079c:	eb fe                	jmp    80079c <_panic+0x70>

0080079e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80079e:	55                   	push   %ebp
  80079f:	89 e5                	mov    %esp,%ebp
  8007a1:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a9:	8b 50 74             	mov    0x74(%eax),%edx
  8007ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007af:	39 c2                	cmp    %eax,%edx
  8007b1:	74 14                	je     8007c7 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007b3:	83 ec 04             	sub    $0x4,%esp
  8007b6:	68 90 24 80 00       	push   $0x802490
  8007bb:	6a 26                	push   $0x26
  8007bd:	68 dc 24 80 00       	push   $0x8024dc
  8007c2:	e8 65 ff ff ff       	call   80072c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007d5:	e9 c2 00 00 00       	jmp    80089c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e7:	01 d0                	add    %edx,%eax
  8007e9:	8b 00                	mov    (%eax),%eax
  8007eb:	85 c0                	test   %eax,%eax
  8007ed:	75 08                	jne    8007f7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007ef:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007f2:	e9 a2 00 00 00       	jmp    800899 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007f7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007fe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800805:	eb 69                	jmp    800870 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800807:	a1 20 30 80 00       	mov    0x803020,%eax
  80080c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800812:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800815:	89 d0                	mov    %edx,%eax
  800817:	01 c0                	add    %eax,%eax
  800819:	01 d0                	add    %edx,%eax
  80081b:	c1 e0 02             	shl    $0x2,%eax
  80081e:	01 c8                	add    %ecx,%eax
  800820:	8a 40 04             	mov    0x4(%eax),%al
  800823:	84 c0                	test   %al,%al
  800825:	75 46                	jne    80086d <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800827:	a1 20 30 80 00       	mov    0x803020,%eax
  80082c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800832:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800835:	89 d0                	mov    %edx,%eax
  800837:	01 c0                	add    %eax,%eax
  800839:	01 d0                	add    %edx,%eax
  80083b:	c1 e0 02             	shl    $0x2,%eax
  80083e:	01 c8                	add    %ecx,%eax
  800840:	8b 00                	mov    (%eax),%eax
  800842:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800845:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800848:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80084d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80084f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800852:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800859:	8b 45 08             	mov    0x8(%ebp),%eax
  80085c:	01 c8                	add    %ecx,%eax
  80085e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800860:	39 c2                	cmp    %eax,%edx
  800862:	75 09                	jne    80086d <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800864:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80086b:	eb 12                	jmp    80087f <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80086d:	ff 45 e8             	incl   -0x18(%ebp)
  800870:	a1 20 30 80 00       	mov    0x803020,%eax
  800875:	8b 50 74             	mov    0x74(%eax),%edx
  800878:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80087b:	39 c2                	cmp    %eax,%edx
  80087d:	77 88                	ja     800807 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80087f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800883:	75 14                	jne    800899 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800885:	83 ec 04             	sub    $0x4,%esp
  800888:	68 e8 24 80 00       	push   $0x8024e8
  80088d:	6a 3a                	push   $0x3a
  80088f:	68 dc 24 80 00       	push   $0x8024dc
  800894:	e8 93 fe ff ff       	call   80072c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800899:	ff 45 f0             	incl   -0x10(%ebp)
  80089c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80089f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008a2:	0f 8c 32 ff ff ff    	jl     8007da <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008a8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008af:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008b6:	eb 26                	jmp    8008de <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8008bd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008c3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008c6:	89 d0                	mov    %edx,%eax
  8008c8:	01 c0                	add    %eax,%eax
  8008ca:	01 d0                	add    %edx,%eax
  8008cc:	c1 e0 02             	shl    $0x2,%eax
  8008cf:	01 c8                	add    %ecx,%eax
  8008d1:	8a 40 04             	mov    0x4(%eax),%al
  8008d4:	3c 01                	cmp    $0x1,%al
  8008d6:	75 03                	jne    8008db <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008d8:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008db:	ff 45 e0             	incl   -0x20(%ebp)
  8008de:	a1 20 30 80 00       	mov    0x803020,%eax
  8008e3:	8b 50 74             	mov    0x74(%eax),%edx
  8008e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008e9:	39 c2                	cmp    %eax,%edx
  8008eb:	77 cb                	ja     8008b8 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008f0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008f3:	74 14                	je     800909 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008f5:	83 ec 04             	sub    $0x4,%esp
  8008f8:	68 3c 25 80 00       	push   $0x80253c
  8008fd:	6a 44                	push   $0x44
  8008ff:	68 dc 24 80 00       	push   $0x8024dc
  800904:	e8 23 fe ff ff       	call   80072c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800909:	90                   	nop
  80090a:	c9                   	leave  
  80090b:	c3                   	ret    

0080090c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80090c:	55                   	push   %ebp
  80090d:	89 e5                	mov    %esp,%ebp
  80090f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800912:	8b 45 0c             	mov    0xc(%ebp),%eax
  800915:	8b 00                	mov    (%eax),%eax
  800917:	8d 48 01             	lea    0x1(%eax),%ecx
  80091a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091d:	89 0a                	mov    %ecx,(%edx)
  80091f:	8b 55 08             	mov    0x8(%ebp),%edx
  800922:	88 d1                	mov    %dl,%cl
  800924:	8b 55 0c             	mov    0xc(%ebp),%edx
  800927:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80092b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092e:	8b 00                	mov    (%eax),%eax
  800930:	3d ff 00 00 00       	cmp    $0xff,%eax
  800935:	75 2c                	jne    800963 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800937:	a0 24 30 80 00       	mov    0x803024,%al
  80093c:	0f b6 c0             	movzbl %al,%eax
  80093f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800942:	8b 12                	mov    (%edx),%edx
  800944:	89 d1                	mov    %edx,%ecx
  800946:	8b 55 0c             	mov    0xc(%ebp),%edx
  800949:	83 c2 08             	add    $0x8,%edx
  80094c:	83 ec 04             	sub    $0x4,%esp
  80094f:	50                   	push   %eax
  800950:	51                   	push   %ecx
  800951:	52                   	push   %edx
  800952:	e8 dd 10 00 00       	call   801a34 <sys_cputs>
  800957:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80095a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800963:	8b 45 0c             	mov    0xc(%ebp),%eax
  800966:	8b 40 04             	mov    0x4(%eax),%eax
  800969:	8d 50 01             	lea    0x1(%eax),%edx
  80096c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80096f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800972:	90                   	nop
  800973:	c9                   	leave  
  800974:	c3                   	ret    

00800975 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800975:	55                   	push   %ebp
  800976:	89 e5                	mov    %esp,%ebp
  800978:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80097e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800985:	00 00 00 
	b.cnt = 0;
  800988:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80098f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800992:	ff 75 0c             	pushl  0xc(%ebp)
  800995:	ff 75 08             	pushl  0x8(%ebp)
  800998:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80099e:	50                   	push   %eax
  80099f:	68 0c 09 80 00       	push   $0x80090c
  8009a4:	e8 11 02 00 00       	call   800bba <vprintfmt>
  8009a9:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009ac:	a0 24 30 80 00       	mov    0x803024,%al
  8009b1:	0f b6 c0             	movzbl %al,%eax
  8009b4:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009ba:	83 ec 04             	sub    $0x4,%esp
  8009bd:	50                   	push   %eax
  8009be:	52                   	push   %edx
  8009bf:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009c5:	83 c0 08             	add    $0x8,%eax
  8009c8:	50                   	push   %eax
  8009c9:	e8 66 10 00 00       	call   801a34 <sys_cputs>
  8009ce:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009d1:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009d8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009de:	c9                   	leave  
  8009df:	c3                   	ret    

008009e0 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009e0:	55                   	push   %ebp
  8009e1:	89 e5                	mov    %esp,%ebp
  8009e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009e6:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009ed:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f6:	83 ec 08             	sub    $0x8,%esp
  8009f9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009fc:	50                   	push   %eax
  8009fd:	e8 73 ff ff ff       	call   800975 <vcprintf>
  800a02:	83 c4 10             	add    $0x10,%esp
  800a05:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a08:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a0b:	c9                   	leave  
  800a0c:	c3                   	ret    

00800a0d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a0d:	55                   	push   %ebp
  800a0e:	89 e5                	mov    %esp,%ebp
  800a10:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a13:	e8 2d 12 00 00       	call   801c45 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a18:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a21:	83 ec 08             	sub    $0x8,%esp
  800a24:	ff 75 f4             	pushl  -0xc(%ebp)
  800a27:	50                   	push   %eax
  800a28:	e8 48 ff ff ff       	call   800975 <vcprintf>
  800a2d:	83 c4 10             	add    $0x10,%esp
  800a30:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a33:	e8 27 12 00 00       	call   801c5f <sys_enable_interrupt>
	return cnt;
  800a38:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a3b:	c9                   	leave  
  800a3c:	c3                   	ret    

00800a3d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a3d:	55                   	push   %ebp
  800a3e:	89 e5                	mov    %esp,%ebp
  800a40:	53                   	push   %ebx
  800a41:	83 ec 14             	sub    $0x14,%esp
  800a44:	8b 45 10             	mov    0x10(%ebp),%eax
  800a47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a50:	8b 45 18             	mov    0x18(%ebp),%eax
  800a53:	ba 00 00 00 00       	mov    $0x0,%edx
  800a58:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a5b:	77 55                	ja     800ab2 <printnum+0x75>
  800a5d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a60:	72 05                	jb     800a67 <printnum+0x2a>
  800a62:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a65:	77 4b                	ja     800ab2 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a67:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a6a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a6d:	8b 45 18             	mov    0x18(%ebp),%eax
  800a70:	ba 00 00 00 00       	mov    $0x0,%edx
  800a75:	52                   	push   %edx
  800a76:	50                   	push   %eax
  800a77:	ff 75 f4             	pushl  -0xc(%ebp)
  800a7a:	ff 75 f0             	pushl  -0x10(%ebp)
  800a7d:	e8 a2 15 00 00       	call   802024 <__udivdi3>
  800a82:	83 c4 10             	add    $0x10,%esp
  800a85:	83 ec 04             	sub    $0x4,%esp
  800a88:	ff 75 20             	pushl  0x20(%ebp)
  800a8b:	53                   	push   %ebx
  800a8c:	ff 75 18             	pushl  0x18(%ebp)
  800a8f:	52                   	push   %edx
  800a90:	50                   	push   %eax
  800a91:	ff 75 0c             	pushl  0xc(%ebp)
  800a94:	ff 75 08             	pushl  0x8(%ebp)
  800a97:	e8 a1 ff ff ff       	call   800a3d <printnum>
  800a9c:	83 c4 20             	add    $0x20,%esp
  800a9f:	eb 1a                	jmp    800abb <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800aa1:	83 ec 08             	sub    $0x8,%esp
  800aa4:	ff 75 0c             	pushl  0xc(%ebp)
  800aa7:	ff 75 20             	pushl  0x20(%ebp)
  800aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800aad:	ff d0                	call   *%eax
  800aaf:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ab2:	ff 4d 1c             	decl   0x1c(%ebp)
  800ab5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ab9:	7f e6                	jg     800aa1 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800abb:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800abe:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ac3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ac6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ac9:	53                   	push   %ebx
  800aca:	51                   	push   %ecx
  800acb:	52                   	push   %edx
  800acc:	50                   	push   %eax
  800acd:	e8 62 16 00 00       	call   802134 <__umoddi3>
  800ad2:	83 c4 10             	add    $0x10,%esp
  800ad5:	05 b4 27 80 00       	add    $0x8027b4,%eax
  800ada:	8a 00                	mov    (%eax),%al
  800adc:	0f be c0             	movsbl %al,%eax
  800adf:	83 ec 08             	sub    $0x8,%esp
  800ae2:	ff 75 0c             	pushl  0xc(%ebp)
  800ae5:	50                   	push   %eax
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	ff d0                	call   *%eax
  800aeb:	83 c4 10             	add    $0x10,%esp
}
  800aee:	90                   	nop
  800aef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800af2:	c9                   	leave  
  800af3:	c3                   	ret    

00800af4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800af4:	55                   	push   %ebp
  800af5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800af7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800afb:	7e 1c                	jle    800b19 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	8b 00                	mov    (%eax),%eax
  800b02:	8d 50 08             	lea    0x8(%eax),%edx
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	89 10                	mov    %edx,(%eax)
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	8b 00                	mov    (%eax),%eax
  800b0f:	83 e8 08             	sub    $0x8,%eax
  800b12:	8b 50 04             	mov    0x4(%eax),%edx
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	eb 40                	jmp    800b59 <getuint+0x65>
	else if (lflag)
  800b19:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1d:	74 1e                	je     800b3d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	8d 50 04             	lea    0x4(%eax),%edx
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	89 10                	mov    %edx,(%eax)
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	8b 00                	mov    (%eax),%eax
  800b31:	83 e8 04             	sub    $0x4,%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	ba 00 00 00 00       	mov    $0x0,%edx
  800b3b:	eb 1c                	jmp    800b59 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	8b 00                	mov    (%eax),%eax
  800b42:	8d 50 04             	lea    0x4(%eax),%edx
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	89 10                	mov    %edx,(%eax)
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4d:	8b 00                	mov    (%eax),%eax
  800b4f:	83 e8 04             	sub    $0x4,%eax
  800b52:	8b 00                	mov    (%eax),%eax
  800b54:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b59:	5d                   	pop    %ebp
  800b5a:	c3                   	ret    

00800b5b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b5b:	55                   	push   %ebp
  800b5c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b5e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b62:	7e 1c                	jle    800b80 <getint+0x25>
		return va_arg(*ap, long long);
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	8b 00                	mov    (%eax),%eax
  800b69:	8d 50 08             	lea    0x8(%eax),%edx
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	89 10                	mov    %edx,(%eax)
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	8b 00                	mov    (%eax),%eax
  800b76:	83 e8 08             	sub    $0x8,%eax
  800b79:	8b 50 04             	mov    0x4(%eax),%edx
  800b7c:	8b 00                	mov    (%eax),%eax
  800b7e:	eb 38                	jmp    800bb8 <getint+0x5d>
	else if (lflag)
  800b80:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b84:	74 1a                	je     800ba0 <getint+0x45>
		return va_arg(*ap, long);
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	8b 00                	mov    (%eax),%eax
  800b8b:	8d 50 04             	lea    0x4(%eax),%edx
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	89 10                	mov    %edx,(%eax)
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	8b 00                	mov    (%eax),%eax
  800b98:	83 e8 04             	sub    $0x4,%eax
  800b9b:	8b 00                	mov    (%eax),%eax
  800b9d:	99                   	cltd   
  800b9e:	eb 18                	jmp    800bb8 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	8b 00                	mov    (%eax),%eax
  800ba5:	8d 50 04             	lea    0x4(%eax),%edx
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	89 10                	mov    %edx,(%eax)
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb0:	8b 00                	mov    (%eax),%eax
  800bb2:	83 e8 04             	sub    $0x4,%eax
  800bb5:	8b 00                	mov    (%eax),%eax
  800bb7:	99                   	cltd   
}
  800bb8:	5d                   	pop    %ebp
  800bb9:	c3                   	ret    

00800bba <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bba:	55                   	push   %ebp
  800bbb:	89 e5                	mov    %esp,%ebp
  800bbd:	56                   	push   %esi
  800bbe:	53                   	push   %ebx
  800bbf:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bc2:	eb 17                	jmp    800bdb <vprintfmt+0x21>
			if (ch == '\0')
  800bc4:	85 db                	test   %ebx,%ebx
  800bc6:	0f 84 af 03 00 00    	je     800f7b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bcc:	83 ec 08             	sub    $0x8,%esp
  800bcf:	ff 75 0c             	pushl  0xc(%ebp)
  800bd2:	53                   	push   %ebx
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	ff d0                	call   *%eax
  800bd8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bdb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bde:	8d 50 01             	lea    0x1(%eax),%edx
  800be1:	89 55 10             	mov    %edx,0x10(%ebp)
  800be4:	8a 00                	mov    (%eax),%al
  800be6:	0f b6 d8             	movzbl %al,%ebx
  800be9:	83 fb 25             	cmp    $0x25,%ebx
  800bec:	75 d6                	jne    800bc4 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bee:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bf2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bf9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c00:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c07:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c11:	8d 50 01             	lea    0x1(%eax),%edx
  800c14:	89 55 10             	mov    %edx,0x10(%ebp)
  800c17:	8a 00                	mov    (%eax),%al
  800c19:	0f b6 d8             	movzbl %al,%ebx
  800c1c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c1f:	83 f8 55             	cmp    $0x55,%eax
  800c22:	0f 87 2b 03 00 00    	ja     800f53 <vprintfmt+0x399>
  800c28:	8b 04 85 d8 27 80 00 	mov    0x8027d8(,%eax,4),%eax
  800c2f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c31:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c35:	eb d7                	jmp    800c0e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c37:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c3b:	eb d1                	jmp    800c0e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c3d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c44:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c47:	89 d0                	mov    %edx,%eax
  800c49:	c1 e0 02             	shl    $0x2,%eax
  800c4c:	01 d0                	add    %edx,%eax
  800c4e:	01 c0                	add    %eax,%eax
  800c50:	01 d8                	add    %ebx,%eax
  800c52:	83 e8 30             	sub    $0x30,%eax
  800c55:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c58:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5b:	8a 00                	mov    (%eax),%al
  800c5d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c60:	83 fb 2f             	cmp    $0x2f,%ebx
  800c63:	7e 3e                	jle    800ca3 <vprintfmt+0xe9>
  800c65:	83 fb 39             	cmp    $0x39,%ebx
  800c68:	7f 39                	jg     800ca3 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c6a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c6d:	eb d5                	jmp    800c44 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c6f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c72:	83 c0 04             	add    $0x4,%eax
  800c75:	89 45 14             	mov    %eax,0x14(%ebp)
  800c78:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7b:	83 e8 04             	sub    $0x4,%eax
  800c7e:	8b 00                	mov    (%eax),%eax
  800c80:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c83:	eb 1f                	jmp    800ca4 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c85:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c89:	79 83                	jns    800c0e <vprintfmt+0x54>
				width = 0;
  800c8b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c92:	e9 77 ff ff ff       	jmp    800c0e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c97:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c9e:	e9 6b ff ff ff       	jmp    800c0e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ca3:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ca4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ca8:	0f 89 60 ff ff ff    	jns    800c0e <vprintfmt+0x54>
				width = precision, precision = -1;
  800cae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cb1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cb4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cbb:	e9 4e ff ff ff       	jmp    800c0e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cc0:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cc3:	e9 46 ff ff ff       	jmp    800c0e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cc8:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccb:	83 c0 04             	add    $0x4,%eax
  800cce:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd4:	83 e8 04             	sub    $0x4,%eax
  800cd7:	8b 00                	mov    (%eax),%eax
  800cd9:	83 ec 08             	sub    $0x8,%esp
  800cdc:	ff 75 0c             	pushl  0xc(%ebp)
  800cdf:	50                   	push   %eax
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	ff d0                	call   *%eax
  800ce5:	83 c4 10             	add    $0x10,%esp
			break;
  800ce8:	e9 89 02 00 00       	jmp    800f76 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ced:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf0:	83 c0 04             	add    $0x4,%eax
  800cf3:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf9:	83 e8 04             	sub    $0x4,%eax
  800cfc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cfe:	85 db                	test   %ebx,%ebx
  800d00:	79 02                	jns    800d04 <vprintfmt+0x14a>
				err = -err;
  800d02:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d04:	83 fb 64             	cmp    $0x64,%ebx
  800d07:	7f 0b                	jg     800d14 <vprintfmt+0x15a>
  800d09:	8b 34 9d 20 26 80 00 	mov    0x802620(,%ebx,4),%esi
  800d10:	85 f6                	test   %esi,%esi
  800d12:	75 19                	jne    800d2d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d14:	53                   	push   %ebx
  800d15:	68 c5 27 80 00       	push   $0x8027c5
  800d1a:	ff 75 0c             	pushl  0xc(%ebp)
  800d1d:	ff 75 08             	pushl  0x8(%ebp)
  800d20:	e8 5e 02 00 00       	call   800f83 <printfmt>
  800d25:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d28:	e9 49 02 00 00       	jmp    800f76 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d2d:	56                   	push   %esi
  800d2e:	68 ce 27 80 00       	push   $0x8027ce
  800d33:	ff 75 0c             	pushl  0xc(%ebp)
  800d36:	ff 75 08             	pushl  0x8(%ebp)
  800d39:	e8 45 02 00 00       	call   800f83 <printfmt>
  800d3e:	83 c4 10             	add    $0x10,%esp
			break;
  800d41:	e9 30 02 00 00       	jmp    800f76 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d46:	8b 45 14             	mov    0x14(%ebp),%eax
  800d49:	83 c0 04             	add    $0x4,%eax
  800d4c:	89 45 14             	mov    %eax,0x14(%ebp)
  800d4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d52:	83 e8 04             	sub    $0x4,%eax
  800d55:	8b 30                	mov    (%eax),%esi
  800d57:	85 f6                	test   %esi,%esi
  800d59:	75 05                	jne    800d60 <vprintfmt+0x1a6>
				p = "(null)";
  800d5b:	be d1 27 80 00       	mov    $0x8027d1,%esi
			if (width > 0 && padc != '-')
  800d60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d64:	7e 6d                	jle    800dd3 <vprintfmt+0x219>
  800d66:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d6a:	74 67                	je     800dd3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d6c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d6f:	83 ec 08             	sub    $0x8,%esp
  800d72:	50                   	push   %eax
  800d73:	56                   	push   %esi
  800d74:	e8 0c 03 00 00       	call   801085 <strnlen>
  800d79:	83 c4 10             	add    $0x10,%esp
  800d7c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d7f:	eb 16                	jmp    800d97 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d81:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d85:	83 ec 08             	sub    $0x8,%esp
  800d88:	ff 75 0c             	pushl  0xc(%ebp)
  800d8b:	50                   	push   %eax
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	ff d0                	call   *%eax
  800d91:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d94:	ff 4d e4             	decl   -0x1c(%ebp)
  800d97:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d9b:	7f e4                	jg     800d81 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d9d:	eb 34                	jmp    800dd3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d9f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800da3:	74 1c                	je     800dc1 <vprintfmt+0x207>
  800da5:	83 fb 1f             	cmp    $0x1f,%ebx
  800da8:	7e 05                	jle    800daf <vprintfmt+0x1f5>
  800daa:	83 fb 7e             	cmp    $0x7e,%ebx
  800dad:	7e 12                	jle    800dc1 <vprintfmt+0x207>
					putch('?', putdat);
  800daf:	83 ec 08             	sub    $0x8,%esp
  800db2:	ff 75 0c             	pushl  0xc(%ebp)
  800db5:	6a 3f                	push   $0x3f
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dba:	ff d0                	call   *%eax
  800dbc:	83 c4 10             	add    $0x10,%esp
  800dbf:	eb 0f                	jmp    800dd0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800dc1:	83 ec 08             	sub    $0x8,%esp
  800dc4:	ff 75 0c             	pushl  0xc(%ebp)
  800dc7:	53                   	push   %ebx
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	ff d0                	call   *%eax
  800dcd:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dd0:	ff 4d e4             	decl   -0x1c(%ebp)
  800dd3:	89 f0                	mov    %esi,%eax
  800dd5:	8d 70 01             	lea    0x1(%eax),%esi
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	0f be d8             	movsbl %al,%ebx
  800ddd:	85 db                	test   %ebx,%ebx
  800ddf:	74 24                	je     800e05 <vprintfmt+0x24b>
  800de1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800de5:	78 b8                	js     800d9f <vprintfmt+0x1e5>
  800de7:	ff 4d e0             	decl   -0x20(%ebp)
  800dea:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dee:	79 af                	jns    800d9f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800df0:	eb 13                	jmp    800e05 <vprintfmt+0x24b>
				putch(' ', putdat);
  800df2:	83 ec 08             	sub    $0x8,%esp
  800df5:	ff 75 0c             	pushl  0xc(%ebp)
  800df8:	6a 20                	push   $0x20
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	ff d0                	call   *%eax
  800dff:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e02:	ff 4d e4             	decl   -0x1c(%ebp)
  800e05:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e09:	7f e7                	jg     800df2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e0b:	e9 66 01 00 00       	jmp    800f76 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e10:	83 ec 08             	sub    $0x8,%esp
  800e13:	ff 75 e8             	pushl  -0x18(%ebp)
  800e16:	8d 45 14             	lea    0x14(%ebp),%eax
  800e19:	50                   	push   %eax
  800e1a:	e8 3c fd ff ff       	call   800b5b <getint>
  800e1f:	83 c4 10             	add    $0x10,%esp
  800e22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e25:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e2b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e2e:	85 d2                	test   %edx,%edx
  800e30:	79 23                	jns    800e55 <vprintfmt+0x29b>
				putch('-', putdat);
  800e32:	83 ec 08             	sub    $0x8,%esp
  800e35:	ff 75 0c             	pushl  0xc(%ebp)
  800e38:	6a 2d                	push   $0x2d
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	ff d0                	call   *%eax
  800e3f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e42:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e45:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e48:	f7 d8                	neg    %eax
  800e4a:	83 d2 00             	adc    $0x0,%edx
  800e4d:	f7 da                	neg    %edx
  800e4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e52:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e55:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e5c:	e9 bc 00 00 00       	jmp    800f1d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e61:	83 ec 08             	sub    $0x8,%esp
  800e64:	ff 75 e8             	pushl  -0x18(%ebp)
  800e67:	8d 45 14             	lea    0x14(%ebp),%eax
  800e6a:	50                   	push   %eax
  800e6b:	e8 84 fc ff ff       	call   800af4 <getuint>
  800e70:	83 c4 10             	add    $0x10,%esp
  800e73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e76:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e79:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e80:	e9 98 00 00 00       	jmp    800f1d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e85:	83 ec 08             	sub    $0x8,%esp
  800e88:	ff 75 0c             	pushl  0xc(%ebp)
  800e8b:	6a 58                	push   $0x58
  800e8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e90:	ff d0                	call   *%eax
  800e92:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e95:	83 ec 08             	sub    $0x8,%esp
  800e98:	ff 75 0c             	pushl  0xc(%ebp)
  800e9b:	6a 58                	push   $0x58
  800e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea0:	ff d0                	call   *%eax
  800ea2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ea5:	83 ec 08             	sub    $0x8,%esp
  800ea8:	ff 75 0c             	pushl  0xc(%ebp)
  800eab:	6a 58                	push   $0x58
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb0:	ff d0                	call   *%eax
  800eb2:	83 c4 10             	add    $0x10,%esp
			break;
  800eb5:	e9 bc 00 00 00       	jmp    800f76 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800eba:	83 ec 08             	sub    $0x8,%esp
  800ebd:	ff 75 0c             	pushl  0xc(%ebp)
  800ec0:	6a 30                	push   $0x30
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	ff d0                	call   *%eax
  800ec7:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eca:	83 ec 08             	sub    $0x8,%esp
  800ecd:	ff 75 0c             	pushl  0xc(%ebp)
  800ed0:	6a 78                	push   $0x78
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	ff d0                	call   *%eax
  800ed7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eda:	8b 45 14             	mov    0x14(%ebp),%eax
  800edd:	83 c0 04             	add    $0x4,%eax
  800ee0:	89 45 14             	mov    %eax,0x14(%ebp)
  800ee3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee6:	83 e8 04             	sub    $0x4,%eax
  800ee9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800eeb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ef5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800efc:	eb 1f                	jmp    800f1d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800efe:	83 ec 08             	sub    $0x8,%esp
  800f01:	ff 75 e8             	pushl  -0x18(%ebp)
  800f04:	8d 45 14             	lea    0x14(%ebp),%eax
  800f07:	50                   	push   %eax
  800f08:	e8 e7 fb ff ff       	call   800af4 <getuint>
  800f0d:	83 c4 10             	add    $0x10,%esp
  800f10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f13:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f16:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f1d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f24:	83 ec 04             	sub    $0x4,%esp
  800f27:	52                   	push   %edx
  800f28:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f2b:	50                   	push   %eax
  800f2c:	ff 75 f4             	pushl  -0xc(%ebp)
  800f2f:	ff 75 f0             	pushl  -0x10(%ebp)
  800f32:	ff 75 0c             	pushl  0xc(%ebp)
  800f35:	ff 75 08             	pushl  0x8(%ebp)
  800f38:	e8 00 fb ff ff       	call   800a3d <printnum>
  800f3d:	83 c4 20             	add    $0x20,%esp
			break;
  800f40:	eb 34                	jmp    800f76 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f42:	83 ec 08             	sub    $0x8,%esp
  800f45:	ff 75 0c             	pushl  0xc(%ebp)
  800f48:	53                   	push   %ebx
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4c:	ff d0                	call   *%eax
  800f4e:	83 c4 10             	add    $0x10,%esp
			break;
  800f51:	eb 23                	jmp    800f76 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f53:	83 ec 08             	sub    $0x8,%esp
  800f56:	ff 75 0c             	pushl  0xc(%ebp)
  800f59:	6a 25                	push   $0x25
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5e:	ff d0                	call   *%eax
  800f60:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f63:	ff 4d 10             	decl   0x10(%ebp)
  800f66:	eb 03                	jmp    800f6b <vprintfmt+0x3b1>
  800f68:	ff 4d 10             	decl   0x10(%ebp)
  800f6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6e:	48                   	dec    %eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	3c 25                	cmp    $0x25,%al
  800f73:	75 f3                	jne    800f68 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f75:	90                   	nop
		}
	}
  800f76:	e9 47 fc ff ff       	jmp    800bc2 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f7b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f7c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f7f:	5b                   	pop    %ebx
  800f80:	5e                   	pop    %esi
  800f81:	5d                   	pop    %ebp
  800f82:	c3                   	ret    

00800f83 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f83:	55                   	push   %ebp
  800f84:	89 e5                	mov    %esp,%ebp
  800f86:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f89:	8d 45 10             	lea    0x10(%ebp),%eax
  800f8c:	83 c0 04             	add    $0x4,%eax
  800f8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f92:	8b 45 10             	mov    0x10(%ebp),%eax
  800f95:	ff 75 f4             	pushl  -0xc(%ebp)
  800f98:	50                   	push   %eax
  800f99:	ff 75 0c             	pushl  0xc(%ebp)
  800f9c:	ff 75 08             	pushl  0x8(%ebp)
  800f9f:	e8 16 fc ff ff       	call   800bba <vprintfmt>
  800fa4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fa7:	90                   	nop
  800fa8:	c9                   	leave  
  800fa9:	c3                   	ret    

00800faa <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800faa:	55                   	push   %ebp
  800fab:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb0:	8b 40 08             	mov    0x8(%eax),%eax
  800fb3:	8d 50 01             	lea    0x1(%eax),%edx
  800fb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbf:	8b 10                	mov    (%eax),%edx
  800fc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc4:	8b 40 04             	mov    0x4(%eax),%eax
  800fc7:	39 c2                	cmp    %eax,%edx
  800fc9:	73 12                	jae    800fdd <sprintputch+0x33>
		*b->buf++ = ch;
  800fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fce:	8b 00                	mov    (%eax),%eax
  800fd0:	8d 48 01             	lea    0x1(%eax),%ecx
  800fd3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fd6:	89 0a                	mov    %ecx,(%edx)
  800fd8:	8b 55 08             	mov    0x8(%ebp),%edx
  800fdb:	88 10                	mov    %dl,(%eax)
}
  800fdd:	90                   	nop
  800fde:	5d                   	pop    %ebp
  800fdf:	c3                   	ret    

00800fe0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fe0:	55                   	push   %ebp
  800fe1:	89 e5                	mov    %esp,%ebp
  800fe3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fef:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff5:	01 d0                	add    %edx,%eax
  800ff7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ffa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801001:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801005:	74 06                	je     80100d <vsnprintf+0x2d>
  801007:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80100b:	7f 07                	jg     801014 <vsnprintf+0x34>
		return -E_INVAL;
  80100d:	b8 03 00 00 00       	mov    $0x3,%eax
  801012:	eb 20                	jmp    801034 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801014:	ff 75 14             	pushl  0x14(%ebp)
  801017:	ff 75 10             	pushl  0x10(%ebp)
  80101a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80101d:	50                   	push   %eax
  80101e:	68 aa 0f 80 00       	push   $0x800faa
  801023:	e8 92 fb ff ff       	call   800bba <vprintfmt>
  801028:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80102b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80102e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801031:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801034:	c9                   	leave  
  801035:	c3                   	ret    

00801036 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801036:	55                   	push   %ebp
  801037:	89 e5                	mov    %esp,%ebp
  801039:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80103c:	8d 45 10             	lea    0x10(%ebp),%eax
  80103f:	83 c0 04             	add    $0x4,%eax
  801042:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801045:	8b 45 10             	mov    0x10(%ebp),%eax
  801048:	ff 75 f4             	pushl  -0xc(%ebp)
  80104b:	50                   	push   %eax
  80104c:	ff 75 0c             	pushl  0xc(%ebp)
  80104f:	ff 75 08             	pushl  0x8(%ebp)
  801052:	e8 89 ff ff ff       	call   800fe0 <vsnprintf>
  801057:	83 c4 10             	add    $0x10,%esp
  80105a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80105d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801060:	c9                   	leave  
  801061:	c3                   	ret    

00801062 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801062:	55                   	push   %ebp
  801063:	89 e5                	mov    %esp,%ebp
  801065:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801068:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80106f:	eb 06                	jmp    801077 <strlen+0x15>
		n++;
  801071:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801074:	ff 45 08             	incl   0x8(%ebp)
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	8a 00                	mov    (%eax),%al
  80107c:	84 c0                	test   %al,%al
  80107e:	75 f1                	jne    801071 <strlen+0xf>
		n++;
	return n;
  801080:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801083:	c9                   	leave  
  801084:	c3                   	ret    

00801085 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801085:	55                   	push   %ebp
  801086:	89 e5                	mov    %esp,%ebp
  801088:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80108b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801092:	eb 09                	jmp    80109d <strnlen+0x18>
		n++;
  801094:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801097:	ff 45 08             	incl   0x8(%ebp)
  80109a:	ff 4d 0c             	decl   0xc(%ebp)
  80109d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010a1:	74 09                	je     8010ac <strnlen+0x27>
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a6:	8a 00                	mov    (%eax),%al
  8010a8:	84 c0                	test   %al,%al
  8010aa:	75 e8                	jne    801094 <strnlen+0xf>
		n++;
	return n;
  8010ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010af:	c9                   	leave  
  8010b0:	c3                   	ret    

008010b1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8010b1:	55                   	push   %ebp
  8010b2:	89 e5                	mov    %esp,%ebp
  8010b4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8010bd:	90                   	nop
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	8d 50 01             	lea    0x1(%eax),%edx
  8010c4:	89 55 08             	mov    %edx,0x8(%ebp)
  8010c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ca:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010cd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010d0:	8a 12                	mov    (%edx),%dl
  8010d2:	88 10                	mov    %dl,(%eax)
  8010d4:	8a 00                	mov    (%eax),%al
  8010d6:	84 c0                	test   %al,%al
  8010d8:	75 e4                	jne    8010be <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010dd:	c9                   	leave  
  8010de:	c3                   	ret    

008010df <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010df:	55                   	push   %ebp
  8010e0:	89 e5                	mov    %esp,%ebp
  8010e2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010f2:	eb 1f                	jmp    801113 <strncpy+0x34>
		*dst++ = *src;
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	8d 50 01             	lea    0x1(%eax),%edx
  8010fa:	89 55 08             	mov    %edx,0x8(%ebp)
  8010fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801100:	8a 12                	mov    (%edx),%dl
  801102:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801104:	8b 45 0c             	mov    0xc(%ebp),%eax
  801107:	8a 00                	mov    (%eax),%al
  801109:	84 c0                	test   %al,%al
  80110b:	74 03                	je     801110 <strncpy+0x31>
			src++;
  80110d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801110:	ff 45 fc             	incl   -0x4(%ebp)
  801113:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801116:	3b 45 10             	cmp    0x10(%ebp),%eax
  801119:	72 d9                	jb     8010f4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80111b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80111e:	c9                   	leave  
  80111f:	c3                   	ret    

00801120 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801120:	55                   	push   %ebp
  801121:	89 e5                	mov    %esp,%ebp
  801123:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80112c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801130:	74 30                	je     801162 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801132:	eb 16                	jmp    80114a <strlcpy+0x2a>
			*dst++ = *src++;
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	8d 50 01             	lea    0x1(%eax),%edx
  80113a:	89 55 08             	mov    %edx,0x8(%ebp)
  80113d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801140:	8d 4a 01             	lea    0x1(%edx),%ecx
  801143:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801146:	8a 12                	mov    (%edx),%dl
  801148:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80114a:	ff 4d 10             	decl   0x10(%ebp)
  80114d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801151:	74 09                	je     80115c <strlcpy+0x3c>
  801153:	8b 45 0c             	mov    0xc(%ebp),%eax
  801156:	8a 00                	mov    (%eax),%al
  801158:	84 c0                	test   %al,%al
  80115a:	75 d8                	jne    801134 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80115c:	8b 45 08             	mov    0x8(%ebp),%eax
  80115f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801162:	8b 55 08             	mov    0x8(%ebp),%edx
  801165:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801168:	29 c2                	sub    %eax,%edx
  80116a:	89 d0                	mov    %edx,%eax
}
  80116c:	c9                   	leave  
  80116d:	c3                   	ret    

0080116e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80116e:	55                   	push   %ebp
  80116f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801171:	eb 06                	jmp    801179 <strcmp+0xb>
		p++, q++;
  801173:	ff 45 08             	incl   0x8(%ebp)
  801176:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	84 c0                	test   %al,%al
  801180:	74 0e                	je     801190 <strcmp+0x22>
  801182:	8b 45 08             	mov    0x8(%ebp),%eax
  801185:	8a 10                	mov    (%eax),%dl
  801187:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118a:	8a 00                	mov    (%eax),%al
  80118c:	38 c2                	cmp    %al,%dl
  80118e:	74 e3                	je     801173 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801190:	8b 45 08             	mov    0x8(%ebp),%eax
  801193:	8a 00                	mov    (%eax),%al
  801195:	0f b6 d0             	movzbl %al,%edx
  801198:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119b:	8a 00                	mov    (%eax),%al
  80119d:	0f b6 c0             	movzbl %al,%eax
  8011a0:	29 c2                	sub    %eax,%edx
  8011a2:	89 d0                	mov    %edx,%eax
}
  8011a4:	5d                   	pop    %ebp
  8011a5:	c3                   	ret    

008011a6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8011a6:	55                   	push   %ebp
  8011a7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8011a9:	eb 09                	jmp    8011b4 <strncmp+0xe>
		n--, p++, q++;
  8011ab:	ff 4d 10             	decl   0x10(%ebp)
  8011ae:	ff 45 08             	incl   0x8(%ebp)
  8011b1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8011b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b8:	74 17                	je     8011d1 <strncmp+0x2b>
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	84 c0                	test   %al,%al
  8011c1:	74 0e                	je     8011d1 <strncmp+0x2b>
  8011c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c6:	8a 10                	mov    (%eax),%dl
  8011c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cb:	8a 00                	mov    (%eax),%al
  8011cd:	38 c2                	cmp    %al,%dl
  8011cf:	74 da                	je     8011ab <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d5:	75 07                	jne    8011de <strncmp+0x38>
		return 0;
  8011d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8011dc:	eb 14                	jmp    8011f2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e1:	8a 00                	mov    (%eax),%al
  8011e3:	0f b6 d0             	movzbl %al,%edx
  8011e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e9:	8a 00                	mov    (%eax),%al
  8011eb:	0f b6 c0             	movzbl %al,%eax
  8011ee:	29 c2                	sub    %eax,%edx
  8011f0:	89 d0                	mov    %edx,%eax
}
  8011f2:	5d                   	pop    %ebp
  8011f3:	c3                   	ret    

008011f4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
  8011f7:	83 ec 04             	sub    $0x4,%esp
  8011fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801200:	eb 12                	jmp    801214 <strchr+0x20>
		if (*s == c)
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80120a:	75 05                	jne    801211 <strchr+0x1d>
			return (char *) s;
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	eb 11                	jmp    801222 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801211:	ff 45 08             	incl   0x8(%ebp)
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
  801217:	8a 00                	mov    (%eax),%al
  801219:	84 c0                	test   %al,%al
  80121b:	75 e5                	jne    801202 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80121d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801222:	c9                   	leave  
  801223:	c3                   	ret    

00801224 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
  801227:	83 ec 04             	sub    $0x4,%esp
  80122a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801230:	eb 0d                	jmp    80123f <strfind+0x1b>
		if (*s == c)
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80123a:	74 0e                	je     80124a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80123c:	ff 45 08             	incl   0x8(%ebp)
  80123f:	8b 45 08             	mov    0x8(%ebp),%eax
  801242:	8a 00                	mov    (%eax),%al
  801244:	84 c0                	test   %al,%al
  801246:	75 ea                	jne    801232 <strfind+0xe>
  801248:	eb 01                	jmp    80124b <strfind+0x27>
		if (*s == c)
			break;
  80124a:	90                   	nop
	return (char *) s;
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80124e:	c9                   	leave  
  80124f:	c3                   	ret    

00801250 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801250:	55                   	push   %ebp
  801251:	89 e5                	mov    %esp,%ebp
  801253:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80125c:	8b 45 10             	mov    0x10(%ebp),%eax
  80125f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801262:	eb 0e                	jmp    801272 <memset+0x22>
		*p++ = c;
  801264:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801267:	8d 50 01             	lea    0x1(%eax),%edx
  80126a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80126d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801270:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801272:	ff 4d f8             	decl   -0x8(%ebp)
  801275:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801279:	79 e9                	jns    801264 <memset+0x14>
		*p++ = c;

	return v;
  80127b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80127e:	c9                   	leave  
  80127f:	c3                   	ret    

00801280 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801280:	55                   	push   %ebp
  801281:	89 e5                	mov    %esp,%ebp
  801283:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801286:	8b 45 0c             	mov    0xc(%ebp),%eax
  801289:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80128c:	8b 45 08             	mov    0x8(%ebp),%eax
  80128f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801292:	eb 16                	jmp    8012aa <memcpy+0x2a>
		*d++ = *s++;
  801294:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801297:	8d 50 01             	lea    0x1(%eax),%edx
  80129a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80129d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012a3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012a6:	8a 12                	mov    (%edx),%dl
  8012a8:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8012aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8012b3:	85 c0                	test   %eax,%eax
  8012b5:	75 dd                	jne    801294 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ba:	c9                   	leave  
  8012bb:	c3                   	ret    

008012bc <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
  8012bf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8012c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012d4:	73 50                	jae    801326 <memmove+0x6a>
  8012d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012dc:	01 d0                	add    %edx,%eax
  8012de:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012e1:	76 43                	jbe    801326 <memmove+0x6a>
		s += n;
  8012e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ec:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012ef:	eb 10                	jmp    801301 <memmove+0x45>
			*--d = *--s;
  8012f1:	ff 4d f8             	decl   -0x8(%ebp)
  8012f4:	ff 4d fc             	decl   -0x4(%ebp)
  8012f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012fa:	8a 10                	mov    (%eax),%dl
  8012fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ff:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801301:	8b 45 10             	mov    0x10(%ebp),%eax
  801304:	8d 50 ff             	lea    -0x1(%eax),%edx
  801307:	89 55 10             	mov    %edx,0x10(%ebp)
  80130a:	85 c0                	test   %eax,%eax
  80130c:	75 e3                	jne    8012f1 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80130e:	eb 23                	jmp    801333 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801310:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801313:	8d 50 01             	lea    0x1(%eax),%edx
  801316:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801319:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80131c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80131f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801322:	8a 12                	mov    (%edx),%dl
  801324:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801326:	8b 45 10             	mov    0x10(%ebp),%eax
  801329:	8d 50 ff             	lea    -0x1(%eax),%edx
  80132c:	89 55 10             	mov    %edx,0x10(%ebp)
  80132f:	85 c0                	test   %eax,%eax
  801331:	75 dd                	jne    801310 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801336:	c9                   	leave  
  801337:	c3                   	ret    

00801338 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801338:	55                   	push   %ebp
  801339:	89 e5                	mov    %esp,%ebp
  80133b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80133e:	8b 45 08             	mov    0x8(%ebp),%eax
  801341:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801344:	8b 45 0c             	mov    0xc(%ebp),%eax
  801347:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80134a:	eb 2a                	jmp    801376 <memcmp+0x3e>
		if (*s1 != *s2)
  80134c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80134f:	8a 10                	mov    (%eax),%dl
  801351:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801354:	8a 00                	mov    (%eax),%al
  801356:	38 c2                	cmp    %al,%dl
  801358:	74 16                	je     801370 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80135a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80135d:	8a 00                	mov    (%eax),%al
  80135f:	0f b6 d0             	movzbl %al,%edx
  801362:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801365:	8a 00                	mov    (%eax),%al
  801367:	0f b6 c0             	movzbl %al,%eax
  80136a:	29 c2                	sub    %eax,%edx
  80136c:	89 d0                	mov    %edx,%eax
  80136e:	eb 18                	jmp    801388 <memcmp+0x50>
		s1++, s2++;
  801370:	ff 45 fc             	incl   -0x4(%ebp)
  801373:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801376:	8b 45 10             	mov    0x10(%ebp),%eax
  801379:	8d 50 ff             	lea    -0x1(%eax),%edx
  80137c:	89 55 10             	mov    %edx,0x10(%ebp)
  80137f:	85 c0                	test   %eax,%eax
  801381:	75 c9                	jne    80134c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801383:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801388:	c9                   	leave  
  801389:	c3                   	ret    

0080138a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80138a:	55                   	push   %ebp
  80138b:	89 e5                	mov    %esp,%ebp
  80138d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801390:	8b 55 08             	mov    0x8(%ebp),%edx
  801393:	8b 45 10             	mov    0x10(%ebp),%eax
  801396:	01 d0                	add    %edx,%eax
  801398:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80139b:	eb 15                	jmp    8013b2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	0f b6 d0             	movzbl %al,%edx
  8013a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a8:	0f b6 c0             	movzbl %al,%eax
  8013ab:	39 c2                	cmp    %eax,%edx
  8013ad:	74 0d                	je     8013bc <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8013af:	ff 45 08             	incl   0x8(%ebp)
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8013b8:	72 e3                	jb     80139d <memfind+0x13>
  8013ba:	eb 01                	jmp    8013bd <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8013bc:	90                   	nop
	return (void *) s;
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013c0:	c9                   	leave  
  8013c1:	c3                   	ret    

008013c2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8013c2:	55                   	push   %ebp
  8013c3:	89 e5                	mov    %esp,%ebp
  8013c5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013d6:	eb 03                	jmp    8013db <strtol+0x19>
		s++;
  8013d8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	8a 00                	mov    (%eax),%al
  8013e0:	3c 20                	cmp    $0x20,%al
  8013e2:	74 f4                	je     8013d8 <strtol+0x16>
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	8a 00                	mov    (%eax),%al
  8013e9:	3c 09                	cmp    $0x9,%al
  8013eb:	74 eb                	je     8013d8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f0:	8a 00                	mov    (%eax),%al
  8013f2:	3c 2b                	cmp    $0x2b,%al
  8013f4:	75 05                	jne    8013fb <strtol+0x39>
		s++;
  8013f6:	ff 45 08             	incl   0x8(%ebp)
  8013f9:	eb 13                	jmp    80140e <strtol+0x4c>
	else if (*s == '-')
  8013fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fe:	8a 00                	mov    (%eax),%al
  801400:	3c 2d                	cmp    $0x2d,%al
  801402:	75 0a                	jne    80140e <strtol+0x4c>
		s++, neg = 1;
  801404:	ff 45 08             	incl   0x8(%ebp)
  801407:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80140e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801412:	74 06                	je     80141a <strtol+0x58>
  801414:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801418:	75 20                	jne    80143a <strtol+0x78>
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8a 00                	mov    (%eax),%al
  80141f:	3c 30                	cmp    $0x30,%al
  801421:	75 17                	jne    80143a <strtol+0x78>
  801423:	8b 45 08             	mov    0x8(%ebp),%eax
  801426:	40                   	inc    %eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	3c 78                	cmp    $0x78,%al
  80142b:	75 0d                	jne    80143a <strtol+0x78>
		s += 2, base = 16;
  80142d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801431:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801438:	eb 28                	jmp    801462 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80143a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80143e:	75 15                	jne    801455 <strtol+0x93>
  801440:	8b 45 08             	mov    0x8(%ebp),%eax
  801443:	8a 00                	mov    (%eax),%al
  801445:	3c 30                	cmp    $0x30,%al
  801447:	75 0c                	jne    801455 <strtol+0x93>
		s++, base = 8;
  801449:	ff 45 08             	incl   0x8(%ebp)
  80144c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801453:	eb 0d                	jmp    801462 <strtol+0xa0>
	else if (base == 0)
  801455:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801459:	75 07                	jne    801462 <strtol+0xa0>
		base = 10;
  80145b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	8a 00                	mov    (%eax),%al
  801467:	3c 2f                	cmp    $0x2f,%al
  801469:	7e 19                	jle    801484 <strtol+0xc2>
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	8a 00                	mov    (%eax),%al
  801470:	3c 39                	cmp    $0x39,%al
  801472:	7f 10                	jg     801484 <strtol+0xc2>
			dig = *s - '0';
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	8a 00                	mov    (%eax),%al
  801479:	0f be c0             	movsbl %al,%eax
  80147c:	83 e8 30             	sub    $0x30,%eax
  80147f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801482:	eb 42                	jmp    8014c6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801484:	8b 45 08             	mov    0x8(%ebp),%eax
  801487:	8a 00                	mov    (%eax),%al
  801489:	3c 60                	cmp    $0x60,%al
  80148b:	7e 19                	jle    8014a6 <strtol+0xe4>
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	8a 00                	mov    (%eax),%al
  801492:	3c 7a                	cmp    $0x7a,%al
  801494:	7f 10                	jg     8014a6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	8a 00                	mov    (%eax),%al
  80149b:	0f be c0             	movsbl %al,%eax
  80149e:	83 e8 57             	sub    $0x57,%eax
  8014a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8014a4:	eb 20                	jmp    8014c6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8014a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a9:	8a 00                	mov    (%eax),%al
  8014ab:	3c 40                	cmp    $0x40,%al
  8014ad:	7e 39                	jle    8014e8 <strtol+0x126>
  8014af:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b2:	8a 00                	mov    (%eax),%al
  8014b4:	3c 5a                	cmp    $0x5a,%al
  8014b6:	7f 30                	jg     8014e8 <strtol+0x126>
			dig = *s - 'A' + 10;
  8014b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bb:	8a 00                	mov    (%eax),%al
  8014bd:	0f be c0             	movsbl %al,%eax
  8014c0:	83 e8 37             	sub    $0x37,%eax
  8014c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014c9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014cc:	7d 19                	jge    8014e7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014ce:	ff 45 08             	incl   0x8(%ebp)
  8014d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d4:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014d8:	89 c2                	mov    %eax,%edx
  8014da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014dd:	01 d0                	add    %edx,%eax
  8014df:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014e2:	e9 7b ff ff ff       	jmp    801462 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014e7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014ec:	74 08                	je     8014f6 <strtol+0x134>
		*endptr = (char *) s;
  8014ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f1:	8b 55 08             	mov    0x8(%ebp),%edx
  8014f4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014fa:	74 07                	je     801503 <strtol+0x141>
  8014fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ff:	f7 d8                	neg    %eax
  801501:	eb 03                	jmp    801506 <strtol+0x144>
  801503:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801506:	c9                   	leave  
  801507:	c3                   	ret    

00801508 <ltostr>:

void
ltostr(long value, char *str)
{
  801508:	55                   	push   %ebp
  801509:	89 e5                	mov    %esp,%ebp
  80150b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80150e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801515:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80151c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801520:	79 13                	jns    801535 <ltostr+0x2d>
	{
		neg = 1;
  801522:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801529:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80152f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801532:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801535:	8b 45 08             	mov    0x8(%ebp),%eax
  801538:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80153d:	99                   	cltd   
  80153e:	f7 f9                	idiv   %ecx
  801540:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801543:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801546:	8d 50 01             	lea    0x1(%eax),%edx
  801549:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80154c:	89 c2                	mov    %eax,%edx
  80154e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801551:	01 d0                	add    %edx,%eax
  801553:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801556:	83 c2 30             	add    $0x30,%edx
  801559:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80155b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80155e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801563:	f7 e9                	imul   %ecx
  801565:	c1 fa 02             	sar    $0x2,%edx
  801568:	89 c8                	mov    %ecx,%eax
  80156a:	c1 f8 1f             	sar    $0x1f,%eax
  80156d:	29 c2                	sub    %eax,%edx
  80156f:	89 d0                	mov    %edx,%eax
  801571:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801574:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801577:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80157c:	f7 e9                	imul   %ecx
  80157e:	c1 fa 02             	sar    $0x2,%edx
  801581:	89 c8                	mov    %ecx,%eax
  801583:	c1 f8 1f             	sar    $0x1f,%eax
  801586:	29 c2                	sub    %eax,%edx
  801588:	89 d0                	mov    %edx,%eax
  80158a:	c1 e0 02             	shl    $0x2,%eax
  80158d:	01 d0                	add    %edx,%eax
  80158f:	01 c0                	add    %eax,%eax
  801591:	29 c1                	sub    %eax,%ecx
  801593:	89 ca                	mov    %ecx,%edx
  801595:	85 d2                	test   %edx,%edx
  801597:	75 9c                	jne    801535 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801599:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8015a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a3:	48                   	dec    %eax
  8015a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8015a7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015ab:	74 3d                	je     8015ea <ltostr+0xe2>
		start = 1 ;
  8015ad:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8015b4:	eb 34                	jmp    8015ea <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8015b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bc:	01 d0                	add    %edx,%eax
  8015be:	8a 00                	mov    (%eax),%al
  8015c0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c9:	01 c2                	add    %eax,%edx
  8015cb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d1:	01 c8                	add    %ecx,%eax
  8015d3:	8a 00                	mov    (%eax),%al
  8015d5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015dd:	01 c2                	add    %eax,%edx
  8015df:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015e2:	88 02                	mov    %al,(%edx)
		start++ ;
  8015e4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015e7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ed:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015f0:	7c c4                	jl     8015b6 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015f2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f8:	01 d0                	add    %edx,%eax
  8015fa:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015fd:	90                   	nop
  8015fe:	c9                   	leave  
  8015ff:	c3                   	ret    

00801600 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801600:	55                   	push   %ebp
  801601:	89 e5                	mov    %esp,%ebp
  801603:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801606:	ff 75 08             	pushl  0x8(%ebp)
  801609:	e8 54 fa ff ff       	call   801062 <strlen>
  80160e:	83 c4 04             	add    $0x4,%esp
  801611:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801614:	ff 75 0c             	pushl  0xc(%ebp)
  801617:	e8 46 fa ff ff       	call   801062 <strlen>
  80161c:	83 c4 04             	add    $0x4,%esp
  80161f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801622:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801629:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801630:	eb 17                	jmp    801649 <strcconcat+0x49>
		final[s] = str1[s] ;
  801632:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801635:	8b 45 10             	mov    0x10(%ebp),%eax
  801638:	01 c2                	add    %eax,%edx
  80163a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	01 c8                	add    %ecx,%eax
  801642:	8a 00                	mov    (%eax),%al
  801644:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801646:	ff 45 fc             	incl   -0x4(%ebp)
  801649:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80164c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80164f:	7c e1                	jl     801632 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801651:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801658:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80165f:	eb 1f                	jmp    801680 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801661:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801664:	8d 50 01             	lea    0x1(%eax),%edx
  801667:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80166a:	89 c2                	mov    %eax,%edx
  80166c:	8b 45 10             	mov    0x10(%ebp),%eax
  80166f:	01 c2                	add    %eax,%edx
  801671:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801674:	8b 45 0c             	mov    0xc(%ebp),%eax
  801677:	01 c8                	add    %ecx,%eax
  801679:	8a 00                	mov    (%eax),%al
  80167b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80167d:	ff 45 f8             	incl   -0x8(%ebp)
  801680:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801683:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801686:	7c d9                	jl     801661 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801688:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80168b:	8b 45 10             	mov    0x10(%ebp),%eax
  80168e:	01 d0                	add    %edx,%eax
  801690:	c6 00 00             	movb   $0x0,(%eax)
}
  801693:	90                   	nop
  801694:	c9                   	leave  
  801695:	c3                   	ret    

00801696 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801696:	55                   	push   %ebp
  801697:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801699:	8b 45 14             	mov    0x14(%ebp),%eax
  80169c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8016a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a5:	8b 00                	mov    (%eax),%eax
  8016a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b1:	01 d0                	add    %edx,%eax
  8016b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016b9:	eb 0c                	jmp    8016c7 <strsplit+0x31>
			*string++ = 0;
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	8d 50 01             	lea    0x1(%eax),%edx
  8016c1:	89 55 08             	mov    %edx,0x8(%ebp)
  8016c4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ca:	8a 00                	mov    (%eax),%al
  8016cc:	84 c0                	test   %al,%al
  8016ce:	74 18                	je     8016e8 <strsplit+0x52>
  8016d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d3:	8a 00                	mov    (%eax),%al
  8016d5:	0f be c0             	movsbl %al,%eax
  8016d8:	50                   	push   %eax
  8016d9:	ff 75 0c             	pushl  0xc(%ebp)
  8016dc:	e8 13 fb ff ff       	call   8011f4 <strchr>
  8016e1:	83 c4 08             	add    $0x8,%esp
  8016e4:	85 c0                	test   %eax,%eax
  8016e6:	75 d3                	jne    8016bb <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8016e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016eb:	8a 00                	mov    (%eax),%al
  8016ed:	84 c0                	test   %al,%al
  8016ef:	74 5a                	je     80174b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8016f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8016f4:	8b 00                	mov    (%eax),%eax
  8016f6:	83 f8 0f             	cmp    $0xf,%eax
  8016f9:	75 07                	jne    801702 <strsplit+0x6c>
		{
			return 0;
  8016fb:	b8 00 00 00 00       	mov    $0x0,%eax
  801700:	eb 66                	jmp    801768 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801702:	8b 45 14             	mov    0x14(%ebp),%eax
  801705:	8b 00                	mov    (%eax),%eax
  801707:	8d 48 01             	lea    0x1(%eax),%ecx
  80170a:	8b 55 14             	mov    0x14(%ebp),%edx
  80170d:	89 0a                	mov    %ecx,(%edx)
  80170f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801716:	8b 45 10             	mov    0x10(%ebp),%eax
  801719:	01 c2                	add    %eax,%edx
  80171b:	8b 45 08             	mov    0x8(%ebp),%eax
  80171e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801720:	eb 03                	jmp    801725 <strsplit+0x8f>
			string++;
  801722:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	8a 00                	mov    (%eax),%al
  80172a:	84 c0                	test   %al,%al
  80172c:	74 8b                	je     8016b9 <strsplit+0x23>
  80172e:	8b 45 08             	mov    0x8(%ebp),%eax
  801731:	8a 00                	mov    (%eax),%al
  801733:	0f be c0             	movsbl %al,%eax
  801736:	50                   	push   %eax
  801737:	ff 75 0c             	pushl  0xc(%ebp)
  80173a:	e8 b5 fa ff ff       	call   8011f4 <strchr>
  80173f:	83 c4 08             	add    $0x8,%esp
  801742:	85 c0                	test   %eax,%eax
  801744:	74 dc                	je     801722 <strsplit+0x8c>
			string++;
	}
  801746:	e9 6e ff ff ff       	jmp    8016b9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80174b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80174c:	8b 45 14             	mov    0x14(%ebp),%eax
  80174f:	8b 00                	mov    (%eax),%eax
  801751:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801758:	8b 45 10             	mov    0x10(%ebp),%eax
  80175b:	01 d0                	add    %edx,%eax
  80175d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801763:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

void* malloc(uint32 size) {
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 28             	sub    $0x28,%esp
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,


	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801770:	e8 31 08 00 00       	call   801fa6 <sys_isUHeapPlacementStrategyNEXTFIT>
  801775:	85 c0                	test   %eax,%eax
  801777:	0f 84 64 01 00 00    	je     8018e1 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  80177d:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  801783:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  80178a:	8b 55 08             	mov    0x8(%ebp),%edx
  80178d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801790:	01 d0                	add    %edx,%eax
  801792:	48                   	dec    %eax
  801793:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801796:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801799:	ba 00 00 00 00       	mov    $0x0,%edx
  80179e:	f7 75 e8             	divl   -0x18(%ebp)
  8017a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8017a4:	29 d0                	sub    %edx,%eax
  8017a6:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  8017ad:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8017b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b6:	01 d0                	add    %edx,%eax
  8017b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  8017bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  8017c2:	a1 28 30 80 00       	mov    0x803028,%eax
  8017c7:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8017ce:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8017d1:	0f 83 0a 01 00 00    	jae    8018e1 <malloc+0x177>
  8017d7:	a1 28 30 80 00       	mov    0x803028,%eax
  8017dc:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8017e3:	85 c0                	test   %eax,%eax
  8017e5:	0f 84 f6 00 00 00    	je     8018e1 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8017eb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017f2:	e9 dc 00 00 00       	jmp    8018d3 <malloc+0x169>
				flag++;
  8017f7:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  8017fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017fd:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801804:	85 c0                	test   %eax,%eax
  801806:	74 07                	je     80180f <malloc+0xa5>
					flag=0;
  801808:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  80180f:	a1 28 30 80 00       	mov    0x803028,%eax
  801814:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80181b:	85 c0                	test   %eax,%eax
  80181d:	79 05                	jns    801824 <malloc+0xba>
  80181f:	05 ff 0f 00 00       	add    $0xfff,%eax
  801824:	c1 f8 0c             	sar    $0xc,%eax
  801827:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80182a:	0f 85 a0 00 00 00    	jne    8018d0 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801830:	a1 28 30 80 00       	mov    0x803028,%eax
  801835:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80183c:	85 c0                	test   %eax,%eax
  80183e:	79 05                	jns    801845 <malloc+0xdb>
  801840:	05 ff 0f 00 00       	add    $0xfff,%eax
  801845:	c1 f8 0c             	sar    $0xc,%eax
  801848:	89 c2                	mov    %eax,%edx
  80184a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80184d:	29 d0                	sub    %edx,%eax
  80184f:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801852:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801855:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801858:	eb 11                	jmp    80186b <malloc+0x101>
						hFreeArr[j] = 1;
  80185a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80185d:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801864:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801868:	ff 45 ec             	incl   -0x14(%ebp)
  80186b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80186e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801871:	7e e7                	jle    80185a <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801873:	a1 28 30 80 00       	mov    0x803028,%eax
  801878:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80187b:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801881:	c1 e2 0c             	shl    $0xc,%edx
  801884:	89 15 04 30 80 00    	mov    %edx,0x803004
  80188a:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801890:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801897:	a1 28 30 80 00       	mov    0x803028,%eax
  80189c:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8018a3:	89 c2                	mov    %eax,%edx
  8018a5:	a1 28 30 80 00       	mov    0x803028,%eax
  8018aa:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  8018b1:	83 ec 08             	sub    $0x8,%esp
  8018b4:	52                   	push   %edx
  8018b5:	50                   	push   %eax
  8018b6:	e8 21 03 00 00       	call   801bdc <sys_allocateMem>
  8018bb:	83 c4 10             	add    $0x10,%esp

					idx++;
  8018be:	a1 28 30 80 00       	mov    0x803028,%eax
  8018c3:	40                   	inc    %eax
  8018c4:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  8018c9:	a1 04 30 80 00       	mov    0x803004,%eax
  8018ce:	eb 16                	jmp    8018e6 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8018d0:	ff 45 f0             	incl   -0x10(%ebp)
  8018d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d6:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8018db:	0f 86 16 ff ff ff    	jbe    8017f7 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  8018e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018e6:	c9                   	leave  
  8018e7:	c3                   	ret    

008018e8 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8018e8:	55                   	push   %ebp
  8018e9:	89 e5                	mov    %esp,%ebp
  8018eb:	83 ec 18             	sub    $0x18,%esp
  8018ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f1:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8018f4:	83 ec 04             	sub    $0x4,%esp
  8018f7:	68 30 29 80 00       	push   $0x802930
  8018fc:	6a 5a                	push   $0x5a
  8018fe:	68 4f 29 80 00       	push   $0x80294f
  801903:	e8 24 ee ff ff       	call   80072c <_panic>

00801908 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
  80190b:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  80190e:	83 ec 04             	sub    $0x4,%esp
  801911:	68 5b 29 80 00       	push   $0x80295b
  801916:	6a 60                	push   $0x60
  801918:	68 4f 29 80 00       	push   $0x80294f
  80191d:	e8 0a ee ff ff       	call   80072c <_panic>

00801922 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
  801925:	83 ec 18             	sub    $0x18,%esp

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  801928:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80192f:	e9 8a 00 00 00       	jmp    8019be <free+0x9c>
		if (virtual_address == (void*)uHeapArr[i].first) {
  801934:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801937:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  80193e:	3b 45 08             	cmp    0x8(%ebp),%eax
  801941:	75 78                	jne    8019bb <free+0x99>
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
  801943:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801946:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  80194d:	05 00 00 00 80       	add    $0x80000000,%eax
  801952:	c1 e8 0c             	shr    $0xc,%eax
  801955:	89 45 ec             	mov    %eax,-0x14(%ebp)
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;
  801958:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80195b:	8b 14 c5 44 30 88 00 	mov    0x883044(,%eax,8),%edx
  801962:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801965:	01 d0                	add    %edx,%eax
  801967:	85 c0                	test   %eax,%eax
  801969:	79 05                	jns    801970 <free+0x4e>
  80196b:	05 ff 0f 00 00       	add    $0xfff,%eax
  801970:	c1 f8 0c             	sar    $0xc,%eax
  801973:	89 45 e8             	mov    %eax,-0x18(%ebp)

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  801976:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801979:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80197c:	eb 19                	jmp    801997 <free+0x75>
				sys_freeMem((uint32)j, fIDX);
  80197e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801981:	83 ec 08             	sub    $0x8,%esp
  801984:	50                   	push   %eax
  801985:	ff 75 f0             	pushl  -0x10(%ebp)
  801988:	e8 33 02 00 00       	call   801bc0 <sys_freeMem>
  80198d:	83 c4 10             	add    $0x10,%esp
	for(int i=0; i<idx; i++) {
		if (virtual_address == (void*)uHeapArr[i].first) {
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  801990:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
  801997:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80199a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80199d:	72 df                	jb     80197e <free+0x5c>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
  80199f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a2:	c7 04 c5 44 30 88 00 	movl   $0x0,0x883044(,%eax,8)
  8019a9:	00 00 00 00 
  8019ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b0:	c7 04 c5 40 30 88 00 	movl   $0x0,0x883040(,%eax,8)
  8019b7:	00 00 00 00 

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  8019bb:	ff 45 f4             	incl   -0xc(%ebp)
  8019be:	a1 28 30 80 00       	mov    0x803028,%eax
  8019c3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  8019c6:	0f 8c 68 ff ff ff    	jl     801934 <free+0x12>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
		}
	}
}
  8019cc:	90                   	nop
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <sfree>:


void sfree(void* virtual_address)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
  8019d2:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8019d5:	83 ec 04             	sub    $0x4,%esp
  8019d8:	68 77 29 80 00       	push   $0x802977
  8019dd:	68 87 00 00 00       	push   $0x87
  8019e2:	68 4f 29 80 00       	push   $0x80294f
  8019e7:	e8 40 ed ff ff       	call   80072c <_panic>

008019ec <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
  8019ef:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8019f2:	83 ec 04             	sub    $0x4,%esp
  8019f5:	68 94 29 80 00       	push   $0x802994
  8019fa:	68 9f 00 00 00       	push   $0x9f
  8019ff:	68 4f 29 80 00       	push   $0x80294f
  801a04:	e8 23 ed ff ff       	call   80072c <_panic>

00801a09 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a09:	55                   	push   %ebp
  801a0a:	89 e5                	mov    %esp,%ebp
  801a0c:	57                   	push   %edi
  801a0d:	56                   	push   %esi
  801a0e:	53                   	push   %ebx
  801a0f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a12:	8b 45 08             	mov    0x8(%ebp),%eax
  801a15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a18:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a1b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a1e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a21:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a24:	cd 30                	int    $0x30
  801a26:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a29:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a2c:	83 c4 10             	add    $0x10,%esp
  801a2f:	5b                   	pop    %ebx
  801a30:	5e                   	pop    %esi
  801a31:	5f                   	pop    %edi
  801a32:	5d                   	pop    %ebp
  801a33:	c3                   	ret    

00801a34 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a34:	55                   	push   %ebp
  801a35:	89 e5                	mov    %esp,%ebp
  801a37:	83 ec 04             	sub    $0x4,%esp
  801a3a:	8b 45 10             	mov    0x10(%ebp),%eax
  801a3d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a40:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a44:	8b 45 08             	mov    0x8(%ebp),%eax
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	52                   	push   %edx
  801a4c:	ff 75 0c             	pushl  0xc(%ebp)
  801a4f:	50                   	push   %eax
  801a50:	6a 00                	push   $0x0
  801a52:	e8 b2 ff ff ff       	call   801a09 <syscall>
  801a57:	83 c4 18             	add    $0x18,%esp
}
  801a5a:	90                   	nop
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <sys_cgetc>:

int
sys_cgetc(void)
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	6a 01                	push   $0x1
  801a6c:	e8 98 ff ff ff       	call   801a09 <syscall>
  801a71:	83 c4 18             	add    $0x18,%esp
}
  801a74:	c9                   	leave  
  801a75:	c3                   	ret    

00801a76 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a76:	55                   	push   %ebp
  801a77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a79:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	50                   	push   %eax
  801a85:	6a 05                	push   $0x5
  801a87:	e8 7d ff ff ff       	call   801a09 <syscall>
  801a8c:	83 c4 18             	add    $0x18,%esp
}
  801a8f:	c9                   	leave  
  801a90:	c3                   	ret    

00801a91 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a91:	55                   	push   %ebp
  801a92:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 02                	push   $0x2
  801aa0:	e8 64 ff ff ff       	call   801a09 <syscall>
  801aa5:	83 c4 18             	add    $0x18,%esp
}
  801aa8:	c9                   	leave  
  801aa9:	c3                   	ret    

00801aaa <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801aaa:	55                   	push   %ebp
  801aab:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 03                	push   $0x3
  801ab9:	e8 4b ff ff ff       	call   801a09 <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
}
  801ac1:	c9                   	leave  
  801ac2:	c3                   	ret    

00801ac3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ac3:	55                   	push   %ebp
  801ac4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 04                	push   $0x4
  801ad2:	e8 32 ff ff ff       	call   801a09 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
}
  801ada:	c9                   	leave  
  801adb:	c3                   	ret    

00801adc <sys_env_exit>:


void sys_env_exit(void)
{
  801adc:	55                   	push   %ebp
  801add:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 06                	push   $0x6
  801aeb:	e8 19 ff ff ff       	call   801a09 <syscall>
  801af0:	83 c4 18             	add    $0x18,%esp
}
  801af3:	90                   	nop
  801af4:	c9                   	leave  
  801af5:	c3                   	ret    

00801af6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801af6:	55                   	push   %ebp
  801af7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801af9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801afc:	8b 45 08             	mov    0x8(%ebp),%eax
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	52                   	push   %edx
  801b06:	50                   	push   %eax
  801b07:	6a 07                	push   $0x7
  801b09:	e8 fb fe ff ff       	call   801a09 <syscall>
  801b0e:	83 c4 18             	add    $0x18,%esp
}
  801b11:	c9                   	leave  
  801b12:	c3                   	ret    

00801b13 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b13:	55                   	push   %ebp
  801b14:	89 e5                	mov    %esp,%ebp
  801b16:	56                   	push   %esi
  801b17:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b18:	8b 75 18             	mov    0x18(%ebp),%esi
  801b1b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b1e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b21:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b24:	8b 45 08             	mov    0x8(%ebp),%eax
  801b27:	56                   	push   %esi
  801b28:	53                   	push   %ebx
  801b29:	51                   	push   %ecx
  801b2a:	52                   	push   %edx
  801b2b:	50                   	push   %eax
  801b2c:	6a 08                	push   $0x8
  801b2e:	e8 d6 fe ff ff       	call   801a09 <syscall>
  801b33:	83 c4 18             	add    $0x18,%esp
}
  801b36:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b39:	5b                   	pop    %ebx
  801b3a:	5e                   	pop    %esi
  801b3b:	5d                   	pop    %ebp
  801b3c:	c3                   	ret    

00801b3d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b3d:	55                   	push   %ebp
  801b3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b40:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b43:	8b 45 08             	mov    0x8(%ebp),%eax
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	52                   	push   %edx
  801b4d:	50                   	push   %eax
  801b4e:	6a 09                	push   $0x9
  801b50:	e8 b4 fe ff ff       	call   801a09 <syscall>
  801b55:	83 c4 18             	add    $0x18,%esp
}
  801b58:	c9                   	leave  
  801b59:	c3                   	ret    

00801b5a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b5a:	55                   	push   %ebp
  801b5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	ff 75 0c             	pushl  0xc(%ebp)
  801b66:	ff 75 08             	pushl  0x8(%ebp)
  801b69:	6a 0a                	push   $0xa
  801b6b:	e8 99 fe ff ff       	call   801a09 <syscall>
  801b70:	83 c4 18             	add    $0x18,%esp
}
  801b73:	c9                   	leave  
  801b74:	c3                   	ret    

00801b75 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b75:	55                   	push   %ebp
  801b76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 0b                	push   $0xb
  801b84:	e8 80 fe ff ff       	call   801a09 <syscall>
  801b89:	83 c4 18             	add    $0x18,%esp
}
  801b8c:	c9                   	leave  
  801b8d:	c3                   	ret    

00801b8e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b8e:	55                   	push   %ebp
  801b8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 0c                	push   $0xc
  801b9d:	e8 67 fe ff ff       	call   801a09 <syscall>
  801ba2:	83 c4 18             	add    $0x18,%esp
}
  801ba5:	c9                   	leave  
  801ba6:	c3                   	ret    

00801ba7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ba7:	55                   	push   %ebp
  801ba8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 0d                	push   $0xd
  801bb6:	e8 4e fe ff ff       	call   801a09 <syscall>
  801bbb:	83 c4 18             	add    $0x18,%esp
}
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	ff 75 0c             	pushl  0xc(%ebp)
  801bcc:	ff 75 08             	pushl  0x8(%ebp)
  801bcf:	6a 11                	push   $0x11
  801bd1:	e8 33 fe ff ff       	call   801a09 <syscall>
  801bd6:	83 c4 18             	add    $0x18,%esp
	return;
  801bd9:	90                   	nop
}
  801bda:	c9                   	leave  
  801bdb:	c3                   	ret    

00801bdc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801bdc:	55                   	push   %ebp
  801bdd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	ff 75 0c             	pushl  0xc(%ebp)
  801be8:	ff 75 08             	pushl  0x8(%ebp)
  801beb:	6a 12                	push   $0x12
  801bed:	e8 17 fe ff ff       	call   801a09 <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf5:	90                   	nop
}
  801bf6:	c9                   	leave  
  801bf7:	c3                   	ret    

00801bf8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801bf8:	55                   	push   %ebp
  801bf9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 0e                	push   $0xe
  801c07:	e8 fd fd ff ff       	call   801a09 <syscall>
  801c0c:	83 c4 18             	add    $0x18,%esp
}
  801c0f:	c9                   	leave  
  801c10:	c3                   	ret    

00801c11 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c11:	55                   	push   %ebp
  801c12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	ff 75 08             	pushl  0x8(%ebp)
  801c1f:	6a 0f                	push   $0xf
  801c21:	e8 e3 fd ff ff       	call   801a09 <syscall>
  801c26:	83 c4 18             	add    $0x18,%esp
}
  801c29:	c9                   	leave  
  801c2a:	c3                   	ret    

00801c2b <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 10                	push   $0x10
  801c3a:	e8 ca fd ff ff       	call   801a09 <syscall>
  801c3f:	83 c4 18             	add    $0x18,%esp
}
  801c42:	90                   	nop
  801c43:	c9                   	leave  
  801c44:	c3                   	ret    

00801c45 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c45:	55                   	push   %ebp
  801c46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 14                	push   $0x14
  801c54:	e8 b0 fd ff ff       	call   801a09 <syscall>
  801c59:	83 c4 18             	add    $0x18,%esp
}
  801c5c:	90                   	nop
  801c5d:	c9                   	leave  
  801c5e:	c3                   	ret    

00801c5f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c5f:	55                   	push   %ebp
  801c60:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 15                	push   $0x15
  801c6e:	e8 96 fd ff ff       	call   801a09 <syscall>
  801c73:	83 c4 18             	add    $0x18,%esp
}
  801c76:	90                   	nop
  801c77:	c9                   	leave  
  801c78:	c3                   	ret    

00801c79 <sys_cputc>:


void
sys_cputc(const char c)
{
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
  801c7c:	83 ec 04             	sub    $0x4,%esp
  801c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c82:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c85:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	50                   	push   %eax
  801c92:	6a 16                	push   $0x16
  801c94:	e8 70 fd ff ff       	call   801a09 <syscall>
  801c99:	83 c4 18             	add    $0x18,%esp
}
  801c9c:	90                   	nop
  801c9d:	c9                   	leave  
  801c9e:	c3                   	ret    

00801c9f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c9f:	55                   	push   %ebp
  801ca0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	6a 17                	push   $0x17
  801cae:	e8 56 fd ff ff       	call   801a09 <syscall>
  801cb3:	83 c4 18             	add    $0x18,%esp
}
  801cb6:	90                   	nop
  801cb7:	c9                   	leave  
  801cb8:	c3                   	ret    

00801cb9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cb9:	55                   	push   %ebp
  801cba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 00                	push   $0x0
  801cc5:	ff 75 0c             	pushl  0xc(%ebp)
  801cc8:	50                   	push   %eax
  801cc9:	6a 18                	push   $0x18
  801ccb:	e8 39 fd ff ff       	call   801a09 <syscall>
  801cd0:	83 c4 18             	add    $0x18,%esp
}
  801cd3:	c9                   	leave  
  801cd4:	c3                   	ret    

00801cd5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801cd5:	55                   	push   %ebp
  801cd6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cd8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	52                   	push   %edx
  801ce5:	50                   	push   %eax
  801ce6:	6a 1b                	push   $0x1b
  801ce8:	e8 1c fd ff ff       	call   801a09 <syscall>
  801ced:	83 c4 18             	add    $0x18,%esp
}
  801cf0:	c9                   	leave  
  801cf1:	c3                   	ret    

00801cf2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cf2:	55                   	push   %ebp
  801cf3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cf5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	52                   	push   %edx
  801d02:	50                   	push   %eax
  801d03:	6a 19                	push   $0x19
  801d05:	e8 ff fc ff ff       	call   801a09 <syscall>
  801d0a:	83 c4 18             	add    $0x18,%esp
}
  801d0d:	90                   	nop
  801d0e:	c9                   	leave  
  801d0f:	c3                   	ret    

00801d10 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d10:	55                   	push   %ebp
  801d11:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d16:	8b 45 08             	mov    0x8(%ebp),%eax
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	52                   	push   %edx
  801d20:	50                   	push   %eax
  801d21:	6a 1a                	push   $0x1a
  801d23:	e8 e1 fc ff ff       	call   801a09 <syscall>
  801d28:	83 c4 18             	add    $0x18,%esp
}
  801d2b:	90                   	nop
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
  801d31:	83 ec 04             	sub    $0x4,%esp
  801d34:	8b 45 10             	mov    0x10(%ebp),%eax
  801d37:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d3a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d3d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d41:	8b 45 08             	mov    0x8(%ebp),%eax
  801d44:	6a 00                	push   $0x0
  801d46:	51                   	push   %ecx
  801d47:	52                   	push   %edx
  801d48:	ff 75 0c             	pushl  0xc(%ebp)
  801d4b:	50                   	push   %eax
  801d4c:	6a 1c                	push   $0x1c
  801d4e:	e8 b6 fc ff ff       	call   801a09 <syscall>
  801d53:	83 c4 18             	add    $0x18,%esp
}
  801d56:	c9                   	leave  
  801d57:	c3                   	ret    

00801d58 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d58:	55                   	push   %ebp
  801d59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d61:	6a 00                	push   $0x0
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	52                   	push   %edx
  801d68:	50                   	push   %eax
  801d69:	6a 1d                	push   $0x1d
  801d6b:	e8 99 fc ff ff       	call   801a09 <syscall>
  801d70:	83 c4 18             	add    $0x18,%esp
}
  801d73:	c9                   	leave  
  801d74:	c3                   	ret    

00801d75 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d75:	55                   	push   %ebp
  801d76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d78:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	51                   	push   %ecx
  801d86:	52                   	push   %edx
  801d87:	50                   	push   %eax
  801d88:	6a 1e                	push   $0x1e
  801d8a:	e8 7a fc ff ff       	call   801a09 <syscall>
  801d8f:	83 c4 18             	add    $0x18,%esp
}
  801d92:	c9                   	leave  
  801d93:	c3                   	ret    

00801d94 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d94:	55                   	push   %ebp
  801d95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	52                   	push   %edx
  801da4:	50                   	push   %eax
  801da5:	6a 1f                	push   $0x1f
  801da7:	e8 5d fc ff ff       	call   801a09 <syscall>
  801dac:	83 c4 18             	add    $0x18,%esp
}
  801daf:	c9                   	leave  
  801db0:	c3                   	ret    

00801db1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801db1:	55                   	push   %ebp
  801db2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801db4:	6a 00                	push   $0x0
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 20                	push   $0x20
  801dc0:	e8 44 fc ff ff       	call   801a09 <syscall>
  801dc5:	83 c4 18             	add    $0x18,%esp
}
  801dc8:	c9                   	leave  
  801dc9:	c3                   	ret    

00801dca <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801dca:	55                   	push   %ebp
  801dcb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	ff 75 10             	pushl  0x10(%ebp)
  801dd7:	ff 75 0c             	pushl  0xc(%ebp)
  801dda:	50                   	push   %eax
  801ddb:	6a 21                	push   $0x21
  801ddd:	e8 27 fc ff ff       	call   801a09 <syscall>
  801de2:	83 c4 18             	add    $0x18,%esp
}
  801de5:	c9                   	leave  
  801de6:	c3                   	ret    

00801de7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801de7:	55                   	push   %ebp
  801de8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dea:	8b 45 08             	mov    0x8(%ebp),%eax
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	50                   	push   %eax
  801df6:	6a 22                	push   $0x22
  801df8:	e8 0c fc ff ff       	call   801a09 <syscall>
  801dfd:	83 c4 18             	add    $0x18,%esp
}
  801e00:	90                   	nop
  801e01:	c9                   	leave  
  801e02:	c3                   	ret    

00801e03 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e03:	55                   	push   %ebp
  801e04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e06:	8b 45 08             	mov    0x8(%ebp),%eax
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	50                   	push   %eax
  801e12:	6a 23                	push   $0x23
  801e14:	e8 f0 fb ff ff       	call   801a09 <syscall>
  801e19:	83 c4 18             	add    $0x18,%esp
}
  801e1c:	90                   	nop
  801e1d:	c9                   	leave  
  801e1e:	c3                   	ret    

00801e1f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e1f:	55                   	push   %ebp
  801e20:	89 e5                	mov    %esp,%ebp
  801e22:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e25:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e28:	8d 50 04             	lea    0x4(%eax),%edx
  801e2b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	52                   	push   %edx
  801e35:	50                   	push   %eax
  801e36:	6a 24                	push   $0x24
  801e38:	e8 cc fb ff ff       	call   801a09 <syscall>
  801e3d:	83 c4 18             	add    $0x18,%esp
	return result;
  801e40:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e46:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e49:	89 01                	mov    %eax,(%ecx)
  801e4b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e51:	c9                   	leave  
  801e52:	c2 04 00             	ret    $0x4

00801e55 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	ff 75 10             	pushl  0x10(%ebp)
  801e5f:	ff 75 0c             	pushl  0xc(%ebp)
  801e62:	ff 75 08             	pushl  0x8(%ebp)
  801e65:	6a 13                	push   $0x13
  801e67:	e8 9d fb ff ff       	call   801a09 <syscall>
  801e6c:	83 c4 18             	add    $0x18,%esp
	return ;
  801e6f:	90                   	nop
}
  801e70:	c9                   	leave  
  801e71:	c3                   	ret    

00801e72 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e72:	55                   	push   %ebp
  801e73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 25                	push   $0x25
  801e81:	e8 83 fb ff ff       	call   801a09 <syscall>
  801e86:	83 c4 18             	add    $0x18,%esp
}
  801e89:	c9                   	leave  
  801e8a:	c3                   	ret    

00801e8b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
  801e8e:	83 ec 04             	sub    $0x4,%esp
  801e91:	8b 45 08             	mov    0x8(%ebp),%eax
  801e94:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e97:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	50                   	push   %eax
  801ea4:	6a 26                	push   $0x26
  801ea6:	e8 5e fb ff ff       	call   801a09 <syscall>
  801eab:	83 c4 18             	add    $0x18,%esp
	return ;
  801eae:	90                   	nop
}
  801eaf:	c9                   	leave  
  801eb0:	c3                   	ret    

00801eb1 <rsttst>:
void rsttst()
{
  801eb1:	55                   	push   %ebp
  801eb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 28                	push   $0x28
  801ec0:	e8 44 fb ff ff       	call   801a09 <syscall>
  801ec5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ec8:	90                   	nop
}
  801ec9:	c9                   	leave  
  801eca:	c3                   	ret    

00801ecb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ecb:	55                   	push   %ebp
  801ecc:	89 e5                	mov    %esp,%ebp
  801ece:	83 ec 04             	sub    $0x4,%esp
  801ed1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ed4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ed7:	8b 55 18             	mov    0x18(%ebp),%edx
  801eda:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ede:	52                   	push   %edx
  801edf:	50                   	push   %eax
  801ee0:	ff 75 10             	pushl  0x10(%ebp)
  801ee3:	ff 75 0c             	pushl  0xc(%ebp)
  801ee6:	ff 75 08             	pushl  0x8(%ebp)
  801ee9:	6a 27                	push   $0x27
  801eeb:	e8 19 fb ff ff       	call   801a09 <syscall>
  801ef0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef3:	90                   	nop
}
  801ef4:	c9                   	leave  
  801ef5:	c3                   	ret    

00801ef6 <chktst>:
void chktst(uint32 n)
{
  801ef6:	55                   	push   %ebp
  801ef7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	ff 75 08             	pushl  0x8(%ebp)
  801f04:	6a 29                	push   $0x29
  801f06:	e8 fe fa ff ff       	call   801a09 <syscall>
  801f0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f0e:	90                   	nop
}
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <inctst>:

void inctst()
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 2a                	push   $0x2a
  801f20:	e8 e4 fa ff ff       	call   801a09 <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
	return ;
  801f28:	90                   	nop
}
  801f29:	c9                   	leave  
  801f2a:	c3                   	ret    

00801f2b <gettst>:
uint32 gettst()
{
  801f2b:	55                   	push   %ebp
  801f2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 2b                	push   $0x2b
  801f3a:	e8 ca fa ff ff       	call   801a09 <syscall>
  801f3f:	83 c4 18             	add    $0x18,%esp
}
  801f42:	c9                   	leave  
  801f43:	c3                   	ret    

00801f44 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f44:	55                   	push   %ebp
  801f45:	89 e5                	mov    %esp,%ebp
  801f47:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 2c                	push   $0x2c
  801f56:	e8 ae fa ff ff       	call   801a09 <syscall>
  801f5b:	83 c4 18             	add    $0x18,%esp
  801f5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f61:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f65:	75 07                	jne    801f6e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f67:	b8 01 00 00 00       	mov    $0x1,%eax
  801f6c:	eb 05                	jmp    801f73 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f73:	c9                   	leave  
  801f74:	c3                   	ret    

00801f75 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f75:	55                   	push   %ebp
  801f76:	89 e5                	mov    %esp,%ebp
  801f78:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	6a 2c                	push   $0x2c
  801f87:	e8 7d fa ff ff       	call   801a09 <syscall>
  801f8c:	83 c4 18             	add    $0x18,%esp
  801f8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f92:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f96:	75 07                	jne    801f9f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f98:	b8 01 00 00 00       	mov    $0x1,%eax
  801f9d:	eb 05                	jmp    801fa4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fa4:	c9                   	leave  
  801fa5:	c3                   	ret    

00801fa6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801fa6:	55                   	push   %ebp
  801fa7:	89 e5                	mov    %esp,%ebp
  801fa9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 2c                	push   $0x2c
  801fb8:	e8 4c fa ff ff       	call   801a09 <syscall>
  801fbd:	83 c4 18             	add    $0x18,%esp
  801fc0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801fc3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801fc7:	75 07                	jne    801fd0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801fc9:	b8 01 00 00 00       	mov    $0x1,%eax
  801fce:	eb 05                	jmp    801fd5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801fd0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fd5:	c9                   	leave  
  801fd6:	c3                   	ret    

00801fd7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801fd7:	55                   	push   %ebp
  801fd8:	89 e5                	mov    %esp,%ebp
  801fda:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 2c                	push   $0x2c
  801fe9:	e8 1b fa ff ff       	call   801a09 <syscall>
  801fee:	83 c4 18             	add    $0x18,%esp
  801ff1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ff4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ff8:	75 07                	jne    802001 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ffa:	b8 01 00 00 00       	mov    $0x1,%eax
  801fff:	eb 05                	jmp    802006 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802001:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802006:	c9                   	leave  
  802007:	c3                   	ret    

00802008 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802008:	55                   	push   %ebp
  802009:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80200b:	6a 00                	push   $0x0
  80200d:	6a 00                	push   $0x0
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	ff 75 08             	pushl  0x8(%ebp)
  802016:	6a 2d                	push   $0x2d
  802018:	e8 ec f9 ff ff       	call   801a09 <syscall>
  80201d:	83 c4 18             	add    $0x18,%esp
	return ;
  802020:	90                   	nop
}
  802021:	c9                   	leave  
  802022:	c3                   	ret    
  802023:	90                   	nop

00802024 <__udivdi3>:
  802024:	55                   	push   %ebp
  802025:	57                   	push   %edi
  802026:	56                   	push   %esi
  802027:	53                   	push   %ebx
  802028:	83 ec 1c             	sub    $0x1c,%esp
  80202b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80202f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802033:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802037:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80203b:	89 ca                	mov    %ecx,%edx
  80203d:	89 f8                	mov    %edi,%eax
  80203f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802043:	85 f6                	test   %esi,%esi
  802045:	75 2d                	jne    802074 <__udivdi3+0x50>
  802047:	39 cf                	cmp    %ecx,%edi
  802049:	77 65                	ja     8020b0 <__udivdi3+0x8c>
  80204b:	89 fd                	mov    %edi,%ebp
  80204d:	85 ff                	test   %edi,%edi
  80204f:	75 0b                	jne    80205c <__udivdi3+0x38>
  802051:	b8 01 00 00 00       	mov    $0x1,%eax
  802056:	31 d2                	xor    %edx,%edx
  802058:	f7 f7                	div    %edi
  80205a:	89 c5                	mov    %eax,%ebp
  80205c:	31 d2                	xor    %edx,%edx
  80205e:	89 c8                	mov    %ecx,%eax
  802060:	f7 f5                	div    %ebp
  802062:	89 c1                	mov    %eax,%ecx
  802064:	89 d8                	mov    %ebx,%eax
  802066:	f7 f5                	div    %ebp
  802068:	89 cf                	mov    %ecx,%edi
  80206a:	89 fa                	mov    %edi,%edx
  80206c:	83 c4 1c             	add    $0x1c,%esp
  80206f:	5b                   	pop    %ebx
  802070:	5e                   	pop    %esi
  802071:	5f                   	pop    %edi
  802072:	5d                   	pop    %ebp
  802073:	c3                   	ret    
  802074:	39 ce                	cmp    %ecx,%esi
  802076:	77 28                	ja     8020a0 <__udivdi3+0x7c>
  802078:	0f bd fe             	bsr    %esi,%edi
  80207b:	83 f7 1f             	xor    $0x1f,%edi
  80207e:	75 40                	jne    8020c0 <__udivdi3+0x9c>
  802080:	39 ce                	cmp    %ecx,%esi
  802082:	72 0a                	jb     80208e <__udivdi3+0x6a>
  802084:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802088:	0f 87 9e 00 00 00    	ja     80212c <__udivdi3+0x108>
  80208e:	b8 01 00 00 00       	mov    $0x1,%eax
  802093:	89 fa                	mov    %edi,%edx
  802095:	83 c4 1c             	add    $0x1c,%esp
  802098:	5b                   	pop    %ebx
  802099:	5e                   	pop    %esi
  80209a:	5f                   	pop    %edi
  80209b:	5d                   	pop    %ebp
  80209c:	c3                   	ret    
  80209d:	8d 76 00             	lea    0x0(%esi),%esi
  8020a0:	31 ff                	xor    %edi,%edi
  8020a2:	31 c0                	xor    %eax,%eax
  8020a4:	89 fa                	mov    %edi,%edx
  8020a6:	83 c4 1c             	add    $0x1c,%esp
  8020a9:	5b                   	pop    %ebx
  8020aa:	5e                   	pop    %esi
  8020ab:	5f                   	pop    %edi
  8020ac:	5d                   	pop    %ebp
  8020ad:	c3                   	ret    
  8020ae:	66 90                	xchg   %ax,%ax
  8020b0:	89 d8                	mov    %ebx,%eax
  8020b2:	f7 f7                	div    %edi
  8020b4:	31 ff                	xor    %edi,%edi
  8020b6:	89 fa                	mov    %edi,%edx
  8020b8:	83 c4 1c             	add    $0x1c,%esp
  8020bb:	5b                   	pop    %ebx
  8020bc:	5e                   	pop    %esi
  8020bd:	5f                   	pop    %edi
  8020be:	5d                   	pop    %ebp
  8020bf:	c3                   	ret    
  8020c0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020c5:	89 eb                	mov    %ebp,%ebx
  8020c7:	29 fb                	sub    %edi,%ebx
  8020c9:	89 f9                	mov    %edi,%ecx
  8020cb:	d3 e6                	shl    %cl,%esi
  8020cd:	89 c5                	mov    %eax,%ebp
  8020cf:	88 d9                	mov    %bl,%cl
  8020d1:	d3 ed                	shr    %cl,%ebp
  8020d3:	89 e9                	mov    %ebp,%ecx
  8020d5:	09 f1                	or     %esi,%ecx
  8020d7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020db:	89 f9                	mov    %edi,%ecx
  8020dd:	d3 e0                	shl    %cl,%eax
  8020df:	89 c5                	mov    %eax,%ebp
  8020e1:	89 d6                	mov    %edx,%esi
  8020e3:	88 d9                	mov    %bl,%cl
  8020e5:	d3 ee                	shr    %cl,%esi
  8020e7:	89 f9                	mov    %edi,%ecx
  8020e9:	d3 e2                	shl    %cl,%edx
  8020eb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020ef:	88 d9                	mov    %bl,%cl
  8020f1:	d3 e8                	shr    %cl,%eax
  8020f3:	09 c2                	or     %eax,%edx
  8020f5:	89 d0                	mov    %edx,%eax
  8020f7:	89 f2                	mov    %esi,%edx
  8020f9:	f7 74 24 0c          	divl   0xc(%esp)
  8020fd:	89 d6                	mov    %edx,%esi
  8020ff:	89 c3                	mov    %eax,%ebx
  802101:	f7 e5                	mul    %ebp
  802103:	39 d6                	cmp    %edx,%esi
  802105:	72 19                	jb     802120 <__udivdi3+0xfc>
  802107:	74 0b                	je     802114 <__udivdi3+0xf0>
  802109:	89 d8                	mov    %ebx,%eax
  80210b:	31 ff                	xor    %edi,%edi
  80210d:	e9 58 ff ff ff       	jmp    80206a <__udivdi3+0x46>
  802112:	66 90                	xchg   %ax,%ax
  802114:	8b 54 24 08          	mov    0x8(%esp),%edx
  802118:	89 f9                	mov    %edi,%ecx
  80211a:	d3 e2                	shl    %cl,%edx
  80211c:	39 c2                	cmp    %eax,%edx
  80211e:	73 e9                	jae    802109 <__udivdi3+0xe5>
  802120:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802123:	31 ff                	xor    %edi,%edi
  802125:	e9 40 ff ff ff       	jmp    80206a <__udivdi3+0x46>
  80212a:	66 90                	xchg   %ax,%ax
  80212c:	31 c0                	xor    %eax,%eax
  80212e:	e9 37 ff ff ff       	jmp    80206a <__udivdi3+0x46>
  802133:	90                   	nop

00802134 <__umoddi3>:
  802134:	55                   	push   %ebp
  802135:	57                   	push   %edi
  802136:	56                   	push   %esi
  802137:	53                   	push   %ebx
  802138:	83 ec 1c             	sub    $0x1c,%esp
  80213b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80213f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802143:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802147:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80214b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80214f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802153:	89 f3                	mov    %esi,%ebx
  802155:	89 fa                	mov    %edi,%edx
  802157:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80215b:	89 34 24             	mov    %esi,(%esp)
  80215e:	85 c0                	test   %eax,%eax
  802160:	75 1a                	jne    80217c <__umoddi3+0x48>
  802162:	39 f7                	cmp    %esi,%edi
  802164:	0f 86 a2 00 00 00    	jbe    80220c <__umoddi3+0xd8>
  80216a:	89 c8                	mov    %ecx,%eax
  80216c:	89 f2                	mov    %esi,%edx
  80216e:	f7 f7                	div    %edi
  802170:	89 d0                	mov    %edx,%eax
  802172:	31 d2                	xor    %edx,%edx
  802174:	83 c4 1c             	add    $0x1c,%esp
  802177:	5b                   	pop    %ebx
  802178:	5e                   	pop    %esi
  802179:	5f                   	pop    %edi
  80217a:	5d                   	pop    %ebp
  80217b:	c3                   	ret    
  80217c:	39 f0                	cmp    %esi,%eax
  80217e:	0f 87 ac 00 00 00    	ja     802230 <__umoddi3+0xfc>
  802184:	0f bd e8             	bsr    %eax,%ebp
  802187:	83 f5 1f             	xor    $0x1f,%ebp
  80218a:	0f 84 ac 00 00 00    	je     80223c <__umoddi3+0x108>
  802190:	bf 20 00 00 00       	mov    $0x20,%edi
  802195:	29 ef                	sub    %ebp,%edi
  802197:	89 fe                	mov    %edi,%esi
  802199:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80219d:	89 e9                	mov    %ebp,%ecx
  80219f:	d3 e0                	shl    %cl,%eax
  8021a1:	89 d7                	mov    %edx,%edi
  8021a3:	89 f1                	mov    %esi,%ecx
  8021a5:	d3 ef                	shr    %cl,%edi
  8021a7:	09 c7                	or     %eax,%edi
  8021a9:	89 e9                	mov    %ebp,%ecx
  8021ab:	d3 e2                	shl    %cl,%edx
  8021ad:	89 14 24             	mov    %edx,(%esp)
  8021b0:	89 d8                	mov    %ebx,%eax
  8021b2:	d3 e0                	shl    %cl,%eax
  8021b4:	89 c2                	mov    %eax,%edx
  8021b6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021ba:	d3 e0                	shl    %cl,%eax
  8021bc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021c0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021c4:	89 f1                	mov    %esi,%ecx
  8021c6:	d3 e8                	shr    %cl,%eax
  8021c8:	09 d0                	or     %edx,%eax
  8021ca:	d3 eb                	shr    %cl,%ebx
  8021cc:	89 da                	mov    %ebx,%edx
  8021ce:	f7 f7                	div    %edi
  8021d0:	89 d3                	mov    %edx,%ebx
  8021d2:	f7 24 24             	mull   (%esp)
  8021d5:	89 c6                	mov    %eax,%esi
  8021d7:	89 d1                	mov    %edx,%ecx
  8021d9:	39 d3                	cmp    %edx,%ebx
  8021db:	0f 82 87 00 00 00    	jb     802268 <__umoddi3+0x134>
  8021e1:	0f 84 91 00 00 00    	je     802278 <__umoddi3+0x144>
  8021e7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8021eb:	29 f2                	sub    %esi,%edx
  8021ed:	19 cb                	sbb    %ecx,%ebx
  8021ef:	89 d8                	mov    %ebx,%eax
  8021f1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8021f5:	d3 e0                	shl    %cl,%eax
  8021f7:	89 e9                	mov    %ebp,%ecx
  8021f9:	d3 ea                	shr    %cl,%edx
  8021fb:	09 d0                	or     %edx,%eax
  8021fd:	89 e9                	mov    %ebp,%ecx
  8021ff:	d3 eb                	shr    %cl,%ebx
  802201:	89 da                	mov    %ebx,%edx
  802203:	83 c4 1c             	add    $0x1c,%esp
  802206:	5b                   	pop    %ebx
  802207:	5e                   	pop    %esi
  802208:	5f                   	pop    %edi
  802209:	5d                   	pop    %ebp
  80220a:	c3                   	ret    
  80220b:	90                   	nop
  80220c:	89 fd                	mov    %edi,%ebp
  80220e:	85 ff                	test   %edi,%edi
  802210:	75 0b                	jne    80221d <__umoddi3+0xe9>
  802212:	b8 01 00 00 00       	mov    $0x1,%eax
  802217:	31 d2                	xor    %edx,%edx
  802219:	f7 f7                	div    %edi
  80221b:	89 c5                	mov    %eax,%ebp
  80221d:	89 f0                	mov    %esi,%eax
  80221f:	31 d2                	xor    %edx,%edx
  802221:	f7 f5                	div    %ebp
  802223:	89 c8                	mov    %ecx,%eax
  802225:	f7 f5                	div    %ebp
  802227:	89 d0                	mov    %edx,%eax
  802229:	e9 44 ff ff ff       	jmp    802172 <__umoddi3+0x3e>
  80222e:	66 90                	xchg   %ax,%ax
  802230:	89 c8                	mov    %ecx,%eax
  802232:	89 f2                	mov    %esi,%edx
  802234:	83 c4 1c             	add    $0x1c,%esp
  802237:	5b                   	pop    %ebx
  802238:	5e                   	pop    %esi
  802239:	5f                   	pop    %edi
  80223a:	5d                   	pop    %ebp
  80223b:	c3                   	ret    
  80223c:	3b 04 24             	cmp    (%esp),%eax
  80223f:	72 06                	jb     802247 <__umoddi3+0x113>
  802241:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802245:	77 0f                	ja     802256 <__umoddi3+0x122>
  802247:	89 f2                	mov    %esi,%edx
  802249:	29 f9                	sub    %edi,%ecx
  80224b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80224f:	89 14 24             	mov    %edx,(%esp)
  802252:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802256:	8b 44 24 04          	mov    0x4(%esp),%eax
  80225a:	8b 14 24             	mov    (%esp),%edx
  80225d:	83 c4 1c             	add    $0x1c,%esp
  802260:	5b                   	pop    %ebx
  802261:	5e                   	pop    %esi
  802262:	5f                   	pop    %edi
  802263:	5d                   	pop    %ebp
  802264:	c3                   	ret    
  802265:	8d 76 00             	lea    0x0(%esi),%esi
  802268:	2b 04 24             	sub    (%esp),%eax
  80226b:	19 fa                	sbb    %edi,%edx
  80226d:	89 d1                	mov    %edx,%ecx
  80226f:	89 c6                	mov    %eax,%esi
  802271:	e9 71 ff ff ff       	jmp    8021e7 <__umoddi3+0xb3>
  802276:	66 90                	xchg   %ax,%ax
  802278:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80227c:	72 ea                	jb     802268 <__umoddi3+0x134>
  80227e:	89 d9                	mov    %ebx,%ecx
  802280:	e9 62 ff ff ff       	jmp    8021e7 <__umoddi3+0xb3>
