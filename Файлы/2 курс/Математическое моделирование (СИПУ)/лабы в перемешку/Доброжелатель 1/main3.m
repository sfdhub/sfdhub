function [Z, Z1, Z2] = main3(x, y, x1, y1)
[x,y]=meshgrid(-3:3);
Z=sin((x.^2) + (y.^2));
[x1,y1]=meshgrid(-3:0.1:3);
Z1=interp2(x,y,Z,x1,y1,'cubic');
Z2=sin((x1.^2) + (y1.^2));
figure(3), mesh(x1,y1,Z1+2)
title('Gr 3')
xlabel('X')
ylabel('Y')
zlabel('Z')
hold
surf(x1,y1,Z2)
grid on
end