function CS_tessPlot(CSstruct, index, TrackStruct, TrajArray)


    if nargin==3
        TrajArray=[1:size(CSstruct(index).CSmatrix,2)];
    end

    close all

    figure(1);
    plot(CSstruct(index).CSmatrix(:,TrajArray,2),CSstruct(index).CSmatrix(:,TrajArray,3),'LineWidth',1.5);
    xlim([-1.5 1.5]);
    ylim([-1.5 1.5]);
    axis square
    hold on
    %plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
    
    
    figure(2);
    plot(CSstruct(index).CSmatrix(:,TrajArray,1),sqrt(CSstruct(index).CSmatrix(:,TrajArray,2).^2+CSstruct(index).CSmatrix(:,TrajArray,3).^2),'LineWidth',1.5);
    ylim([-0.5 3.5]);
    %xlim([0 2500]);
    hold on
    yline(0,'--');
    set(gcf,'Position',[50 250 2400 400]);
    
    figure(3);
    plot(CSstruct(index).CSmatrix(:,TrajArray,2),CSstruct(index).CSmatrix(:,TrajArray,3),'LineWidth',1.5);
    xlim([-0.5 0.5]);
    ylim([-0.5 0.5]);
    axis square
    hold on
    
    %Establish a summy variable for TessIndices needed
    A=CSstruct(index).TessIndex;
    B=unique(A(isfinite(A)));
    
    for i=1:size(B)
        
        hold on
        plot(TrackStruct(CSstruct(index).cellIndex).JBM.voronoi_x{B(i)}-CSstruct(index).refCenter(1),TrackStruct(CSstruct(index).cellIndex).JBM.voronoi_y{B(i)}-CSstruct(index).refCenter(2),'k','LineWidth',1.5);
    end
    
   
    
    



end