clear all, close all;
Ua_nom=220; Ue_nom=220; p=1;
P_nom=0.7e3; n_nom=1500; flux_nom=3.1e-3; Ra=6.75   ; Re=600; c=378.15; we=4800; J=0.042;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
omega_nom=2*pi*n_nom/60;
M_nom=P_nom/omega_nom
M_kz=c*Ua_nom*flux_nom/Ra
Ie_nom=Ue_nom/Re;
Ia_nom=M_nom/(c*flux_nom);
kf=flux_nom/Ie_nom;
La=0.25*Ua_nom/(p*omega_nom*Ia_nom);
Le=2*p*we*kf;
Lm=M_nom/(p*Ia_nom*Ie_nom);
M=0:3:M_kz;
figure(1)
w=Ua_nom/(c*flux_nom)-M*Ra/(c^2*flux_nom^2);
plot(M,w);
grid on, xlabel('M'),ylabel('w')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M=0:3:M_kz;
% w=Ua_nom/(c*flux_nom)-M*Ra/(c^2*flux_nom^2);
% w1=0.65*Ua_nom/(c*flux_nom)-M*Ra/(c^2*flux_nom^2);
% w2=0.35*Ua_nom/(c*flux_nom)-M*Ra/(c^2*flux_nom^2);
% figure(1) %семейство искусственных механических характеристик при изменении напряжения якоря
 %plot(M,w,M,w1,M,w2);
% grid on, xlabel('M'),ylabel('w')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%flux1=kf*Ue_nom/Re; flux2=kf*0.65*Ue_nom/Re; flux3=kf*0.35*Ue_nom/Re;
%w21=Ua_nom/(c*flux1)-M*Ra/(c^2*flux1^2);
%w22=Ua_nom/(c*flux2)-M*Ra/(c^2*flux2^2);
%w23=Ua_nom/(c*flux3)-M*Ra/(c^2*flux3^2);
%figure(2)
%plot(M,w21,M,w22,M,w23);
%grid on, xlabel('M'),ylabel('w')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%U=0:10:Ua_nom;
%flux1=kf*U/Re;
%w=Ua_nom./(c*flux1)-M_nom*Ra./(c^2*flux1.^2);
%figure(3)
%plot(U,w);
%grid on, xlabel('U'),ylabel('w')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M=0:0.1*M_kz:M_kz
wr=[187.7 168.9 150.1 131.4 112.6 93.84 75.07 56.3 37.53 18.77 0.0005922];
wr3=[122 103.2 84.45 65.69 46.92 28.15 9.384 -9.383 -28.15 -46.92 -65.68 ];
wr2=[65.68 46.92 28.15 9.384 -9.383 -28.15 -46.92 -65.68 -84.45 -103.2 -122];
figure(2)
plot(M,wr,M,wr2,M,wr3);
grid on, xlabel('M'),ylabel('w')
y2=[288.7  244.3 199.9 155.5 111 66.63 22.21 -22.21 -66.63 -111 -155.5];
y3=[520.3 371.2 222.2 73.13 -75.92 -225 -374 -523 -672.1 -821.1 -970.2];
figure(3)
plot(M,wr,M,y2,M,y3);
grid on, xlabel('M'),ylabel('w')
u2=[ 178.9 124.5 70.11  15.72 -38.67 -93.05 -147.4 -201.8 -256.2 -310.6 -365];
u3=[168.5 99.65 30.76 -38.12 -107 -175.9 -244.8 -313.7 -382.5 -451.4 -520.3];
figure(4)
plot(M,wr,M,u2,M,u3);
grid on, xlabel('M'),ylabel('w')