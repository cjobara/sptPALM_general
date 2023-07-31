
function [Var1,Var2,X,Y,EndPts]=LinePlotScatter(TrackStruct,index,ScaleFactor,AxLimits)

%Input notes:
% AxLim need to be of the form: [x1 x2;y1 y2] in microns
% ScaleFactor is the number of pixels per micron in the final image, so the
% line can be exported as an ROI that works in Fiji/ImageJ

%Output notes:
% Var,X,Y are the x and y points and associated variable along the line as
% columnn vectors
% EndPts is the endpoints of the line in the format [x y w h] scaled to
% fit the final output image so they can be passed to imageJ easily.

%Define the Kernel to trace with here in nm (e.g. [50 50] means +/- 50 nm
%in both x and y dimensions).
Kernel=[50 50];

%Define stepping rule for parametric variable here. 
    %If constant step size desired, use this line with number in nm:
        StepSize=10;
        ConstrainSteps=true;
    %If constant number of steps is desired, use this line with number
    %here: (NOTE DID NOT FINISH THIS CODE NEED TO ADD IT AT LINE 96
%       NumSteps=50;
%       ConstrainSteps=false;

%Define the variable output as Var at line 84. Any variable defined as a
%function of m and n can be used.


if nargin==2
    AxLimits=[0 20.48; 0 20.48]; 
    ScaleFactor=1;
    % i.e. use the whole image and don't scale to pixels.
end

if nargin==3
    AxLimits=[0 20.48; 0 20.48];
end

fig1=figure(1);
fig1.Position=[100 300 768 768];
colormap(jet);
% plot(TrackStruct(index).matrix(:,:,2),TrackStruct(index).matrix(:,:,3));
A=TrackStruct(index).matrix(:,:,2);
B=TrackStruct(index).matrix(:,:,3);%Note get rid of the +1.5 if not in Fig2A!
C=TrackStruct(index).Deff;
scatter(A(:),B(:),[],C(:)); 

xlim(AxLimits(1,:));
ylim(AxLimits(2,:));

roi=drawfreehand;

jkMatrix=roi.Position;
x=jkMatrix(:,1);
y=jkMatrix(:,2);

EndPts=ScaleFactor*[x(1)-AxLimits(1,1) y(1)-AxLimits(2,1) x(2)-AxLimits(1,1) y(2)-AxLimits(2,1)]
Length=sqrt((x(2)-x(1))^2+(y(2)-y(1))^2);

if ConstrainSteps==true
    % Define x and y spacing
        xStep=(abs(x(2)-x(1)))/(1000*Length/StepSize);
        yStep=(abs(y(2)-y(1)))/(1000*Length/StepSize);
        
    % Generate the x and y axes along the parametric variable (as vector index)    
        if (x(2)-x(1))>=0
            X=x(1):xStep:x(2);
        else
            X=x(2):xStep:x(1);
        end
        if (y(2)-y(1))>=0
            Y=y(1):yStep:y(2);
        else
            Y=y(2):yStep:y(1);
        end
    
    % Align the two axes so vector index is shared
        if ((x(2)-x(1))*(y(2)-y(1)))<=0
            Y=flipud(Y);
        end
    
   
        
        Var1=NaN(size(X));
        Var2=NaN(size(X));
    for k=1:size(X,2)
       
       %Establish conditional logical matrices
       c1=A<=(X(k)+Kernel(1)/1000);
       c2=A>=(X(k)-Kernel(1)/1000);
       c3=B<=(Y(k)+Kernel(2)/1000);
       c4=B>=(Y(k)-Kernel(2)/1000);
        
       Var1(k)=mean(C(find(c1.*c2.*c3.*c4)),'all','omitnan');
       Var2(k)=sum(c1.*c2.*c3.*c4,'all','omitnan');
    end
       
    % Now define for constant number of steps
    
end

end