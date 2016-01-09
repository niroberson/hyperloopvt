syms R1 R2 R3 A B C D a b c d  c2 c3 c4 c5 

eqn1 = c2*R1 + R2*c3 -R2*c4 == A;
eqn2 = -R2*c3*a + R2*c4*b + R3*c5*c == B;
eqn3 = c2 - c3 -c4 == C;
eqn4 = -c3*a - c4*b +c5*c == D;

[MA,MB] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4],[c2, c3, c4, c5]);

%X = linsolve(MA,MB)

eqn1 = R1*c2 + R2*c3 - R2*c4 == A;
eqn2 = R2*c3*a - R2*c4*b - R3*c5*c == B;
eqn3 = c2 - c3 -c4 == C;
eqn4 = -c3*a - c4*b + c5*c == D;

[MA,MB] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4],[c2, c3, c4, c5]);

%X = linsolve(MA,MB)

eqn1 = R1*c2 + R2*c3 - R2*c4 == A;
eqn2 = R2*c3*a - R2*c4*b - R3*c5*c == B;
eqn3 = c2 - c3 -c4 == C;
eqn4 = -c3*a - c4*b + c5*d == D;

[MA,MB] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4],[c2, c3, c4, c5]);

%X = linsolve(MA,MB)

eqn1 = R1*c2 + R2*c3 - R2*c4 == A;
eqn2 = R2*c3*a - R2*c4*b - R3*c5*c == B;
eqn3 = c2 - c3 -c4 == C;
eqn4 = -c3*a + c4*b + c5*d == D;

[MA,MB] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4],[c2, c3, c4, c5]);

%X = linsolve(MA,MB)

%[solC2,solC3,solC4,solC5] = solve(eqn1,eqn2,eqn3,eqn4)

eqn1 = R1*c2 + R2*c3 - R2*c4 == A;
eqn2 = R2*c3*a - R2*c4*b - R3*c5*c == B;
eqn3 = c2 - c3 -c4 == C;
eqn4 = -c3*a - c4*b + c5*c == D;

[MA,MB] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4],[c2, c3, c4, c5])

X = linsolve(MA,MB)
