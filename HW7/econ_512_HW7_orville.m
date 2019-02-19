%  looks like you did not converge to the equilibrium. I think you just
%  needed to let it run longer and code more efficiently. check the answer
%  key.
clear;
tic;
setparams;
V0=(repmat(v,L,L)+repmat(c',L,1))./(2*beta);
%V0=zeros(L,L);
P0=1.5*repmat(c',L,1);
[val,p,iter]=vfi(V0,P0,CRIT,L,c,lambda,beta,v,trans_prob);

figure(1);
mesh(val); title('Value Function');
xlabel('Firm 1 Knowledge');
ylabel('Firm 2 Knowledge');
zlabel('Value Function');
figure(2);
mesh(p); title('Price Policy');
xlabel('Firm 1 Knowledge');
ylabel('Firm 2 Knowledge');
zlabel('Value Function');
fprintf('Time taken:%f seconds',toc);
csvwrite('value.csv',val);
csvwrite('policy.csv',p);

%% Part (b)
%Construct a 900*900 matrix of transition probabilities for states. 
[D_0,D_1,D_2]=getD(p,p,v);
T=zeros(L^2,L^2);
for k=1:30
    if k==1
        for i=1:30
            if i==1
                T((k-1)*30+i,(k-1)*30+i)=D_0(k,i)...
                    +D_1(k,i)*(1-(1-delta)^(k+1))+D_2(k,i)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-1)*30+i+1)=D_2(k,i)*(1-delta)^(i+1);
                T((k-1)*30+i,(k)*30+i)=D_1(k,i)*((1-delta)^(k+1));
            elseif i<30
                T((k-1)*30+i,(k-1)*30+i)=D_0(k,i)*((1-delta)^i)...
                    +D_1(k,i)*(1-(1-delta)^(k+1))*((1-delta)^i)+D_2(k,i)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-1)*30+i+1)=D_2(k,i)*(1-delta)^(i+1);
                T((k-1)*30+i,(k)*30+i)=D_1(k,i)*((1-delta)^(k+1))*(1-delta)^i;
                T((k-1)*30+i,(k-1)*30+i-1)=D_0(k,i)*(1-(1-delta)^i)+D_1(k,i)*(1-(1-delta)^(k+1))*(1-(1-delta)^i);
                T((k-1)*30+i,(k)*30+i-1)=D_1(k,i)*((1-delta)^(k+1))*(1-(1-delta)^i);
            elseif i==30
                T((k-1)*30+i,(k-1)*30+i)=D_0(k,i)*((1-delta)^i)...
                    +D_1(k,i)*(1-(1-delta)^(k+1))*((1-delta)^i)+D_2(k,i);
                T((k-1)*30+i,(k-1)*30+i-1)=D_0(k,i)*(1-(1-delta)^i)+D_1(k,i)*(1-(1-delta)^(k+1))*(1-(1-delta)^i);
                T((k-1)*30+i,(k)*30+i)=D_1(k,i)*((1-delta)^(k+1))*(1-delta)^i;
                T((k-1)*30+i,(k)*30+i-1)=D_1(k,i)*((1-delta)^(k+1))*(1-(1-delta)^i);
            end
        end
    elseif k<30
        for i=1:30
            if i==1
                T((k-1)*30+i,(k-1)*30+i)=D_0(k,i)*((1-delta)^k)...
                +D_1(k,i)*(1-(1-delta)^(k+1))+D_2(k,i)*((1-delta)^k)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-1)*30+i+1)=D_2(k,i)*((1-delta)^k)*(1-delta)^(i+1);
                T((k-1)*30+i,(k)*30+i)=D_1(k,i)*((1-delta)^(k+1));
                T((k-1)*30+i,(k-2)*30+i)=D_0(k,i)*(1-(1-delta)^k)+D_2(k,i)*(1-(1-delta)^k)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-2)*30+i+1)=D_2(k,i)*(1-(1-delta)^k)*((1-delta)^(i+1));

            elseif i<30
                T((k-1)*30+i,(k-1)*30+i)=D_0(k,i)*((1-delta)^k)*((1-delta)^i)...
                    +D_1(k,i)*(1-(1-delta)^(k+1))*((1-delta)^i)+D_2(k,i)*((1-delta)^k)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-1)*30+i+1)=D_2(k,i)*((1-delta)^k)*(1-delta)^(i+1);
                T((k-1)*30+i,(k)*30+i)=D_1(k,i)*((1-delta)^(k+1))*(1-delta)^i;
                T((k-1)*30+i,(k)*30+i-1)=D_1(k,i)*((1-delta)^(k+1))*(1-(1-delta)^i);
                T((k-1)*30+i,(k-1)*30+i-1)=D_0(k,i)*((1-delta)^k)*(1-(1-delta)^i)+D_1(k,i)*(1-(1-delta)^(k+1))*(1-(1-delta)^i);
                T((k-1)*30+i,(k-2)*30+i)=D_0(k,i)*(1-(1-delta)^k)*((1-delta)^i)+D_2(k,i)*(1-(1-delta)^k)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-2)*30+i-1)=D_0(k,i)*(1-(1-delta)^k)*(1-(1-delta)^i);
                T((k-1)*30+i,(k-2)*30+i+1)=D_2(k,i)*(1-(1-delta)^k)*((1-delta)^(i+1));

            elseif i==30
                T((k-1)*30+i,(k-1)*30+i)=D_0(k,i)*((1-delta)^k)*((1-delta)^i)...
                    +D_1(k,i)*(1-(1-delta)^(k+1))*((1-delta)^i)+D_2(k,i)*((1-delta)^k);
                T((k-1)*30+i,(k)*30+i)=D_1(k,i)*((1-delta)^(k+1))*(1-delta)^i;
                T((k-1)*30+i,(k)*30+i-1)=D_1(k,i)*((1-delta)^(k+1))*(1-(1-delta)^i);
                T((k-1)*30+i,(k-1)*30+i-1)=D_0(k,i)*((1-delta)^k)*(1-(1-delta)^i)+D_1(k,i)*(1-(1-delta)^(k+1))*(1-(1-delta)^i);
                T((k-1)*30+i,(k-2)*30+i)=D_0(k,i)*(1-(1-delta)^k)*((1-delta)^i)+D_2(k,i)*(1-(1-delta)^k);
                T((k-1)*30+i,(k-2)*30+i-1)=D_0(k,i)*(1-(1-delta)^k)*(1-(1-delta)^i);
            end
        end
    elseif k==30
        for i=1:30
           if i==1
                T((k-1)*30+i,(k-1)*30+i)=D_0(k,i)*((1-delta)^k)...
                +D_1(k,i)+D_2(k,i)*((1-delta)^k)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-1)*30+i+1)=D_2(k,i)*((1-delta)^k)*(1-delta)^(i+1);
                T((k-1)*30+i,(k-2)*30+i)=D_0(k,i)*(1-(1-delta)^k)+D_2(k,i)*(1-(1-delta)^k)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-2)*30+i+1)=D_2(k,i)*(1-(1-delta)^k)*((1-delta)^(i+1));

            elseif i<30
                T((k-1)*30+i,(k-1)*30+i)=D_0(k,i)*((1-delta)^k)*((1-delta)^i)...
                    +D_1(k,i)*((1-delta)^i)+D_2(k,i)*((1-delta)^k)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-1)*30+i+1)=D_2(k,i)*((1-delta)^k)*(1-delta)^(i+1);
                T((k-1)*30+i,(k-1)*30+i-1)=D_0(k,i)*((1-delta)^k)*(1-(1-delta)^i)+D_1(k,i)*(1-(1-delta)^i);
                T((k-1)*30+i,(k-2)*30+i)=D_0(k,i)*(1-(1-delta)^k)*((1-delta)^i)+D_2(k,i)*(1-(1-delta)^k)*(1-(1-delta)^(i+1));
                T((k-1)*30+i,(k-2)*30+i-1)=D_0(k,i)*(1-(1-delta)^k)*(1-(1-delta)^i);
                T((k-1)*30+i,(k-2)*30+i+1)=D_2(k,i)*(1-(1-delta)^k)*((1-delta)^(i+1));
            elseif i==30
                T((k-1)*30+i,(k-1)*30+i)=D_0(k,i)*((1-delta)^k)*((1-delta)^i)...
                    +D_1(k,i)*((1-delta)^i)+D_2(k,i)*((1-delta)^k);
                T((k-1)*30+i,(k-1)*30+i-1)=D_0(k,i)*((1-delta)^k)*(1-(1-delta)^i)+D_1(k,i)*(1-(1-delta)^i);
                T((k-1)*30+i,(k-2)*30+i)=D_0(k,i)*(1-(1-delta)^k)*((1-delta)^i)+D_2(k,i)*(1-(1-delta)^k);
                T((k-1)*30+i,(k-2)*30+i-1)=D_0(k,i)*(1-(1-delta)^k)*(1-(1-delta)^i);
            end
        end
    end
end
t1=sum(T,2);
init=[1,zeros(1,899)];
%After 10 periods:
figure(3);
A1=reshape((init*(T^10))',30,30);
mesh(A1);
xlabel('Firm 1 Knowledge'); ylabel('Firm 2 Knowledge'); zlabel('Density');
title('Distribution after 10 periods');
%After 20 periods:
figure(4);
A2=reshape((init*(T^20))',30,30);
mesh(A2);
xlabel('Firm 1 Knowledge'); ylabel('Firm 2 Knowledge'); zlabel('Density');
title('Distribution after 20 periods');

%After 30 periods:
figure(5);
A3=reshape((init*(T^30))',30,30);
mesh(A3);
xlabel('Firm 1 Knowledge'); ylabel('Firm 2 Knowledge'); zlabel('Density');
title('Distribution after 30 periods');
%Steady State
figure(6);
A4=reshape((init*(T^1000))',30,30);
mesh(A4);
xlabel('Firm 1 Knowledge'); ylabel('Firm 2 Knowledge'); zlabel('Density');
title('Steady State Distribution');
