%loop over L then R ORN spike increments
for s=1:2
    
    incCounter=1;
for d=[12:15]
    
 
    
    %loop over trials
    for t=1:5000
        tic
        %loop over PNs, loading all
        for p=1:5
            
            
            pn=PN_Names{p};
            base=['/home/simulation/nC_projects/',pn,'_allORNs/simulations/latTask/results_fixedSpikeCount/'];
            
            
            if s==1
            resultFiles=dir([base,'real_L',num2str(d),'_R12_rep*']);
            else
            resultFiles=dir([base,'real_L12_R',num2str(d),'_rep*']);   
            end
            dataFileName=ls([base,resultFiles(1).name]);
            dataFileName=strtrim(dataFileName(1:29));
            
            load([base,resultFiles(t).name,'/spikeTimesL.mat']);
            load([base,resultFiles(t).name,'/spikeTimesR.mat']);
            pnvm=importdata([base,resultFiles(t).name, '/',dataFileName]);
            
            
            indSum=0;
            spikeCounter=0;
            
            %Loop over left ORNs
            for o=1:length(ORNs_Left)
                
                if sum(find(leftUEPSPs_idList{p}==ORNs_Left(o))) ==0
                else
                
                
                %How many spikes did this ORN fire in this trial?
                numspikes=numel(spikeTimesL{o});
                
                % If it fired at all
                if numspikes ~= 0
                    
                    %Pull the UEPSP trace that this ORN drives in this PN
                    uEPSP_working=leftUEPSPs{p}(find(leftUEPSPs_idList{p}==ORNs_Left(o)),:);
                    
                    %Sum the uEPSP voltage deflection and add it to our
                    %running tally for this PN & trial
                    
                    indSum=indSum+sum(uEPSP_working+59.3999)*numspikes;
                    spikeCounter=spikeCounter+numspikes;
                    
                else
                end
                end
            end
            
            
            %Now go through and do the same thing for R ORNs
            for o=1:length(ORNs_Right)
                
                if sum(find(rightUEPSPs_idList{p}==ORNs_Right(o)))==0
                else
                
                numspikes=numel(spikeTimesR{o});
                
                if numspikes ~= 0
                    
                    uEPSP_working=rightUEPSPs{p}(find(rightUEPSPs_idList{p}==ORNs_Right(o)),:);
                    indSum=indSum+sum(uEPSP_working+59.3999)*numspikes;
                    spikeCounter=spikeCounter+numspikes;
                    
                else
                end
                end
            end
            
            
           linearityRatios(s,incCounter,t,p)=sum(pnvm+59.3999)/indSum;
           spikesReceived(p,t)=spikeCounter;
           sumDepol(s,incCounter,t,p)=sum(pnvm+59.3999);
           indSums(s,incCounter,t,p)=indSum;
       
            
            
        end
        toc
    end
    
    incCounter=incCounter+1;
    
end
end




for s=1:2
    figure()
    set(gcf, 'Color','w')
    
   for i=1:4
       subplot(2,2,i)
       histogram(linearityRatios(s,i,:,1:3))
       hold on
      histogram(linearityRatios(s,i,:,4:5))
      
   end
   
end






