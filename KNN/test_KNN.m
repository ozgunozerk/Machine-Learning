clear;
clc;
close all
load('classification_1.mat');

% this is a program for the implementation of a KNN algortihm, the assumed
% situation is there exist a point in the dataset which must be assigned to
% a class, and the attributes are represented with numbers
D_train = [D_train, labels_train];
D_valid = [D_valid, labels_valid];
k = 3; % number of neighbours
IDX = myKNN(k, D_train, D_valid);

gscatter(D_train(:,1),D_train(:,2),D_train(:,3),'krgbm','o',5); hold on
gscatter(D_valid(:,1),D_valid(:,2),IDX,'krgbm','.',15); hold on
