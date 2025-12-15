% control_iz2_ex - закон управления ИЗ 2
function u=control_iz2_ex(x)
global x1_0 x2_0 T1 k
u = -(-2*T1*sin(x(1))*cos(x(1))*x(2)+2*T1*sin(x(1))^3*cos(x(1))-T1*k*x(2)+T1*k*sin(x(1))^2-T1*x(2)-T1*x(2)^2+x(2)-sin(x(1))^2-k*x(1)+k*x1_0)/T1;