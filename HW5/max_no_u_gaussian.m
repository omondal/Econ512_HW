function L=max_no_u_gaussian(gamma,beta,sigma,Y,X,Z)
optset('qnwnorm','usesqrtm',1);
[x,w]=qnwnorm(100,beta,sigma);% Generate 20 nodes and weights from N(beta,sigma).
nodes.nx=x;
nodes.ny=0;
L=-likelihood(gamma,w,nodes,Y,X,Z);
end

