import numpy as np
import sympy as sp

# Given constants
D_bore = 100
L_rod = 400
P_max = 5
FOS_buckling = 5
L_stroke = 100
m = 1.5
rpm = 2000 * 2 * np.pi / 60
t_bush = 3
sigma_c = 330
sigma_c_allow = sigma_c / FOS_buckling
sigma_cap = 380
FOS_cap = 5
sigma_bolt = 450
FOS_bolt = 5
Pc = np.pi * D_bore**2 * P_max / 4
Pcr = Pc * FOS_bolt
a = 1 / 7500

# Symbolic solution for thickness `t`
t = sp.Symbol('t', positive=True, real=True)
eqn = sigma_c * 11 * t**2 / (1 + a * (L_rod / (1.78 * t))**2) - Pcr
sols = sp.solve(eqn, t)
t_val = max([float(s.evalf()) for s in sols if s.is_real and s > 0])

# Further calculations
H_middle = 5 * t_val
A = 11 * t_val**2
kxx = 1.78 * t_val

Pbp = 12.5
dp = np.sqrt(Pc / (1.5 * Pbp))
lp = 1.5 * dp

Pcp = 10
dc = np.sqrt(Pc / (1.5 * Pcp))
lc = 1.5 * dc

sigma_bolt_allow = sigma_bolt / FOS_bolt
r = L_stroke / 2
n1 = L_rod / r
pi_max = m * rpm**2 * r * (1 + 1/n1) / 1000
dc_bolt = 1000 * np.sqrt(2 * pi_max / (np.pi * sigma_bolt_allow * 1e6))
d_bolt = dc_bolt / 0.8

sigma_cap_allow = sigma_cap / FOS_cap
clearance = 2
l = d_bolt + clearance + 2 * t_bush + dp
Mb = pi_max * l / 6
bc = lc
tc = np.sqrt(6 * Mb / (bc * sigma_cap_allow))
I_cap = bc * tc**3 / 12
y = tc / 2

# Displaying key results
print(f"t = {t_val:.4f} mm")
print(f"H_middle = {H_middle:.4f} mm")
print(f"A = {A:.4f} mm²")
print(f"kxx = {kxx:.4f} mm")
print(f"dp = {dp:.4f} mm")
print(f"dc = {dc:.4f} mm")
print(f"d_bolt = {d_bolt:.4f} mm")
print(f"tc = {tc:.4f} mm")
print(f"I_cap = {I_cap:.4f} mm⁴")
print(f"y = {y:.4f} mm")
