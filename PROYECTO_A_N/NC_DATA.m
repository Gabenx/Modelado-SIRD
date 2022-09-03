%% data
clear all 
clc
close all

load('data.mat')

N = 580000;
T=300;
t=1:T;

S = zeros(T,1);
S(1:T)=N;

S2 = zeros(T,1);
S2(1:T)=N;

for i=1:length(data)
    S(i:end)=S(i:end)-data(i);
end

%% 
A=S2-S;

B=[0; 0; 0; 0; 0; 0; 0; A(1:293)];

I = A-0.98*B-0.02*B;
R = 0.98*B;
D = 0.02*B;
I(I<0.01) = 0;
D(D<0.01) = 0;
t = t';
%plot(t,A)
%plot(t,I)
%plot(t,A)

%% SIRD GRAPH 
%semilogy(t,S,t,I,t,R,t,D), legend('S','I','R','D')
semilogy(t,I,t,R,t,D), legend('I','R','D')
%% IRD GRAPH
%plot(t,I,t,R,t,D), legend('I','R','D')
%% ID GRAPH
%plot(t,I,t,D), legend('I','D')

filename = 'dataModel.mat';
save('dataModel.mat','S','I','R','D','t')






