function [Z,H]=mle_z(y,X,b)
% Returns the first order conditions for MLE assuming a Poisson process.
% 'y' is a vector of the dependent variable, X is a design matrix, 'b' is
% the coefficient.
s=size(X);
t1=y-exp(X*b);
t2=kron(t1,ones(1,s(2)));
z1=t2.*X;
Z=sum(z1,1)'/s(1);
E=kron(exp(X*b),ones(1,s(2)));
E2=E.*X;
H=(E2'*X)/s(1);
end