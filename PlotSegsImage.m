
function PlotSegsImage(ChrisC,SegTable,IndArray,PlotNum)

% DON'T USE ME I NEED ATTENTION FIRST

%Note Orth variables are just ratios of the eig values, theya re not
%normalized for direction

if nargin==2
    IndArray=1:size(SegTable,1);
    PlotNum=size(IndArray,1);
end

if nargin==3
    PlotNum=size(IndArray,1)-1;
end

figure
imshow(255*ones(1200,1200,3),'Border','tight');
hold on

%Preallocate memory
D=NaN(size(IndArray,1),2);
F=NaN(size(IndArray,1),2);
OrthF=NaN(size(IndArray,1),1);
OrthD=NaN(size(IndArray,1),1);
DtoF=NaN(size(IndArray,1),1);

%Make a dummy variable to know when to stop plotting
Counter=0;

for i=1:size(IndArray)
    
    Counter=Counter+1;
    
    %Collect Stats for export
    D(i,:)=SegTable{IndArray(i),6};
    F(i,:)=SegTable{IndArray(i),5};
    if F(i,1)>=F(i,2)
        OrthF(i)=F(i,1)/F(i,2);
    else
        OrthF(i)=F(i,2)/F(i,1);
    end
    if D(i,1)>D(i,2)
        OrthD(i)=D(i,1)/D(i,2);
    else
        OrthF(i)=F(i,2)/F(i,1);
    end
    DtoF(i)=SegTable{IndArray(i),4};
    
    if Counter<=PlotNum
        
        %Extract the x and y values from ChrisC
        X=ChrisC(SegTable{IndArray(i),1}).x;
        Y=ChrisC(SegTable{IndArray(i),1}).y;
        
        %Find the segment bounds
        Track_ind=find(ChrisC(SegTable{IndArray(i),1}).segNum==SegTable{IndArray(i),2});
        
        %Plot the segment
        %Use this line for centered on mean value
        %    plot(X(Track_ind)-mean(X(Track_ind),'omitnan'),Y(Track_ind)-mean(Y(Track_ind),'omitnan'));
        
        %Use this line for plotted at segment origin
            plot(1000*X(Track_ind)-X(Track_ind(1))+600,1000*Y(Track_ind)-Y(Track_ind(1))+600);
    end
    
end

D_bar=mean(D,'all','omitnan');
F_bar=mean(F,'all','omitnan');
OrthF_bar=median(abs(OrthF),'all','omitnan');
OrthD_bar=median(abs(OrthD),'all','omitnan');
DtoF_bar=median(D,'all','omitnan');


end