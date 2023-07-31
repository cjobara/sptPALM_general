
function TrackOverlayMaker(Tracks)

for i=1:size(Tracks,2)ss
    
    filename=char(Tracks(i).file);
    filebase=filename(1:end-7);
    
    imS=ChrisPrograms.loadtiff(fullfile(pwd,'MaxInt',strcat(filebase,'_3_MaxInt_RGB.tif')));
    cd Overlay
   TracksOverRawImage(Tracks,i,imS)
   cd ..
   
end

end