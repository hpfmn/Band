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


50 => int bpm;
int key;
0 => int start;
0 => int numcount;
100 => int multipl;
0 => int new_tempo;

//fun void enter_tempo()
//{
//}

                        250 => msg1.data1; // 252 would be stop, 251 continue
                        0 => msg1.data2;
                        0 => msg1.data3;
                        mout1.send(msg1);
                        1 => start;




fun void set_tempo( int tempo )
{
    if (start==0)
    {
    tempo => bpm;
    Std.system("say "+Std.itoa(bpm)+" &");
    0 => numcount;
    100 => multipl;
    0 => new_tempo;
    }
}



fun void control()
{
    while(true)
    {
        min1 => now;
        while(min1.recv(msg2))
        {
            <<<msg2.data1, msg2.data2, msg2.data3>>>;
            //<<<msg2.data2 % 12>>>;
            if((msg2.data1 == 144) && (msg2.data3 == 0))
            {
                msg2.data2 % 24 => key;
                if(key==0)
                {
                    set_tempo(180);
                }
                if(key==1)
                {
                    set_tempo(112);
                }
                if(key==2)
                {
                    set_tempo(140);
                }
                if(key==3)
                {
                    set_tempo(105);
                }
                if(key==4)
                {
                    set_tempo(122);
                }
                if(key==5)
                {
                    set_tempo(185);
                }
                if(key==6)
                {
                    set_tempo(125);
                }
                if(key==7)
                {
                    set_tempo(170);
                }
                if(key==8)
                {
                    set_tempo(129);
                }
                if(key==10)
                {
                    Std.system("say "+Std.itoa(bpm)+" &");
                }
                if(key==11)
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
			0 => numcount;
			0 => new_tempo;
			100 => multipl;
                        //set_tempo(bpm);
                        <<<"STOP">>>;
                    }
                }
                if((key>=12) && (key<=21))
                {
                    (key % 12) * multipl +=> new_tempo;
                    1 +=> numcount;
                    multipl/10 => multipl;
                    <<< multipl >>>;
                    <<< new_tempo >>>;
                    if(numcount==3)
                    {
                        set_tempo(new_tempo);
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
             //<<<"blubb">>>;
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
