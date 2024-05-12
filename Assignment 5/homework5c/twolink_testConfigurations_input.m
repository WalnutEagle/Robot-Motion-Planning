function twolink_testConfigurations_input()
close all
fileName='twolink_testConfigurations_sphereworld';
load('sphereworld.mat','world')

thetaTest=[];
subplot(1,2,1)
axis([0 2*pi 0 2*pi])
title('Click on the left of the axes to exit')
x=Inf;
while true
    subplot(1,2,1)
    [x,y,button]=ginput(1);
    if x<0
        break
    end
    disp([x y button])
    switch button
        case 1
            thetaTest=[thetaTest [x;y]];
        case 3
            thetaTest(:,end)=[];
    end
    subplot(1,2,2)
    sphereworld_plot(world,zeros(2,0))
    hold on
    twolink_plot(thetaTest,'g')
    hold off
    pause(0.1)
end
disp(thetaTest)
disp(['Saving to ' fileName])
save(fileName,'thetaTest')
