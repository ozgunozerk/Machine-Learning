clear;
clc;
close all;

fh(2) = figure(2);

D = rand(8,2);
scatter(D(:,1),D(:,2))
hold on

learning_rate = 0.5;

H=[6,2;7,2;8,2;9,2;
   6,3;7,3;8,3;9,3];

scatter(H(:,1),H(:,2))
pause(1);

for k=1:100
    
    %clf(fh(2));
    
    dists = zeros(64,1); %initialize an empty array for distances
    for j=1:8
        for i=1:8
            dists((j-1)*8+i) = Minkowski(D(i,:),H(j,:), 2); %compute the distances 
            % - 1 for Manhattan, 2 for Euclidean, infinity for Chebyshev
        end
    end
    
    temp = sort(dists); % sorting the distance array
    val = temp(1); % selecting the minimum value
    mdv = find(dists == val); % finding which one is the minimum
    
    red = mdv/8; % finding which red point is the closest to the blue ones
    red = floor(red); % necessary floor operation
    red = red+1; % necesaary math stuff again
    
    blue = mod(mdv,8); % finding which blue point is the closest to the red ones
    if blue == 0 % because indexing starting from the 0,
        blue = 8; % if the result for modulo is 0, we make it 8
    end
    
    plot([D(blue,1),H(red,1)],[D(blue,2),H(red,2)]) % plotting the line between closest points
    hold on
    
    x_dist = H(red,1)-D(blue,1); % finding the distance between points, x
    y_dist = H(red,2)-D(blue,2); % finding the distance between points, y
    
    x_dist = x_dist * learning_rate; % calculating the movement step for x
    y_dist = y_dist * learning_rate; % calculating the movement step for y
    
    learning_rate = learning_rate - learning_rate * exp(-k*100); % updating the Learning Rate
    
    if red > 1 % if the red point index is bigger than 1, we need to iterate back for the ones before it
        for i=red-1:-1:1
            x_dif = H(i,1) - H(red,1); % finding the distance between the current and the closest one, x
            y_dif = H(i,2) - H(red,2); % finding the distance between the current and the closest one, y
            H(i,1) = H(i,1) - (x_dist * x_dif); % calculating the step size for current point, x
            H(i,2) = H(i,2) - (y_dist * y_dif); % calculating the step size for current point, y
        end
    end
    
    if red < 8 % if the red point index is smaller than 8, we need to iterate forth for the ones after it
        for i=red+1:8 %rest is same with upward section
            x_dif = H(i,1) - H(red,1);
            y_dif = H(i,2) - H(red,2);
            H(i,1) = H(i,1) - (x_dist * x_dif);
            H(i,2) = H(i,2) - (y_dist * y_dif);
        end
    end
    
    H(red,1) = H(red,1) - x_dist; % calculating the step size for the closest point, x
    H(red,2) = H(red,2) - y_dist; % calculating the step size for the closest point, y
    
    scatter(H(:,1),H(:,2))
    scatter(D(:,1),D(:,2))
    pause(0.3);
end









