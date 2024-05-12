%function twolink_plot(theta,color)
%This function should use twolink_kinematicMap from the previous question
%together with the function polygon_draw from Homework 1 to draw the manipulator.
function twolink_plot(theta,color,varargin)
flagPlotVelocities=false;
flagHold=ishold();

%optional parameters
ivarargin=1;
while ivarargin<=length(varargin)
    switch lower(varargin{ivarargin})
        case 'thetadot'
            flagPlotVelocities=true;
            ivarargin=ivarargin+1;
            thetaDot=varargin{ivarargin};
        otherwise
            error(['Argument ' varargin{ivarargin} ' not valid!'])
    end
    ivarargin=ivarargin+1;
end

for iTheta=1:size(theta,2)
    %get transformed vertices
    [vertexEffectorTransf,vertices1Transf,vertices2Transf]=twolink_kinematicMap(theta(:,iTheta));
    %remember if we are in figure hold or not
    flagHold=ishold();
    polygon_plot(vertices1Transf,color);
    hold on
    polygon_plot(vertices2Transf,color);
    hold on
    plot(vertexEffectorTransf(1),vertexEffectorTransf(2),'ko')
    if flagPlotVelocities
        plotAngularVelocity(vertices1Transf,thetaDot(1,iTheta))
        plotAngularVelocity(vertices2Transf,thetaDot(2,iTheta))
        endEffectorDot=twolink_jacobian(theta(:,iTheta),thetaDot(:,iTheta));
        quiver(vertexEffectorTransf(1),vertexEffectorTransf(2),...
            endEffectorDot(1),endEffectorDot(2),...
            'AutoScale','off')
    end
end
%restore figure hold (off) if necessary
if ~flagHold
    hold off
end

function plotAngularVelocity(verticesTransf,thetaDot)
nbVerticesHalfOffset=size(verticesTransf,2)/2-1;
gravCenter=mean(verticesTransf,2);
velCenter=verticesTransf*[...
    zeros(nbVerticesHalfOffset,1);-1;...
    1;zeros(nbVerticesHalfOffset,1)...
    ]*thetaDot;
velCenter=velCenter/norm(velCenter)*thetaDot;
quiver(gravCenter(1),gravCenter(2),velCenter(1),velCenter(2),'k',...
    'AutoScale','off')
