//metronome

SndBuf w;
SndBuf s;

"data/MetronomeUp.wav" => w.read;
"data/Metronome.wav" => s.read;

//?w.samples => w.pos;
w => dac;
s => dac;
//s => dac;

1 => s.gain;
0.5 => w.gain;//0.38 => w.gain;

0 => int i;
0 => int j;
[1,0,1,0,1,1] @=> int b[];
[1,0,0,0,0,0] @=> int a[];


1    => int beats;
180 => float bpm;

while(true)
{
   /* 
   if(j==0)
    {
        0.2 => w.gain;
    }
    if(j==2)
    {
        2.0 => w.gain;
    }
    */
    if(i<(1*beats))
    {
        if(a[j]==1)
        {
            0 => w.pos;
            //<<<"tick">>>;
        }
        if(b[j]==1)
        {
            0 => s.pos;
            //<<<"tick">>>;
        }
        //<<<"tick"+i>>>;
    }
    else
    {
        if(a[j]==1)
        {
           0 => w.pos;
            //<<<"tick">>>;
        }
        if(b[j]==1)
        {
            0 => s.pos;
            //<<<"tick">>>;
        }
       // <<<"tick"+i>>>; 
    }
    i+1 => i;
    if(i>((2*3)-1))
    {
    
        0 => i;
        //<<<"nicht tick"+i>>>;
    }
    
    /*
    if(a[j]==1)
    {
        0 => w.pos;
        <<<"tick">>>;
    }
    else
        <<<"nicht tick"+i>>>;
    */
    j++;
    
    if(j==beats)
        0=>j; 
        
    
    (60.0/bpm/beats)::second=>now;
}

