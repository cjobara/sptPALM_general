
function CS_plotChPts(CSstruct,index)


 close all
    
 %set up the fig and plot the trajectories in grey and the boundary in
 %black
    figure(1);
    plot(CSstruct(index).CSmatrix(:,:,2),CSstruct(index).CSmatrix(:,:,3),'Color', [0.4 0.4 0.4],'LineWidth',1.5);
    xlim([-0.5 0.5]);
    ylim([-0.5 0.5]);
    hold on
    plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
    set(gcf,'Position',[100 300 768 768]); 
    
 %Find which data points have ChPts at them
    ChPts=find(CSstruct(index).ChPts);
    X=CSstruct(index).CSmatrix(:,:,2);
    Y=CSstruct(index).CSmatrix(:,:,3);
    
 %Add to figure! :-D   
    scatter(X(ChPts),Y(ChPts),'r', 'filled');

end