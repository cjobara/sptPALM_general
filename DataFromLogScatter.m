function A=DataFromLogScatter(DataX,DataY)

figure;
scatter(cell2mat(DataX),log(cell2mat(DataY)))
roi=drawpolygon;
tf=inROI(roi,cell2mat(DataX),log(cell2mat(DataY)));
A=find(tf);

hold on
scatter(cell2mat(DataX(A)),log(cell2mat(DataY(A))),'r');
end

