
function PlotChrisCvec(ChrisC,index,SegColors)

  
     CP=[1 find(ChrisC(index).cp)' size(ChrisC(index).cp,1)];
    if nargin==2
        LinesLUT=lines;
        SegColors=LinesLUT(1:size(CP,2)-1,:); 
    end
    
    if size(SegColors,1)~=size(CP,2)-1
        error('Color Inputs do not have right number of elements for number of states.');
    end

    figure;
    for i=1:size(CP,2)-1
       plot(ChrisC(index).x(CP(i):CP(i+1)),ChrisC(index).y(CP(i):CP(i+1)),'Color',SegColors(i,:),'LineWidth',1.5);
       hold on
    end
     set(gcf,'Position',[100 300 768 768]);
     set(gca, 'LineWidth', 1.5);
       
    figure;
    for i=1:size(CP,2)-1
       plot(0.011*ChrisC(index).t(CP(i):CP(i+1))-0.011*ChrisC(index).t(CP(1)),sqrt(ChrisC(index).x(CP(i):CP(i+1)).^2+ChrisC(index).y(CP(i):CP(i+1)).^2),'Color',SegColors(i,:),'LineWidth',2);
       hold on
    end
    xlabel('Time  (sec)');
    ylabel('Position (\mum)');
    set(gcf,'Position',[900 350 1500 500]); 
    set(gca,'FontSize',20);
    set(gca, 'LineWidth', 1.5);



end