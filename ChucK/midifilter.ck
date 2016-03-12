// number of the device to open (see: chuck --probe)
4 => int device;
// get command line
if( me.args() ) me.arg(0) => Std.atoi => device;

int i;
0 => i;

// the midi event
MidiIn min1;
MidiIn min2;
MidiOut mout1;
MidiOut mout2;
MidiOut mout3;
// the message for retrieving data
MidiMsg msg1;
MidiMsg msg2;
if( !mout1.open( 0 ) ) me.exit();
if( !mout2.open( 1 ) ) me.exit();
if( !mout3.open( 2 ) ) me.exit();

// open the device
if( !min1.open( device ) ) me.exit();

min2.open(3);

fun void midiread()
{
  while( true )
  {  
    min2 => now;
    while( min2.recv(msg2) )
    {
        // print out midi message
       // <<< msg2.data1, msg2.data2, msg2.data3 >>>;
        if((msg2.data1==144)||(msg2.data1==176))
        {
            //<<<i>>>;
            if(i==0)
            {
            //<<<"mout1">>>;
                mout1.send(msg2);
            }
            if(i==1)
            {
            //<<<"mout2">>>;
                msg2.data1+1=>msg2.data1;
                mout2.send(msg2);
            }
            if(i==2)
            {
            //<<<"mout3">>>;
                msg2.data1+2=>msg2.data1;
                mout3.send(msg2);
            }
        }
    }
   }
}

fun void setoutput()
{
   while( true )
   {
    min1 => now;
    while( min1.recv(msg1))
    {
        <<<msg1.data1, msg1.data2, msg1.data3 >>>;
        if(msg1.data1==195)
        {
            if(msg1.data2==0)
                0 => i;
            if(msg1.data2==1)
                1 => i;
            if(msg1.data2==2)
                2 => i;
        }
    }
   }
}
// print out device that was opened

spork ~ midiread();
spork ~ setoutput();

// infinite time-loop
while( true )
        1::second => now; 