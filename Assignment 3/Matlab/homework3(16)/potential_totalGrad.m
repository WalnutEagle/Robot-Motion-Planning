%function [gradU]=potential_totalGrad(xEval,world,potential)
%Compute the gradient of the total potential, $ U= U_ attr+  @ @ _i U_ rep,i$,
%where $ $ is given by the variable  @x   potential.repulsiveWeight
function [gradU]=potential_totalGrad(xEval,world,potential)
% same for total grad add the grad of attractive and repulsive
gradU = potential_attractiveGrad(xEval,potential);
worldCell = num2cell(world);
gradUreplu = cellfun(@(s) potential_repulsiveSphereGrad(xEval, s), worldCell, 'UniformOutput', false);
gradUreplu = cat(2,gradUreplu{:});
gradUreplu = sum(gradUreplu,2);
gradU = gradU + potential.repulsiveWeight*gradUreplu;
end
%Need to fix the partial accepting case