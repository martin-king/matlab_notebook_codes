function r=res(u0)

z_leftend=0;
u_rightend=0;

[y,u]=ode45(@twoode,[0 0.0025],[u0 z_leftend]);

r=u(end,1)-u_rightend; 