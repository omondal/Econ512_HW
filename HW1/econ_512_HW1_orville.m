%% Question 1
X=[1 1.5 3 4 5 7 9 10]';
Y1=-2+0.5*X; Y2=-2+0.5*(X.^2);
plot(X,Y1,'r-',X,Y2,'b--');
legend('Y1','Y2','Location','northwest'); xlabel('X');
%% Question 2
vector=linspace(-10,20,200)';
q2=sum(vector);
%% Question 3
A=[2 4 6;1 7 5;3 12 4]; b=[-2;3;10];
C=A'*b; D=inv(A'*A)*b; E=b'*sum(A,2);F=A(1,:);
q3=A\b;
%% Question 4
B=blkdiag(A,A,A,A,A);
%% Question 5
A=normrnd(10,5,5,3);
B=(A>=10);
%% Question 6
M=csvread('F:\PSU Coursework\512 Empirical Methods\Homework-master\Homeworks\hw1\datahw1.csv');
Y=M(:,5); X=[ones(size(M,1),1) M(:,3) M(:,4) M(:,6)];
n=size(M,1);
S1=(X'*X); S2=X'*Y;
b_hat=S1\S2;
% Naive standard errors
e_hat=Y-X*b_hat; 
e_bar=repmat(e_hat,1,4);
X1=X.*e_bar;
V=X1'*X1; D=X'*X;
var=inv(D)*V*inv(D);
%{
%Somewhat less naive
omega=zeros(4,4);
for k=1:4:n-3
    e_i=e_hat(k:k+3);
    omega=omega+(e_i*(e_i'))/(n/4);
end
Q=zeros(4,4); W=zeros(4,4);
for k=1:4:n-3
    x_i=X(k:k+3,:);
    Q=Q+(x_i'*x_i)/(n/4);
    W=W+(x_i'*omega*x_i)/(n/4);
end
var=inv(Q)*W*inv(Q);
% Trying out the estimator from Hansen, Journal of Econometrics, 2007
w_hat=zeros(4,4);
for j=1:4:n-3
    temp1=X(j:j+3,:)'*e_hat(j:j+3);
    w_hat=w_hat+(temp1'*temp1)/n;
end
var=inv(Q)*w_hat*inv(Q);
%}
