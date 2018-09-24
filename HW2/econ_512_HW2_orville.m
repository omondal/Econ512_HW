%% Question 1
D_A=exp(1)/(1+2*exp(1));
fprintf('Demand assuming Price is 1: %f\n', D_A);
%% Question 2
p=[1;4];v=[2;2];
% Initial values of function and Jacobian
[fval, iJacTemp]=cournot_hw2(p,v);
iJac=inv(iJacTemp);
% Broyden Iterations
maxit=10000;
tol=1e-10;
tic
for i=1:maxit
    fnorm = norm(fval);
    if norm(fval) < tol
        fprintf('i %d: P(A) = %f, P(B) = %f, norm(f(x)) = %.8f\n', i, p(1), p(2), norm(fval));
        break
    end
   d=-(iJac*fval);
   p=p+d;
   fOld=fval;
   fval=cournot_hw2(p,v);
   u=iJac*(fval-fOld);
   iJac=iJac+((d-u)*(d'*iJac))/(d'*u);
end
toc
%% Question 3
%Initil values
p2=[1;4];
p2Old=[5,5];
fOld=cournot_hw2(p2Old,v);
tic
for j=1:maxit
    fval=cournot_hw2(p2,v);
    if norm(fval)<tol
        fprintf('j: %d, P(A): %f, P(B): %f, norm(f(p)): %f\n',j,p2(1),p2(2),norm(fval));
        break
    else
%       d_n=cournot_hw2(p2);
%       d_ol=cournot_hw2(p2Old);
        p2_A=p2(1)-(p2(1)-p2Old(1))*fval(1)/(fval(1)-fOld(1));
        d_gaussSidel=cournot_hw2([p2_A;p2(2)],v);
        p2_B=p2(2)-(p2(2)-p2Old(2))*d_gaussSidel(2)/(fval(2)-fOld(2));
        p2Old=p2;
        fOld=fval;
        p2=[p2_A;p2_B];
    end
end
toc
%% Question 4
%Initial value of Prices
p3=[1;1]; p3Old=5*p3;
%The demand at a price.
D=@(p)[(exp(2-p(1)))/(1+exp(2-p(1))+exp(2-p(2)));(exp(2-p(2)))/(1+exp(2-p(1))+exp(2-p(2)))];
tic
for k=1:maxit
    fnorm=norm(cournot_hw2(p3,v));
    pnorm=norm(p3-p3Old);
    if pnorm<tol
        fprintf('k %d: P(A) = %f, P(B) = %f, norm(f(x)) = %.8f\n', k, p3(1), p3(2), fnorm);
        break
    end
    p3Old=p3;
    p3New=(ones(2,1)-D(p3)).^(-1);
    p3=p3New;
end
toc
%% Question 5
% I'm going to use Broyden to solve this.
v2=0:0.2:3;
v1=repmat(2,1,length(v2));
v=[v1;v2];
p_out=ones(2,length(v2));
for l=1:length(v2)
    p_out(:,l)=broyden_cournot(v(:,l));
end
%plot
plot(v(2,:),p_out(1,:),v(2,:),p_out(2,:));
xlabel('Valuation of good B'); ylabel('Equilibrium Prices');
