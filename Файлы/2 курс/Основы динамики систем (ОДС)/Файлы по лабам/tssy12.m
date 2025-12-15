clear all, close all
clc
Ua_nom=220;
Ue_nom=220;
p = 1;
P_nom = 0.7e3; n_nom=1500; flux_nom=3.1e-3;
Ra=6.75;Re=600;c=378.15;w_e=4800;
w_nom=pi/30*n_nom
M_nom=P_nom/w_nom
M_kz=Ua_nom*c*flux_nom/Ra
Ia_nom=M_nom/(c*flux_nom)
Ie_nom=Ue_nom/Re
kf=flux_nom/Ie_nom
La=0.25*Ua_nom/(p*w_nom*Ia_nom)
Le=2*p*w_e*kf
Ln=M_nom/(p*Ia_nom*Ie_nom)
M=0:0.01:M_kz;
w1=Ua_nom/c/flux_nom-Ra*M/(c^2*flux_nom^2);
w2=0.65*Ua_nom/c/flux_nom-Ra*M/(c^2*flux_nom^2);
w3=0.35*Ua_nom/c/flux_nom-Ra*M/(c^2*flux_nom^2);
figure(1), plot(M,w1,M,w2,M,w3), grid on,xlabel('M'),ylabel('w')
flux1=kf*Ue_nom/Re;flux2=kf*0.65*Ue_nom/Re;flux3=kf*0.35*Ue_nom/Re
w4=Ua_nom/c/flux1-Ra*M/(c^2*flux1^2);
w5=Ua_nom/c/flux2-Ra*M/(c^2*flux2^2);
w6=Ua_nom/c/flux3-Ra*M/(c^2*flux3^2);
figure(2), plot(M,w4,M,w5,M,w6), grid on,xlabel('M'),ylabel('w')
Ua=0:0.01:Ua_nom;
Ue=25:0.01:Ue_nom;
flux=kf*Ue/Re;
w_a=Ua/c/flux_nom-Ra*M_nom/(c^2*flux_nom^2);
w_e=Ua_nom./(c*flux)-Ra*M_nom./(c^2*flux.^2);
figure(3), plot(Ua,w_a), grid on,xlabel('Ua'),ylabel('w')
figure(4), plot(Ue,w_e), grid on,xlabel('Ue'),ylabel('w')