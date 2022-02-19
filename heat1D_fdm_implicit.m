%example m-file.
%finite differencing method for the 1D heat equation.
%implicit euler's (lines 29 to 35).
%solving dT/dt=d^2T/dx^2.
%see what happens if C is changed to 0.505. compare to heat1D_fdm_explicitb.m. 
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

%here's something you might not have seen before.
%creating the differential operator matrix D
%see lecture note on what D is.
D=toeplitz([(1+2.*C) -C zeros(1,nx-4)]);  

for istep=1:ntsteps  %time stepping
    Tstore(istep,:)=T;  %storing T to Tstore
    T(2)=T(2)+C*T(1); T(end-1)=T(end-1)+C*T(end);  %applying the b.c.'s
    T(2:end-1)=D\T(2:end-1)';  %implicit euler's, because D*Tnew=T, where D and T are known, and Tnew unknown.
end
Tstore(ntsteps+1,:)=T;  %T at tlast

%for plotting
t=[0:dt:tlast];
[xx,tt]=meshgrid(x,t);
contourf(xx,tt,Tstore),colorbar;
xlabel('x'),ylabel('t');
title('T')