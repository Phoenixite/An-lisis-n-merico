import numpy as np
import random 
import Image
import sys

print sys.argv
FILE_NAME= sys.argv[1]
MODO_INTERPOLACION =int(sys.argv[2])

MARGEN_INTERPOLACION=100
if(MODO_INTERPOLACION==2):
	MARGEN_INTERPOLACION = int(sys.argv[3])

source = Image.open(FILE_NAME)

def Binarizar(fileName,newImage,treshhold):
	source = Image.open(fileName)
	result = newImage
	for x in xrange(source.size[0]):
		for y in xrange(source.size[1]):
			r,g,b = source.getpixel((x,y))
			w = int(0.299*r + 0.587*g + 0.114*b)
			if(w>=treshhold):
				result.putpixel((x,y),(255,255,255))
			else:
				result.putpixel((x,y),(0,0,0))
	return result

def PaintAdjacent(source,result, x,y, maxX,maxY, color1, color2,colorOriginal):
	(rl,gl,bl)=(-1,-1,-1)
	(ru,gu,bu)=(-1,-1,-1)
	(rr,gr,br)=(-1,-1,-1)
	(rd,gd,bd)=(-1,-1,-1)

	if(x>0):
		(rl,gl,bl) = result.getpixel((x-1,y))
	if(x+1<maxX):
		(rr,gr,br) = result.getpixel((x+1,y))
	if(y>0):
		(ru,gu,bu) = result.getpixel((x,y-1))
	if(y+1<maxY):
		(rd,gd,bd) = result.getpixel((x,y+1))

	if(((rl,gl,bl)==(color1) or (ru,gu,bu)==(color1) or (rr,gr,br)==(color1) or (rd,gd,bd)==(color1)) and (source.getpixel((x,y))==colorOriginal)):
		result.putpixel((x,y),color2)
		return True
	return False

def Outline(file, colorOriginal, colorOutside, colorInside, colorOutline):
	area=0
	source = file
	result = Image.new("RGB",source.size,colorInside)
	result.putpixel((0,0),colorOutside)

	for x in xrange(source.size[0]):
		for y in xrange(source.size[1]):
			if(not PaintAdjacent(source,result, x,y, source.size[0],source.size[1], colorOutside,colorOutside,colorOriginal)):
				area=area+1

	for x in reversed(xrange(source.size[0])):
		for y in reversed(xrange(source.size[1])):
			if(not PaintAdjacent(source,result, x,y, source.size[0],source.size[1], colorOutside,colorOutside,colorOriginal)):
				area=area+1

	points = []
	for x in xrange(source.size[0]):
		for y in xrange(source.size[1]):
			border = PaintAdjacent(result,result, x,y, source.size[0],source.size[1], colorOutside,colorOutline,colorInside)
			if(border):
				points.append( (x,y) )
	return {'Result':result,'Points':points,'Area':area}

def Trace(result,initPoint,lineColor, pointColor, margen, modo):
	direcciones={0:(-1,-1),1:( 0,-1),2:( 1,-1),3:( 1, 0),4:( 1, 1),5:( 0, 1),6:(-1, 1),7:(-1, 0)}
	(x,y)=initPoint


	i=0
	toReturn = []
	while True:
		found =False
		for d in xrange(0,8):
			(ox,oy)=direcciones[d]
			(ax,ay)=(x+ox,y+oy)

			if(result.getpixel((ax,ay))==lineColor):
				inflexion=(d%2 == 1)
				result.putpixel((ax,ay),pointColor)
				if(inflexion and not anteriorInflexion and modo==1) or (i%margen==0 and modo ==2):
					toReturn.append((ax,ay))

				(x,y)=(ax,ay)
				anteriorInflexion = inflexion
				found=True
				i=i+1
				break
		if(not found):
			break
	return toReturn


def lerp(x0,x1, x_p):
	dist=x1-x0
	if(dist!=0):
		return int(x0+float(dist)*float(x_p))
	else:
		return x1

def drawLerp(image,x0,y0,x1,y1, lineColor):
	(xr,yr)=(0,0)

	for p in xrange(0,101):
		xr= lerp(x0,x1,float(p)/100.0)
		yr= lerp(y0,y1,float(p)/100.0)
		image.putpixel((xr,yr),lineColor)

def drawLerpSilouette(points,image, lineColor):
	primerPunto=True
	(px,py)=(0,0)
	(ax,ay)=(0,0)

	for (x,y) in points:
		if(primerPunto):
			(px,py)=(x,y)
			primerPunto=False
		else:
			drawLerp(image,x,y,ax,ay, lineColor)
		(ax,ay)=(x,y)

	drawLerp(image,px,py,ax,ay, lineColor)
	
def Mark(points, result, markColor):
	maxX=result.size[0]
	maxY=result.size[1]
	for (x,y) in points:
		result.putpixel((x,y),markColor)

	return result

print "Original"
source.show()

#Binarizacion
result = Binarizar(FILE_NAME,Image.open(FILE_NAME),240)
print "Binarizacion"
result.show()

#Outlined
dict = Outline(result,(255,255,255),(255,140,140),(140,140,255),(10,130,10))
result = dict['Result']
print "Delineado: " + str(len(dict['Points']))
result.show()

points = Trace(result,dict['Points'][0],(10,130,10), (255,255,255),MARGEN_INTERPOLACION, MODO_INTERPOLACION)
print "Trazeado"
result.show()

result = Mark(points,result,(130,000,000))

reduccion =int (float(len(dict['Points'])-len(points))/float(len(dict['Points']))*10000)
reduccion =float(reduccion)/100.0
print "Marcado: " + str(len(points))+ "("+str(reduccion)+"%)"
result.show()

drawLerpSilouette(points,result, (000,000,000))
print "Interpolado"
result.show()
#
#NUEVA IMAGEN
#

for x in xrange(result.size[0]):
	for y in xrange(result.size[1]):
		r,g,b = result.getpixel((x,y))
		w = int(0.299*r + 0.587*g + 0.114*b)
		if(w>=100):
			result.putpixel((x,y),(255,255,255))
		else:
			result.putpixel((x,y),(0,0,0))
print "Segunda Binarizacion"
#result.show()

dict2 = Outline(result,(255,255,255),(140,140,255),(255,255,140),(255,000,000))
result=dict2['Result']
print "Segundo Delineado"
result.show()

Antes=float(dict['Area'])
Despues=float(dict2['Area'])

print "Original: " +str(Antes)
print "New: "+str(Despues)

err = (Despues-Antes)/Antes
if(err<0):
	err=0-err
print "Error: "+str(100*(err))+"%"