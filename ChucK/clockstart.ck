// MidiClock
MidiOut mout1;
MidiMsg msg1;
if( !mout1.open( "IAC-Treiber MidiClock" ) ) me.exit(); 
250 => msg1.data1; // 252 would be stop, 251 continue
0 => msg1.data2;
0 => msg1.data3;
mout1.send(msg1);
1::second => now;