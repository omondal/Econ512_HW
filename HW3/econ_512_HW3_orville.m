%%Load the data
W=load('hw3','-mat'); X=W.X; y=W.y;
clear W;
%% Question 1
b_mle=(1:1:size(X,2))';
l=@(b)-likelihood(y,X,b);
options=optimset('Display','final');
exit=2;maxit=0;
while (exit~=1)&&(maxit<100)
    [b_mle,fval,exit]=fminsearch(l,b_mle,options);
    maxit=maxit+1;
end
fprintf('Iterations: %d, Likelihood function value: %f \n', maxit,likelihood(y,X,b_mle));
b_mle
%% Question 2
