
function MSD=EnsembleMSD(TimeIndex,Xpos,Ypos)

% NOTE: Time index must be frames (positive integers)

    [m,n]=size(Xpos);

    % If time axis is already standardized, expand to full uniform matrix
    if size(TimeIndex,2)==1
        for i=1:n-1
            TimeIndex(:,i+1)=TimeIndex(:,1);
        end
    end

    TimeStep=diff(TimeIndex,1,1);
    StepMatrix1=(TimeStep==1);
    Num1steps=sum(StepMatrix1,'all');
    CalcMatrix(:,:,1)=TimeIndex;
    CalcMatrix(:,:,2)=Xpos;
    CalcMatrix(:,:,3)=Ypos;
    
    MSD=NaN(Num1steps, (max(TimeIndex,[],'all','omitnan')-min(TimeIndex,[],'all','omitnan')));
    Counters=zeros(1,(max(TimeIndex,[],'all','omitnan')-min(TimeIndex,[],'all','omitnan')));
    
    for i=1:m-1
        
        TempMatrix=CalcMatrix(i+1:end,:,:)-CalcMatrix(1:end-i,:,:);
        Tmin=min(TempMatrix(:,:,1),[],'all');
        Tmax=max(TempMatrix(:,:,1),[],'all');
        
        for j=Tmin:Tmax
            Temp2=(TempMatrix(:,:,1)==j);
            k=find(Temp2);
            X=TempMatrix(:,:,2);
            Y=TempMatrix(:,:,3);
            MSD(Counters(j)+1:Counters(j)+sum(Temp2,'all'),j)=X(k).^2+Y(k).^2;
            Counters(j)=Counters(j)+sum(Temp2,'all');
        end
        
        disp(['Min: ',num2str(Tmin),' Max: ',num2str(Tmax)]);
        
    end
           
            
            
       
   
        

end