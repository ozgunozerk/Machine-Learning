function IDX = dbscan(DD, epsilon, minP)

    numrows = size(DD,1); %number of rows in the matrix
    IDX = zeros(numrows,1); %array for labelization
    visited = zeros(numrows,1); % creating an empty list for visited flag
    clusterNumber = 0; % we must start numbering clusters from 1
    %noise points will be labelized as 0

    for i=1:numrows
        if visited(i) == 1 %check for if point is already visited, probably unnecessary check
            continue;
        end
        if visited(i) == 0 %if point is not visited
            if size(findRegion(i),1) >= minP %if point has enough neighbours
                clusterNumber = clusterNumber + 1; %creating a new cluster index 
                expandCluster(i); %calling our function which assembles the cluster
            end
        end
    end
           
    function expandCluster(pointIndex) %recusrisve function which expands the cluster if necessary
        if visited(pointIndex) == 0 %if point is not visited, this check is necessary since this function is recursive
            visited(pointIndex) = 1; %mark it as visited
            Neighbour_list = findRegion(pointIndex); %getting the neighbour list
            Neighbour_size = size(Neighbour_list,1); %gettin the array size of neighbour list
            IDX(pointIndex) = clusterNumber; %assigning the points to the current cluster
            if Neighbour_size>minP %if there are enough neighbours--
                for k=1:Neighbour_size %for each neighbour--
                        expandCluster(Neighbour_list(k)); %call this recursive function on the neighbours.
                end
            end
        end
    end
           
    function Neighbours=findRegion(i)
        dists = zeros(numrows,1); %initialize an empty array for distances
        for m=1:numrows
            dists(m) = Cosine(DD(i,:),DD(m,:)); %compute the distances - 1 for Manhattan, 2 for Euclidean, infinity for Chebyshev
        end
        Neighbours = find((dists<=epsilon) & (dists>0)); %assign all the neighbours to a list, which is the output of this function
    end
end
