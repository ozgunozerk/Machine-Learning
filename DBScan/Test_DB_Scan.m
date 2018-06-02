clear
clc

minP = 30; %minimum points
eps = 1; %radius


load("DD1.mat")
%DD = Data.DS;
clusters = dbscan(DD, eps, minP); %generating the clusters

gscatter(DD(:,1),DD(:,2),clusters); %scattering them
hold on
%scatter(DD(:,1),DD(:,2));