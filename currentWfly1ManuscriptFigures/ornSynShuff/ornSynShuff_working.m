PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};


for p=1:numel(PN_Names)
    
    
    % Load annotations json. Generated by Wei's code gen_annotation_map.py
    annotations=loadjson('~/tracing/sid_by_annotation.json');
    
    %Load ipsi ORN skel IDs
    if strcmp(PN, 'PN1RS') ==1  || strcmp(PN, 'PN2RS') ==1
        % Return all skeleton IDs for R and L ORNs
        ipsiORNs=annotations.Right_0x20_ORN;
    else
        % Return all skeleton IDs for R and L ORNs
        ipsiORNs=annotations.Left_0x20_ORN;
    end
    
    
    activeSyns=pullContactNums(ipsiORNs,['~/nC_projects/',PN_Names{p},'_allORNs/simulations/shuffUnitaries/'],[PN_Names{p},'_allORNs.hoc']);
    
    
    for o=1:numel(unique(activeSyns(:,2)))
        
        miniPerUni(o)=sum(activeSyns(:,2)==o);
        %
        %     miniNums{o}=[sum(activeSyns(:,2)<=o)-sum(activeSyns(:,2)==o)+1:sum(activeSyns(:,2)<=o)];
        %
    end
    %
    resultDirs=dir('~/nC_projects/PN1LS_allORNs/simulations/shuffUnitaries/results/');
    
    counter=1;
    
    %Loop over all repetitions of the simulation
    
    for r=3:length(resultDirs)
        
        tic
        %Load the uni data
        unitaries=load(['~/nC_projects/PN1LS_allORNs/simulations/shuffUnitaries/results/',resultDirs(r).name,'/neuron_PN1_LS_sk_419138_0.dat']);
        
        %load the mini results, ordering them
        
        miniFiles=dir(['~/nC_projects/PN1LS_allORNs/simulations/shuffUnitaries/results/',resultDirs(r).name,'/minis/mini*.dat']);
        
        for i=1:length(miniFiles)
            
            minis(i,:)=load(['~/nC_projects/PN1LS_allORNs/simulations/shuffUnitaries/results/',resultDirs(r).name,'/minis/',miniFiles(i).name]);
            
        end
        
        
        %Loop over ORNs
        for o=1:27
            
            workingUni=unitaries([(o-1)*8000:o*8000]+3600);
            uniAmps(counter,o)=max(workingUni)+60;
            uniArea(counter,o)=sum(workingUni+60);
            
            
            %Loop over minis
            for m=1:miniPerUni(o)
                
                
                
                miniAmps{counter,o}(m)=max(minis(miniNums{o}(m),:))+60;
                miniArea{counter,o}(m)=sum(minis(miniNums{o}(m),:)+60);
                
                
            end
            
            meanMiniAmps(counter,o)=mean(miniAmps{counter,o}(:));
            summEff(counter,o)=uniArea(counter,o)/sum(miniArea{counter,o}(:));
            
        end
        
        counter=counter+1;
        toc
    end
    
    
    for i=1:1000
        
        cvMeanMini(i)=std(meanMiniAmps(i,:))/mean(meanMiniAmps(i,:));
        cvSummEff(i)=std(summEff(i,:))/mean(summEff(i,:));
        
    end
    
    
    
end