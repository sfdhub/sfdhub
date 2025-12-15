% ostu_iz2_ex - программа для моделирования замкнутой системы 2-го порядка для
% ИЗ 2
close all 
% clear all          
global x1_0 x2_0 T1 k
% Параметры регулятора
x1_0=1;
T1=0.1;
k=-1;
% Параметры поля фазового портрета
figure(1)     
x1max=10; x2max=10;    
axis([-x1max x1max -x2max x2max]);
grid on
xlabel('x1');
ylabel('x2');
title('Phase portrait')
set(1,'units','normalized','Position',[0.3927    0.1259    0.5682    0.7222])
hold on
while 1 
    figure(1)
    x0 = ginput(1);
    tmax=20;
    if abs(x0(1)) > x1max || abs(x0(2)) > x2max, break, end
    [t,x]=ode45(@model_iz2_ex,[0 tmax],x0);
    start= line('color',[0 0 1], ...
        'Marker','.', ...
        'markersize',16, ...
        'xdata',x0(1),'ydata',x0(2));
    finish=line('color',[1 0 0], ...
        'Marker','.', ...
        'markersize',20, ...
        'xdata',x(length(t),1),'ydata',x(length(t),2));
    pht=plot(x(:,1),x(:,2),'b');
%     set(pht,'linewidth',[1]);
% ************* Invariant manifolf *****************
x1=-x1max:0.01:x1max;
% x1=-x1max:0.01:x1max;
x2=(sin(x1).^2)+k*x1-k*x1_0;
mf=plot(x1,x2); set (mf,'color',[1 0 0],'linewidth',[2]);
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
% Вычисление массива значений управляющего воздействия
u=[];
   for i=1:length(t)
    u(i)=feval('control_iz2_ex',x(i,:));
   end
% График переходного процесса управления
figure(3)
set(3,'units','normalized','position',[0.1620    0.0528    0.2661    0.3389])
plot(t,u,'r')
ylabel('u');
xlabel('t');
grid on
figure(1)
end
