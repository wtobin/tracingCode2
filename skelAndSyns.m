function [ skelAndSyns ] = skelAndSyns( skelID, synType)
%This function accepts a single skeleton ID and returns a cell array with
%two fields. Field one is called skeleton and contains the xyz coordinates
%for the neuron. Field two is called synapses and contains the xyz
%coordinates, on the indicated skeleton, of either input or output
%synapses.


%Step one, import the skeleton and write the xyz skeleton coordinates to
%the array

cd('~/tracing');
skelFile=loadjson(strcat('skeletons/',num2str(skelID),'.json'), 'FastArrayParser', 1);



end

