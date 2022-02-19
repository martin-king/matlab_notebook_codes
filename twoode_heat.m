function dydx = twoode_heat(x,y)
    h=0.05; Ta=200;
    dydx=[y(2);  h*(y(1)-Ta)];
end
        
