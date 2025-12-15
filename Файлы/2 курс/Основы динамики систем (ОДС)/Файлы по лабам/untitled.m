close all ,clear all 
while 1
   % Начало основного цикла          
   tmax=25;
   % Время моделирования 
   x0=input('Setorigins')
   % Задание начальных условий 
   [t,x]=ode45(@pendulum22,[0 tmax],x0);% Численное интегрирование системы %***************Построение фазовой траектории 
   figure(1)
   set ( 1,'units','normalized','Position',[0.0375 0.0498 0.8680 0.8467])
   pht=plot3(x(:,1),x(:,2),x(:,3));
   set(pht,'linewidth',[1],'Color',[0 0.4470 0.7410]);
   xlabel('x1'),ylabel('x2'),zlabel('x3')
   rotate3d on,grid on,hold on
   %******************Построение графиков переходных процессов переменных  
   figure(2)
   set(2,'units','normalized','Position',[0.00625 0.0575 0.778906 0.80125])
   for i=1:3
   subplot(3,1,i),plot(t,x(:,i),'b')
   xlabel('t');
   grid on
   if i==1
       ylabel('x1');
   elseif i==2
       ylabel('x2');
   else
       ylabel('x3')
   end
end
%*****************Запрос на продолжение вычислений 
f2=input('Continue?');
if isempty(f2),break,end
end