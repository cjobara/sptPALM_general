
function OneColorCenterTrackPlotter(Matrix,Color,Direction)

% Direction is 1 (towards white) or 2 (towards black)

if nargin==2
    Direction=1;
end

if size(Matrix,3)~=3
    error('Matrix input must be in the format of t,x,y along the third dimension. Tracks are arranged y m and n.');
end

if size(Color,2)~=3
    error('Color needs tobe given in RGB triplets normalized so 255.')
end

Color=Color/255;
[~,n,~]=size(Matrix);

deltaColor1=([1 1 1]-Color)/(2*n);
deltaColor2=([0 0 0]-Color)/(2*n);

figure
hold on

if Direction==1
for i=1:n
    plot(Matrix(:,i,2)-Matrix(1,i,2),Matrix(:,i,3)-Matrix(1,i,3),'Color',Color+i*deltaColor1);
end
end

if Direction==2
for i=1:n
    plot(Matrix(:,i,2)-Matrix(1,i,2),Matrix(:,i,3)-Matrix(1,i,3),'Color',Color+i*deltaColor2);
end
end

set(gcf,'Position',[100 100 500 500]);
xlim([-6 6]);
ylim([-6 6]);

end