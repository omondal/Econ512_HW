function [L, J]=likelihood2(y,X,b)
%Same as likelihood function, except it returns the norm of the likelihood,
%along with its Jacobian.
s=size(X);
t1=y-exp(X*b);
t2=kron(t1,ones(1,s(2)));
z1=t2.*X;
L1=-exp(X*b)+y.*X*b;
L=norm(sum(L1));
J=sum(z1,1)'/(2*L);
end