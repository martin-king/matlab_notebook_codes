%example m-file.
%finite differencing method for the 1D heat equation.
%solving dT/dt=d^2T/dx^2.
%crank-nicolson with 2nd order central differencing in space.
%with theta scheme.
%see also explanatory note.
%theta=1: implicit. 
%theta=-1: explicit.
%theta=0: crank-nicolson.
%------------------------------------------
%

clear all, close all;

theta=0.;  %see above

%defining the spatial domain
xmin=0; xmax=2; dx=0.1; x=xmin:dx:xmax; nx=length(x);

%where C=dt/dx^2
C=5.0; dt=C*dx.^2;

Thot=5.0; Tcold=2.0;  %Dirichlet boundary values
%grid point indices for hot and cold ends:
hotend=find(x==xmin); coldend=find(x==xmax);

T=zeros(1,nx); T(hotend)=Thot; T(coldend)=Tcold; Tnew=T;  %initial T; and applying b.c. too
tlast=1.5;  %final time
ntsteps=ceil(tlast/dt);  %number of timesteps
dt=tlast/ntsteps;  %re-correct dt
C=dt./dx.^2;  %re-correct C

L=toeplitz([2+2*C*(1+theta) -C*(1+theta) zeros(1,nx-4)]);  %operator for LHS
R=toeplitz([2-2*C*(1-theta) C*(1-theta) zeros(1,nx-4)]);  %operator for RHS

for istep=1:ntsteps  %time stepping
    Tstore(istep,:)=T;  %storing T to Tstore
    TR=T(2:end-1);  %setting rhs vector; only the internal points
    TR=R*TR';  %applying the RHS operator 
    TR(1)=TR(1)+C*(1+theta)*T(1);  %add the b.c.'s for the implicit (LHS) terms 
    TR(end)=TR(end)+C*(1+theta)*T(end);
    TR(1)=TR(1)+C*(1-theta)*T(1);  %add the b.c.'s for the explicit (RHS) terms
    TR(end)=TR(end)+C*(1-theta)*T(end);  
    
    T(2:end-1)=L\TR;  %implicit euler's    
end
Tstore(ntsteps+1,:)=T;  %T at tlast

%for plotting
t=[0:dt:tlast];
[xx,tt]=meshgrid(x,t);
contourf(xx,tt,Tstore),colorbar;
xlabel('x'),ylabel('t');
title('T')