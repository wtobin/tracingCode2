% { What I want to do here is identify all synapses of the following types
% 
% ORN--> PN
% ORN--> LN
% ORN--> ORN
% 
% PN-->PN
% PN-->LN
% PN-->ORN
% 
% LN-->PN
% LN-->LN
% LN-->ORN
% 
% Then I need to count the number of postsynaptic elements at each of them

% Strategy for identifying ORNs, PNs and LNs

%% Load annotations and connectors

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

%exclude unilateral ORNs for now

ORNs_Right(find(ORNs_Right == 499879))=[];
ORNs_Left(find(ORNs_Left == 426230))=[];
ORNs_Left(find(ORNs_Left == 401378))=[];
% 
% %exclude ORN 8 because it was temporarily unilateral on 8/5 for testing 
% ORNs_Left(find(ORNs_Left == 593865))=[];

ORNs=[ORNs_Left, ORNs_Right];

%return all skeleton IDs of DM6 PNs
PNs=annotations.PN;

%return all LN skel IDs
LNs=annotations.LN;
LNs=[LNs, annotations.potential_0x20_LN];
LNs=[LNs, annotations.Prospective_0x20_LN];
LNs=[LNs, annotations.Likely_0x20_LN];


%Load the connector structure
load('~/tracing/conns.mat')

%gen conn fieldname list
connFields=fieldnames(conns);

% 
% prod=[];
% 
% for i=1:length(annFields)
%     
%     if isempty(findstr('LN',cell2mat(annFields(i)))) == 0
%         
%         prod=[prod i];
%     else
%     end
% end
     

% find ORN--> PN synapses, count post profiles


% Loop over L ORNs
for o=1:length(ORNs_Left)
    
synCounter=0;

%loop over all connectors
for i= 1 : length(connFields)
    
    %Make sure the connector doesnt have an empty presynaptic field
    if isempty(conns.(cell2mat(connFields(i))).pre) == 1
        
    else
        
        %Check to see if the working skel is presynaptic at this connector
        if conns.(cell2mat(connFields(i))).pre == ORNs_Left(o)


                synCounter=synCounter+1;
                
          
        else
        end
    end
end

sumLeftORNOuts(o)=synCounter;

end


        
        
