
function PrepSegFig(TrackInfo,imB,SegIdent)

% Fill the blank inputs
if nargin==2
   SegIdent=1;
end


CPs=[1 find(TrackInfo.cp)' size(TrackInfo.x,1)];
SegLengths=diff(CPs);
SegIndex=find(SegLengths==TrackInfo.eig{SegIdent,2}+1);
TrackBounds=[CPs(SegIndex) CPs(SegIndex+1)];

%Extract Data from eig cell Array
    Xhat=mean(TrackInfo.x(TrackBounds(1):TrackBounds(2)),1);
    Yhat=mean(TrackInfo.y(TrackBounds(1):TrackBounds(2)),1);
    D=str2num(TrackInfo.eig{SegIdent,5});
    F=str2num(TrackInfo.eig{SegIdent,4});
    Fvec=str2num(TrackInfo.eig{SegIdent,6});
    Dvec=str2num(TrackInfo.eig{SegIdent,7});

close all
fig1=figure(1);

plot(TrackInfo.x,TrackInfo.y,'Color',[0.0627, 0.4980, 0.5020]);

    Xlims=xlim;
        Ylims=ylim;
        Dx=Xlims(2)-Xlims(1);
        Dy=Ylims(2)-Ylims(1);
     if Dx>=Dy
         Yaxis=[Dy/2+Ylims(1)-Dx/2 Dy/2+Ylims(1)+Dx/2];
         Xaxis=Xlims;
         ylim(Yaxis);
     else
         Xaxis=[Dx/2+Xlims(1)-Dy/2 Dx/2+Xlims(1)+Dy/2];
         Yaxis=Ylims;
         xlim( Xaxis );
     end
     
     ScaleFactor1=128/(Xaxis(2)-Xaxis(1));
     disp(['First Scale Factor:' num2str(ScaleFactor1)]);
     
 imshow(imB)
 hold on
 plot(ScaleFactor1*(TrackInfo.x-Xaxis(1)),ScaleFactor1*(TrackInfo.y-Yaxis(1)),'Color',[0.0627, 0.4980, 0.5020]);
 plot(ScaleFactor1*(TrackInfo.x(TrackBounds(1):TrackBounds(2))-Xaxis(1)), ScaleFactor1*(TrackInfo.y(TrackBounds(1):TrackBounds(2))-Yaxis(1)),'r');
 fig1.Position=[100 400 768 768];
 
 fig2=figure(2);
 plot(0.011*(TrackInfo.t-TrackInfo.t(1)),sqrt(TrackInfo.x.^2+TrackInfo.y.^2),'Color',[0.0627, 0.4980, 0.5020],'LineWidth',2)
 hold on
 plot(0.011*(TrackInfo.t(TrackBounds(1):TrackBounds(2))-TrackInfo.t(1)),sqrt(TrackInfo.x(TrackBounds(1):TrackBounds(2)).^2+TrackInfo.y(TrackBounds(1):TrackBounds(2)).^2),'r','LineWidth',2);
 xlabel('Time  (sec)');
 ylabel('Position (\mum)');
 set(gca, 'linewidth', 2);
 set(gca, 'FontName', 'Arial');
 set(gca, 'FontSize', 20);
 fig2.Position=[400 75 768+384 384];


 if exist('ForceType','var')
 fig3=figure(3);
 plot(TrackInfo.x(TrackBounds(1):TrackBounds(2)), TrackInfo.y(TrackBounds(1):TrackBounds(2)),'Color',[0.0627, 0.4980, 0.5020]);
 
    Xlims=xlim;
        Ylims=ylim;
        Dx=Xlims(2)-Xlims(1);
        Dy=Ylims(2)-Ylims(1);
     if Dx>=Dy
         ylim( [Dy/2+Ylims(1)-1.2*Dx/2 Dy/2+Ylims(1)+1.2*Dx/2] );
         xlim( [Dx/2+Xlims(1)-1.2*Dx/2 Dx/2+Xlims(1)+1.2*Dx/2] );
     else
         xlim( [Dx/2+Xlims(1)-1.2*Dy/2 Dx/2+Xlims(1)+1.2*Dy/2] );
         ylim( [Dy/2+Ylims(1)-1.2*Dy/2 Dy/2+Ylims(1)+1.2*Dy/2] );
     end
     
 
 hold on
     
 quiver(Xhat,Yhat,F(1)*Fvec(1,1),F(1)*Fvec(2,1),'r','ShowArrowHead','off','AutoScale','off');
 quiver(Xhat,Yhat,F(1)*Fvec(1,2),F(1)*Fvec(2,2),'r','ShowArrowHead','off','AutoScale','off');
 fig3.Position=[900 400 768 768];
 
 end
 
 fig4=figure(4);
 plot(TrackInfo.x(TrackBounds(1):TrackBounds(2)), TrackInfo.y(TrackBounds(1):TrackBounds(2)));
 
    Xlims=xlim;
        Ylims=ylim;
        Dx=Xlims(2)-Xlims(1);
        Dy=Ylims(2)-Ylims(1);
     if Dx>=Dy
         Yaxis=[Dy/2+Ylims(1)-1.2*Dx/2 Dy/2+Ylims(1)+1.2*Dx/2];
         Xaxis=[Dx/2+Xlims(1)-1.2*Dx/2 Dx/2+Xlims(1)+1.2*Dx/2];
         ylim( Yaxis );
         xlim( Xaxis );
     else
         Xaxis=[Dx/2+Xlims(1)-1.2*Dy/2 Dx/2+Xlims(1)+1.2*Dy/2];
         Yaxis=[Dy/2+Ylims(1)-1.2*Dy/2 Dy/2+Ylims(1)+1.2*Dy/2];
         xlim( Xaxis );
         ylim( Yaxis );
     end
     
 ScaleFactor2=128/(Xaxis(2)-Xaxis(1));
 disp(['Second Scale Factor:' num2str(ScaleFactor2)]);
 imshow(imB);
 hold on
 plot(ScaleFactor2*(TrackInfo.x(TrackBounds(1):TrackBounds(2))-Xaxis(1)), ScaleFactor2*(TrackInfo.y(TrackBounds(1):TrackBounds(2))-Yaxis(1)));    
 quiver(ScaleFactor2*(Xhat-Xaxis(1)),ScaleFactor2*(Yhat-Yaxis(1)),ScaleFactor2*40*D(1)*Dvec(1,1),ScaleFactor2*40*D(1)*Dvec(2,1),'r','ShowArrowHead','off','AutoScale','off');
 quiver(ScaleFactor2*(Xhat-Xaxis(1)),ScaleFactor2*(Yhat-Yaxis(1)),ScaleFactor2*40*D(1)*Dvec(1,2),ScaleFactor2*40*D(1)*Dvec(2,2),'r','ShowArrowHead','off','AutoScale','off');
 fig4.Position=[1700 400 768 768];



end