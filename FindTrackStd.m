

function TrackIndex=FindTrackStd(Tracks,index,subset)

if nargin==2 
    subset=1:size(Tracks(index).lengths,1);
end

roi=drawrectangle;

Xrange=xlim;
Yrange=ylim;

if Xrange(2)-Xrange(1)>128
    %X axis is time
    if exist('Tracks','var')
        Xl=Tracks(index).matrix(:,subset,1)>=roi.Position(1);
        Xu=Tracks(index).matrix(:,subset,1)<=(roi.Position(1)+roi.Position(3));
   
    else
        error('Trajectory Structure is not correct.')
    end
    disp(['X-axis is time. Range is: ',num2str(roi.Position(1)),' to ',num2str((roi.Position(1)+roi.Position(3))),' frames']);
    TimeFlag=1;
else
    % X-axis is Microns
    if exist('Tracks','var')
        Xl=Tracks(index).matrix(:,subset,2)>=roi.Position(1);
        Xu=Tracks(index).matrix(:,subset,2)<=(roi.Position(1)+roi.Position(3));
    else
        error('Trajectory Structure is not correct.')
    end
    disp(['X-axis is microns. Range is: ',num2str(roi.Position(1)),' to ',num2str((roi.Position(1)+roi.Position(3))),' microns']);
end

if Yrange(2)-Yrange(1)>128 
    %Y axis is time
    if exist('Tracks','var')
        Yl=Tracks(index).matrix(:,subset,1)>=roi.Position(2);
        Yu=Tracks(index).matrix(:,subset,1)<=(roi.Position(2)+roi.Position(4));
    else
        error('Trajectory Structure is not correct.')
    end
    disp(['Y-axis is time. Range is: ',num2str(roi.Position(2)),' to ',num2str((roi.Position(2)+roi.Position(4))),' frames']);

elseif Yrange(2)-Yrange(1)>23 && exist('TimeFlag','var')
    % Y-axis is image position (radius)
    if exist('Tracks','var')
        Yl=sqrt(Tracks(index).matrix(:,subset,2).^2+Tracks(index).matrix(:,subset,3).^2)>=roi.Position(2);
        Yu=sqrt(Tracks(index).matrix(:,subset,2).^2+Tracks(index).matrix(:,subset,3).^2)<=(roi.Position(2)+roi.Position(4));
    else
        error('Trajectory Structure is not correct.')
    end
    disp(['Y-axis is microns (radial). Range is: ',num2str(roi.Position(2)),' to ',num2str((roi.Position(2)+roi.Position(4))),' microns']);
else
    % Y-axis is Microns
    if exist('Tracks','var')
        Yl=Tracks(index).matrix(:,subset,3)>=roi.Position(2);
        Yu=Tracks(index).matrix(:,subset,3)<=(roi.Position(2)+roi.Position(4));
    else
        error('Trajectory Structure is not correct.')
    end
    disp(['Y-axis is microns. Range is: ',num2str(roi.Position(2)),' to ',num2str((roi.Position(2)+roi.Position(4))),' microns']);
end

    LogMatrix=Xl.*Yl.*Xu.*Yu;
    ReadLine=sum(LogMatrix,1);
  
if size(subset,2)==size(Tracks(index).lengths,1)
    TrackIndex=find(ReadLine);  
else
    TrackIndex=subset(logical(ReadLine));
end


end