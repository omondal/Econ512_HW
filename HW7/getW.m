function [w0,w1,w2]=getW(V,trans_prob)
%getW: Returns the expected continuation payoffs, given a Value funcion
%      guess, V.
%INPUTS: V: A guess of a value function. Dimension L*L where L is the
%           number of states of knowledge.
%OUTPUTS: w0: Expected continuation values next period, conditional on
%             neither firm selling the product.
%         w1: The same as above, but conditional on firm 1 selling a
%             product.
%         w2: The same as above, but conditional on firm 2 selling a
%             product.
s=size(trans_prob,1); t_prob=trans_prob;
trans_prob_0=t_prob(1:s-1,:); 
trans_prob_1=t_prob(2:s,:);

w0=trans_prob_0*V*trans_prob_0';
w1=trans_prob_1*V*trans_prob_0';
w2=trans_prob_0*V*trans_prob_1';

end