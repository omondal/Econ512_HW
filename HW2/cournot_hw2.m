function [fval, Jac]=cournot_hw2(p)
%Given a two dimensional price vector, this returns the FOC with prices
%subtracted, as fval. This is the appropriate system to solve for an
%equilibrium. Jac is the Jacobian for this system.
fval=[(1+exp(2-(1))+exp(2-p(2)))/(1+exp(2-p(2)))-p(1);(1+exp(2-(1))+exp(2-p(2)))/(1+exp(2-p(1)))-p(2)];
Jac=[(-exp(2-p(1)))/(1+exp(2-p(2)))-1 (exp(4-sum(p)))/(1+exp(2-p(2)))^2;...
      (exp(4-sum(p)))/(1+exp(2-p(1)))^2 (-exp(2-p(2)))/(1+exp(2-p(1)))-1];
end