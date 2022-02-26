function replacenew = replace(x) 
nanData = x;
%TF = isnan(nanData); % 缺失数据位置

meanData = nanmean(nanData); % 计算每列上数据的均值（忽略NaN）
intMean = floor(meanData); % 
replacenew = fillmissing(nanData,'constant',intMean); % 填充缺失数据为均值
% x = fillmissing(nanData,'constant',0); % 也可填充缺失数据为0
