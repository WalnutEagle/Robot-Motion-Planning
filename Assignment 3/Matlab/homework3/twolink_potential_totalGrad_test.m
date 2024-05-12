function twolink_potential_totalGrad_test
load('potential_init_autoTestData','potential','world')
[theta,thetaDot]=real_randGeodFun(randn(2,1));


f=@(t) twolink_potential_total(theta(t),world,potential);
df=@(t) thetaDot(t)'*twolink_potential_totalGrad(theta(t),world,potential);

funCheckDer(f,df)
