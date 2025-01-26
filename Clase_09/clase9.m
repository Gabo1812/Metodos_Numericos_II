 % Clase del 17/9/2024
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
%Ejemplo (modelando cañon de iones)
 clearvars;
 % Resuelve la ecuación de Laplace D^2U = 0
 % Limites del dominio
xi = 0;
xf = 0.05; %m
yi = 0;
yf = 0.05;
%....................
h = 4e-5;
%....................
x = (xi:h:xf)';
y = (yi:h:yf)';

%Creación del dominio
n = size(x,1);

%Creación de la matriz
U = zeros(n,n);
Udummy = zeros(n,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%spy(U)

%crear los electrodos

%Repeler
for i=200:1000
    for j=200:205
        Udummy(i,j) = 1;
    end
end

%Extractor
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

%focus
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

%ground (rejilla)
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

figure(1)
spy(Udummy)


%Colocar el potencial electrico en cada elecotrodo

for i=1:n
    for j=1:n
         if Udummy(i,j) == 1
             U(i,j) = 1000;% Repeler potential
         elseif Udummy(i,j) == 2
             U(i,j) = 600; % Extractor potential
         elseif Udummy(i,j) == 3
             U(i,j) = 600;
         elseif Udummy(i,j) == 4
             U(i,j) = 200; % Focus potential
         elseif Udummy(i,j) == 5
             U(i,j) = 200; % Focus potential
        elseif Udummy(i,j) == 6
             U(i,j) = 0; %  ground
         end
    end
end

%Grafica el U, donde x,y son las componentes (sin unidades)
figure(2)
h4 = surf(U);
colormap turbo;
h4.EdgeColor = 'none';

%...........
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


[X,Y] = meshgrid(x,y);
figure(3)
h5 = surf(X,Y,U);
colormap turbo;
h5.EdgeColor = 'none';



figure(777)
plot(dE, '-k');
grid on;
xlabel('Inter');
ylabel('log_(10)(Error)')


