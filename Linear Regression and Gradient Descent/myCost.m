function cost = myCost( x, y, parameters )
    cost = (x * parameters - y)' * (x * parameters - y) / (2 * length(y)); % calculation of the cost function 
end