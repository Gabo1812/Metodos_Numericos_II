%Clase 18, 8/11/2024

clearvars;
R1 = 0.02; %m radio del circulo
%Posición del circulo
x0 = 0;
y0 = 0;
C1 = [1;x0;y0;R1;0;0;0;0;0;0];

R2 = 15*0.02; %m radio del circulo
%Posición del circulo
x0 = 0;
y0 = 0;
C2 = [1;x0;y0;R2;0;0;0;0;0;0];

R3 = 0.02; %m radio del circulo
%Posición del circulo
x0 = 0.2;
y0 = 0;
C3 = [1;x0;y0;R3;0;0;0;0;0;0];

gd = [C1,C2,C3];
ns = char('C1','C2','C3'); %funciona como etiqueta
ns = ns';
sf = 'C1+C2+C3';
[dl, bt] = decsg(gd,sf,ns); % decomposition geometry
%Donde dl es una matriz y bt es la region
%..... Grafica de la composición.......
figure(1);
pdegplot(dl,'EdgeLabels','on','FaceLabels','on');
axis equal

%Crea el objeto del modelo
model = femodel(AnalysisType="magnetostatic",Geometry=dl); % es un objeto 

mu_0 = 4*pi*1e-7;
model.VacuumPermeability = mu_0;
model.MaterialProperties(1) = materialProperties(RelativePermeability=1);
model.MaterialProperties(2) = materialProperties(RelativePermeability=1);
model.MaterialProperties(3) = materialProperties(RelativePermeability=5000);
%El indice es para que le asigne al dominio que quiero

%Definir la densidad de corriente de cada face
I = 10.0; %A
A = pi*R1^2; %Area en m^2
J = I/A; %densidad de corriente

model.FaceLoad(2) = faceLoad("CurrentDensity",J);
model.FaceLoad(1) = faceLoad("CurrentDensity",0);
model.FaceLoad(3) = faceLoad("CurrentDensity",0);
%Aplicando las cond. de frontera
model.EdgeBC(5:8) = edgeBC("MagneticPotential",0);
%Crear la malla
model = generateMesh(model,"Hmax",0.005); %Crea los triangulo con esa altura maxima
%Plotea la malla
figure(2)
pdemesh(model);
%Ahora para resolver la PDE
R = solve(model);
%Se grafica la solución en 2D
figure(3)
pdeplot(R.Mesh, XYData=R.MagneticPotential,FlowData=[R.MagneticField.Hx ...
    R.MagneticField.Hy],FaceAlpha=1,ColorMap='jet', ColorBar='on',Mesh='off')
axis equal
xlabel('x')
ylabel('y')