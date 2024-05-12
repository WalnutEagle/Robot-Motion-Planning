function twolink_animatePath(thetaPath, fps)
%function twolink_animatePath(thetaPath, fps)
%Draws each iteration of the twolink manipulator and superimposes
%them, at a certain frames per second.
load('twolink_testData','obstaclePoints')
plot(obstaclePoints(1,:),obstaclePoints(2,:),'r*')
hold on
for indexOfthetaPath = thetaPath
    twolink_plot(indexOfthetaPath,'k')
    pause(1/fps)
end
hold off
