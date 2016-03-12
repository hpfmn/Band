MidiIn min1;
MidiIn min2;
MidiIn min3;
MidiIn min4;
MidiOut mout1;
MidiOut mout2;
MidiOut mout3;
MidiOut mout4;
MidiOut mout5;

MidiMsg msg1;
MidiMsg msg2;

int i;
1 =>i;
0 => int start;
//Midi-Inputs
if( !min1.open( "Euphonix MIDI Euphonix Port 1" ) ) me.exit(); //Korg nano Pad
if( !min2.open( "Euphonix MIDI Euphonix Port 2" ) ) me.exit(); //Korg nano Pad
if( !min3.open( "Euphonix MIDI Euphonix Port 3" ) ) me.exit(); //Korg nano Pad
if( !min4.open( "Euphonix MIDI Euphonix Port 4" ) ) me.exit(); //Korg nano Pad


//Midi-Outputs
if( !mout1.open( "IAC-Treiber FM8" ) ) me.exit();
if( !mout2.open( 1 ) ) me.exit();
if( !mout3.open( 2 ) ) me.exit();
if( !mout4.open( 3 ) ) me.exit();
if( !mout5.open( 4 ) ) me.exit();

while(true)
{
    min1 => now;
    while( min1.recv(msg1))
    {
        // If we Receive a Pitchbend on Chan 1 (First Fader)
        // Translate to CC1
        if (msg1.data1==224) {
            176 => msg2.data1;
            1 => msg2.data2;
            msg1.data3 => msg2.data3;
            mout1.send(msg2);
        }
    }
}