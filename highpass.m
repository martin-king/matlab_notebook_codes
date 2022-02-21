function [filtf]=highpass(F,Fc,f_cut)

%INPUTS:
%F is Fourier Transform of the original data
%Fc is the Nyquist Freq.
%f_cut is the cut-off freq the user chooses
%OUTPUTS:
%filtf is the filtered data
%filt is the filter used

%SEE also lect. 30, pp. 21-26.

%sharpess of filter
n=20;

N=length(F);
datend=ceil(N/2);

freq=Fc*linspace(0,1,datend);
%freq2=cat(2,freq,freq(1:datend-1)-Fc);  %see L.30 p. 12 for this.
%13 june 2009 it was freq2=cat(2,freq,freq(1:datend-1)-Fc);
%i had to change it to work for lab9
freq2=cat(2,freq,freq(1:datend)-Fc);  %see L.30 p. 12 for this.

filt=1-exp(-(freq2/f_cut).^n);
filt_F=F.*filt;
filtf=ifft(filt_F);

figure(10),clf
plot(freq2,abs(filt),'r+');
xlabel('Freq')
title('Shape of filter')

