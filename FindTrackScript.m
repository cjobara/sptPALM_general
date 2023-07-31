

%To run this you must have Tracks or Figure already open, and predefine the
%cell you want to use as "index". I.e. index=3 for the third cell.


roi=drawrectangle;

Xrange=xlim;
Yrange=ylim;

if Xrange(2)-Xrange(1)>128
    %X axis is time
    if exist('Tracks','var')
        Xl=Tracks(index).matrix(:,:,1)>=roi.Position(1);
        Xu=Tracks(index).matrix(:,:,1)<=(roi.Position(1)+roi.Position(3));
    elseif exist('Figure','var')
        Xl=Figure(index).matrix(:,:,1)>=roi.Position(1);
        Xu=Figure(index).matrix(:,:,1)<=(roi.Position(1)+roi.Position(3));
    else
        error('Cannot find Trajectory Structure in open variables.')
    end
    disp(['X-axis is time. Range is: ',num2str(roi.Position(1)),' to ',num2str((roi.Position(1)+roi.Position(3))),' frames']);
elseif Xrange(2)-Xrange(1)>20.48
    % X-axis is pixels
    if exist('Tracks','var')
        Xl=Tracks(index).matrix(:,:,2)>=roi.Position(1)/6.25;
        Xu=Tracks(index).matrix(:,:,2)<=(roi.Position(1)+roi.Position(3))/6.25;
    elseif exist('Figure','var')
        Xl=Figure(index).matrix(:,:,2)>=roi.Position(1)/6.25;
        Xu=Figure(index).matrix(:,:,2)<=(roi.Position(1)+roi.Position(3))/6.25;
    else
        error('Cannot find Trajectory Structure in open variables.')
    end    
    disp(['X-axis is pixels. Range is: ',num2str(roi.Position(1)/6.25),' to ',num2str((roi.Position(1)+roi.Position(3))/6.25),' microns']);
else
    % X-axis is Microns
    if exist('Tracks','var')
        Xl=Tracks(index).matrix(:,:,2)>=roi.Position(1);
        Xu=Tracks(index).matrix(:,:,2)<=(roi.Position(1)+roi.Position(3));
    elseif exist('Figure','var')
        Xl=Figure(index).matrix(:,:,2)>=roi.Position(1);
        Xu=Figure(index).matrix(:,:,2)<=(roi.Position(1)+roi.Position(3));
    else
        error('Cannot find Trajectory Structure in open variables.')
    end
    disp(['X-axis is microns. Range is: ',num2str(roi.Position(1)),' to ',num2str((roi.Position(1)+roi.Position(3))),' microns']);
end

if Yrange(2)-Yrange(1)>128
    %Y axis is time
    if exist('Tracks','var')
        Yl=Tracks(index).matrix(:,:,1)>=roi.Position(2);
        Yu=Tracks(index).matrix(:,:,1)<=(roi.Position(2)+roi.Position(4));
    elseif exist('Figure','var')
        Yl=Figure(index).matrix(:,:,1)>=roi.Position(2);
        Yu=Figure(index).matrix(:,:,1)<=(roi.Position(2)+roi.Position(4));
    else
        error('Cannot find Trajectory Structure in open variables.')
    end
    disp(['Y-axis is time. Range is: ',num2str(roi.Position(2)),' to ',num2str((roi.Position(2)+roi.Position(4))),' frames']);
elseif Yrange(2)-Yrange(1)>20.48
    % Y-axis is pixels
    if exist('Tracks','var')
        Yl=Tracks(index).matrix(:,:,3)>=roi.Position(2)/6.25;
        Yu=Tracks(index).matrix(:,:,3)<=(roi.Position(2)+roi.Position(4))/6.25;
    elseif exist('Figure','var')
        Yl=Figure(index).matrix(:,:,3)>=roi.Position(2)/6.25;
        Yu=Figure(index).matrix(:,:,3)<=(roi.Position(2)+roi.Position(4))/6.25;
    else
        error('Cannot find Trajectory Structure in open variables.')
    end
    disp(['Y-axis is pixels. Range is: ',num2str(roi.Position(2)/6.25),' to ',num2str((roi.Position(2)+roi.Position(4))/6.25),' microns']);
else
    % Y-axis is Microns
    if exist('Tracks','var')
        Yl=Tracks(index).matrix(:,:,3)>=roi.Position(2);
        Yu=Tracks(index).matrix(:,:,3)<=(roi.Position(2)+roi.Position(4));
    elseif exist('Figure','var')
        Yl=Figure(index).matrix(:,:,3)>=roi.Position(2);
        Yu=Figure(index).matrix(:,:,3)<=(roi.Position(2)+roi.Position(4));
    else
        error('Cannot find Trajectory Structure in open variables.')
    end
    disp(['Y-axis is microns. Range is: ',num2str(roi.Position(2)),' to ',num2str((roi.Position(2)+roi.Position(4))),' microns']);
end

    LogMatrix=Xl.*Yl.*Xu.*Yu;
    ReadLine=sum(LogMatrix,1);
    
    TrackIndex=find(ReadLine);  
