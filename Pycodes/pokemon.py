import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import seaborn as sns

def main():
    df = pd.read_csv('Pokemon.csv', index_col=0)

    sns.lmplot(x='Attack', y='Defense', data=df, fit_reg=False, hue='Stage')
    plt.show()


if __name__ == "__main__":
    main()

