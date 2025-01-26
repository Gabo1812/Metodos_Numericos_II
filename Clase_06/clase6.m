 % Clase del 30/8/2024
 %Por Gabriel Alvarez derechos de Autor
%{
Marca de agua
                               ,'"`.,./.
                             ,'        Y',"..
                           ,'           \  | \
                          /              . |  `
                         /               | |   \
            __          .                | |    .
       _   \  `. ---.   |                | j    |
      / `-._\   `Y   \  |                |.     |
     _`.    ``    \   \ |..              '      |,-'""7,....
     l     '-.     . , `|  | , |`. , ,  /,     ,'    '/   ,'_,.-.
     `-..     `-.  : :     |/ `   ' "\,' | _  /          '-'    /___
      \""' __.,.-`.: :        /   /._    l'.,'
       `--,   _.-' `".           /__ `'-.' '         .
       ,---..._,.--"""""""--.__..----,-.'   .  /    .'   ,.--
       |                          ,':| /    | /     ;.,-'--      ,.-
       |     .---.              .'  :|'     |/ ,.-='"-.`"`' _   -.'
       /    \    /               `. :|--.  _L,"---.._        "----'
     ,' `.   \ ,'           _,     `''   ``.-'       `-  -..___,'
    . ,.  .   `   __     .-'  _.-           `.     .__    \
    |. |`        "  ;   !   ,.  |             `.    `.`'---'
    ,| |C\       ` /    | ,' |(]|            -. |-..--`
   /  "'--'       '      /___|__]        `.  `- |`.
  .       ,'                   ,   /       .    `. \
    \                      .,-'  ,'         .     `-.
     x---..`.  -'  __..--'"/"""""  ,-.      |   |   |
    / \--._'-.,.--'     _`-    _. ' /       |     -.|
   ,   .   `-..__ ...--'  _,.-' | `   ,.-.  ;   /  '|
  .  _,'         '"-----""      |    `   | /  ,'    ;
  |-'  .-.    `._               |     `._// ,'     /
 _|    `-'   _,' "`--.._________|        `,'    _ /.
//\   ,-._.'"/\__,.   _,"     /_\__/`. /'.-.'.-/_,`-' 
`-"`"' v'    `"  `-`-"              `-'`-`  `'
%}
% Partial Differential Equation (PDE)

% This class of differential equation coulde be separated in three clasess:
%  Eliptic, Parabolic and Hyperbolic Equation

% For example, the eliptic equation are very important into the electromagenetics field 
% Parabolic equation are used in the heat conduction equation and hyperbolic ecuation are used on
% wave equation 
% Poisson Equation 
% La ecuación a resolver es: D^2U = rho/epsilon

% Limites del dominio
xi = 0;
xf = 0.07; %m
yi = 0;
yf = 0.05;

%Partición del dominio
factor = 1;
n = factor*5;
m = factor*7;

h = (xf-xi)/m;
k = (yf-yi)/n;

x = (xi:h:xf)';
y = (yi:k:yf)';

% Definición del f(x)
epsilonr = 1;
epsilon0 = 8.85e-12;
epsilon = epsilonr*epsilon0;
%Para Poisson
%rho = -1e-6;
%Para Laplace 
rho = 0;
f = @(x,y) rho/epsilon;
%.............
%Coeficientes de la matriz
alpha = 2*(1+(h/k)^2);
beta = (h/k)^2;
%.............
%Creación del dominio
U = zeros(n+1,m+1);
%.....................
%Condiciones de frontera en el dominio
U(:,1) = 0;%llena columna izquierda
U(n+1,2:m) = 0;%llena fila de abajo
U(:,m+1) = 0; % llena columna derecha
U(1,2:m) = 0; % llena fila de arriba

%............
A = zeros(m-1,m-1);
for i=1:m-1
    A(i,i) = alpha;
end
for i = 1:m-2
    A(i,i+1) = -beta;
    A(i+1,i) = -beta;
end
%............ No se usó pero se puede
B = zeros(m-1,m-1);
for i =1:m-1
    B(i,i) = -beta;
end
%.....
%C = zeros(m-1,m-1);
%Conforma la matriz del problema
C = A;
for i=1:n-2
    C = blkdiag(C,A); % Crea una matriz con matrices dentro
end
for i = 0:size(C,1)-m
    C(m+i,i+1) = -beta; % Para meter los betas
    C(i+1,m+i) = -beta;
end
%figure(1)
%spy(C)

%.....................
% Para crear el vector b
b = zeros(size(C,1),1);
%Los llena por filas de los puntos a encontrar
l = 0;
for i=2:n
    for j=2:m
        l = l+1;
        b(l) = U(i-1,j)+U(i+1,j)+beta*(U(i,j-1)+U(i,j+1))-h^2*f(x(j),y(i));
    end
end

%Ahora se resuelve el sistema
u = C\b;

%Se ingresa el resultado en U
l = 0;
for i=2:n
    for j=2:m
        l = l+1;
        U(i,j) = u(l);
    end
end
%Grafica el U, donde x,y son las componentes (sin unidades)
figure(2)
h4 = surf(U);
colormap turbo;
h4.EdgeColor = 'none';
xlabel('p_x');
ylabel('p_y');
zlabel('V(p_x,p_y)');
%Esta ya va con metros
[X,Y] = meshgrid(x,y);
figure(3)
h5 = surf(X,Y,U);
colormap turbo;
h5.EdgeColor = 'none';

%Calcular gradiente
[Ex, Ey] = gradient(U);
% Se normaliza el campo vectorial
E = sqrt(Ex.^2 + Ey.^2);
Ex = Ex./E;
Ey = Ey./E;

figure(4)
contour(x,y,U,20);
hold on;
quiver(X,Y,Ex,Ey,'r');
hold off;
xlabel('x')
ylabel('y')