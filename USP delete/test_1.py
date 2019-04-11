import numpy as np

# Topologia:
#        input     hidden    output
#          x1       1_h     1_o → ŷ1
#          x2       2_h     2_o → ŷ2    
#          x3


# exec(open("./test_1.py").read())

# (y-ŷ)*ŷ*(1-ŷ)
alpha = np.array([0.2, 1/3])


#                w11  w12  θ1
w_o = np.array([[1.2, 1.3, 1.4], 
                [2.2, 2.3, 2.4]])
#                w21  w22  θ2


#              f_h1  f_h2  apnd
f_h = np.array([0.3, 0.4,   1])

# f_h * (1-f_h)
def beta(f_h):
    return (f_h * (1-f_h))


#                w11  w12  w13  θ1 
w_h = np.array([[1.2, 1.3, 1.4, 1.5], 
                [2.9, 2.8, 2.7, 2.8]])
#                w21  w22  w23  θ2


#             x1   x2    x3  apnd
x = np.array([1.7, 1.5, 1.2,  1])


