function indeces = calculateIndeces(view, centers)
    d = pdist2(view,centers);
    [~,indeces] = min(d,[],2);
end