%function [pQueue,key,cost]=priority_minExtract(pQueue)
%Extract the element with minimum cost from the queue.
function [pQueue,key,cost]=priority_minExtract(pQueue)
elemNum=numel(pQueue);%get number of records

if elemNum==0%if the given queue is empty, return an empty queue.
    key=[];%set key as empty.
    cost=[];%set cost as empty.
    return;
end

[~,idxMin]=min([pQueue.cost]);
idxMin=idxMin(1);
key=pQueue(idxMin).key;
cost=pQueue(idxMin).cost;
pQueue(idxMin)=[];
if isempty(pQueue)
    pQueue=priority_prepare();
end
