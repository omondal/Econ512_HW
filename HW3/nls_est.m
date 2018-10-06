function [a, b, c]=nls_est(init,y,X)
b_nls_init=init;
options3 = optimoptions('lsqnonlin','Display','final','TolFun',1e-16,'TolX',1e-16);
f=@(b)y-exp(X*b);
tic
[b_nls,res1,res2,exit]=lsqnonlin(f,b_nls_init,[],[],options3);
a=toc;
b=exit;
c=3;
end