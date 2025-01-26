%clase 17, 5 noviembre

clearvars;

%Se crea la geometria
R1 = 0.10;
x0 = 0.0;
y0 = 0.0;
C1 = [1;x0;y0;R1;0;0;0;0;0;0];

gd = C1;
ns = char('C1');
ns = ns';
sf = 'C1';
[dl, bt] = decsg(gd,sf,ns);
%..... Grafica de la composición.......
%{
figure(1);
pdegplot(dl,'EdgeLabels','on','FaceLabels','on');
axis equal  
%}

%Crea el objeto del modelo
model = createpde(); % es un objeto 
%Se ingresa la geometria 
geometryFromEdges(model,dl);

%Se resuelve la ecuación de Poisson ( espec. la ec. de Onda ) 
alpha = 5; % rapidez de la onda
specifyCoefficients(model,"m",1,"d",0,"c",alpha^2,"a",0,"f",0,"Face",1)

% Ojo que el m=1 me la hace dependiente del tiempo

applyBoundaryCondition(model,"dirichlet","Edge",1:4,"r",0,"h",1)

%Sea 

a = 0.05;
b = 1e-5;

f =@(x,y) a*exp((-x.^2 -y.^2)/b);
paso = 1e-4;
x = (-0.015:paso:0.015);
y = (-0.015:paso:0.015);
[X, Y] = meshgrid(x,y);

%{
figure(777)
surf(X,Y,f(X,Y), 'EdgeColor','none');
xlim([-0.1 0.1])
ylim([-0.1 0.1])
%}

u0 = @(location) a*exp((-(location.x).^2 -(location.y).^2)/b);
du0 = @(location) 0*(location.x + location.y);
%colocamos la condiciones iniciales
setInitialConditions(model,u0,du0);


%Crear la malla
mesh = generateMesh(model,Hmax=0.005); %Crea los triangulo con esa altura maxima
%Plotea la malla
%{
figure(2)
pdemesh(model);
%}

%Ahora para resolver la PDE
t = (0:0.001:0.25);
%Resuelve el sistema model
R = solvepde(model,t);
%Aca va algo
u = R.NodalSolution;%solución de los nodos
%umax = max(max(u));
%umin = min(min(u));


for i=1:size(t,2)
    pdeplot(mesh,XYData= u(:,i),ZData=u(:,i), ZStyle="continuous",Mesh="off")
    string = ['t =', num2str(t(i)),'s'];
    title(string)
    xlabel('x')
    ylabel('y')
    zlabel('z')
    zlim([-0.01 0.01])
    clim([-0.01 0.01])
    %M(i) = getframe;
    pause(0.001)
    %exportgraphics(gcf, 'membrana.gif', 'Append', true);

    
end

