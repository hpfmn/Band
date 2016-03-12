MidiIn min1;
MidiIn min2;
MidiOut mout1;
MidiOut mout2;
MidiOut mout3;
MidiOut mout4;
MidiOut mout5;

MidiMsg msg1;
MidiMsg msg2;
MidiMsg msg3;

//Midi-Inputs
if( !min2.open( "Midilink" ) ) me.exit(); //Controller
if( !min1.open( "MIDI 1 x 1" ) ) me.exit(); //Piano

//Midi-Outputs
if( !mout1.open( 0 ) ) me.exit();
if( !mout2.open( 1 ) ) me.exit();
if( !mout3.open( 2 ) ) me.exit();
if( !mout4.open( 3 ) ) me.exit();
if( !mout5.open( 4 ) ) me.exit();

3 => int i;

fun void Piano()
{
    while( true )
    {
        min1 => now;
        while( min1.recv(msg1) )
        {
                // print out midi message
                // <<< msg1.data1, msg1.data2, msg1.data3 >>>;
                if((msg1.data1==144)||(msg1.data1==176))
                {
                    //<<<i>>>;
                    if(i==0)
                        mout1.send(msg1);
                    if(i==1)
                        mout2.send(msg1);
                    if(i==2)
                        mout3.send(msg1);
                    if(i==3)
                        mout4.send(msg1);
                    if(i==4)
                        mout5.send(msg1);
                 }
        }
    }
}

fun void Controller()
{
    while(true)
    {
        min2 => now;
        while( min2.recv(msg2) )
        {
           <<<msg2.data1, msg2.data2, msg2.data3>>>;
            if((msg2.data1==144)&&(msg2.data3==0))
            {
                if((msg2.data2%12)==0)
                    0 => i;
                if((msg2.data2%12)==1)
                    1 => i;
                if((msg2.data2%12)==2)
                    2 => i;
                if((msg2.data2%12)==3)
                    3 => i;
                if((msg2.data2%12)==4)
                    4 => i;
                if((msg2.data2%12)==5)
                {
                                195 => msg3.data1; //Programmchange channel 4
                                0 => msg3.data2; //programm no1
                                0 => msg3.data3;
                                mout4.send(msg3);
                }
                if((msg2.data2%12)==6)
                {
                    195 => msg3.data1; //Programmchange channel 4
                    1 => msg3.data2; //programm no1
                    0 => msg3.data3;
                    mout4.send(msg3);
                }
                if((msg2.data2%12)==7)
                {
                    195 => msg3.data1; //Programmchange channel 4
                    2 => msg3.data2; //programm no1
                    0 => msg3.data3;
                    mout4.send(msg3);
                }
            }
        }
    }
}

spork ~ Piano();
spork ~ Controller();

while( true )
    1::second => now;
