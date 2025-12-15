function dx = model_iz3_ex(t,x)
global T1 T2 k x1_0 x2_0 x3_0 funcu 
% Модель объекта
u=feval(funcu,x);
%************Variant 0 ****************
dx=[x(2)+x(1)^3; x(3)+0.5*x(3)*sin(x(2)); x(2)*x(1)+u];