
function [Out1, Out2, Out3]=LineScanSMLMdata(Xpos,Ypos,In1,In2,StepSize,BoxSize,EndPts)

% Endpoints should be a 2 x 2 matrix of format [x1 y1; x2 y2]
% All measurement inputs are in nm
% Xpos and Ypos are assumed to be in microns

    if nargin==3
        StepSize=10;
        BoxSize=50;
        figure
        scatter(Xpos(:),Ypos(:),[],In1(:));
        roi=drawline;
        EndPts=roi.Position;
    end

    if nargin==4
        BoxSize=50;
         figure
        scatter(Xpos(:),Ypos(:),[],In1(:));
        roi=drawline;
        EndPts=roi.Position;
    end

    if nargin==5
         figure
        scatter(Xpos(:),Ypos(:),[],In1(:));
        roi=drawline;
        EndPts=roi.Position;
    end
    
     jkMatrix=EndPts;
    x=jkMatrix(:,1);
    y=jkMatrix(:,2);
    Length=sqrt((x(2)-x(1))^2+(y(2)-y(1))^2);
    
    Kernel=[BoxSize BoxSize];
    % Define x and y spacing
        NumSteps=(1000*Length/StepSize);
        xStep=(abs(x(2)-x(1)))/NumSteps;
        yStep=(abs(y(2)-y(1)))/NumSteps;
        
    % Generate the x and y axes along the parametric variable (as vector index)    
        if (x(2)-x(1))>0
            X=x(1):xStep:x(2);
        elseif (x(2)-x(1))<0
            X=x(2):xStep:x(1);
        else
            X=x(1)*ones(1,NumSteps+1);
            %Vertical Line
        end
        if (y(2)-y(1))>0
            Y=y(1):yStep:y(2);
        elseif (y(2)-y(1))<0
            Y=y(2):yStep:y(1);
        else
            Y=y(1)*ones(NumSteps+1,1);
            %Horizontal Line
        end
    
    % Align the two axes so vector index is shared
        if ((x(2)-x(1))*(y(2)-y(1)))<0
            Y=flipud(Y);
        end
    
   
        
        Out1=NaN(size(X));
        Out2=NaN(size(X));
        Out3=NaN(size(X));
    for k=1:size(X,2)
       
       %Establish conditional logical matrices
       c1=Xpos<=(X(k)+Kernel(1)/1000);
       c2=Xpos>=(X(k)-Kernel(1)/1000);
       c3=Ypos<=(Y(k)+Kernel(2)/1000);
       c4=Ypos>=(Y(k)-Kernel(2)/1000);
        
       Out1(k)=mean(In1(logical(c1.*c2.*c3.*c4)),'all','omitnan');
       Out3(k)=mean(In2(logical(c1.*c2.*c3.*c4)),'all','omitnan');
       Out2(k)=sum(c1.*c2.*c3.*c4,'all','omitnan');
    end
    
    

end