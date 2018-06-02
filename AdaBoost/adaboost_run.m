% this script playes a role of dataset constructor. 
clear
close all
clc

figure(1);
% covariance matrices
covmat.matrix = [30, 1; 1, 30];

% mean values
mean.mu = [20,0];

% sample sizes
n = 1900;

D = mvnrnd(mean.mu,covmat.matrix,n);

x=-0:0.1:40;
y = poly(x,mean.mu(1));
plot(x,y);
hold on;

data_len = size(D,1);
label=zeros(data_len, 1);

for i=1:data_len
    projection = poly(D(i,1), mean.mu(1));
    point=D(i,2);
    if projection>=point
        label(i)=-1;
        D(i,2) = D(i,2) - .5;
    else
        label(i)=1;
        D(i,2) = D(i,2) + .5;
    end
end

X = [D(:,1),D(:,2),label];
X = X(randperm(size(X,1)),:);
figure(1);
gscatter(X(:,1),X(:,2),X(:,3)); hold on;


D_train = X(1:1500,1:2);
Z_values = X(1:1500,3);
D_valid = X(1501:1900,1:2);
labels_valid = X(1501:1900,3);

valid_result = adaboost(D_train, Z_values, D_valid, labels_valid);

conf_mat_score = confusion_mat(labels_valid, valid_result)

X = D_valid(:,1);
Y = D_valid(:,2);

figure(1)
gscatter(X, Y, valid_result); %%comparison


function y = poly(x, x_offset)
    y = ((x-x_offset).^(3)-2*(x-x_offset).^(2)-(x-x_offset)+7)/400;
end




