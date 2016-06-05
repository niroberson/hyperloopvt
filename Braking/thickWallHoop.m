%% Solves for integration coefficients of thick walled hoop stress formula, given:
% di = internal radius deflection (m)
% sigo = external radius stress (Pa)
% E = young's modulus (Pa)
% v = poission's ratio (nondim)
% p = density (kg/m3)
% ri = internal radius (m)
% ro = external radius (m)

function [A, B] = thickWallHoop(di, sigo, E, v, p, ri, ro)

syms X Y n
eqn1 = (3+v)*p*n^2*ro^2/8 + X + Y/ro^2 == sigo;
eqn2 = -(1-v^2)*p*n^2*ri^3/(8*E)+(1-v)*X*ri/E-(1+v)*Y/(E*ri) == di;

[A,B] = equationsToMatrix([eqn1, eqn2], [X, Y]);

Z = linsolve(A,B);

A = -Z(1);
B = -Z(2);
end