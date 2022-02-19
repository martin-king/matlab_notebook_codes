function vprime=lorenzrhs(V,r,sig,b)

vprime(1) = -sig*V(1) + sig*V(2);
vprime(2) = -V(1)*V(3) + r*V(1)-V(2);
vprime(3) = V(1)*V(2) -b*V(3);

end