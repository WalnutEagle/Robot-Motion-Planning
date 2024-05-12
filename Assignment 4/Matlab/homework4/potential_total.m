%function [UEval]=potential_total(xEval,world,potential)
%Compute the function $U=U_attr+aU_rep,i$, where $a$ is given by the
%variable  potential.repulsiveWeight
function [UEval]=potential_total(xEval,world,potential)
worldCell = num2cell(world);
uattr = potential_attractive(xEval,potential);
ureplu_i = sum(cellfun(@(s) potential_repulsiveSphere(xEval, s), worldCell));
UEval = uattr+ potential.repulsiveWeight*ureplu_i;

end