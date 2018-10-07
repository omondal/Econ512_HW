%%Load the data
W=load('hw3','-mat'); X=W.X; y=W.y;
clear W;
%% Question 1
b_mle=[3;0;0;0;0;0];
l=@(b)-likelihood(y,X,b);
options=optimset('Display','final','TolFun',1e-8,'TolX',1e-8);
exit=2;maxit=0;
tic
while (exit~=1)&&(maxit<100)
    [b_mle,fval,exit]=fminsearch(l,b_mle,options);
    maxit=maxit+1;
end
t1=toc
fprintf('Iterations: %d,Likelihood function value: %f \n', maxit,likelihood(y,X,b_mle));
b_mle
%% Question 2 (Quasi-Newton)
b_mle_init=[3;0;0;0;0;0];
options2=optimset('Display','final');
l_z=@(b)likelihood2(y,X,b);
b_mle_qn=fminunc(l_z,b_mle_init,options2);
fprintf('Norm of Likelihood function value: %f \n', likelihood2(y,X,b_mle_qn));
b_mle_qn
%% Question 3
b_nls_init=[3;0;0;0;0;0];
options3 = optimoptions('lsqnonlin','Display','final','TolFun',1e-16,'TolX',1e-16);
f=@(b)y-exp(X*b);
b_nls=lsqnonlin(f,b_nls_init,[],[],options3);
fprintf('Objective Function: %f \n',sum(f(b_nls).^2));
b_nls
%% Question 4
b_nls_nm=[3;0;0;0;0;0];
nls_f=@(b)sum((y-exp(X*b)).^2);
options4=optimset('Display','final','TolFun',1e-16,'TolX',1e-16);
exit2=2;maxit2=0;
while (exit2~=1)&&(maxit2<100)
    [b_nls_nm,fval,exit2]=fminsearch(nls_f,b_nls_nm,options4);
    maxit2=maxit2+1;
end
fprintf('Iterations: %d, Objective Function: %f \n', maxit2,nls_f(b_nls_nm));
b_nls_nm
%% Question 5
% Define a range over which to perturb initial values. I will store the
% time taken to converge, for any method, for all values in a particular
% range of initial values.
range=linspace(2,4);
tests=zeros(length(range)*4,4);
for k=1:length(range)
    b_init=[range(k);0;0;0;0;0];
    [x1,x2,x3]=mle_est(b_init,y,X);
    [x4,x5,x6]=mle_qn_est(b_init,y,X);
    [x7,x8,x9]=nls_est(b_init,y,X);
    [x10,x11,x12]=nls_nm_est(b_init,y,X);
    tests((k-1)*4+1,1)=range(k);
    tests((k-1)*4+1,2)=x1;
    tests((k-1)*4+1,3)=x2;
    tests((k-1)*4+1,4)=x3;
    tests((k-1)*4+2,1)=range(k);
    tests((k-1)*4+2,2)=x4;
    tests((k-1)*4+2,3)=x5;
    tests((k-1)*4+2,4)=x6;
    tests((k-1)*4+3,1)=range(k);
    tests((k-1)*4+3,2)=x7;
    tests((k-1)*4+3,3)=x8;
    tests((k-1)*4+3,4)=x9;
    tests((k-1)*4+4,1)=range(k);
    tests((k-1)*4+4,2)=x10;
    tests((k-1)*4+4,3)=x11;
    tests((k-1)*4+4,4)=x12;
end
%csvwrite('robustness.csv',tests);
%% Comparisons for question 5
l1=find(tests(:,4)==1);l2=find(tests(:,4)==2);l3=find(tests(:,4)==3);l4=find(tests(:,4)==4);
mle_tests=tests(l1,:);mleqn_tests=tests(l2,:);nls_tests=tests(l3,:);nlsnm_tests=tests(l4,:);
plot(range,mle_tests(:,2),range,mleqn_tests(:,2),range,nls_tests(:,2),range,nlsnm_tests(:,2));
xlabel('Initial value');ylabel('Time'); legend('MLE','MLE QN','NLS','NLS NM');
