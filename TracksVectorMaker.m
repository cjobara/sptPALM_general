
% Cell Compiler for Ensemble
Files=dir(fullfile(pwd, '*.mat')); 

[NumFiles,~]=size(Files);
    
files={Files.name};
   

for i=1:NumFiles

 % Record the name of the file
    filename=char(files(i));
    [~,L]=size(filename);
    filebase=filename(1:L-4);
    load(filename);
    
    pause(1);
    
    [~,NumCells]=size(Tracks);
    
    for j=1:NumCells

    Tracks(j).rawVector(:,:,1)=diff(Tracks(j).matrix(:,:,2),1,1);
    Tracks(j).rawVector(:,:,2)=diff(Tracks(j).matrix(:,:,3),1,1);
    
    Tracks(j).vector=bsxfun(@rdivide,Tracks(j).rawVector,Tracks(j).rawSteps(:,:,1));
    
    end
    
    save(strcat(filebase, '_vector'), 'Tracks','-v7.3' );
    
end







   
    
    
    
 