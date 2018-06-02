clear; 
close all;
clc;

% read the training data
data = load('examples.txt');

% initialize Matrices and Variables
x = data(:, 1);     % feature matrix
y = data(:, 2);     % results matrix

m = length(x);      % number of training examples

maxX = max(x); % normalization
minX = min(x);
x = (x - maxX) / (maxX - minX);

x = [ones(m, 1), x]; %added ones for the cost function to our data


parameters = zeros(2, 1);     % initial parameters for cost
iterations = 200;  % Iterations needed for Gradient Descent
alpha = 0.4;      % Learning Rate

[parameters, costs] = myGradient(x, y, parameters, alpha, iterations);


% Plotting our final hypothesis
figure;
plot(min(x(:, 2)):max(x(:, 2)), parameters(1) + parameters(2) * (min(x(:, 2)):max(x(:, 2))));
hold on;

% Plotting the dataset on the same figure
plot(x(:, 2), y, 'rx', 'MarkerSize', 10);

figure
scatter(1:iterations, costs); % plot the cost evolution

