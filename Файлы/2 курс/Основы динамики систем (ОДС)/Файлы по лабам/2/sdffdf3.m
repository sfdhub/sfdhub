close all, clear all
figure(1)
set(1,'units','normalized','Position',[0.0375 0.0498 0.8680 0.8467])
% Задание пределов фазового портрета
x1max=4; x2max=4;
axis([-x1max x1max -x2max x2max]);
% Шаг сетки начальных условий
xstep=1;
% Время моделирования (сек)
tmax=20;
% Шаг демонстрации по времени (сек)
tstep=1;
% Имя файла-функции с моделью ДС
func='pendulum';
set(gca,'xgrid','on','ygrid','on')
xlabel('x1');
ylabel('x2');
title('t=0')
h2=get(gca,'title');
set(h2,'fontname','arial',...
 'fontsize',[16],'color',[0.3 0 0.5],'fontweight','bold',...
 'fontangle','normal')
axx=line([-x1max x1max],[0 0]);set(axx,'color',[0.5 0.5 0.5])
axy=line([0 0],[-x2max x2max]);set(axy,'color',[0.5 0.5 0.5])
hold on
% Демонстрация начальной сетки
[x1,x2]=meshgrid(-x1max:xstep:x1max,-x2max:xstep:x2max); 
n1=size(x1,1); n2=size(x2,1);
for k=1:n1
 for l=1:n2
 start= line('color',[0.6 0 0.6], ...
 'Marker','.', ...
 'markersize',15, ...
 'xdata',x1(k,l),'ydata',x2(k,l));
end
end
figure(1)
tt=tstep;t0=0;
for k=1:n1
 for l=1:n2
 y0_1(k,l)=x1(k,l);y0_2(k,l)=x2(k,l);
 end
end
pause
% Запуск основного цикла
while tt<tmax+tstep
 cla
for k=1:n1
 for l=1:n2
 y0=[y0_1(k,l) y0_2(k,l)];
 [t,y]=ode45(@pendulum,[t0 tt],y0);
 currient= line('color',[0.6 0 0.6], ...
 'Marker','.', ...
 'markersize',15, ...
 'xdata',y(length(t),1),'ydata',y(length(t),2));
 y0_1(k,l)=y(length(t),1);y0_2(k,l)=y(length(t),2);
 hold on
 end 
end
figure(1)
set(gca,'xgrid','on','ygrid','on')
 xlabel('x1');
 ylabel('x2');
 titl=['t=' num2str(tt) 'c'];
 title(titl)
 h2=get(gca,'title');
 set(h2,'fontname','arial',...
 'fontsize',[16],'color',[0.3 0 0.5],'fontweight','bold',...
 'fontangle','normal')
 axx=line([-x1max x1max],[0 0]);set(axx,'color',[0.5 0.5 0.5])
 axy=line([0 0],[-x2max x2max]);set(axy,'color',[0.5 0.5 0.5])
% pause(1)
pause
t0=t0+tstep;tt=tt+tstep;
end
