# Marcel Jerzyk [22.10.2019 | 15:43 - 16:01]
# Task 2.

# Calculating lim:
#
# lim(x->oo) ( e^(x) * ln(1 + e^(-x)) ) = ...
# 
#           =  ln(1 + e^-x)) / (1/e^x)               Transform
#
#           = -(((e^-x) / (1 + e^-x)) / (-e^-x))     L'Hopital
#
#           =  ((e^-x) / (1 + e^-x)) / (e^-x)        Reduce [-]
#
#           =  e^-x / ((1 + e^-x) * e^-x)            Include in the denominator
#
#           =  1 / (1 + e^-x)                        Cancel common factor [e^-x]
#
# lim(x->oo)     1      = 1
# lim(x->oo) (1 + e^-x) = 1
#
#           ... = 1/1 = 1
