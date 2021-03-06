conns=loadjson('~/tracing/connectors.json');
connNames=fieldnames(conns);
 
annotations=loadjson('/home/wtobin/tracing/sid_by_annotation.json');

PNs=annotations.PN;

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

ORNs=[ORNs_Left, ORNs_Right];

LNs=annotations.LN;
LNs=[LNs, annotations.Likely_0x20_LN];


for i=1:length(connNames)
positions(i,:)=conns.(cell2mat(connNames(i))).location;
end

counter=1;
for j=1:length(connNames)
if isempty(conns.(cell2mat(connNames(j))).pre)==0
if ismember(conns.(cell2mat(connNames(j))).pre,PNs) == 1
pnOuts(counter,:)=conns.(cell2mat(connNames(j))).location;
counter=counter+1;
else
end
else
end
end

counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        if ismember(conns.(cell2mat(connNames(j))).pre,PNs) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,ORNs)) ~= 0
            pnToORN(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end

counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)==0
        if ismember(conns.(cell2mat(connNames(j))).pre,ORNs) == 1
            ornOuts(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end


counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)==0
        if ismember(conns.(cell2mat(connNames(j))).pre,LNs) == 1
            lnOuts(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end


counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).post)==0
        if sum(ismember(conns.(cell2mat(connNames(j))).post,LNs)) ~= 0
            lnIns(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end


counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        if ismember(conns.(cell2mat(connNames(j))).pre,LNs) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,ORNs)) ~= 0
            lnToORN(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end

counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        if ismember(conns.(cell2mat(connNames(j))).pre,PNs) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs)) ~= 0
            pnPN(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end


counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        if ismember(conns.(cell2mat(connNames(j))).pre,ORNs) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs(5))) ~= 0
            orn2PN1LS(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end


counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        if ismember(conns.(cell2mat(connNames(j))).pre,ORNs) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs(2))) ~= 0
            orn2PN2LS(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end


counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        if ismember(conns.(cell2mat(connNames(j))).pre,ORNs) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs(1))) ~= 0
            orn2PN3LS(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end


for i=1:length(ORNs_Left)
    
    
    
counter=1;

for j=1:length(connNames)
    
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        
        if ismember(conns.(cell2mat(connNames(j))).pre,ORNs_Left(i)) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs)) ~= 0
            
            orn2PNs_Left{i}(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
            
        else
        end
        
    else
    end
end


end


for i=1:length(ORNs_Right)
    
    
    
counter=1;

for j=1:length(connNames)
    
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        
        if ismember(conns.(cell2mat(connNames(j))).pre,ORNs_Right(i)) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs)) ~= 0
            
            orn2PNs_Right{i}(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
            
        else
        end
        
    else
    end
end


end



counter=1;
for j=1:length(connNames)
    
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        
        if sum(ismember(conns.(cell2mat(connNames(j))).post,PNs(1))) ~= 0
            
           inputs_PN1(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
            
        else
        end
        
    else
    end
    
end


counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        if ismember(conns.(cell2mat(connNames(j))).pre,LNs) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs(1))) ~= 0
            lnToPN1(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end


counter=1;
for j=1:length(connNames)
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        if ismember(conns.(cell2mat(connNames(j))).pre,PNs) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs(1))) ~= 0
            pnToPN1(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
        else
        end
    else
    end
end

figure(1)

% subplot(6,4,i)
% scatter(positions(:,1),positions(:,2),'b')
scatter(inputs_PN1(:,1),inputs_PN1(:,3),'b')
hold on
scatter(lnToPN1(:,1),lnToPN1(:,3),'filled','r')
scatter(pnToPN1(:,1),pnToPN1(:,3),'filled','y')
% scatter(ornOuts(:,1),ornOuts(:,2), 'r')
% scatter(pnOuts(:,1),pnOuts(:,2), 'g')
% scatter(pnToORN(:,1),pnToORN(:,2), 'k', 'filled')
% scatter(lnOuts(:,1), lnOuts(:,3), 'k', 'filled')
% scatter(lnToORN(:,1), lnToORN(:,2), 'k', 'filled')
% scatter(orn2PNs_Left{i}(:,1), orn2PNs_Left{i}(:,3), 'k', 'filled')
hold on
for i=1:length(ORNs_Left)
scatter(orn2PNs_Left{i}(:,1), orn2PNs_Left{i}(:,3), 'k', 'filled')
end

for i=1:length(ORNs_Right)
scatter(orn2PNs_Right{i}(:,1), orn2PNs_Right{i}(:,3), 'm', 'filled')
end


% ylim([2.25*10^5, 2.45*10^5])
% xlim([3.95*10^5 4.66*10^5])
ylim([8500, 2.3*10^4])
xlim([4.51*10^5 4.66*10^5])

set(gcf,'color','w')



figure()
scatter(positions(:,1),positions(:,2))
hold on
scatter(ornOuts(:,1),ornOuts(:,2), 'r')
scatter(pnOuts(:,1),pnOuts(:,2), 'g')
% scatter(pnToORN(:,1),pnToORN(:,2), 'k', 'filled')
% scatter(lnOuts(:,1), lnOuts(:,3), 'k', 'filled')
% scatter(lnToORN(:,1), lnToORN(:,2), 'k', 'filled')
scatter(orn2PN1LS(:,1), orn2PN1LS(:,2), 'k', 'filled')
scatter(orn2PN2LS(:,1), orn2PN2LS(:,2), 'm', 'filled')
scatter(orn2PN3LS(:,1), orn2PN3LS(:,2), 'c', 'filled')
ylim([2.25*10^5, 2.45*10^5])
xlim([3.95*10^5 4.66*10^5])
% ylim([8500, 2.3*10^4])
% xlim([3.95*10^5 4.66*10^5])
set(gcf,'color','w')




counter=1;

for i=1:length(ORNs_Right)
    




for j=1:length(connNames)
    
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        
        if ismember(conns.(cell2mat(connNames(j))).pre,ORNs_Right(i)) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs([1,2,5]))) ~= 0
            
            orn2PNs_Lcontra(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
            
        
        end
        
    else
    end
end


end


counter=1;

for i=1:length(ORNs_Left)
    

for j=1:length(connNames)
    
    if isempty(conns.(cell2mat(connNames(j))).pre)== 0 &&  isempty(conns.(cell2mat(connNames(j))).post) == 0
        
        if ismember(conns.(cell2mat(connNames(j))).pre,ORNs_Left(i)) == 1 && sum(ismember(conns.(cell2mat(connNames(j))).post,PNs([1,2,5]))) ~= 0
            
            orn2PNs_Lipsi(counter,:)=conns.(cell2mat(connNames(j))).location;
            counter=counter+1;
            
        
        end
        
    else
    end
end


end


figure()
% subplot(2,1,1)
hold on
scatter(orn2PNs_Lipsi(:,1),orn2PNs_Lipsi(:,2), 'k')
% subplot(2,1,2)
scatter(orn2PNs_Lcontra(:,1),orn2PNs_Lcontra(:,2), 'r')

ylim([2.25*10^5, 2.45*10^5])
xlim([3.95*10^5 4.66*10^5])
% ylim([8500, 2.3*10^4])
% xlim([3.95*10^5 4.66*10^5])
set(gcf,'color','w')



