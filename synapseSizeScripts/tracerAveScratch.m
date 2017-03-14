%{
relies on downloading data to the local machine and running
pullSynapseSizeData_rough first.

Also, assumes averaging across users has occured
%}


%% Ipsi Contra Tbar size 



f1=figure();
f2=figure();


    
    ipsiTbarVol=[];
    contraTbarVol=[];
    
    ipsiPost=[];
    contraPost=[];
    
    
    for o=1:10
        
       
     
            for p=1:5
                
                
                
            
                    if o<=5 && ismember(p,[1,2,5])==1
                        
                        ipsiTbarVol=[ipsiTbarVol;aveSizes{o,p}(:,1)];
                        ipsiPost=[ipsiPost;;aveSizes{o,p}(:,2)];
                        
                    elseif o<=5 && ismember(p,[1,2,5])==0
                        
                        contraTbarVol=[contraTbarVol;aveSizes{o,p}(:,1)];
                        contraPost=[contraPost;aveSizes{o,p}(:,2)];
                        
                    elseif o>5 && ismember(p,[1,2,5])==1
                        
                        contraTbarVol=[contraTbarVol;aveSizes{o,p}(:,1)];
                        contraPost=[contraPost;aveSizes{o,p}(:,2)];
                        
                    elseif o>5 && ismember(p,[1,2,5])==0
                        
                        ipsiTbarVol=[ipsiTbarVol;aveSizes{o,p}(:,1)];
                        ipsiPost=[ipsiPost;aveSizes{o,p}(:,2)];
                    end
                end
            end
  
    figure(f1)
    
    [p,h]=ranksum(ipsiTbarVol,contraTbarVol);
  
    histogram(ipsiTbarVol,30)
    hold on
    histogram(contraTbarVol,30)
    title(['Wilcoxon rank sum p: ',num2str(p)])
    xlabel('Tbar Vol (nm^3)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Ipsilateral Tbars';'Contralateral Tbars'})
    
    %Some boxplotting
    forBoxplot=[[ipsiTbarVol;contraTbarVol],[zeros(length(ipsiTbarVol),1);ones(length(contraTbarVol),1)]];
    
    figure()
    boxplot(forBoxplot(:,1),forBoxplot(:,2),...
        'Labels',{'Ipsi Tbar Vols','Contra Tbar Vols'},'Notch','on','FontSize',14)
    ylabel('Tbar Vol (nm^3)','FontSize',14)
    
    
    
    
    [p,h]=ranksum(ipsiPost,contraPost);
    figure(f2)
 
    histogram(ipsiPost,30)
    hold on
    histogram(contraPost,30)
    %xlim([0 500])
    title(['Wilcoxon rank sum p: ',num2str(p)])
    xlabel('Postsynaptic PN membrane area (nm^2)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Ipsilateral PNs';'Contralateral PNs'})
    


%% Some sorting left/right


f1=figure();
f2=figure();


rightTbarVol=[];
leftTbarVol=[];
tbarNums=[];

rightPost=[];
leftPost=[];
postNums=[];

for o=1:10
           
        for p=1:5
          
                
                if ismember(p,[1,2,5])==1
                    
                    leftTbarVol=[leftTbarVol;aveSizes{o,p}(:,1)];
                    leftPost=[leftPost;aveSizes{o,p}(:,2)];
                    
                elseif ismember(p,[3,4])==1
                    
                    rightTbarVol=[rightTbarVol;aveSizes{o,p}(:,1)];
                    rightPost=[rightPost;aveSizes{o,p}(:,2)];

                end
            end
        end

    [p,h]=ranksum(leftTbarVol,rightTbarVol);
    figure(f1)
    histogram(rightTbarVol,30)
       hold on
    histogram(leftTbarVol,30)
    title(['Wilcoxon rank sum p: ',num2str(p)])
    xlabel('Tbar Vol (nm^3)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Right Tbars';'Left Tbars'})
    
    [p,h]=ranksum(leftPost,rightPost);
    figure(f2)
    histogram(rightPost,30)
    hold on
    histogram(leftPost,30)
    %xlim([0 500])
    title(['Wilcoxon rank sum p: ',num2str(p)])
    xlabel('Postsynaptic PN membrane area (nm^2)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Right PNs';'Left PNs'})
    





%% Some sorting ipsi contra

ipsiTbarVolMeans=[];
contraTbarVolMeans=[];
ipsiTbarNums=[];


ipsiPostMeans=[];
contraPostMeans=[];
contraTbarNums=[];

for o=1:10
    
    
    
        
        for p=1:5
            
        
           
                if o<=5 && ismember(p,[1,2,5])==1
                    
                    ipsiTbarVolMeans=[ipsiTbarVolMeans;mean(aveSizes{o,p}(:,1))];
                    ipsiPostMeans=[ipsiPostMeans;mean(aveSizes{o,p}(:,2))];
                    ipsiTbarNums=[ipsiTbarNums,numel(aveSizes{o,p}(:,1))]
                    
                elseif o<=5 && ismember(p,[1,2,5])==0
                    
                    contraTbarVolMeans=[contraTbarVolMeans;mean(aveSizes{o,p}(:,1))];
                    contraPostMeans=[contraPostMeans;mean(aveSizes{o,p}(:,2))];
                    contraTbarNums=[contraTbarNums,numel(aveSizes{o,p}(:,1))];
                    
                elseif o>5 && ismember(p,[1,2,5])==1
                    
                    contraTbarVolMeans=[contraTbarVolMeans;mean(aveSizes{o,p}(:,1))];
                    contraPostMeans=[contraPostMeans;mean(aveSizes{o,p}(:,2))];
                    contraTbarNums=[contraTbarNums,numel(aveSizes{o,p}(:,1))];
                    
                elseif o>5 && ismember(p,[1,2,5]) == 0
                    
                    ipsiTbarVolMeans=[ipsiTbarVolMeans;mean(aveSizes{o,p}(:,1))];
                    ipsiPostMeans=[ipsiPostMeans;mean(aveSizes{o,p}(:,2))];
                    ipsiTbarNums=[ipsiTbarNums,numel(aveSizes{o,p}(:,1))]
                end
            end
        end


CV_tbar=std(ipsiTbarVolMeans)/mean(ipsiTbarVolMeans);
CV_post=std(ipsiPostMeans)/mean(ipsiPostMeans);


figure()
scatter(ipsiTbarVolMeans,ipsiTbarNums)
title(['Pearsons Corr:',num2str(rho),' P Value: ',num2str(pval)])
xlabel('Ipsi Connection Mean Tbar Vol (nm^3)','FontSize',14)
ylabel('Syns per Connection','FontSize',14)


%% Scratch

figure()
counter=1;
for o=1:5
    for p=[3,4]
        
        subplot(2,5,counter)
        counter=counter+1;
        histogram(elementSizes{o}{p}(:,1),20)
        xlim([0 4000])
        
        
    end

    
end

%%

o=337396;

p=427345;

counter=0;

for c =1:length(connFields)
    
    connField=cell2mat(connFields(c));
    conn=conns.(connField);
    if isempty(conn.pre)==1
    else
        
        if conn.pre == o && ismember(p,conn.post)==1
            
            
            counter=counter+sum(conn.post==p);
            
        else
        end
    end
    
    
end


%%

sizeByPN=[];

for o = 1:10
    for p=1:5
    
    tbarSizeByPN(o,p)=nanmean(aveSizes{o,p}(:,1));
    pnSizeByPN(o,p)=nanmean(aveSizes{o,p}(:,2));
    
    end
end


