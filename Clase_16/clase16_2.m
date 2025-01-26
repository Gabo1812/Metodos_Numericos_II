%
clearvars;
%Se carga la geometria step
gm = fegeometry("disipador_01.step");
figure(1)
pdegplot(gm, FaceLabels="on",FaceAlpha=0.5);
%..........Crea el objeto del modelo.........
model = createpde();
importGeometry(model,'disipador_01.step');
%............
%Se ingresan los coeficientes para resolver el problema
% La ecuación a resolver en este caso es: 
% m*d^2U/dt^2 + d*dU/dt -Nabla(c*Nabla(U)) + a*U = f
%Difusividad termica del aluminio
%Para este caso, m=0, d=1, c = alpha, a=0, f=0
alpha= 97e-6;%m^2/s
epsilon_0 = 8.85e-12;
specifyCoefficients(model, 'm',0,'d',1,'c',alpha,'a',0,'f',0);

%Aplica las condiciones de Dirchilet
% h*u = r
T0 = 50; % grados, temp. cara plana
applyBoundaryCondition(model,"dirichlet", 'Face',18, 'r',T0,'h',1);

%Aplica condiciones de Neumann
% n*(c x nabla(u)) + q*u = g
applyBoundaryCondition(model,"neumann","Face",1:17,"g",0,"q",0)
applyBoundaryCondition(model,"neumann","Face",19:34,"g",0,"q",0)
T_inicial = 0;
setInitialConditions(model,T_inicial)
%.....Crear la malla.....
mesh = generateMesh(model,Hmax=0.005);
%Graficar la malla
figure(2)
pdemesh(mesh,'FaceAlpha',0.2);
t = (0:0.1:20);
%Resuelve el sistema model
R = solvepde(model,t);
U = R.NodalSolution;%solución de los nodos
for i=1:size(t,2)
    %Graficar en 3D de evolución temporal
    figure(3)
    pdeplot3D(mesh, ColorMapData=R.NodalSolution(:,i),FaceAlpha=0.7);
    axis equal
    xlabel('x(m)')
    ylabel('y(m)')
    zlabel('z(m)')
    pause(0.05)
end