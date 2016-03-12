//metronome

SndBuf w;
SndBuf s;

"data/metronome_click.wav" => w.read;
"data/sidestick.wav" => s.read;

//?w.samples => w.pos;
w => dac;

//s => dac;

0 => int i;
0 => int j;
[1,0,0] @=> int a[];
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
    if(i<(1*3))
    {
        if(a[j]==1)
        {
            0 => w.pos;
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
    
    if(j==3)
        0=>j; 
        
    
    (60.0/45/3)::second=>now;
}