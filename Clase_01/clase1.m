 % Clase del 13/8/2024
 %Por Gabriel Alvarez derechos de Autor
%{
Marca de agua
              _.--""`-..
            ,'          `.
          ,'          __  `.
         /|          " __   \
        , |           / |.   .
        |,'          !_.'|   |
      ,'             '   |   |
     /              |`--'|   |
    |                `---'   |
     .   ,                   |                       ,".
      ._     '           _'  |                    , ' \ `
  `.. `.`-...___,...---""    |       __,.        ,`"   L,|
  |, `- .`._        _,-,.'   .  __.-'-. /        .   ,    \
-:..     `. `-..--_.,.<       `"      / `.        `-/ |   .
  `,         """"'     `.              ,'         |   |  ',,
    `.      '            '            /          '    |'. |/
      `.   |              \       _,-'           |       ''
        `._'               \   '"\                .      |
           |                '     \                `._  ,'
           |                 '     \                 .'|
           |                 .      \                | |
           |                 |       L              ,' |
           `                 |       |             /   '
            \                |       |           ,'   /
          ,' \               |  _.._ ,-..___,..-'    ,'
         /     .             .      `!             ,j'
        /       `.          /        .           .'/
       .          `.       /         |        _.'.'
        `.          7`'---'          |------"'_.'
       _,.`,_     _'                ,''-----"'
   _,-_    '       `.     .'      ,\
   -" /`.         _,'     | _  _  _.|
    ""--'---"""""'        `' '! |! /
                            `" " -' 
%}


%Matrices

A = [ [5, -2, 8, -7]; ...
      [12, 15, -14, -20];... 
      [8, 1, -3, -4];...
      [11, 18, 21, -3] ];

%Vector columna tranpuesto
B =  [5, -2, 8, -7]';

%Distitas formas de sacar inversa  de una matriz
A_inv1 = inv(A); 
A_inv2 = A^(-1);

%Formas de solución:
x1 = A_inv1*B; % Gauss Jordan
x2 = inv(A) *B; % Gauss Jordan
x3 = A^(-1)*B; % Gauss Jordan
x4 = A\B; % Gauss-Jordan hacia atrás, es el que vamos a usar
%La ultima es la forma más rápida!!!!

figure(666)
spy(A_inv1)


I = A\ A; % Matriz identidad
figure(333)
spy(I)
%Dependiendo de la precisión puede que quede o no como la identidad
N = 1e4;
b = rand(N);
c = rand(N,1);
%{
disp('b_inversa1 = b^(-1);');
tic;
b_inversa1 = b^(-1);
toc;
disp('b_inversa2 = inv(b);');
tic;
b_inversa2 = inv(b);
toc;
disp('b_inversa3 = b\b;');
tic;
b_inversa3 = b\b;
toc;
%}

%Soluciones 
disp(' y1 = b^(-1)*c;');
tic;
y1 = b^(-1)*c;
toc;

disp(' y2 = inv(b)*c;');

tic;
y2 = inv(b)*c;
toc;

disp(' y3 = b\c;');

tic;
y3 = b\c;
toc;

% Observando los tiempos con tic, toc nos damos cuenta que el tercer
% metodos es el más rapido
%Determinante
disp('D = det(b); ');
tic;
D = det(b);
toc;

delta1 = y3-y2;
delta2 = y3-y1;
figure(1);
plot(delta1, '.r');
hold on;
plot(delta2, '.b');
hold off;