%example m-file.
%finite differencing method for the 1D heat equation.
%explict euler's.
%solving dT/dt=d^2T/dx^2.
%compare this with heat1D_fdm_explicitb.m. 
%see what happens if C is changed to 0.505.
%martin king, 30 Aug 2008.

clear all, close all;

%defining the spatial domain
xmin=0; xmax=2; dx=0.1; x=xmin:dx:xmax; nx=length(x);

%where C=dt/dx^2
C=0.49; dt=C*dx.^2;

Thot=5.0; Tcold=5.0;  %boundary values
%grid point indices for hot and cold ends:
hotend=find(x==xmin); coldend=find(x==xmax);

T=zeros(1,nx); T(hotend)=Thot; T(coldend)=Tcold; Tnew=T;  %initial T; and applying b.c. too
tlast=1.5;  %final time
ntsteps=ceil(tlast/dt);  %number of timesteps
dt=tlast/ntsteps;  %re-correct dt
C=dt./dx.^2;  %re-correct C

for istep=1:ntsteps  %time stepping
    Tstore(istep,:)=T;  %storing T to Tstore
    for ix=2:nx-1  %updating in x
      Tnew(ix)=T(ix)+C*(T(ix-1)-2.*T(ix)+T(ix+1));  %timestepping in explicit euler's      
    end
%begin: the following two lines will do the same job as the for loop above 
%    Tnew=T+dt*4.*del2(T,dx);
%    Tnew(hotend)=Thot; Tnew(coldend)=Tcold;
%end
    T=Tnew;  %updating T   
end
Tstore(ntsteps+1,:)=T;  %T at tlast

%for plotting
t=[0:dt:tlast];
[xx,tt]=meshgrid(x,t);
contourf(xx,tt,Tstore),colorbar;
xlabel('x'),ylabel('t');
title('T')