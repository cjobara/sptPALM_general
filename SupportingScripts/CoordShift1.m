
function OutStruct=CoordShift1(TrackStruct,index,alphadeg,origin)

%NOTE: COUNTERCLOCKWISE is Positive (Right hand rule)

if nargin==3
    origin=[0 0];
end

OutStruct=TrackStruct(index);

OutStruct.file=strcat(TrackStruct(index).file,'_CS');
OutStruct.origin=origin;
OutStruct.alpha=alphadeg;
OutStruct.rawVector=[];

% Move to the origin before rotating
TempX(:,:)=OutStruct.matrix(:,:,2)-origin(1);
TempY(:,:)=OutStruct.matrix(:,:,3)-origin(2);

% Rotate by angle alpha in degrees
OutStruct.matrix(:,:,2)=TempX*cosd(alphadeg)-TempY*sind(alphadeg);
OutStruct.matrix(:,:,3)=TempX*sind(alphadeg)+TempY*cosd(alphadeg);

% Recenter the center
OutStruct.center=bsxfun(@minus, OutStruct.matrix, OutStruct.matrix(1,:,:));

TempX2(:,:)=OutStruct.vector(:,:,1);
TempY2(:,:)=OutStruct.vector(:,:,2);

OutStruct.vector(:,:,1)=TempX2*cosd(alphadeg)-TempY2*sind(alphadeg);
OutStruct.vector(:,:,2)=TempX2*sind(alphadeg)+TempY2*cosd(alphadeg);

end


