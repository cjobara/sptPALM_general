
function PlotChrisCFACSplot(SegInfo,AxesLoc)

    % AxesLoc tells you where to look in SegInfo for the axes to be plotted
    
    if nargin==1
        AxesLoc=[3 4];
    end
    
    if size(SegInfo{1,AxesLoc(1)},2)>=2
        Xcoord=mean(SegInfo{:,AxesLoc(1)},2);
    else
        Xcoord=SegInfo{:,AxesLoc(1)};
    end
    
    if size(SegInfo{1,AxesLoc(2)},2)>=2
        Ycoord=mean(SegInfo{:,AxesLoc(2)},2);
    else
        Ycoord=SegInfo{:,AxesLoc(2)};
    end
    
    

    dscatter(log10(Xcoord),log10(Ycoord));
    colormap(jet)
    set(gcf,'Position',[50 300 768 768]);
    title('Trajectory Segment Properties');
    xlabel('Log_{10} Segment Length');
    ylabel('Log_{10} D to F ratio');
    set(gca,'FontSize',20);
    set(gca, 'LineWidth', 1.5);


end