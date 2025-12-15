close all, clear all
Uf_nom = 220;
P_nom=11e3; p=2; s_nom=0.028; kpd=0.875; cosfi=0.87;
Xm_pu=3.2; Rs_pu=0.043; Xs_pu=0.085; Rr_pu=0.032; Xr_pu=0.13; J=0.04; %s=stator, r=rotor
%%%%%%%%%%%%%%%

w0=2*pi*50/p;
w_nom=w0*(1-s_nom)
M_nom=P_nom/w_nom
P2nom = P_nom/kpd;
Is_nom=P_nom/3/Uf_nom/kpd/cosfi

Rs=Uf_nom/Is_nom*Rs_pu;
Xs=Uf_nom/Is_nom*Xs_pu;
Rr=Uf_nom/Is_nom*Rr_pu;
Xr=Uf_nom/Is_nom*Xr_pu;
Xm=Uf_nom/Is_nom*Xm_pu;

s_m=Rr/(sqrt(Rs^2+(Xs+Xr)^2));
M_max=3*Uf_nom^2/(2*w0*(Rs+sqrt(Rs^2+(Xs+Xr)^2)))

par1=[Rs Xs Rr Xr Xm]
%%%%%%%%%%%%%%%%%%%
s=[0.00001:0.01:1];
M=3*Uf_nom^2*Rr./(s.*w0.*((Rs+Rr./s).^2+(Xs+Xr)^2));
figure(1), plot(s,M)
grid on, xlabel('s'),ylabel('M')

w=w0*(1-s);
figure(2), plot(M,w)
grid on, xlabel('M'),ylabel('w')

Mf_1=3*Uf_nom^2*Rr./(s.*0.5*w0.*((Rs+Rr./s).^2+(Xs+Xr)^2));
wf_1=0.5*w0*(1-s);
Mf_2=3*Uf_nom^2*Rr./(s.*1.5*w0.*((Rs+Rr./s).^2+(Xs+Xr)^2));
wf_2=1.5*w0*(1-s);
figure(3), plot(M,w,Mf_1,wf_1,Mf_2,wf_2)
grid on, xlabel('M'),ylabel('w')

Mu_1=3*(0.75*Uf_nom)^2*Rr./(s.*w0.*((Rs+Rr./s).^2+(Xs+Xr)^2));
Mu_2=3*(0.5*Uf_nom)^2*Rr./(s.*w0.*((Rs+Rr./s).^2+(Xs+Xr)^2));
figure(4), plot(M,w,Mu_1,w,Mu_2,w)
grid on, xlabel('M'),ylabel('w')


M_real_1 = 0:0.1*175.3828:175.3828
%%%Пункт 5
%при 50 гц
w_real_1_f1 = [186 153.1 130 177.7 151.6 153.5 157.5 162 151.2 155.4 156.4];
%при 25 гц
w_real_2_f2 = [78.54 78.5 78.47 78.43 78.4 78.36 78.33 78.29 78.25 78.22 78.18];
%при 75 гц
w_real_3_f3 = [235.7 235.4 235 234.7 234.3 233.9 233.4 232.9 232.1 230.4 0];
figure(5), plot(M_real_1,w_real_1_f1,M_real_1,w_real_2_f2,M_real_1,w_real_3_f3)

%%%Пункт 6
w_real_1_U = [186 153.1 130 177.7 151.6 153.5 157.5 162 151.2 155.4 156.4];
w_real_2_U2 = [157.1 156.8 156.4 156.1 155.7 155.3 154.8 154.2 153.3 0 0];
w_real_3_U3 = [157.1 155.7 153.2 0 0 0 0 0 0 0 0];
figure(6), plot(M_real_1,w_real_1_U,M_real_1,w_real_2_U2,M_real_1,w_real_3_U3)

%%%%%Пункт 7

w_real_1 = [235.7 235.4 235 234.7 234.3 233.9 233.4 232.9 232.1 230.4 0];
w_real_2 = [157.1 156.8 156.4 156.1 155.7 155.3 154.8 154.2 153.3 0 0];
w_real_3 = [70.81 120.8 75.13 64.84 91.83 95.19 63 0 0 0 0];
figure(7), plot(M_real_1,w_real_1,M_real_1,w_real_2,M_real_1,w_real_3)





