  
% Track Importer v.3

% Imports tracks in TrackMate format, generates a structured matrix from
% each file with the following variables: file (name), lengths, matrix,
% StepSizes, CSD, and MSD.


% Get the names of all the files in the input folder

Files=dir(fullfile(pwd, '*.xlsx')); 

[NumFiles,~]=size(Files);
    
files={Files.name};

Tracks=struct('file', [], 'lengths', [], 'matrix', [], 'center', [], 'rawSteps', [], 'steps', [], 'MSDdata', [], 'MSD', [], 'MSDerror', [],'MSDstdev', [], 'CSD', [], 'CSDnorm', []);

 for i=1:NumFiles
    
    % Record the name of the file
    filename=char(files(i))
    [~,L]=size(filename);
    filebase=filename(1:L-5);
    
    Tracks(i).file=filebase;

    % Import the data + parse variables
    
    %filedata=xlsread(filename,1,'AD:AG');
    
    nSpots=xlsread(filename,1,'C:C');
    t=xlsread(filename,1,'I:I');
    x=xlsread(filename,1,'E:E');
    y=xlsread(filename,1,'F:F');
    
    % Set up a loop to separate the individual tracks
    [SpotNumber, ~]= size(nSpots);
    TrackLengths=[];
    TrackLengths(1)=nSpots(1);
    NumberTracks=1;
    RealLengths=[];
    Counter=0;
    
    for j=2:SpotNumber
        if TrackLengths(NumberTracks)~=nSpots(j) || abs(y(j)-y(j-1))>1.0 || abs(x(j)-x(j-1))>1.0 || abs(t(j)-t(j-1))>12
            RealLengths(NumberTracks)=Counter;
            NumberTracks=NumberTracks+1;
            TrackLengths(NumberTracks)=nSpots(j);
            Counter=0;
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
        if TrackLengths(TrackNumber)~=nSpots(j) || abs(y(j)-y(j-1))>1.0 || abs(x(j)-x(j-1))>1.0 || abs(t(j)-t(j-1))>12
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
    
    MSDcomplete=zeros(m-1,n,m-1);
    CSD=zeros(m-1,n);
    
    for j=1:m-1
       
        DummyMSD=(DeltaT==j).*DeltaS;
        DummyMSD(~isfinite(DummyMSD))=false;
        
        if sum(sum((sum(DummyMSD~=0,3)>1)))>0
            error('One of the time steps is registering twice!');
        end
        
        CSD(j,:)=sum(Tracks(i).steps(1:j,:),1);
        MSDcomplete(:,:,j)=sum(DummyMSD,3);
        
    end
    
    Tracks(i).MSDdata=MSDcomplete;
    MSDcomplete(MSDcomplete==0)=NaN;
    
    
    Tracks(i).MSD=mean(MSDcomplete,1,'omitnan');
    Tracks(i).MSD=squeeze(Tracks(i).MSD);
    Tracks(i).MSD=transpose(Tracks(i).MSD);
    
    N=sum((isfinite(Tracks(i).MSD)),2);
    
    Tracks(i).MSDstdev=std(MSDcomplete,1,'omitnan');
    Tracks(i).MSDstdev=squeeze(Tracks(i).MSDstdev);
    Tracks(i).MSDstdev=transpose(Tracks(i).MSDstdev);
    Tracks(i).MSDerror=bsxfun(@rdivide, Tracks(i).MSDstdev, sqrt(N));
    Tracks(i).CSD=CSD;
       
    Totals=zeros(1,n);
    
    for j=1:n
        Totals(j)=Tracks(i).CSD(Tracks(i).lengths(j)-1,j);
    end
    
    Tracks(i).CSDnorm=bsxfun(@rdivide, Tracks(i).CSD, Totals);    
    
end

save('TrackStruct', 'Tracks','-v7.3'  );
clear;
