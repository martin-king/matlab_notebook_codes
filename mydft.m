function [F]=mydft(f)

N=length(f);

omega0=2*pi/N;

real=zeros(1,N);
imag=zeros(1,N); 
F=zeros(1,N);

for k=0:N-1
    for n=0:N-1
        angle=k*omega0*n;
        real(k+1)=real(k+1)+f(n+1)*cos(angle);
        imag(k+1)=imag(k+1)-f(n+1)*sin(angle);
    end
    F(k+1)=real(k+1)+i*imag(k+1);
end

end