function [v,p,iter]=vfi(V,P,CRIT,L,c,lambda,beta,v,trans_prob)

vold=V; pold=P;init=P; options=optimset('Display','None');
vnew=zeros(size(V)); pnew=zeros(size(P));
tol=1;i=1;
while and(tol>CRIT,i<200)
    f=@(p)foc(vold,p,pold,L,c,beta,v,trans_prob);
    pnew=fsolve(f,init,options);
%    pnew=price_update(vold,pold,L,c,beta,v,trans_prob);
    [d0, d1, d2]=getD(pnew,pold,v);
    [w0,w1,w2]=getW(vold,trans_prob);
    vnew=d1.*(pnew-repmat(c',L,1))+beta*(d0.*w0+d1.*w1+d2.*w2);
    tol=max(max(max(abs((vnew-vold)./(1+vnew)))),max(max(abs((pnew-pold)./(1+pnew)))));
    vold=lambda*vnew+(1-lambda)*vold; pold=lambda*pnew+(1-lambda)*pold;
    fprintf('Iteration:%d\n',i);
    fprintf('Tolerance:%f\n',tol);
    i=i+1;
end
v=vold; p=pold;iter=i;
end