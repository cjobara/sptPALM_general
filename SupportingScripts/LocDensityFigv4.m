% Plot Step Density

function [imG,DeffMatrix]=LocDensityFigv4(TrackStruct,index,PixSize)

close all

Bins=PixSize*(1:ceil(20.48/(PixSize/1000))+1);

fig1=figure(1);

Hraw=histogram2(1000*TrackStruct(index).matrix(:,:,2),1000*TrackStruct(index).matrix(:,:,3),Bins,Bins,'DisplayStyle','tile');
set(gcf,'Position',[100 300 768 768]);
%LocDensity=Hraw;
[C,~,~,binX,binY]=histcounts2(1000*TrackStruct(index).matrix(:,:,2),1000*TrackStruct(index).matrix(:,:,3),Bins,Bins);
imG=30*imgaussfilt(Hraw.Values,[2 2]);
imG=imG';
fig3=figure(3);
imshow(uint8(imG), turbo, 'Border','tight');
fig3.Position=[800 300 768 768];
Total=TrackStruct(index).matrix(:,:,2);
Total(~isfinite(Total))=0;
NormTotal=sum(sum(logical(Total)));
disp(strcat('Total Localizations is :',num2str(NormTotal)));
disp(strcat('Axis max is :',num2str((255/30)/NormTotal,2)));


%Deff bin

DeffMatrix=zeros(size(C));

for i=1:size(TrackStruct(index).Deff(:),1)
    if binX(i)~=0
        DeffMatrix(binX(i),binY(i))=DeffMatrix(binX(i),binY(i))+TrackStruct(index).Deff(i);
    end
end

% for i=1:max(binX,[],'all')
%     
%     for j=1:max(binY,[],'all')
%         A=((binX==i).*(binY==j));
%         D_ij=sum(A.*TrackStruct(index).Deff,'all','omitnan');
%         if sum(A,'all')~=C(i,j)
%             error('C is not lined up with X + Y');
%         end
%         
%    
%     DeffMatrix(i,j)=D_ij/C(i,j);
%     
%     end
%     
% end
DeffMatrix=DeffMatrix./C;

fig2=figure(2);
imshow(uint8(3*255*DeffMatrix), jet, 'Border','tight');
fig4=figure(4);

h=hexscatter(1000*TrackStruct(index).matrix(:,:,2),1000*TrackStruct(index).matrix(:,:,3),'res',683);
%close(fig1);

%saveas(fig3, strcat('Cell_', num2str(index), '_Densities.jpg'));
%ChrisPrograms.saveastiff(imG,fullfile(pwd, strcat('Cell_', num2str(index), '_Densities.tif')));

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

%DensityMatrix=struct('X',TrackStruct(index).matrix(:,:,2),'Y',TrackStruct(index).matrix(:,:,3),'t',TrackStruct(index).matrix(:,:,1))%,'ProbCoeff',ProbCoeff,'imS',imS,'imSnorm',imSnorm,'Hnorm',Hnorm);

save(strcat('Density_',TrackStruct(index).file,'.mat'),'imG','binX','binY','DeffMatrix');
%save('DensityMatrix','DensityMatrix','-v7.3');
ChrisPrograms.saveastiff(uint16(imG),strcat('Density_',TrackStruct(index).file,'.tif'));
%fig2=figure(2);
%imN=imgaussfilt(Hnorm,[2 2]);
%imshow(uint16(imN/550), jet);
%fig2.Position=[900 400 768 768];

%close(fig3);

end



        
