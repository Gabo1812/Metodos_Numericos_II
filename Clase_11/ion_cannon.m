clearvars;
xi = 0;
xf = 0.05;
yi =0;
yf = 0.05;

h = 4e-5;
x = (xi:h:xf);
y = (yi:h:yf);

n = size(x,2);

U = zeros(n,n);
%spy(U);
Udummy = zeros(n,n);

for i=200:1000
    for j=200:205
        Udummy(i,j) = 1;
    end
end

% Extractor
for i=200:500
    for j=400:405
        Udummy(i,j) = 2;
    end
end

for i=700:1000
    for j=400:405
        Udummy(i,j) = 3;
    end
end

% Focus
for i=200:500
    for j=800:805
        Udummy(i,j) = 4;
    end
end

for i=700:1000
    for j=800:805
        Udummy(i,j) = 5;
    end
end

% Ground

% Extractor
for i=200:500
    for j=1100:1105
        Udummy(i,j) = 6;
    end
end

for i=700:1000
    for j=1100:1105
        Udummy(i,j) = 6;
    end
end

figure(1);
spy(Udummy);
title('Dummy matrix');

% potential on each electrode

for i=1:n
    for j=1:n
        if Udummy(i,j) == 1
            U(i,j) = 1000;
        elseif Udummy(i,j) == 2
            U(i,j) = 600;
        elseif Udummy(i,j) == 3
            U(i,j) = 600;
        elseif Udummy(i,j) == 4
            U(i,j) = 200;
        elseif Udummy(i,j) == 5
            U(i,j) = 200;
        elseif Udummy(i,j) == 6
            U(i,j) = 0;
        end
    end
end

figure(2);
h4 = surf(U);
colormap turbo;
h4.EdgeColor = 'none'; % quitar color negro a cuadriculas
xlabel('p_x');
ylabel('p_y');
zlabel('V(px,py)');

N = 10000;
dE = zeros(N,1);
Ut = 0;
for k=1:N
    for i=1:n-1
        for j=1:n-1
            if (i==1) && (j==1)
                U(i,j) = (1/4)*(2*U(i+1,j)+2*U(i,j+1));
            elseif (i==n) && (j==n)
                U(i,j) = (1/4)*(2*U(i-1,j)+2*U(i,j+1));
            elseif (i==1) && (j > 1) && (j< n)
                U(i,j) = (1/4)*(2*U(i+1,j)+U(i,j+1)+U(i,j-1));
            elseif (i==n) && (j>1) && (j<n)
                U(i,j) = (1/4)*(2*U(i-1,j)+U(i,j+1)+U(i,j-1));
            elseif (i==n) && (i>1) && (i<n)
                U(i,j) = (1/4)*(U(i+1,j)+U(i-1,j)+U(i,j-1));
           elseif (j==1) && (i>1) && (i<n)
                U(i,j) = (1/4)*(U(i+1,j)+U(i-1,j)+2*U(i,j+1));     
           elseif (j==n) && (i<n) && (i>1)
                U(i,j) = (1/4)*(U(i+1,j)+U(i-1,j)+2*U(i,j-1));
            else
                if Udummy(i,j)==0
                    U(i,j) = (1/4)*(U(i+1,j)+U(i-1,j)+U(i,j+1)+U(i,j-1));                
                end
            end
        end
    end
    dE(k) = log10(abs(U(800,600)-Ut));
    Ut = U(800,600);
end      

[X, Y] = meshgrid(x,y);
figure(3);
h5 = surf(X,Y,U);
colormap turbo;
h5.EdgeColor = 'none'; % quitar color negro a cuadriculas
xlabel('x');
ylabel('y');
zlabel('V(x,y)');

figure(6);
plot(dE);