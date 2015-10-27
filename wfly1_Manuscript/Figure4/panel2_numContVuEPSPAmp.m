% This code relies on the products of uEPSP_AmpWorking which should be found in Fig 2 dir


% GOAL: For each PN scatterplot num contacts vs uEPSP amp for each ORN input


% Collect the amplitude of ipsi and contra uEPSPs for R and L ORN-->PN
% pairs

% Loop over ORNs
for o=1:length(ORNs)
    
     %For the L ORNs
    if o <= length(ORNs_Left)
        
    %loop over PNs
    for p=1:4
    
       uEPSP_Amps(o,p)=max(leftUEPSPs{p}(o,:))-mean(leftUEPSPs{p}(o,1:100));
        
    end
        %For the R ORNs
    else
            
        %Loop over PNs
        
        for p=1:4
    
       uEPSP_Amps(o,p)=max(rightUEPSPs{p}(o-length(ORNs_Left),:))-mean(rightUEPSPs{p}(o-length(ORNs_Left),1:100));
        
        end
    
    end
end


figure()
set(gcf, 'color', 'w')

scatter([leftContactNum{1}, rightContactNum{1}],uEPSP_Amps(:,1), 'filled')
hold on
scatter([leftContactNum{2}, rightContactNum{2}],uEPSP_Amps(:,2), 'r', 'filled')
scatter([leftContactNum{3}, rightContactNum{3}],uEPSP_Amps(:,3), 'k', 'filled')
scatter([leftContactNum{4}, rightContactNum{4}],uEPSP_Amps(:,4), 'm', 'filled')
xlabel('Contact Number', 'FontSize',18)
ylabel('uEPSP Amp (mV)', 'FontSize',18)
legend({'PN1 LS', 'PN2 LS', 'PN3 LS', 'PN1 RS'}, 'Location', 'NorthWest')


