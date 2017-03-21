%Repeat bias factor determination using different tracers as reference,
%collect bias correction factors

for t=1:4
    
    tbarBiasPool=[];
    pnAreaBiasPool=[];
    synapseCounter=1;
    
    %loop over orns
    for o=1:10
        
        %loop over PNs
        for p=1:5
            
            %Look at tracer 1s seg simply to find # of syns at this connection
            seg=elementSizes{o,p,1};
            
            %Loop over synapses
            for s=1:size(seg,1)
                
                %Loop over users
                for u=1:4
                    
                    tbarBiasPool(synapseCounter,u)=elementSizes{o,p,u}(s,1)/...
                        elementSizes{o,p,t}(s,1);
                    pnAreaBiasPool(synapseCounter,u)=elementSizes{o,p,u}(s,2)/...
                        elementSizes{o,p,t}(s,2);
                    
                end
                
                synapseCounter=synapseCounter+1;
                
            end
            
        end
    end
    
    tbarBias=nanmedian(tbarBiasPool);
    
    for u=1:4
        
        pnAreaBias(t,u)=median(pnAreaBiasPool(isfinite(pnAreaBiasPool(:,u)),u));
        
    end
    
    
end


%Now Loop over the data again, multiply by user bias value and store again



biasCorrSizes=cell(10,5,4);


%loop over orns
for o=1:10
    
    %loop over PNs
    for p=1:5
        
        %Look at tracer 1s seg simply to find # of syns at this connection
        seg=elementSizes{o,p,1};
        
        %Loop over synapses
        for s=1:size(seg,1)
            
            %Loop over users
            for u=1:4
                
                corrTs=[];
                corrPs=[];
                
                %Loop over 
                for b=1:4
                    
                    corrTs(b)= elementSizes{o,p,u}(s,1)/tbarBias(b,u);
                   
                    
                end
                
                %Bias correct tbar vol and on area measurments
                biasCorrSizes{o,p,u}(s,1)=elementSizes{o,p,u}(s,1)/tbarBias(u);
                biasCorrSizes{o,p,u}(s,2)=elementSizes{o,p,u}(s,2)/pnAreaBias(u);
                
                %store num post and num post PNs
                biasCorrSizes{o,p,u}(s,3)=elementSizes{o,p,u}(s,3);
                biasCorrSizes{o,p,u}(s,4)=elementSizes{o,p,u}(s,4);
                
            end
            
            
        end
        
    end
end


save('biasCorrSizes','biasCorrSizes')
