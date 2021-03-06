%Load synaptic element size data
cd ~/Documents/MATLAB/tracingCode2/synapseSizeScripts/
load elementSizes.mat

%Compute the ratio of average measurements over all commonly segmented
%synapses for each pair of tracers

tracers=1:4;
allPairs=nchoosek(tracers,2);

aveRatios=zeros(size(allPairs));
numSharedSyns=zeros(6,1);

for pair=1:size(allPairs,1)
    
    t1TbarPool=[];
    t2TbarPool=[];
    
    t1PNPool=[];
    t2PNPool=[];
    
    shared=0;
    for o=1:10
        for p=1:5
            
            t1Seg=elementSizes{o,p,allPairs(pair,1)};
            t2Seg=elementSizes{o,p,allPairs(pair,2)};
            
            for s=1:size(t1Seg,1)
                if isnan(t1Seg(s,1)) == 0 && isnan(t2Seg(s,1))==0
                    
                    t1TbarPool=[t1TbarPool,t1Seg(s,1)];
                    t2TbarPool=[t2TbarPool,t2Seg(s,1)];
                    
                    t1PNPool=[t1PNPool,t1Seg(s,2)];
                    t2PNPool=[t2PNPool,t2Seg(s,2)];
                    
                    shared=shared+1;
                    
                else
                    
                end
                
            end
        end
    end
    
    aveRatios(pair,1)=mean(t2TbarPool)/mean(t1TbarPool);
    aveRatios(pair,2)=mean(t2PNPool)/mean(t1PNPool);
    
    numSharedSyns(pair)=shared;
    
end

%Re-express ratios in terms of tracer 1
aveTbarRatios_relT1=NaN(3,4);

%Tracer 1 comparison
aveTbarRatios_relT1(:,1)=aveRatios(1:3,1);

%Tracer 2 comparison
aveTbarRatios_relT1(2,2)=aveRatios(1,1)*aveRatios(4,1);
aveTbarRatios_relT1(3,2)=aveRatios(1,1)*aveRatios(5,1);

%Tracer 3 comparison
aveTbarRatios_relT1(1,3)=aveRatios(2,1)*aveRatios(4,1);
aveTbarRatios_relT1(3,3)=aveRatios(2,1)*(1/aveRatios(4,1));

%Tracer 4 comparison
aveTbarRatios_relT1(1,4)=aveRatios(3,1)*(1/aveRatios(5,1));
aveTbarRatios_relT1(2,4)=aveRatios(3,1)*(1/aveRatios(6,1));


%Re-express ratios in terms of tracer 1
avePNRatios_relT1=NaN(3,4);

%Tracer 1 comparison
avePNRatios_relT1(:,1)=aveRatios(1:3,2);

%Tracer 2 comparison
avePNRatios_relT1(2,2)=aveRatios(1,2)*aveRatios(4,2);
avePNRatios_relT1(3,2)=aveRatios(1,2)*aveRatios(5,2);

%Tracer 3 comparison
avePNRatios_relT1(1,3)=aveRatios(2,2)*aveRatios(4,2);
avePNRatios_relT1(3,3)=aveRatios(2,2)*(1/aveRatios(4,2));

%Tracer 4 comparison
avePNRatios_relT1(1,4)=aveRatios(3,2)*(1/aveRatios(5,2));
avePNRatios_relT1(2,4)=aveRatios(3,2)*(1/aveRatios(6,2));

%Average these values to get a bias factor relative to tracer 1
tbarBias=[1;nanmean(aveTbarRatios_relT1,2)];
pnBias=[1;nanmean(avePNRatios_relT1,2)];







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
                
            
                
                %Bias correct tbar vol and on area measurments
                biasCorrSizes{o,p,u}(s,1)=elementSizes{o,p,u}(s,1)/tbarBias(u);
                biasCorrSizes{o,p,u}(s,2)=elementSizes{o,p,u}(s,2)/pnBias(u);
                
                %store num post and num post PNs
                biasCorrSizes{o,p,u}(s,3)=elementSizes{o,p,u}(s,3);
                biasCorrSizes{o,p,u}(s,4)=elementSizes{o,p,u}(s,4);
                
            end
            
            
        end
        
    end
end


save('biasCorrSizes','biasCorrSizes')
