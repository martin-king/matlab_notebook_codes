% sample solution m-file

clear all; close all;

% number of internal points is 199, i.e. 200 intervals
nx=19;

%length of column
L=4; dx=L/(nx+1); x=0:dx:L;

A=-dx^(-2)*toeplitz([-2 1 zeros(1,nx-2)]);
figure(1)
spy(A)

%uncomment this part for part b.
%E=linspace(30,100,nx+2);
%DE=diag(E(2:end-1),0);
%A=A*DE;
%
%another way (longer)
%E=linspace(30,100,nx+2);
%EE=diag(E(2:end-1),0)+diag(E(2:end-2),-1)+diag(E(3:end-1),1);
%A=EE.*A;

[V,D]=eig(A);
[eigval,isort]=sort(diag(D));

for n=1:4
    neig=isort(n);  %neig is the index for the nth eigenvalue/vector
  y=zeros(nx+2,1);  %define y
  y(2:end-1)=V(:,neig);  %update the internal points
  figure(2)
  subplot(1,4,n)
   plot(y,x,'+-')
   title(['eigval=',num2str(D(neig,neig))])
   axis([-0.5 0.5 0 L])
   xlabel y, ylabel x;
end