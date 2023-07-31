function CS_trajPlotv2(CSstruct, index, TrajArray)


    if nargin==2
        TrajArray=1:size(CSstruct(index).CSmatrix,2);
    end

   % close all

    figure;
    plot(CSstruct(index).CSmatrix(:,TrajArray,2),CSstruct(index).CSmatrix(:,TrajArray,3),'LineWidth',1.5);
    xlim([-1.5 1.5]);
    ylim([-1.5 1.5]);
    axis square
    hold on
    plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
    
    
    figure;
    X=CSstruct(index).CSmatrix(:,:,2);
    Y=CSstruct(index).CSmatrix(:,:,3);
    T=CSstruct(index).CSmatrix(:,:,1);
    scatter(0.011*T(CSstruct(index).CSLocIDs),sqrt(X(CSstruct(index).CSLocIDs).^2+Y(CSstruct(index).CSLocIDs).^2),[],'blue');
            hold on
    scatter(0.011*T(CSstruct(index).CSneighborIDs),sqrt(X(CSstruct(index).CSneighborIDs).^2+Y(CSstruct(index).CSneighborIDs).^2),[],'MarkerEdgeColor',[0.4 0.4 0.4]);
    plot(0.011*CSstruct(index).CSmatrix(:,TrajArray,1),sqrt(CSstruct(index).CSmatrix(:,TrajArray,2).^2+CSstruct(index).CSmatrix(:,TrajArray,3).^2),'LineWidth',1.5);
    ylim([-0.5 3.5]);
    %xlim([0 2500]);

    yline(0,'--');
    set(gcf,'Position',[50 250 2400 400]);
    xlabel('Time (sec)');
    ylabel('Distance from CS Center (\mum)');
    set(gca,'FontSize',20);
  


end