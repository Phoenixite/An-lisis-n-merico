#Punto 1G 
#Se posee un incremento de error igual a h 
h=0.1
x0=1.8
x1=x0+h
x2=x0+2*h
x3=x0-h
x4=x0-2*h

PrimeraDDosPuntos=(log(x1)-log(x0))/h
primeraDTresPuntos=((1/(2*h)))*((-3*log(x0))+(4*log(x1))-(log(x1))-(log(x2)))
PrimeraDCincoPuntos=(-log(x2)+8*log(x1)-8*log(x3)+log(x4))/(12*h)

print("Punto G ")
print(PrimeraDDosPuntos)
print(primeraDTresPuntos)
print(PrimeraDCincoPuntos)
print(" ")
print(" ")
print(" ")



#Punto 1K 
# Utilizando el metodo de solucion para ecuaciones diferenciales ordinarias
# De la forma y'+p(x)=q(x)
# Cuya solución para el caso práctico de circuitos sería: 
# i(t) = C*exp^(-(R*t)/(L))+E(t)*(L/R)
# Debido a que la constante C no se puede determinar dado que nos piden hallar el voltaje
# Se asume que en el tiempo cero la corriente también es cero, por lo que la solución
# quedaría de la siguiente forma i(t)=E(t)*(L/R)(exp^(-(R*t)/(L))+1), y despejando el
# voltaje, entonces se tendría E(t)=(i(t)*R)/(L*exp^(-(R*t)/(L))+1)

calcularVoltaje <-function(R,L,t,i){
  
  E = (i*R)/(L*exp(-(R*t)/(L))+1)
  return (E)
  #sprintf("Valor del voltaje : %f voltios", E)  
}


t= c(1.00,1.01,1.02,1.03,1.00)
i= c(3.10,3.12,3.14,3.18,3.24)

R=0.142
L=0.98
V= c() 

print("Punto K ")
pos =1
while(pos <= length(t)){
 V[pos] = calcularVoltaje(R,L,t[pos], i[pos]) 
 print (V[pos])
 sprintf("tiempo: %f, corriente: %f",t[pos],i[pos])
 sprintf("El valor del voltaje: %f",V[pos])
 pos=pos+1
}
plot(t,V)
print(" ")
print(" ")
print(" ")


#Punto H
print("Punto H ")
#intervalo superior
b=2
#intervalo inferior
a=1
#Funcion evaluada 1
parametro1=expression(-((b-a)/2)*(1/sqrt(3))+((b+a)/2))
x=eval(parametro1)
#valor para evaluar 1
print(x)
expre1= expression(x*exp(x))
#funcion evaluada 
num1=eval(expre1)
print(num1)
#Funcion evaluada 2
parametro2=expression(((b-a)/2)*(1/sqrt(3))+((b+a)/2))
y=eval(parametro2)
#valor para evaluar 2
print(y)
expre2= expression(y*exp(y))
#funcion evaluada 2 
num2=eval(expre2)
print(num2)
#constante
c=(b-a)/2
#evaluamos en la formula simpson y de trapecios
f=c*(num1+num2)
print(f)
print(" ")
print(" ")
print(" ")



#Punto L
print("Punto L")
#Teniendo encuenta que e=sqrt(1-((b^2)/(a^2)))debemos despejar b ya que tenemos las
#otras dos incognitas e=0.206 y a = 0.387
e=0.206
a=0.387
expresionB= expression(sqrt((1-e^2)*(a^2)))
b= eval(expresionB)
print(B)
#Despejando la ecuacion de la eclipse obtenemos que la longitud esta dada por:
#4integrate(sqrt(1-(1-(b^2)/(a^2))^2*cos^2(Theta)))from 0 to pi/2(Cuadrante que se necesario)
#al evaluar la funcion en sus respectivos intervalos obtenemos (pi(a^2+b^2))/(a^2))
#evaluamos la funcion
pi=3.14159265359
expresionIntegracion=(pi*(a^2+b^2))/a^2
integracion=eval(expresionIntegracion)
print(integracion)
print(" ")
print(" ")
print(" ")




#funcion integracion del punto J
print("Punto J")

integral=function(a,b){
  #Funcion evaluada 1
  parametro1=expression(-((b-a)/2)*(1/sqrt(3))+((b+a)/2))
  x=eval(parametro1)
  #valor para evaluar 1
  expre1= expression(x*exp(x))
  #funcion evaluada 
  num1=eval(expre1)
  #Funcion evaluada 2
  parametro2=expression(((b-a)/2)*(1/sqrt(3))+((b+a)/2))
  y=eval(parametro2)
  #valor para evaluar 2
  expre2= expression(y*exp(y))
  #funcion evaluada 2 
  num2=eval(expre2)
  #constante
  c=(b-a)/2
  #evaluamos en la formula simpson y de trapecios
  f=c*(num1+num2)
  
}
int2=integral(1,1.5)
int3=integral(1.5,2)
int=int2+int3

#fomato de numero para numero de decimales
decimales=function(x,k){
  format(round(x,k),nsmall=k)
}
decimales(int,20)

solucion=function(a,b,k){
  #entre mas divisiones 	
  expre=expression((b-a)/(2*k))
  incremento=eval(expre)
  i=a
  sol=0
  while(i<b){
    sol=sol+integral(i,i+incremento)
    i=i+incremento
  }
  solf=decimales(sol,k)
  print(solf)
}
solucion(1,2,4)