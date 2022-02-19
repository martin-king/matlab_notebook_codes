% by martin king, 31 Aug 2008
%------------------------------
% solves 2D Laplace Equation by direct method 
% (i.e. inverse Laplacian).
% 0=u_xx+u_yy in domain [-5,5]x[-5,5]
% bc's: top and bottom walls u=-x
%       left and right walls u=-y
% ic: u=0.

clear all; close all;
format long;

xmin=-5.; xmax=5.; ymin=-5.; ymax=5.;  % defining domain
dx=0.25; dy=0.25;  % grid spacing
x=[xmin:dx:xmax]; y=[ymin:dy:ymax];  % defining mesh
[X,Y]=meshgrid(x,y);  %X,Y only used for plotting later
[nx,ny]=size(X);  % setting number of grid points

% boundary values
topwall=find(Y==ymax); botwall=find(Y==ymin);
lefwall=find(X==xmin); rigwall=find(X==xmax);

u=zeros(nx,ny);
u(topwall)=-x; u(botwall)=-x;  %boundary conditions
u(lefwall)=-y; u(rigwall)=-y;

I = speye(nx-2); % identity matrix
D = dx^(-2)*toeplitz([-2 1 zeros(1,nx-4)]);  % 1D Laplacian
% 2D Laplacian; difficult to explain, but this is the MATLAB way to make
% this:
L = kron(I,D) + kron(D,I);  

%forming the rhs (here, it's the b.c.'s) by taking \nabla^2, 
%internal points must be zero for this to work.
rhs=4*del2(u,dx,dy);  
%the border of internal points nicely forms the b.c's; the rest of 
%the points are zero because this is a Laplace Eq, ie f(x,y)=0.
rhs=rhs(2:end-1,2:end-1);
%reshape rhs into a vector
rhs=reshape(rhs,(nx-2)*(ny-2),1);
%don't forget we have to change the sign, when we move terms from LHS to RHS.
rhs=-1.*rhs;

utemp=L\rhs;  %all the above was done just to do this!
utemp=reshape(utemp,nx-2,ny-2);  %reshaping into a matrix
u(2:end-1,2:end-1)=utemp;  %update internal points

%plotting
        contourf(X,Y,u,20),colorbar;
        xlabel('x');ylabel('y');
%

        
    
    
    
    








