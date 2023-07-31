function MSD=MSDbyTrack(TimeIndex,Xpos,Ypos)

% NOTE: Time index must be frames (positive integers)

    [m,n]=size(Xpos);

    % If time axis is already standardized, expand to full uniform matrix
    if size(TimeIndex,2)==1
        for i=1:n-1
            TimeIndex(:,i+1)=TimeIndex(:,1);
        end
    end
    
    CalcMatrix(:,:,1)=TimeIndex;
    CalcMatrix(:,:,2)=Xpos;
    CalcMatrix(:,:,3)=Ypos;
    
    MSD=NaN(m-1,n,2);
    Blinks=struct('m',[],'n',[],'Tmn',[]);
    
     for i=1:m-1
        TempMatrix=CalcMatrix(i+1:end,:,:)-CalcMatrix(1:end-i,:,:);
        Tmin=min(TempMatrix(:,:,1),[],'all');
        Tmax=max(TempMatrix(:,:,1),[],'all');
        
        IDmatrix=(TempMatrix(:,:,1)==i);
        MSD(i,:,1)=mean((IDmatrix.*TempMatrix(:,:,2)).^2+(IDmatrix.*TempMatrix(:,:,3)).^2,1);
        MSD(i,:,2)=sum(IDmatrix,1);
        [j,k]=find(~IDmatrix);
        Tmn=TempMatrix(j,k,1);
        
        Blinks(i).m=j;
        Blinks(i).n=k;
        Blinks(i).Tmn=Tmn;
        
     end
     
     %Now correct for blinks and longer linkages
     
    % for i=1:m-1
         
         
        
end