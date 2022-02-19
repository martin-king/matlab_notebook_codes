% martin king, 24 aug 09.
% the two ODEs we need to solve.
% dT/dx=z
% dz/dx=h(T-Ta)
% x=[0,10]
% subject to T(0)=300K, T(10)=400K, Ta=200K, h=0.05 
% the ODEs are from originally
% d^2T/dx^2+h(Ta-T)=0

%creating some initial solutions from x=0 to x=10,
%all T=1 and all z=1
solinit=bvpinit(linspace(0,10,100),[1 1]);

%solving it
%see functions twoode and twobc as well
sol=bvp4c(@twoode_heat,@twobc_heat,solinit);

%creating x axis
x=linspace(0,10,100);

%obtain the solutions c(1)=T; and c(2)=z
c=deval(sol,x);

%this part is just to reset some properties so we are 
%with good fonts and lines
set(0,'defaultaxesfontsize',20,'defaultaxeslinewidth',.7,...
    'defaultlinelinewidth',.8,'defaultpatchlinewidth',.7)

%plot the solutions ie. T ie c(1)
figure(1),clf
plot(x,c(1,:))
xlabel('x'); ylabel('temperature');