function finalCIdx = assignFinIdxPerClSkm(view1, view2, mperClV)
    view1 = view1./repmat(sqrt(sum(view1.^2,2)), 1, size(view1,2));
    view1(isnan(view1)) = 0;
    view2 = view2./repmat(sqrt(sum(view2.^2,2)), 1, size(view2,2));
    view2(isnan(view2)) = 0;
    mPerClV1 = mperClV{1};
    mPerClV2 = mperClV{2};
    K = size(mPerClV1,1);
    n = size(view1,1);
    finalCIdx = zeros(1,n);
    sphericMin = inf*ones(n,1);
    for i = 1:K
        sphericVal = acos(view1 * mPerClV1(i,:)') + acos(view2 * mPerClV2(i,:)');
        minPat = sphericVal < sphericMin;
        sphericMin(minPat) = sphericVal(minPat);
        finalCIdx(minPat) = i;
    end
end