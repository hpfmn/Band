import time
import rtmidi

fm8_out = rtmidi.MidiOut()
pianoteq_out = rtmidi.MidiOut()
massive_out = rtmidi.MidiOut()
kontakt_out = rtmidi.MidiOut()
absynth_out = rtmidi.MidiOut()


fm8_out.open_port(0)
pianoteq_out.open_port(1)
massive_out.open_port(2)
kontakt_out.open_port(3)
absynth_out.open_port(4)

piano_out_no = 0

def piano_cb(msg, state):
    global piano_out_no
    global fm8_out
    global pianoteq_out
    global massive_out
    global kontakt_out
    global absynth_out
    event=msg[0]
    if (piano_out_no == 0):
        fm8_out.send_message(event)
    if (piano_out_no == 1):
        pianoteq_out.send_message(event)
    if (piano_out_no == 2):
        massive_out.send_message(event)
    if (piano_out_no == 3):
        kontakt_out.send_message(event)
    if (piano_out_no == 4):
        absynth_out.send_message(event)

def controller_cb(msg, state):
    global piano_out_no
    global fm8_out
    global pianoteq_out
    global massive_out
    global kontakt_out
    global absynth_out
    event=msg[0]
    if (event[0] == 196):
        piano_out_no=event[1]
    else:
        if((event[0] % 16) == 0):
            fm8_out.send_message(event)
        if((event[0] % 16) == 1):
            pianoteq_out.send_message(event)
        if((event[0] % 16) == 2):
            massive_out.send_message(event)
        if((event[0] % 16) == 3):
            kontakt_out.send_message(event)
        if((event[0] % 16) == 4):
            absynth_out.send_message(event)

keystation_1_in = rtmidi.MidiIn()
keystation_2_in = rtmidi.MidiIn()

keystation_1_in.open_port(5) # Look for actual ports later
keystation_2_in.open_port(6)

keystation_1_in.set_callback(controller_cb)
keystation_2_in.set_callback(piano_cb)

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print('exeting...')
finally:
    # close and delete outputs
    fm8_out.close_port()
    pianoteq_out.close_port()
    massive_out.close_port()
    kontakt_out.close_port()
    absynth_out.close_port()
    del fm8_out
    del pianoteq_out
    del massive_out 
    del kontakt_out 
    del absynth_out 

    # close and delete inputs
    keystation_1_in.close_port()
    keystation_2_in.close_port()

    del keystation_1_in
    del keystation_2_in
