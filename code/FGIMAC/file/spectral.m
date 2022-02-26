function C = spectral(W,sigma, num_clusters)
% �׾����㷨
% ʹ��Normalized���Ʊ任
% ����  : W             : N-by-N ����, �����Ӿ���
%        sigma          : ��˹�˺���,sigmaֵ
%        num_clusters   : ������
%
% ���  : C : N-by-1���� ����������ǩֵ
%
    format long
    m = size(W, 1);

    %�������ƶȾ���S  ���ƶȾ�����Ȩֵ����õ���ʵ����һ���ø�˹�˺���
	W = W.*W;   %ƽ��
	W = -W/(2*sigma*sigma);
    S = full(spfun(@exp, W));
    
    %��öȾ���D,�˴�DΪ���ƶȾ���S��һ��Ԫ�ؼ������ŵ��Խ����ϣ��õ��Ⱦ���D
    D = full(sparse(1:m, 1:m, sum(S)));
    
    % ���������˹���� , L =I - D^(-1/2) * S * D^(-1/2)
    L = eye(m)-(D^(-1/2) * S * D^(-1/2));
    
    % ���������� V
    %  eigs 'SM';����ֵ��С����ֵ
    [V, ~] = eigs(L, num_clusters, 'SM');

    % ������������k-means
   C = litekmeans((normcols(V'))',num_clusters,'Replicates',20,'MaxIter',1e3);
   %C=kmeans(V,num_clusters);
end