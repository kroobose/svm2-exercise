function ret = get_hingeloss(z)
%
% non-smooth hinge loss
%

ret = max(1-z,0); 
