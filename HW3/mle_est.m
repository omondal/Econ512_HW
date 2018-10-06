function [a, b, c]=mle_est(init,y,X)
b_mle=init;
l=@(b)-likelihood(y,X,b);
options=optimset('Display','final','TolFun',1e-8,'TolX',1e-8);
exit=2;maxit=0;
tic
while (exit~=1)&&(maxit<100)
    [b_mle,fval,exit]=fminsearch(l,b_mle,options);
    maxit=maxit+1;
end
a=toc;
b=exit;
c=1;
end