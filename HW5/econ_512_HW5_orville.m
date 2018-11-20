%% Load Data
addpath('D:/PSU_Coursework/512_Empirical_Methods/Lectures/CETools'); %add Miranda-Fackler's toolkit.

data=load('D:\PSU_Coursework\512_Empirical_Methods\Econ512_HW\HW5\hw5.mat');%Load data
X=data.data.X';Y=data.data.Y';Z=data.data.Z';
clear data;
%% Question 1
[x,w]=qnwnorm(20,0.1,1);% Generate 20 nodes and weights from N(0.1,1).
nodes.nx=x;
nodes.ny=0;
%nodes=[x zeros(20,1)];
l1=likelihood(0,w,nodes,Y,X,Z);

%% Question 2
rng(100);
nodes2.nx=randn(100,1)+0.1;
nodes2.ny=0;
w2=1/length(nodes2.nx);
l2=likelihood(0,w2,nodes2,Y,X,Z);

%% Question 3-Gaussian Quadrature
func1=@(x) max_no_u_gaussian(x(1),x(2),x(3),Y,X,Z);
    x0=[1,1,1];
[arg, fval]=fminsearch(func1,x0);
%% Question 3-MC
func2=@(y)max_no_u_mc(y(1),y(2),y(3),Y,X,Z);
x1=[1,1,1];
exit=0;times=1;
while (exit~=1) && (times<10)
    tic
    [x1, fval2,exit]=fminsearch(func2,x1);
    times=times+1;
    toc
end

%% Question 4
func3=@(z)max_mc(z(1),z(2),z(3),z(4),z(5),Y,X,Z);
x2=[1,1,1,1,0.5];
[arg3,fval3,exit3]=fminsearch(func3,x2);
