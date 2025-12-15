function [x_1,x_2,y_2,y_1] = graf
x_1 = (-10:0.1:-6);
x_2 = (-6:0.1:6);
x_3 = (6:0.1:10);
y_1 = x_1 .* 0 + 2;
y_2 = abs(x_2) ./ 3 ;
y_3 = x_3 .* 0 + 2;
x = [x_1 x_2 x_3];
y = [y_1 y_2 y_3];
plot(x,y,'m.');
grid on;
end