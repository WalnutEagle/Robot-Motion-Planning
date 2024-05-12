%function priority_test()
%Test the priority_* functions by inserting three elements in a priority queue
%with different costs, checking for the presence of two specific elements, and
%then displaying the result of four extractions. See Table 
%tab:priority-test-inputs for details on the inputs and expected outputs.
function priority_testMakeData()
pQueue=priority_prepare();
pQueue=priority_insert(pQueue,'Oranges',4.5);
pQueue=priority_insert(pQueue,'Apples',1);
pQueue=priority_insert(pQueue,'Bananas',2);
pQueue=priority_insert(pQueue,'Onions',0);
pQueue=priority_minExtract(pQueue); %Extract 'Onions'
pQueueMonoKey=pQueue;
pQueue=priority_insert(pQueue,[9,0,3,1],1000);
pQueueFull=pQueue;
pQueue=pQueueMonoKey;
disp('Check for the key ''Oranges''')
disp(priority_isMember(pQueue,'Oranges'))
disp('Check for the key [1,5]')
disp(priority_isMember(pQueue,[1,5]))
disp('Results for 3 extractions')
key=cell(1,3);
cost=cell(1,3);
for iExtraction=1:3
    [pQueue,key{iExtraction},cost{iExtraction}]=priority_minExtract(pQueue);
end
display(key)
display(cost)

disp('Results for 4 extractions')
pQueue=pQueueFull;
keyFull=cell(1,4);
costFull=cell(1,4);
for iExtraction=1:4
    [pQueue,keyFull{iExtraction},costFull{iExtraction}]=priority_minExtract(pQueue);
end
display(keyFull)
display(costFull)

pQueueEmpty=priority_prepare();
pQueueSingle=priority_insert(pQueueEmpty,'key',0);

save(fullfile('/Users/tron/BU/Teaching/ME570-MotionPlanning/Homework/autograders/homework1/testData','priority'),...
    'pQueueMonoKey','pQueueFull','pQueueEmpty','pQueueSingle',...
    'key','cost','keyFull','costFull')
