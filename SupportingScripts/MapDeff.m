
function [DeffMap, DensityMap]=MapDeff(TrackAssembly,index,PixSize,HexFlag)

   %This doesn't really work very well--probably need a 2D LUT or something
   % otherwise the background of pixels without signal swamp the signal
   % itself... or a new set of axes for binning, maybe.



    %Note: If HexFlag is false, the returned structures will be double
    %precision arrays corresponding to pixels in a resulting image. If the
    %HexFlag is set to true, the returns will be handles to patch objects
    %corresponding to the hexagonal arrays that make up the image.

if nargin==3
    HexFlag=false;
end

% Define common m x n matrices for ease of linear indexing
A=TrackAssembly(index).matrix(:,:,2);
B=TrackAssembly(index).matrix(:,:,3);
C=TrackAssembly(index).Deff;

% Establish the binning conditions 
Bins=PixSize*(1:ceil(20.48/(PixSize/1000))+1);
[NumLoc,~,~,xID,yID]=histcounts2(1000*A,1000*B,Bins,Bins);

%Generate the density map
fig1=figure(1);
if HexFlag==false
    %Generate an image with square bins, return the image matrix
    DensityMap=imgaussfilt(NumLoc,[2 2]);
    DensityMap=DensityMap';
    scaleFactor=255/max(DensityMap,[],'all');
    imshow(scaleFactor*DensityMap, jet, 'Border','tight');
else
    %Generate an image with hexagonal bins
    DensityMap=hexscatter(1000*A,1000*B,'res',size(Bins,2)-1,'xlim',[0 max(Bins,[],'all')],'ylim',[0 max(Bins,[],'all')],'showZeros','true');
end
fig1.Position=[100 300 768 768];

%Generate the Diffusional Landscape
    fig2=figure(2);
    
    %Find linIndex of the bin down and right one from the actual bin (So
    %the [0,0] indexes of NaN's don't throw the result).
    linID=sub2ind([size(Bins,2) size(Bins,2)],xID+1,yID+1);

    if HexFlag==false
        %Acuumulate Deff's by pixel then normalize to # of localizations
        DeffMapLin=accumarray(linID(:),C(:));
        DeffMap=NaN(size(Bins,2)^2,1);
        DeffMap(1:size(DeffMapLin,1))=DeffMapLin;
        DeffMap=reshape(DeffMap,[size(Bins,2) size(Bins,2)]);
        PaddedNumLoc=zeros([size(Bins,2) size(Bins,2)]);
        PaddedNumLoc(2:end,2:end)=NumLoc;
        DeffMap=DeffMap./PaddedNumLoc;  
    end

    imDeff=DeffMap;
    imDeff(~isfinite(imDeff))=0;
    imDeff=imgaussfilt(imDeff,[2 2]);
    imDeff=imDeff';
    scaleFactor=255/max(imDeff,[],'all','omitnan');
    imshow(scaleFactor*imDeff, jet, 'Border','tight');
    
    fig2.Position=[800 300 768 768];

end