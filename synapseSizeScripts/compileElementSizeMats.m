% This is a scrip to compile elementSizes matricies. I sorted postsynaptic
% PN segmentations at synapses where a single PN was reported to be
% postsynaptic twice by hand for each tracer. I saved the product of this
% sorting in a elementSize matrix for each tracer, Wei did tracer #1

%paths to the files I need
scriptDir='/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/';
synapseVolDir='/Users/williamtobin/Desktop/wfly1_synapseVols2/';

%initialize an array to store each tracers measurements 
elementSizes_comp={};

%Tracer 1
load([synapseVolDir,'tracer_1_elementSizes.mat'])
elementSizes_comp(:,:,1)=elementSizes(:,:,1);
clear elementSizes

%Tracer 2
load([synapseVolDir,'tracer_2_elementSizes.mat'])
elementSizes_comp(:,:,2)=elementSizes(:,:,2);
clear elementSizes

%Tracer 3
load([synapseVolDir,'tracer_3_elementSizes.mat'])
elementSizes_comp(:,:,3)=elementSizes(:,:,3);
clear elementSizes

%Tracer 4
load([synapseVolDir,'tracer_4_elementSizes.mat'])
elementSizes_comp(:,:,4)=elementSizes(:,:,4);
clear elementSizes

%save this compiled array
save([synapseVolDir,'elementSizes_comp.mat'],...
    'elementSizes_comp')