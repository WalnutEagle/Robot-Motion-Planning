
function polygon_isCollision_testMakeData()

testPointXX=(-1:0.5:6)+0.17;
testPointYY=(-1.5:0.5:1.5)+0.3;
[testPointX,testPointY]=meshgrid(testPointXX,testPointYY);
testPoints=reshape(permute(cat(3,testPointX,testPointY),[3 1 2]),2,[]);
%testPoints=[2.75;0.8];

[vertices1,vertices2]=twolink_polygons();%call the function twolink_polygons to get the vertices information of two polygons.
vertices1(:,end)=[];

%call the function VisibilityPlot to draw the lines as the homework assignment requires
VisibilityPlot(vertices1,testPoints,'polygon1_full');
VisibilityPlot(fliplr(vertices1),testPoints,'polygon1_hollow');
VisibilityPlot(vertices2,testPoints,'polygon2_full');
VisibilityPlot(fliplr(vertices2),testPoints,'polygon2_hollow');

function VisibilityPlot(vertices,testPoints,fileName)
polygon_plot(vertices,'y');%plot the given polygon
hold on;
flagPoints=polygon_isCollision(vertices,testPoints);
plotPoints(testPoints(:,~flagPoints),'g*')
plotPoints(testPoints(:,flagPoints),'r*')
hold off;

save(fullfile('~/BU/Teaching/ME570/Homework/autograders/homework1/testData/collision',fileName),'vertices','testPoints','flagPoints')

%The function should display four separate figures in total, each one with a
%single polygon and lines from each vertex in the polygon, to each point.
