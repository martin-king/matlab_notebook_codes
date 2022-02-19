% Sample solution m-file.
% Suggested solutions.
%--------------------------------
% Investigating the order of accuracy for some common 
% numerical schemes for ODES.
% Numerically solving the ODE
% du/dt=alpha*u

clear all;  % clearing variables from workspace
close all;  % closing figure windows
format long; % display all the decimal places

alpha=-4.;  % suggested alpha
finaltime=5.;  % suggested final time
dtvect=[];  % declaring two empty matrices to store dt's and errors  
errorvect=[];

% loop for different timestep sizes
for ndt=2:2:50
 u0=1.;  % initial condition
 u=u0;  % set first value of f to f0
 dt=0.02/ndt;  % timestep sizes
 itimelast=round(finaltime/dt);  % total number of timesteps required

 for itime=0:itimelast-1  % timestepping loop
  switch 2  % use switch to choose which case to run
   case 1  %Explicit Euler
%BEGIN: WRITE YOUR CODE HERE, time-marching in f 
    u=u+dt*(alpha*u);  
%END
   case 2  %Runge-Kutta 4-th Order
%BEGIN: WRITE YOUR CODE HERE, time-marching in f  
    k1=dt*(alpha*u);
    k2=dt*(alpha*(u+k1/2));
    k3=dt*(alpha*(u+k2/2));
    k4=dt*(alpha*(u+k3));
    u=u+1/6*(k1+2*k2+2*k3+k4);
%END  
  end  
  t=dt*(itime+1);  %advance to next time instant
  exact=exp(alpha*t)*u0;  %the exact solution to the ODE
  error=abs(u-exact);
 end  
  figure(1)
  loglog(dt,error,'.','MarkerSize',6)  %plotting errors against dt 
  hold on;
% store dt and final error to dt_vect and error_vect respectively
  dtvect=[dtvect; dt]; errorvect=[errorvect; error];
end
hold off;
 
p=polyfit(log10(dtvect),log10(errorvect),1);  %finding gradient of the points in figure 1
title(['calculated order of accuracy = ',num2str(p(1))]);  %print it out as title
xlabel('dt');
ylabel('abs. errors');
