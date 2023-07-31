
function [p,S]=MSDplotterTau(t, X, Y)

SF=min(diff(t,1,1),[],'all');

tMSD=EnsembleMSD(t/SF,X,Y);
sMSD=MSDbyTrack(t/SF,X,Y);

fig1=figure(1);
plot(log(t(2:end)),log(sMSD(:,:,1)),'Color',[0.7 0.7 0.7]);
hold on
plot(log(t(2:end)),log(mean(tMSD,1,'omitnan')),'b');
fig1.Position=[100 400 768 768];
xlabel('Log_{10} Time Lag (\tau), (sec)');
ylabel('Log_{10} Mean Squared Displacement (\mum^2)');

fig2=figure(2);
plot(log(t(2:end)),log(sMSD(:,:,1)),'Color',[0.7 0.7 0.7]);
hold on
[p,S,mu]=polyfit(log(t(2:end)),log(mean(tMSD,1,'omitnan')),1);
[BF,sigma]=polyval(p,log(t(2:end)),S,mu);
plot(log(t(2:end)),BF,'b-');
plot(log(t(2:end)),BF+2*sigma,'b--',log(t(2:end)),BF-2*sigma,'b--');
fig2.Position=[900 400 768 768];
xlabel('Log_{10} Time Lag (\tau), (sec)');
ylabel('Log_{10} Mean Squared Displacement (\mum^2)');



end