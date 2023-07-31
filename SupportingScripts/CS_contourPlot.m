function CS_contourPlot(CSstruct, index, TrackStruct, TrajArray)


    if nargin==3
        TrajArray=1:size(CSstruct(index).CSmatrix,2);
    end

    CS_Deff_rho_plot(CSstruct,index);
 
    figure(3);
    plot(CSstruct(index).CSmatrix(:,TrajArray,2),CSstruct(index).CSmatrix(:,TrajArray,3),'LineWidth',1.5);
    xlim([-0.5 0.5]);
    ylim([-0.5 0.5]);
    hold on
    %plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
    set(gcf,'Position',[1200 300 500 500]);
    
    
    figure(4);
    plot(CSstruct(index).CSmatrix(:,TrajArray,1),sqrt(CSstruct(index).CSmatrix(:,TrajArray,2).^2+CSstruct(index).CSmatrix(:,TrajArray,3).^2),'LineWidth',1.5);
    ylim([-0.5 3.5]);
    %xlim([0 2500]);
    hold on
    yline(0,'--','LineWidth',1.5);
    set(gcf,'Position',[50 850 2400 400]);
    xlabel('Time  (sec)');
    ylabel('Position (\mum)');
    set(gca,'FontSize',20);
    
    %Establish a summy variable for TessIndices needed
    A=CSstruct(index).TessIndex;
    B=unique(A(isfinite(A)));
    
    figure(3)
    
    for i=1:size(B)
        
        hold on
        plot(TrackStruct(CSstruct(index).cellIndex).JBM.voronoi_x{B(i)}-CSstruct(index).refCenter(1),TrackStruct(CSstruct(index).cellIndex).JBM.voronoi_y{B(i)}-CSstruct(index).refCenter(2),'k','LineWidth',1.5);
    end
    
    %Generate the xy grid to map contours from
    xv=linspace(-0.5,0.5,40);
    yv=linspace(-0.5,0.5,40);
    [X,Y]=ndgrid(xv,yv);
    
    %Generate dummy variables for linear indexing by CS matrix
%     A=CSstruct(index).CSmatrix(:,:,2);
%     B=CSstruct(index).CSmatrix(:,:,3);
%     C=CSstruct(index).Deff;
%     DataInd=find(isfinite(C));
    
    %Generate dummy variables for linear indexing by Track Matrix
    A=TrackStruct(CSstruct(index).cellIndex).matrix(:,:,2);
    B=TrackStruct(CSstruct(index).cellIndex).matrix(:,:,3);
    C=TrackStruct(CSstruct(index).cellIndex).Deff;
        %Cut it down to the ones in the CSproper and center on CS
    A=A(CSstruct(index).refLocIDs)-CSstruct(index).refCenter(1);
    B=B(CSstruct(index).refLocIDs)-CSstruct(index).refCenter(2);
    C=C(CSstruct(index).refLocIDs);
    DataInd=find(isfinite(C));
    
    %Interpolate through x and y space to make a grid
    Z=griddata(A(DataInd),B(DataInd),C(DataInd),X,Y);
   
    figure(5);
    contour(X,Y,Z,'LineWidth',1.5);
    xlim([-0.5 0.5]);
    ylim([-0.5 0.5]);
    hold on
    %plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
    set(gcf,'Position',[1750 300 500 500]);
    



end