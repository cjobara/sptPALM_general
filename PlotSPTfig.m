
function PlotSPTfig(TrackStruct,index,imB,imS,subset,offset)

%TrackStruct = Figure or Tracks variable
%index = Cell index in TrackStruct
%imB - Background image for trajectories
%imS - Microscopy image for overlay
%subset - Tracks Index to plot
%offset = Channel Alignment Vector in form [x y];

close all

x=offset(1);
y=offset(2);

ColorMatrix=[0 0.4470 0.7410; 0.8500 0.3250 0.0980;0.9290 0.6940 0.1250;0.4940 0.1840 0.5560;0.4660 0.6740 0.1880;0.3010 0.7450 0.9330];

fig1=figure(1);
imshow(imB,'Border','tight');
fig1.Position=[900 300 768 768];
colororder(ColorMatrix);
hold on
plot(6.25*TrackStruct(index).matrix(:,subset,2)+x,6.25*TrackStruct(index).matrix(:,subset,3)+y,'LineWidth',1.5);

fig2=figure(2);
imshow(imS,'Border','tight');
fig2.Position=[100 300 768 768];
colororder(ColorMatrix);

fig3=figure(3);
imshow(imS,'Border','tight');
fig3.Position=[1700 300 768 768];
colororder(ColorMatrix);
hold on
plot(6.25*TrackStruct(index).matrix(:,subset,2)+x,6.25*TrackStruct(index).matrix(:,subset,3)+y,'LineWidth',1.5);

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


