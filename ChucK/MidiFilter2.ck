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
if( !min2.open( 5 ) ) me.exit(); //Controller
if( !min1.open( 6 ) ) me.exit(); //Piano

//Midi-Outputs
if( !mout1.open( 0 ) ) me.exit();
if( !mout2.open( 1 ) ) me.exit();
if( !mout3.open( 2 ) ) me.exit();
if( !mout4.open( 3 ) ) me.exit();
if( !mout5.open( 4 ) ) me.exit();

0 => int i;

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
           //<<<msg2.data1, msg2.data2, msg2.data3>>>;
           //if((msg2.data1>=192)&&(msg2.data1<=207))
            //   msg2.data2 => msg2.data3;
           //msg2.data1=>msg3.data1;
           //msg2.data2=>msg3.data3;
           //255=>msg3.data3;
           //<<<"msg3">>>;
           //<<<msg3.data1, msg3.data2, msg3.data2>>>;
            if((msg2.data1  % 16)==0)
                mout1.send(msg2);
            if((msg2.data1  % 16)==1)
                mout2.send(msg2);
            if((msg2.data1  % 16)==2)
                mout3.send(msg2);
            if((msg2.data1  % 16)==3)
                mout4.send(msg2);
            if((msg2.data1  % 16)==5)
                mout5.send(msg2);
            if(msg2.data1==196)
            {
                if(msg2.data2==0)
                    0 => i;
                if(msg2.data2==1)
                    1 => i;
                if(msg2.data2==2)
                    2 => i;
                if(msg2.data2==3)
                    3 => i;
                if(msg2.data2==4)
                    4 => i;

            }
        }
    }
}

spork ~ Piano();
spork ~ Controller();

while( true )
    1::second => now;
