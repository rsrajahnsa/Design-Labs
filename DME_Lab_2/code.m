%% Units: N, mm
% Assumptions
sigmaYT = 380;
sigmaYC = 2 * sigmaYT;
tauYT = 0.5 * sigmaYT;
FOS = 3.5;
P = 70000; % Force of 70kN

% Display Assumptions
disp(['sigmaYT = ', num2str(sigmaYT)]);
disp(['tauYT = ', num2str(tauYT)]);
disp(['FOS = ', num2str(FOS)]);
disp(['P = ', num2str(P)]);

%% Step 1: Rod Diameter
sigmat = sigmaYT / FOS;
d = sqrt(4 * (P / sigmat) / pi);
disp('Step 1');
disp(['sigma = ', num2str(sigmat)]);
disp(['d = ', num2str(d)]);

%% Step 2: Thickness of Cotter
t = 0.31 * d;
disp('Step 2');
disp(['Empirical relation t = 0.31*d = ', num2str(t)]);

%% Step 3: Spigot End
d2 = 2 * (t + sqrt(t^2 + (P / sigmat) / pi)) / pi;
disp('Step 3');
disp(['d2 = ', num2str(d2)]);

%% Step 4: Socket End
d1 = 2 * (t + sqrt(t^2 + (2 * (P / sigmat)) / pi)) / pi;
disp('Step 4');
disp(['d1 = ', num2str(d1)]);

%% Step 5: Additional Dimensions
d3 = 1.5 * d;
d4 = 2.4 * d;
disp('Step 5');
disp(['d3 = ', num2str(d3)]);
disp(['d4 = ', num2str(d4)]);

%% Step 6: Dimensions a and c
tau = tauYT / FOS;
a = P / (2 * tau * d2);
c = P / (2 * tau * (d4 - d2));
disp('Step 6');
disp(['a = ', num2str(a)]);
disp(['c = ', num2str(c)]);

%% Step 7: Dimension b
b = P / (2 * tau * t);
disp('Step 7');
disp(['b = ', num2str(b)]);

%% Step 8: Thickness of Spigot Collar
t1 = 0.45 * d;
disp('Step 8');
disp(['t1 = ', num2str(t1)]);

%% Step 9: Spigot End Safety Checks
sigmaCspigot = sigmaYC / FOS;
disp(['sigmaCspigot = ', num2str(sigmaCspigot)]);
disp(['P / (d2 * t) = ', num2str(P / (d2 * t))]);
if sigmaCspigot >= P / (d2 * t)
    disp('Spigot safe in crushing test');
else
    disp('Spigot not safe in crushing test');
end

tauspigot = tauYT / FOS;
disp(['tauspigot = ', num2str(tauspigot)]);
disp(['P / (2 * a * d2) = ', num2str(P / (2 * a * d2))]);
if tauspigot >= P / (2 * a * d2)
    disp('Spigot safe in shear test');
else
    disp('Spigot not safe in shear test');
end

%% Step 10: Socket End Safety Checks
sigmaCsocket = sigmaYC / FOS;
disp(['sigmaCsocket = ', num2str(sigmaCsocket)]);
disp(['P / ((d4 - d2) * t) = ', num2str(P / ((d4 - d2) * t))]);
if sigmaCsocket >= P / ((d4 - d2) * t)
    disp('Socket safe in crushing test');
else
    disp('Socket not safe in crushing test');
end

tausocket = tauYT / FOS;
disp(['tausocket = ', num2str(tausocket)]);
disp(['P / (2 * c * (d4 - d2)) = ', num2str(P / (2 * c * (d4 - d2)))]);
if tausocket >= P / (2 * c * (d4 - d2))
    disp('Socket safe in shear test');
else
    disp('Socket not safe in shear test');
end
