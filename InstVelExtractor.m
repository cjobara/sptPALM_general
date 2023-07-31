
% ExtractInstVelocities.m

% Run through TrackMate XML-->XLSX files to extract trajectories and
% calculate instantaneous speeds and velocities


%Find all the files named *.xlsx

Files=dir(fullfile(pwd, '*.xlsx')); 

[NumFiles,~]=size(Files);
    
files={Files.name};


% Loop through each file and make new sheets with desired data

for i=1:NumFiles
    
    % Get the file name
    filename=char(files(i))
    output=filename;
 
    
    % Import the data + parse variables
    filedata=xlsread(filename,1,'K:M');
    nSpots=xlsread(filename,1,'I:I');
    
    t=filedata(:,1);
    x=filedata(:,2);
    y=filedata(:,3);
    
    % Set up a loop to separate the individual tracks
    [SpotNumber, ~]= size(nSpots);
    TrackLengths=[];
    TrackLengths(1)=nSpots(1);
    NumberTracks=1;
    RealLengths=[];
    Counter=1;
    
    for j=2:SpotNumber
        if TrackLengths(NumberTracks)~=nSpots(j) %|| abs(y(j)-y(j-1))>0.8 || abs(x(j)-x(j-1))>0.8 || abs(t(j)-t(j-1))>5 || t(j)-t(j-1)<=0
            RealLengths(NumberTracks)=Counter;
            NumberTracks=NumberTracks+1;
            TrackLengths(NumberTracks)=nSpots(j);
            Counter=1;
        else
            Counter=Counter+1;
        end
    end
    RealLengths(NumberTracks)=Counter;
    
    % Record the lengths of each track
    Tracks(i).lengths=transpose(RealLengths);
    
    % Define iteration variables
    TrackNumber=1;
    TrackIndex=1;
    
    % Preallocate temp memory stash for each file's tracks
    TrackMatrix=NaN(max(RealLengths), NumberTracks, 3);
    
    % Iterate through each track from beginning to end
    
    % for the j=1 case (which makes the conditional operator undefined)
        TrackMatrix(TrackIndex,TrackNumber,1)=t(1);
        TrackMatrix(TrackIndex,TrackNumber,2)=x(1);
        TrackMatrix(TrackIndex,TrackNumber,3)=y(1);
    
    for j=2:SpotNumber
        if TrackLengths(TrackNumber)~=nSpots(j) %|| abs(y(j)-y(j-1))>0.8 || abs(x(j)-x(j-1))>0.8 || abs(t(j)-t(j-1))>5 || t(j)-t(j-1)<=0
            TrackNumber=TrackNumber+1;
            TrackIndex=1;
            TrackMatrix(TrackIndex,TrackNumber,1)=t(j);
            TrackMatrix(TrackIndex,TrackNumber,2)=x(j);
            TrackMatrix(TrackIndex,TrackNumber,3)=y(j);
        else
            TrackIndex=TrackIndex+1;
            TrackMatrix(TrackIndex,TrackNumber,1)=t(j);
            TrackMatrix(TrackIndex,TrackNumber,2)=x(j);
            TrackMatrix(TrackIndex,TrackNumber,3)=y(j);
        end
    
    end
    
    Xfinal=TrackMatrix(:,:,2);
    Yfinal=TrackMatrix(:,:,3);
    Tfinal=TrackMatrix(:,:,1);
    
    xlswrite(output, (Xfinal(2:end,:)-Xfinal(1:end-1,:))./(Tfinal(2:end,:)-Tfinal(1:end-1,:)), 'Instantaneous Velocities X');
    xlswrite(output, (Yfinal(2:end,:)-Yfinal(1:end-1,:))./(Tfinal(2:end,:)-Tfinal(1:end-1,:)), 'Instantaneous Velocities Y');
    xlswrite(output, sqrt((Xfinal(2:end,:)-Xfinal(1:end-1,:)).^2+(Yfinal(2:end,:)-Yfinal(1:end-1,:)).^2)./(Tfinal(2:end,:)-Tfinal(1:end-1,:)), 'Instantaneous Speeds');
    
        
    
    
    
end