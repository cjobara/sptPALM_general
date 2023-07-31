function CSDplotterTau(t, X, Y)

    Steps=diff(X,1,1).^2+diff(Y,1,1).^2;
    CSD=NaN(size(X,1)-1,size(X,2));
    
    for i=1:size(Steps,1)
        
        CSD(i,:)=sum(Steps(1:i,:),1);
        
    end

    fig1=figure(1);
    plot(t(2:end),CSD);
    fig1.Position=[100 400 768 768];
    xlabel('Time (sec)');
    ylabel('Cumulative Squared Displacement (\mum^2)');

end