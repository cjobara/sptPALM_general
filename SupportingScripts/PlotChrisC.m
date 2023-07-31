
function [X,Y]=PlotChrisC(ChrisC,index,SegColors)

%Note SegColors needs to be given in RGB triplet notation, so it should be
%an X by 3 matrix where X is the number of states in the track.

    close all
    CP=[1 find(ChrisC(index).cp)' size(ChrisC(index).cp,1)];
    if nargin==2
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
    
    %Wipe the image and make a white background
    hold off
    imshow(255*ones(128,128,3),'Border','tight');
    
    %Establish the scaling and offset for the overlay
    SF=128/range(X);
    OffsetX=X(1);
    OffsetY=Y(1);
       
    for i=1:size(CP,2)-1
       fig1=figure(1);
      % imshow(255*ones(128,128,3),'Border','tight');
       hold on
       plot(SF*ChrisC(index).x(CP(i):CP(i+1))-SF*OffsetX,SF*ChrisC(index).y(CP(i):CP(i+1))-SF*OffsetY,'Color',SegColors(i,:),'LineWidth',1.5);
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
        
        




end