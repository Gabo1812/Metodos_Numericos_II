 % Clase del 23/8/2024
 %Por Gabriel Alvarez derechos de Autor
%{
Marca de agua
                      ,-'`\
                  _,"'    j
           __....+       /               .
       ,-'"             /               ; `-._.'.
      /                (              ,'       .'
     |            _.    \             \   ---._ `-.
     ,|    ,   _.'  Y    \             `- ,'   \   `.`.
     l'    \ ,'._,\ `.    .              /       ,--. l
  .,-        `._  |  |    |              \       _   l .
 /              `"--'    /              .'       ``. |  )
.\    ,                 |                .        \ `. '
`.                .     |                '._  __   ;. \'
  `-..--------...'       \                  `'  `-"'.  \
      `......___          `._                        |  \
               /`            `..                     |   .
              /|                `-.                  |    L
             / |               \   `._               .    |
           ,'  |,-"-.   .       .     `.            /     |
         ,'    |     '   \      |       `.         /      |
       ,'     /|       \  .     |         .       /       |
     ,'      / |        \  .    +          \    ,'       .'
    .       .  |         \ |     \          \_,'        / j
    |       |  L          `|      .          `        ,' '
    |    _. |   \          /      |           .     .' ,'
    |   /  `|    \        .       |  /        |   ,' .'
    |   ,-..\     -.     ,        | /         |,.' ,'
    `. |___,`    /  `.   /`.       '          |  .'
      '-`-'     j     ` /."7-..../|          ,`-'
                |        .'  / _/_|          .
                `,       `"'/"'    \          `.
                  `,       '.       `.         |
             __,.-'         `.        \'       |
            /_,-'\          ,'        |        _.
             |___.---.   ,-'        .-':,-"`\,' .
                  L,.--"'           '-' |  ,' `-.\
                                        `.' 
%}
 %Ecuaciones Diferenciales

%Continuación clase 3, 23/8/24
%Ecuación a resolver y'' = y' + 2y + cos(x)
N = 100;
a = 0;
b = pi/2;
y0 = -0.3;
yN = -0.1;
p = @(x) 1;
q = @(x) 2;
r = @(x) cos(x);
h = (b-a)/(N+1);
x = (a:h:b)';

%Completar la matriz A:
A = zeros(N,N);
for i=1:N
    A(i,i) = (2+h^2*q(x(i+1)));
end
%spy(A) % Para mostrar la matriz
for i=1:N-1
    A(i,i+1) = -(1-(h/2)*p(x(i+1)));
    A(i+1,i) = -(1+(h/2)*p(x(i+1)));
end

%Completar el vector b
b = zeros(N,1);
b(1) = (1+(h/2)*p(x(2)))*y0-h^2*r(x(2));
for i=2:N-1
    b(i) = -h^2*r(x(i+1));
end
b(N) = (1-(h/2)*p(x(N+1)))*yN-h^2*r(x(N+1));
%Resolver el sistema A*y = b

y = A\b;
y = [y0;y;yN]; %Para incluir las condiciones frontera de los extremos
ya = @(x) -(1/10).*(sin(x)+3.*cos(x));
figure(1)
plot(x,y,'or')
hold on;
plot(x,ya(x), '.b');
hold off;
ylabel('y(x)');
xlabel('x')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ahora resolvemos y''= (-2/x)y' + (2/x^2)y + sin(log(x))/x^2
%Condiciones
a = 1;
b = 2;
y0 = 1;
yN = 2;
p = @(x) (-2/x);
q = @(x) (2/x^2);
r = @(x) sin(log(x))/x^2;
h = (b-a)/(N+1);
x = (a:h:b)';

%Completar la matriz A:
A = zeros(N,N);
for i=1:N
    A(i,i) = (2+h^2*q(x(i+1)));
end

for i=1:N-1
    A(i,i+1) = -(1-(h/2)*p(x(i+1)));
    A(i+1,i) = -(1+(h/2)*p(x(i+1)));
end

%Completar el vector b
b = zeros(N,1);
b(1) = (1+(h/2)*p(x(2)))*y0-h^2*r(x(2));
for i=2:N-1
    b(i) = -h^2*r(x(i+1));
end
b(N) = (1-(h/2)*p(x(N+1)))*yN-h^2*r(x(N+1));

%Resolver el sistema A*y = b
y = A\b;
y = [y0;y;yN]; %Para incluir las condiciones iniciales
figure(2)
plot(x,y,'or')
ylabel('y(x)');
xlabel('x')
%NOTA:  Hacer función de este metodo