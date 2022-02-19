% example m-file
% the note king_2008_diffusion2d_fdm_implicit.pdf accompanies this mfile
% martin king, 4 Sept 2008
%------------------------------
% solves 2D Diffusion Equation by Backward/Implicit Euler timestepping.
% du/dt=a(u_xx+u_yy) in domain [0,1]x[0,1]
% bc's: one side x=0, x=1: u=5. y=0, y=1: u=0. 
% ic: u=0.

clear all; close all;
format long;

a=1.; %the coefficient of diffusion

xmin=0.; xmax=1.0; ymin=0.; ymax=1.0;  % defining domain
dx=0.1; dy=0.1;  % grid spacing; this code will only work for dx=dy
x=[xmin:dx:xmax]; y=[ymin:dy:ymax];  % defining mesh
[X,Y]=meshgrid(x,y);  %X,Y are only used for plotting later
[nx,ny]=size(X);  % setting number of grid points

%where C=dt/dx^2, dt is timestep size
C=1.0; dt=C*dx.^2;

Thot=5.0; Tcold=0.;  % boundary values
wallhot=find(X==xmin|X==xmax);  % grid point indices for hot wall
wallcold=find(Y==ymin|Y==ymax);  % grid point indices for cold wall

u=zeros(nx,ny);  %declaring u
u(wallcold)=Tcold;u(wallhot)=Thot;  %boundary conditions
uinit=u;  %store initial u

tlast=2.;  %final time
ntsteps=ceil(tlast/dt);  %number of timesteps
dt=tlast/ntsteps;  %re-correct dt
C=dt./dx.^2;  %re-correct C

I = speye(nx-2); II=speye((nx-2)^2);% identity matrices
D = -a*dt*dx^(-2)*toeplitz([-2 1 zeros(1,nx-4)]);  % 1D Laplacian, see formula for Backward Euler
% 2D Laplacian; difficult to explain, but this is the MATLAB way to make this:
L = kron(I,D) + kron(D,I); 
B = II+L;

%forming the rhs (here, it's the 2D Laplacian of the b.c.'s) by taking DEL^2, 
%internal points must first be zero for this to work
rhsb=-a*dt*4*del2(uinit,dx,dy);
%the border of internal points in rhsb nicely forms the 2D Laplacian of b.c's
rhsb=rhsb(2:end-1,2:end-1);
%reshape rhs into a vector
rhsb=reshape(rhsb,(nx-2)*(ny-2),1);
%don't forget we have to change the sign, when we move terms from LHS to RHS
rhsb=-1.*rhsb;

rhs=rhsb+reshape(uinit(2:end-1,2:end-1),(nx-2)*(ny-2),1);
for istep=1:ntsteps  %time stepping
    utemp=B\rhs;  %all the above was done just to do this!
    rhs=utemp+rhsb;
%
% 'animation'
    if(mod(istep,2)==0.)
        figure(1)
        utemp=reshape(utemp,nx-2,ny-2);  %reshaping into a matrix
        u(2:end-1,2:end-1)=utemp;  %update internal points
        surf(X,Y,u); shading interp; view(28,16); drawnow;
        xlabel x, ylabel y, zlabel T;
    end
%
end

%
%plotting the last solution
        
        figure(2)
        mesh(X,Y,u), axis([xmin xmax ymin ymax 0. 6]), view(28,16);
        xlabel x, ylabel y, zlabel T;
        colormap(1e-6*[1 1 1]); 
        xmid=ceil(nx/2);ymid=ceil(ny/2);
        title(['umid=',num2str(u(xmid,ymid)),' at t=',num2str(istep*dt)]);
        umid=u(xmid,ymid)
%
%
        
    
    
    
    








