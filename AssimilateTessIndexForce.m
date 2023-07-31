
function NewStruct=AssimilateTessIndex2(TrackStruct,index,Maps)

LocIndex=NaN(size(TrackStruct(index).matrix(:,:,1)));
Deff=NaN(size(TrackStruct(index).matrix(:,:,1)));
NewStruct=TrackStruct(index);

%Define JBM output variables
NewStruct.JBM.x=cell(size(Maps,2),1);
NewStruct.JBM.y=cell(size(Maps,2),1);
NewStruct.JBM.D=NaN(size(Maps,2),1);
NewStruct.JBM.n=NaN(size(Maps,2),1);

    %Record where Voronoi Tess are for reference
    NewStruct.JBM.center_x=NaN(size(Maps,2),1);
    NewStruct.JBM.center_y=NaN(size(Maps,2),1);
    NewStruct.JBM.voronoi_x=cell(size(Maps,2),1);
    NewStruct.JBM.voronoi_y=cell(size(Maps,2),1);
    NewStruct.JBM.neighbors=cell(size(Maps,2),1);

 %Define temp variables for linear indexing
 A=TrackStruct(index).matrix(:,:,1);
 B=round(1000*TrackStruct(index).matrix(:,:,2));
 C=round(1000*TrackStruct(index).matrix(:,:,3));
 
 counter=[0];
 
for i=1:size(Maps,2)
    
    for j=1:size(Maps(i).x,1)
%           k1=find(A==round(Maps(i).t(j)/0.011));
%           k2=find(B==round(1000*Maps(i).x(j)));
%           k3=find(C==round(1000*Maps(i).y(j)));
        [m,n]=find((A==round(Maps(i).t(j)/0.011)).*(B==round(1000*Maps(i).x(j))).*(C==round(1000*Maps(i).y(j))));
            if size(m,1)>1 || size(n,1)>1
                %Too many inputs for a single point
                if size(m,1)==size(n,1)
                    %There is more than one track with the localization--force the
                    %assignment and warn the user.
                    disp('Forcing two spot steps to use same input Deff information, beware of artifact!');
                    disp(strcat('Doube use localization at: t=',num2str(Maps(i).t(j)/0.011),"_x=",num2str(Maps(i).x(j)),"_y=",num2str(Maps(i).y(j))));
                        for k=1:size(m,1)
                            LocIndex(m(k),n(k))=i;
                            Deff(m(k),n(k))=Maps(i).D;
                        end
                else
                    %There are not consistent points feeding in, report an
                    %error
                    error(strcat('2 localizations found at same time and space but not independently! t=',num2str(Maps(i).t(j)/0.011),"_x=",num2str(Maps(i).x(j)),"_y=",num2str(Maps(i).y(j))));
                end
                
            elseif isempty(m) || isempty(n)
                %Cannot find a consistent point to satisfy the conditions
                
                %Check if it is a rounding error by round on a different
                %significant digit (unlikely to make same error twice)
                B=round(10000*TrackStruct(index).matrix(:,:,2));
                C=round(10000*TrackStruct(index).matrix(:,:,3));
                [m,n]=find((A==round(Maps(i).t(j)/0.011)).*(B==round(10000*Maps(i).x(j))).*(C==round(10000*Maps(i).y(j))));
                
                %Then reassign B and C so they are ready for the next part
                %of the loop.
                B=round(1000*TrackStruct(index).matrix(:,:,2));
                C=round(1000*TrackStruct(index).matrix(:,:,3));
               
                if  isempty(m) || isempty(n)
                    %If it is still empty, it is not a rounding error.
                    counter=counter+1;
                    if Maps(i).x(j)==0 || Maps(i).y(j)==0
                        %Zero values cause JBM's program artifacts, skip it
                        %if it has a zero value by writing it to the bottom
                        %right index of the matrix that never gets used and
                        %inform the user.
                        m=size(B,1);
                        n=size(B,2);
                        disp('Zero value localization not found. Forcing ahead, beware of artifact!');
                        disp(strcat('Localization at: t=',num2str(Maps(i).t(j)/0.011),"_x=",num2str(Maps(i).x(j)),"_y=",num2str(Maps(i).y(j))));
                        
                    else
                        %For some reason JBM has some random spots that
                        %shouldn't exist. I'm just ignoring them for now,
                        %because they do only happen at the edges of the
                        %image, but you need to deal with this later.
                        m=size(B,1);
                        n=size(B,2);
                        disp(strcat('Cannot find localization! t=',num2str(Maps(i).t(j)/0.011),"_x=",num2str(Maps(i).x(j)),"_y=",num2str(Maps(i).y(j))));
                    end
                end
                
            end
            
         LocIndex(m,n)=i;
         Deff(m,n)=Maps(i).D;        
        
    end  
    
    NewStruct.JBM.x{i}=Maps(i).x;
    NewStruct.JBM.y{i}=Maps(i).y;
    NewStruct.JBM.D(i)=Maps(i).D;
    NewStruct.JBM.n(i)=size(Maps(i).x,1);
    NewStruct.JBM.center_x(i)=Maps(i).center_x;
    NewStruct.JBM.center_y(i)=Maps(i).center_y;
    NewStruct.JBM.voronoi_x{i}=Maps(i).voronoi_x;
    NewStruct.JBM.voronoi_y{i}=Maps(i).voronoi_y;
    NewStruct.JBM.neighbors{i}=Maps(i).neighbors;
    
    
    
    
end

NewStruct.LocIndex=LocIndex;
NewStruct.Deff=Deff;
counter

end