% Martin King, 21 Feb 2020
clear all; close all;

set(0,'defaultaxesfontsize',20,'defaultaxeslinewidth',0.7, ...
      'defaultlinelinewidth',3.0,'defaultpatchlinewidth',2.0)

load -ascii GLBTSSST.long.dat; GLBTSSST = GLBTSSST_long;

%remove first column (years) in orignal data
GLBTSSST(:,1)=[];

GLBTSSST=GLBTSSST';
GLBTSSST=reshape(GLBTSSST,1,1536); % nino34=nino34(833:end);
%nino34=nino34-mean(nino34);

dt=1/12;
year=[1880:dt:2008-dt]; % year=year(833:end);

scrsz = get(0,'ScreenSize');
%[left, bottom, width, height]
figure('Position',[2 2 scrsz(3)/2. scrsz(4)/3.]);
figure(1),clf
plot(year,GLBTSSST,'k-','LineWidth',1.0); xlabel('Year'); ylabel('Nino3.4');
title('Original Nino3.4 (black), filtered (blue)');
hold on;

N=length(GLBTSSST);  %total number of data points
Fc=0.5/dt;  %Nyquist Freq

F=mydft(GLBTSSST);  %Fourier Transform. part i of ex.

GLBTSSSTf=lowpass(F,Fc,11/12);  %see lowpass.m. part i of ex.  

F=mydft(GLBTSSSTf);  %part ii of ex.

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
plot(year,real(GLBTSSSTf)); xlabel('Year'); ylabel('Temp. Anom. x100'); 
hold off;

% glbtf = real(GLBTSSSTf);
% save('glbtsstlowpass.txt','glbtf','-ascii');

