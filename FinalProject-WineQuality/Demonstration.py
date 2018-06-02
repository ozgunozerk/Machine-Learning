import seaborn as sns
import matplotlib.pyplot as plt
from pandas.plotting import parallel_coordinates
from sklearn.preprocessing import StandardScaler
import pandas as pd

# demonstrate the quality of wines in a graph
def demonstrate(wines):
    cp = sns.countplot(x="quality", hue="wine_type", data=wines, palette={"red": "#FF9999", "white": "#FFE888"})
    plt.show()

    # demonstrate some attributes for both red and white wine
    cols = ['density', 'residual sugar', 'total sulfur dioxide', 'fixed acidity']
    subset_df = wines[cols]

    ss = StandardScaler()
    scaled_df = ss.fit_transform(subset_df)
    scaled_df = pd.DataFrame(scaled_df, columns=cols)
    final_df = pd.concat([scaled_df, wines['wine_type']], axis=1)
    final_df.head()

    # plot parallel coordinates
    plt.figure()
    parallel_coordinates(final_df, 'wine_type', color=('#FFE888', '#FF9999'))
    plt.show()
