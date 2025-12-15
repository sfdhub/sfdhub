clc; clear all; close all

A = [1 2 3 4; 2 3 1 2; 1 1 1 -1; 1 0 -2 -6]

B = A(4, 2) + ((A(3, 3)*abs(A(1,4)))/(1 + cos(A(2, 1))^2))

MIN = min(A(:,2))

MAX = max(A(3, :))

MEAN = mean(A(:, 3))

SUM = sum(A(:, 3))

PROD =prod(A(4, :))

SUM_OF_MIN = min(A(:,1)) + min(A(:,2)) + min(A(:,3)) + min(A(:,4))

C = eye (4,3)

D = zeros(3, 7)

E = [C, A]

E = cat(1, D, E)

F = inv(A)

CHECKING = A * F

G = det(A)
H = trace(A)
AA = eig(A)
BB = rank(A)

x = -2*pi:pi/9:2*pi;
y = sin(x)./(1+abs(x));
figure(1);
CC = plot(x, y, 'g--d')
title('GRAPH 1')
xlabel('X')
ylabel('Y')
grid on

[u, v] = meshgrid(-3:0.15:3, -3:0.15:3)
z = sinh(u).*cos(v.^2)
figure(2);
mesh(u, v, z)
title('MESH')
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
shading interp
colormap(bone)

t = 0:0.25:100
x = t.*sin(t).*cos(t)
y = t.*cos(2.*t)
z = t
figure(3);
plot3(x, y, z)
title('PLOT3')
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on


theta = 0:pi/50:2*pi;
rho = exp(sin(3.*theta).^3)
figure(4);
polarplot(theta, rho)

x = 0:0.05:10
y1 = 100.*cos(x).^2
y2 = 0.1.*sin(x).*cos(x)
figure(5)
plotyy(x, y1, x, y2)
