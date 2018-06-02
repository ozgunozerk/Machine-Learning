function result = Minkowski(point1,point2,p) %p=1 Manhattan, p=2 Euclidean, infinity for Chebyshev
d = length(point1);
sum = 0;
for i = 1:d
    diff =(abs(point1(i) - point2(i))^p);
    sum = diff + sum;
end
result = sum^(1/p);
end