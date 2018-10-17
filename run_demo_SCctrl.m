
%% Demo to compute regional average controllabilty 
%
% Won Hee Lee
% wonhee.lee@mssm.edu
% Icahn School of Medicine at Mount Sinai
%
% type in a Matlab terminal: 
% run_demo_SCctrl

%% compute regional average controllability

tic;
load hcp10_aal512_sc
nSub = size(hcp10_aal512_sc,3);
nROI = size(hcp10_aal512_sc,1);

nodalStr = zeros(nROI, nSub);
aveCtrl = zeros(nROI, nSub);

for s = 1:nSub
    C = hcp10_aal512_sc(:,:,s);
    % nodal strength
    nodalStr(:, s) = strengths_und(C)';
    % regional average controllability
    aveCtrl(:, s) = ave_control(C);
end

%% relationship between regional average controllability and weighted degree

Spearman( mean(nodalStr, 2), mean(aveCtrl,2), 1 );
xlabel('Rank of weighted degree'); 
ylabel('Rank of average controllability');
set(gca, 'FontSize', 15);
axis square; box off;

%% compute regional mean average controllability

% HCP 
aveCtrl_avg = mean(aveCtrl, 2);
aveCtrl_std = std(aveCtrl, 0, 2);

%% compute rank of mean average controllability

aveCtrl_avgRank = tiedrank(aveCtrl_avg);

%% visualize ranked regional average controllability

load aal512_anat

MarkerSize=12;
h=figure; set(h, 'Position', [50 450 1600 435], 'color', 'white'); hold on;
colormap('jet')

subplot(131); plot3k(aal512_cog, 'ColorData', aveCtrl_avgRank, 'Marker',{'o', MarkerSize})
axis image; axis off; % colorbar('off')    
view([-90 0]) 

subplot(132); plot3k(aal512_cog, 'ColorData', aveCtrl_avgRank, 'Marker',{'o', MarkerSize})
axis image; axis off; % colorbar('off')    
view([0 90]) 

subplot(133); plot3k(aal512_cog, 'ColorData', aveCtrl_avgRank, 'Marker',{'o', MarkerSize})
axis image; axis off; % colorbar('off')    
view([90 0]) 
toc;