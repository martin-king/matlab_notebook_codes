% by martin king, 31 Aug 2008
%------------------------------
% solves 2D Laplace Equation by Jacobi iteration.
% 0=u_xx+u_yy in domain [0,1]x[0,1]
% bc's: one side u=5, 3 sides u=0. 
% ic: u=0.

clear all; close all;
format long;

xmin=0.; xmax=1.0; ymin=0.; ymax=1.0;  % defining domain
dx=0.1; dy=0.1;  % grid spacing
x=[xmin:dx:xmax]; y=[ymin:dy:ymax];  % defining mesh
[X,Y]=meshgrid(x,y);
[nx,ny]=size(X);  % setting number of grid points

Thot=5.0; Tcold=0.;  % boundary values
wallhot=find(X==xmin);  % grid point indices for hot wall
wallcold=find(X==xmax|Y==ymin|Y==ymax);  % grid point indices for cold wall

u=zeros(nx,ny);
u(wallcold)=Tcold; u(wallhot)=Thot;  %boundary conditions
update=u;

err=1;  %so that 1st iteration must run
while err>=0.5e-10
update=del2(u)+u;
%the above line does the same job as these nested loops:
%for ix=2:nx-1
%    for iy=2:ny-1
%     update(iy,ix)=0.25*(u(iy,ix+1)+u(iy,ix-1)+u(iy-1,ix)+u(iy+1,ix));
%    end
%end
err=norm(update(2:end-1,2:end-1)-u(2:end-1,2:end-1));  %calculating aprox error
u(2:end-1,2:end-1)=update(2:end-1,2:end-1);  %updating internal points
end

% 
%plotting
        mesh(X,Y,u), axis([xmin xmax ymin ymax 0 6]), view(44,38);
        xlabel x, ylabel y, zlabel T
        colormap(1e-6*[1 1 1]); 
        xmid=ceil(nx/2);ymid=ceil(ny/2);
        title(['u(0,0)=',num2str(u(xmid,ymid))]);
        umid=u(xmid,ymid)
%

        
    
    
    
    








