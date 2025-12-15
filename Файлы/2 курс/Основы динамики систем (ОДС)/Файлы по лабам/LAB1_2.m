% simo_DDS2 - программа для моделирования дискретной ДС 2-го порядка 
close all, clear all
while 1 
    % Организация бесконечного цикла
    figure(1)
    set(1,'units','normalized','Position',[0.4073  0.1565  0.5427  0.6926])
    x1max=2;x2max=2;
    axis([-x1max x1max -x2max x2max]);
    grid on, xlabel('x'),ylabel('y'), hold on
    x0=ginput(1);
    if abs(x0(1)) > x1max || abs(x0(2)) > x2max, break, end
    x(1,1)=x0(1);x(1,2)=x0(2);
    % Число дискретных шагов 
    n=100;
    % Визуализация точки старта 
    inpoint=plot(x(1,1),x(1,2));
    set(inpoint,'Marker','.','MarkerSize',[8],'color',[0 0 1])
    % Начало вычислительного цикла 
    for i=1:n   
        x_next=feval(@henon,x(i,:));   
        x(i+1,1)=x_next(1);   
        x(i+1,2)=x_next(2);   
        % Визуализация текущего состояния   
        point=plot(x(i+1,1),x(i+1,2));   
        set(point,'Marker','.','MarkerSize',[4],'color',[0 0.4470 0.7410])
    end
    % Конец вычислительного цикла
    % Графики переходных процессов 
    figure(2)
    set(2,'units','normalized','position',[0.0047    0.3731    0.3880    0.4741])
    subplot(2,1,1)
    plot(x(:,1)),xlabel('k'),ylabel('x'),grid on
    subplot(2,1,2)
    plot(x(:,2)),xlabel('k'),ylabel('y'),grid on
end
