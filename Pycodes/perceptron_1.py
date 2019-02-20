import numpy as np


def f(net, energy = 0.5):
    if net >= energy:
        return 1
    else:
        return 0


def gradientDescent(weights, eta, dE2):
    return(weights-(eta*dE2))


def derivateError2(error, x):
    return(-2*x*(error))


def perceptron_test(x, weights):
    net = np.dot(np.append(np.array(x),[1]), weights)
    return(f(net))


def perceptron_train(dataset, eta=0.1, threshold = 1e-3):
    dataDim = dataset.shape # (nrow, ncol)
    
    X = dataset[...,0:(dataDim[1]-1)] # slicing the X input
    Y = dataset[...,dataDim[1]-1] # slicing the training class
    
    # np.random.rand gera números aleatórios com distribuição uniforme no intervalo [0,1]
    weights = np.random.rand(dataDim[1])

    sqrterror = 2*threshold

    while(sqrterror > threshold):
        sqrterror = 0

        for i in range(dataDim[0]):

            # x : i-ésima linha de X concatenando [1] à direita
            #   i.e.,
            #       0-ésima linha de X: [0 0]
            #       0-ésima linha de X append[1]: [0 0 1]
            x = np.append(np.array(X[i]), [1])
            y = Y[i]

            # produto interno entre x e weights
            net = np.dot(x, weights)

            # aplicando a função de ativação
            f_net = f(net)
            
            error = y - f_net
            sqrterror = sqrterror + pow(error,2)

            dE2 = derivateError2(x, error)
            weights = gradientDescent(weights, eta, dE2)

        sqrterror = sqrterror/dataDim[0]
        print("error: ", sqrterror)

    return(weights)


def main():
    dataset = np.array([[0,0,0],
                        [0,1,0],
                        [1,0,0],
                        [1,1,1]])

    weights =  perceptron_train(dataset)
    res = perceptron_test([0,1], weights)
    print(res)


if __name__ == "__main__":
    main()
