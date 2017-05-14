%% Code to get lengths and radii of branch segments from NEURON hoc files

%base directory for simulation results
baseDir='~/nC_projects/';

% branch segments = sections in NEURON and may be divided into 'segments'
% for computational purposes

% DM6 PN1LS
tic
% collect branch segment IDs
idCommand=['grep -Po ''(?<=section: c)\d*'' ', ...
    baseDir,'PN1LS_allORNs/generatedNEURON/neuron_PN1_LS_sk_419138.hoc > ',baseDir,'PN1LS_allORNs/generatedNEURON/sectionIDs.txt'];
    
system(idCommand);
IDsPn1Ls=importdata([baseDir,'PN1LS_allORNs/generatedNEURON/sectionIDs.txt']);

% collect branch segment radii
idCommand=['grep -Po ''(?<=rad: )\d*.\d*'' ', ...
    baseDir,'PN1LS_allORNs/generatedNEURON/neuron_PN1_LS_sk_419138.hoc > ',baseDir,'PN1LS_allORNs/generatedNEURON/sectionRadii.txt'];
    
system(idCommand);
radPn1Ls = importdata([baseDir,'PN1LS_allORNs/generatedNEURON/sectionRadii.txt']);

% collect branch segment lengths
idCommand=['grep -Po ''(?<=len: )\d*.\d*'' ', ...
    baseDir,'PN1LS_allORNs/generatedNEURON/neuron_PN1_LS_sk_419138.hoc > ',baseDir,'PN1LS_allORNs/generatedNEURON/sectionLengths.txt'];
    
system(idCommand);
lenPn1Ls = importdata([baseDir,'PN1LS_allORNs/generatedNEURON/sectionLengths.txt']);

toc

% due to NEURON root having no length, remove first row from IDs and radii
IDsPn1Ls(1,:) = [];
radPn1Ls(1,:) = [];


% DM6 PN2LS
tic
% collect branch segment IDs
idCommand=['grep -Po ''(?<=section: c)\d*'' ', ...
    baseDir,'PN2LS_allORNs/generatedNEURON/neuron_PN2_LS_sk_427345.hoc > ',baseDir,'PN2LS_allORNs/generatedNEURON/sectionIDs.txt'];
    
system(idCommand);
IDsPn2Ls=importdata([baseDir,'PN2LS_allORNs/generatedNEURON/sectionIDs.txt']);

% collect branch segment radii
idCommand=['grep -Po ''(?<=rad: )\d*.\d*'' ', ...
    baseDir,'PN2LS_allORNs/generatedNEURON/neuron_PN2_LS_sk_427345.hoc > ',baseDir,'PN2LS_allORNs/generatedNEURON/sectionRadii.txt'];
    
system(idCommand);
radPn2Ls = importdata([baseDir,'PN2LS_allORNs/generatedNEURON/sectionRadii.txt']);

% collect branch segment lengths
idCommand=['grep -Po ''(?<=len: )\d*.\d*'' ', ...
    baseDir,'PN2LS_allORNs/generatedNEURON/neuron_PN2_LS_sk_427345.hoc > ',baseDir,'PN2LS_allORNs/generatedNEURON/sectionLengths.txt'];
    
system(idCommand);
lenPn2Ls = importdata([baseDir,'PN2LS_allORNs/generatedNEURON/sectionLengths.txt']);

toc

% due to NEURON root having no length, remove first row from IDs and radii
IDsPn2Ls(1,:) = [];
radPn2Ls(1,:) = [];


% DM6 PN3LS
tic
% collect branch segment IDs
idCommand=['grep -Po ''(?<=section: c)\d*'' ', ...
    baseDir,'PN3LS_allORNs/generatedNEURON/neuron_PN3_LS_sk_668267.hoc > ',baseDir,'PN3LS_allORNs/generatedNEURON/sectionIDs.txt'];
    
system(idCommand);
IDsPn3Ls=importdata([baseDir,'PN3LS_allORNs/generatedNEURON/sectionIDs.txt']);

% collect branch segment radii
idCommand=['grep -Po ''(?<=rad: )\d*.\d*'' ', ...
    baseDir,'PN3LS_allORNs/generatedNEURON/neuron_PN3_LS_sk_668267.hoc > ',baseDir,'PN3LS_allORNs/generatedNEURON/sectionRadii.txt'];
    
system(idCommand);
radPn3Ls = importdata([baseDir,'PN3LS_allORNs/generatedNEURON/sectionRadii.txt']);

% collect branch segment lengths
idCommand=['grep -Po ''(?<=len: )\d*.\d*'' ', ...
    baseDir,'PN3LS_allORNs/generatedNEURON/neuron_PN3_LS_sk_668267.hoc > ',baseDir,'PN3LS_allORNs/generatedNEURON/sectionLengths.txt'];
    
system(idCommand);
lenPn3Ls = importdata([baseDir,'PN3LS_allORNs/generatedNEURON/sectionLengths.txt']);

toc

% due to NEURON root having no length, remove first row from IDs and radii
IDsPn3Ls(1,:) = [];
radPn3Ls(1,:) = [];


% DM6 PN1RS
tic
% collect branch segment IDs
idCommand=['grep -Po ''(?<=section: c)\d*'' ', ...
    baseDir,'PN1RS_allORNs/generatedNEURON/neuron_PN1_RS_sk_638603.hoc > ',baseDir,'PN1RS_allORNs/generatedNEURON/sectionIDs.txt'];
    
system(idCommand);
IDsPn1Rs=importdata([baseDir,'PN1RS_allORNs/generatedNEURON/sectionIDs.txt']);

% collect branch segment radii
idCommand=['grep -Po ''(?<=rad: )\d*.\d*'' ', ...
    baseDir,'PN1RS_allORNs/generatedNEURON/neuron_PN1_RS_sk_638603.hoc > ',baseDir,'PN1RS_allORNs/generatedNEURON/sectionRadii.txt'];
    
system(idCommand);
radPn1Rs = importdata([baseDir,'PN1RS_allORNs/generatedNEURON/sectionRadii.txt']);

% collect branch segment lengths
idCommand=['grep -Po ''(?<=len: )\d*.\d*'' ', ...
    baseDir,'PN1RS_allORNs/generatedNEURON/neuron_PN1_RS_sk_638603.hoc > ',baseDir,'PN1RS_allORNs/generatedNEURON/sectionLengths.txt'];
    
system(idCommand);
lenPn1Rs = importdata([baseDir,'PN1RS_allORNs/generatedNEURON/sectionLengths.txt']);

toc

% due to NEURON root having no length, remove first row from IDs and radii
IDsPn1Rs(1,:) = [];
radPn1Rs(1,:) = [];


% DM6 PN2RS
tic
% collect branch segment IDs
idCommand=['grep -Po ''(?<=section: c)\d*'' ', ...
    baseDir,'PN2RS_allORNs/generatedNEURON/neuron_PN2_RS_sk_480245.hoc > ',baseDir,'PN2RS_allORNs/generatedNEURON/sectionIDs.txt'];
    
system(idCommand);
IDsPn2Rs=importdata([baseDir,'PN2RS_allORNs/generatedNEURON/sectionIDs.txt']);

% collect branch segment radii
idCommand=['grep -Po ''(?<=rad: )\d*.\d*'' ', ...
    baseDir,'PN2RS_allORNs/generatedNEURON/neuron_PN2_RS_sk_480245.hoc > ',baseDir,'PN2RS_allORNs/generatedNEURON/sectionRadii.txt'];
    
system(idCommand);
radPn2Rs = importdata([baseDir,'PN2RS_allORNs/generatedNEURON/sectionRadii.txt']);

% collect branch segment lengths
idCommand=['grep -Po ''(?<=len: )\d*.\d*'' ', ...
    baseDir,'PN2RS_allORNs/generatedNEURON/neuron_PN2_RS_sk_480245.hoc > ',baseDir,'PN2RS_allORNs/generatedNEURON/sectionLengths.txt'];
    
system(idCommand);
lenPn2Rs = importdata([baseDir,'PN2RS_allORNs/generatedNEURON/sectionLengths.txt']);

toc

% due to NEURON root having no length, remove first row from IDs and radii
IDsPn2Rs(1,:) = [];
radPn2Rs(1,:) = [];

%% calc average radii and lengths
% note: average radii are estimates averaged over section segments not
% lengths
[radPn1LsAvg] = grpstats(radPn1Ls,IDsPn1Ls,{'mean'});
[lenPn1LsSums] = grpstats(lenPn1Ls,IDsPn1Ls,{'sum'});

[radPn2LsAvg] = grpstats(radPn2Ls,IDsPn2Ls,{'mean'});
[lenPn2LsSums] = grpstats(lenPn2Ls,IDsPn2Ls,{'sum'});

[radPn3LsAvg] = grpstats(radPn3Ls,IDsPn3Ls,{'mean'});
[lenPn3LsSums] = grpstats(lenPn3Ls,IDsPn3Ls,{'sum'});

[radPn1RsAvg] = grpstats(radPn1Rs,IDsPn1Rs,{'mean'});
[lenPn1RsSums] = grpstats(lenPn1Rs,IDsPn1Rs,{'sum'});

[radPn2RsAvg] = grpstats(radPn2Rs,IDsPn2Rs,{'mean'});
[lenPn2RsSums] = grpstats(lenPn2Rs,IDsPn2Rs,{'sum'});

branchRad = {radPn1LsAvg,radPn2LsAvg,radPn3LsAvg,radPn1RsAvg,radPn2RsAvg};
branchLen = {lenPn1LsSums,lenPn2LsSums,lenPn3LsSums,lenPn1RsSums,lenPn2RsSums};
%% number of compartments
nComp_PnLs = [length(IDsPn1Ls); length(IDsPn2Ls); length(IDsPn3Ls)]; 
nComp_PnRs = [length(IDsPn1Rs); length(IDsPn2Rs)]; 

meanNcompPns = mean([nComp_PnLs;nComp_PnRs])
semNcompPns = std([nComp_PnLs;nComp_PnRs])/sqrt(length([nComp_PnLs;nComp_PnRs]))

meanNcompLs = mean(nComp_PnLs)
semNcompLs = std(nComp_PnLs)/sqrt(length(nComp_PnLs))

meanNcompRs = mean(nComp_PnRs)
semNcompRs = std(nComp_PnRs)/sqrt(length(nComp_PnRs))


%% histogram example
figure
histogram(radPn1LsAvg)
set(gca,'TickDir','out')
xlabel('radius (\mum)','FontSize',16)
ylabel('no. of branch segments','FontSize',16)

figure
histogram(lenPn1LsSums)
set(gca,'TickDir','out')
xlabel('length (\mum)','FontSize',16)
ylabel('no. of branch segments','FontSize',16)

%% separate histograms

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

colors={[0.53, 0.40, 0.67];...
        [0.23, 0.76, 0.85];...
        [0.05, 0.66, 0.40];...
        [0.30, 0.18, 0.55];...
        [0.12, 0.59, 0.64]};

% radii
figure
for i=1:5
    ax(i) = subplot(5,1,i)

    histogram(branchRad{i},'FaceColor',colors{i})
    title(PN_Names(i),'FontSize',12)
    ylabel('no. of branch segments')
    set(gca,'TickDir','out')

if i==5
    
    xlabel('radius (\mum)','FontSize',16)
    
else
end


end

linkaxes(ax(1:5),'x');
set(gca,'TickDir','out')

%TODO check PN1LS 1 segment with 2 um radius?
xlim([0 1])


% lengths
figure
for i=1:5
    ax(i) = subplot(5,1,i)

    histogram(branchLen{i},'FaceColor',colors{i})
    title(PN_Names(i),'FontSize',12)
    ylabel('no. of branch segments')
    set(gca,'TickDir','out')

if i==5
    
    xlabel('length (\mum)','FontSize',16)
    
else
end


end

linkaxes(ax(1:5),'x');

%% box plots

% radii
forBox=[];
for i=1:5
   
%     meanRadius(i)=mean(radii{i});
    forBox_w(:,1)=branchRad{i};
    forBox_w(:,2)=i*ones(numel(branchRad{i}),1);
    forBox=[forBox;forBox_w];
    
    forBox_w=[];
end

figure
boxplot(forBox(:,1),forBox(:,2),'Notch','on')
ax=gca;
ax.XTickLabel=PN_Names;
% ax.YLim=[-60 1000];
ylabel('segment radius (\mum)');
ax.FontSize=16;
set(gca,'TickDir','out')
%TODO check PN1LS 1 segment with 2 um radius?
ylim([0 1])


% lengths
forBox=[];
for i=1:5
   
%     meanRadius(i)=mean(radii{i});
    forBox_w(:,1)=branchLen{i};
    forBox_w(:,2)=i*ones(numel(branchLen{i}),1);
    forBox=[forBox;forBox_w];
    
    forBox_w=[];
end

figure
boxplot(forBox(:,1),forBox(:,2),'Notch','on')
ax=gca;
ax.XTickLabel=PN_Names;
% ax.YLim=[-60 1000];
ylabel('segment length (\mum)');
ax.FontSize=16;
set(gca,'TickDir','out')

% ylim([0 1])


%% compiled histograms

colors={[0.53, 0.40, 0.67];...
        [0.23, 0.76, 0.85];...
        [0.12, 0.59, 0.64];...
        [0.30, 0.18, 0.55];...
        [0.05, 0.66, 0.40]};


PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

% segment radii
figure
hold on
for i=1:5
    
h(i) = histogram(branchRad{i},'DisplayStyle','stairs','EdgeColor',colors{i});

end

set(gca,'TickDir','out')
xlabel('radius (\mum)','FontSize',16)
ylabel('no. of branch segments','FontSize',16)

% segment lengths
figure
hold on
for i=1:5
    
h(i) = histogram(branchLen{i},'DisplayStyle','stairs','EdgeColor',colors{i});

end

set(gca,'TickDir','out')
xlabel('length (\mum)','FontSize',16)
ylabel('no. of branch segments','FontSize',16)
