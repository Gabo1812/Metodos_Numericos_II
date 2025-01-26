%clase 11:
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
%Metodo Implicito 
%Dominio
xi = 0.00;
xf = 0.10;
ti = 0;
tf = 10.0;
%..............Cond. de Frontera..........
Txi = 70;
Txf = 20;
%.....................
%Particiones
n = 1000;
m = 500;
%.....................
h = (xf-xi)/n;
k = (tf-ti)/m;

x = (xi:h:xf)';
t = (ti:k:tf)';
%.................Difusividad térmica.................
a = 1200e-6; %m2/s grafito
%a = 111e-6 %CU
%a = 40e-6 % Sn
%.............Matrix coefficients............
r = a*k/h^2;

% fill the matrix

A = zeros(n-1,n-1);

for i=1:n-1
    A(i,i) = (1+2*r);
end

for i=1:n-2
    A(i,i+1) = -r;
    A(i+1,i) = -r;
end
% Se invierte la matriz
B = inv(A);

%{
figure(3)
h3 = surf(B);
colormap turbo;
h3.EdgeColor = "none";
%}

%Condicion inicial
%T0 =@(x) -1000.*x-100;
T0 =@(x) 0*ones(size(x,1)-2,1);% Deja AFUERA EL PRIMERO Y EL ULTIMO
%Resolver para cada paso temporal
%{
figure(4)
area(x,[Txi;T0;Txf], 'FaceColor','r');
xlabel('L(m)');
ylabel('T(C)');
ylim([0 100]);
%}

%Tt=0;
Tt = T0(x);
for j=1:m
    Tt(1) = Tt(1) + r*Txi;
    Tt(end) = Tt(end) + r*Txf;
    T = B*Tt;
    area(x,[Txi;T;Txf], 'FaceColor','r');
    %area(x,[Txi;T0(x);Txf], 'FaceColor','r');
    ylim([0 100]);
    str = ['t=',num2str(t(j)),'s'];
    text(0.05,95,str);
    Tt= T;
    pause(0.001);
end