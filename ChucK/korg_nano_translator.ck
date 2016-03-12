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
if( !min1.open( "nanoPAD PAD" ) ) me.exit(); //Korg nano Pad

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
        <<<msg1.data1, msg1.data2, msg1.data3>>>;
        if(msg1.data2==39)
        {
            <<<"Button 1">>>;
            195 => msg2.data1; //Programmchange channel 4
            7 => msg2.data2; //programm no8
            0 => msg2.data3;
            mout4.send(msg2);
        }
        if(msg1.data2==48)
        {
            195 => msg2.data1; //Programmchange channel 4
            8 => msg2.data2; //programm no8
            0 => msg2.data3;
            mout4.send(msg2);
            <<<"Button 2">>>;
        }
        if(msg1.data2==45)
        {
            195 => msg2.data1; //Programmchange channel 4
            9 => msg2.data2; //programm no8
            0 => msg2.data3;
            mout4.send(msg2);
            <<<"Button 3">>>;                 
        }
        if((msg1.data1==159) & (msg1.data2==43))
        {
            <<<"Button 4 pressed">>>;
           <<<id>>>;
          if(id == 0)
          {
            Machine.add("/Users/hannes/Documents/Programmierung/ChucK/metro2.ck") => id;
       }
          else
          {
             Machine.remove(id);
             0 => id;
          }
        }
        if(msg1.data2==51)
        {
            <<<"Button 5">>>;
        }
        if(msg1.data2==49)
        {
            <<<"Button 6">>>;
            if (i==1)
            {
                179 => msg2.data1; //Control Change Channel4 
                55 => msg2.data2; //CC55
                0 => msg2.data3; //Value
                mout4.send(msg2);
                2 => i;
            }
            else
            {
                179 => msg2.data1; //Control Change Channel4 
                55 => msg2.data2; //CC55
                127 => msg2.data3; //Value
                mout4.send(msg2);
                1 => i;
            }
        }
        if(msg1.data2==36)
        {
            <<<"Button 7">>>;
            192 => msg2.data1; //Programmchange channel 1
            4 => msg2.data2; //programm no5
            0 => msg2.data3;
            mout1.send(msg2);
        }
        if(msg1.data2==38)
        {
            <<<"Button 8">>>;
            192 => msg2.data1; //Programmchange channel 1
            5 => msg2.data2; //programm no6
            0 => msg2.data3;
            mout1.send(msg2);
        }
        if(msg1.data2==40)
        {
            <<<"Button 9">>>;
            192 => msg2.data1; //Programmchange channel 1
            6 => msg2.data2; //programm no6
            0 => msg2.data3;
            mout1.send(msg2);
        }
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

        if(msg1.data2==27)
        {
            mout1.send(msg1);
        }
        if(msg1.data2==28)
        {
            mout1.send(msg1);
        }
    }
}