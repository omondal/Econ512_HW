%% Question 1
D_A=exp(1)/(1+2*exp(1));
fprintf('Demand assuming Price is 1: %f\n', D_A);
%% Question 2
p=[1,4];
% Initial values of function and Jacobian
[fval, iJacTemp]=cournot_hw2(p);
iJac=inv(iJacTemp);
% Broyden Iterations
maxit=1000;
tol=1e-10;
tic
for i=1:maxit
    fnorm = norm(fval);
    fprintf('i %d: P(A) = %f, P(B) = %f, norm(f(x)) = %.8f\n', i, p(1), p(2), norm(fval));
    if norm(fval) < tol
        break
    end
   d=-(iJac*fval);
   p=p+d;
   fOld=fval;
   fval=cournot_hw2(p);
   u=iJac*(fval-fOld);
   iJac=iJac+((d-u)*(d'*iJac))/(d'*u);
end
toc
%% Question 3
%% Question 4
%Initial value of Prices
p3=[5,1];
%The demand at a price.
D=@(p)[(exp(2-p(1)))/(1+exp(2-p(1))+exp(2-p(2))),(exp(2-p(2)))/(1+exp(2-p(1))+exp(2-p(2)))];
for k=1:maxit
    fnorm=norm(cournot_hw2(p3));
    fprintf('k %d: P(A) = %f, P(B) = %f, norm(f(x)) = %.8f\n', k, p3(1), p3(2), fnorm);
    if fnorm < tol
        break
    end
    p3Old=p3;
    p3New=(ones(2,1)-D(p3)).^(-1);
    p3=p3New;
end

