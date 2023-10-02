clc
close all

plotter=XYPlotter('COM4');

dt=1/10;
N=1000;
vT=0:dt:N*dt;
v=0.5;
x(1)=0;
y(1)=0;
theta(1)=pi;
omega=0.1;

sigma=0;

for k=1:length(vT)-1

    db1=randn;
    db2=randn;
    newX = x(k)+v*cos(theta(k))*dt+sigma*sqrt(dt)*db1;
x(k+1)= newX;
newY = y(k)+v*sin(theta(k))*dt+sigma*sqrt(dt)*db2;
y(k+1)=newY;
theta(k+1)=theta(k)+omega;

[distance] = plotter.moveTo(newX*200,newY*200, dt);
% pause(0.2);

end

