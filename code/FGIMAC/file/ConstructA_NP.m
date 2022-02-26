%S = Z*diag(1./sum(Z,1))*Z';
%S = full(max(S,S')); % guarantee symmetry

% %% compute within-view similarity
function Z = ConstructA_NP(TrainData, Anchor,k)
%d*n
Dis = sqdist(TrainData,Anchor);
[~,idx] = sort(Dis,2);
[~,anchor_num] = size(Anchor);
[~,num] = size(TrainData);
Z = zeros(num,anchor_num);
for i = 1:num
    id = idx(i,1:k+1);
    di = Dis(i,id);
    Z(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
end
end

function d=sqdist(a,b)
% SQDIST - computes squared Euclidean distance matrix
%          computes a rectangular matrix of pairwise distances
% between points in A (given in columns) and points in B

% NB: very fast implementation taken from Roland Bunschoten

aa = sum(a.*a,1); 
bb = sum(b.*b,1); 
ab = a'*b; 
d = abs(repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab);
end
