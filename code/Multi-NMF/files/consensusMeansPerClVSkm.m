function concensusMeans = consensusMeansPerClVSkm(view1, view2, index1, index2)
    labels = intersect(unique(index1), unique(index2));
    for i = 1:numel(labels)
        sharedInJ = index1 == labels(i) & index2 == labels(i);
        mPerClV1 = mean(view1(sharedInJ,:));
        mPerClV1 = mPerClV1 ./ repmat(sqrt(sum(mPerClV1.^2,2)), 1, size(mPerClV1,2));
        mPerClV2 = mean(view2(sharedInJ,:));
        mPerClV2 = mPerClV2 ./ repmat(sqrt(sum(mPerClV2.^2,2)), 1, size(mPerClV2,2));
        concensusMeans{1}(i,:)= mPerClV1;
        concensusMeans{2}(i,:) = mPerClV2;
    end
end