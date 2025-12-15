%lab3, Michenko D. G. variant 19
close all;
clear all; 
clc;
%1
A=[-7 -2 -7 3; 2 -2 1 3;1 -3 5 7; -5 -2 4 5];
B=[-1; -3; 5; -4];
res1=A\B;
res1_2=A*res1;
%2
res2=fzero(@fun,[-5,5]);
res2_2=fsolve(@fun,-5:5);
x=(-5:0.1:5);
plot(x,(sin(x)-(0.2*x)-0.5));
%3
x_3=(1:0.1:5);
plot(x_3, ((5 .* sin(x_3)) ./ x_3));
%min
res3=fminbnd(@fun2,-7,7);
%max
res3_2=fminbnd(@fun2_1,-7,7);
%4
res4=fminsearch(@fun3,[0 0]);
[x_4,y_4]=meshgrid(-1:0.1:1,-1:0.1:1);
z_4=(4 .* (x_4.^2)) + (3 .* (y_4.^2)) - (4 .* x_4 .* y_4) + x_4;
surf(x_4,y_4,z_4);  
%5
x_5=-5:0.1:5;
y_5=sin(2 .* x_5) ./ x_5;
dy=diff(y_5)/0.1;
plot(x_5,y_5,x_5(1:length(x_5)-1),dy);
%6
x_6=0:0.01:-4;
y_6=((x_6.^2) + (7 .* x_6) + 12) .* cos(x_6); 
tr = trapz(x_6,y_6);
qd = quad('((x_6.^2) + (7 .* x_6) + 12) .* cos(x_6)',1,2);
%7
x_7=plot(roots([1 1 -13 39 12 -40]),'.')