MidiIn min1;

MidiOut mout1;
MidiOut mout2;
MidiOut mout3;
MidiOut mout4;

MidiMsg msg1;
MidiMsg msg2;

int i;
1 =>i;
0 => int id;
//Midi-Inputs
if( !min1.open( 9 ) ) me.exit(); //Korg nano Pad

//Midi-Outputs
if( !mout1.open( 0 ) ) me.exit();
if( !mout2.open( 1 ) ) me.exit();
if( !mout3.open( 2 ) ) me.exit();
if( !mout4.open( 3 ) ) me.exit();

while(true)
{
    min1 => now;
    while( min1.recv(msg1))
    {
if((msg1.data1==159) & (msg1.data2==42))
{
    <<<"Button 10">>>;
    193 => msg2.data1; //Programmchange channel 2
    0 => msg2.data2; //programm no1
    0 => msg2.data3;
    <<<msg2.data1,msg2.data2,msg2.data3>>>;
    mout2.send(msg2);
}
if((msg1.data1==159) & (msg1.data2==46))
{
    <<<"Button 12">>>;
    193 => msg2.data1; //Programmchange channel 2
    1 => msg2.data2; //programm no2
    0 => msg2.data3;
    <<<msg2.data1,msg2.data2,msg2.data3>>>;
    mout2.send(msg2);
    mout2.send(msg2);
}
if((msg1.data1==159) & (msg1.data2==44))
{
    <<<"Button 11">>>;                
    193 => msg2.data1; //Programmchange channel 2
    3 => msg2.data2; //programm no2
    0 => msg2.data3;
    <<<msg2.data1,msg2.data2,msg2.data3>>>;
    mout2.send(msg2);
}
}
}