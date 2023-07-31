
function SubStruc=TrackSubsetSelector(TrackStruct,index,subset)

    SubStruc=TrackStruct(index);
    
    SubStruc.lengths=SubStruc.lengths(subset);
    
    SubStruc.matrix=SubStruc.matrix(:,subset,:);
    SubStruc.center=SubStruc.center(:,subset,:);
    SubStruc.rawSteps=SubStruc.rawSteps(:,subset,:);
    SubStruc.steps=SubStruc.steps(:,subset,:);
    SubStruc.MSDdata=[];
    SubStruc.MSD=SubStruc.MSD(:,subset);
    SubStruc.vector=SubStruc.vector(:,subset,:);

end
