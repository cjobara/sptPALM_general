
function DeffMapSynchronizerCS(Control, HBSS, LUT, Range, Steps)

%Fist two inputs should be CS structures, others are optional.

if nargin ==2
%Define ahead of time:
    LUT=viridis;
    Range=[0.19 0.26];
    Steps=0.01;
end

A=1000*Control.CSmatrix(:,:,2)+600;
B=1000*Control.CSmatrix(:,:,3)+600;
C=Control.Deff;

X=1000*HBSS.CSmatrix(:,:,2)+600;
Y=1000*HBSS.CSmatrix(:,:,3)+600;
Z=HBSS.Deff;

figure
set(gcf,'Position',[100 100 1600 550]);


subplot(1,2,1)
colormap(LUT);
imshow(uint8(255*ones(1200,1200,3)));
hold on
scatter(A(:),B(:),[],C(:),'filled');
% xlim([-0.6 0.6]);
% ylim([-0.6 0.6]);
caxis(Range);
hold on
plot(Control.refboundary(:,1)+600,Control.refboundary(:,2)+600,'r','LineWidth',1.5);

c=colorbar;
T=Range(1):Steps:Range(2);
c.Ticks=T;
set(gca,'FontSize',20);
c.Label.String='2D D_{eff} (\mum^2/sec)';

subplot(1,2,2)
colormap(LUT);
imshow(uint8(255*ones(1200,1200,3)));
hold on
scatter(X(:),Y(:),[],Z(:),'filled');
% xlim([-0.6 0.6]);
% ylim([-0.6 0.6]);
caxis(Range);
hold on
plot(HBSS.refboundary(:,1)+600,HBSS.refboundary(:,2)+600,'r','LineWidth',1.5);

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
T=Range(1):Steps:Range(2);
c.Ticks=T;
set(gca,'FontSize',20);
c.Label.String='2D D_{eff} (\mum^2/sec)';

end

