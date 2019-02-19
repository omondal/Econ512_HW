clear;
global L l c delta beta kappa v rho CRIT lambda;
L = 30; %Number of states.
l=15; %Point at which learning ceases.
c = zeros(L,1); %Initialise the cost by learning vector.
delta = 0.03;%Depreciation parameter.
beta = 1/1.05;%Discount Factor.
kappa=10;%Cost function parameter.
v=10;%Quality of product.
rho=0.85;%Cost paramter.
CRIT = 1e-4; 
lambda = 1; %.75; %For Dampening
c(1:l)=kappa*[1:1:l]'.^(log(rho)/log(2)); %Fill in the cost function, by firm learning state.
c(l+1:end)=kappa*(l^(log(rho)/log(2)));
trans_prob=zeros(L+1,L); %Initialise the transition of state, conditional on sale matrix.
for i=1:L+1
    if i==1
        trans_prob(i,1)=1;
    elseif i==L+1
        trans_prob(i,L)=1;
    else
        trans_prob(i,i-1)=1-(1-delta)^(i);
        trans_prob(i,i)=(1-delta)^(i);
    end
end