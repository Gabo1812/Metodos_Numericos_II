 % Clase del 16/8/2024
 %Por Gabriel Alvarez derechos de Autor
%{
Marca de agua
                                           /
                        _,.------....___,.' ',.-.
                     ,-'          _,.--"        |
                   ,'         _.-'              .
                  /   ,     ,'                   `
                 .   /     /                     ``.
                 |  |     .                       \.\
       ____      |___._.  |       __               \ `.
     .'    `---""       ``"-.--"'`  \               .  \
    .  ,            __               `              |   .
    `,'         ,-"'  .               \             |    L
   ,'          '    _.'                -._          /    |
  ,`-.    ,".   `--'                      >.      ,'     |
 . .'\'   `-'       __    ,  ,-.         /  `.__.-      ,'
 ||:, .           ,'  ;  /  / \ `        `.    .      .'/
 j|:D  \          `--'  ' ,'_  . .         `.__, \   , /
/ L:_  |                 .  "' :_;                `.'.'
.    ""'                  """""'                    V
 `.                                 .    `.   _,..  `
   `,_   .    .                _,-'/    .. `,'   __  `
    ) \`._        ___....----"'  ,'   .'  \ |   '  \  .
   /   `. "`-.--"'         _,' ,'     `---' |    `./  |
  .   _  `""'--.._____..--"   ,             '         |
  | ." `. `-.                /-.           /          ,
  | `._.'    `,_            ;  /         ,'          .
 .'          /| `-.        . ,'         ,           ,
 '-.__ __ _,','    '`-..___;-...__   ,.'\ ____.___.'
 `"^--'..'   '-`-^-'"--    `-^-'`.''"""""`.,^.`.--'
%}
 %Sistemas Tridiagonales
%Matriz forma

%{

A = [
      [a ,  0,  0]; ...
      [0 ,  b,  0];... 
      [0 ,  0,  c]
 ];

%}

clearvars;
n = 10000;
%A = zeros(n,n);

%{
for i=1:n
    A(i,i) = rand(1); % Para llenar la diagonal
end

for i = 1:n-1
    A(i,i+1) = rand(1);%Diagonal Superior
    A(i+1,i) = rand(1);%Diagnoal inferior
end

%}

b = rand(n,1);

%{
disp('AI1  = A^(-1);')
tic;
AI1  = A^(-1);
toc;

disp('AI2  = inv(A);')
tic;
AI2  = inv(A);
toc;
%}

%Para solucionar 

%disp('x1  = A^(-1)*b;')
%tic;
%x1  = A^(-1)*b;
%toc;

%disp('x2  = inv(A)*b;')
%tic;
%x2  = inv(A)*b;
%toc;


%disp('x3  = A\b;')
%tic;
%x3  = A\b;
%toc;

%{
disp('D = det(A);')
tic;
D = det(A);
toc;
%}
%{
delta1 = x3-x2;
delta2 = x3-x1;
figure(1);
plot(delta1, '.r');
hold on;
plot(delta2, '.b');
hold off;
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Factorización A = LU
% Para factorizar una matriz en dos matrices, donde L es una matriz
% triangular inferior y U es una matriz triangular superior
% Ax = b ===> LUx = b
% Ux = L^(-1)*b = d, se resuelven las dos ecuaciones igualadas a d
% Y finalmente x = U^(-1)*d

%Usando x3, n, A y b anterior para el ejemplo.
A = gallery('lehmer',n);

disp('x3  = A\b;')
tic;
x3  = A\b;
toc;

disp('L U factorization');
tic;
[L, U] = lu(A); % Si no es triangonal hay que usar esto
d = L\b;
x2 = U\d;
toc;

delta = x2 -  x3;
figure(1);
plot(delta, '.r');

figure(2);
spy(L)

figure(3);
spy(U)


%%%%%%%%%%%%%%%%%%%%%%%%%%
%Factorización de Cholesky ====> A = U^T * U
% Si Ax = b ====> U^(T)*Ux = b ====> Ux = d y U^(T)*d = b ====> d = ( U^(T) )^(-1) * b
% x = U^(-1)*d


disp('Cholesky factorization');
tic;
U = chol(A);
d = U'\b;
x2 = U\d;
toc;


