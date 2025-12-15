% simo_DS2 - программа для моделирования ДС 2-го порядка
% Закрытие графических окон и очистка рабочей области памяти
close all,clear all
% Окно фазового портрета
figure(1)
% Задание пределов осей графического окна (поля фазового портрета)
x1max=4; x2max=4;
axis([-x1max x1max -x2max x2max]);
grid on
xlabel('x1');
ylabel('x2');
title('Фазовый портрет')
set(1,'units','normalized','Position',[0.3927 0.1259 0.5682 0.7222])
hold on
% Организация бесконечного цикла
while 1   
    figure(1)  
    x0 = ginput(1); 
    % Графический ввод начальных условий в поле портрета  
    tmax=50; 
    % Время моделирования  
    % Условия прерывания  
    if abs(x0(1)) > x1max || abs(x0(2)) > x2max, break, end
    % Вызов решателя  
    [t,x]=ode45(@pendulum,[0 tmax],x0); 
    % Визуализация точки старта траектории (начального состояния)  
    start= line('color',[0 0.4470 0.7410], ...
        'Marker','.', ...
        'markersize',16, ...
        'xdata',x0(1),'ydata',x0(2));
    % Построениефазовойтраектории  
    pht=plot(x(:,1),x(:,2));  
    set(pht,'linewidth',[1],'Color',[0 0.4470 0.7410]);
    % Построениеграфиковпереходныхпроцессовпеременных  
    figure(2)  
    set(2,'units','normalized','Position',[0.0047 0.3833 0.3630 0.4630])  
    for i=1:2    
        subplot(2,1,i)    
        x_t=plot(t,x(:,i));     
        set(x_t,'color',[0.8500 0.3250 0.0980])    
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

