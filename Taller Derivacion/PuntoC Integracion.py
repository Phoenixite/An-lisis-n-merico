#Punto 2 C
import numpy as np
from scipy.integrate import quad

#Uso del codigo definido en el enunciado
def trapecios(f,a,b,m):
  h=(float)(b-a)/m
  s=0
  for i in range (1,m):
    s=s+f(a+i*h)
  r=h/2*(f(a)+2*s+f(b))
  return r
 
#Creacion de la funcion a utilizar
def funcion(x):
  return np.sin(x)*np.sqrt(x)

f = funcion
inf = 0
sup = 2
trap1 = 10
trap2 = 100
trap3 = 1000

#Llamado a la funcion de trapacios utilizando distintas cantidades de trapecios
aprox1= trapecios(f,inf,sup,trap1)
aprox2= trapecios(f,inf,sup,trap2)
aprox3= trapecios(f,inf,sup,trap3)

#Llamado a la funcion para integrar la funcion definida anteriormente
exacto = quad (funcion,inf,sup)

#Impresion del error de las aproximaciones con respecto al valor exacto
print ("Error aprox 1: ", abs(aprox1-exacto[0]))
print ("Error aprox 2: ", abs(aprox2-exacto[0]))
print ("Error aprox 3: ", abs(aprox3-exacto[0]))



