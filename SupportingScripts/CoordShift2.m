
function OutStruct=CoordShift2(CSstruct,index,alphadeg,origin)

%NOTE: COUNTERCLOCKWISE is Positive (Right hand rule)
% This function operates on CS structured arrays

if nargin==3
    origin=[0 0];
end

OutStruct=CSstruct(index);

OutStruct.file=strcat(CSstruct(index).file,'_CoordShift');
OutStruct.origin=origin;
OutStruct.alpha=alphadeg;
%OutStruct.rawVector=[];

% Move to the origin before rotating
TempX(:,:)=OutStruct.CSmatrix(:,:,2)-origin(1);
TempY(:,:)=OutStruct.CSmatrix(:,:,3)-origin(2);

% Rotate by angle alpha in degrees
OutStruct.CSmatrix(:,:,2)=TempX*cosd(alphadeg)-TempY*sind(alphadeg);
OutStruct.CSmatrix(:,:,3)=TempX*sind(alphadeg)+TempY*cosd(alphadeg);

% Rotate the CSvectors
TempX2(:,:)=OutStruct.CSvec(:,:,1);
TempY2(:,:)=OutStruct.CSvec(:,:,2);

OutStruct.CSvec(:,:,1)=TempX2*cosd(alphadeg)-TempY2*sind(alphadeg);
OutStruct.CSvec(:,:,2)=TempX2*sind(alphadeg)+TempY2*cosd(alphadeg);

% Recenter and Rotate the pre- and post- refinement boundaries

TempX3=OutStruct.refboundary(:,1)-origin(1)*1000;
TempY3=OutStruct.refboundary(:,2)-origin(2)*1000;
OutStruct.refboundary=[TempX3*cosd(alphadeg)-TempY3*sind(alphadeg), TempX3*sind(alphadeg)+TempY3*cosd(alphadeg)];

TempBounds=[OutStruct.boundaries.x(1),OutStruct.boundaries.y(1); OutStruct.boundaries.x(2), OutStruct.boundaries.y(1);...
    OutStruct.boundaries.x(2),OutStruct.boundaries.y(2);OutStruct.boundaries.x(1),OutStruct.boundaries.y(2); ...
    OutStruct.boundaries.x(1),OutStruct.boundaries.y(1)];
TempBounds(:,1)=TempBounds(:,1)-origin(1);
TempBounds(:,2)=TempBounds(:,2)-origin(2);

OutStruct.boundariesCS=[TempBounds(:,1)*cosd(alphadeg)-TempBounds(:,2)*sind(alphadeg), TempBounds(:,1)*sind(alphadeg)+TempBounds(:,2)*cosd(alphadeg)];

% Regenerate the Ellipse Fits

    a=CSstruct(index).EllipseFit.MajorAxisLength/2;
    b=CSstruct(index).EllipseFit.MinorAxisLength/2;
    c=CSstruct(index).EllipseFit.Centroid-origin;
    d=linspace(0,2*pi,100);
    phi=-CSstruct(index).EllipseFit.Orientation;
    % Note ellipses are centered at zero, zero in this form (if you want to
    % change that add an h +k factor to lines 56 + 57, respectively
    x=c(1)+a*cos(d)*cosd(phi)-b*sin(d)*sind(phi);
    y=c(2)+a*cos(d)*sind(phi)+b*sin(d)*cosd(phi);
    plot(pix_SF*x+pix_off,pix_SF*y+pix_off,'r','LineWidth',1.5);
    MajAx=[x(1), y(1); x(50), y(50)];
    MinAx=[x(25), y(25); x(75), y(75)];
    plot(pix_SF*MajAx(:,1)+pix_off,pix_SF*MajAx(:,2)+pix_off, 'b', 'LineWidth',1.5);
    plot(pix_SF*MinAx(:,1)+pix_off,pix_SF*MinAx(:,2)+pix_off, 'b', 'LineWidth',1.5);
    saveas(fig1,fullfile(pwd, 'VectorGraphics', strcat('CS_',num2str(i),'_EllipseFit.svg')));


end


