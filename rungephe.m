% just an mfile to show runge phenomenon.
% martin king, 30 july 2008.

clear all;
close all;

ezplot('1./(1+25*x.^2)',[-1 1])  %plotting the runge function
hold on;
axis([-1.2 1.2 -0.5 1.2])

pause;

x=linspace(-1,1,10);  %setting equi-distanced x points and the corresponding y points
%chebyshev points
%i=[1:1:20];
%x=cos((2.*i-1)/(2.*length(i))*pi);
%
y=1./(1+25*x.^2);
plot(x,y,'bo')

pause;

p=polyfit(x,y,length(x)-1);  %fit a polynomial to these points
xi=linspace(-1,1,100);  %setting many x points for interpolation
yi=polyval(p,xi);
plot(xi,yi,'k-')  %plotting the interpolated curve

pause;                                      

% interpolation with splines
yi3=interp1(x,y,xi,'spline');
plot(xi,yi3,'r-')
