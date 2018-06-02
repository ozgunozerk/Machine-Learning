import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
import pandas as pd


def Kmeans(wines, X):
    kmeans = KMeans(n_clusters=4).fit(X)
    wines_kmeans = wines
    wines_kmeans['label'] = kmeans.labels_
    wines_kmeans.drop(['citric acid'], axis=1)  # to see the effect of citric acid
    wines_kmeans.drop(['free sulfur dioxide', 'total sulfur dioxide'], axis=1)  # to see the effect of sulfur

    # Violin Plots
    f, (ax) = plt.subplots(1, 1, figsize=(12, 4))
    f.suptitle('Wine Quality - KMeans Labels', fontsize=14)

    sns.violinplot(x="quality", y="label", data=wines_kmeans,  ax=ax)
    ax.set_xlabel("Wine Quality",size = 12,alpha=0.8)
    ax.set_ylabel("Wine Label",size = 12,alpha=0.8)
    plt.show()

    sns.violinplot(x="label", y="quality", data=wines_kmeans, ax=ax)
    ax.set_xlabel("Wine Label", size=12, alpha=0.8)
    ax.set_ylabel("Wine Quality", size=12, alpha=0.8)
    plt.show()

    # finding percentages of the wines in labels regarding their qualities
    count_list = []  # list to store how many wines of which quality stored in each label
    sum_list = []  # list to store how many wines stored in each label

    for i in range(28):  # creation of count list
        count_list.append(0)

    for i in range(4):  # creation of sum list
        sum_list.append(0)

    df = pd.DataFrame(wines_kmeans)  # turning it into a dataframe to run for loop
    for index, row in df.iterrows():  # filling the count list
        count_list[row['label'] * 7 + row['quality'] - 3] += 1  # -3 because qualities start from 3

    for j in range(4):  # filling the sum list
        for i in range(7):
            sum_list[j] += count_list[j * 7 + i]

    for i in range(28):  # getting the percentages of which quality of wine exists in which label
        print(count_list[i] / sum_list[i // 7])

    cols = ['volatile acidity', 'pH', 'density', 'free sulfur dioxide', 'label']
    pp = sns.pairplot(wines_kmeans[cols], hue='label', size=1.8, aspect=1.8,
                      palette={0: "#FF4848", 1: "#105DCB", 2: "#39C101", 3: "#8D00C2"},
                      plot_kws=dict(edgecolor="black", linewidth=0.5))
    plt.figure()
    fig = pp.fig
    fig.subplots_adjust(top=0.93, wspace=0.3)
    t = fig.suptitle('Wine Attributes Pairwise Plots', fontsize=14)
    plt.show()