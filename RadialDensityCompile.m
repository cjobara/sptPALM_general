
% Compile Radial Density

DthetaA=NaN(Radius*100+1,360);
DnormThetaA=NaN(Radius*100+1,360);
RhoA=NaN(Radius*100+1,360);
DthetaB=NaN(Radius*100+1,360);
DnormThetaB=NaN(Radius*100+1,360);
RhoB=NaN(Radius*100+1,360);

for theta=1:360
    
   EndPts=[Radius*cosd(theta) Radius*sind(theta)];
   [D,rho,Dnorm]=LineScanSMLMdata(A.matrix(:,:,1),A.matrix(:,:,2),A.D,A.normD,10,25,[0 0; EndPts]);
   DthetaA(:,theta)=D';
   RhoA(:,theta)=rho';
   DnormThetaA(:,theta)=Dnorm';
   
   [D,rho,Dnorm]=LineScanSMLMdata(B.matrix(:,:,1),B.matrix(:,:,2),B.D,B.normD,10,25,[0 0; EndPts]);
   DthetaB(:,theta)=D';
   RhoB(:,theta)=rho';
   DnormThetaB(:,theta)=Dnorm';
   
    
end

