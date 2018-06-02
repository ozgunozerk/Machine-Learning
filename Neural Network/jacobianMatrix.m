function jRow = jacobianMatrix(output, perceptrons, formula)

jMatrix = zeros(1,10); % initialization of the empty row


for i=1:5
    
    jMatrix((i-1)*2 + 1) = 2 * (((-output * perceptrons(i).input1 * exp(formula))/(exp(formula) + 1)^2) ...
                             + ((perceptrons(i).input1 * exp(formula)^2) / (exp(formula) + 1)^3));
                 
    jMatrix((i-1)*2 + 2) = 2 * (((-output * perceptrons(i).input2 * exp(formula))/(exp(formula) + 1)^2) ...
                             + ((perceptrons(i).input2 * exp(formula)^2) / (exp(formula) + 1)^3));
end

jRow = jMatrix;
end

