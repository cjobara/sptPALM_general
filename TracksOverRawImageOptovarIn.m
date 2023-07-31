
function TracksOverRawImageOptovarIn(TrackStruct,index,imS)

fig1=figure(1);
imshow(imS,'Border','tight');
fig1.Position=[300 300 768 768];
hold on

plot(9.375*TrackStruct(index).matrix(:,:,2),9.375*TrackStruct(index).matrix(:,:,3),'b');

saveas(fig1,strcat(TrackStruct(index).file,'_tracks.tif'));

close all

end