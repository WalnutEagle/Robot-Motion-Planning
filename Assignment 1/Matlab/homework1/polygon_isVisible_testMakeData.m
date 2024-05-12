%function polygon_isVisible_test()
%This function should perform the following operations: enumerate  an array 
%testPoints with dimensions [ 2 $ $  5] containing points generated uniformly at
%random using rand and scaled to approximately occupy the rectangle $[0,5]
%[-2,2]$ (i.e., the $x$ coordinates of the points should fall between $0$ and
%$5$, while the $y$ coordinates between $-2$ and $2$).  the coordinates 
%vertices1 and  vertices2 of two polygons from twolink_polygons.  two  logical
%vectors  flag1 and  flag2 by calling polygon_isVisible using  testPoints and,
%respectively,  vertices1 and  vertices2 as argument. item:test-polygon For each
%polygon  vertices1,  vertices2, display a separate figure using the following:
%enumerate  the array  testPointsWithPolygon by concatenating  testPoints with
%the coordinates of the polygon (i.e., the coordinates of the polygon become also
%test points).  the polygon (use polygon_plot). item:test-visibility For each
%vertex $v$ in the polygon: enumerate  the visibility of each point in 
%testPointsWithPolygon with respect to that polygon (using polygon_isVisible). 
%lines from the vertex $v$ to each point in  testPointsPolygon according in green
%if the corresponding point is visible, and in red otherwise. enumerate enumerate
% the order of the vertices in  vertices1,  vertices2 using the function fliplr. 
%item item:test-polygon above with the reversed edges. enumerate
function polygon_isVisible_testMakeData()

testPoints=[3 0; 3.8 0; 6.3 0; -2 -2]';
[vertices1,vertices2]=twolink_polygons();%call the function twolink_polygons to get the vertices information of two polygons.
vertices1(:,end)=[];

%call the function VisibilityPlot to draw the lines as the homework assignment requires
VisibilityPlot(vertices1,testPoints,'polygon1_full');
VisibilityPlot(fliplr(vertices1),testPoints,'polygon1_hollow');
VisibilityPlot(vertices2,testPoints,'polygon2_full');
VisibilityPlot(fliplr(vertices2),testPoints,'polygon2_hollow');

function VisibilityPlot(vertices,testPoints,fileName)

testPointsWithPolygon=[testPoints];%concatenate testPoints with polygon vertices.
vertexNum=size(vertices,2);%get the number of vertices.
flagNum=size(testPointsWithPolygon,2);%get the column number of flagPoints.

polygon_plot(vertices,'y');%plot the given polygon
hold on;
allFlagPoints=false(vertexNum,flagNum);

%this loop aims at traversing each vertex of the given polygon, and judging
%their visibility to the testPointsWithPolygon.
for indexVertex=1:vertexNum
    
    [flagPoints]=polygon_isVisible(vertices,indexVertex,testPoints);%judge the visibility of the specified vertex to the testPointsWithPolygon.
    allFlagPoints(indexVertex,:)=flagPoints;
    %traverse the flagPoints, if visible, draw a green line, or draw a red
    %line otherwise.
    for indexTP=1:flagNum
        
        if flagPoints(indexTP)%visible.
            
            plot([testPointsWithPolygon(1,indexTP),vertices(1,indexVertex)],[testPointsWithPolygon(2,indexTP),vertices(2,indexVertex)],'g');
            
        else%not visible.
            
            plot([testPointsWithPolygon(1,indexTP),vertices(1,indexVertex)],[testPointsWithPolygon(2,indexTP),vertices(2,indexVertex)],'r');
            
        end
        
    end
    
    hold on;
end

plotPoints(testPoints,'*')
hold off;

save(fullfile('~/BU/Teaching/ME570/Homework/autograders/homework1/testData/visibility',fileName),'vertices','testPoints','allFlagPoints')

%The function should display four separate figures in total, each one with a
%single polygon and lines from each vertex in the polygon, to each point.
