  
% Track Importer v.3

% Imports tracks in TrackMate format, generates a structured matrix from
% each file with the following variables: file (name), lengths, matrix,
% StepSizes, CSD, and MSD.


% Get the names of all the files in the input folder

Files=dir(fullfile(pwd, '*.xlsx')); 

[NumFiles,~]=size(Files);
    
files={Files.name};

Tracks=struct('file', [], 'lengths', [], 'matrix', [], 'center', [], 'rawSteps', [], 'steps', [],  'rawVector', [], 'vector', []);

%
 for i=1:NumFiles
    
    % Record the name of the file
    filename=char(files(i))
    [~,L]=size(filename);
    filebase=filename(1:L-5);
    
    Tracks(i).file=filebase;

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
        if TrackLengths(NumberTracks)~=nSpots(j) || abs(y(j)-y(j-1))>0.8 || abs(x(j)-x(j-1))>0.8 || abs(t(j)-t(j-1))>10 || t(j)-t(j-1)<=0
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
        if TrackLengths(TrackNumber)~=nSpots(j) || abs(y(j)-y(j-1))>0.8 || abs(x(j)-x(j-1))>0.8 || abs(t(j)-t(j-1))>10 || t(j)-t(j-1)<=0
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
    
    % Record the TrackMatrix
    
    Tracks(i).matrix=TrackMatrix;
    Tracks(i).center=bsxfun(@minus, Tracks(i).matrix, Tracks(i).matrix(1,:,:));    

% Calculate the CSD and MSD variables
     
    [m,n,~]=size(Tracks(i).matrix);
    
    DeltaT=NaN(m-1,n,m-1);
    DeltaS=NaN(m-1,n,m-1);
    
    for j=1:m-1
        
        DeltaT(1:m-j,:,j)=Tracks(i).matrix(1+j:m,:,1)-Tracks(i).matrix(1:m-j,:,1);
        DeltaS(1:m-j,:,j)=sqrt((Tracks(i).matrix(1+j:m,:,2)-Tracks(i).matrix(1:m-j,:,2)).^2+(Tracks(i).matrix(1+j:m,:,3)-Tracks(i).matrix(1:m-j,:,3)).^2);
        
    end
    
    Tracks(i).rawSteps(:,:,1)=DeltaT(:,:,1);
    Tracks(i).rawSteps(:,:,2)=DeltaS(:,:,1);
    
    Tracks(i).steps=DeltaS(:,:,1)./DeltaT(:,:,1);
       
    Tracks(i).rawVector(:,:,1)=diff(Tracks(i).matrix(:,:,2),1,1);
    Tracks(i).rawVector(:,:,2)=diff(Tracks(i).matrix(:,:,3),1,1);
    
    Tracks(i).vector=bsxfun(@rdivide,Tracks(i).rawVector,Tracks(i).rawSteps(:,:,1));
    
    
end

save('TrackStruct', 'Tracks','-v7.3'  );
clear;
