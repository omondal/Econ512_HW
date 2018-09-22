function [fval, Jac]=cournot_hw2(p)
fval=[(1+exp(2-(1))+exp(2-p(2)))/(1+exp(2-p(2)))-p(1);(1+exp(2-(1))+exp(2-p(2)))/(1+exp(2-p(1)))-p(2)];
Jac=[(-exp(2-p(1)))/(1+exp(2-p(2)))-1 (exp(4-sum(p)))/(1+exp(2-p(2)))^2;...
      (exp(4-sum(p)))/(1+exp(2-p(1)))^2 (-exp(2-p(2)))/(1+exp(2-p(1)))-1];
end