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
x1=x0+h
x2=x0+2*h
for(h in c(-100:100)){
PrimeraD=((1/(2*h)))*((-3*log(x0))+(4*log(x1))-(log(x1))-(log(x2)))
print(h)
#el valor mas aproximado al real es el indice 6
print(PrimeraD)
}