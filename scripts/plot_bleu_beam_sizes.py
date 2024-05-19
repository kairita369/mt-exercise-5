import matplotlib.pyplot as plt

data = {
    1:	18.6,
    2:	19.5,
    3:	19.8,
    4:	19.6,
    5:	19.5,
    7:	19.3,
    9:	19.1,
    13:	19.0,
    17:	18.9,
    21:	18.8,
}


plt.plot(list(data.keys()), list(data.values()), marker='o')

plt.xlabel('Beam size')
plt.ylabel('BLEU Scores')
plt.title('BLEU Scores per Beam Size')
plt.xticks(list(data.keys()))

plt.xlabel('Values')
plt.ylabel('Keys')
plt.title('Line Plot with Keys Positioned by Values')

plt.savefig('line_plot.png')
plt.show()