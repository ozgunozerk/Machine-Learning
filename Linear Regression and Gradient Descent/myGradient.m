function [ parameters, costs ] = myGradient( x, y, parameters, learningRate, repetition )

m = length(y); % Getting the length of the dataset
costs = ones(repetition,1);

for i = 1:repetition  % Running gradient descent
    
    h = (x * parameters - y)'; % Calculating the transpose of our hypothesis
    
    parameters(1) = parameters(1) - learningRate * (1/m) * h * x(:, 1);
    parameters(2) = parameters(2) - learningRate * (1/m) * h * x(:, 2);
    costs(i) = myCost(x, y, parameters); %storing the history of cost function
end