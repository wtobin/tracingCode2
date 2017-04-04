%Load the cell array contianing the tracer averaged, bias corrected tbar vol and pn area measurments
load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/aveSizesBC.mat'

%Load the cell array containing connector IDs for each ORN/PN pair in the
%mat loaded above
load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/segIDs.mat'

%sort measurments ipsi/contra syns
tbarVols=[];
pnAreas=[];

connsIncluded={};


for o=1:10
    
    for p=1:5
        
        for s=1:size(aveSizesBC{o,p},1)
            
            %Check to see if this tbar was recorded as part of another
            %connection
            if ismember(segIDs{o,p,1}(s),connsIncluded) == 0
                
                tbarVols=[tbarVols, aveSizesBC{o,p}(s,1)];
                connsIncluded=[connsIncluded;segIDs{o,p,1}(s)];
               
            else
                
            end
            
            pnAreas=[pnAreas, aveSizesBC{o,p}(s,2)];
            
        end
        
    end
    
end

std(tbarVols)/mean(tbarVols)
std(pnAreas)/mean(pnAreas)
