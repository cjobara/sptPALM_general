
function PlotChrisCOverlay(ChrisC,index,imS,imSize,SegColors)

    if size(size(imS),2)>=4
        error('Choose the single plane of theiamge you want overlayed on first.');
    end
    
    close all
    CP=[1 find(ChrisC(index).cp)' size(ChrisC(index).cp,1)];
    
    if nargin==3
        imSize=20.48; %Default image size in microns
        LinesLUT=lines;
        SegColors=LinesLUT(1:size(CP,2)-1,:); 
    end
    
    if nargin==4
        LinesLUT=lines;
        SegColors=LinesLUT(1:size(CP,2)-1,:); 
    end
    
    if size(SegColors,1)~=size(CP,2)-1
        error('Color Inputs do not have right number of elements for number of states.');
    end
    
    %Figure out where to draw the axes
    figure(1);
    plot(ChrisC(index).x,ChrisC(index).y);
    Xrange=xlim;
    Yrange=ylim;
    
    %Make the final Image square and centered
    if range(Xrange)>=range(Yrange)
        X=Xrange;
        Y=[mean(Yrange)-range(X)/2 mean(Yrange)+range(X)/2];
    else
        Y=Yrange;
        X=[mean(Xrange)-range(Y)/2 mean(Xrange)+range(Y)/2];
    end
    
    %Wipe the image and show the context
    hold off
    imshow(imS,'Border','tight');
    
    %Establish the scaling and offset for the overlay
    SF=size(imS,1)/imSize; % Need to change the size positionnin microns to pixel units
          
    for i=1:size(CP,2)-1
       fig1=figure(1);
      % imshow(255*ones(128,128,3),'Border','tight');
       hold on
       plot(SF*ChrisC(index).x(CP(i):CP(i+1)),SF*ChrisC(index).y(CP(i):CP(i+1)),'Color',SegColors(i,:),'LineWidth',1.5);
       fig1.Position=[100 300 768 768];
       
       fig2=figure(2);
       plot(0.011*ChrisC(index).t(CP(i):CP(i+1))-0.011*ChrisC(index).t(CP(1)),sqrt(ChrisC(index).x(CP(i):CP(i+1)).^2+ChrisC(index).y(CP(i):CP(i+1)).^2),'Color',SegColors(i,:),'LineWidth',2);
       hold on
       fig2.InnerPosition=[400 75 768+384 384];
       xlabel('Time  (sec)');
       ylabel('Position (\mum)');
       set(fig2,'Position',[300 70 1500 500]); 
       set(gca,'FontSize',20);
       set(gca, 'LineWidth', 1.5);
        
    end
        
    figure(1)
    xlim(SF*X);
    ylim(SF*Y);
        
end