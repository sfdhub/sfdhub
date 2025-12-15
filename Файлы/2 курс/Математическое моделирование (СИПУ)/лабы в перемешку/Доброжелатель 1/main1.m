function y = main1(x)
x=-5:0.01:5;
y=(exp(sin(x)) ./ (1 + (cos(0.5 .* x).^2)));
x1=-5:0.1:5;
y1=(exp(sin(x1)) ./ (1 + (cos(0.5 .* x1).^2)));
pz=polyfit(x1,y1,21);
figure(1),plot(x,y,x,polyval(pz,x),'m-',x1,y1,'b.')
title('Gr 1')
xlabel('X')
ylabel('Y')
grid on
end