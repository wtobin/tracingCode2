#!/usr/bin/python
# 151001 WCL: script to edit Neuroconstruct generated hoc code for NEURON
# to simulate ORN to PN inputs from CATMAID EM reconstructions

import fileinput
import re
import sys

svn = 0			# increments to total number of synapses

# TODO: add svPath variable

svPath = '/home/william/nC_projects/'+str(sys.argv[2])+'/spikeVectors/'

for line in fileinput.input(sys.argv[1], inplace=1, backup='.bak'):

    if 'objref spikesource_' in line: 	# in lines with
# match skelIDnum
        line = re.sub(r'objref spikesource_(.*)\[n_(.*)\]', r'objref vecFile_\1[n_\2]\nobjref stimVec_\1[n_\2]\n\nobjref spikesource_\1[n_\2]\n', line.rstrip())
        sys.stdout.write(line)

    elif 'spikesource_' in line and 'new NetStim' in line: 	# in lines with
# match and add code snippet
        line = re.sub(r'spikesource_(\d*)\[(\d*)\] = new NetStim\((.*)\)', r'\nvecFile_\1[\2] = new File()\nvecFile_\1[\2].ropen("'+str(svPath)+'spikeVector'+str(svn)+r'.txt")\nstimVec_\1[\2] = new Vector()\nstimVec_\1[\2].scanf(vecFile_\1[\2])\nvecFile_\1[\2].close()\n\nspikesource_\1[\2] = new VecStim(\3)\nspikesource_\1[\2].play(stimVec_\1[\2])\n', line.rstrip())
        sys.stdout.write(line)
        svn = svn + 1	# increment synapse number

    elif 'tstop = 100.0' in line: 	# in lines with
# change tstop to to 1 sec
        line = re.sub(r'tstop = 100.0', r'tstop = 1000.0\n', line.rstrip())
        sys.stdout.write(line)
    
   # delete following lines
    elif re.match(r'spikesource_\d*\[\d*\]\.number = 200.0',line):   # removing lines withq
        pass
    elif re.match(r'spikesource_\d*\[\d*\]\.interval = 50.0',line):   # removing lines with
        pass
    elif re.match(r'spikesource_\d*\[\d*\]\.noise = 1.0',line):   # removing lines with
        pass
    elif re.match(r'spikesource_\d*\[\d*\]\.start = 0',line):   # removing lines with
        pass
    else:
        sys.stdout.write(line)


