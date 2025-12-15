close all, clear all
Uf_nom = 220;
P_nom=45e3; p=2; s_nom=0.016; kpd=0.92; cosfi=0.9;
Xm_pu=4.6; Rs_pu=0.034; Xs_pu=0.082; Rr_pu=0.017; Xr_pu=0.14; J=0.45; %s=stator, r=rotor
%%%%%%%%%%%%%%%

w0=2*pi*50/p
w_nom=w0*(1-s_nom)
M_nom=P_nom/w_nom
P2nom = P_nom/kpd
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


M_real_1 = 0:0.1*645.1:645.1
%%%Пункт 5
%при 50 гц
w_real_1_f1 = [157.1 156.6 156 155.4 154.8 154.1 153.4 152.5 151.4 149.9 146.4];
%при 25 гц
w_real_2_f2 = [235.6 235.1 234.5 233.9 233.3 232.6 231.9 231 230 228.6 225.8];
%при 75 гц
w_real_3_f3 = [78.47 77.88 77.31 76.68 75.95 75.12 74.09 72.71 70.31 0 0];
figure(5), plot(M_real_1,w_real_1_f1,M_real_1,w_real_2_f2,M_real_1,w_real_3_f3)

%%%Пункт 6
w_real_1_U = [157.1 156.5 156 155.4 154.7 154 153.2 152.3 151 149.2 144];
w_real_2_U2 = [235.6 235.1 234.5 233.9 233.3 232.6 231.9 231 230 228.6 225.8];
w_real_3_U3 = [78.47 77.88 77.31 76.68 75.95 75.12 74.09 72.71 70.31 0 0];
figure(6), plot(M_real_1,w_real_1_U1,M_real_1,w_real_2_U2,M_real_1,w_real_3_U3)

%%%%%Пункт 7

w_real_1 = [157.1 156.5 156 155.4 154.7 154 153.2 152.3 151 149.2 144];
w_real_2 = [235.6 235.1 234.5 233.9 233.3 232.6 231.9 231 230 228.6 225.8];
w_real_3 = [78.47 77.88 77.31 76.68 75.95 75.12 74.09 72.71 70.31 0 0];
figure(7), plot(M_real_1,w_real_1,M_real_1,w_real_2,M_real_1,w_real_3)






