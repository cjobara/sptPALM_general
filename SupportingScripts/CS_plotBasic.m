function CS_plotBasic(CS,num)

    figure
    set(gcf,'Position',[300 200 1500 750]);
    subplot(2,2,[1 3])
    plot(CS(num).CSmatrix(:,:,2),CS(num).CSmatrix(:,:,3));
    title('XY space plot')
    xlim([-1.5 1.5])
    ylim([-1.5 1.5])
    subplot(2,2,2)
    plot(CS(num).CSmatrix(:,:,1),CS(num).CSmatrix(:,:,2));
    title('X vs T')
    yline(0,'--')
    subplot(2,2,4)
    plot(CS(num).CSmatrix(:,:,1),CS(num).CSmatrix(:,:,3));
    yline(0,'--')
    title('Y vs T')
    sgtitle(['Contact Site Number ',num2str(num)]);


end