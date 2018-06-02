function [z_value, perceptrons] = NN_Run(input1, input2, Weights)

% creation of the 5 perceptrons (2 on 2 hidden layer, 1 for output)

% hidden layer 1
p1 = perceptron(input1, input2, Weights(1), Weights(2));
p2 = perceptron(input1, input2, Weights(3), Weights(4));

Outputs1 = p1.getOutput();
Outputs2 = p2.getOutput();

%hidden layer 2
p3 = perceptron(Outputs1, Outputs2, Weights(5), Weights(6));
p4 = perceptron(Outputs1, Outputs2, Weights(7), Weights(8));

Outputs3 = p3.getOutput();
Outputs4 = p4.getOutput();

%output
p5 = perceptron(Outputs3, Outputs4, Weights(9), Weights(10));

Outputs5 = p5.getOutput();
z_value = Outputs5;
perceptrons = [p1 p2 p3 p4 p5];

end