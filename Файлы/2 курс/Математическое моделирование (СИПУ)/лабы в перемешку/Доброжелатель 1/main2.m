function y = main2(x)
x=-2:1:6;
y=(cos(x).^2) - (0.1*(x.^2)) + (0.5.*x) - 1;
x1=-2:1:6; 
y1=interp1(x,y,x1,'cubic'); 
y12=interp1(x,y,x1,'spline'); 
x2=-2:0.01:6;
y2=(cos(x2).^2) - (0.1*(x2.^2)) + (0.5.*x2) - 1;
figure(2),plot(x,y,'*b',x1,y1,'r',x1,y12,'g',x2,y2)
title('Gr 2')
xlabel('X')
ylabel('Y')
grid on
end