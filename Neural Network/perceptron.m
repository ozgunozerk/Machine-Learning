classdef perceptron
    properties
        input1 % x coordinate
        input2 % y coordinate
        weight1
        weight2
        bias
    end
    
    methods
        function obj = perceptron(x1, x2, w1, w2) % constructor
            obj.input1 = x1;
            obj.input2 = x2;
            obj.weight1 = w1; 
            obj.weight2 = w2;
            obj.bias = 2;
        end
        
        function sum = getSum(obj) % for calculating the sum
            sum = obj.input1*obj.weight1 + obj.input2*obj.weight2;
        end
        
        function output = getOutput(obj) % for calculating the output of the perceptron
            output = Sigmoid(getSum(obj));
        end
    end
    
end