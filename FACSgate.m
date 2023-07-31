function [Subset,roiCoord]=FACSgate(X,Y,roi)

if iscell(X)

figure;
scatter(cell2mat(X),log10(cell2mat(Y)));

if nargin==2
    roi=drawpolygon;
end

roiCoord=roi.Position;
tf=inROI(roi,cell2mat(X),log10(cell2mat(Y)));
Subset=find(tf);

hold on
scatter(cell2mat(X(Subset)),log10(cell2mat(Y(Subset))),'r');
disp(['Segments Gated: ', num2str(size(Subset,1)), ' of ', num2str(size(X,1))]);

elseif istable(X)
    
    figure;
    scatter(log10(table2array(X)),log10(table2array(Y)));
    
    if nargin==2
        roi=drawpolygon;
    end
    
    roiCoord=roi.Position;
    tf=inROI(roi, log10(table2array(X)), log10(table2array(Y)));
    Subset=find(tf);
    
    hold on
    scatter(log10(table2array(X(Subset,1))),log10(table2array(Y(Subset,1))),'r');
    disp(['Segments Gated: ', num2str(size(Subset,1)), ' of ', num2str(size(X,1))]);
else
    
    figure;
    scatter(X,log10(Y));
    
     if nargin==2
        roi=drawpolygon;
     end
    
    roiCoord=roi.Position;
    tf=inROI(roi,X, log10(Y));
    Subset=find(tf);
    
    hold on
    scatter(X(Subset),log10(Y(Subset)),'r');
    disp(['Segments Gated: ', num2str(size(Subset,1)), ' of ', num2str(size(X,1))]);
    

end