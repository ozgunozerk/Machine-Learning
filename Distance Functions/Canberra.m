function [result] = Canberra(point1,point2)
d = length(point1);
result = 0;
for i = 1:d
    diff =(abs(point1(i) - point2(i)))/(abs(point1(i))+abs(point2(i)));
    
    result = diff + result;
end
end
