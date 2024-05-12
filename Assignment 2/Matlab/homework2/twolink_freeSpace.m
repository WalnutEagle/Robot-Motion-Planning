function twolink_freeSpace()
NGrid=100;
load('twolink_testData.mat');
fHandle=@(theta) ~any(logical(twolink_isCollision(theta,obstaclePoints)));
xGrid=linspace(0,2*pi,NGrid);
grid=struct('xx',xGrid,'yy',xGrid);
grid=grid_eval(grid,fHandle,'showProgress');
imagesc(grid.F')
save([mfilename '_data'],'grid')

%\x08

