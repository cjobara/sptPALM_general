
function [SegID,Size,Ratio,F,D,Fvec,Dvec]=ChrisCconvert(SegmentDetails)

[NumSegs,~]=size(SegmentDetails);

SegID=SegmentDetails(:,1);
Size=NaN(NumSegs,1);
Ratio=NaN(NumSegs,1);
F=NaN(NumSegs,2);
D=NaN(NumSegs,2);
Fvec=NaN(2,2,NumSegs);
Dvec=NaN(2,2,NumSegs);

for i=1:NumSegs
   
   Size(i)=SegmentDetails{i,2};
   Ratio(i)=SegmentDetails{i,3};
   F(i,:)=str2num(SegmentDetails{i,4});
   D(i,:)=str2num(SegmentDetails{i,5});
   Fvec(:,:,i)=str2num(SegmentDetails{i,6});
   Dvec(:,:,i)=str2num(SegmentDetails{i,7});
    
end


end