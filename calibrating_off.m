close all
clc
clear


A = [-1 0 0; 0 -1 0; 0 0 -1];

B = [0; 0; 0];

[x,J]=fmincon('calibrate_off',[0.001 1 0.5],A,B);

lambda0=x(2)
kappa0=x(3)

G10=[4.60E+05	3.60E+05	3.40E+05
6.40E+05	5.20E+05	6.40E+05
3.40E+06	4.00E+06	3.20E+06
5.40E+06	6.60E+06	6.40E+06
8.80E+06	1.00E+07	1.08E+07
2.00E+07	2.20E+07	3.00E+07
4.00E+07	4.00E+07	4.40E+07
7.40E+07	8.00E+07	8.60E+07
1.00E+08	1.80E+08	1.40E+08
2.20E+08	3.00E+08	2.60E+08
4.00E+08	4.40E+08	4.40E+08
4.20E+08	4.00E+08	5.80E+08
4.00E+08	4.80E+08	4.20E+08
3.80E+08	5.40E+08	4.00E+08
3.80E+08	4.80E+08	4.00E+08
5.40E+08	4.00E+08	3.80E+08
4.60E+08	3.20E+08	3.80E+08
3.40E+08	4.80E+08	3.40E+08
4.00E+08	3.80E+08	5.40E+08
4.20E+08	4.00E+08	4.60E+08
3.00E+08	5.60E+08	2.80E+08
5.20E+08	3.40E+08	3.80E+08
4.00E+08	3.60E+08	5.00E+08
5.20E+08	4.00E+08	3.80E+08
3.40E+08	4.20E+08	4.40E+08];

data = mean(G10(:,1:3),2)/10^9;

x0 = x(1);
lambda = x(2);
kappa = x(3);

x = [x0];

x_now = x0;

for k=1:24
     
    x_next = x_now + lambda*x_now*(1-x_now/kappa);
    
    x = [x; x_next];
    
    x_now = x_next;
    
end

errorbar([0:24],mean(G10(:,1:3)'/10^9),std(G10(:,1:3)'/10^9))
hold
plot([0:24],x)
hold
%figure
%scatter([0:24],G10(:,3)/10^9)
%hold
%plot([0:24],x)
%hold