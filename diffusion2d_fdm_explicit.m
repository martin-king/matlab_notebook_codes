% sample solution m-file.
% sample solution m-file.
% by martin king, 4 Sept 2008
%------------------------------
% solves 2D Diffusion Equation by Explicit Euler timestepping.
% du/dt=a(u_xx+u_yy) in domain [0,2]x[0,2]
% bc's: one side u=6, 3 sides u=0. 
% ic: u=0.

clear all; close all;
format long;

a=1.; %the coefficient of diffusion

xmin=0.; xmax=2.0; ymin=0.; ymax=2.0;  % defining domain
dx=0.1; dy=0.1;  % grid spacing; this code will only work for dx=dy
x=[xmin:dx:xmax]; y=[ymin:dy:ymax];  % defining mesh
[X,Y]=meshgrid(x,y);  %X,Y are only used for plotting later
[nx,ny]=size(X);  % setting number of grid points

%where C=dt/dx^2, dt is timestep size
C=0.1; dt=C*dx.^2;

Thot=6.0; Tcold=0.;  % boundary values
wallhot=find(X==xmin);  % grid point indices for hot wall
wallcold=find(X==xmax|Y==ymin|Y==ymax);  % grid point indices for cold wall

u=zeros(nx,ny);  %declaring u
u(wallcold)=Tcold;u(wallhot)=Thot;  %boundary conditions

tlast=5.;  %final time
ntsteps=ceil(tlast/dt);  %number of timesteps
dt=tlast/ntsteps;  %re-correct dt
C=dt./dx.^2;  %re-correct C

xmid=ceil(nx/2);ymid=ceil(ny/2);

for istep=1:ntsteps  %time stepping
     rhstemp=a*dt*4*del2(u,dx,dy);  %forming the rhs by taking DEL^2 of known matrix u.
     rhs=rhstemp(2:end-1,2:end-1);  %the internal points in rhstemp nicely forms L[u]
     rhs=rhs+u(2:end-1,2:end-1);  %add the most current u to complete making rhs for the internal points
     utemp=rhs;  %internal points at next timestep are now just rhs
     u(2:end-1,2:end-1)=utemp;  %update internal points
%     if u(xmid,ymid)>=1.
%         break;
%     end
%{
% 'animation'
    if(mod(istep,2)==0.)
        figure(2)
        utemp=reshape(utemp,nx-2,ny-2);  %reshaping into a matrix
        u(2:end-1,2:end-1)=utemp;  %update internal points
        surf(X,Y,u); shading interp; view(35,25); drawnow;
        xlabel x, ylabel y, zlabel T;
    end
%}
end

%
%plotting the last solution
        utemp=reshape(utemp,nx-2,ny-2);  %reshaping into a matrix
        u(2:end-1,2:end-1)=utemp;  %update internal points
        
        figure(1)
        mesh(X,Y,u), axis([xmin xmax ymin ymax 0. 6]), view(42,26);
        xlabel x, ylabel y, zlabel T;
        colormap(1e-6*[1 1 1]); 
        
        title(['umid=',num2str(u(xmid,ymid)),' at t=',num2str(istep*dt)]);
        umid=u(xmid,ymid)
%
%
        
    
    
    
    








