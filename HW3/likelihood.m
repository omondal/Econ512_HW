function [L J]=likelihood(y,x,b)
%Returns the likelhood function, given a matrix of covariates 'x', and a vector of the dependent variable 'y', assuming a Poisson regression is being
%estimated. 'b' is the coefficient.
s=size(x);
t1=y-exp(x*b);
t2=kron(t1,ones(1,s(2)));
z1=t2.*x;
J=sum(z1,1)'/s(1);
L1=-exp(x*b)+y.*x*b;
L=sum(L1)/s(1);
end