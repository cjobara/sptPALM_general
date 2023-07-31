
function CS_ccPlot(CSstruct,index,TrajArray)

    if nargin==2
        TrajArray=find(isfinite(CSstruct(index).tracksCCids));
    end
    
    figure
    plot(CSstruct(index).CSmatrix(:,TrajArray,2),CSstruct(index).CSmatrix(:,TrajArray,3),'LineWidth',1.5);
    hold on
    plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
    set(gcf,'Position',[100 300 768 768])
    if CSstruct(index).MitoFlag==1
         title(['Mitochondria Contact Site Number ',num2str(index)]);
    else
         title(['Other Contact Site Number ',num2str(index)]);
    end
    
    figure
    plot(CSstruct(index).CSmatrix(:,TrajArray,1),sqrt(CSstruct(index).CSmatrix(:,TrajArray,2).^2+CSstruct(index).CSmatrix(:,TrajArray,3).^2),'LineWidth',1.5);
    ylim([-0.5 3.5]);
    %xlim([0 2500]);
    hold on
     if CSstruct(index).MitoFlag==1
         title(['Mitochondria Contact Site Number ',num2str(index)]);
    else
         title(['Other Contact Site Number ',num2str(index)]);
    end
    yline(0,'--');
    set(gcf,'Position',[900 350 1500 500]);
    
    for i=1:size(TrajArray,2)
        endIndex=max(find(isfinite(CSstruct(index).CSmatrix(:,TrajArray(i),1))),[],'all');
        text(CSstruct(index).CSmatrix(endIndex-100,TrajArray(i),1),sqrt(CSstruct(index).CSmatrix(endIndex-100,TrajArray(i),3).^2+CSstruct(index).CSmatrix(endIndex-100,TrajArray(i),2).^2)+0.2,['ChrisC Track ',num2str(CSstruct(index).tracksCCids(TrajArray(i)))]);
    end
    

end