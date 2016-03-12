// MidiClock

MidiOut mout1;
MidiIn min1;
//MidiIn min2;
MidiMsg msg1;
MidiMsg msg2;


SndBuf w;
SndBuf s;

"data/MetronomeUp.wav" => w.read;
"data/Metronome.wav" => s.read;

//?w.samples => w.pos;
w => dac;
s => dac;

1 => s.gain;
1 => w.gain;

0 => int i;

if( !mout1.open( "IAC-Treiber MidiClock" ) ) me.exit(); 
//if( !min1.open( "Midilink" ) ) me.exit();
if( !min1.open( "Midilink" ) ) me.exit();


50 => float bpm;
int key;
0 => int start;

//fun void enter_tempo()
//{
//}

                        250 => msg1.data1; // 252 would be stop, 251 continue
                        0 => msg1.data2;
                        0 => msg1.data3;
                        mout1.send(msg1);
                        1 => start;


fun void control()
{
    while(true)
    {
        min1 => now;
        while(min1.recv(msg2))
        {
            <<<msg2.data1, msg2.data2, msg2.data3>>>;
            //<<<msg2.data2 % 12>>>;
            if(msg2.data1 == 144)
            {
                msg2.data2 % 12 => key;
                if(key==0)
                {
                    180 => bpm;
                }
                if(key==1)
                {
                    112 => bpm;
                }
                if(key==2)
                {
                    140 => bpm;
                }
                if(key==3)
                {
                    105 => bpm;
                }
                if(key==4)
                {
                    122 => bpm;
                }
                if(key==5)
                {
                    185 => bpm;
                }
                if(key==6)
                {
                    125 => bpm;
                }
                if(key==7)
                {
                    170 => bpm;
                }
                if(key==8)
                {
                    129 => bpm;
                }
                if((key==11) && (msg2.data3!=0))
                {
                    if(start==0)
                    {
                        // Start Message
                        176 => msg1.data1; // 252 would be stop, 251 continue
                        8 => msg1.data2;
                        0 => msg1.data3;
                        mout1.send(msg1);
                        1 => start;
                        <<<"START">>>;
                    }
                    else
                    {
                                                // Stop Message
                        176 => msg1.data1; // 252 would be stop, 251 continue
                        8 => msg1.data2;
                        127 => msg1.data3;
                        mout1.send(msg1);
                        0 => start;
                        <<<"STOP">>>;
                    }
                }
            }
        }
    }
}

fun void midiclock()
{
    while(true)
    {
// Clock Message
         248 => msg1.data1;
         0 => msg1.data2;
         0 => msg1.data3;
         mout1.send(msg1);
         if( (start==1) && (i==23) )
         {
             0 => w.pos;
           //  <<<"blubb">>>;
         }
         if(i==24)
             0 => i;
         i + 1 => i;
         (60.0/(bpm*24))*1000::ms=>now;
    }
}

spork ~ control();
spork ~ midiclock();
//spork ~ enter_tempo();


while(true)
    1::second => now;