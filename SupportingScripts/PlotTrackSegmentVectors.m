
function PlotTrackSegmentVectors(ChrisCstruct,index, SegmentID, DFcellArray, VecChoice)

    %VecChoices is a string either 'F' for force 'D' for diffusion or []
    %for both
    
    if nargin==4
        VecChoice=[];
    end

    fig2=figure(4);
    plot(ChrisCstruct(index).x,ChrisCstruct(index).y);
    hold on
    C=[1 find(ChrisCstruct(index).cp)'  size(ChrisCstruct(index).cp,1)];
        if C(end-1)==C(end)
            C=C(1:end-1);
        end
        
    plot(ChrisCstruct(index).x(C(SegmentID):C(SegmentID+1)),ChrisCstruct(index).y(C(SegmentID):C(SegmentID+1)),'r');
        Xhat=mean(ChrisCstruct(index).x(C(SegmentID):C(SegmentID+1)),1);
        Yhat=mean(ChrisCstruct(index).y(C(SegmentID):C(SegmentID+1)),1);
        D=str2num(DFcellArray{5});
        F=str2num(DFcellArray{4});
        Dvec=str2num(DFcellArray{7});
        Fvec=str2num(DFcellArray{6});
        
        
    if VecChoice=='F'    
        
        quiver(Xhat,Yhat, F(1)*Fvec(1,1),F(1)*Fvec(1,2),'b');
        quiver(Xhat,Yhat, F(2)*Fvec(2,1),F(2)*Fvec(2,2),'b');
        
    elseif VecChoice=='D'    
        
        quiver(Xhat,Yhat, D(1)*Dvec(1,1),D(1)*Dvec(1,2),'m','LineWidth', 1, 'MaxHeadSize', 0.5);
        quiver(Xhat,Yhat, D(2)*Dvec(2,1),D(2)*Dvec(2,2),'m','LineWidth', 1, 'MaxHeadSize', 0.5);
        
    elseif isempty(VecChoice)
        
        quiver(Xhat,Yhat, F(1)*Fvec(1,1),F(1)*Fvec(2,1),'b');
        quiver(Xhat,Yhat, F(2)*Fvec(1,2),F(2)*Fvec(2,2),'b');
        quiver(Xhat,Yhat, D(1)*Dvec(1,1),D(1)*Dvec(2,1),'m');
        quiver(Xhat,Yhat, D(2)*Dvec(1,2),D(2)*Dvec(2,2),'m');
        
    else
        disp('Invalid VecChoice.');
    end
                
        hold off
  

end