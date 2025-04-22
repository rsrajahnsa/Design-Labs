clc;
clear;
D_bore = 100;
L_rod = 400;
P_max = 5;
FOS_buckling = 5;
L_stroke = 100;
m = 1.5;
rpm = 2000*2*pi/60;
t_bush = 3;
sigma_c = 330;
sigma_c_allow = sigma_c/FOS_buckling;
sigma_cap = 380;
FOS_cap = 5;
sigma_bolt = 450;
FOS_bolt = 5;
Pc = pi*D_bore*D_bore*P_max/4;
Pcr = Pc*FOS_bolt;
a = 1/7500;

syms t
eqn = sigma_c*11*t*t/(1+a*(L_rod/(1.78*t))*(L_rod/(1.78*t))) == Pcr;
t = double(max(vpasolve(eqn,t)));
H_middle = 5*t;
A = 11*t*t;
kxx = 1.78*t;

Pbp = 12.5;
dp = sqrt(Pc/(1.5*Pbp));
lp = 1.5*dp;

Pcp = 10;
dc = sqrt(Pc/(1.5*Pcp));
lc = 1.5*dc;

sigma_bolt_allow = sigma_bolt/FOS_bolt;
r = L_stroke/2;
n1 = L_rod/r;
pi_max = m*rpm*rpm*r*(1 + 1/n1)/1000;
dc_bolt = 1000*sqrt(pi_max*2/(pi*sigma_bolt_allow*1e6));
d_bolt = dc_bolt/.8;
sigma_cap_allow = sigma_cap/FOS_cap;
clearance = 2;
l = d_bolt + clearance + t_bush*2 + dp;
Mb = pi_max*l/6;
bc = lc;
tc = sqrt(6*Mb/(bc*sigma_cap_allow));
I_cap = bc*tc*tc*tc/12;
y = tc/2;
