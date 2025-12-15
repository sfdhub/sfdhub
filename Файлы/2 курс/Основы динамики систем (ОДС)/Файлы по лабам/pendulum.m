function dx= pendulum(t,x)
u=-2;
    dx = [x(1)*x(2);1+u-x(1)-x(2)];
    %dx = [4*(1-(x(1)^2))*x(1)-3*x(1)-x(2); x(1)];

