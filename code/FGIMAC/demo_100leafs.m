clear;
clc;
addpath(genpath('./file'));

load("100leafs.mat");
load("miss.mat");
f = 3;
ind_folds = miss3{f};
truthF = truth;  
numClust = length(unique(truthF));
num_view = length(X);
rate = sum(ind_folds,1)/sum(sum(ind_folds,1),2);
for iv = 1:num_view
    X1 = X{iv}';
    ind_0 = find(ind_folds(:,iv) == 0);
    X1(ind_0,:) = [];       
    Y{iv} = X1';            
    W1 = eye(size(ind_folds,1));
    W1(ind_0,:) = [];
    G{iv} = W1;                                               
end

SS = 0;
for i = 1:num_view
    Z = ConstructA_NP(Y{i}, Y{i},12);
     S = Z*diag(1./sum(Z,1))*Z';
     S = full(max(S,S'));
    sim{i} = (G{i}'*S*G{i})*rate(i); 
     SS = SS + sim{i};
end

 
lablece1 = spectral_clustering_lfp(SS,numClust);
result_LatLRR = ClusteringMeasure(truthF, lablece1);  
ACC = result_LatLRR(1) * 100;
NMI = result_LatLRR(2) * 100;

fprintf('\n %.02f ', ACC);
fprintf('\n %.02f \n', NMI);
 