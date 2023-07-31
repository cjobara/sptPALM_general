
function PlotTrackDatabyCell(TrackStruct,index,subset)

 close all

if nargin==2
    subset=1:size(TrackStruct(index).lengths,1);
end

figure(1)
set(gcf,'Position',[200 200 768 768]);
plot(TrackStruct(index).matrix(:,subset,2),TrackStruct(index).matrix(:,subset,3))
axis equal

figure(2)
set(gcf,'Position',[1000 400 1200 800]);
subplot(2,1,1);
plot(TrackStruct(index).matrix(:,subset,1),TrackStruct(index).matrix(:,subset,2));
ylabel('X Position (\mum)')
xlabel('Time (frames)')
subplot(2,1,2);
plot(TrackStruct(index).matrix(:,subset,1),TrackStruct(index).matrix(:,subset,3));
ylabel('Y Position (\mum)')
xlabel('Time (frames)')

end