%% curvefitting SIRD con RK4

clc
clear all

%%
load('dataModel.mat');

ydata=[S,I,R,D];
tdata=t;

clear S I R D t
%Parametros de prueba --------------------------------------------------
par = [0.5,0.03,0.02];
%par = [0.8,0.1,0.01]
%par = rand(1,3)
%par = [0.2722,0.1611,0.0072];
%par = [94.0405,89.7873,3.5029];
%Función lsqcurvefit --------------------------------------------------

[parfit] = lsqcurvefit(@RGTSS,par,tdata,ydata);

%for i=1:1000

%if par == [parfit]
%break
%else
    
%par = [parfit];
%end
%end

yest = RGTSS(parfit,tdata);
semilogy(tdata,ydata(:,2),'b.',tdata,yest(:,2),'b-',tdata,ydata(:,3),'r.',tdata,yest(:,3),'r-',tdata,ydata(:,4),'g.',tdata,yest(:,4),'g-'), 
legend('Iexp','Rexp','Dexp','Iest','Rest','Dest'), grid on


% yest = RGTSS(parfit,tdata);
% semilogy(tdata,ydata(:,2:4),'.',tdata,yest(:,2:4)), legend('Iexp','Rexp','Dexp','Iest','Rest','Dest'), grid on

disp(' ')
disp('Parametros Ideales')
disp([0.4 0.035 0.005])
disp('Parametros Encontrados')
disp(parfit)
