load('elementSizes.mat')

aveSizes=[]; 

%loop over orns
for o=1:10
    
    for p=1:5
        
        pool=[];
        for u=1:4
            
            pool(u,:,:)=elementSizes{o,p,u}(:,1:2);
            
        end
        aveSizes{o,p}=squeeze(nanmean(pool,1));
    end
end

size(aveSizes{o,p})

save('aveSizes','aveSizes')