%% curvefitting SIRD con RK4

clc
clear all

%%
load('dataModel.mat');

ydata=[S,I,R,D];
tdata=t;

clear S I R D t

%% Matrices para el ventaneo de 40 elementos con solapamiento de 10 
M1 = zeros(40,4);
M2 = zeros(40,4);
M3 = zeros(40,4);
M4 = zeros(40,4);
M5 = zeros(40,4);
M6 = zeros(40,4);
M7 = zeros(40,4);
M8 = zeros(40,4);
M9 = zeros(40,4);
M10 = zeros(30,4);

%% Tiempos para graficar las ventanas t1 para M1:M9 y t2 para M10
t1 = (1:40).';
t2 = (1:30).';

%% Se separan en ventanas mediante for, a partir del segundo es necesario 
%eliminar los elementos anteriores al i para mantener el tamaño de 40.

%Primeros 40 elementos 
for i=1:40
    for j=1:4
    M1(i,j) = ydata(i,j);
    end
end

%Elementos del 30 al 70
for i=30:70 
    for j=1:4
    M2(i,j) = ydata(i,j);
    end
end
%Se asegura que la matriz resultante sea de 40x4
M2(1:30,:) = [];

%Elementos del 70 al 100
for i=70:100
    for j=1:4
    M3(i,j) = ydata(i,j);
    end
end
%Se asegura que la matriz resultante sea de 40x4
M3(1:70,:) = [];

%Elementos del 90 al 130
for i=90:130 
    for j=1:4
    M4(i,j) = ydata(i,j);
    end
end
%Se asegura que la matriz resultante sea de 40x4
M4(1:90,:) = [];

%Elementos del 120 al 160
for i=120:160 
    for j=1:4
    M5(i,j) = ydata(i,j);
    end
end
%Se asegura que la matriz resultante sea de 40x4
M5(1:120,:) = [];

%Elementos del 150 al 190
for i=150:190
    for j=1:4
    M6(i,j) = ydata(i,j);
    end
end
%Se asegura que la matriz resultante sea de 40x4
M6(1:150,:) = [];

%Elementos del 180 al 220
for i=180:220
    for j=1:4
    M7(i,j) = ydata(i,j);
    end
end
%Se asegura que la matriz resultante sea de 40x4
M7(1:180,:) = [];

%Elementos del 210 al 250
for i=210:250
    for j=1:4
    M8(i,j) = ydata(i,j);
    end
end
%Se asegura que la matriz resultante sea de 40x4
M8(1:210,:) = [];

%Elementos del 240 al 280
for i=240:280
    for j=1:4
    M9(i,j) = ydata(i,j);
    end
end
%Se asegura que la matriz resultante sea de 40x4
M9(1:240,:) = [];

%Elementos del 270 al 300
for i=270:300
    for j=1:4
    M10(i,j) = ydata(i,j);
    end
end
%Se asegura que la matriz resultante sea de 30x4
M10(1:270,:) = [];


%% Parametros de prueba

%Inicializo mi vector de randoms y guardo su estructura
R = zeros(100,3);
sz = size(par);

%El intervalo de la tasa de contagio y recuperación es similar, por eso 
%los hallaremos a la vez, hallaremos la tasa de mortalidad por separado.

%Inicializo los vectores para los parametros que necesito.
tCR = zeros(100,2); 
par = rndInterval(-,5,sz);


tM = zeros(100,1);



par = [0.5,0.03,0.02];
%par = [0.8,0.1,0.01]
%par = rand(1,3)
%par = [0.2722,0.1611,0.0072];
%par = [94.0405,89.7873,3.5029];

%% Curvefitting 

[parfit] = lsqcurvefit(@RGTSS,par,tdata,ydata);

%for i=1:1000

%if par == [parfit]
%break
%else
    
%par = [parfit];
%end
%end

%% Display
yest = RGTSS(parfit,tdata);
semilogy(tdata,ydata(:,2:4),'.',tdata,yest(:,2:4)), legend('Iexp','Rexp','Dexp','Iest','Rest','Dest'), grid on

disp(' ')
disp('Parametros Encontrados')
disp(parfit)
