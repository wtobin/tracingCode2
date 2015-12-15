PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

for p=1:numel(PN_Names)
    
PN=cell2mat(PN_Names(p));

cd (['~/nC_projects/',PN,'_localMini/']);

%Grep command to pull all section numbers
secGrepCmd=['grep -o -P ''cable\=\"\K\d*'' allORNsTo',PN,'_151125.neuroml'];
[status sections]=system(secGrepCmd);
sections=str2num(sections);


% Pull a diameter for each segment, when this is defined for both proximal
% and distal portions of the segment just pull the distal diam

diamGrepCmd=['grep -o -P -z ''diameter\=\"\K\d*.\d*(?=\"\/\>\n\<\/segment\>)'' allORNsTo',PN,'_151125.neuroml'];
[status diameters]=system(diamGrepCmd);
diameters=str2num(diameters);




    while numel(sections) ~= numel(diameters) 
        
clear sections diameters 
       
%Grep command to pull all section numbers
secGrepCmd=['grep -o -P ''cable\=\"\K\d*'' allORNsTo',PN,'_151125.neuroml'];
[status sections]=system(secGrepCmd);
sections=str2num(sections);


% Pull a diameter for each segment, when this is defined for both proximal
% and distal portions of the segment just pull the distal diam

diamGrepCmd=['grep -o -P -z ''diameter\=\"\K\d*.\d*(?=\"\/\>\n\<\/segment\>)'' allORNsTo',PN,'_151125.neuroml'];
[status diameters]=system(diamGrepCmd);
diameters=str2num(diameters);


    end
    
    


% Find the mean diameter for all sections
uSections=unique(sections);

for i=1:length(uSections)
    
   
    mSecDiams(i,1)=uSections(i);
    mSecDiams(i,2)=mean(diameters(find(sections==uSections(i))));
    
end
   


%Find the section number for each input synapse, in the sequence they were
%activated in the simulation

synSecCmd=['grep -o -P ''.c\K\d*'' simulations/localMini/', PN,'_151125.hoc' ];
[status synSec]=system(synSecCmd);
synSec=str2num(synSec);
synSec=synSec(1:size(localMinis{p},1));

for s=1:numel(synSec)
    
    synSecDs(s)=mSecDiams(find(mSecDiams==synSec(s)),2);
    miniAmps(s)=max(localMinis{p}(s,:))+59.4;
    
    
end

synSectDiamSum(p,1)=mean(synSecDs);
synSectDiamSum(p,2)=std(synSecDs)/sqrt(numel(synSecDs));

% subplot(5,1,p)


 set(gcf,'Color','w')
 scatter((synSecDs).^-2/3,miniAmps)
 hold on
% title(PN_Names(p),'FontSize',12)
% if p ==5
 
 xlabel('Mean Compartment Diam ^-2/3 ','FontSize',16)
% 
% elseif p==4
    ylabel('Mini Amp @ site of Synapse (mV)','FontSize',16)
% end


% subplot(5,1,p)
% hist(synSecDs,50)
% xlim([0 .75])
% ylim([0 20])

clear sections diameters synSec miniAmps synSecDs mSecDiams uSections

end
% pull compartment #, L and diam from psections

%Grep command to pull all section numbers

secGrepCmd2=['grep -o -P ''\.c\K\d*(?=\s\{\snseg)'' simulations/localMini/psections'];
[status sections2]=system(secGrepCmd2)
sections2=str2num(sections2);


lenGrepCmd2=['grep -o -P ''L\=\K\d*\.?\d*'' simulations/localMini/psections'];
[status lengths]=system(lenGrepCmd2)
lengths=str2num(lengths);



    while numel(sections2) ~= numel(lengths) 
        
clear sections2 lengths 
       
secGrepCmd2=['grep -o -P ''\.c\K\d*(?=\s\{)'' simulations/localMini/psections'];
[status sections2]=system(secGrepCmd2);
sections2=str2num(sections2);


lenGrepCmd2=['grep -o -P ''L\=\K\d*\.\d*'' simulations/localMini/psections'];
[status lengths]=system(lenGrepCmd2);
lengths=str2num(lengths);

    end
    
    
    
secLengths=[sections2, lengths];

    
for s=1:numel(synSec)
    
    synSecLs(s)=secLengths(find(secLengths(:,1)==synSec(s)),2);
    miniAmps(s)=max(localMinis{1}(s,:))+59.4;
    
    
end
    
