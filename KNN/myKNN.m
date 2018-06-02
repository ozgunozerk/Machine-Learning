function IDX = myKNN (k, trainingSample, vaidationSample)
Trows = size(trainingSample,1); % getting the row number of training dataset
Vrows = size(vaidationSample,1); % getting the row number of validation dataset
IDX = zeros(Vrows,1); %creating an empty arrar for clustering validation dataet

dists = zeros(Trows,1); % initialize an empty array for distances
decision = zeros(k,1); % initialize an empty array size of the variety of attributes
for i=1:Vrows
    for m=1:Trows % to compare through all the points
        dists(m) = Minkowski(vaidationSample(i,1:2),trainingSample(m,1:2), 2); % compute the distances
        % 1 for Manhattan, 2 for Euclidean, infinity for Chebyshev
    end
    
    temp = sort(dists); % sorted all the distances
    val = temp(1:k); % stored k neighbours into our new array
    
    for j=1:k % to iterate through all the neighbours
        mdv = dists == val(j); % getting the index of that neighbour
        att = trainingSample(mdv,3); % assumed that the attribute of that point is as the third variable
        decision(j) = att;
    end
    
    R = mode(decision);
    IDX(i) = R; % assigning the point to its respective cluster
end