function [w_est,res] ...
    = train_hingesvm( X_tra, lam, param )
% 
% 
% 
nfeas = size(X_tra,1); 
ntras = size(X_tra,2); 
tsassert( size(X_tra) == [nfeas,ntras] ); 
tsassert( isscalar(lam) ); 

if nargin <= 2, 
  param.default = 1;
end

niters = 1000; 
if isfield( param, 'niters' )
  niters = param.niters; 
end

thres_gap = 1e-3; 
if isfield( param, 'thres_gap' )
  thres_gap = param.thres_gap; 
end

mode_stochas = 2; 
if isfield( param, 'mode_stochas' )
  mode_stochas = param.mode_stochas; 
end

mode_rec = 0; 
if isfield( param, 'mode_rec' )
  mode_rec = param.mode_rec; 
end

ntras = size(X_tra,2); 
pownorms_xk = zeros(ntras,1); 
for i_con=1:ntras
  xk = X_tra(:,i_con); 
  pownorms_xk(i_con) = norm(xk).^2; 
end

alph_init = zeros(ntras,1); 
if isfield( param, 'alph_init' ),
  alph_init = param.alph_init; 
end
tsassert( size(alph_init) == [ntras,1] ); 

verbose = 0; 
if isfield( param, 'verbose' )
  verbose = param.verbose; 
end

lossfun     = @(z) get_hingeloss(z); 
lossfun_ast = @(alph) get_hingeloss_ast(alph); 
if norm(alph_init) > 0,
  alph  = alph_init; 
  w_new = (X_tra*alph)/(lam*ntras); 
else
  alph  = zeros(ntras,1); 
  w_new = zeros(nfeas,1); 
end
objs_primal = []; 
objs_dual   = []; 
lamn  = lam*ntras; 
ilamn = 1./lamn; 

gmat = zeros(ntras,niters); 
fmat = zeros(ntras,niters); 

iter = 0; finished = 0; 
while ~finished, 
  iter = iter + 1; 

  if mode_stochas == 0,
    r_con = 1:ntras; 
  elseif mode_stochas == 1,
  r_con = randperm(ntras); 
  elseif mode_stochas == 2,
  r_con = floor(rand(1,ntras)*ntras)+1; 
  end

  for i_k=1:numel(r_con); 
    k = r_con(i_k); 

    if mode_rec > 0 || i_k == 1,
      
      nfeas = size(X_tra,1); 
      ntras = size(X_tra,2); 
      w_recon = (X_tra*alph)/(lam*ntras); 
      tsassert( norm(w_recon-w_new) < 1e-10*nfeas*ntras ); 
      %% [tmp1,w_recon] = get_signreg2_d(v_recon,l_sgn);
      zs    = X_tra'*w_recon; 
      term1_p = 0.5*lam*norm(w_recon).^2; 
      term2_p = sum(lossfun(zs))/ntras; 
      obj_p = term1_p + term2_p; 

      term1_d = -term1_p; 
      term2_d = -sum(lossfun_ast(-alph))/ntras; 
      obj_d = term1_d + term2_d; 

      fmat( i_k, iter ) = obj_p; gmat( i_k, iter ) = obj_d; 
      if verbose > 0, 
        fprintf('(%d,%d)a: f=%g, g=%g, i_k=%d\n', ...
                iter, i_k, obj_p, obj_d, i_k ); 
      end
      if i_k >= 2, 
        tsassert( gmat(i_k,iter)-gmat(i_k-1,iter) >= -1e-6 ); 
      end

    else
      % fprintf('.'); 
    end

    w_old     = w_new; 
    xk        = X_tra(:,k); 
    alphk_old = alph(k); 
    pnxk      = pownorms_xk(k); 
    nume1     = 1 - dot(w_old,xk); 
    deno1     = pnxk*ilamn; 
    delalphk  = max(0,min(1,nume1./deno1 + alphk_old))-alphk_old; 
    alphk_new = alphk_old + delalphk; 
    tsassert( alphk_new >= -1e-8 );  
    tsassert( alphk_new <= 1+1e-8 );  
    alph(k)   = alphk_new; 
    w_new     = w_old + (delalphk*ilamn)*xk; 
    
  end
  
  if iter >= 2 && abs(fmat(1,iter)- gmat(1,iter))<1e-5,
    finished = 1; 
  end
  if iter == niters,
    finished = 1; 
  end

end

if verbose > 0,fprintf('\n'); end
w_est = w_new; 
res.fmat = fmat; 
res.gmat = gmat; 
res.alph = alph; 
res.iter = iter; 



