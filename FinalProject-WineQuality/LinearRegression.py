from sklearn.metrics import mean_squared_error
from sklearn.metrics import r2_score
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression


def LinearReg(X_train_scaled, y_train, X_test, X_test_scaled, y_test, str, column1 = 0, column2 = 0):
    if (str == 'all'):
        regr = LinearRegression()
        regr.fit(X_train_scaled, y_train)
        regr_pred = regr.predict(X_test_scaled)


    if (str == 'some'):
        regr = LinearRegression()
        regr.fit(X_train_scaled[:, [column1, column2]], y_train)
        regr_pred = regr.predict(X_test_scaled[:, [column1, column2]])

    # Display Co-efficients
    print('Coefficients: \n', regr.coef_)

    # Mean-Squared error
    print('Mean-Squared Error: \n', mean_squared_error(regr_pred, y_test))

    print('Variance score: \n', r2_score(regr_pred, y_test))

    # Visualizing 3-D numeric data with a bubble chart
    #  length, breadth and size
    plt.scatter(X_test['total sulfur dioxide'], X_test['alcohol'], s=regr_pred * 20, alpha=0.4, edgecolors='w')

    plt.xlabel('Total Sulphur Dioxide')
    plt.ylabel('Alcohol')
    plt.title('Wine Alcohol Content - Total Sulphur Dioxide - Label', y=1.05)
    plt.show()

