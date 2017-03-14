%{
relies on downloading data to the local machine and running
pullSynapseSizeData_rough first.


%}
%% initials of tracers in the order their data is stored in the elementSizes cell
Users={'JK','HY','BS','WC'};

%% Ipsi Contra Tbar size 



f1=figure();
f2=figure();

for u=1:4
    
    ipsiTbarPx=[];
    contraTbarPx=[];
    
    ipsiPost=[];
    contraPost=[];
    
    
    for o=1:10
        
        curO=elementSizes{u}{o};
        
        if isempty(curO)==1
        else
            
            for p=1:length(curO)
                
                curOP=curO{p};
                
                if isempty(curOP)==1
                else
                    
                    if o<=5 && ismember(p,[1,2,5])==1
                        
                        ipsiTbarPx=[ipsiTbarPx;curOP(:,1)];
                        ipsiPost=[ipsiPost;curOP(:,2)];
                        
                    elseif o<=5 && ismember(p,[1,2,5])==0
                        
                        contraTbarPx=[contraTbarPx;curOP(:,1)];
                        contraPost=[contraPost;curOP(:,2)];
                        
                    elseif o>5 && ismember(p,[1,2,5])==1
                        
                        contraTbarPx=[contraTbarPx;curOP(:,1)];
                        contraPost=[contraPost;curOP(:,2)];
                        
                    elseif o>5 && ismember(p,[1,2,5])==0
                        
                        ipsiTbarPx=[ipsiTbarPx;curOP(:,1)];
                        ipsiPost=[ipsiPost;curOP(:,2)];
                    end
                end
            end
        end
    end
    
    figure(f1)
    
    [p,h]=ranksum(ipsiTbarPx,contraTbarPx);
    subplot(2,2,u)
    hold on
    histogram(ipsiTbarPx,30)
    histogram(contraTbarPx,30)
    title(['Tracer ',num2str(u), ' Wilcoxon rank sum p: ',num2str(p)])
    xlabel('Tbar Vol (nm^3)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Ipsilateral Tbars';'Contralateral Tbars'})
    
    
    [p,h]=ranksum(ipsiPost,contraPost);
    figure(f2)
    subplot(2,2,u)
    hold on
    histogram(ipsiPost,30)
    histogram(contraPost,30)
    %xlim([0 500])
    title(['Tracer ',num2str(u), ' Wilcoxon rank sum p: ',num2str(p)])
    xlabel('Postsynaptic PN membrane area (nm^2)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Ipsilateral PNs';'Contralateral PNs'})
    
end

%% Some sorting left/right


f1=figure();
f2=figure();


for u=1:4

rightTbarPx=[];
leftTbarPx=[];

rightPost=[];
leftPost=[];

for o=1:10
    
    curO=elementSizes{u}{o};
    
    if isempty(curO)==1
    else
        
        for p=1:length(curO)
            
            curOP=curO{p};
            
            if isempty(curOP)==1
            else
                
                if ismember(p,[1,2,5])==1
                    
                    leftTbarPx=[leftTbarPx;curOP(:,1)];
                    leftPost=[leftPost;curOP(:,2)];
                    
                elseif ismember(p,[3,4])==1
                    
                    rightTbarPx=[rightTbarPx;curOP(:,1)];
                    rightPost=[rightPost;curOP(:,2)];
                    
                    
                end
            end
        end
    end
end

    [p,h]=ranksum(leftTbarPx,rightTbarPx);
    figure(f1)
    subplot(2,2,u)
    hold on
    histogram(rightTbarPx,30)
    histogram(leftTbarPx,30)
    title(['Tracer ',num2str(u), ' Wilcoxon rank sum p: ',num2str(p)])
    xlabel('Tbar Vol (nm^3)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Right Tbars';'Left Tbars'})
    
    [p,h]=ranksum(leftPost,rightPost);
    figure(f2)
    subplot(2,2,u)
    hold on
    histogram(rightPost,30)
    histogram(leftPost,30)
    %xlim([0 500])
    title(['Tracer ',num2str(u), ' Wilcoxon rank sum p: ',num2str(p)])
    xlabel('Postsynaptic PN membrane area (nm^2)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Right PNs';'Left PNs'})
    


end


%% Some sorting ipsi contra

ipsiTbarVolMeans=[];
contraTbarVolMeans=[];

ipsiPostMeans=[];
contraPostMeans=[];

for u=1:4
    
    U=elementSizes{u};

for o=1:10
    
    curO=U{o};
    
    if isempty(curO)==1
    else
        
        for p=1:length(curO)
            
            curOP=curO{p};
            
            if isempty(curOP)==1
            else
                
                if o<=5 && ismember(p,[1,2,5])==1
                    
                    ipsiTbarVolMeans=[ipsiTbarVolMeans;mean(curOP(:,1))];
                    ipsiPostMeans=[ipsiPostMeans;mean(curOP(:,2))];
                    
                elseif o<=5 && ismember(p,[1,2,5])==0
                    
                    contraTbarVolMeans=[contraTbarVolMeans;mean(curOP(:,1))];
                    contraPostMeans=[contraPostMeans;mean(curOP(:,2))];
                    
                elseif o>5 && ismember(p,[1,2,5])==1
                    
                    contraTbarVolMeans=[contraTbarVolMeans;mean(curOP(:,1))];
                    contraPostMeans=[contraPostMeans;mean(curOP(:,2))];
                    
                elseif o>5 && ismember(p,[1,2,5]) == 0
                    
                    ipsiTbarVolMeans=[ipsiTbarVolMeans;mean(curOP(:,1))];
                    ipsiPostMeans=[ipsiPostMeans;mean(curOP(:,2))];
                    
                end
            end
        end
    end
end

CV_tbar=std(ipsiTbarVolMeans)/mean(ipsiTbarVolMeans)
CV_post=std(ipsiPostMeans)/mean(ipsiPostMeans)
end

%% Scratch

figure()
counter=1;
for o=1:5
    for p=[3,4]
        
        subplot(2,5,counter)
        counter=counter+1
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
            
            
            counter=counter+sum(conn.post==p)
            
        else
        end
    end
    
    
end
