#!/usr/bin/python
# 151001 WCL: script to edit Neuroconstruct generated hoc code for NEURON
# to simulate ORN to PN inputs from CATMAID EM reconstructions

import fileinput
import re
import sys

tD = 200		# fixed delay between start times (msec)
t = 100			# first start time
 
for line in fileinput.input(inplace=1, backup='.bak'):
    if 'spikesource_' in line and '.number = 200.0' in line: 	# in lines with
# change number to 1.0
        line = re.sub(r'.number = 200.0', r'.number = 1.0\n', line.rstrip())
        sys.stdout.write(line)

    elif 'spikesource_' in line and '.noise = 1.0' in line: 	# in lines with
# change noise to 0.0
        line = re.sub(r'.noise = 1.0', r'.noise = 0.0\n', line.rstrip())
        sys.stdout.write(line)

    elif 'spikesource_' in line and '.start = 0' in line: 	# in lines with
# match skelIDnum, remove bracket to bracket, and add code snippet
# change start to increment
        line = re.sub(r'.start = 0', r'.start = '+str(t)+'\n', line.rstrip())
        sys.stdout.write(line)
        t = t +tD	# add delay for next ORN start time

# delete spike source intervals
    elif not re.match(r'spikesource_\d*\[\d*\].interval = 50.0',line):   # removing lines with
#        print "MATCH\n",
        sys.stdout.write(line)

# TODO: delete '//  NOTE: This is a very rough way to get an average rate of 0.02 kHz!!!'
#    elif not re.match(r'\/\/.*NOTE.*kHz.*',line):   # removing lines with
#        sys.stdout.write(line)
#    else:
#        sys.stdout.write(line)

# TODO: output list of skeletonIDs corresponding to stimuli