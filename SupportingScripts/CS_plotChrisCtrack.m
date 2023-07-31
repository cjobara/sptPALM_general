
function CS_plotChrisCtrack(CSstruct,index,CCid,SegColors,TrackIDflag)

% CSstruct - Contact Site structured array
% index - Contact site index
% CCid -the CCindex (i.e. CSstruct(index).trackCCids(TrackID)
% SegColors - the order of colors for plotting segments, must equal number
% of segmetns
% TrackIDflag - 1 if instead of a ccID, the ccID input is a TrackID


if nargin<=5
    TrackIDflag=0;
end

if TrackIDflag==0
    TrackID=find(CSstruct(index).tracksCCids==CCid);
end

CP = [1 find(CSstruct(index).ChPts(:,TrackID))' size(CSstruct(index).ChPts,1)];
    
if nargin==3
    LinesLUT=lines;
    SegColors=LinesLUT(1:size(CP,2)-1,:); 
end

if size(SegColors,1)~=size(CP,2)-1
      error('Color Inputs do not have right number of elements for number of states.');
end

    % Generate X, Y, and T variables of track for linear indexing
    x=CSstruct(index).CSmatrix(:,TrackID,2);
    y=CSstruct(index).CSmatrix(:,TrackID,3);
    t=CSstruct(index).CSmatrix(:,TrackID,1);

    % Plot the XY space representation
    figure;
    for i=1:size(CP,2)-1
       plot(x(CP(i):CP(i+1)),y(CP(i):CP(i+1)),'Color',SegColors(i,:),'LineWidth',1.5);
       hold on
    end
    xlim([-2 2])
    ylim([-2 2])
    set(gcf,'Position',[100 300 768 768]);
    set(gca, 'LineWidth', 1.5);
     plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
     
     %Plot the RT space representation
    figure;   
    for i=1:size(CP,2)-1
       plot(0.011*t(CP(i):CP(i+1))-0.011*t(CP(1)),sqrt(x(CP(i):CP(i+1)).^2+y(CP(i):CP(i+1)).^2),'Color',SegColors(i,:),'LineWidth',2);
       hold on
    end
    ylim([-0.5 2.5]);
    yline(0,'--','LineWidth',1.5);
    xlabel('Time  (sec)');
    ylabel('Position (\mum)');
    set(gcf,'Position',[900 350 1500 500]);
    set(gca,'FontSize',20);
    set(gca, 'LineWidth', 1.5);

    % Plot the XY w/ChPts space representation
    figure;
    ImpChPts=zeros(size(find(CSstruct(index).ChPts(:,TrackID)),1),1);
    for i=1:size(CP,2)-1
       plot(x(CP(i):CP(i+1)),y(CP(i):CP(i+1)),'Color',SegColors(i,:),'LineWidth',1.5);
       hold on
       if i>1
          if any(SegColors(i,:)-SegColors(i-1,:)) 
              ImpChPts(i-1)=1;
          end
       end
    end
    xlim([-0.5 0.5])
    ylim([-0.5 0.5])
    set(gcf,'Position',[800 700 500 500]);
    set(gca, 'LineWidth', 1.5);
     %plot(CSstruct(index).refboundary(:,1)/1000,CSstruct(index).refboundary(:,2)/1000,'k','LineWidth',1.5);
     
    ChPts=find(CSstruct(index).ChPts(:,TrackID)); 
    
    
    hold on
    scatter(x(ChPts(find(ImpChPts))),y(ChPts(find(ImpChPts))),50,'k','filled');
    
end