#!/usr/bin/python
# -*- coding: utf-8 -*-
# Plays a 440.0 Hz test tone for 3 seconds to alsa_pcm:playback_1.
#
# Copyright 2003, Andrew W. Schmeder
# This source code is released under the terms of the GNU Public License.
# See LICENSE for the full text of these terms.

import numpy
import jack
import pysoundfile
import time

jack.attach("pymetro")
jack.register_port("out_1", jack.IsOutput)
jack.register_port("in_1", jack.IsInput)
jack.activate()
#print(jack.get_ports())
jack.connect("pymetro:out_1", "system:playback_1")
jack.connect("pymetro:out_1", "system:playback_2")

N = jack.get_buffer_size()
Sr = float(jack.get_sample_rate())

output_file = pysoundfile.SoundFile('MetronomeUp.wav')
output = output_file.read()
output = 0.225*output/numpy.max(output)

print(output.shape)
input = numpy.zeros((1,N), 'f')
print(N)
print(output.transpose().shape)
output=output.transpose()
output=output[0]
#clickdur=len(output)/float(Sr)
#dur=60.0/120
#pausedur=dur-clickdur
raster=[1]
samples_to_next_click=int((60/(75.0*len(raster))) * Sr)

out_buffer=numpy.zeros((1,N),'f')
#while i < output.shape[1] - N:
#    try:
#        jack.process(output[:,i:i+N], input)
#        print(i)
#        i += N
#    except jack.InputSyncError:
#        pass
#    except jack.OutputSyncError:
#        pass
i = float(0)
start=0
output_start=0
play_click=False
clicks_played=0
r=-1
try:
    while True:
        try:
            out_buffer=numpy.zeros((1,N),'f')
            if ((i+N)>=clicks_played*samples_to_next_click):
                #i=i-samples_to_next_click
                r+=1
                if r==len(raster):
                    r=0
                if raster[r]:
                    start=N-(i+N-(clicks_played*samples_to_next_click))
                    play_click=True
                    output_start=0
                clicks_played+=1
            if (play_click):
                ende=output_start+N-start
                buffer_ende=N
                if ende>=len(output):
                    ende=len(output)
                    buffer_ende=ende-output_start
                    play_click=False
                out_buffer[0,start:buffer_ende]=output[output_start:ende]
                output_start=ende+1
                start=0
            jack.process(out_buffer, input)
            #output_start+=float(N)
            i += N
        except jack.InputSyncError:
            pass
        except jack.OutputSyncError:
            pass
except KeyboardInterrupt:
    print('exeting...')
finally:
    jack.deactivate() 
    jack.detach()

print(output.shape)

#try:
#    while True:
#        i = 0
#        while i < output.shape[1] - N:
#            try:
#                jack.process(output[:,i:i+N], input)
#                i += N
#                print("bla")
#            except jack.InputSyncError:
#                pass
#            except jack.OutputSyncError:
#                pass
#except KeyboardInterrupt:
#    print('exeting...')
#finally:
#    jack.deactivate() 
#    jack.detach()
