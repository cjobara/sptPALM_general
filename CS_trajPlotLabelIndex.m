function CS_trajPlotLabelIndex(CSstruct, index, TrajArray)

    %Note TrajArray is the location in the CS array, not the original cell
    %matrix

    if nargin==2
        TrajArray=1:size(CSstruct(index).CSmatrix,2);
    end
    labels=string(TrajArray);

   % close all

    figure;
    plot(CSstruct(index).CSmatrix(:,TrajArray,2),CSstruct(index).CSmatrix(:,TrajArray,3),'LineWidth',1.5);
    xlim([-1.5 1.5]);
    ylim([-1.5 1.5]);
    hold on
    plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
    text(CSstruct(index).CSmatrix(1,TrajArray,2)',CSstruct(index).CSmatrix(1,TrajArray,3)',labels');
    
    figure;
    plot(CSstruct(index).CSmatrix(:,TrajArray,1),sqrt(CSstruct(index).CSmatrix(:,TrajArray,2).^2+CSstruct(index).CSmatrix(:,TrajArray,3).^2),'LineWidth',1.5);
    ylim([-0.5 3.5]);
    xlim([0 2500]);
    hold on
    yline(0,'--');
    set(gcf,'Position',[50 250 2400 400]);
    xlabel('Frames');
    ylabel('Position (\mum)');
    set(gca,'FontSize',20);

    T=CSstruct(index).CSmatrix(:,TrajArray,1);
    X=CSstruct(index).CSmatrix(:,TrajArray,2);
    Y=CSstruct(index).CSmatrix(:,TrajArray,3);
    [~,Loc]=max(CSstruct(index).CSmatrix(:,TrajArray,1),[],1,"omitnan");
    LastPtsInd=sub2ind(size(T),Loc,1:size(T,2));
    text(T(LastPtsInd),sqrt(X(LastPtsInd).^2+Y(LastPtsInd).^2), labels);
    
  


end