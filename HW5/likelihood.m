%LIKELIHOOD computes the log likelihood function for specification given in
%HW5 for ECON 512, Fall 2018. 
%Inputs: 
%   gamma: Coefficient on Z.
%   weights: Weights for integrating over Beta_i, and u_i. Weights must be
%   a matrix.
%   nodes: Nodes for integrating over Beta_i, and u_i. Nodes must be a
%   structure with one vector component for each coordinate.
%   Y: Discrete choice variable arranged in N*T matrix, N=number of agents,
%      T=nuumber of time periods.
%   X,Z: Scalar regressor matrices of dimension N*T each.
% Outputs: 
%   L: The likelihood function.
function L=likelihood(gamma,weights,nodes,Y,X,Z)
s=size(Y); s1=s(1); s2=s(2); L1=zeros(s1,1); 
nx=nodes.nx; ny=nodes.ny; s3_1=length(nx); s3_2=length(ny);
parfor i=1:s1
    t1=ones(s3_1,s3_2,s2);
    for j=1:s2
        for k=1:s3_1
            for l=1:s3_2
                t1(k,l,j)=exp(Y(i,j)*(nx(k)*X(i,j)+gamma*Z(i,j)+ny(l)))/(1+exp(nx(k)*X(i,j)+gamma*Z(i,j)+ny(l)));
            end
        end
    end
    L1(i)=sum(sum(prod(t1,3).*weights));
end
L=sum(log(L1));
end