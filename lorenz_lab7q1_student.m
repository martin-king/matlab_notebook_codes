% Lab7 Q1, m-file template
% -------
% time integration of "chaotic" Lorenz 3-component system.
% this example employs a first-order time marching, i.e.
% the Euler's method (also equivalent to first-order truncated
% Taylor's series) 
% this code also needs lorenzrhs.m to run.
% Martin King, Aug 2008. (Modified from Holton, 2004)

clear all;
close all;

%setting the initial conditions
disp('initial Y and Z are 0 and 40 respectively. Specify initial 0 < X <= 10 when asked ')
X0 = input('give an initial X value:  ');
Y0 = 0;
Z0 = 40;

% define constants of the system
r = 28;
sig = 10;
b = 8/3;

%timestep size
dt = 0.02;

time = input('final integration time units: ');

v = [X0 Y0 Z0];  % vector of initial conditions

% setting up figure 1 for plotting
figure(1)
axis([-30 30 -30 30 0 50]), view(-140,45)
xlabel('X'), ylabel('Y'), zlabel('Z')
title('trajectory in X Y Z space')
hold on

n = 0;  % counter
vsave=[];

for t = 0:dt:time
    
    % lorenzrhs is a function written in lorenzrhs.m and returns the 
    % vprime vector
    vprime=lorenzrhs(v,r,sig,b);
    v= v +dt.*vprime; %Euler's Method
    
    p = plot3(v(1),v(2),v(3),'r.','MarkerSize',4);
    drawnow  
    
    vsave=[vsave; v];  %vsave stores the time history of v=[X Y Z]  

    if mod(t,.2) == 0  %saving X at an interval of t=0.2
        n = n+1;
        Xhist(n) = v(1);
        thist(n) = t;
    end
    
end
grid
hold off

scrsz = get(0,'ScreenSize');
%[left, bottom, width, height]
figure('Position',[2 2 scrsz(3)/2. scrsz(4)/3.]);

figure(2)
plot(thist(1:n),Xhist(1:n))
xlabel('time'); ylabel('X')
title('time series of X component')

%uncomment the following line to save vsave to file1.mat
%save file1 vsave;

%


