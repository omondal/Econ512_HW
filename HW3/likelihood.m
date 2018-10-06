function L=likelihood(y,x,b)
%Returns the likelhood function, given a matrix of covariates 'x', and a vector of the dependent variable 'y', assuming a Poisson regression is being
%estimated. 'b' is the coefficient.
L1=-exp(x*b)+y.*x*b;
L=sum(L1);
end