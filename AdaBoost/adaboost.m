function [test_Data]= adaboost(train_Data,train_Label, valid_Data, labels_valid)
% AdaBoost function for enhancing the performance

% Choosen Weak classifiers:
% 1. GDA
% 2. knn (NumNeighbors = 30)
% 3. Naive Bayes
% 4. Logistic Regression
% 5. SVM (rbf)

data_Size=size(train_Data,1); % getting the size of our train data
data_and_label=[train_Data train_Label]; % concetanating data and labels 

weights=(1/data_Size)*ones(data_Size,1); % weigths for each input as an array
Dt=[]; h_=[]; % h_ to store results for each classifier
weights_history = zeros(data_Size,6); % creating a variable for keep tracking of the weights

Classifiers=5;
error_sum_array=zeros(Classifiers,1);

for T=1:Classifiers % loop to iterate through all the classifiers
    p_min=min(weights); % getting the minimum weight
    p_max=max(weights); % getting the maximum weight
    
    for i=1:length(weights)
        p = (p_max-p_min)*rand(1) + p_min;
        
        if weights(i)>=p
            d(i,:)=data_and_label(i,:); % selecting variables with higher or equal values
        end
        
        t=randi(size(d,1)); % selecting a random input from d
        Dt=[Dt ;d(t,:)]; % expanding Dt with selected random input
    end

    X=Dt(:,1:end-1);
    Y=Dt(:,end);
    
    if T==1
        % General Discriminant Analysis
        gda_in=fitcknn(X,Y,'NumNeighbors',20);
        gda_out=predict(gda_in, X);
        h=gda_out;
        Dt=Dt(length(Dt)+1:end,:);
    end
    
    if T==2
        % KNN with with K=20
        knn_in=fitcknn(X,Y,'NumNeighbors',20);
        knn_out=predict(knn_in, X);
        h=knn_out;
        Dt=Dt(length(Dt)+1:end,:);
    end
    
    if T==3
        % Naive Bayes
        nb_in=fitcknn(X,Y,'NumNeighbors',20);
        nb_out=predict(nb_in, X);
        h=nb_out;
        Dt=Dt(length(Dt)+1:end,:);
    end
    
    if T==4
        % Logistic Regression
        linear_in=fitcknn(X,Y,'NumNeighbors',20);
        linear_out=predict(linear_in, X);
        h=linear_out;
        Dt=Dt(length(Dt)+1:end,:);
    end
    
    if T==5
        % Binary Support Vector Machine
        svm_in=fitcknn(X,Y,'NumNeighbors',20);
        svm_out=predict(svm_in, X);
        h=svm_out;
        Dt=Dt(length(Dt)+1:end,:);
    end  
    
    h_=[h_ h];

    % weighted error
    for i=1:length(Y)
        if (h_(i,T)~=Y(i))
            error_sum_array(T)=error_sum_array(T)+weights(i,:); 
        end  
    end
    
    
    % Hypothesis weight
    alpha(T)=0.5*log((1-error_sum_array(T))/error_sum_array(T));
    
    % Update weights
    weights=weights.*exp((-1).*Y.*alpha(T).*h);
    weights=weights./sum(weights);
    weights_history(:,T) = weights; %assign the first entry to original value
end

figure(2);
surf(weights_history); % to create a surface with weight changes
figure(3);
plot(error_sum_array); % to plot error change for each method

% for generating the test set
Htest(:,1)=predict(gda_in, valid_Data);
Htest(:,2)=predict(knn_in, valid_Data);
Htest(:,3)=predict(nb_in, valid_Data);
Htest(:,4)=predict(linear_in, valid_Data);
Htest(:,5)=predict(svm_in, valid_Data);

conf_mat_score(1) = confusion_mat(labels_valid, Htest(:,1));
conf_mat_score(2) = confusion_mat(labels_valid, Htest(:,2));
conf_mat_score(3) = confusion_mat(labels_valid, Htest(:,3));
conf_mat_score(4) = confusion_mat(labels_valid, Htest(:,4));
conf_mat_score(5) = confusion_mat(labels_valid, Htest(:,5));

figure(4);
plot(conf_mat_score);

test_Data(:,1)=sign(Htest*alpha');
end
