
fig1=figure(1)
subplot(2,1,1)
plot(WT.matrix(:,:,2),WT.matrix(:,:,3));
subplot(2,1,2)
plot(Mut.matrix(:,:,2),Mut.matrix(:,:,3));

fig2=figure(2)
subplot(2,1,1)
plot(WT.center(:,:,2),WT.center(:,:,3));
subplot(2,1,2)
plot(Mut.center(:,:,2),Mut.center(:,:,3));

fig3=figure(3)
subplot(3,2,1)
histogram(WT.steps);
subplot(3,2,3)
plot(1:size(WT.matrix,1)-1,WT.MSD,'Color',[0.4 0.4 0.4])
hold on
plot(1:size(WT.matrix,1)-1,mean(WT.MSD,2,'omitnan'),'r')
subplot(3,2,5)
plot(1:size(WT.matrix,1)-1,WT.CSD,'Color',[0.4 0.4 0.4])
hold on
plot(1:size(WT.matrix,1)-1,mean(WT.CSD,2,'omitnan'),'r')

subplot(3,2,2)
histogram(Mut.steps);
subplot(3,2,4)
plot(1:size(Mut.matrix,1)-1,Mut.MSD,'Color',[0.4 0.4 0.4])
hold on
plot(1:size(Mut.matrix,1)-1,mean(Mut.MSD,2,'omitnan'),'r')
subplot(3,2,6)
plot(1:size(Mut.matrix,1)-1,Mut.CSD,'Color',[0.4 0.4 0.4])
hold on
plot(1:size(Mut.matrix,1)-1,mean(Mut.CSD,2,'omitnan'),'r')

fig4=figure(4)
subplot(2,1,1)
quiver(WT.matrix(1:end-1,:,2),WT.matrix(1:end-1,:,3),WT.vector(:,:,1),WT.vector(:,:,2));
subplot(2,1,2)
quiver(Mut.matrix(1:end-1,:,2),Mut.matrix(1:end-1,:,3),Mut.vector(:,:,1),Mut.vector(:,:,2));

fig5=figure(5)
subplot(2,1,1)
[~,theta]=cart2pol(WT.vector(:,:,1),WT.vector(:,:,2));
polarhistogram(nonzeros(theta));
subplot(2,1,2)
[rho,theta]=cart2pol(Mut.vector(:,:,1),Mut.vector(:,:,2));
polarhistogram(nonzeros(theta));