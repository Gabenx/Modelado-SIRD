%%
function [y]= RGTSS(param,tdata)
%% v. iniciales, parametros
So=579997;
Io=3;
Ro=0;
Do=0;

beta=param(1);
gamma=param(2);
mu=param(3);


h=1;      %paso
tfinal=300;   %tiempo final
t=0:h:tfinal; %vector tiempo

%% pre-localizacion en memoria

S=zeros(size(t));
I=zeros(size(t));
R=zeros(size(t));
D=zeros(size(t));

S(1)= So;
I(1)= Io;
R(1)= Ro;
D(1)= Do;

%% 
%funciones SIRD

N=So+Io+Ro+Do;
funcS=@(varS,varI) -beta*varS*varI/N;
funcI=@(varS,varI) beta*varS*varI/N - gamma*varI - mu*varI;
funcR=@(varI) gamma*varI;
funcD=@(varI) mu*varI;

%% Rungekutta para SIRD - Iteraciones


for i=1:(length(t)-1)
% k1
k1_S= h *feval(funcS,S(i),I(i));
k1_I= h *feval(funcI,S(i),I(i));
k1_R= h *feval(funcR,I(i));
k1_D= h *feval(funcD,I(i));

% k2
k2_S= h *feval(funcS,S(i) + k1_S/2, I(i) + k1_I/2);
k2_I= h *feval(funcI,S(i) + k1_S/2, I(i) + k1_I/2);
k2_R= h *feval(funcR,I(i) + k1_I/2);
k2_D= h *feval(funcD,I(i) + k1_I/2);

% k3
k3_S= h *feval(funcS,S(i) + k2_S/2, I(i) + k2_I/2);
k3_I= h *feval(funcI,S(i) + k2_S/2, I(i) + k2_I/2);
k3_R= h *feval(funcR,I(i) + k2_I/2);
k3_D= h *feval(funcD,I(i) + k2_I/2);

% k4
k4_S= h *feval(funcS,S(i) + k3_S, I(i) + k3_I);
k4_I= h *feval(funcI,S(i) + k3_S, I(i) + k3_I);
k4_R= h *feval(funcR,I(i) + k3_I);
k4_D= h *feval(funcD,I(i) + k3_I);

%consolidacion
S(i+1)= S(i) +(k1_S + 2*k2_S + 2*k3_S + k4_S)/6;
I(i+1)= I(i) +(k1_I + 2*k2_I + 2*k3_I + k4_I)/6;
R(i+1)= R(i) +(k1_R + 2*k2_R + 2*k3_R + k4_R)/6;
D(i+1)= D(i) +(k1_D + 2*k2_D + 2*k3_D + k4_D)/6;

end

%% MODELO SIMULINK

S=spline(t,S,tdata);
I=spline(t,I,tdata);
R=spline(t,R,tdata);
D=spline(t,D,tdata);

%%

y = [S,I,R,D];
%%