clear all, close all, clc
syms s p d w X t U0 U T1 T2 k Kkz
% Вариант
T0 = 0.15
k0 = 9
k1 = 0.01
kt = 1
ky = 100
P = -95
Tm = 0.016
Tya = 0.002
ke = 0.02
v = 0.75
sigma = 25
vpa(T0*w*s+ w == k0*X-k1*P)
E = kt*w
deltaU = U0-E
Uy = ky*U
vpa(Tm*Tya*s^3+Tm*s^2+s == ke*Uy)
%Передаточные функции звеньев
Wy = ky
Wd = vpa(ke/(Tm*Tya*s^3+Tm*s^2+s))
W0 = vpa(k0/(T0*s+1))
Wt = kt
Wp = vpa(k1/(T0*s+1))
Wrazomknut = vpa(simplify(expand(Wy*Wd*Wt*W0)))
T1*T2 == vpa(Tm*Tya)
T1+T2 == vpa(Tm)
vpa((Tm-T2)*T2 == Tm*Tya)
vpa(Tm*T2 - T2^2 == Tm * Tya)
vpa(T2^2 - Tm*T2 + Tm*Tya == 0)
T2_1 = vpa((Tm/2)+(sqrt(Tm^2-4*Tya*Tm)/2))
T2_2 = vpa((Tm/2)-(sqrt(Tm^2-4*Tya*Tm)/2))
T1_1 = Tm - T2_1
T1_2 = Tm - T2_2
T1 = T1_1
T2 = T1_2
Wraz = vpa(simplify(expand(18/(s*(T1*s+1)*(T2*s+1)*(T0*s+1)))))
Wzam = Wraz/(Wraz+1)
%Оценка точности
delta = simplify(1/(1+Wraz))
delta = subs(delta, s, 0)
% D - разбиение
Djw = vpa(simplify(expand(-(s*(T1*s+1)*(T2*s+1)*(T0*s+1)))))
Djw = subs(Djw, s, i * w)
omega = -30:0.005:30;
Djw = subs(Djw, w, omega);
x = real(Djw);
y = imag(Djw);
figure(1)
plot(x,y)
grid on
y = vpa(simplify(expand(s*(T1*s+1)*(T2*s+1)*(T0*s+1)+k)))
lambda1 = solve(subs(y,k,1), s, 'MaxDegree',4)
lambda2 = solve(subs(y,k,68.33), s, 'MaxDegree',4)
lambda3 = solve(subs(y,k,70), s, 'MaxDegree',4)
%Построение ЛАЧХ
w1 = log10(1/T0)
w2 = log10(1/T2)
w3 = log10(1/T1)
k = 20*log10(18)
kjel = k
Wjel = vpa(simplify(expand(kjel/(s*(T2*s+1)*(T1*s+1)^2))))
Wjelzam = vpa(simplify(expand(Wjel/(1+Wjel))))
figure (2)
plot([-w1, w1],[k, k-20], 'b', 'DisplayName','Исходная ЛАЧХ')
hold on
plot([w1, w2], [k-20, k-40], 'b', 'HandleVisibility','off')
hold on
plot([w2, w3], [k-40, k-60], 'b', 'HandleVisibility','off')
hold on
plot([w3, 4], [k-60, k-80], 'b', 'HandleVisibility','off')
hold on
plot([-w1, w2],[k, k-20],'--r', 'DisplayName','Желаемая ЛАЧХ')
hold on 
plot([w2, w3], [k-20, k-40], '--r', 'HandleVisibility','off')
hold on
plot([w3, 4], [k-40, k-80],'--r', 'HandleVisibility','off')
hold on
plot([-w1, w1], [k, k-20],'-.g', 'DisplayName','Корректирующая ЛАЧХ')
hold on
plot([w1, w3], [k-20, k],'-.g', 'HandleVisibility','off')
hold on
plot([w3, 4], [k, k],'-.g', 'HandleVisibility','off')
grid on
legend('show')
%Расчёт корректирующего звена
Kk = k/kjel
Wk = vpa(simplify(Wjel/Wraz))
Wk = vpa((T0*s+1)/(T1*s+1))
%Синтез цифрового пассивного регулятора
Wkz = vpa(Kkz*(T0*s+1)/(T1*s+1))
Kkz = T1/T0
C1 = 10^-5
R1 = T0/C1
R2 = Kkz*R1/(1-Kkz)
Ky = Kk/Kkz
