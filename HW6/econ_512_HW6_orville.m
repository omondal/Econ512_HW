%% Question 2
%{
 Generate a discrete grid of prices, and transition probabilities,
 approximating the AR(1) process for price.
%}
[prob,grid]=tauchen(21,0.5,0.5,0.1); 
%% Question 3,4
%{
NOTE: Value function iteration is performed to yield a matrix of value
function values, where element (i,j) corresponds to the value when the
period stock of `lumber' is the i-th value, and the period price is the
j-th value. If there are S possible starting stocks, and P possible price
levels, the value function matrix is of dimension S\cross P

%}
delta=0.95; S=1000; P=repmat(grid,S,1); pi=prob; %Setting up discount factor, 
                                                 %number of state spaces for the resource,
                                                 %price matrix, transition
                                                 %probabilities.
stock=linspace(0,100,S); S1=repmat(stock',1,length(grid));%Actual state space, and a repeated matrix needed for later.
v_init=zeros(S,length(grid));d_init=ones(S,length(grid)); %Initialise value functions, decisions.
v_revised=ones(S,length(grid));d_revised=ones(S,length(grid));%Revised values, used in VFI.
diff=1;

while diff>0.001
    Ev=v_init*pi';
    for i=1:S
        U=u(P,stock(i)-S1);
        [v_revised(i,:),d_revised(i,:)]=max(U+delta*Ev);
    end
    diff=norm(v_revised-v_init)/norm(v_revised);
    disp(['Change in value function:',num2str(diff)]);
    v_init=v_revised;
end
%plot value function against stock of goods, for specified prices.
figure(1)
plot(stock,v_init(:,8),'r-',stock,v_init(:,11),'k-.',stock,v_init(:,14),'b--');
legend({'p=0.9','p=1','p=1.1'},'Location','northwest');
title('Value function cross-sections');
figure(2)
%plot next period optimal stock as a function of price for lumber=25,50,75
plot(grid,d_revised(250,:),'r-',grid,d_revised(500,:),'k-.',grid,d_revised(750,:),'b--');
legend({'stock=25','stock=50','stock=75'},'Location','northwest');
title('Optimal Next-period Stock');
%% Question 5
% Generate the time series for price
p_gen=[11,zeros(1,19)]; %vector of indices.
rng(100);
for i=1:19
    draw=mnrnd(1,prob(p_gen(i),:));
    p_gen(i+1)=find(draw==1);
end
d_gen=[d_revised(1000,11),zeros(1,19)];
for j=1:19
    d_gen(j+1)=d_revised(d_gen(j),p_gen(j+1));
end
%Plot the generated time series for stock
plot(1:1:20,d_gen);
%% Question 6
%{
Repeat the exercise when using only 5 points of price.
%}
[prob1,grid1]=tauchen(5,0.5,0.5,0.1);
delta=0.95; S=1000; P=repmat(grid1,S,1); pi2=prob1; %Setting up discount factor, 
                                                 %number of state spaces for the resource,
                                                 %price matrix, transition
                                                 %probabilities.
stock1=linspace(0,100,S); S1=repmat(stock1',1,length(grid1));%Actual state space, and a repeated matrix needed for later.
v_init2=zeros(S,length(grid1));d_init2=ones(S,length(grid1)); %Initialise value functions, decisions.
v_revised2=ones(S,length(grid1));d_revised2=ones(S,length(grid1));%Revised values, used in VFI.
diff2=1;

while diff2>0.001
    Ev=v_init2*pi2';
    for i=1:S
        U=u(P,stock(i)-S1);
        [v_revised2(i,:),d_revised2(i,:)]=max(U+delta*Ev);
    end
    diff2=norm(v_revised2-v_init2)/norm(v_revised2);
    disp(['Change in value function:',num2str(diff2)]);
    v_init2=v_revised2;
end
figure(3)
%plot value function against stock of goods, for specified prices.
plot(stock1,v_init2(:,2),'r-',stock1,v_init2(:,3),'k-.',stock1,v_init2(:,4),'b--');
legend({'p=0.9','p=1','p=1.1'},'Location','northwest');
title('Value function cross-sections');
figure(4)
%plot next period optimal stock as a function of price for lumber=25,50,75
plot(grid1,d_revised2(250,:),'r-',grid1,d_revised2(500,:),'k-.',grid1,d_revised2(750,:),'b--');
legend({'stock=25','stock=50','stock=75'},'Location','northwest');
title('Optimal Next-period Stock');
