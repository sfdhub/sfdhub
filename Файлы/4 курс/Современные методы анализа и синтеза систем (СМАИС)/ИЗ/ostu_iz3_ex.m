% ostu_iz3_ex - пример программы для моделирования 3-хмерной замкнутой системы со скалярным
% агрегированным регулятором
% model_iz3_ex - имя файла с моделью системы
% control_iz3_ex - имя файла с законом управления
close all, clear all
global T1 T2 k x1_0 x2_0 x3_0 funcu 
% Заданное значение управляемой переменной и параметры регулятора
T1=0.1;T2=0.1;k=-1;
x1_0=-1;
che=0;
% Функции модели и регулятора [1,0,-5]  [-1,0,35] [-0.5,-1,60] [0.2,-1,50]
%  [1.1,-1.7,10] [1.3,-1.7,5]
func='model_iz3_ex';
funcu='control_iz3_ex';
 while 1
 % Интерактивный ввод начальных условий 
 if x1_0>0
 switch che
    case 0
        x0=[1,0,-5]
    case 1
        x0=[-1,0,35]
    case 2
        x0=[-0.5,-1,60]
    case 3
        x0=[0.2,-1,50]
    case 4
        x0=[1.1,-1.7,10]
    case 5
        x0=[1.3,-1.7,5]
    otherwise
        %f2=input('Continue ?');
        %if isempty(f2), break,end
        break
 end
 else
     switch che
    case 0
        x0=[1,0,-30]
    case 1
        x0=[-1,0,30]
    case 2
        x0=[-0.5,-1,25]
    case 3
        x0=[0.2,1,-15]
    case 4
        x0=[1.1,1.1,-15]
    case 5
        x0=[-1.1,-1.2,90]
    otherwise
        %f2=input('Continue ?');
        %if isempty(f2), break,end
        break
     end
 end  
 %x0=input('Initial conditions x0=')
 % Время моделирования
 tmax=10;
 [t,x]=ode45(func,[0 tmax],x0);
% Вычисление массива управления 
  n=size(x,1);i=1;u=[];
  while i<=n
    u(i)=feval(funcu,x(i,:));
    i=i+1;
 end
 % Построение графиков
 figure(1) % Фазовый портрет и инвариантные многообразия
 set(1,'units','normalized','position',[0.0078    0.2472    0.5531    0.6602],'numbertitle','off',...
     'name','Фазовый портрет')
 plot3(x(:,1),x(:,2),x(:,3),'r'), hold on
 title('Фазовый портрет')
 xlabel('x1'),ylabel('x2'),zlabel('x3')
 grid on,rotate3d on
 start= line('color',[1 0 0], ...
        'Marker','.', ...
        'markersize',16, ...
        'xdata',x0(1),'ydata',x0(2),'zdata',x0(3));
 finish= line('color',[1 0 1], ...
        'Marker','.', ...
        'markersize',16, ...
        'xdata',x(length(t),1),'ydata',x(length(t),2),'zdata',x(length(t),3));
 % Построение инвариантного многообразия
 [x1,x2]=meshgrid(-2:0.1:2,-2:0.1:2);
%  [x1,x2]=meshgrid(-5:0.2:5,-5:0.2:5);
%  [x2,x3]=meshgrid(-3:0.2:3,-8:0.2:3);
 % ******** Variant 0
%  x2=-(T2*cos(x1).*sin(x1)+T2*cos(x1).*x3+T2*k*sin(x1)+T2*k*x3+T2*cos(x1)-sin(x1)-x3-k*x1+k*x1_0)/T2;
x3 = -2 .* (3 * T2 .* (x1.^2) .* x2 + 3 * T2 .* (x1.^5) - T2 * k .* x2 - T2 * k .* (x1.^3) + x2 + (x1.^3) - k .* x1 + k * x1_0) ./ (T2 .* (2 + sin(x2)));
surf(x1,x2,x3), colormap(bone)
 figure(2) % x1(t)
 set(2,'units','normalized','position',[0.5677    0.3713    0.4276    0.5389],'numbertitle','off',...
     'name','Переходной процесс по x1')
 plot(t,x(:,1))
 title('x1(t)')
 xlabel('t'),ylabel('x1')
 grid on
 figure(3) % x2(t)
 set(3,'units','normalized','position',[0.5677    0.3361    0.4276    0.5389],'numbertitle','off',...
     'name','Переходной процесс по x2')
 plot(t,x(:,2))
 title('x2(t)')
 xlabel('t'),ylabel('x2')
 grid on
 figure(4) % x3(t)
 set(4,'units','normalized','position',[0.5677    0.3009    0.4276    0.5389],'numbertitle','off',...
     'name','Переходной процесс по x3')
 plot(t,x(:,3))
 title('x3(t)')
 xlabel('t'),ylabel('x3')
 grid on
 figure(5) % u(t)
 set(5,'units','normalized','position',[0.5677    0.2657    0.4276    0.5389],'numbertitle','off',...
     'name','Переходной процесс управления')
 plot(t,u,'r')
 grid on
 xlabel('t'),ylabel('u')
 che=che+1;
   end
 
  
     
