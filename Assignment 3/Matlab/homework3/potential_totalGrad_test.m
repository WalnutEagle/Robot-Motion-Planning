function potential_totalGrad_test()
resetRands()
load('potential_init_autoTestData','potential','world')
[xt,vt]=real_randGeodFun(randn(2,1),'speed',4);


f=@(t) potential_total(xt(t),world,potential);
df=@(t) vt(t)'*potential_totalGrad(xt(t),world,potential);

funCheckDer(f,df)
