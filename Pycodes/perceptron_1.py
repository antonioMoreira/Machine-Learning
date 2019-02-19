import numpy as np


def f(net, energy = 0.5):
    lenght = len(net)
    f_net = np.zeros(lenght)

    for i in range(lenght):
        if net[i] >= energy:
            f_net[i] = 1
        else:
            f_net[i] = 0
    
    return f_net


def perceptron_train(dataset, eta=0.1):
    dataDim = dataset.shape # (nrow, ncol)
    
    X = dataset[...,0:(dataDim[1]-1)] # slicing the X input
    Y = dataset[...,dataDim[1]-1] # slicing the training class
    
    # np.random.rand gera números aleatórios com distribuição uniforme no intervalo [0,1]
    weights = np.random.rand(dataDim[1])

    for i in range(dataDim[0]):

        # x : i-ésima linha de X concatenando [1] à direita
        #   i.e.,
        #       0-ésima linha de X: [0 0]
        #       0-ésima linha de X append[1]: [0 0 1]
        x = np.append(np.array(X[i]), [1])

        net = x*weights

        #print(net) 

        f_net = f(net)

        print(f_net)


def main():
    dataset = np.array([[0,0,0],
                        [0,1,0],
                        [1,0,0],
                        [1,1,1]])

    perceptron_train(dataset)


if __name__ == "__main__":
    main()
