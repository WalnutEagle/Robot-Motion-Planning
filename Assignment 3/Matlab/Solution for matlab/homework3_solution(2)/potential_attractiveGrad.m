%function [gradUAttr]=potential_attractiveGrad(xEval,potential)
%Evaluate the gradient of the attractive potential $ U_ attr$ at a point  xEval.
%The gradient is given by the formula If  potential.shape is equal to  'conic',
%use $p=1$. If  potential.shape is equal to  'quadratic', use $p=2$.
function [gradUAttr]=potential_attractiveGrad(xEval,potential)

%set the p value based on shape of the potential
if strcmp('conic',potential.shape) == 1
    pval = 1;
elseif strcmp('quadratic',potential.shape) == 1
    pval = 2;
else
    disp('That is not a valid shape')
    return
end

xGoal = potential.xGoal;
difference_vector = xEval-xGoal; % calculate the vector between the x and xgoal
mag_difference_vec = norm(xEval-xGoal); % magnitude of vector between x and x goal

gradUAttr = pval*mag_difference_vec^(pval-2)*difference_vector;