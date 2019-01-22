function u=u(p,x)
% The period return function, with a penalty of -infinity if a negative
% amount is consumed. 
x1=x.*(x>=0);
out=p.*x1-0.2*x1.^(1.5);
%check=isreal(out);
%u=out.*check;
u=out-100*(x<0);
end