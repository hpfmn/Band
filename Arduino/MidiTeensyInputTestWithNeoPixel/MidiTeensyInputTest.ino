/* MIDI Input Test - for use with Teensy or boards where Serial is separate from MIDI
 * As MIDI messages arrive, they are printed to the Arduino Serial Monitor.
 *
 * Where MIDI is on "Serial", eg Arduino Duemilanove or Arduino Uno, this does not work!
 *
 * This example code is released into the public domain.
 */
 
#include <MIDI.h>
#include <Adafruit_NeoPixel.h>

#define PIN 6
#define PIXELS 60

int KeyOffs[PIXELS];

Adafruit_NeoPixel strip = Adafruit_NeoPixel(PIXELS, PIN, NEO_GRB + NEO_KHZ800);

int pedalDown = 0;

void setup() {
  MIDI.begin(MIDI_CHANNEL_OMNI);
  Serial.begin(57600);
  Serial.println("MIDI Input Test");
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
  strip.setBrightness(50);
  for(int i=0;i<PIXELS;i++)
  {
    KeyOffs[i]=0;
  }
}

unsigned long t=0;

void loop() {
  int type, note, velocity, channel, d1, d2, value, control;
  if (MIDI.read()) {                    // Is there a MIDI message incoming ?
    byte type = MIDI.getType();
    switch (type) {
      case NoteOn:
        note = MIDI.getData1();
        velocity = MIDI.getData2();
        channel = MIDI.getChannel();
        usbMIDI.sendNoteOn(note,velocity,channel);
        if (velocity > 0) {
          Serial.println(String("Note On:  ch=") + channel + ", note=" + note + ", velocity=" + velocity);
          strip.setPixelColor(60-((note-20)*0.68), strip.Color(random(256),random(256),random(256)));
        } else {
          Serial.println(String("Note Off: ch=") + channel + ", note=" + note);
          if(!pedalDown)
          {
            strip.setPixelColor(60-((note-20)*0.68), strip.Color(0,0,0));
          }
          else
          {
            int noteToPixel = 60-((note-20)*0.68);
            KeyOffs[noteToPixel] = 1;
          }
        }
        break;
      case NoteOff:
        note = MIDI.getData1();
        velocity = MIDI.getData2();
        channel = MIDI.getChannel();
        strip.setPixelColor(60-((note-20) * 0.68), strip.Color(0,0,0));
        usbMIDI.sendNoteOff(note,velocity,channel);
        Serial.println(String("Note Off: ch=") + channel + ", note=" + note + ", velocity=" + velocity);
        break;
      case ControlChange:
        control = MIDI.getData1();
        value = MIDI.getData2();
        channel = MIDI.getChannel();
        usbMIDI.sendControlChange(control, value, channel);
        if(control==64 && value==127)
        {
          pedalDown=1;
        }
        if(control==64 && value==0)
        {
          pedalDown=0;
          for(int i=0;i<PIXELS;i++)
          {
            if(KeyOffs[i])
            {
              strip.setPixelColor(i,strip.Color(0,0,0));
              KeyOffs[i]=0;
            }
          }
        }
        Serial.println(String("Control Change ") + control + ", val=" + value  + ", ch=" +  channel);
      break;
      default:
        d1 = MIDI.getData1();
        d2 = MIDI.getData2();
        Serial.println(String("Message, type=") + type + ", data = " + d1 + " " + d2);
    }
    strip.show();
    t = millis();
  }
  if (millis() - t > 10000) {
    t += 10000;
    Serial.println("(inactivity)");
  }
}
