MidiIn min1;
MidiMsg msg1;

if( !min1.open( "Teensy MIDI MIDI 1" ) ) me.exit(); //Korg nano Pad

while(true)
{
    min1 => now;
    while(min1.recv(msg1))
    {
        <<<msg1.data1, msg1.data2, msg1.data3>>>;
    }
}
