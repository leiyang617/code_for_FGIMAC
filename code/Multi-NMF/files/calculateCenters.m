function centers = calculateCenters(view, index)
    centers = zeros(numel(unique(index)), size(view,2));
    for i = 1:numel(unique(index))
        centers(i,:) = mean(view(index==i,:));
        centers(i,:) = centers(i,:)./sqrt(sum(centers(i,:).^2));
    end
end