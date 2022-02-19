function dudy = twoode(y,u)
    Dp=2.8e5; mu=0.492; L=4.88;
    dudy=[u(2);  -Dp/mu/L];
end
        