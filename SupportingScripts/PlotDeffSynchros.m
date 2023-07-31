
function PlotDeffSynchros(Control, HBSS, dRange, LUT, cRange, Steps)

if nargin==2
    %Define ahead of time:
    dRange=1:size(Control,2);
    LUT=parula;%flipud(turbo);
    cRange=[0.175 0.250];
    Steps=0.025;
end

for i=dRange
A=Control(i).CSmatrix(:,:,2);
B=Control(i).CSmatrix(:,:,3);
C=Control(i).Deff;

X=HBSS(i).CSmatrix(:,:,2);
Y=HBSS(i).CSmatrix(:,:,3);
Z=HBSS(i).Deff;

figure
set(gcf,'Position',[100 100 1600 550]);


subplot(1,2,1)
colormap(LUT);
scatter(A(:),B(:),[],C(:),'filled');
xlim([-0.6 0.6]);
ylim([-0.6 0.6]);
caxis(cRange);
hold on
plot(Control(i).refboundary(:,1)/1000,Control(i).refboundary(:,2)/1000,'r','LineWidth',1.5);

c=colorbar;
T=cRange(1):Steps:cRange(2);
c.Ticks=T;
set(gca,'FontSize',20);
c.Label.String='2D D_{eff} (\mum^2/sec)';

subplot(1,2,2)
colormap(LUT);
scatter(X(:),Y(:),[],Z(:),'filled');
xlim([-0.6 0.6]);
ylim([-0.6 0.6]);
caxis(cRange);
hold on
plot(HBSS(i).refboundary(:,1)/1000,HBSS(i).refboundary(:,2)/1000,'r','LineWidth',1.5);

% figure
% set(gcf,'Position',[100 100 1600 750]);
% subplot(1,2,1)
% colormap(LUT);
% scatter(A(:),B(:),[],C(:),'filled');
% xlim([-0.6 0.6]);
% ylim([-0.6 0.6]);
% caxis(Range);
% subplot(1,2,2)
% colormap(LUT);
% scatter(X(:),Y(:),[],Z(:),'filled');
% xlim([-0.6 0.6]);
% ylim([-0.6 0.6]);
% caxis(Range);

c=colorbar;
T=cRange(1):Steps:cRange(2);
c.Ticks=T;
set(gca,'FontSize',20);
c.Label.String='2D D_{eff} (\mum^2/sec)';


end

