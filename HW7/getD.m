function [d0,d1,d2]=getD(p,p_star,v)
d0=1./(1+exp(v-p)+exp(v-p_star')); 
d1=exp(v-p)./(1+exp(v-p)+exp(v-p_star'));
d2=exp(v-p_star')./(1+exp(v-p)+exp(v-p_star'));
end