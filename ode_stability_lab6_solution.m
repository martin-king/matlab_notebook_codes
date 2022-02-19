% Sample solution m-file.
% Suggested solutions to guide tutors.
%--------------------------------
% Investigating the stability  for RK4 
% numerical schemes for ODES.
% Numerically solving the ODE
% du/dt=alpha*u
% Just run it and see the results.

clear all;  % clearing variables from workspace
close all;  % close all figure windows
format long; % display all the decimal places

alpha=-4.;  % suggested alpha

for itests=1:4  %testing stability with 4 different final times
finaltime=itests*5.;  % suggested final time

dtvect=[];  % declaring two empty matrices to store dt's and errors  
errorvect=[];

for ndt=1:20  % loop for different timestep sizes
 u0=1.;  % initial condition
 u=u0;  % set first value of f to f0
 dt=2/ndt;  % timestep sizes
 itimelast=round(finaltime/dt);  % total number of timesteps required

 for itime=0:itimelast-1  % timestepping loop
  switch 1  % use switch to choose which case to run
   case 1  %Explicit Euler
    u=u+dt*(alpha*u);     
  end  
  t=dt*(itime+1);  %advance to next time instant
  exact=exp(alpha*t)*u0;  %the exact solution to the ODE
  error=abs(u-exact);
 end  
  subplot(4,1,itests)  %plotting
  loglog(dt,error,'.','MarkerSize',6)  %plotting errors against dt 
  xlabel('dt');
  ylabel('abs. errors');
  title(strcat('final time= ',num2str(finaltime)))
  axis([2/20 2 10^-40 10^10])
  hold on;
% store dt and final error to dt_vect and error_vect respectively
  dtvect=[dtvect; dt]; errorvect=[errorvect; error];
end
hold off;
 
end