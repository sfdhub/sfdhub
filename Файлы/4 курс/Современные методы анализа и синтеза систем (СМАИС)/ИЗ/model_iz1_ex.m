function dx = model_iz1_ex(t,x)
% u=0;
x2_0=2000000;
u = -3*x(1)+x(1)*(x(2)^2)+x2_0;
dx=[(3-(x(2)^2))*x(1)-2*x(1)-x(2)+u;x(1)];