function sonic = sound_speed(T,option)

R = 287;

if option == 1
% for calorically perfect gas
   cpo = 1003.5;
   cvo = cpo - R;
   gamm = cpo/cvo;
 
elseif option == 2

end

sonic = sqrt(gamm*R*T);