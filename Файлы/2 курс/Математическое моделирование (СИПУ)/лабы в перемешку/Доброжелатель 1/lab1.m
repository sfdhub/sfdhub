%lab1, Michenko D. G.

%exercise 1
A=magic(4);
%exercise 2
sin(A(1,1)) + ((A(2,1)+(A(3,3) * A(2,4))) / (1 +abs(cos(A(1,4)))));
%exercise 3
max(A(3,:));
mean(A(:,2));
sum(A(:,1));
prod(A(4,:));
%exercise 4
mean([sum(A(:,1)), sum(A(:,2)), sum(A(:,3)), sum(A(:,4))]);
%exercise 5
D= A;
D(1:5,5) = 1;
D(5,:)= D(4,:);
D(4,:)= D(3,:);
D(3,:)= D(2,:);
D(2,:)= D(1,:);
D(1,:)= 1;
%exercise 6
inv(A);
A * inv(A);
%exercise 7
det(A);
trace(A);
rank(A);
eig(A);
poly(A);

%part 2
%exercise 8
x = -10:1:10;
y=(cos(2*x).^2)./(2+(sin(x).^2));
plot(x,y,'m:*');
title( 'exercise 8');
xlabel('x');
ylabel('y');
grid on;
%exercise 9
[u,v]=meshgrid(-2:0.1:2,-2:0.1:2);
z = (u.^2) .* exp(-v.^2) .* (sin(u).^2);
surf(u,v,z);
shading interp;
colormap(hot);
title( 'exercise 9');
xlabel('u');
ylabel('v');
zlabel('z');
grid on;
%exercise 10
t=0:0.1:100;
x= (2*t) .* sin(t) .* cos(t);
y= t .* cos(3*t);
z=t;
plot3(x,y,z)
rotate3d
title( 'exercise 10');
xlabel('x');
ylabel('y');
zlabel('z');
grid on;
%exercise 11
theta=0:pi/50:2*pi; 
p = polar(theta,(2.^cos(3*theta)));
%exercise 12
x = -10:0.1:10;
y1= (2.^x) .* (cos(x) .^2);
y2= 0.05 .* cos(x./4);
plotyy(x,y1,x,y2,'semilogy','plot');

%and this file is exercise 13