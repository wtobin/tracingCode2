
load('/Users/williamtobin/Desktop/wfly1_synapseVols2/elementSizes_comp.mat')

counter=0;

for o=1:10
    for p=1:5
        for u=1:4
            
            connArray=elementSizes_comp{o,p,u};
            
            for s=1:size(connArray,1)
                
                if isnan(connArray(s,2))==1 && isnan(connArray(s,1))==0
                    counter=counter+1
                else
                end
                
            end
        end
    end
end

