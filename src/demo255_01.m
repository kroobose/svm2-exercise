1; clear; close all; 
rand('state',0); 

%
% Generate a data set. 
%
ntras  = 100; nfeas  = 3; 
X_tra  = [rand(nfeas-1,ntras)*2-1; ones(1,ntras) ]; 
X_tra  = round(X_tra*100)*0.01; 
w_orac = [-1.0,1.0,-0.1 ]'; 
w_orac = round(w_orac*100)*0.01; 
y_tra  = sign(X_tra'*w_orac); 
X_til  = mtimes_diag( X_tra, y_tra ); 

%
% Learn the SVM. 
%
lam = 1.0/ntras; 
[w_est,res] = train_hingesvm( X_til, lam ); 
alph_est = res.alph; 

%
% Plot the classification boundary. 
%
[gcf1,gca1] = tsfigure( [3,3] ); 
pbaspect([1,1,1]); 
xlim1 = [-1,+1]; ylim1 = [-1,+1]; 
xlim( xlim1 ); ylim( ylim1 ); 
plot_X_cts( X_tra, y_tra ); 
param.margin = 1; 
param.clr = [0, 0, 0]; 
plot_svm_boundary( w_est(1:end-1), w_est(end), xlim1, ylim1, param );  
filehint = sprintf('k.demo255_01.svbnd'); 
print_eps_and_png( filehint ); 



