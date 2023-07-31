
for i=1:24
Tracks(i).MSDdata=[];
Tracks(i).Major=table2array(readtable(strcat('Cell_',num2str(i),'_Dens_Mask.csv'),'Range','E:E','ReadVariableNames',false));
Tracks(i).Minor=table2array(readtable(strcat('Cell_',num2str(i),'_Dens_Mask.csv'),'Range','F:F','ReadVariableNames',false));
end