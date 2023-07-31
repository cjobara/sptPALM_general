
function PlotSPTfigTonly(TrackStruct,index,subset)

%TrackStruct = Figure or Tracks variable
%index = Cell index in TrackStruct
%imB - Background image for trajectories
%imS - Microscopy image for overlay
%subset - Tracks Index to plot
%offset = Channel Alignment Vector in form [x y];

close all

ColorMatrix=[0 0.4470 0.7410; 0.8500 0.3250 0.0980;0.9290 0.6940 0.1250;0.4940 0.1840 0.5560;0.4660 0.6740 0.1880;0.3010 0.7450 0.9330];

fig4=figure(4);
colororder(ColorMatrix);
plot(0.011*TrackStruct(index).matrix(:,subset,1)-0.011*min(TrackStruct(index).matrix(1,subset,1),[],'all'),sqrt(TrackStruct(index).matrix(:,subset,2).^2+TrackStruct(index).matrix(:,subset,3).^2),'LineWidth',1.5);
fig4.InnerPosition=[400 75 768+384 384];
xlabel('Time  (sec)');
ylabel('Position (\mum)');
xlim([0 0.011*max(TrackStruct(index).matrix(:,subset,1),[],'all')]);
ylim([0 25]);
set(gca,'LineWidth',1.5);




end


