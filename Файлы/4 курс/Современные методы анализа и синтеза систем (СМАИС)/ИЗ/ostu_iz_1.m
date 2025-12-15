% ostu_iz_1 - программа для моделирования системы 2-го порядка без регулятора и с регулятором
% для ИЗ 1
close all, clear all          
figure(1)     
x1max=5; x2max=5;    
axis([-x1max x1max -x2max x2max]);
grid on
xlabel('x1');
ylabel('x2');
title('Phase portrait')
set(1,'units','normalized','Position',[0.3927    0.1259    0.5682    0.7222])
hold on
% figure(2)
% set(2,'units','normalized','Position',[0.0047    0.3833    0.3630    0.4630])
while 1 
    figure(1)
    x0 = ginput(1);
    tmax=20;
    if abs(x0(1)) > x1max || abs(x0(2)) > x2max, break, end
    [t,x]=ode45(@model_iz1_ex,[0 tmax],x0);
    start= line('color',[0 0 1], ...
        'Marker','.', ...
        'markersize',16, ...
        'xdata',x0(1),'ydata',x0(2));
%     comet(x(:,1),x(:,2),0.1)
    pht=plot(x(:,1),x(:,2),'b');
figure(2)
set(2,'units','normalized','Position',[0.0047    0.3833    0.3630    0.4630])
for i=1:2
    subplot(2,1,i),plot(t,x(:,i),'b')
    xlabel('t');
    grid on
    if i==1
        ylabel('x1');
    else
      ylabel('x2');
    end
end
figure(1)
end
