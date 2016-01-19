
function [Pe,M1,M2,Me] = Pe_given_Ashock(A1_At,Ae_At,Po)

% function to calculate Pe given Po, A1/At and Ae/At
%
% refer to figure 5.19 - this is example 5.6
%
% Pe/Po = (Pe/Peo)(Pe0/Po2)(Po2/Po1)(Po1/Po)
%
% but Peo = Po2 &  Po1 = Po
%
% -->  Pe/Po = (Pe/Po2)(Po2/Po)
%                 A.1     A.3
%


% get M1 - mach # at shock inlet - throat sonic
mguess = 2;
mo = mguess;
func = 1.0;
while abs(func) > 1.0e-8,
  [presr,densr,tempr,arear] = isentrop(mo);
  dm = mo*1.0e-3;
  mr = mo+dm; 
  [presrr,densrr,temprr,arearr] = isentrop(mr);
  func = arear - A1_At;
  dfdm = ( arearr-arear )/(dm);
  delm = -func/dfdm;
  mo = mo + delm;
end
M1 = mo;

% now go through shock to get state 2 - Po2_Po1 = (Po2/Po1)
% need M2 and Po2_Po1
[presr2, densr2, tempr2, Po2_Po1 , po21, M2 ] = shock(M1);

% get A2/A2* (note A1 = A2 but A1* is not equal to A2*) A2_A2star = A2/A2*
[presrr,densrr,temprr,A2_A2star] = isentrop(M2);
% need A2_A2star

%Ae/A2* = Ae/Ae* = (Ae/A2)(A2/A2*) = (Ae/At)(At/A2)(A2/A2*)
% A2 = A1  --> A2/At = A1/At = A1_At
Ae_Astar = Ae_At/A1_At*A2_A2star;

% use Ae/Ae* to iterate to find Me  - guess subsonic
% also need Poe/Pe
mguess = .2;
mo = mguess;
func = 1.0;
while abs(func) > 1.0e-8,
  [presr,densr,tempr,arear] = isentrop(mo);
  dm = mo*1.0e-3;
  mr = mo+dm; 
  [Poe_Pe,densrr,temprr,arearr] = isentrop(mr);
  func = arear - Ae_Astar;
  dfdm = ( arearr-arear )/(dm);
  delm = -func/dfdm;
  mo = mo + delm;
end
Me = mo;
% Pe/Po = (Pe/Po2)(Po2/Po)
Pe_Po = (1/Poe_Pe)*Po2_Po1;
Pe = Pe_Po*Po;
end
