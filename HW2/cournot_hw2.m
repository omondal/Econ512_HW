function [fval, Jac]=cournot_hw2(p,v)
%Given a two dimensional price vector, and valuation vector, this returns the FOC with prices
%subtracted, as fval. This is the appropriate system to solve for an
%equilibrium. Jac is the Jacobian
fval=[(1+exp(v(1)-p(1))+exp(v(2)-p(2)))/(1+exp(v(2)-p(2)))-p(1);(1+exp(v(1)-p(1))+exp(v(2)-p(2)))/(1+exp(v(1)-p(1)))-p(2)];
Jac=[(-exp(v(1)-p(1)))/(1+exp(v(2)-p(2)))-1 (exp(sum(v)-sum(p)))/(1+exp(v(2)-p(2)))^2;...
      (exp(sum(v)-sum(p)))/(1+exp(v(1)-p(1)))^2 (-exp(v(2)-p(2)))/(1+exp(v(1)-p(1)))-1];
end