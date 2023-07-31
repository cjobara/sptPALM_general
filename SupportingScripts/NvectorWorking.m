
% Anisotropy Calculator

%For Y axis orientation
AY=Tracks(i).vector(2:end,:,1).*Tracks(i).vector(1:end-1,:,2);
BX=Tracks(i).vector(2:end,:,2).*Tracks(i).vector(1:end-1,:,1);
AX=Tracks(i).vector(2:end,:,1).*Tracks(i).vector(1:end-1,:,1);
BY=Tracks(i).vector(2:end,:,2).*Tracks(i).vector(1:end-1,:,2);

TOP=Tracks(i).vector(2:end,:,1).*Tracks(i).vector(1:end-1,:,2)-Tracks(i).vector(2:end,:,2).*Tracks(i).vector(1:end-1,:,1);
BOTTOM=Tracks(i).vector(2:end,:,1).*Tracks(i).vector(1:end-1,:,1)+Tracks(i).vector(2:end,:,2).*Tracks(i).vector(1:end-1,:,2);

NormFac=Tracks(i).steps(1:end-1,:);



% For x axis orientation

TOP=Tracks(i).vector(2:end,:,1).*Tracks(i).vector(1:end-1,:,1)+Tracks(i).vector(2:end,:,2).*Tracks(i).vector(1:end-1,:,2);
BOTTOM=Tracks(i).vector(2:end,:,1).*Tracks(i).vector(1:end-1,:,2)-Tracks(i).vector(2:end,:,2).*Tracks(i).vector(1:end-1,:,1);