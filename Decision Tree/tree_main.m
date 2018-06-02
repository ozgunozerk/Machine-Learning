clear
close all
clc


load('binBankDS.mat');
binDS = binDS(randperm(size(binDS,1)),:);
DS = binDS;
[rows, cols] = size(DS);


proportion = 0.7;
trainRows = floor(rows * proportion);
testRows = rows - trainRows;

trainData = DS(1:trainRows, :);
testData = DS(trainRows+1:rows, :);


rootParent = treeNode();


tree = growTree(rootParent, trainData);

outCome = treeTest(testData, tree);


confusionmat(outCome, testData(:, cols))




