% sample solution for Lab 8, Q 1.
% by martin king, 31 Aug 2008
%------------------------------
% solves 2D Laplace Equation by SOR Gauss-Seidel iteration.
% 0=u_xx+u_yy in domain [0,2]x[0,2]
% bc's: one side u=6, 3 sides u=0. 
% ic: u=0.

clear all; close all;
format long;

xmin=0.; xmax=2.0; ymin=0.; ymax=2.0;  % defining domain
dx=0.05; dy=0.05;  % grid spacing
x=[xmin:dx:xmax]; y=[ymin:dy:ymax];  % defining mesh
[X,Y]=meshgrid(x,y);
[nx,ny]=size(X);  % setting number of grid points

Thot=6.0; Tcold=0.;  % boundary values
wallhot=find(X==xmin);  % grid point indices for hot wall
wallcold=find(X==xmax|Y==ymin|Y==ymax);  % grid point indices for cold wall

u=zeros(nx,ny);
u(wallcold)=Tcold; u(wallhot)=Thot; %boundary conditions
uold=u;
alpha=0.9; %-1<alpha<1; negative for under-relaxation, positive for over-relaxation 
xmid=ceil(nx/2);ymid=ceil(ny/2);
err=1;  %so that first iteration must run
iter=0;
while err>=0.5e-10
    for ix=2:nx-1
      for iy=2:ny-1
          u(iy,ix)=(1+alpha)*0.25*(u(iy,ix-1)+u(iy,ix+1)+u(iy-1,ix)+u(iy+1,ix))-alpha*uold(iy,ix);
      end
    end
err=norm(u-uold);
uold=u;
iter=iter+1
end

% 
%plotting
        mesh(X,Y,u), axis([0 2 0 2 0. 6]), view(44,38);
        xlabel x, ylabel y, zlabel T
        colormap(1e-6*[1 1 1]); 
        
        title(['umid=',num2str(u(xmid,ymid))]);
        umid=u(xmid,ymid)
%

        
    
    
    
    








