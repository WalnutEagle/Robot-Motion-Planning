%function [gradUTheta]=twolink_potential_totalGrad(thetaEval,world,potential)
%Compute the gradient of the potential $U$ pulled back through the kinematic map
%of the two-link manipulator, i.e., $ _vec17E  U(  Wp_ eff(vec17E ))$.
function [gradUTheta]=twolink_potential_totalGrad(thetaEval,world,potential)
%Using function from previous assignment for simplicity
joint_theta = twolink_jacobianMatrix(thetaEval);
%Below this all is for report till the last comment
potential.repulsiveWeight = 0.1;
% Upto this all is for report and all other images
[vertexEffectorTransf,~,~] = twolink_kinematicMap(thetaEval);
spheres = numel(world);
rep_gradients = cell(1, spheres);
for icell = 1:spheres
    rep_gradients{icell} = potential_repulsiveSphereGrad(vertexEffectorTransf,world(icell));
end
totalRepulsiveGrad = sum(cat(3,rep_gradients{:}),3);
UAttractive_grad = potential_attractiveGrad(vertexEffectorTransf, potential);
gradUTheta = UAttractive_grad + potential.repulsiveWeight * totalRepulsiveGrad;
gradUTheta = transpose(joint_theta) * gradUTheta;
end