function torus_phi_test()
nbPoints=200;
thetaRing=linspace(0,15/8*pi,nbPoints);
ring1=torus_phi([thetaRing;zeros(1,nbPoints)]);
ring2=torus_phi(flipud([thetaRing;zeros(1,nbPoints)]));

plot3(ring1(1,:),ring1(2,:),ring1(3,:),'.-b')
hold on
plot3(ring2(1,:),ring2(2,:),ring2(3,:),'.-r')
hold off
axis equal
%\x08

