function ret = get_hingeloss_ast(alph)
%
% Convex conjugate of hinge loss. 
%

l1 = alph >= -1; 
l2 = alph <= 0;
l3 = l1&l2; 
ret = l3.*alph + ~l3*1e+300; 




