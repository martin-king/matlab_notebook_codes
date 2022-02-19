% martin king, 31 aug 2009.
% this is using the shooting method
% the two ODEs we need to solve.
% du/dy=z
% dz/dy=-Dp/muL
% y=[0,0.0025]
% subject to du/dy(y=0)=z(y=0)=0., u(0.0025)=0, 
% Dp=2.8e5, mu=0.492, L=4.88; H=0.0025 
% the ODEs are from originally
% d^2(mu u)/dy^2+Dp/L=0


%solving it
%see functions twoode and res as well, 5 is an initial guess for u(0)
%[fzero(@res,5) 0] are u(0) and z(0). But u(0) has to be found first using
%fzero.
[y,u]=ode45(@twoode,[0, 0.0025],[fzero(@res,5) 0]); 

%this part is just to reset some properties so we are 
%with good fonts and lines
set(0,'defaultaxesfontsize',20,'defaultaxeslinewidth',.7,...
    'defaultlinelinewidth',.8,'defaultpatchlinewidth',.7)

%plot the solutions ie. T ie c(1)
figure(1),clf
plot(y,u(:,1))
xlabel('y'); ylabel('u velocity');
