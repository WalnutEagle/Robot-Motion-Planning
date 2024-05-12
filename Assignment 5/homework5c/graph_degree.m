%Returns an array with the degree deg(n) of each vertex n in the graph graphVector.
function deg=graph_degree(graphVector)
deg=arrayfun(@(x) length(x.neighbors),graphVector);