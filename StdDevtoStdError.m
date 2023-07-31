
% Standard Deviation to Standard Error Corrector for Tracks Variables

Files=dir(fullfile(pwd, '*.mat')); 

[NumFiles,~]=size(Files);
    
files={Files.name};

for i=1:NumFiles
    
    % Record the name of the file
    filename=char(files(i));
    load(filename);
    
    if ~isfield(Tracks,'MSDstdev')
    
    [~,NumCells]=size(Tracks);
    
    for j=1:NumCells
        
        [m,n]=size(Tracks(j).MSD);
        N=sum((isfinite(Tracks(j).MSD)),2);
        
        Tracks(j).MSDstdev=Tracks(j).MSDerror;
        Tracks(j).MSDerror=bsxfun(@rdivide, Tracks(j).MSDerror, sqrt(N));
        
    end
    end
    save(filename, 'Tracks','-v7.3'  );
    
    clear('Tracks');
    
end
