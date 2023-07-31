
function SegmentID=PlotTrackStates(ChrisCstruct,index,subsetLength)

if nargin==2

    close all
    fig1=figure(1);
    
    
    subplot(1,2,1)
    plot(ChrisCstruct(index).x,ChrisCstruct(index).y)
    hold on
    B=find(ChrisCstruct(index).cp);
    B=[1 B' size(ChrisCstruct(index).cp,1)]; %Add the endpoints
    
    for i=1:size(B,2)-1
        plot(ChrisCstruct(index).x(B(i):B(i+1)),ChrisCstruct(index).y(B(i):B(i+1)));
    end
    
    subplot(2,2,2)
    plot(0.011*(ChrisCstruct(index).t-ChrisCstruct(index).t(1)),ChrisCstruct(index).x);
    hold on
    xlabel('Time (sec)');
    ylabel('X Position (\mum)');
    xlim([0 0.011*(ChrisCstruct(index).t(end)-ChrisCstruct(index).t(1))]);
    subplot(2,2,4)
    plot(0.011*(ChrisCstruct(index).t-ChrisCstruct(index).t(1)),ChrisCstruct(index).y);
    hold on
    xlabel('Time (sec)');
    ylabel('Y Position (\mum)');
    xlim([0 0.011*(ChrisCstruct(index).t(end)-ChrisCstruct(index).t(1))]);
    
    for i=1:size(B,2)-1
        subplot(2,2,2)
        plot(0.011*(ChrisCstruct(index).t(B(i):B(i+1))-ChrisCstruct(index).t(1)),ChrisCstruct(index).x(B(i):B(i+1)));
        subplot(2,2,4)
        plot(0.011*(ChrisCstruct(index).t(B(i):B(i+1))-ChrisCstruct(index).t(1)),ChrisCstruct(index).y(B(i):B(i+1)));
    end
    
    for i=2:size(B,2)-1
       subplot(2,2,2) 
       xline(0.011*(ChrisCstruct(index).t(B(i))-ChrisCstruct(index).t(1)),':b','LineWidth',1.5);
       subplot(2,2,4)
       xline(0.011*(ChrisCstruct(index).t(B(i))-ChrisCstruct(index).t(1)),':b','LineWidth',1.5);
    end
    
    SegmentID=['There are ' num2str(size(B,2)-1) 'segments in Track' num2str(index)]

else 
    close all
    fig1=figure(1);
    
    subplot(1,2,1)
    plot(ChrisCstruct(index).x,ChrisCstruct(index).y)
    hold on
    B=find(ChrisCstruct(index).cp);
    B=[1 B' size(ChrisCstruct(index).cp,1)]; %Add the endpoints
    C=find(diff(B)==subsetLength+1);
    if isempty(C)
        C=find(diff(B)==subsetLength);
        if C==1
           C=1;
        else 
            C=[];
            disp('No track segment found at that length.');
        end
    end
    plot(ChrisCstruct(index).x(B(C):B(C+1)),ChrisCstruct(index).y(B(C):B(C+1)),'r');
    
    subplot(2,2,2)
    plot(0.011*(ChrisCstruct(index).t-ChrisCstruct(index).t(1)),ChrisCstruct(index).x)
    hold on
    plot(0.011*(ChrisCstruct(index).t(B(C):B(C+1))-ChrisCstruct(index).t(1)),ChrisCstruct(index).x(B(C):B(C+1)),'r');
    xlabel('Time (sec)');
    ylabel('X Position (\mum)');
    xlim([0 0.011*(ChrisCstruct(index).t(end)-ChrisCstruct(index).t(1))]);
    
    subplot(2,2,4)
    plot(0.011*(ChrisCstruct(index).t-ChrisCstruct(index).t(1)),ChrisCstruct(index).y)
    hold on
    plot(0.011*(ChrisCstruct(index).t(B(C):B(C+1))-ChrisCstruct(index).t(1)),ChrisCstruct(index).y(B(C):B(C+1)),'r');
    xlabel('Time (sec)');
    ylabel('Y Position (\mum)');
    xlim([0 0.011*(ChrisCstruct(index).t(end)-ChrisCstruct(index).t(1))]);
    
    SegmentID=C;
    
end

end