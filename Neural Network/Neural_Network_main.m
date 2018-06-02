clc
clear
close all;

Weights_test = 7 * randn(10,1); % getting a surface for test
Weights = 7 * randn(10,1); % initializing random weights
Outputs = zeros(5,1); % initializing empty 0 arrays for outputs

input1 = (-2:0.1:2); % X coordinates
input2 = (-2:0.1:2); % Y coordinates
input2 = input2'; % transposing Y coordinates in order to 
% create a Matrix for surface generation

len = length(input1); % store the value of input1, gonna use it many times

z_real = NN_Run(input1, input2, Weights_test); % the surface our NN will
% try to approach

surf(input1, input2, z_real); % plotting the surface
hold on
pause(0.5);

l_R = 10; % learning rate
jMatrix = zeros(41, 10); % initialize the empty jacobian matrix
W_size = 10; % initializing the number of weights
I = eye(W_size,W_size); % identity matrix 


for j=1:10000 % main loop for repetition - epoch
    
    error = zeros(len,1); % resetting the error at each iteration
    
    for m=1:len % iterating through the coordinates

        [guess, p_list] = NN_Run(input1(m), input2(m), Weights); % guess is 
        % the output of the NN, p_list is the list of the 5 perceptrons
        
        formula = 0; % long formula we will use in the computation, reset
        
        for i=1:5 % iterate through the perceptrons to calculate formula
            formula = formula + (p_list(i).input1 * p_list(i).weight1 + p_list(i).input2 * p_list(i).weight2);
        end
        
        jRow = jacobianMatrix(guess, p_list, formula); % create the new row
        jMatrix(m,:) = jRow; % add that row to our matrix
        
        
        error(m) = (z_real(m,m) - (exp(formula)/(exp(formula)+1))); 
        % calculate the error
        
    end
    
    % at this point we have the jacobian matrix, error and the guess for that epoch
    
    z_guess = NN_Run(input1, input2, Weights); % estimated surface
    surf(input1, input2, z_guess);
    hold on;
    comparison = [Weights, Weights_test] % for comparing the real and estimated weights
    pause(0.1);
    
    update_value = (jMatrix' * jMatrix + l_R * I) \ (2 * jMatrix' * error(:)); % getting the update values
    
    for i=1:size(Weights) % update the weights
        
        Weights(i) = Weights(i) - update_value(i);
    end
    
end




