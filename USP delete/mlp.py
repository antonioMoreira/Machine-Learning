import numpy as np
#import random

np.random.seed(42)

class MLP:

    def sigmoid(self, x):
        return (1/(1+np.exp(-x)))


    def d_sigmoid(self, x):
        return (x*(1-x))


    def preProcessing_Data(self):
        fp = open(self.datapath, 'r')

        X = [] # features
        Y = [] # labels

        for i in fp:
            j = list(map(float, i.split()[:-10]))
            j.append(1.0)            
            X.append(j)                                     #slicing inputs and adding '1' at the end
            Y.append(list(map(int, i.split(" ")[-11:-1])))  #slicing training classes
            
        fp.close()

        return (np.array(X),np.array(Y))


    def init_hLWeights(self):
        # Gera números aleatórios com distribuição normal centralizados em 0
        # no intervalo [-0.5,0.5]
        return (np.random.rand(self.hL_size, np.shape(self.X)[1])-0.5)*1e-3
        #return (np.random.rand(self.hL_size, np.shape(self.X)[1])*1e-3)-0.5


    def init_oLWeights(self):
        # Gera números aleatórios com distribuição normal centralizados em 0
        # no intervalo [-0.5,0.5]
        return (np.random.rand(self.oL_size, self.hL_size+1)-0.5)*1e-3
        #return (np.random.rand(self.oL_size, self.hL_size+1)*1e-3)-0.5



### mudar o eta 

    def __init__(self, datapath, hL_size = 2, oL_size = 1, activationFunc = sigmoid, 
                                    d_activationFunc = d_sigmoid, eta = 1e-3, threshold = 1e-2):
        self.datapath = datapath
        #self.iL_size = iL_size
        self.hL_size = hL_size
        self.oL_size = oL_size
        self.activationFunc = activationFunc
        self.d_activationFunc = d_activationFunc
        self.eta = eta
        self.threshold = threshold
        (self.X, self.Y) = self.preProcessing_Data()
        self.hL_Weights = self.init_hLWeights()
        self.oL_Weights = self.init_oLWeights()


    def feedForward(self, feedVec):
        # mudar o append de 1 do vetor aqui!!!!!!! tirar do preprocessing
        
        if(len(feedVec) != np.shape(self.X)[1]):
            return -1

        # Hidden Layer
        net_hL = np.dot(feedVec, np.transpose(self.hL_Weights))
        f_net_hL = self.sigmoid(net_hL)
        #print(np.shape(f_net_hL))

        # Output Layer
        f_net_hL = np.append(f_net_hL, [1])
        net_oL = np.dot(self.oL_Weights, np.transpose(f_net_hL)) # mudar o tranpose
        f_net_oL = self.sigmoid(net_oL)
        #print(np.shape(f_net_oL)) 

        return (f_net_oL, f_net_hL)


    def error(self, y, f_net_oL): # Calcular o erro como: Erro = (y - ŷ)
        #e(i) = ∑(d(i) - y(i))²
        return sum(pow(y-f_net_oL, 2))


    def backpropagation(self):
        squaredError = 2*self.threshold

        while(squaredError > self.threshold):
            #squaredError = 0 # ←←←←← tirar isso pra ver se converge
            
            row = 0
            for i in self.X:
                # » Forward pass
                (f_net_oL, f_net_hL) = self.feedForward(i)
                
                squaredError = squaredError + self.error(self.Y[row], f_net_oL)
                
                # » Backward pass

                # → Ajustando oL_Weights
                    # 𝝏(erro²)/𝝏(oL_Weight) = [(y-ŷ)*ŷ*(1-ŷ)]^t * f_net_hL
                d_error2_o = np.transpose([(self.Y[row]-f_net_oL) * self.d_sigmoid(f_net_oL)])*f_net_hL                
                old_oL_Weights = self.oL_Weights # para usar no ajuste da hidden layer
               
                    # w(t+1) = w(t) - η * 𝝏(erro²)/𝝏(oL_Weight)
                self.oL_Weights = old_oL_Weights + self.eta * d_error2_o


                # → Ajustando hL_Weights:
                    # ∑[(y-ŷ)*ŷ*(1-ŷ)] * w_o[...,:-1]
                    #                         ↪ θ de cada neurônio da output layer não interfere no backpropagation  
                aux1 = np.dot((self.Y[row]-f_net_oL) * self.d_sigmoid(f_net_oL), old_oL_Weights[...,:-1])
                    # 𝝏(erro²)/𝝏(hL_Weight) = (∑[(y-ŷ)*ŷ*(1-ŷ)] * w_o[...,:-1])*(f_net_hL)(1-f_net_hL)*x
                d_error2_h = np.transpose([aux1*self.d_sigmoid(f_net_hL[:-1])]) * i
                self.hL_Weights = self.hL_Weights + self.eta * d_error2_h

                row=row+1
            
            squaredError = squaredError/np.shape(self.X)[0]
            print("Erro médio quadrátrico:\t", squaredError)


def main():
    mlp1 = MLP("./data/semeion.data", hL_size=100, oL_size=10)
    
    #(f_net_oL, f_net_hL) = mlp1.feedForward(mlp1.X[0])
    #print(f_net_oL)

    mlp1.backpropagation()
    mlp1.feedForward(mlp1.X[0])

if __name__ == "__main__":
    main()