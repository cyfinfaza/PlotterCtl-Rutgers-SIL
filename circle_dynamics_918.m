clc
close all
clear all

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
x(k+1)=x(k)+v*cos(theta(k))*dt+sigma*sqrt(dt)*db1;
y(k+1)=y(k)+v*sin(theta(k))*dt+sigma*sqrt(dt)*db2;
theta(k+1)=theta(k)+omega;

end

plot(x,y)
