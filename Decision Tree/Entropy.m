function [gain, stopCriteria] = Entropy(X, i)

tempStop = 0;

[rows, cols] = size(X); % getting the row and column size of the matrix
temp1 = 0;
temp2 = 0;
temp3 = 0;
temp4 = 0;

for entry = 1:rows
    if X(entry, i) == 0 % left branch
        if X(entry, cols) == 0
            temp1 = temp1 + 1;
        end
        if X(entry, cols) == 1
            temp2 = temp2 + 1;
        end
    end
    if X(entry, i) == 1 % right branch
        if X(entry, cols) == 0
            temp3 = temp3 + 1;
        end
        if X(entry, cols) == 1
            temp4 = temp4 + 1;
        end
    end
end

A = max(temp1, temp2);
B = max(temp3, temp4);

%which means we reach a pure subset, so stop recursing the function
if (temp1 == 0 || temp2 ==0) 
    tempStop = 1;
end

if (temp3 == 0 || temp4 == 0)
    tempStop = 2;
end

if (temp3 == 0 || temp4 == 0) && (temp1 == 0 || temp2 ==0)
    tempStop = 3;
end

gain = (A+B)/(rows);
stopCriteria = tempStop;
