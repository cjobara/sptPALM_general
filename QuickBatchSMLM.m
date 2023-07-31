
list=dir(pwd);

[NumFiles,~]=size(list);
    
blues={list.name};

for a=4:NumFiles
    
    list=dir(pwd);

    [NumFiles,~]=size(list);
    
    blues={list.name};
    
      
    BLUE=char(blues(a));
      cd(BLUE);
    
     
      TrackImporterCJO_20190411
      
    
       
    cd ..

end
