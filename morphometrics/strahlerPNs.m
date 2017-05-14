% some supplementary morphometrics
% Strahler distribution from CATMAID
% https://github.com/catmaid/CATMAID/wiki/Scripting
% load neurons in CATMAID 3D view
% open java console (in Chrome: shift+control+J)
% paste and run the following and check order of skeletons
% 
% function printStrahlerDistributionFrom3DViewer() {
%  var viewers = CATMAID.WebGLApplication.prototype.instances;
%  for (var wid in viewers) {
%    var w = viewers[wid];
%    console.log("Strahler distribution for skeletons in widget '" + w.getName() + "'");
%    for (var sid in w.space.content.skeletons) {
%      var skeleton = w.space.content.skeletons[sid];
%      var arbor = skeleton.createArbor();
%      // We only care about the topology, therefore create a new working arbor
%      // that only contains the root, branches and leafs.
%      var topoArbor = arbor.topologicalCopy();
%      // Get Strahler numbers for nodes of topology arbor and build distribution
%      var strahlerNumbers = topoArbor.strahlerAnalysis();
%      var distribution = {};
%      var maxStrahler = strahlerNumbers[topoArbor.root];
%      for (var nodeId in strahlerNumbers) {
%        var s = strahlerNumbers[nodeId];
%        if (s in distribution) {
%          ++distribution[s]
%        } else {
%          distribution[s] = 1;
%        }
%      }
%      // The count of the root strahler numnber has to be reduced by one,
%      // because the Strahler number is associated with the edge to the parent,
%      // which the root node doesn't have.
%      --distribution[maxStrahler];
% 
%      console.log("Strahler distribution for Skeleton #" + sid, distribution);
%    }
%  }
% }
% 
% printStrahlerDistributionFrom3DViewer();

%% Strahler distributions of PN branch segments
load('strahlerDist.mat') % imported from CATMAID Morphology Plot

strahler = strahlerDist'; % before transformation [PN, 1, 2, 3, 4, 5, 6, 7]

figure;

% assumes PN order PN1LS, PN2LS, PN3LS, PN1RS, PN2RS
colors={[0.53, 0.40, 0.67];...
        [0.23, 0.76, 0.85];...
        [0.05, 0.66, 0.40];...
        [0.30, 0.18, 0.55];...
        [0.12, 0.59, 0.64]};
    
hold on
for pn = 2:size(strahler,2);
    plot(strahler(:,1),strahler(:,pn),'color',colors{pn-1},'LineWidth',2)
end

ylabel('no. branches')
xlabel('Strahler branch order')
set(gca,'TickDir','out')

%%
saveas(gcf,'strahler','epsc')
saveas(gcf,'strahler')

%% Normalized

maxStrahler = max(strahler(:,2:6));

normStrahler = bsxfun(@rdivide, strahler(:,2:6), maxStrahler);

figure
hold on
for pn = 2:size(strahler,2);
    plot(strahler(:,1)/1000,normStrahler(:,pn-1),'color',colors{pn-1},'LineWidth',2)
end
ylabel('Norm. no. of branches')
set(gca,'TickDir','out')
xlabel('Strahler branch order')

%%
saveas(gcf,'strahler_norm','epsc')
saveas(gcf,'strahler_norm')