% by martin king, 31 Aug 2008
%------------------------------
% solves 2D Laplace Equation by direct method 
% (i.e. inverse Laplacian).
% 0=u_xx+u_yy in domain [0,1]x[0,1]
% bc's: one side u=5, 3 sides u=0. 
% ic: u=0.

clear all; close all;
format long;

xmin=0.; xmax=1.0; ymin=0.; ymax=1.0;  % defining domain
dx=0.1; dy=0.1;  % grid spacing
x=[xmin:dx:xmax]; y=[ymin:dy:ymax];  % defining mesh
[X,Y]=meshgrid(x,y);  %X,Y only used for plotting later
[nx,ny]=size(X);  % setting number of grid points

Thot=5.0; Tcold=0.;  % boundary values
wallhot=find(X==xmin);  % grid point indices for hot wall
wallcold=find(X==xmax|Y==ymin|Y==ymax);  % grid point indices for cold wall

u=zeros(nx,ny);
u(wallcold)=Tcold;u(wallhot)=Thot;  %boundary conditions

I = speye(nx-2); % identity matrix
D = dx^(-2)*toeplitz([-2 1 zeros(1,nx-4)]);  % 1D Laplacian
% 2D Laplacian; difficult to explain, but this is the MATLAB way to make
% this:
L = kron(I,D) + kron(D,I); 

%forming the rhs (here, it's the b.c.'s) by taking DEL^2, 
%internal points must first be zero for this to work.
rhs=4*del2(u,dx,dy);
%the border of internal points in rhs nicely forms the b.c's; the rest of 
%the points are zero here because this is a Laplace Eq, ie f(x,y)=0.
rhs=rhs(2:end-1,2:end-1);
%reshape rhs into a vector
rhs=reshape(rhs,(nx-2)*(ny-2),1);
%don't forget we have to change the sign, when we move terms from LHS to RHS.
rhs=-1.*rhs;

utemp=L\rhs;  %all the above was done just to do this!

utemp=reshape(utemp,nx-2,ny-2);  %reshaping into a matrix

u(2:end-1,2:end-1)=utemp;  %update internal points

%plotting
        mesh(X,Y,u), axis([xmin xmax ymin ymax 0. 6]), view(42,26);
        xlabel x, ylabel y, zlabel T
        colormap(1e-6*[1 1 1]); 
        xmid=ceil(nx/2);ymid=ceil(ny/2);
        title(['u(0,0)=',num2str(u(xmid,ymid))]);
        umid=u(xmid,ymid)
%

        
    
    
    
    








