

for j=1:5
    nIpsiContraDists(:,j)=ipsiContraDists(:,j)/max(ipsiContraDists(:,j));
end


titles={'PN3 LS', 'PN2 LS', 'PN1 RS', 'PN2 RS', 'PN1 LS'};

for i=1:length(PNs)
    
    
    subplot(2,3,i)
    
    boxplot(ipsiContraDists(:,i),[zeros(25,1);ones(25,1)], 'notch', 'on')
    set(gca,'XTickLabel',['Left ORNs ';'Right ORNs'])
    ylabel('contact averaged path length')
    title(titles(i))
    set(gcf,'color','w');
    
end

plot(realPathsL)

% scatter plot synapse path length to root sorted by number of contacts

for p=1:5
    
    collectedPathLengthsL=[];
    collectedPathLengthsR=[];
     groupsL=[];
      groupsR=[];

for j=1:50
    
    ind=i(j,p);
    
    if ind<=25
    
    collectedPathLengthsL=[collectedPathLengthsL,realPathsToIntegratorL{p}{i(j,p)}];
    groupsL=[groupsL, j*ones(1,length(realPathsToIntegratorL{p}{i(j,p)}))];
    
    
    else 



    collectedPathLengthsR=[collectedPathLengthsR,realPathsToIntegratorR{p}{i(j,p)-25}];
    groupsR=[groupsR, j*ones(1,length(realPathsToIntegratorR{p}{i(j,p)-25}))];
    
    end
end
        
 subplot(2,3,p)
 hold on
 scatter(collectedPathLengthsL,groupsL)
 scatter(collectedPathLengthsR,groupsR, 'r')

end


%Plot sorted contact number for all PNs

figure()

[v,il]=sort(sum(numContactsLORNs));
[v,ir]=sort(sum(numContactsRORNs));


for p=1:5
    subplot(1,2,1)
    
plot(sort(numContactsLORNs(p,il)))
hold on
    subplot(1,2,2)
    
plot(sort(numContactsRORNs(p,ir)))
hold on


end

% For each ORN plot the fraction of total PN input synapses made on the
% ipsi and contra side

for i=1:25
   fractIpsiL(i)=sum(numContactsLORNs([1,2,5],i))/sum(numContactsLORNs([3,4],i));
   fractIpsiR(i)=sum(numContactsRORNs([3,4],i))/sum(numContactsRORNs(:,i));
    
end

subplot(2,1,1)
hist(fractIpsiL,20)
xlim([0 2])
subplot(2,1,2)
hist(fractIpsiR,20)
xlim([0 2])


titles={'PN3 LS', 'PN2 LS', 'PN1 RS', 'PN2 RS', 'PN1 LS'};

for i=1:length(PNs)
    
    
    subplot(2,3,i)
    
   scatter([numContactsLORNs(i,:),numContactsRORNs(i,:)],[ones(1,length(numContactsLORNs(i,:))),2*ones(1,length(numContactsRORNs(i,:)))])
 

    title(titles(i))
    set(gcf,'color','w');
    ylim([0 2])
    
end



for p=1:5
    
collectedPathLengths=[];
groups=[];

for j=1:length(realPathsToIntegratorR{p})
    collectedPathLengths=[collectedPathLengths,realPathsToIntegratorR{p}{j}];
    groups=[groups, j*ones(1,length(realPathsToIntegratorR{p}{j}))];
end
        
 subplot(2,3,p)
 hold on
 
 scatter(collectedPathLengths,groups, 'r')
 
end
