
%ChrisCexport.m

% Writes Ratios and Eiganvalues of Force and Diffusion tensor to XLSX file

FileName='ChrisC-WT.xlsx';

T1=table(SegLength, DtoFratio);
T1=[SegID,T1];

T2=table(D,F);
T2=[SegID, T2];

writetable(T1,FileName,'Sheet',1);
writetable(T2,FileName,'Sheet',2);

