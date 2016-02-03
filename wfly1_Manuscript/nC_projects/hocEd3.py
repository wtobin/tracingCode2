#!/usr/bin/python
# 151001 WCL: script to edit Neuroconstruct generated hoc code for NEURON
# to simulate ORN to PN inputs from CATMAID EM reconstructions

import fileinput
import re
import sys

tD = 200		# fixed delay between start times (msec)
t = 100			# first start time
 
for line in fileinput.input(inplace=1, backup='.bak'):
    if 'objref spikesource_' in line: 	# in lines with
# match skelIDnum, remove bracket to bracket, and add code snippet
        line = re.sub(r'\[n_(.*)\]', r'\n\nspikesource_\1 = new NetStim()\nspikesource_\1.number = 1.0\nspikesource_\1.noise = 0.0\nspikesource_\1.start = '+str(t)+'\n', line.rstrip())
        sys.stdout.write(line)
        t = t +tD	# add delay for next ORN start time

# remove synapse point array indices [\d]
#    elif 'connection_' in line: 	# in lines with
    elif 'connection_' in line and 'new NetCon' in line: 	# in lines with
        line = re.sub(r'spikesource_(\d*)\[\d*\]', r'spikesource_\1', line.rstrip())
        sys.stdout.write(line)

# delete [independent] spike source lines 
    elif not re.match(r'spikesource_\d*\[\d*\].*',line):   # removing lines with
#        print "MATCH\n",
        sys.stdout.write(line)

# TODO: delete '//  NOTE: This is a very rough way to get an average rate of 0.02 kHz!!!'
#    elif not re.match(r'\/\/.*NOTE.*kHz.*',line):   # removing lines with
#        sys.stdout.write(line)
#    else:
#        sys.stdout.write(line)

# TODO: output list of skeletonIDs corresponding to stimuli
