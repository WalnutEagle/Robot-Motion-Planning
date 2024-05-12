%function [UTheta]=twolink_potential_total(thetaEval,world,potential)
%Compute the potential $U$ pulled back through the kinematic map of the two-link
%manipulator, i.e., $U(  Wp_ eff(vec17E ))$, where $U$ is defined as in Question 
%q:total-potential, and $  Wp_ eff( )$ is the position of the end effector in the
%world frame as a function of the joint angles $vec17E = _1\\ _2$.
function [UTheta]=twolink_potential_total(thetaEval,world,potential)
%using functions from previous homework to make it easier
%Below this all is for report till the last comment
potential.repulsiveWeight = 0.1;
% Upto this all is for report and all other images
[vertexEffectorTransf,~,~] = twolink_kinematicMap(thetaEval);
Spheres = numel(world);
repulsivePotentials = zeros(1, Spheres);
for icell = 1:Spheres
    repulsivePotentials(icell)=potential_repulsiveSphere(vertexEffectorTransf,world(icell));
end
totalRepulsive=sum(repulsivePotentials);
UAttractive=potential_attractive(vertexEffectorTransf,potential);
UTheta=UAttractive+potential.repulsiveWeight*totalRepulsive;
%Trying this approach if the twolink_kinematicMap works it will be really
%good.Needed to add two_linkPolygon and rot2d but it worked.
end