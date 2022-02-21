function [filtf]=bandpass(F,Fc,f_low,f_up)

%INPUTS:
%F is Fourier Transform of the original data
%Fc is the Nyquist Freq.
%frequencies between f_low and f_up will pass through this filter

%OUTPUTS:
%lowf is the low-pass filtered of the original data
%filt is the filter used

%SEE also lect. 30, pp.28-32.

%sharpess of filter
n=500;

N=length(F);
datend=ceil(N/2);

freq=Fc*linspace(0,1,datend);
%freq2=cat(2,freq,freq(1:datend-1)-Fc);  %see L.30 p. 12 for this.
%13 june 2009 it was freq2=cat(2,freq,freq(1:datend-1)-Fc);
%i had to change it to work for lab9
freq2=cat(2,freq,freq(1:datend)-Fc);  %see L.30 p. 12 for this.

filt=exp(-(freq2/f_up).^n)-exp(-(freq2/f_low).^n);
filt_F=F.*filt;
filtf=ifft(filt_F);

figure(10),clf
plot(freq2,abs(filt),'r+');
xlabel('Freq')
title('Shape of filter')
