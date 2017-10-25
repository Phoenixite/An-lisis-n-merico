#Punto B: Calcule las cotas del error

#Calculo de la cota del error esta dada por h*M/2 
#donde M es la segunda derivada de la funcion(log(x)) en nuestro caso 
#que corresponde a -1/x^2
expresion1= expression(log(x))
#valor para la cota, entre mas grande sea la cota mas se vera el cambio en las cotas
# si el valor es muy pequeño el cambio  es casi despreciable 
h= 0.1
x0=1.8
x1=x0+h
errorh=h/2
#primera derivada
p=D(expresion1,"x")
print (p)
#segunda derivada
expresM=D(p,"x")
cotax0=-1/((x1)^2)
cotax1=-1/((x0) ^2)
cota1=abs(errorh*cotax0)
cota2=abs(errorh*cotax1)
print (cota1)
print (cota2)


#Punto 1E

#Se posee un incremento de error igual a h 
#Tambien se poseen x0(punto inicial),x1 y x2 que poseen los valores de : 
#h=0.1
x0=1.8
for(h in c(-100:100)){
  x1=x0+h
  x2=x0+2*h
  PrimeraD=((1/(2*h)))*((-3*log(x0))+(4*log(x1))-(log(x1))-(log(x2)))
  print(h)
  #el valor mas aproximado al real es el indice 6
  print(PrimeraD)
}


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

#Llamado a la funcion de trapacios utilizando distintas cantidades
aprox1= trapecios(f,inf,sup,trap1)
aprox2= trapecios(f,inf,sup,trap2)
aprox3= trapecios(f,inf,sup,trap3)

#Llamado a la funcion para integrar la funcion definida anteriormente
exacto = quad (funcion,inf,sup)

#Impresion del error de las aproximaciones con respecto al valor exacto
print "Error aprox 1: ", abs(aprox1-exacto[0])
print "Error aprox 2: ", abs(aprox2-exacto[0])
print "Error aprox 3: ", abs(aprox3-exacto[0])
