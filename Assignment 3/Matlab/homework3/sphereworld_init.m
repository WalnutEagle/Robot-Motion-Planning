function sphereworld_init
scale=5;
world(1)=struct('xCenter',[0;0],'radius',-2);
world(2)=struct('xCenter',[0.75;0],'radius',0.6);
world(3)=struct('xCenter',[0;-1],'radius',0.3);
world(4)=struct('xCenter',[-0.75;0.75],'radius',0.5);
for iSphere=1:4
    world(iSphere).distInfluence=0.2;
end

xGoal=[1.45, 1.65; 0, 0];
xStart=[   -1.5,   -0.9,   1.2,    0.3,    -0.3;
            0.3,   -1.3,  -1.1,    1.5,    -0.1];

%scale original world
for iSphere=1:4
    for field=fields(world)'
        world(iSphere).(field{1})=scale*world(iSphere).(field{1});
    end
end
xGoal=scale*xGoal;
xStart=scale*xStart;
         
sphereworld_plot(world,xGoal)
hold on
plotPoints(xStart,'bx')
hold off

save('sphereworld.mat','world','xGoal','xStart')

