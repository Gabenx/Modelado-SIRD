function [R] = rndInterval (a,b,size)

[R] = a + (b-a).*rand(size);