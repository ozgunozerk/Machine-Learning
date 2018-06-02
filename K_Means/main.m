clear;
clc;
close all
load('gaussians.mat');

k = 5; %number of clusters, also centroids

[rows, cols] = size(DD); %getting the row and col number from out matrix DD
centroid = randn(k,cols); %assigning random X and Y value for our 3 centroids
for c = 0 : 20 %repeat the whole algorithm for 20 times to get more acccuracy
for i = 1 : rows
    for j = 1:k
        distnc(j) = Minkowski(centroid(j,:), DD(i,:), 2); %calculating the distance between a point to every centorid
    end
    md = min(distnc); %selecting the min because we want to find the closest centroid
    mdv = find(distnc == md); %getting the number of that centroid
    IDX(i) = mdv; %assigning that centroid number to a vector
end


for i = 1:k
    centroid(i,:) = mean(DD(IDX==i,:)); %this line to be asked to the teacher
end

end

gscatter(DD(:,1), DD(:,2),IDX); hold on
%scatter(centroid(:,1), centroid(:,2)); hold on


