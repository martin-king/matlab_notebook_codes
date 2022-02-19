%sample m-file
clear all;
close all;

%REMEMBER TO CHANGE DT ACCORDING TO THE RUNS

load file1.mat
vsave1=vsave;

load file2.mat
vsave2=vsave;

dt=0.02;  %time step size used in lab7q1_student.m

n=length(vsave2(:,1));
display=1;

for i=1:n
    separation1=norm(vsave2(i,:)-vsave1(i,:))./norm(vsave2(i,:));
    plot(i*dt,separation1*100,'b.','MarkerSize',5);
    hold on;
    
    if(separation1 > 0.1 && display)
        disp('t at seperation just larger than 0.1: '),disp(i*dt);
        display=0;
    end
end

xlabel('t'), ylabel('separation %');
hold off