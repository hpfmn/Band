MidiIn min1;
MidiIn min2;

MidiMsg msg1;
MidiMsg msg2;

MidiOut mout1;
if( !mout1.open( 0 ) ) me.exit();

if( !min2.open( 4 ) ) me.exit(); //Midilink
if( !min1.open( 5 ) ) me.exit(); //Nanopad

fun void bla()
{
while(true)
{
    min1 => now;
    while(min1.recv(msg1))
    {
       mout1.send(msg1); //<<< msg1.data1, msg1.data2, msg1.data3 >>>;
    }
}
}

fun void blu()
{
while(true)
{
    min2 => now;
    while(min2.recv(msg2))
    {
       mout1.send(msg2);
       // <<< msg2.data1, msg2.data2, msg2.data3 >>>;
    }
}
}

spork ~ blu();
spork ~ bla();
while(true)
    1::second=>now;