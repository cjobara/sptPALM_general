
function FullMatrix=CombineTraj(Tracks)

%Establish the size and preallocate space

lengths=NaN(size(Tracks,2),1);
Size=NaN(size(Tracks,2),1);

for i=1:size(Tracks,2)
    
    lengths(i)=max(Tracks(i).lengths,[],'all');
    Size(i)=size(Tracks(i).lengths,1);

end

FullMatrix=NaN(max(lengths,[],'all'),sum(Size,'all'),3);

%Assemble the matrix
counter=0;

for i=1:size(Tracks,2)
    
    counter=counter+1;
    lengths(i)=max(Tracks(i).lengths,[],'all');
    FullMatrix(1:size(Tracks(i).matrix,1),counter:counter+size(Tracks(i).lengths,1)-1,:)=Tracks(i).matrix;
    
    counter=counter+size(Tracks(i).lengths,1)-1;
    
end


end
    
