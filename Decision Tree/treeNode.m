classdef treeNode
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        index
        value
        left
        right
    end
    
    methods
        function obj = treeNode()
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.value = [];
            obj.left = [];
            obj.right = [];
        end
    end
end

