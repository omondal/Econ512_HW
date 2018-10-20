function [x,w]=newt_coat_weights(n,a,b)
%Return an n*1 vector of weights for Newton_coates Integration, along with
%n*1 vector of quadrature points. Only works for interval of reals.
%INPUTS: n-Number of points/weights.
%        a-Start of interval, b-End of interval
w=zeros(n,1); x=zeros(n,1);
for i=1:n
    if or(i==1,i==n)
        w(i)=1/(3*n);
    elseif mod(i,2)==0
            w(i)=4/(3*n);
    elseif mod(i,2)~=0
        w(i)=2/(3*n);
    end
end
for j=1:n
    if j==1
        x(j)=a;
    else
        x(j)=x(j-1)+((b-a)/n);
    end
end
end