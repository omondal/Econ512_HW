function p1=broyden_cournot(v)
% Just a copy of the code for question 2 in the assignment.
p=[1;4];
% Initial values of function and Jacobian
[fval, iJacTemp]=cournot_hw2(p,v);
iJac=inv(iJacTemp);
% Broyden Iterations
maxit=10000;
tol=1e-10;
for i=1:maxit
    if norm(fval) < tol
        fprintf('i: %d P(A) = %f, P(B) = %f, norm(f(x)) = %.8f\n', i, p(1), p(2), norm(fval));
        break
    end
   d=-(iJac*fval);
   p=p+d;
   fOld=fval;
   fval=cournot_hw2(p,v);
   u=iJac*(fval-fOld);
   iJac=iJac+((d-u)*(d'*iJac))/(d'*u);
end
p1=p;
end