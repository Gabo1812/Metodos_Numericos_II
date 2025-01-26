%Clase 15
%Elemento finito 
%Se crea la geometria 
%Ej: Circulo
% Radio del circulo
R =0.05; %m
%Posición del centro del circulo
x0 = 0;
y0 = 0;
C1 = [1;x0;y0;R;0;0;0;0;0;0];
%Donde:
%Primer numero, sig. que es un circulo
%Segundo y tercer numero, el centro
%Cuarto numero el radio del circulo
%...........................
%{
gd = C1;
ns = char('C1'); %funciona como etiqueta
ns = ns';
sf = 'C1';
[dl, bt] = decsg(gd,sf,ns); % decomposition geometry
%Donde dl es una matriz y bt es la region

%..... Grafica de la composición

figure(1);
pdegplot(dl,'EdgeLabels','on','FaceLabels','on');
axis equal
%}

%Como armar un rectangulo o cuadrado
L = 0.5;
H = 0.5;
%R1 = [3;4;0;L;L;0;0;0;H;H]; %sin centrar
R1 = [3;4;-L/2;L/2;L/2;-L/2;-H/2;-H/2;H/2;H/2]; %centrado
%Donde:
%Primer numero, sig. que es un rectangulo
%Los demás me delimitan la figura
%figura = [tipo_Fig;#lados;x1;x2;x3;x4;y1;y2;y3;y4]
gd = [C1,R1];
ns = char('C1','R1'); %funciona como etiqueta
ns = ns';
sf = 'C1+R1';
[dl, bt] = decsg(gd,sf,ns); % decomposition geometry
%Donde dl es una matriz y bt es la region
%..... Grafica de la composición.......
figure(1);
pdegplot(dl,'EdgeLabels','on','FaceLabels','on');
axis equal

%Crea el objeto del modelo
model = createpde(); % es un objeto 
%Se ingresa la geometria 
geometryFromEdges(model,dl);
% En este caso estaremos resolviendo la ecuación de Laplace
% m*ddU/

epsilon_r = 1;
epsilon_0 = 8.85e-12;
epsilon = epsilon_0*epsilon_r;

specifyCoefficients(model,'m',0,'d',0,'c',epsilon,'a',0,'f',0,'Face',1);

%Para aplicar las condiciones de Dirichlet
%h*u = r
v0 = 100; %voltios
applyBoundaryCondition(model,"dirichlet","Edge",5:8,'r',v0,'h',1);
vl = 0;
applyBoundaryCondition(model,"dirichlet","Edge",1:4,'r',vl,'h',1);

%Crear la malla
mesh = generateMesh(model,Hmax=0.05); %Crea los triangulo con esa altura maxima
%Plotea la malla
figure(2)
pdemesh(model);
%Ahora para resolver la PDE
R = solvepde(model);
%...
U = R.NodalSolution; %Solución U de los nodos
%Se grafica en 2D
figure(3)
pdeplot(mesh,XYData=U,FaceAlpha=1,ColorMap='jet',ColorBar='on',Mesh='on');
axis equal
xlabel('x(m)');
ylabel('y(m)');

%Se grafica en 3D
figure(4)
pdeplot(mesh,XYData=U,ZData=U,FaceAlpha=1,ColorMap='jet',ColorBar='on',Mesh='off');
%axis equal
xlabel('x(m)');
ylabel('y(m)');
zlabel('volts')