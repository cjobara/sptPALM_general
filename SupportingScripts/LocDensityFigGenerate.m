
function imG=LocDensityFigGenerate(X,Y,PixSize,Dimensions)

    % PixSize is in nm, X and Y in microns, Dimensions as [Lower, Upper]
    % measured in output pixels. Asymmetric axes can be used in the format
    % [Xl Xu; Yl Yu];
    
    if size(Dimensions,1)==1
        Dimensions=[Dimensions;Dimensions];
    end
    
    Xl=Dimensions(1);
    Yl=Dimensions(2);
    Xu=Dimensions(3);
    Yu=Dimensions(4);
        
    BinsX=PixSize*(Xl:1:Xu);
    BinsY=PixSize*(Yl:1:Yu);
    
    [NumLoc,~,~,~,~]=histcounts2(1000*(X),1000*(Y),BinsX,BinsY);
    disp(['Total Localizations: ' num2str(sum(NumLoc,"all"))]);
    imG=imgaussfilt(NumLoc,[2 2]);
    imG=imG';
    imG=flipud(imG);
    cSF=255/(max(imG,[],'all','omitnan')-min(imG,[],'all','omitnan'));
    disp(['Max Loc: ' num2str(max(imG,[],'all','omitnan')) ' Min Loc: ' num2str(min(imG,[],'all','omitnan')) ]);
    
    imG=cSF*(imG-min(imG,[],'all','omitnan'));
    imG=uint8(imG);
       

end