addpath('D:/PSU_Coursework/512_Empirical_Methods/Lectures/CETools'); %add Miranda-Fackler's toolkit.
%% Question 1
[x,w]=qnwequi(50000,[0,0],[1,1],'N'); %generate equidistributed points.
test1=x(:,1).^2+x(:,2).^2<=1; %How many of generated points qualify?
pi_qmc=4*w'*test1; %Quasi-MC estimate of pi.

%% Question 2
fun=@(x,y)(double(x.^2+y.^2<=1));
[x1,wx1]=newt_coat_weights(25000,0,1); %Generate quadrature points and weights, assuming approximation by quadratic function 
f_val=zeros(25000,25000);
%Evaluate a 2-d matrix of function evaluations at all points of quadrature.
for i=1:length(x1)
    f_val(i,:)=fun(repmat(x1(i),1,length(x1)),x1');
end

pi_nc=4*wx1'*f_val*wx1; %Newton-Coates estimate of pi.

%% Question 3
[x3,w3]=qnwequi(50000,0,1,'N'); %generate equidistributed points.
pi_qmc2=4*w3'*(1-x3.^2).^0.5; %Quasi-MC estimate, using the iterated logartihm.

%% Question 4
[x4,wx4]=newt_coat_weights(25000,0,1); %Generate quadrature points and weights, assuming approximation by quadratic function
f_val2=(1-x4.^2).^0.5;%Function values at points of quadrature
pi_nc2=4*wx4'*f_val2;% Newton-Coates estimate of Pi, using the iterated integral.

%% Question 5
sim_study=zeros(6,2);
fun=@(x,y)(double(x.^2+y.^2<=1));
t=[100,1000,10000];
for k=1:length(t)
    [a,b]=newt_coat_weights(t(k),0,1);
    f_val1=zeros(length(a),length(a));
    %Evaluate a 2-d matrix of function evaluations at all points of quadrature.
    for i=1:length(a)
    f_val1(i,:)=fun(repmat(a(i),1,length(a)),a');
    end
    sim_study(3,k)=4*b'*f_val1*b;%Newton-Coates estimate of Indicator function integral
end
clear a b f_val1 k
for l=1:length(t)
    [c,d]=newt_coat_weights(t(l),0,1); %Generate quadrature points and weights, assuming approximation by quadratic function
    f_val3=(1-c.^2).^0.5;%Function values at points of quadrature
    sim_study(4,l)=4*d'*f_val3;% Newton-Coates estimate of Pi, using the iterated integral.
end
clear c d f_val3 l
for m=1:length(t)
    [e,f]=qnwequi(t(m),[0,0],[1,1],'N'); %generate equidistributed points.
    test1=e(:,1).^2+e(:,2).^2<=1; %How many of generated points qualify?
    sim_study(1,m)=4*f'*test1; %Quasi-MC estimate of pi.

end
clear e f test1 m

for n=1:length(t)
    [g,h]=qnwequi(t(n),0,1,'N'); %generate equidistributed points.
    sim_study(2,n)=4*h'*(1-g.^2).^0.5; %Quasi-MC estimate, using the iterated logartihm.
end
clear g h n

%Generate Pseudo Random numbers, One sequence for each dimension.
seed=12345;
rng(seed); pmc1=zeros(200,length(t)); pmc2=zeros(200,length(t));
%Pseudo MC integration using the above random numbers
for r=1:200
    for p=1:length(t)
        tic;
        r1=rand(t(p),1);
        r2=rand(t(p),1);
        f_val4=zeros(t(p),1);
        for s=1:t(p)
            f_val4(s)=mean(fun(repmat(r1(s),t(p),1),r2));
        end
        pmc1(r,p)=4*mean(f_val4);
        clear f_val4
        pmc2(r,p)=4*mean((1-r1.^(2)).^0.5);
    end
    time=toc;
    fprintf('Iteration: %d Time: %f\n', r,time);
end
final=(sim_study-pi).^2;
pmc1_error=pmc1-pi; pmc2_error=pmc2-pi;
for x=1:length(t)
    final(5,x)=mean(pmc1_error(:,x).^2);
    final(6,x)=mean(pmc2_error(:,x).^2);
end

csvwrite('simulations_output.csv',final);