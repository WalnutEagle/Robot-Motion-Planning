function grid_eval_test()
nbX=41;
nbY=31;
grid=struct('xx',linspace(-1,1,nbX),'yy',linspace(-1,1,nbY));
mu=[0.5;0];
fun=@(x) sqrt((x-mu)'*diag([2,1])*(x-mu));
grid=grid_eval(grid,fun);
%Check the definition of grid in PDF for these asserts
assert(nbX==size(grid.F,1))
assert(nbY==size(grid.F,2))
[XX,YY]=meshgrid(grid.xx,grid.yy);
surf(XX,YY,grid.F')
%\x08

