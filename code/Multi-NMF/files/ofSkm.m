function obj = ofSkm(view, centers, indeces)
    obj = 0;
    for i = 1:numel(unique(indeces))
        obj = obj + sum(view(indeces==i,:)*centers(i,:)');
    end
end