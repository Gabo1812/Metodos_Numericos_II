 % Clase del 13/9/2024
 %Por Gabriel Alvarez derechos de Autor
%{
Marca de agua
                       _
            _,..-"""--' `,.-".
          ,'      __.. --',  |
        _/   _.-"' |    .' | |       ____
  ,.-""'    `-"+.._|     `.' | `-..,',--.`.
 |   ,.                      '    j 7    l \__
 |.-'                            /| |    j||  .
 `.                   |         / L`.`""','|\  \
   `.,----..._       ,'`"'-.  ,'   \ `""'  | |  l
     Y        `-----'       v'    ,'`,.__..' |   .
      `.                   /     /   /     `.|   |
        `.                /     l   j       ,^.  |L
          `._            L       +. |._   .' \|  | \
            .`--...__,..-'""'-._  l L  """    |  |  \
          .'  ,`-......L_       \  \ \     _.'  ,'.  l
       ,-"`. / ,-.---.'  `.      \  L..--"'  _.-^.|   l
 .-"".'"`.  Y  `._'   '    `.     | | _,.--'"     |   |
  `._'   |  |,-'|      l     `.   | |"..          |   l
  ,'.    |  |`._'      |      `.  | |_,...---"""""`    L
 /   |   j _|-' `.     L       | j ,|              |   |
`--,"._,-+' /`---^..../._____,.L',' `.             |\  |
   |,'      L                   |     `-.          | \j
            .                    \       `,        |  |
             \                __`.Y._      -.     j   |
              \           _.,'       `._     \    |  j
              ,-"`-----""""'           |`.    \  7   |
             /  `.        '            |  \    \ /   |
            |     `      /             |   \    Y    |
            |      \    .             ,'    |   L_.-')
             L      `.  |            /      ]     _.-^._
              \   ,'  `-7         ,-'      / |  ,'      `-._
             _,`._       `.   _,-'        ,',^.-            `.
          ,-'     v....  _.`"',          _:'--....._______,.-'
        ._______./     /',,-'"'`'--.  ,-'  `.
                 """""`.,'         _\`----...' 
                        --------""'
%}
 %Metodo de relajación
 %Forma más simple de resolver ecuaciones lineales
 clearvars;
 % Resuelve la ecuación de Laplace D^2U = 0
 % Limites del dominio
xi = 0;
xf = 0.07; %m
yi = 0;
yf = 0.05;


%Partición del dominio
factor = 30;
n = factor*5;
m = factor*7;
%....................
h = (xf-xi)/m;
k = (yf-yi)/n;
%....................
x = (xi:h:xf)';
y = (yi:k:yf)';
%Creación de la matriz
U = zeros(n+1,m+1);
%.....................
%Condiciones de frontera en el dominio
U(:,1) = 10;%llena columna izquierda
U(n+1,2:m) = 0;%llena fila de abajo
U(:,m+1) = 10; % llena columna derecha
U(1,2:m) = 0; % llena fila de arriba
%...................................
N = 1e4;
dE = zeros(N,1);
Ut = 0;
for k=1:N
    for i=2:n
        for j=2:m
            U(i,j) = (1/4)*( U(i+1,j)+U(i-1,j)+U(i,j+1)+U(i,j-1));
        end
    end
    dE(k) = log10( abs(U(33,35) - Ut) ); % se puede escoger cualquier punto
    Ut = U(33,55);
end

%Grafica el U, donde x,y son las componentes (sin unidades)
figure(1)
h4 = surf(U);
colormap turbo;
h4.EdgeColor = 'none';
xlabel('p_x');
ylabel('p_y');
zlabel('V(p_x,p_y)');
%Esta ya va con metros
%{
[X,Y] = meshgrid(x,y);
figure(2)
h5 = surf(X,Y,U);
colormap turbo;
h5.EdgeColor = 'none';
%}

figure(777)
plot(dE, '-k');
grid on;
xlabel('Inter');
ylabel('log_(10)(Error)')


