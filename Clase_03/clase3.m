 % Clase del 20/8/2024
 %Por Gabriel Alvarez derechos de Autor
%{
Marca de agua
               _,........__
            ,-'            "`-.
          ,'                   `-.
        ,'                        \
      ,'                           .
      .'\               ,"".       `
     ._.'|             / |  `       \
     |   |            `-.'  ||       `.
     |   |            '-._,'||       | \
     .`.,'             `..,'.'       , |`-.
     l                       .'`.  _/  |   `.
     `-.._'-   ,          _ _'   -" \  .     `
`."""""'-.`-...,---------','         `. `....__.
.'        `"-..___      __,'\          \  \     \
\_ .          |   `""""'    `.           . \     \
  `.          |              `.          |  .     L
    `.        |`--...________.'.        j   |     |
      `._    .'      |          `.     .|   ,     |
         `--,\       .            `7""' |  ,      |
            ` `      `            /     |  |      |    _,-'"""`-.
             \ `.     .          /      |  '      |  ,'          `.
              \  v.__  .        '       .   \    /| /              \
               \/    `""\"""""""`.       \   \  /.''                |
                `        .        `._ ___,j.  `/ .-       ,---.     |
                ,`-.      \         ."     `.  |/        j     `    |
               /    `.     \       /         \ /         |     /    j
              |       `-.   7-.._ .          |"          '         /
              |          `./_    `|          |            .     _,'
              `.           / `----|          |-............`---'
                \          \      |          |
               ,'           )     `.         |
                7____,,..--'      /          |
                                  `---.__,--.'
%}
% Metodo Newton - Raphson
%Ejemplo: f(x)  = (x-2)(x+5)(x-7) y su derivada f'(x) 
%Sirve para encontrar ceros no soluciones
clearvars;
x = (-6:0.001:10)';
f = @(x) (x-2).*(x+5).*(x-7);
df = @(x) (x+5).*(x-7) + (x-2).*(x-7) + (x-2).*(x+5);
figure(1);
plot(x,f(x), '-r');
tol = 1e-10;
n = 100;
xn = 0;
for i = 1:n
    xnn = xn - f(xn)/df(xn);
    if abs(xnn-xn)<=tol
        break;
    end
    xn = xnn;
end
%Este metodo se extra pola hasta raices
%Para un sistema de ecuaciones no lineales
% Ejemplo 2: 4x^2 + y^2 + 2*x*y - y = 2 ====> 4x^2 + y^2 + 2*x*y - y -2= 0
%            2x^2 + 3*x*y + y^2 = 3     ====> 2x^2 + 3*x*y + y^2 -3 = 0

%Con
%Puntos iniciales
x = 0.1;
y = 0.1;

sn = [x,y]';
tol = 1e-10;
N = 100;
for i = 1:N
    J = [8*x+2*y, 2*y + 2*x-1;...
        4*x+3*y, 3*x + 2*y];%Jacobiano
    F = [4*x^2+y^2+2*x*y-y-2;...
        2*x^2+3*x*y+y^2-3];%sistema de ec.
    v = J\(-F); %Resolver 
    snn = sn + v;
    test = sqrt(dot(sn - snn, sn-snn));
    if test<= tol
        break;
    end
    sn = snn;
    x = sn(1);
    y = sn(2);
end


