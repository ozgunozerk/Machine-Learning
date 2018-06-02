from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import mean_squared_error
from sklearn.metrics import r2_score
import matplotlib.pyplot as plt

def KNN(X_train, X_train_scaled, y_train, X_test, X_test_scaled, y_test):
    neigh = KNeighborsClassifier(n_neighbors=10)
    neigh.fit(X_train_scaled, y_train)

    y_pred = (neigh.predict(X_test_scaled))
    y_test_array = y_test.values
    y_train_array = y_train.values

    print(mean_squared_error(y_test_array, y_pred))
    print('Variance score: \n', r2_score(y_test_array, y_pred))

    fig = plt.figure(figsize=(8, 6))
    t = fig.suptitle('Wine Residual Sugar - Alcohol Content - Acidity - Type', fontsize=14)
    ax = fig.add_subplot(111, projection='3d')

    x = list(X_train['residual sugar'])
    y = list(X_train['total sulfur dioxide'])
    z = list(X_train['alcohol'])
    data_points = [(x, y, z) for x, y, z in zip(x, y, z)]
    colors = ['red' if (wt == 3 or wt == 4) else 'purple' if wt == 7 else
    'green' if (wt == 8 or wt == 9) else 'black' for wt in y_train_array]
    alphas = [0.5 if (color == 'red' or color == 'purple' or color == 'green') else 0 for color in colors]

    fig = plt.figure(figsize=(8, 6))
    t = fig.suptitle('Wine Residual Sugar - Alcohol Content - Acidity - Type', fontsize=14)
    ax = fig.add_subplot(111, projection='3d')

    xs = list(X_test['residual sugar'])
    ys = list(X_test['total sulfur dioxide'])
    zs = list(X_test['alcohol'])
    data_points1 = [(xs, ys, zs) for xs, ys, zs in zip(xs, ys, zs)]
    colors1 = ['red' if (wt == 3 or wt == 4) else 'purple' if wt == 7 else
    'green' if (wt == 8 or wt == 9) else 'black' for wt in y_test_array]
    alphas1 = [0.3 if (color == 'red' or color == 'purple' or color == 'green') else 0 for color in colors]

    for data, color, alp in zip(data_points, colors, alphas):
        x, y, z = data
        ax.scatter(x, y, z, alpha=alp, c=color, edgecolors='none', s=25)

    for data, color, alp in zip(data_points1, colors1, alphas1):
        xs, ys, zs = data
        ax.scatter(xs, ys, zs, alpha=alp, c=color, edgecolors='none', s=35)

    ax.set_xlabel('Residual Sugar')
    ax.set_ylabel('Total Sulphur Dioxide')
    ax.set_zlabel('Alcohol')

    plt.show()