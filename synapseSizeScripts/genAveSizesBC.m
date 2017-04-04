load('biasCorrSizes.mat')

aveSizesBC=[]; 
CVs=[];

%loop over orns
for o=1:10
    
    for p=1:5
        
        pool=[];
        for u=1:4
            
            pool(u,:,:,:,:)=biasCorrSizes{o,p,u};
            
        end
        
        aveSizesBC{o,p}=squeeze(nanmean(pool,1));
        
        
    end
end

size(aveSizesBC{o,p})

save('aveSizesBC','aveSizesBC')