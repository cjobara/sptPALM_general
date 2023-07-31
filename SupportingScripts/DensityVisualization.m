
function DensityVisualization(Tracks,PixSize,SaveFlag)

if nargin==2
    SaveFlag=false;
end

%Density maps by condition

for i=1:size(Tracks,2)
    figure
    Bins=PixSize*(1:ceil(20.48/(PixSize/1000))+1);
    [NumLoc,~,~,~,~]=histcounts2(1000*Tracks(i).matrix(:,:,2),1000*Tracks(i).matrix(:,:,3),Bins,Bins);
    imG=imgaussfilt(NumLoc,[2 2]);
    imG=imG';
    SF=255/(max(imG,[],'all','omitnan')-min(imG,[],'all','omitnan'));
    imshow(SF*(imG-min(imG,[],'all','omitnan')), jet, 'Border','tight');
    %h=hexscatter(1000*A,1000*B,'res',683,'showZeros','true');
    set(gcf,'Position',[800 300 768 768]);
    if SaveFlag==true
        fig1=figure(1);
        saveas(fig1,strcat(Tracks(i).file,'_rho.tif'));
        close(fig1);
    end
    
end

end