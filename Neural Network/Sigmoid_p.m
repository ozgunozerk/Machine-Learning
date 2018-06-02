function output = Sigmoid_p(input) % derivative of the sigmoid

output = Sigmoid(input) * (1-Sigmoid(input)); % calculation of derivative of the sigmoid

end