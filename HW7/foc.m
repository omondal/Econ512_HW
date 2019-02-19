function f=foc(V,p,p_star,L,c,beta,v,trans_prob)
c1=repmat(c',L,1);
[d0,d1,d2]=getD(p,p_star,v);
[w0, w1,w2]=getW(V,trans_prob);
foc=1-(1-d1).*(p-c1)-beta*w1+beta*(d0.*w0+d1.*w1+d2.*w2);
f=foc;
end