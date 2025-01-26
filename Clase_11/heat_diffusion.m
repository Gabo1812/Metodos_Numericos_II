clearvars;
% heat diffusion equation 
xi = 0.00;
xf = 0.10;
ti = 0;
tf = 5.0;

n = 100;
m = 2000;

h = (xf-xi)/n;
k = (tf-ti)/m;

x = (xi:h:xf)';
t = (ti:k:tf)';

% termic diffusivity
a = 111e-6; % m2/s Cu\
%a = 40e-6; % Sn 

%Matrix coefficients
r = a*k/h^2;

% Boundary conditions
Txi = 0;
Txf = 0;

% fill the matrix

A = zeros(n+1,n+1);

for i=1:n+1
    A(i,i) = (1-2*r);
end

for i=1:n
    A(i,i+1) = r;
    A(i+1,i) = r;
end

A(2,1) = r*Txi;
A(n,n+1) = r*Txf;

figure(1);
spy(A);

% Initial conditions
T0 = @(x) -1000*x+120;
%T0 = @(x) 100*ones(size(x,1),1);

figure(2);
area(x,T0(x));
xlabel('L(m');
ylabel('T(c)');
ylim([0,120]);

figure(3);
area(x,T0(x));
xlabel('L(m)');
ylabel('T(c)');
ylim([0 125]);

Tt = T0(x);
for j = 1:m+1
    T = A*Tt;
    area(x,T);
    xlim([0 0.1]);
    ylim([0 125]);
    str = ['t = ', num2str(t(j)), ' s'];
    text(0.05,110,str);
    Tt = T;
    pause(0.01);
end
