% by martin king, 30 Sep 2009
%------------------------------
% solves 2D Poisson Equation by Jacobi iteration.
% 0=u_xx+u_yy in domain [0,2]x[0,2]
% bc's: u=5, u=3, u=2, u=0 
% ic: u=0.

clear all; close all; clc;
format long;

xmin=-1.; xmax=1.; ymin=-1.; ymax=1.;  % defining domain
dx=0.05; dy=0.05;  % grid spacing
x=[xmin:dx:xmax]; y=[ymin:dy:ymax];  % defining mesh
[X,Y]=meshgrid(x,y);
[nx,ny]=size(X);  % setting number of grid points

T5=5.0; T3=3.0; T2=2.0; T0=0.0;  % boundary values
switch 3
    case 1
        wall5=find(Y==ymax); wall3=find(X==xmax); wall2=find(Y==ymin); wall0=find(X==xmin);
    case 2
        wall5=find(X==xmax); wall3=find(Y==ymin); wall2=find(Y==ymax); wall0=find(X==xmin);
    case 3
        wall5=find(Y==ymax); wall3=find(Y==ymin); wall2=find(X==xmax); wall0=find(X==xmin);
end

u=zeros(nx,ny);
u(wall5)=T5; u(wall3)=T3; u(wall2)=T2; u(wall0)=T0;  %boundary conditions
uprev=u;

f=@(x,y,A) A/0.2*exp(-0.5*(x^2+y^2)/0.2^2);

A=1.5329;

err=1;  %so that 1st iteration must run
while err>=0.5e-10
%update=del2(u)+u;
%the above line does the same job as these nested loops:
for ix=2:nx-1
    for iy=2:ny-1
     u(ix,iy)=0.25*(u(ix,iy+1)+u(ix,iy-1)+u(ix-1,iy)+u(ix+1,iy)+ ... 
         A/0.2*exp(-0.5*(x(ix)^2+y(iy)^2)/0.2^2)*dx^2); 
    end
end
err=norm(u(2:end-1,2:end-1)-uprev(2:end-1,2:end-1));  %calculating aprox error
uprev(2:end-1,2:end-1)=u(2:end-1,2:end-1);  %updating internal points
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

        
    
    
    
    








