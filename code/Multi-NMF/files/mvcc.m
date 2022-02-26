function [cluster_indicator] = mvcc(view1, view2, K, nround)

    if nargin < 4
        nround = 20;
    end
    % First thing: convert rows to unit length
    view1 = view1./ repmat(sqrt(sum(view1.^2,2)),1, size(view1,2));
    view1(isnan(view1)) = 0;
    view2 = view2./ repmat(sqrt(sum(view2.^2,2)),1, size(view2,2));
    view2(isnan(view2)) = 0;
    startView = view1;
    otherView = view2;
    
    %Get k centers from startView
    [CIdx, initialCenters] = litekmeans(startView, K, 'Replicates', 10);

    %Main loop until objective function yields termination criterion
    % Uses lists to exchange views
    % Starts with processing otherView
    views{1} = otherView;
    views{2} = startView;
    centers{1} = [];
    centers{2} = initialCenters;
    indeces{1} = [];
    indeces{2} = CIdx;
    maxima{1} = -inf;
    maxima{2} = -inf;
    rounds{1} = 0;
    rounds{2} = 0;
    itCount = 0;
    t = 0;
    agreementRateDf = [];
    indicesSVDf = [];
    indicesOVDf = [];

    while true
        t = t+1;
        itCount = itCount +1;
        % M-Step: cluster centers
        centers{1} = calculateCenters(views{1}, indeces{2});
        % E-Step: cluster assignment for data
        indeces{1} = calculateIndeces(views{1}, centers{1});

        if (itCount == 2)
            itCount = 0;
            rounds{1} = rounds{1} +1;
            rounds{2} = rounds{2} +1;
            of2 = ofSkm(views{2}, centers{2}, indeces{2});
            of1 = ofSkm(views{1}, centers{1}, indeces{1});
            if of2 > maxima{2}
                maxima{2} = of2;
                rounds{2} = 0;
            end
            if of1 > maxima{1}
                maxima{1} = of1;
                rounds{1} = 0;
            end
        end
        if rounds{1} > nround && rounds{2} > nround
            break;
        end
        % switch
        views = swap(views);
        centers = swap(centers);
        indeces = swap(indeces);
        maxima = swap(maxima);
        rounds = swap(rounds);
    end
    consensusMeans = consensusMeansPerClVSkm(views{1}, views{2}, indeces{1}, indeces{2});
    cluster_indicator = assignFinIdxPerClSkm(views{1}, views{2}, consensusMeans);
end







