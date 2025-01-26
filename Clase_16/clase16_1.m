%
clearvars;
%Se carga la geometria step
gm = fegeometry("capacitor_disco.step");
figure(1)
pdegplot(gm, FaceLabels="on",FaceAlpha=0.5);
%..........Crea el objeto del modelo.........
model = createpde();
importGeometry(model,'capacitor_disco.step');
%............
%Se ingresan los coeficientes para resolver el problema
%
epsilon_0 = 8.85e-12;
specifyCoefficients(model, 'm',0,'d',0,'c',epsilon_0,'a',0,'f',0);

%Aplica las condiciones de Dirchilet
% h*u = r
V1 = 100; % volts
applyBoundaryCondition(model,"dirichlet", 'Face',7:9, 'r',V1,'h',1);
applyBoundaryCondition(model,"dirichlet", 'Face',4:6, 'r',- V1,'h',1);
%Aplica condiciones de Neumann
% n*(c x nabla(u)) + q*u = g
applyBoundaryCondition(model,"neumann","Face",1:3,"g",0,"q",0)
%.....Crear la malla.....
mesh = generateMesh(model,Hmax=0.005);

%Graficar la malla
figure(2)
pdemesh(mesh,'FaceAlpha',0.2);

%Resuelve el sistema model
R = solvepde(model);
U = R.NodalSolution;%solución de los nodos

%Graficar en 3D
figure(3)
pdeplot3D(mesh, ColorMapData=U,FaceAlpha=0.7);
axis equal
xlabel('x(m)')
ylabel('y(m)')
zlabel('z(m)')

%Gradiente
Ex = -R.XGradients;
Ey = -R.YGradients;
Ez = -R.ZGradients;
figure(4)
pdeplot3D(mesh,FlowData=[Ex,Ey,Ez]);
hold on;
pdegplot(gm,FaceLabels='off',FaceAlpha=0.5);
hold off;
axis equal
xlabel('x(m)')
ylabel('y(m)')
zlabel('z(m)')
