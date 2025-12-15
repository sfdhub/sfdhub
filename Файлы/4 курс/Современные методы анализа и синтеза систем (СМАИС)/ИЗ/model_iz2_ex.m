function dx = model_iz2_ex(t,x)
global x1_0 x2_0 T1 k
% Закон управления
u = feval('control_iz2_ex',x);
% Модель объекта
dx=[x(2)-(sin(x(1))^2); -x(2)-(x(2)^2)+u];