function [a, b, c]=nls_nm_est(init,y,X)
b_nls_nm=init;
nls_f=@(b)sum((y-exp(X*b)).^2);
options4=optimset('Display','final','TolFun',1e-16,'TolX',1e-16);
exit2=2;maxit2=0;
tic
while (exit2~=1)&&(maxit2<100)
    [b_nls_nm,fval,exit2]=fminsearch(nls_f,b_nls_nm,options4);
    maxit2=maxit2+1;
end
a=toc;
b=exit2;
c=4;
end