function L=max_mc(gamma,mu,s_u,s_b,s_ub,Y,X,Z)
sigma=[s_b s_ub;s_ub s_u];
U=chol(sigma)';
x=randn(1,100);
y=randn(1,100);
mc_points=U*[x;y]+repmat([mu;0],1,100);
nodes3.nx=mc_points(1,:);nodes3.ny=mc_points(2,:);
w3=1/10000;
L=-likelihood(gamma,w3,nodes3,Y,X,Z);
end
