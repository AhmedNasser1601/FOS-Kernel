
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
  800044:	e8 17 1b 00 00       	call   801b60 <sys_getparentenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	// Get the shared variables from the main program ***********************************

	char _customers[] = "customers";
  80004c:	8d 45 ae             	lea    -0x52(%ebp),%eax
  80004f:	bb 75 23 80 00       	mov    $0x802375,%ebx
  800054:	ba 0a 00 00 00       	mov    $0xa,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custCounter[] = "custCounter";
  800061:	8d 45 a2             	lea    -0x5e(%ebp),%eax
  800064:	bb 7f 23 80 00       	mov    $0x80237f,%ebx
  800069:	ba 03 00 00 00       	mov    $0x3,%edx
  80006e:	89 c7                	mov    %eax,%edi
  800070:	89 de                	mov    %ebx,%esi
  800072:	89 d1                	mov    %edx,%ecx
  800074:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1Counter[] = "flight1Counter";
  800076:	8d 45 93             	lea    -0x6d(%ebp),%eax
  800079:	bb 8b 23 80 00       	mov    $0x80238b,%ebx
  80007e:	ba 0f 00 00 00       	mov    $0xf,%edx
  800083:	89 c7                	mov    %eax,%edi
  800085:	89 de                	mov    %ebx,%esi
  800087:	89 d1                	mov    %edx,%ecx
  800089:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2Counter[] = "flight2Counter";
  80008b:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80008e:	bb 9a 23 80 00       	mov    $0x80239a,%ebx
  800093:	ba 0f 00 00 00       	mov    $0xf,%edx
  800098:	89 c7                	mov    %eax,%edi
  80009a:	89 de                	mov    %ebx,%esi
  80009c:	89 d1                	mov    %edx,%ecx
  80009e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Counter[] = "flightBooked1Counter";
  8000a0:	8d 85 6f ff ff ff    	lea    -0x91(%ebp),%eax
  8000a6:	bb a9 23 80 00       	mov    $0x8023a9,%ebx
  8000ab:	ba 15 00 00 00       	mov    $0x15,%edx
  8000b0:	89 c7                	mov    %eax,%edi
  8000b2:	89 de                	mov    %ebx,%esi
  8000b4:	89 d1                	mov    %edx,%ecx
  8000b6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Counter[] = "flightBooked2Counter";
  8000b8:	8d 85 5a ff ff ff    	lea    -0xa6(%ebp),%eax
  8000be:	bb be 23 80 00       	mov    $0x8023be,%ebx
  8000c3:	ba 15 00 00 00       	mov    $0x15,%edx
  8000c8:	89 c7                	mov    %eax,%edi
  8000ca:	89 de                	mov    %ebx,%esi
  8000cc:	89 d1                	mov    %edx,%ecx
  8000ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Arr[] = "flightBooked1Arr";
  8000d0:	8d 85 49 ff ff ff    	lea    -0xb7(%ebp),%eax
  8000d6:	bb d3 23 80 00       	mov    $0x8023d3,%ebx
  8000db:	ba 11 00 00 00       	mov    $0x11,%edx
  8000e0:	89 c7                	mov    %eax,%edi
  8000e2:	89 de                	mov    %ebx,%esi
  8000e4:	89 d1                	mov    %edx,%ecx
  8000e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Arr[] = "flightBooked2Arr";
  8000e8:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  8000ee:	bb e4 23 80 00       	mov    $0x8023e4,%ebx
  8000f3:	ba 11 00 00 00       	mov    $0x11,%edx
  8000f8:	89 c7                	mov    %eax,%edi
  8000fa:	89 de                	mov    %ebx,%esi
  8000fc:	89 d1                	mov    %edx,%ecx
  8000fe:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _cust_ready_queue[] = "cust_ready_queue";
  800100:	8d 85 27 ff ff ff    	lea    -0xd9(%ebp),%eax
  800106:	bb f5 23 80 00       	mov    $0x8023f5,%ebx
  80010b:	ba 11 00 00 00       	mov    $0x11,%edx
  800110:	89 c7                	mov    %eax,%edi
  800112:	89 de                	mov    %ebx,%esi
  800114:	89 d1                	mov    %edx,%ecx
  800116:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_in[] = "queue_in";
  800118:	8d 85 1e ff ff ff    	lea    -0xe2(%ebp),%eax
  80011e:	bb 06 24 80 00       	mov    $0x802406,%ebx
  800123:	ba 09 00 00 00       	mov    $0x9,%edx
  800128:	89 c7                	mov    %eax,%edi
  80012a:	89 de                	mov    %ebx,%esi
  80012c:	89 d1                	mov    %edx,%ecx
  80012e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_out[] = "queue_out";
  800130:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
  800136:	bb 0f 24 80 00       	mov    $0x80240f,%ebx
  80013b:	ba 0a 00 00 00       	mov    $0xa,%edx
  800140:	89 c7                	mov    %eax,%edi
  800142:	89 de                	mov    %ebx,%esi
  800144:	89 d1                	mov    %edx,%ecx
  800146:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _cust_ready[] = "cust_ready";
  800148:	8d 85 09 ff ff ff    	lea    -0xf7(%ebp),%eax
  80014e:	bb 19 24 80 00       	mov    $0x802419,%ebx
  800153:	ba 0b 00 00 00       	mov    $0xb,%edx
  800158:	89 c7                	mov    %eax,%edi
  80015a:	89 de                	mov    %ebx,%esi
  80015c:	89 d1                	mov    %edx,%ecx
  80015e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custQueueCS[] = "custQueueCS";
  800160:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800166:	bb 24 24 80 00       	mov    $0x802424,%ebx
  80016b:	ba 03 00 00 00       	mov    $0x3,%edx
  800170:	89 c7                	mov    %eax,%edi
  800172:	89 de                	mov    %ebx,%esi
  800174:	89 d1                	mov    %edx,%ecx
  800176:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1CS[] = "flight1CS";
  800178:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  80017e:	bb 30 24 80 00       	mov    $0x802430,%ebx
  800183:	ba 0a 00 00 00       	mov    $0xa,%edx
  800188:	89 c7                	mov    %eax,%edi
  80018a:	89 de                	mov    %ebx,%esi
  80018c:	89 d1                	mov    %edx,%ecx
  80018e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2CS[] = "flight2CS";
  800190:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800196:	bb 3a 24 80 00       	mov    $0x80243a,%ebx
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
  8001c1:	bb 44 24 80 00       	mov    $0x802444,%ebx
  8001c6:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001cb:	89 c7                	mov    %eax,%edi
  8001cd:	89 de                	mov    %ebx,%esi
  8001cf:	89 d1                	mov    %edx,%ecx
  8001d1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custTerminated[] = "custTerminated";
  8001d3:	8d 85 c6 fe ff ff    	lea    -0x13a(%ebp),%eax
  8001d9:	bb 52 24 80 00       	mov    $0x802452,%ebx
  8001de:	ba 0f 00 00 00       	mov    $0xf,%edx
  8001e3:	89 c7                	mov    %eax,%edi
  8001e5:	89 de                	mov    %ebx,%esi
  8001e7:	89 d1                	mov    %edx,%ecx
  8001e9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _taircl[] = "taircl";
  8001eb:	8d 85 bf fe ff ff    	lea    -0x141(%ebp),%eax
  8001f1:	bb 61 24 80 00       	mov    $0x802461,%ebx
  8001f6:	ba 07 00 00 00       	mov    $0x7,%edx
  8001fb:	89 c7                	mov    %eax,%edi
  8001fd:	89 de                	mov    %ebx,%esi
  8001ff:	89 d1                	mov    %edx,%ecx
  800201:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _taircu[] = "taircu";
  800203:	8d 85 b8 fe ff ff    	lea    -0x148(%ebp),%eax
  800209:	bb 68 24 80 00       	mov    $0x802468,%ebx
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
  800225:	e8 96 17 00 00       	call   8019c0 <sget>
  80022a:	83 c4 10             	add    $0x10,%esp
  80022d:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int* flight1Counter = sget(parentenvID, _flight1Counter);
  800230:	83 ec 08             	sub    $0x8,%esp
  800233:	8d 45 93             	lea    -0x6d(%ebp),%eax
  800236:	50                   	push   %eax
  800237:	ff 75 e4             	pushl  -0x1c(%ebp)
  80023a:	e8 81 17 00 00       	call   8019c0 <sget>
  80023f:	83 c4 10             	add    $0x10,%esp
  800242:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int* flight2Counter = sget(parentenvID, _flight2Counter);
  800245:	83 ec 08             	sub    $0x8,%esp
  800248:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80024b:	50                   	push   %eax
  80024c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80024f:	e8 6c 17 00 00       	call   8019c0 <sget>
  800254:	83 c4 10             	add    $0x10,%esp
  800257:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* flight1BookedCounter = sget(parentenvID, _flightBooked1Counter);
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	8d 85 6f ff ff ff    	lea    -0x91(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	ff 75 e4             	pushl  -0x1c(%ebp)
  800267:	e8 54 17 00 00       	call   8019c0 <sget>
  80026c:	83 c4 10             	add    $0x10,%esp
  80026f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	int* flight2BookedCounter = sget(parentenvID, _flightBooked2Counter);
  800272:	83 ec 08             	sub    $0x8,%esp
  800275:	8d 85 5a ff ff ff    	lea    -0xa6(%ebp),%eax
  80027b:	50                   	push   %eax
  80027c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80027f:	e8 3c 17 00 00       	call   8019c0 <sget>
  800284:	83 c4 10             	add    $0x10,%esp
  800287:	89 45 d0             	mov    %eax,-0x30(%ebp)

	int* flight1BookedArr = sget(parentenvID, _flightBooked1Arr);
  80028a:	83 ec 08             	sub    $0x8,%esp
  80028d:	8d 85 49 ff ff ff    	lea    -0xb7(%ebp),%eax
  800293:	50                   	push   %eax
  800294:	ff 75 e4             	pushl  -0x1c(%ebp)
  800297:	e8 24 17 00 00       	call   8019c0 <sget>
  80029c:	83 c4 10             	add    $0x10,%esp
  80029f:	89 45 cc             	mov    %eax,-0x34(%ebp)
	int* flight2BookedArr = sget(parentenvID, _flightBooked2Arr);
  8002a2:	83 ec 08             	sub    $0x8,%esp
  8002a5:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  8002ab:	50                   	push   %eax
  8002ac:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002af:	e8 0c 17 00 00       	call   8019c0 <sget>
  8002b4:	83 c4 10             	add    $0x10,%esp
  8002b7:	89 45 c8             	mov    %eax,-0x38(%ebp)

	int* cust_ready_queue = sget(parentenvID, _cust_ready_queue);
  8002ba:	83 ec 08             	sub    $0x8,%esp
  8002bd:	8d 85 27 ff ff ff    	lea    -0xd9(%ebp),%eax
  8002c3:	50                   	push   %eax
  8002c4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002c7:	e8 f4 16 00 00       	call   8019c0 <sget>
  8002cc:	83 c4 10             	add    $0x10,%esp
  8002cf:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	int* queue_out = sget(parentenvID, _queue_out);
  8002d2:	83 ec 08             	sub    $0x8,%esp
  8002d5:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
  8002db:	50                   	push   %eax
  8002dc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002df:	e8 dc 16 00 00       	call   8019c0 <sget>
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
  8002f7:	e8 93 1a 00 00       	call   801d8f <sys_waitSemaphore>
  8002fc:	83 c4 10             	add    $0x10,%esp

		//dequeue the customer info
		sys_waitSemaphore(parentenvID, _custQueueCS);
  8002ff:	83 ec 08             	sub    $0x8,%esp
  800302:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800308:	50                   	push   %eax
  800309:	ff 75 e4             	pushl  -0x1c(%ebp)
  80030c:	e8 7e 1a 00 00       	call   801d8f <sys_waitSemaphore>
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
  800344:	e8 64 1a 00 00       	call   801dad <sys_signalSemaphore>
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
  80038b:	e8 ff 19 00 00       	call   801d8f <sys_waitSemaphore>
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
  8003ef:	e8 b9 19 00 00       	call   801dad <sys_signalSemaphore>
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
  800409:	e8 81 19 00 00       	call   801d8f <sys_waitSemaphore>
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
  80046d:	e8 3b 19 00 00       	call   801dad <sys_signalSemaphore>
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
  800487:	e8 03 19 00 00       	call   801d8f <sys_waitSemaphore>
  80048c:	83 c4 10             	add    $0x10,%esp
  80048f:	83 ec 08             	sub    $0x8,%esp
  800492:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800498:	50                   	push   %eax
  800499:	ff 75 e4             	pushl  -0x1c(%ebp)
  80049c:	e8 ee 18 00 00       	call   801d8f <sys_waitSemaphore>
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
  800557:	e8 51 18 00 00       	call   801dad <sys_signalSemaphore>
  80055c:	83 c4 10             	add    $0x10,%esp
  80055f:	83 ec 08             	sub    $0x8,%esp
  800562:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800568:	50                   	push   %eax
  800569:	ff 75 e4             	pushl  -0x1c(%ebp)
  80056c:	e8 3c 18 00 00       	call   801dad <sys_signalSemaphore>
  800571:	83 c4 10             	add    $0x10,%esp
		}
		break;
  800574:	eb 17                	jmp    80058d <_main+0x555>
		default:
			panic("customer must have flight type\n");
  800576:	83 ec 04             	sub    $0x4,%esp
  800579:	68 40 23 80 00       	push   $0x802340
  80057e:	68 8f 00 00 00       	push   $0x8f
  800583:	68 60 23 80 00       	push   $0x802360
  800588:	e8 9f 01 00 00       	call   80072c <_panic>
		}

		//signal finished
		char prefix[30]="cust_finished";
  80058d:	8d 85 9a fe ff ff    	lea    -0x166(%ebp),%eax
  800593:	bb 6f 24 80 00       	mov    $0x80246f,%ebx
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
  8005fb:	e8 ad 17 00 00       	call   801dad <sys_signalSemaphore>
  800600:	83 c4 10             	add    $0x10,%esp

		//signal the clerk
		sys_signalSemaphore(parentenvID, _clerk);
  800603:	83 ec 08             	sub    $0x8,%esp
  800606:	8d 85 e3 fe ff ff    	lea    -0x11d(%ebp),%eax
  80060c:	50                   	push   %eax
  80060d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800610:	e8 98 17 00 00       	call   801dad <sys_signalSemaphore>
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
  800623:	e8 1f 15 00 00       	call   801b47 <sys_getenvindex>
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
  800692:	e8 4b 16 00 00       	call   801ce2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800697:	83 ec 0c             	sub    $0xc,%esp
  80069a:	68 a8 24 80 00       	push   $0x8024a8
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
  8006c2:	68 d0 24 80 00       	push   $0x8024d0
  8006c7:	e8 14 03 00 00       	call   8009e0 <cprintf>
  8006cc:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8006d4:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8006da:	83 ec 08             	sub    $0x8,%esp
  8006dd:	50                   	push   %eax
  8006de:	68 f5 24 80 00       	push   $0x8024f5
  8006e3:	e8 f8 02 00 00       	call   8009e0 <cprintf>
  8006e8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006eb:	83 ec 0c             	sub    $0xc,%esp
  8006ee:	68 a8 24 80 00       	push   $0x8024a8
  8006f3:	e8 e8 02 00 00       	call   8009e0 <cprintf>
  8006f8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006fb:	e8 fc 15 00 00       	call   801cfc <sys_enable_interrupt>

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
  800713:	e8 fb 13 00 00       	call   801b13 <sys_env_destroy>
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
  800724:	e8 50 14 00 00       	call   801b79 <sys_env_exit>
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
  80073b:	a1 48 30 88 00       	mov    0x883048,%eax
  800740:	85 c0                	test   %eax,%eax
  800742:	74 16                	je     80075a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800744:	a1 48 30 88 00       	mov    0x883048,%eax
  800749:	83 ec 08             	sub    $0x8,%esp
  80074c:	50                   	push   %eax
  80074d:	68 0c 25 80 00       	push   $0x80250c
  800752:	e8 89 02 00 00       	call   8009e0 <cprintf>
  800757:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80075a:	a1 00 30 80 00       	mov    0x803000,%eax
  80075f:	ff 75 0c             	pushl  0xc(%ebp)
  800762:	ff 75 08             	pushl  0x8(%ebp)
  800765:	50                   	push   %eax
  800766:	68 11 25 80 00       	push   $0x802511
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
  80078a:	68 2d 25 80 00       	push   $0x80252d
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
  8007b6:	68 30 25 80 00       	push   $0x802530
  8007bb:	6a 26                	push   $0x26
  8007bd:	68 7c 25 80 00       	push   $0x80257c
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
  800888:	68 88 25 80 00       	push   $0x802588
  80088d:	6a 3a                	push   $0x3a
  80088f:	68 7c 25 80 00       	push   $0x80257c
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
  8008f8:	68 dc 25 80 00       	push   $0x8025dc
  8008fd:	6a 44                	push   $0x44
  8008ff:	68 7c 25 80 00       	push   $0x80257c
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
  800952:	e8 7a 11 00 00       	call   801ad1 <sys_cputs>
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
  8009c9:	e8 03 11 00 00       	call   801ad1 <sys_cputs>
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
  800a13:	e8 ca 12 00 00       	call   801ce2 <sys_disable_interrupt>
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
  800a33:	e8 c4 12 00 00       	call   801cfc <sys_enable_interrupt>
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
  800a7d:	e8 3e 16 00 00       	call   8020c0 <__udivdi3>
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
  800acd:	e8 fe 16 00 00       	call   8021d0 <__umoddi3>
  800ad2:	83 c4 10             	add    $0x10,%esp
  800ad5:	05 54 28 80 00       	add    $0x802854,%eax
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
  800c28:	8b 04 85 78 28 80 00 	mov    0x802878(,%eax,4),%eax
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
  800d09:	8b 34 9d c0 26 80 00 	mov    0x8026c0(,%ebx,4),%esi
  800d10:	85 f6                	test   %esi,%esi
  800d12:	75 19                	jne    800d2d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d14:	53                   	push   %ebx
  800d15:	68 65 28 80 00       	push   $0x802865
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
  800d2e:	68 6e 28 80 00       	push   $0x80286e
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
  800d5b:	be 71 28 80 00       	mov    $0x802871,%esi
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

0080176a <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  801770:	a1 04 30 80 00       	mov    0x803004,%eax
  801775:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801778:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  80177f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801786:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  80178d:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  801794:	e9 f9 00 00 00       	jmp    801892 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  801799:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80179c:	05 00 00 00 80       	add    $0x80000000,%eax
  8017a1:	c1 e8 0c             	shr    $0xc,%eax
  8017a4:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8017ab:	85 c0                	test   %eax,%eax
  8017ad:	75 1c                	jne    8017cb <nextFitAlgo+0x61>
  8017af:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8017b3:	74 16                	je     8017cb <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  8017b5:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  8017bc:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  8017c3:	ff 4d e0             	decl   -0x20(%ebp)
  8017c6:	e9 90 00 00 00       	jmp    80185b <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  8017cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ce:	05 00 00 00 80       	add    $0x80000000,%eax
  8017d3:	c1 e8 0c             	shr    $0xc,%eax
  8017d6:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8017dd:	85 c0                	test   %eax,%eax
  8017df:	75 26                	jne    801807 <nextFitAlgo+0x9d>
  8017e1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8017e5:	75 20                	jne    801807 <nextFitAlgo+0x9d>
			flag = 1;
  8017e7:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  8017ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  8017f4:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  8017fb:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801802:	ff 4d e0             	decl   -0x20(%ebp)
  801805:	eb 54                	jmp    80185b <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  801807:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80180a:	3b 45 08             	cmp    0x8(%ebp),%eax
  80180d:	72 11                	jb     801820 <nextFitAlgo+0xb6>
				startAdd = tmp;
  80180f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801812:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  801817:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  80181e:	eb 7c                	jmp    80189c <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  801820:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801823:	05 00 00 00 80       	add    $0x80000000,%eax
  801828:	c1 e8 0c             	shr    $0xc,%eax
  80182b:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801832:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  801835:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801838:	05 00 00 00 80       	add    $0x80000000,%eax
  80183d:	c1 e8 0c             	shr    $0xc,%eax
  801840:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801847:	c1 e0 0c             	shl    $0xc,%eax
  80184a:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  80184d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801854:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  80185b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80185e:	3b 45 08             	cmp    0x8(%ebp),%eax
  801861:	72 11                	jb     801874 <nextFitAlgo+0x10a>
			startAdd = tmp;
  801863:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801866:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  80186b:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  801872:	eb 28                	jmp    80189c <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  801874:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  80187b:	76 15                	jbe    801892 <nextFitAlgo+0x128>
			flag = newSize = 0;
  80187d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801884:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  80188b:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  801892:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801896:	0f 85 fd fe ff ff    	jne    801799 <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  80189c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8018a0:	75 1a                	jne    8018bc <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  8018a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018a5:	3b 45 08             	cmp    0x8(%ebp),%eax
  8018a8:	73 0a                	jae    8018b4 <nextFitAlgo+0x14a>
  8018aa:	b8 00 00 00 00       	mov    $0x0,%eax
  8018af:	e9 99 00 00 00       	jmp    80194d <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  8018b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8018b7:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  8018bc:	a1 04 30 80 00       	mov    0x803004,%eax
  8018c1:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  8018c4:	a1 04 30 80 00       	mov    0x803004,%eax
  8018c9:	05 00 00 00 80       	add    $0x80000000,%eax
  8018ce:	c1 e8 0c             	shr    $0xc,%eax
  8018d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  8018d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d7:	c1 e8 0c             	shr    $0xc,%eax
  8018da:	89 c2                	mov    %eax,%edx
  8018dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018df:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  8018e6:	a1 04 30 80 00       	mov    0x803004,%eax
  8018eb:	83 ec 08             	sub    $0x8,%esp
  8018ee:	ff 75 08             	pushl  0x8(%ebp)
  8018f1:	50                   	push   %eax
  8018f2:	e8 82 03 00 00       	call   801c79 <sys_allocateMem>
  8018f7:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  8018fa:	a1 04 30 80 00       	mov    0x803004,%eax
  8018ff:	05 00 00 00 80       	add    $0x80000000,%eax
  801904:	c1 e8 0c             	shr    $0xc,%eax
  801907:	89 c2                	mov    %eax,%edx
  801909:	a1 04 30 80 00       	mov    0x803004,%eax
  80190e:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  801915:	a1 04 30 80 00       	mov    0x803004,%eax
  80191a:	05 00 00 00 80       	add    $0x80000000,%eax
  80191f:	c1 e8 0c             	shr    $0xc,%eax
  801922:	89 c2                	mov    %eax,%edx
  801924:	8b 45 08             	mov    0x8(%ebp),%eax
  801927:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  80192e:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801934:	8b 45 08             	mov    0x8(%ebp),%eax
  801937:	01 d0                	add    %edx,%eax
  801939:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  80193e:	76 0a                	jbe    80194a <nextFitAlgo+0x1e0>
  801940:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  801947:	00 00 80 

	return (void*)returnHolder;
  80194a:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  80194d:	c9                   	leave  
  80194e:	c3                   	ret    

0080194f <malloc>:

void* malloc(uint32 size) {
  80194f:	55                   	push   %ebp
  801950:	89 e5                	mov    %esp,%ebp
  801952:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  801955:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  80195c:	8b 55 08             	mov    0x8(%ebp),%edx
  80195f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801962:	01 d0                	add    %edx,%eax
  801964:	48                   	dec    %eax
  801965:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801968:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80196b:	ba 00 00 00 00       	mov    $0x0,%edx
  801970:	f7 75 f4             	divl   -0xc(%ebp)
  801973:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801976:	29 d0                	sub    %edx,%eax
  801978:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  80197b:	e8 c3 06 00 00       	call   802043 <sys_isUHeapPlacementStrategyNEXTFIT>
  801980:	85 c0                	test   %eax,%eax
  801982:	74 10                	je     801994 <malloc+0x45>
		return nextFitAlgo(size);
  801984:	83 ec 0c             	sub    $0xc,%esp
  801987:	ff 75 08             	pushl  0x8(%ebp)
  80198a:	e8 db fd ff ff       	call   80176a <nextFitAlgo>
  80198f:	83 c4 10             	add    $0x10,%esp
  801992:	eb 0a                	jmp    80199e <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  801994:	e8 79 06 00 00       	call   802012 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  801999:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80199e:	c9                   	leave  
  80199f:	c3                   	ret    

008019a0 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
  8019a3:	83 ec 18             	sub    $0x18,%esp
  8019a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a9:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8019ac:	83 ec 04             	sub    $0x4,%esp
  8019af:	68 d0 29 80 00       	push   $0x8029d0
  8019b4:	6a 7e                	push   $0x7e
  8019b6:	68 ef 29 80 00       	push   $0x8029ef
  8019bb:	e8 6c ed ff ff       	call   80072c <_panic>

008019c0 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8019c0:	55                   	push   %ebp
  8019c1:	89 e5                	mov    %esp,%ebp
  8019c3:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8019c6:	83 ec 04             	sub    $0x4,%esp
  8019c9:	68 fb 29 80 00       	push   $0x8029fb
  8019ce:	68 84 00 00 00       	push   $0x84
  8019d3:	68 ef 29 80 00       	push   $0x8029ef
  8019d8:	e8 4f ed ff ff       	call   80072c <_panic>

008019dd <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8019dd:	55                   	push   %ebp
  8019de:	89 e5                	mov    %esp,%ebp
  8019e0:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8019e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019ea:	eb 61                	jmp    801a4d <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  8019ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019ef:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	39 c2                	cmp    %eax,%edx
  8019fb:	75 4d                	jne    801a4a <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  8019fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801a00:	05 00 00 00 80       	add    $0x80000000,%eax
  801a05:	c1 e8 0c             	shr    $0xc,%eax
  801a08:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a0e:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  801a15:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  801a18:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a1b:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  801a22:	00 00 00 00 
  801a26:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a29:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  801a30:	00 00 00 00 
  801a34:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a37:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  801a3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a41:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  801a48:	eb 0d                	jmp    801a57 <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801a4a:	ff 45 f0             	incl   -0x10(%ebp)
  801a4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a50:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a55:	76 95                	jbe    8019ec <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  801a57:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5a:	83 ec 08             	sub    $0x8,%esp
  801a5d:	ff 75 f4             	pushl  -0xc(%ebp)
  801a60:	50                   	push   %eax
  801a61:	e8 f7 01 00 00       	call   801c5d <sys_freeMem>
  801a66:	83 c4 10             	add    $0x10,%esp
}
  801a69:	90                   	nop
  801a6a:	c9                   	leave  
  801a6b:	c3                   	ret    

00801a6c <sfree>:


void sfree(void* virtual_address)
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
  801a6f:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801a72:	83 ec 04             	sub    $0x4,%esp
  801a75:	68 17 2a 80 00       	push   $0x802a17
  801a7a:	68 ac 00 00 00       	push   $0xac
  801a7f:	68 ef 29 80 00       	push   $0x8029ef
  801a84:	e8 a3 ec ff ff       	call   80072c <_panic>

00801a89 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
  801a8c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801a8f:	83 ec 04             	sub    $0x4,%esp
  801a92:	68 34 2a 80 00       	push   $0x802a34
  801a97:	68 c4 00 00 00       	push   $0xc4
  801a9c:	68 ef 29 80 00       	push   $0x8029ef
  801aa1:	e8 86 ec ff ff       	call   80072c <_panic>

00801aa6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801aa6:	55                   	push   %ebp
  801aa7:	89 e5                	mov    %esp,%ebp
  801aa9:	57                   	push   %edi
  801aaa:	56                   	push   %esi
  801aab:	53                   	push   %ebx
  801aac:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ab8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801abb:	8b 7d 18             	mov    0x18(%ebp),%edi
  801abe:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ac1:	cd 30                	int    $0x30
  801ac3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ac6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ac9:	83 c4 10             	add    $0x10,%esp
  801acc:	5b                   	pop    %ebx
  801acd:	5e                   	pop    %esi
  801ace:	5f                   	pop    %edi
  801acf:	5d                   	pop    %ebp
  801ad0:	c3                   	ret    

00801ad1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801ad1:	55                   	push   %ebp
  801ad2:	89 e5                	mov    %esp,%ebp
  801ad4:	83 ec 04             	sub    $0x4,%esp
  801ad7:	8b 45 10             	mov    0x10(%ebp),%eax
  801ada:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801add:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	52                   	push   %edx
  801ae9:	ff 75 0c             	pushl  0xc(%ebp)
  801aec:	50                   	push   %eax
  801aed:	6a 00                	push   $0x0
  801aef:	e8 b2 ff ff ff       	call   801aa6 <syscall>
  801af4:	83 c4 18             	add    $0x18,%esp
}
  801af7:	90                   	nop
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <sys_cgetc>:

int
sys_cgetc(void)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 01                	push   $0x1
  801b09:	e8 98 ff ff ff       	call   801aa6 <syscall>
  801b0e:	83 c4 18             	add    $0x18,%esp
}
  801b11:	c9                   	leave  
  801b12:	c3                   	ret    

00801b13 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b13:	55                   	push   %ebp
  801b14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b16:	8b 45 08             	mov    0x8(%ebp),%eax
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	50                   	push   %eax
  801b22:	6a 05                	push   $0x5
  801b24:	e8 7d ff ff ff       	call   801aa6 <syscall>
  801b29:	83 c4 18             	add    $0x18,%esp
}
  801b2c:	c9                   	leave  
  801b2d:	c3                   	ret    

00801b2e <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b2e:	55                   	push   %ebp
  801b2f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 02                	push   $0x2
  801b3d:	e8 64 ff ff ff       	call   801aa6 <syscall>
  801b42:	83 c4 18             	add    $0x18,%esp
}
  801b45:	c9                   	leave  
  801b46:	c3                   	ret    

00801b47 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b47:	55                   	push   %ebp
  801b48:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	6a 03                	push   $0x3
  801b56:	e8 4b ff ff ff       	call   801aa6 <syscall>
  801b5b:	83 c4 18             	add    $0x18,%esp
}
  801b5e:	c9                   	leave  
  801b5f:	c3                   	ret    

00801b60 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b60:	55                   	push   %ebp
  801b61:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 04                	push   $0x4
  801b6f:	e8 32 ff ff ff       	call   801aa6 <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	c9                   	leave  
  801b78:	c3                   	ret    

00801b79 <sys_env_exit>:


void sys_env_exit(void)
{
  801b79:	55                   	push   %ebp
  801b7a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 06                	push   $0x6
  801b88:	e8 19 ff ff ff       	call   801aa6 <syscall>
  801b8d:	83 c4 18             	add    $0x18,%esp
}
  801b90:	90                   	nop
  801b91:	c9                   	leave  
  801b92:	c3                   	ret    

00801b93 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b93:	55                   	push   %ebp
  801b94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b99:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	52                   	push   %edx
  801ba3:	50                   	push   %eax
  801ba4:	6a 07                	push   $0x7
  801ba6:	e8 fb fe ff ff       	call   801aa6 <syscall>
  801bab:	83 c4 18             	add    $0x18,%esp
}
  801bae:	c9                   	leave  
  801baf:	c3                   	ret    

00801bb0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bb0:	55                   	push   %ebp
  801bb1:	89 e5                	mov    %esp,%ebp
  801bb3:	56                   	push   %esi
  801bb4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bb5:	8b 75 18             	mov    0x18(%ebp),%esi
  801bb8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bbb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc4:	56                   	push   %esi
  801bc5:	53                   	push   %ebx
  801bc6:	51                   	push   %ecx
  801bc7:	52                   	push   %edx
  801bc8:	50                   	push   %eax
  801bc9:	6a 08                	push   $0x8
  801bcb:	e8 d6 fe ff ff       	call   801aa6 <syscall>
  801bd0:	83 c4 18             	add    $0x18,%esp
}
  801bd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bd6:	5b                   	pop    %ebx
  801bd7:	5e                   	pop    %esi
  801bd8:	5d                   	pop    %ebp
  801bd9:	c3                   	ret    

00801bda <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bda:	55                   	push   %ebp
  801bdb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801bdd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be0:	8b 45 08             	mov    0x8(%ebp),%eax
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	52                   	push   %edx
  801bea:	50                   	push   %eax
  801beb:	6a 09                	push   $0x9
  801bed:	e8 b4 fe ff ff       	call   801aa6 <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
}
  801bf5:	c9                   	leave  
  801bf6:	c3                   	ret    

00801bf7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801bf7:	55                   	push   %ebp
  801bf8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	ff 75 0c             	pushl  0xc(%ebp)
  801c03:	ff 75 08             	pushl  0x8(%ebp)
  801c06:	6a 0a                	push   $0xa
  801c08:	e8 99 fe ff ff       	call   801aa6 <syscall>
  801c0d:	83 c4 18             	add    $0x18,%esp
}
  801c10:	c9                   	leave  
  801c11:	c3                   	ret    

00801c12 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c12:	55                   	push   %ebp
  801c13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 0b                	push   $0xb
  801c21:	e8 80 fe ff ff       	call   801aa6 <syscall>
  801c26:	83 c4 18             	add    $0x18,%esp
}
  801c29:	c9                   	leave  
  801c2a:	c3                   	ret    

00801c2b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 0c                	push   $0xc
  801c3a:	e8 67 fe ff ff       	call   801aa6 <syscall>
  801c3f:	83 c4 18             	add    $0x18,%esp
}
  801c42:	c9                   	leave  
  801c43:	c3                   	ret    

00801c44 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c44:	55                   	push   %ebp
  801c45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 0d                	push   $0xd
  801c53:	e8 4e fe ff ff       	call   801aa6 <syscall>
  801c58:	83 c4 18             	add    $0x18,%esp
}
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	ff 75 0c             	pushl  0xc(%ebp)
  801c69:	ff 75 08             	pushl  0x8(%ebp)
  801c6c:	6a 11                	push   $0x11
  801c6e:	e8 33 fe ff ff       	call   801aa6 <syscall>
  801c73:	83 c4 18             	add    $0x18,%esp
	return;
  801c76:	90                   	nop
}
  801c77:	c9                   	leave  
  801c78:	c3                   	ret    

00801c79 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	ff 75 0c             	pushl  0xc(%ebp)
  801c85:	ff 75 08             	pushl  0x8(%ebp)
  801c88:	6a 12                	push   $0x12
  801c8a:	e8 17 fe ff ff       	call   801aa6 <syscall>
  801c8f:	83 c4 18             	add    $0x18,%esp
	return ;
  801c92:	90                   	nop
}
  801c93:	c9                   	leave  
  801c94:	c3                   	ret    

00801c95 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c95:	55                   	push   %ebp
  801c96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 0e                	push   $0xe
  801ca4:	e8 fd fd ff ff       	call   801aa6 <syscall>
  801ca9:	83 c4 18             	add    $0x18,%esp
}
  801cac:	c9                   	leave  
  801cad:	c3                   	ret    

00801cae <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801cae:	55                   	push   %ebp
  801caf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 00                	push   $0x0
  801cb9:	ff 75 08             	pushl  0x8(%ebp)
  801cbc:	6a 0f                	push   $0xf
  801cbe:	e8 e3 fd ff ff       	call   801aa6 <syscall>
  801cc3:	83 c4 18             	add    $0x18,%esp
}
  801cc6:	c9                   	leave  
  801cc7:	c3                   	ret    

00801cc8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cc8:	55                   	push   %ebp
  801cc9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 10                	push   $0x10
  801cd7:	e8 ca fd ff ff       	call   801aa6 <syscall>
  801cdc:	83 c4 18             	add    $0x18,%esp
}
  801cdf:	90                   	nop
  801ce0:	c9                   	leave  
  801ce1:	c3                   	ret    

00801ce2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ce2:	55                   	push   %ebp
  801ce3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 14                	push   $0x14
  801cf1:	e8 b0 fd ff ff       	call   801aa6 <syscall>
  801cf6:	83 c4 18             	add    $0x18,%esp
}
  801cf9:	90                   	nop
  801cfa:	c9                   	leave  
  801cfb:	c3                   	ret    

00801cfc <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801cfc:	55                   	push   %ebp
  801cfd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 15                	push   $0x15
  801d0b:	e8 96 fd ff ff       	call   801aa6 <syscall>
  801d10:	83 c4 18             	add    $0x18,%esp
}
  801d13:	90                   	nop
  801d14:	c9                   	leave  
  801d15:	c3                   	ret    

00801d16 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d16:	55                   	push   %ebp
  801d17:	89 e5                	mov    %esp,%ebp
  801d19:	83 ec 04             	sub    $0x4,%esp
  801d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d22:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	50                   	push   %eax
  801d2f:	6a 16                	push   $0x16
  801d31:	e8 70 fd ff ff       	call   801aa6 <syscall>
  801d36:	83 c4 18             	add    $0x18,%esp
}
  801d39:	90                   	nop
  801d3a:	c9                   	leave  
  801d3b:	c3                   	ret    

00801d3c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 17                	push   $0x17
  801d4b:	e8 56 fd ff ff       	call   801aa6 <syscall>
  801d50:	83 c4 18             	add    $0x18,%esp
}
  801d53:	90                   	nop
  801d54:	c9                   	leave  
  801d55:	c3                   	ret    

00801d56 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d56:	55                   	push   %ebp
  801d57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d59:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	ff 75 0c             	pushl  0xc(%ebp)
  801d65:	50                   	push   %eax
  801d66:	6a 18                	push   $0x18
  801d68:	e8 39 fd ff ff       	call   801aa6 <syscall>
  801d6d:	83 c4 18             	add    $0x18,%esp
}
  801d70:	c9                   	leave  
  801d71:	c3                   	ret    

00801d72 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d72:	55                   	push   %ebp
  801d73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d75:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d78:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	52                   	push   %edx
  801d82:	50                   	push   %eax
  801d83:	6a 1b                	push   $0x1b
  801d85:	e8 1c fd ff ff       	call   801aa6 <syscall>
  801d8a:	83 c4 18             	add    $0x18,%esp
}
  801d8d:	c9                   	leave  
  801d8e:	c3                   	ret    

00801d8f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d8f:	55                   	push   %ebp
  801d90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d92:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d95:	8b 45 08             	mov    0x8(%ebp),%eax
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	52                   	push   %edx
  801d9f:	50                   	push   %eax
  801da0:	6a 19                	push   $0x19
  801da2:	e8 ff fc ff ff       	call   801aa6 <syscall>
  801da7:	83 c4 18             	add    $0x18,%esp
}
  801daa:	90                   	nop
  801dab:	c9                   	leave  
  801dac:	c3                   	ret    

00801dad <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dad:	55                   	push   %ebp
  801dae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801db0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db3:	8b 45 08             	mov    0x8(%ebp),%eax
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	52                   	push   %edx
  801dbd:	50                   	push   %eax
  801dbe:	6a 1a                	push   $0x1a
  801dc0:	e8 e1 fc ff ff       	call   801aa6 <syscall>
  801dc5:	83 c4 18             	add    $0x18,%esp
}
  801dc8:	90                   	nop
  801dc9:	c9                   	leave  
  801dca:	c3                   	ret    

00801dcb <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801dcb:	55                   	push   %ebp
  801dcc:	89 e5                	mov    %esp,%ebp
  801dce:	83 ec 04             	sub    $0x4,%esp
  801dd1:	8b 45 10             	mov    0x10(%ebp),%eax
  801dd4:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801dd7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801dda:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dde:	8b 45 08             	mov    0x8(%ebp),%eax
  801de1:	6a 00                	push   $0x0
  801de3:	51                   	push   %ecx
  801de4:	52                   	push   %edx
  801de5:	ff 75 0c             	pushl  0xc(%ebp)
  801de8:	50                   	push   %eax
  801de9:	6a 1c                	push   $0x1c
  801deb:	e8 b6 fc ff ff       	call   801aa6 <syscall>
  801df0:	83 c4 18             	add    $0x18,%esp
}
  801df3:	c9                   	leave  
  801df4:	c3                   	ret    

00801df5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801df5:	55                   	push   %ebp
  801df6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801df8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	52                   	push   %edx
  801e05:	50                   	push   %eax
  801e06:	6a 1d                	push   $0x1d
  801e08:	e8 99 fc ff ff       	call   801aa6 <syscall>
  801e0d:	83 c4 18             	add    $0x18,%esp
}
  801e10:	c9                   	leave  
  801e11:	c3                   	ret    

00801e12 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e12:	55                   	push   %ebp
  801e13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e15:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	51                   	push   %ecx
  801e23:	52                   	push   %edx
  801e24:	50                   	push   %eax
  801e25:	6a 1e                	push   $0x1e
  801e27:	e8 7a fc ff ff       	call   801aa6 <syscall>
  801e2c:	83 c4 18             	add    $0x18,%esp
}
  801e2f:	c9                   	leave  
  801e30:	c3                   	ret    

00801e31 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e31:	55                   	push   %ebp
  801e32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e37:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	52                   	push   %edx
  801e41:	50                   	push   %eax
  801e42:	6a 1f                	push   $0x1f
  801e44:	e8 5d fc ff ff       	call   801aa6 <syscall>
  801e49:	83 c4 18             	add    $0x18,%esp
}
  801e4c:	c9                   	leave  
  801e4d:	c3                   	ret    

00801e4e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e4e:	55                   	push   %ebp
  801e4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 20                	push   $0x20
  801e5d:	e8 44 fc ff ff       	call   801aa6 <syscall>
  801e62:	83 c4 18             	add    $0x18,%esp
}
  801e65:	c9                   	leave  
  801e66:	c3                   	ret    

00801e67 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801e67:	55                   	push   %ebp
  801e68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	ff 75 10             	pushl  0x10(%ebp)
  801e74:	ff 75 0c             	pushl  0xc(%ebp)
  801e77:	50                   	push   %eax
  801e78:	6a 21                	push   $0x21
  801e7a:	e8 27 fc ff ff       	call   801aa6 <syscall>
  801e7f:	83 c4 18             	add    $0x18,%esp
}
  801e82:	c9                   	leave  
  801e83:	c3                   	ret    

00801e84 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e84:	55                   	push   %ebp
  801e85:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e87:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	50                   	push   %eax
  801e93:	6a 22                	push   $0x22
  801e95:	e8 0c fc ff ff       	call   801aa6 <syscall>
  801e9a:	83 c4 18             	add    $0x18,%esp
}
  801e9d:	90                   	nop
  801e9e:	c9                   	leave  
  801e9f:	c3                   	ret    

00801ea0 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ea0:	55                   	push   %ebp
  801ea1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	50                   	push   %eax
  801eaf:	6a 23                	push   $0x23
  801eb1:	e8 f0 fb ff ff       	call   801aa6 <syscall>
  801eb6:	83 c4 18             	add    $0x18,%esp
}
  801eb9:	90                   	nop
  801eba:	c9                   	leave  
  801ebb:	c3                   	ret    

00801ebc <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ebc:	55                   	push   %ebp
  801ebd:	89 e5                	mov    %esp,%ebp
  801ebf:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ec2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ec5:	8d 50 04             	lea    0x4(%eax),%edx
  801ec8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	52                   	push   %edx
  801ed2:	50                   	push   %eax
  801ed3:	6a 24                	push   $0x24
  801ed5:	e8 cc fb ff ff       	call   801aa6 <syscall>
  801eda:	83 c4 18             	add    $0x18,%esp
	return result;
  801edd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ee0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ee3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ee6:	89 01                	mov    %eax,(%ecx)
  801ee8:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  801eee:	c9                   	leave  
  801eef:	c2 04 00             	ret    $0x4

00801ef2 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ef2:	55                   	push   %ebp
  801ef3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	ff 75 10             	pushl  0x10(%ebp)
  801efc:	ff 75 0c             	pushl  0xc(%ebp)
  801eff:	ff 75 08             	pushl  0x8(%ebp)
  801f02:	6a 13                	push   $0x13
  801f04:	e8 9d fb ff ff       	call   801aa6 <syscall>
  801f09:	83 c4 18             	add    $0x18,%esp
	return ;
  801f0c:	90                   	nop
}
  801f0d:	c9                   	leave  
  801f0e:	c3                   	ret    

00801f0f <sys_rcr2>:
uint32 sys_rcr2()
{
  801f0f:	55                   	push   %ebp
  801f10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 25                	push   $0x25
  801f1e:	e8 83 fb ff ff       	call   801aa6 <syscall>
  801f23:	83 c4 18             	add    $0x18,%esp
}
  801f26:	c9                   	leave  
  801f27:	c3                   	ret    

00801f28 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f28:	55                   	push   %ebp
  801f29:	89 e5                	mov    %esp,%ebp
  801f2b:	83 ec 04             	sub    $0x4,%esp
  801f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f31:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f34:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	50                   	push   %eax
  801f41:	6a 26                	push   $0x26
  801f43:	e8 5e fb ff ff       	call   801aa6 <syscall>
  801f48:	83 c4 18             	add    $0x18,%esp
	return ;
  801f4b:	90                   	nop
}
  801f4c:	c9                   	leave  
  801f4d:	c3                   	ret    

00801f4e <rsttst>:
void rsttst()
{
  801f4e:	55                   	push   %ebp
  801f4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 28                	push   $0x28
  801f5d:	e8 44 fb ff ff       	call   801aa6 <syscall>
  801f62:	83 c4 18             	add    $0x18,%esp
	return ;
  801f65:	90                   	nop
}
  801f66:	c9                   	leave  
  801f67:	c3                   	ret    

00801f68 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f68:	55                   	push   %ebp
  801f69:	89 e5                	mov    %esp,%ebp
  801f6b:	83 ec 04             	sub    $0x4,%esp
  801f6e:	8b 45 14             	mov    0x14(%ebp),%eax
  801f71:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f74:	8b 55 18             	mov    0x18(%ebp),%edx
  801f77:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f7b:	52                   	push   %edx
  801f7c:	50                   	push   %eax
  801f7d:	ff 75 10             	pushl  0x10(%ebp)
  801f80:	ff 75 0c             	pushl  0xc(%ebp)
  801f83:	ff 75 08             	pushl  0x8(%ebp)
  801f86:	6a 27                	push   $0x27
  801f88:	e8 19 fb ff ff       	call   801aa6 <syscall>
  801f8d:	83 c4 18             	add    $0x18,%esp
	return ;
  801f90:	90                   	nop
}
  801f91:	c9                   	leave  
  801f92:	c3                   	ret    

00801f93 <chktst>:
void chktst(uint32 n)
{
  801f93:	55                   	push   %ebp
  801f94:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	ff 75 08             	pushl  0x8(%ebp)
  801fa1:	6a 29                	push   $0x29
  801fa3:	e8 fe fa ff ff       	call   801aa6 <syscall>
  801fa8:	83 c4 18             	add    $0x18,%esp
	return ;
  801fab:	90                   	nop
}
  801fac:	c9                   	leave  
  801fad:	c3                   	ret    

00801fae <inctst>:

void inctst()
{
  801fae:	55                   	push   %ebp
  801faf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 2a                	push   $0x2a
  801fbd:	e8 e4 fa ff ff       	call   801aa6 <syscall>
  801fc2:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc5:	90                   	nop
}
  801fc6:	c9                   	leave  
  801fc7:	c3                   	ret    

00801fc8 <gettst>:
uint32 gettst()
{
  801fc8:	55                   	push   %ebp
  801fc9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 2b                	push   $0x2b
  801fd7:	e8 ca fa ff ff       	call   801aa6 <syscall>
  801fdc:	83 c4 18             	add    $0x18,%esp
}
  801fdf:	c9                   	leave  
  801fe0:	c3                   	ret    

00801fe1 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801fe1:	55                   	push   %ebp
  801fe2:	89 e5                	mov    %esp,%ebp
  801fe4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 00                	push   $0x0
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 2c                	push   $0x2c
  801ff3:	e8 ae fa ff ff       	call   801aa6 <syscall>
  801ff8:	83 c4 18             	add    $0x18,%esp
  801ffb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801ffe:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802002:	75 07                	jne    80200b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802004:	b8 01 00 00 00       	mov    $0x1,%eax
  802009:	eb 05                	jmp    802010 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80200b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802010:	c9                   	leave  
  802011:	c3                   	ret    

00802012 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802012:	55                   	push   %ebp
  802013:	89 e5                	mov    %esp,%ebp
  802015:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 2c                	push   $0x2c
  802024:	e8 7d fa ff ff       	call   801aa6 <syscall>
  802029:	83 c4 18             	add    $0x18,%esp
  80202c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80202f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802033:	75 07                	jne    80203c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802035:	b8 01 00 00 00       	mov    $0x1,%eax
  80203a:	eb 05                	jmp    802041 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80203c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802041:	c9                   	leave  
  802042:	c3                   	ret    

00802043 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802043:	55                   	push   %ebp
  802044:	89 e5                	mov    %esp,%ebp
  802046:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	6a 2c                	push   $0x2c
  802055:	e8 4c fa ff ff       	call   801aa6 <syscall>
  80205a:	83 c4 18             	add    $0x18,%esp
  80205d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802060:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802064:	75 07                	jne    80206d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802066:	b8 01 00 00 00       	mov    $0x1,%eax
  80206b:	eb 05                	jmp    802072 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80206d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802072:	c9                   	leave  
  802073:	c3                   	ret    

00802074 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802074:	55                   	push   %ebp
  802075:	89 e5                	mov    %esp,%ebp
  802077:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 2c                	push   $0x2c
  802086:	e8 1b fa ff ff       	call   801aa6 <syscall>
  80208b:	83 c4 18             	add    $0x18,%esp
  80208e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802091:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802095:	75 07                	jne    80209e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802097:	b8 01 00 00 00       	mov    $0x1,%eax
  80209c:	eb 05                	jmp    8020a3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80209e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020a3:	c9                   	leave  
  8020a4:	c3                   	ret    

008020a5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020a5:	55                   	push   %ebp
  8020a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	ff 75 08             	pushl  0x8(%ebp)
  8020b3:	6a 2d                	push   $0x2d
  8020b5:	e8 ec f9 ff ff       	call   801aa6 <syscall>
  8020ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8020bd:	90                   	nop
}
  8020be:	c9                   	leave  
  8020bf:	c3                   	ret    

008020c0 <__udivdi3>:
  8020c0:	55                   	push   %ebp
  8020c1:	57                   	push   %edi
  8020c2:	56                   	push   %esi
  8020c3:	53                   	push   %ebx
  8020c4:	83 ec 1c             	sub    $0x1c,%esp
  8020c7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020cb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020cf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020d3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020d7:	89 ca                	mov    %ecx,%edx
  8020d9:	89 f8                	mov    %edi,%eax
  8020db:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8020df:	85 f6                	test   %esi,%esi
  8020e1:	75 2d                	jne    802110 <__udivdi3+0x50>
  8020e3:	39 cf                	cmp    %ecx,%edi
  8020e5:	77 65                	ja     80214c <__udivdi3+0x8c>
  8020e7:	89 fd                	mov    %edi,%ebp
  8020e9:	85 ff                	test   %edi,%edi
  8020eb:	75 0b                	jne    8020f8 <__udivdi3+0x38>
  8020ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8020f2:	31 d2                	xor    %edx,%edx
  8020f4:	f7 f7                	div    %edi
  8020f6:	89 c5                	mov    %eax,%ebp
  8020f8:	31 d2                	xor    %edx,%edx
  8020fa:	89 c8                	mov    %ecx,%eax
  8020fc:	f7 f5                	div    %ebp
  8020fe:	89 c1                	mov    %eax,%ecx
  802100:	89 d8                	mov    %ebx,%eax
  802102:	f7 f5                	div    %ebp
  802104:	89 cf                	mov    %ecx,%edi
  802106:	89 fa                	mov    %edi,%edx
  802108:	83 c4 1c             	add    $0x1c,%esp
  80210b:	5b                   	pop    %ebx
  80210c:	5e                   	pop    %esi
  80210d:	5f                   	pop    %edi
  80210e:	5d                   	pop    %ebp
  80210f:	c3                   	ret    
  802110:	39 ce                	cmp    %ecx,%esi
  802112:	77 28                	ja     80213c <__udivdi3+0x7c>
  802114:	0f bd fe             	bsr    %esi,%edi
  802117:	83 f7 1f             	xor    $0x1f,%edi
  80211a:	75 40                	jne    80215c <__udivdi3+0x9c>
  80211c:	39 ce                	cmp    %ecx,%esi
  80211e:	72 0a                	jb     80212a <__udivdi3+0x6a>
  802120:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802124:	0f 87 9e 00 00 00    	ja     8021c8 <__udivdi3+0x108>
  80212a:	b8 01 00 00 00       	mov    $0x1,%eax
  80212f:	89 fa                	mov    %edi,%edx
  802131:	83 c4 1c             	add    $0x1c,%esp
  802134:	5b                   	pop    %ebx
  802135:	5e                   	pop    %esi
  802136:	5f                   	pop    %edi
  802137:	5d                   	pop    %ebp
  802138:	c3                   	ret    
  802139:	8d 76 00             	lea    0x0(%esi),%esi
  80213c:	31 ff                	xor    %edi,%edi
  80213e:	31 c0                	xor    %eax,%eax
  802140:	89 fa                	mov    %edi,%edx
  802142:	83 c4 1c             	add    $0x1c,%esp
  802145:	5b                   	pop    %ebx
  802146:	5e                   	pop    %esi
  802147:	5f                   	pop    %edi
  802148:	5d                   	pop    %ebp
  802149:	c3                   	ret    
  80214a:	66 90                	xchg   %ax,%ax
  80214c:	89 d8                	mov    %ebx,%eax
  80214e:	f7 f7                	div    %edi
  802150:	31 ff                	xor    %edi,%edi
  802152:	89 fa                	mov    %edi,%edx
  802154:	83 c4 1c             	add    $0x1c,%esp
  802157:	5b                   	pop    %ebx
  802158:	5e                   	pop    %esi
  802159:	5f                   	pop    %edi
  80215a:	5d                   	pop    %ebp
  80215b:	c3                   	ret    
  80215c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802161:	89 eb                	mov    %ebp,%ebx
  802163:	29 fb                	sub    %edi,%ebx
  802165:	89 f9                	mov    %edi,%ecx
  802167:	d3 e6                	shl    %cl,%esi
  802169:	89 c5                	mov    %eax,%ebp
  80216b:	88 d9                	mov    %bl,%cl
  80216d:	d3 ed                	shr    %cl,%ebp
  80216f:	89 e9                	mov    %ebp,%ecx
  802171:	09 f1                	or     %esi,%ecx
  802173:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802177:	89 f9                	mov    %edi,%ecx
  802179:	d3 e0                	shl    %cl,%eax
  80217b:	89 c5                	mov    %eax,%ebp
  80217d:	89 d6                	mov    %edx,%esi
  80217f:	88 d9                	mov    %bl,%cl
  802181:	d3 ee                	shr    %cl,%esi
  802183:	89 f9                	mov    %edi,%ecx
  802185:	d3 e2                	shl    %cl,%edx
  802187:	8b 44 24 08          	mov    0x8(%esp),%eax
  80218b:	88 d9                	mov    %bl,%cl
  80218d:	d3 e8                	shr    %cl,%eax
  80218f:	09 c2                	or     %eax,%edx
  802191:	89 d0                	mov    %edx,%eax
  802193:	89 f2                	mov    %esi,%edx
  802195:	f7 74 24 0c          	divl   0xc(%esp)
  802199:	89 d6                	mov    %edx,%esi
  80219b:	89 c3                	mov    %eax,%ebx
  80219d:	f7 e5                	mul    %ebp
  80219f:	39 d6                	cmp    %edx,%esi
  8021a1:	72 19                	jb     8021bc <__udivdi3+0xfc>
  8021a3:	74 0b                	je     8021b0 <__udivdi3+0xf0>
  8021a5:	89 d8                	mov    %ebx,%eax
  8021a7:	31 ff                	xor    %edi,%edi
  8021a9:	e9 58 ff ff ff       	jmp    802106 <__udivdi3+0x46>
  8021ae:	66 90                	xchg   %ax,%ax
  8021b0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8021b4:	89 f9                	mov    %edi,%ecx
  8021b6:	d3 e2                	shl    %cl,%edx
  8021b8:	39 c2                	cmp    %eax,%edx
  8021ba:	73 e9                	jae    8021a5 <__udivdi3+0xe5>
  8021bc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8021bf:	31 ff                	xor    %edi,%edi
  8021c1:	e9 40 ff ff ff       	jmp    802106 <__udivdi3+0x46>
  8021c6:	66 90                	xchg   %ax,%ax
  8021c8:	31 c0                	xor    %eax,%eax
  8021ca:	e9 37 ff ff ff       	jmp    802106 <__udivdi3+0x46>
  8021cf:	90                   	nop

008021d0 <__umoddi3>:
  8021d0:	55                   	push   %ebp
  8021d1:	57                   	push   %edi
  8021d2:	56                   	push   %esi
  8021d3:	53                   	push   %ebx
  8021d4:	83 ec 1c             	sub    $0x1c,%esp
  8021d7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021db:	8b 74 24 34          	mov    0x34(%esp),%esi
  8021df:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021e3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8021e7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8021eb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8021ef:	89 f3                	mov    %esi,%ebx
  8021f1:	89 fa                	mov    %edi,%edx
  8021f3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021f7:	89 34 24             	mov    %esi,(%esp)
  8021fa:	85 c0                	test   %eax,%eax
  8021fc:	75 1a                	jne    802218 <__umoddi3+0x48>
  8021fe:	39 f7                	cmp    %esi,%edi
  802200:	0f 86 a2 00 00 00    	jbe    8022a8 <__umoddi3+0xd8>
  802206:	89 c8                	mov    %ecx,%eax
  802208:	89 f2                	mov    %esi,%edx
  80220a:	f7 f7                	div    %edi
  80220c:	89 d0                	mov    %edx,%eax
  80220e:	31 d2                	xor    %edx,%edx
  802210:	83 c4 1c             	add    $0x1c,%esp
  802213:	5b                   	pop    %ebx
  802214:	5e                   	pop    %esi
  802215:	5f                   	pop    %edi
  802216:	5d                   	pop    %ebp
  802217:	c3                   	ret    
  802218:	39 f0                	cmp    %esi,%eax
  80221a:	0f 87 ac 00 00 00    	ja     8022cc <__umoddi3+0xfc>
  802220:	0f bd e8             	bsr    %eax,%ebp
  802223:	83 f5 1f             	xor    $0x1f,%ebp
  802226:	0f 84 ac 00 00 00    	je     8022d8 <__umoddi3+0x108>
  80222c:	bf 20 00 00 00       	mov    $0x20,%edi
  802231:	29 ef                	sub    %ebp,%edi
  802233:	89 fe                	mov    %edi,%esi
  802235:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802239:	89 e9                	mov    %ebp,%ecx
  80223b:	d3 e0                	shl    %cl,%eax
  80223d:	89 d7                	mov    %edx,%edi
  80223f:	89 f1                	mov    %esi,%ecx
  802241:	d3 ef                	shr    %cl,%edi
  802243:	09 c7                	or     %eax,%edi
  802245:	89 e9                	mov    %ebp,%ecx
  802247:	d3 e2                	shl    %cl,%edx
  802249:	89 14 24             	mov    %edx,(%esp)
  80224c:	89 d8                	mov    %ebx,%eax
  80224e:	d3 e0                	shl    %cl,%eax
  802250:	89 c2                	mov    %eax,%edx
  802252:	8b 44 24 08          	mov    0x8(%esp),%eax
  802256:	d3 e0                	shl    %cl,%eax
  802258:	89 44 24 04          	mov    %eax,0x4(%esp)
  80225c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802260:	89 f1                	mov    %esi,%ecx
  802262:	d3 e8                	shr    %cl,%eax
  802264:	09 d0                	or     %edx,%eax
  802266:	d3 eb                	shr    %cl,%ebx
  802268:	89 da                	mov    %ebx,%edx
  80226a:	f7 f7                	div    %edi
  80226c:	89 d3                	mov    %edx,%ebx
  80226e:	f7 24 24             	mull   (%esp)
  802271:	89 c6                	mov    %eax,%esi
  802273:	89 d1                	mov    %edx,%ecx
  802275:	39 d3                	cmp    %edx,%ebx
  802277:	0f 82 87 00 00 00    	jb     802304 <__umoddi3+0x134>
  80227d:	0f 84 91 00 00 00    	je     802314 <__umoddi3+0x144>
  802283:	8b 54 24 04          	mov    0x4(%esp),%edx
  802287:	29 f2                	sub    %esi,%edx
  802289:	19 cb                	sbb    %ecx,%ebx
  80228b:	89 d8                	mov    %ebx,%eax
  80228d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802291:	d3 e0                	shl    %cl,%eax
  802293:	89 e9                	mov    %ebp,%ecx
  802295:	d3 ea                	shr    %cl,%edx
  802297:	09 d0                	or     %edx,%eax
  802299:	89 e9                	mov    %ebp,%ecx
  80229b:	d3 eb                	shr    %cl,%ebx
  80229d:	89 da                	mov    %ebx,%edx
  80229f:	83 c4 1c             	add    $0x1c,%esp
  8022a2:	5b                   	pop    %ebx
  8022a3:	5e                   	pop    %esi
  8022a4:	5f                   	pop    %edi
  8022a5:	5d                   	pop    %ebp
  8022a6:	c3                   	ret    
  8022a7:	90                   	nop
  8022a8:	89 fd                	mov    %edi,%ebp
  8022aa:	85 ff                	test   %edi,%edi
  8022ac:	75 0b                	jne    8022b9 <__umoddi3+0xe9>
  8022ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8022b3:	31 d2                	xor    %edx,%edx
  8022b5:	f7 f7                	div    %edi
  8022b7:	89 c5                	mov    %eax,%ebp
  8022b9:	89 f0                	mov    %esi,%eax
  8022bb:	31 d2                	xor    %edx,%edx
  8022bd:	f7 f5                	div    %ebp
  8022bf:	89 c8                	mov    %ecx,%eax
  8022c1:	f7 f5                	div    %ebp
  8022c3:	89 d0                	mov    %edx,%eax
  8022c5:	e9 44 ff ff ff       	jmp    80220e <__umoddi3+0x3e>
  8022ca:	66 90                	xchg   %ax,%ax
  8022cc:	89 c8                	mov    %ecx,%eax
  8022ce:	89 f2                	mov    %esi,%edx
  8022d0:	83 c4 1c             	add    $0x1c,%esp
  8022d3:	5b                   	pop    %ebx
  8022d4:	5e                   	pop    %esi
  8022d5:	5f                   	pop    %edi
  8022d6:	5d                   	pop    %ebp
  8022d7:	c3                   	ret    
  8022d8:	3b 04 24             	cmp    (%esp),%eax
  8022db:	72 06                	jb     8022e3 <__umoddi3+0x113>
  8022dd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8022e1:	77 0f                	ja     8022f2 <__umoddi3+0x122>
  8022e3:	89 f2                	mov    %esi,%edx
  8022e5:	29 f9                	sub    %edi,%ecx
  8022e7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8022eb:	89 14 24             	mov    %edx,(%esp)
  8022ee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022f2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8022f6:	8b 14 24             	mov    (%esp),%edx
  8022f9:	83 c4 1c             	add    $0x1c,%esp
  8022fc:	5b                   	pop    %ebx
  8022fd:	5e                   	pop    %esi
  8022fe:	5f                   	pop    %edi
  8022ff:	5d                   	pop    %ebp
  802300:	c3                   	ret    
  802301:	8d 76 00             	lea    0x0(%esi),%esi
  802304:	2b 04 24             	sub    (%esp),%eax
  802307:	19 fa                	sbb    %edi,%edx
  802309:	89 d1                	mov    %edx,%ecx
  80230b:	89 c6                	mov    %eax,%esi
  80230d:	e9 71 ff ff ff       	jmp    802283 <__umoddi3+0xb3>
  802312:	66 90                	xchg   %ax,%ax
  802314:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802318:	72 ea                	jb     802304 <__umoddi3+0x134>
  80231a:	89 d9                	mov    %ebx,%ecx
  80231c:	e9 62 ff ff ff       	jmp    802283 <__umoddi3+0xb3>
