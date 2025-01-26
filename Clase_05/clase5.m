 % Clase del 27/8/2024
 %Por Gabriel Alvarez derechos de Autor
%{
Marca de agua
     __                                _.--'"7
    `. `--._                        ,-'_,-  ,'
     ,'  `-.`-.                   /' .'    ,|
     `.     `. `-     __...___   /  /     - j
       `.     `  `.-""        " .  /       /
         \     /                ` /       /
          \   /                         ,'
          '._'_               ,-'       |
             | \            ,|  |   ...-'
             || `         ,|_|  |   | `             _..__
            /|| |          | |  |   |  \  _,_    .-"     `-.
           | '.-'          |_|_,' __!  | /|  |  /           \
   ,-...___ .=                  ._..'  /`.| ,`,.      _,.._ |
  |   |,.. \     '  `'        ____,  ,' `--','  |    /      |
 ,`-..'  _)  .`-..___,---'_...._/  .'      '-...'   |      /
'.__' ""'      `.,------'"'      ,/            ,     `.._.' `.
  `.             | `--........,-'.            .         \     \
    `-.          .   '.,--""     |           ,'\        |      .
       `.       /     |          L          ,\  .       |  .,---.
         `._   '      |           \        /  .  L      | /   __ `.
            `-.       |            `._   ,    l   .    j |   '  `. .
              |       |               `"' |  .    |   /  '      .' |
              |       |                   j  |    |  /  , `.__,'   |
              `.      L                 _.   `    j ,'-'           |
               |`"---..\._______,...,--' |   |   /|'      /        j
               '       |                 |   .  / |      '        /
                .      .              ____L   \'  j    -',       /
               / `.     .          _,"     \   | /  ,-','      ,'
              /    `.  ,'`-._     /         \  i'.,'_,'      .'
             .       `.      `-..'             |_,-'      _.'
             |         `._      |            ''/      _,-'
             |            '-..._\             `__,.--'
            ,'           ,' `-.._`.            .
           `.    __      |       "'`.          |
             `-"'  `""""'            7         `.
                                    `---'--.,'"`'
%}
clearvars;
N = 100;
%Clase sobre jacobianos
%Ejemplo:
% Sea y'' = y'*cos(x)-y*log(y)
%Con las siguientes condiciones iniciales:
a=0;
b = pi/2;
y0 = 1;
yN = exp(1);
%Derivadas
%Respecto a y
fy = @(y) -log(y)-1;
%Respecto a y'
fyp = @(x) cos(x);

h = (b-a)/(N+1);
x = (a:h:b)';
tol = 1e-10;

%Metodo de Newton-Raphson ====> vect(J)*v = vect(F)

%................................................
% Se crea la matriz Jacobiana, F y y
%................................................
J = zeros(N,N);
F = zeros(N,1);
y = 0.5*ones(N,1);
% El 0.5 es porque se busca un valor dentro del intervalo [a, b]
%................................
% Para llenar la matriz Jacobiana
%................................

for k = 1:N
    for i=1:N
        J(i,i) = 2+h^2*fy(x(i+1));% Llena la diagonal   
    end
    for i=1:N-1
        J(i,i+1) = -1+(h/2)*fyp(x(i+1)); % Diagonal sup.
        J(i+1,i) = -1-(h/2)*fyp(x(i+1)); % Diagonal inf.
    end

%...............................
% Ahora se llena el vector F
%...............................

    F(1) = -y0+2*y(1)-y(2)+h^2*(((y(1)-y0)/(2*h))*cos(x(1))-y(1)*log(y(1)));
    for i=2:N-1
        F(i) = -y(i-1)+2*y(i)-y(i+1)+h^2*(((y(i+1)-y(i-1))/(2*h))*cos(x(i))-y(i)*log(y(i)))  ;
    end
    F(N) = -y(N-1)+2*y(N)-yN+h^2*(((yN-y(N-1))/(2*h))*cos(x(N))-y(N)*log(y(N)));
    v = J\(-F);
    y = y+v;
    if sqrt(dot(v,v))<=tol
        break;
    end
    yt = [y0;y;yN];
    figure(1);
    plot(x,yt,'ob')
    pause(1)
end
