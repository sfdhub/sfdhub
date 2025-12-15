function dx= pendulum(t,x)
    dx = [4*(1-(x(1)^2))*x(1)-3*x(1)-x(2); x(1)];
