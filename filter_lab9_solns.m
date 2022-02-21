% Martin King, 21 Feb 2020
clear all; close all;

set(0,'defaultaxesfontsize',20,'defaultaxeslinewidth',0.7, ...
      'defaultlinelinewidth',3.0,'defaultpatchlinewidth',2.0)

load -ascii nino34.long.dat; nino34 = nino34_long;

%remove first column (years) in orignal data
nino34(:,1)=[];

nino34=nino34';
nino34=reshape(nino34,1,1644); % nino34=nino34(833:end);
%nino34=nino34-mean(nino34);

dt=1/12;
year=[1871:dt:2008-dt]; % year=year(833:end);

scrsz = get(0,'ScreenSize');
%[left, bottom, width, height]
figure('Position',[2 2 scrsz(3)/2. scrsz(4)/3.]);
figure(1),clf
plot(year,nino34,'k-','LineWidth',1.0); xlabel('Year'); ylabel('Nino3.4');
title('Original Nino3.4 (black), filtered (blue)');
hold on;

N=length(nino34);  %total number of data points
Fc=0.5/dt;  %Nyquist Freq

F=mydft(nino34);  %Fourier Transform. part i of ex.

%lowpas, cutoff freq=11.5/12 per year: 
%ie slower than 1 year periods are included
nino34f=lowpass(F,Fc,11.5/12);  %see lowpass.m. part i of ex.  

F=mydft(nino34f);  %part ii of ex.

%defining x-axis as the frequencies. from 0 to Fc, with 
%N/2 number of discrete points:
freq=Fc*linspace(0,1,N/2); 

scrsz = get(0,'ScreenSize');
%[left, bottom, width, height]
figure('Position',[2 200 scrsz(3)/3. scrsz(4)/3.]);
figure(2),clf
%plotting absolute values of F vs frequencies.
semilogx(freq,abs(F(1:N/2)),'-o'); xlabel('Freq (1/yr)'); title('Power Spectrum: ABS(F) vs. log(freq)');

figure(1)
plot(year,real(nino34f)); xlabel('Year'); ylabel('Nino3.4'); 
hold off;

% n34f = real(nino34f);
% save('nino34lowpass.txt','n34f','-ascii');