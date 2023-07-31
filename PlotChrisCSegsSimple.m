
function PlotChrisCSegsSimple(ChrisC,index,SegColors)

    %Find how many segmets are in the track and how many segments have data
     CP=[1 find(ChrisC(index).cp)' size(ChrisC(index).cp,1)];
     Segs=find(ChrisC(index).segIDbySeg);
     
    %Set up the color scheme for the analyzed tracks
    if nargin==2
        LinesLUT=lines;
        SegColors=LinesLUT(1:size(Segs,2),:); 
    end
    
    if size(SegColors,1)~=size(Segs,2)
        error('Color Inputs do not have right number of elements for number of states.');
    end
     

     figure;
     plot(ChrisC(index).x(:),ChrisC(index).y(:),'Color',[0.4 0.4 0.4]);
     hold on
    for j=1:size(Segs,2)
        i=Segs(j);
       plot(ChrisC(index).x(CP(i):CP(i+1)),ChrisC(index).y(CP(i):CP(i+1)),'Color',SegColors(j,:),'LineWidth',1.5);
       
    end
    set(gcf,'Position',[100 300 768 768]);
   
       
    figure;
    plot(0.011*ChrisC(index).t(:),sqrt(ChrisC(index).y(:).^2+ChrisC(index).x(:).^2),'Color',[0.4 0.4 0.4]);
    xlabel('Time  (sec)');
    ylabel('Position (\mum)');
    set(gcf,'Position',[300 70 1500 500]); 
    set(gca,'FontSize',20);
    set(gca, 'LineWidth', 1.5);
    hold on
    for j=1:size(Segs,2)
        i=Segs(j);
       plot(0.011*ChrisC(index).t(CP(i):CP(i+1))-0.011*ChrisC(index).t(CP(1)),sqrt(ChrisC(index).x(CP(i):CP(i+1)).^2+ChrisC(index).y(CP(i):CP(i+1)).^2),'Color',SegColors(j,:),'LineWidth',2);   
    end


end