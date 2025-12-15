%lab4, Michenko D. G. variant 21
close all; clear all; clc;
%1
main = main1;
%2
main = main2;
%3
[x,y]=meshgrid(-3:3);
[x1,y1]=meshgrid(-3:0.1:3);
[Z, Z1, Z2] = main3(x, y, x1, y1);
%4
[t,x]=ode45(@main4,[0 30],[2 2]);
figure(4), plot(t,x(:,1),'r',t,x(:,2),'b')
grid on
legend('x1(t)','x2(t)')
title( 'Gr 4')
ylabel('x')
xlabel('t')
figure(5),plot(x(:,1),x(:,2))
grid on
title( 'Gr 4_1')
xlabel('x1')
ylabel('x2')
%5
[t,x]=ode45(@main5,[0 60],[1 1 1]);
figure(6), plot(t,x(:,1),'r')
grid on
title('Gr 5')
ylabel('x')
xlabel('t')
figure(7), plot(t,x(:,2),'b')
grid on
title('Gr 5_1')
ylabel('x')
xlabel('t')
figure(8), plot(t,x(:,3),'g')
grid on
title('Gr 5_2')
ylabel('x')
xlabel('t')
figure(9)
plot3(x(:,1),x(:,2),x(:,3))
grid on
title('Gr 5_3')
xlabel('X')
ylabel('Y')
zlabel('Z')



