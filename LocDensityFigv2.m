% Plot Step Density

function LocDensityFigv2(TrackStruct,index,PixSize,offset)

if nargin==3 
    offset=[0 0];
end

x=offset(1);
y=offset(2);

close all

Bins=PixSize*(1:ceil(20.48/(PixSize/1000))+1);

Hraw=histogram2(1000*TrackStruct(index).matrix(:,:,2),1000*TrackStruct(index).matrix(:,:,3),Bins,Bins,'DisplayStyle','tile');
set(gcf,'Position',[100 400 768 768]);

imG=30*imgaussfilt(Hraw.Values,[2 2]);
fig3=figure(3);
imshow(uint8(imG), jet);
fig3.Position=[1700 400 768 768];
Total=TrackStruct(index).matrix(:,:,2);
Total(~isfinite(Total))=0;
NormTotal=sum(sum(logical(Total)));
disp(strcat('Total Localizations is :',num2str(NormTotal)));
disp(strcat('Axis max is :',num2str((255/30)/NormTotal,2)));

saveas(fig3, strcat('Cell_', num2str(index), '_Densities.jpg'));
ChrisPrograms.saveastiff(imG,fullfile(pwd, strcat('Cell_', num2str(index), '_Densities.tif')));

%imS=double(imS);
%NormFactor=sum(sum(imS,1),2);
%imSnorm=bsxfun(@rdivide,imS,NormFactor);

%PixLoc=ceil(6.25*TrackStruct(index).matrix(:,:,2:3))+1;
%PixLoc(:,:,1)=PixLoc(:,:,1)+x;
%PixLoc(:,:,2)=PixLoc(:,:,2)+y;

%PixLoc(PixLoc==0)=1;
%LinIndex=sub2ind(size(imS),PixLoc(:,:,1),PixLoc(:,:,2),TrackStruct(index).matrix(:,:,1)+1);
%ProbCoeff=zeros(size(LinIndex));

%for i=1:size(TrackStruct(index).matrix,2)
    
%    ProbCoeff(1:TrackStruct(index).lengths(i),i)=imSnorm(LinIndex(1:TrackStruct(index).lengths(i),i));
    
%end
    
%[~,~,~,binX,binY]=histcounts2(1000*TrackStruct(index).matrix(:,:,2),1000*TrackStruct(index).matrix(:,:,3),Bins,Bins);

%Hnorm=zeros(Hraw.NumBins);

%for i=1:size(ProbCoeff,2)
    
 %   for j=1:TrackStruct(index).lengths(i)
        
   %     Hnorm(binX(j,i)+1,binY(j,i)+1)=Hnorm(binX(j,i)+1,binY(j,i)+1)+1/ProbCoeff(j,i);
        
  %  end
       
%end

DensityMatrix=struct('X',TrackStruct(index).matrix(:,:,2),'Y',TrackStruct(index).matrix(:,:,3),'t',TrackStruct(index).matrix(:,:,1))%,'ProbCoeff',ProbCoeff,'imS',imS,'imSnorm',imSnorm,'Hnorm',Hnorm);

%save('DensityMatrix','DensityMatrix','-v7.3');

%fig2=figure(2);
%imN=imgaussfilt(Hnorm,[2 2]);
%imshow(uint16(imN/550), jet);
%fig2.Position=[900 400 768 768];


end

