%function priority_test()
%Test the priority_* functions by inserting three elements in a priority queue
%with different costs, checking for the presence of two specific elements, and
%then displaying the result of four extractions. See Table 
%tab:priority-test-inputs for details on the inputs and expected outputs.
function priority_test()
pQueue=priority_prepare();
pQueue=priority_insert(pQueue,'Oranges',4.5);
pQueue=priority_insert(pQueue,'Apples',1);
pQueue=priority_insert(pQueue,'Bananas',2);
pQueue=priority_insert(pQueue,[9,0,3,1],1000);

disp('Content of the queue after 3 insertions')
disp(pQueue)
disp('Check for the key ''Oranges''')
disp(priority_isMember(pQueue,'Oranges'))
disp('Check for the key [1,5]')
disp(priority_isMember(pQueue,[1,5]))
disp('Results for 4 extractions')
for iExtraction=1:4
    [pQueue,key,cost]=priority_minExtract(pQueue);
    display(key)
    display(cost)
end


