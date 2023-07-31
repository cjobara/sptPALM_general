
function varargout=CenterTracks(X,Y,subset)

if nargin==2
    subset=1:size(X,2);
end

NormX=mean(X(:,subset),1,'omitnan');
NormY=mean(Y(:,subset),1,'omitnan');


figure;
scatter(bsxfun(@minus, X(:,subset),NormX),bsxfun(@minus,Y(:,subset),NormY));

if nargout==1
    varargout{1}=[NormX',NormY'];
end

if nargout==2
    varargout{1}=NormX;
    varargout{2}=NormY;
end


end