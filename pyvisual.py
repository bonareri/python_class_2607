import math
from turtle import *

def heart1(M):
    return 15 * math.sin(M) ** 3

def heart2(M):
    return (12 * math.cos(M)-5*\
            math.cos(2 * M)-2*\
            math.cos(3 * M)-\
            math.cos(4 * M))

bgcolor("black")
color("red")
speed(0)

for i in range(1000):
    M = i / 20

    x = heart1(M) * 15
    y = heart2(M) * 15

    goto(x, y)

done()