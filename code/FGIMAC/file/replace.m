function replacenew = replace(x) 
nanData = x;
%TF = isnan(nanData); % ȱʧ����λ��

meanData = nanmean(nanData); % ����ÿ�������ݵľ�ֵ������NaN��
intMean = floor(meanData); % 
replacenew = fillmissing(nanData,'constant',intMean); % ���ȱʧ����Ϊ��ֵ
% x = fillmissing(nanData,'constant',0); % Ҳ�����ȱʧ����Ϊ0
