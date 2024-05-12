%function [uOpt,deltaOpt]=qp_minEffort(AAttr,bAttr,ABarrier,bBarrier,m)
%Solves the optimization problem 
%   min_u 0.5*||u-u_ref||^2
%   subject to
%       AAttr*u+bAttr<=0

function [uOpt]=qp_supervisor(ABarrier,bBarrier,uRef)
cvx_begin quiet
    variables u(2,1)
    uDiff=u-uRef;
    %Matlab version: minimize(uDiff'*uDiff)
    minimize pow_pos(norm(uDiff,2),2)
    subject to
    ABarrier*u+bBarrier<=0
cvx_end
uOpt=u;
