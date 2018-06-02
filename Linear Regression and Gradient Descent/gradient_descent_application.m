% Loading the dataset
dataSet = load('examples.txt');

% Storing the values in seperate matrices
x = dataSet(:, 1); % input matrix
y = dataSet(:, 2); % output matrix

% Mean normalization process
maxX = max(x);
minX = min(x);
x = (x - maxX) / (maxX - minX);


x = [ones(length(x), 1) x]; % Transformed X by adding 1's, in order to matrix multiplication we will use in gradient descent function

%gradient descent part
parameters = [0; 0]; % Matrix containing our initial theta and slope
learningRate = 0.1;
repetition = 1500;
[parameters, costHistory] = myGradient(x, y, parameters, learningRate, repetition);

%plotting
plot(min(x(:, 2)):max(x(:, 2)), parameters(1) + parameters(2) * (min(x(:, 2)):max(x(:, 2)))); 
hold on;
plot(x(:, 2), y, 'rx', 'MarkerSize', 10);

% Prediction
input = 120;
input = (input - maxX) / (maxX - minX);
output = parameters(1) + parameters(2) * input;
disp(output);
