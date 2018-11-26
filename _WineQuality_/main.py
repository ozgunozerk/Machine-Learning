import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
import Demonstration
import Kmeans
import KNN
import LinearRegression


white_wine = pd.read_csv('winequality-white.csv', sep=';') # reading the dataset for white wine
red_wine = pd.read_csv('winequality-red.csv', sep=';') # reading the dataset for red wine

# store wine type as an attribute
red_wine['wine_type'] = 'red'
white_wine['wine_type'] = 'white'

# merge red and white wine datasets
wines = pd.concat([red_wine, white_wine])
wines = wines.drop(['sulphates'], axis=1) # we are not using sulphates in this project

# re-shuffle records just to randomize data points
wines = wines.sample(frac=1, random_state=42).reset_index(drop=True)

#demonstration
#Demonstration.demonstrate(wines)


######################################### DATASET ORGANIZATION ##################################
# creating the train and test dataset for K-means
y = wines.quality
X = wines.drop(['quality', 'wine_type'], axis=1)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=123, stratify=y)

# normalization of the dataset
scalar = preprocessing.StandardScaler().fit(X_train)
X_train_scaled = scalar.transform(X_train)
X_test_scaled = scalar.transform(X_test)


################################## MACHINE LEARNING ALGORITHMS ##################################

# K-MEANS
#Kmeans.Kmeans(wines, X)

# KNN
#KNN.KNN(X_train, X_train_scaled, y_train, X_test, X_test_scaled, y_test)

# Linear-Regression
LinearRegression.LinearReg(X_train_scaled, y_train, X_test, X_test_scaled, y_test, 'all')
LinearRegression.LinearReg(X_train_scaled, y_train, X_test, X_test_scaled, y_test, 'some', 0, 6)
