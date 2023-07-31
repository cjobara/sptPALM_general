
function PlotChrisCSegsOverlay(ChrisC,index,SegInfo,SegColors,subset)

    %ChrisC is track variable
    %index is which track
    %SegInfo is the segment analysis table for the ChrisC structure
    %SegColors is a column vector of RGB triplets for each segment in order
    %Subset is the linear indices of the segmetns you want colored/analyzed


    %Find how many segmets are in the track and how many segments have data
     CP=[1 find(ChrisC(index).cp)' size(ChrisC(index).cp,1)];
     Segs=find(ChrisC(index).segIDbySeg);
     
    %Set up the color scheme for the analyzed tracks
    if nargin==3
        LinesLUT=lines;
        SegColors=LinesLUT(1:size(Segs,2),:); 
    end
    
    if nargin==5
        Segs=Segs(subset);
    end
    
     if size(SegColors,1)~=size(Segs,2)
        error('Color Inputs do not have right number of elements for number of states.');
    end
     

     figure;
     plot(ChrisC(index).x(:),ChrisC(index).y(:),'Color',[0.4 0.4 0.4]);
     hold on
     title(['ChrisC Track Number ',num2str(index)]);
    for j=1:size(Segs,2)
        i=Segs(j);
       plot(ChrisC(index).x(CP(i):CP(i+1)),ChrisC(index).y(CP(i):CP(i+1)),'Color',SegColors(j,:),'LineWidth',1.5);
       X=mean(ChrisC(index).x(CP(i):CP(i+1)),'all');
       Y=mean(ChrisC(index).y(CP(i):CP(i+1)),'all');
       Dvec=squeeze(SegInfo{ChrisC(index).segIDbySeg(i),8});
       Fvec=squeeze(SegInfo{ChrisC(index).segIDbySeg(i),8});
       quiver([X X],[Y Y],Dvec(1,:),Dvec(2,:),'r');
       quiver([X X],[Y Y],Fvec(1,:),Fvec(2,:),'b');
       
    end
    set(gcf,'Position',[50 300 768 768]);
   
       
    figure;
    plot(0.011*ChrisC(index).t(:)-0.011*ChrisC(index).t(CP(1)),sqrt(ChrisC(index).y(:).^2+ChrisC(index).x(:).^2),'Color',[0.4 0.4 0.4]);
    title(['ChrisC Track Number ',num2str(index)]);
    xlabel('Time  (sec)');
    ylabel('Position (\mum)');
    set(gcf,'Position',[900 350 1500 500]); 
    set(gca,'FontSize',20);
    set(gca, 'LineWidth', 1.5);
    hold on
    for j=1:size(Segs,2)
        i=Segs(j);
       plot(0.011*ChrisC(index).t(CP(i):CP(i+1))-0.011*ChrisC(index).t(CP(1)),sqrt(ChrisC(index).x(CP(i):CP(i+1)).^2+ChrisC(index).y(CP(i):CP(i+1)).^2),'Color',SegColors(j,:),'LineWidth',2);   
    end


end