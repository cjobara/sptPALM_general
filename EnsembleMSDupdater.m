

for i=1:size(Tracks,2)
    
    Tracks(i).MSDdata=EnsembleMSD(Tracks(i).matrix(:,:,1),Tracks(i).matrix(:,:,2),Tracks(i).matrix(:,:,3));
    Tracks(i).MSD=mean(Tracks(i).MSDdata,1,'omitnan')';
    Tracks(i).MSDstdev=std(Tracks(i).MSDdata,0,'omitnan')';
    Tracks(i).MSDerror=Tracks(i).MSDstdev./sqrt(sum(isfinite(Tracks(i).MSDdata),1)');
    
end