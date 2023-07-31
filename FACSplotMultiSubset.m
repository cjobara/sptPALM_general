function FACSplotMultiSubset(SegInfo,subset)

    
    figure(1)
    hold on
    scatter(log10(SegInfo{subset,3}),log10(SegInfo{subset,4}),30,'filled');
    set(gcf,'Position',[50 300 768 768]);
    title('Trajectory Segment Properties');
    xlabel('Log_{10} Segment Length');
    ylabel('Log_{10} D to F ratio');
    set(gca,'FontSize',20);
    set(gca, 'LineWidth', 1.5);
    
    
    figure(2)
    hold on
    scatter(log10(SegInfo{subset,3}),log10(mean(SegInfo{subset,5},2)),30,'filled');
    set(gcf,'Position',[850 300 768 768]);
    title('Trajectory Segment Properties');
    xlabel('Log_{10} Segment Length');
    ylabel('Log_{10} F eiganvalues');
    set(gca,'FontSize',20);
    set(gca, 'LineWidth', 1.5);
    
    
    figure(3)
    hold on
    scatter(log10(SegInfo{subset,3}),log10(mean(SegInfo{subset,6},2)),30,'filled');
    set(gcf,'Position',[1650 300 768 768]);
    title('Trajectory Segment Properties');
    xlabel('Log_{10} Segment Length');
    ylabel('Log_{10} D eigenvalues \mum^{2}');
    set(gca,'FontSize',20);
    set(gca, 'LineWidth', 1.5);






end