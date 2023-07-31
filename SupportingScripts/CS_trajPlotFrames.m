function CS_trajPlotFrames(CSstruct, index, TrajArray)


    if nargin==2
        TrajArray=1:size(CSstruct(index).CSmatrix,2);
    end

   % close all

    figure;
    plot(CSstruct(index).CSmatrix(:,TrajArray,2),CSstruct(index).CSmatrix(:,TrajArray,3),'LineWidth',1.5);
    xlim([-1.5 1.5]);
    ylim([-1.5 1.5]);
    hold on
    plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
    
    
    figure;
    plot(CSstruct(index).CSmatrix(:,TrajArray,1),sqrt(CSstruct(index).CSmatrix(:,TrajArray,2).^2+CSstruct(index).CSmatrix(:,TrajArray,3).^2),'LineWidth',1.5);
    ylim([-0.5 3.5]);
    %xlim([0 2500]);
    hold on
    yline(0,'--');
    set(gcf,'Position',[50 250 2400 400]);
    xlabel('Time  (sec)');
    ylabel('Position (\mum)');
    set(gca,'FontSize',20);
  


end