% Radio del circulo
R =0.05; %m
%Posición del centro del circulo
% rectangulo  1
L = 0.20;
H = 0.20;
Rec1 = [3;4;-L/2;L/2;L/2;-L/2;-H/2;-H/2;H/2;H/2];
% Circulo 1
x0 = -0.04;
y0 = 0;
R1 = 0.015;
C1 = [1;x0;y0;R1;0;0;0;0;0;0];
gd = [Rec1,C1];
ns = char('Rec1','C1');
ns = ns';
sf = 'Rec1-C1'; % el circulo es solido dado que es una cond de dirichlet
[dl,bt] = decsg(gd,sf,ns);
figure(1);
pdegplot(dl, 'EdgeLabels','on','FaceLabels','on');
axis equal

% crear le objeto del modelo 
model = createpde();
geometryFromEdges(model,dl);

% ec a resolver
% m*d^2U/dt^2 + d*dU/dt - Nabla.(c*Nabla U) + aU = f
alpha = 1; % rapidez de la onda en ese medio 
% coeficientes de dominio 
specifyCoefficients(model,'m',1,'d',0,'c',alpha^2, 'a',0,'f',0,'Face',1);

% Aplicar condiciones de Dirichlet
applyBoundaryCondition(model,'dirichlet','Edge',[2,4,5,6,7,8],'r',0,'h',1);

applyBoundaryCondition(model, 'neumann','Edge',[1,3],'g',0,'q',0);

a = -0.05;
b = 1e-5;
xp = 0.04;
%{
f = @(x,y) a*exp((-x.^2-y.^2)/b);
x = (-0.015:1e-4:0.015);
y = (-0.015:1e-4:0.015);
[X,Y] = meshgrid(x,y);

figure(777);
surf(X,Y,f(X,Y),'EdgeColor','none');
xlim([-0.1 0.1]);
ylim([-0.1 0.1]);
%view(2); % ver desde arriba
%}

u0 = @(location) a*exp((-(location.x-xp).^2-(location.y).^2)/b);
du0 = @(location) 0*(location.x+location.y);

setInitialConditions(model,u0,du0);

% Crear la malla
mesh = generateMesh(model,Hmax=0.005);

%graficar el mesh y ver la calidad
figure(2);
pdemesh(model,"FaceAlpha",0.2);

% Resolver el sistema model y crear un objeto con la solucion

t = (0:0.001:0.25);
R = solvepde(model,t);
u = R.NodalSolution;

% graficar la solucion en 3D
umax = max(max(u));
umin = min(min(u));
HF = figure(3);
for i=1:size(t,2)
    pdeplot(mesh,XYData=u(:,i),ZData=u(:,i),ZStyle='continuous',Mesh='off', ColorMap='jet');
    string = ['t =', num2str(t(i)),'s'];
    title(string);
    axis equal
    xlabel('x(m)');
    ylabel('y(m)');
    zlabel('z(m)');
    zlim([-0.01 0.02]);
    clim([-0.01, 0.01]);
    %M(i) = getframe;
    pause(0.001);
    %exportgraphics(gcf,'membrana.gif', 'Append',true); % Append que se
    %repita en bucle
end

%figure(4);
%movie(M,5,20);
%}