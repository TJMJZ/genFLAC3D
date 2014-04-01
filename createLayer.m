function createLayer()
% other functions 
% genLayer(layerDepth,layerThickness,panelX,panelY,panelMulti,layerMesh,layerRatio,layerName,layerNumber,genType)
load inputDataFile.mat

if outputType == 0
diary('./Output/gen.f3dat')
else
diary('./Output/single.f3dat')
end

% CREATE LAYERS
disp(sprintf(' '));
disp(sprintf(';>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> '));
disp(sprintf(';>>>>>>>>>>>>>>>>>ROCK LAYERS >>>>>>>>>>>>>>>>>> '));
disp(sprintf(';>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> '));
rockLayerCounter    = 0;
interfaceCount  = 0;

%GENERATE MAIN ROOF LAYERS
if lThickness(1) <= 0 
    mainRoof  = [lDepth(1),max(panelX,panelY)*panelMulti];
else 
    mainRoof  = [lDepth(1),lThickness(1)];
end

genLayer(mainRoof(1),mainRoof(2),panelX,panelY,panelMulti,mainMesh,mainRatio,'mainRoof',0,genType)

%Reflecting Model
disp(sprintf(';only way to make z ratio be applied correctly')) 
disp(sprintf(';z ratio can be disabled in layerRatio in Initial Parameters'))
disp(sprintf('gen zone reflect origin 0,0,%2.1f normal 0,0,-1',mainRoof(1)))
disp(sprintf('del zone range z %2.1f %2.1f',mainRoof(1),mainRoof(1)-panelMulti*max(panelX,panelY)));
disp(sprintf(' '));


%GENERATE ROCK LAYERS
for i=1:size(lType,1)
    if lType(i) == 1
        rockLayerCounter = rockLayerCounter +1;
        disp(sprintf(';layer creater -%i below actual',rockLayerCounter));
        genLayer(lDepth(i)-rockLayerCounter,lThickness(i),panelX,panelY,panelMulti,layerMesh,layerRatio,cell2mat(lName(i)),rockLayerCounter,genType);   
    else if lType(i) == 2
        %donothing
        end
    end
end

%GENERATE MAIN FLOOR LAYERS
rockLayerCounter = rockLayerCounter +1;
disp(sprintf(';layer creater -%i below actual',rockLayerCounter));
if lThickness(end) <= 0
    mainFloor = [lDepth(end)-rockLayerCounter,max(panelX,panelY)*panelMulti,panelX,panelY]; 
else 
    mainFloor = [lDepth(end)-rockLayerCounter,lTickness(end),panelX,panelY]; 
end
genLayer(mainFloor(1),mainFloor(2),mainFloor(3),mainFloor(4),panelMulti,mainMesh,mainRatio,'mainFloor',0,genType)

%GENERATE REFLECTION (X and Y)
disp(sprintf('gen zone reflect origin 0,0,0 normal 0,-1,0'));
disp(sprintf('gen zone reflect origin 0,0,0 normal -1,0,0'));
disp(sprintf(' '));


disp(sprintf(';>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> '));
disp(sprintf(';>>>>>>>>>>>>>>>>> INTERFACE >>>>>>>>>>>>>>>>>>> '));
disp(sprintf(';>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> '));

rockLayerCounter    = 0;
interfaceCount  = 0;

for i=1:size(lType,1)
    if lType(i) == 1
        rockLayerCounter = rockLayerCounter +1;
        disp(sprintf(';LAYER WAS CREATED  -%i BELOW ACTUAL DEPTH',rockLayerCounter));
        disp(sprintf('ini z add %i range z %2.1f %2.1f ',rockLayerCounter,lDepth(i)-rockLayerCounter+0.1,lDepth(i)-rockLayerCounter-lThickness(i)-0.1))
    else if lType(i) == 2
            interfaceCount = interfaceCount +1;
        genInterfaceLayer(lDepth(i),panelX,panelY,...
              lPar1(i),lPar2(i),lPar3(i),lPar4(i),lPar5(i),cell2mat(lName(i)),interfaceCount);
        end
    end
end

%GENERATE MAIN FLOOR INTERFACE
rockLayerCounter = rockLayerCounter +1;
disp(sprintf(';MOVING MAIN FLOOR - WAS CREATED -%i BELOW ACTUAL DEPTH',rockLayerCounter));
disp(sprintf('ini z add %i range z %2.1f %2.1f ',rockLayerCounter,lDepth(end)-rockLayerCounter+0.1,lDepth(end)-rockLayerCounter-mainFloor(2)-0.1))

disp(sprintf(' '));
disp(sprintf('; '));



disp(sprintf(';FISH to loop through all gridpoints on interfaces and replace with cohesion/friction functions'));

disp(sprintf(';def intprop'));
disp(sprintf(';while_stepping'));
disp(sprintf(';local _i = i_head'));
disp(sprintf(';loop while _i # null ; loop through all interfaces'));
disp(sprintf(';  local _in = i_node_head(_i)'));
disp(sprintf(';  loop while _in # null ; loop through all nodes on this interface'));
disp(sprintf(';local _nstress = in_nstr(_in) ; see page 2-99 FISH Reference'));
disp(sprintf(';if _nstress < = 72000  then'));
disp(sprintf(';        in_prop(_in, ''cohesion'') = 21600'));
disp(sprintf(';        in_prop(_in, ''friction'') = 20'));
disp(sprintf(';endif'));
disp(sprintf(';if _nstress > 72000  then'));
disp(sprintf(';    in_prop(_in, ''cohesion'')= 47805.86'));
disp(sprintf(';    in_prop(_in, ''friction'')= 0'))
disp(sprintf(';endif'));
disp(sprintf(';    _in = in_next(_in)'));
disp(sprintf(';  endloop'));
disp(sprintf(';  _i = i_next(_i)'));
disp(sprintf(';endloop'));
disp(sprintf(';end'));
end %function creareLayer()




function  genLayer(layerDepth,layerThickness,panelX,panelY,panelMulti,...
                layerMesh,layerRatio,layerName,layerNumber,genType)
%Generates Layer for Room and Pillar 
%   layerDepth = top coordination of rock seam

    XYZ = genLayerPoints(layerDepth,layerThickness,panelX,panelY,panelMulti,genType);
    
    
    if (strcmp(genType,'radtunnel'))

    X0=XYZ(1,1);Y0=XYZ(1,2);Z0=XYZ(1,3);
    X1=XYZ(2,1);Y1=XYZ(2,2);Z1=XYZ(2,3);
    X2=XYZ(3,1);Y2=XYZ(3,2);Z2=XYZ(3,3);
    X3=XYZ(4,1);Y3=XYZ(4,2);Z3=XYZ(4,3);
    
    disp(sprintf(';----------------------------------'));
    disp(sprintf(';;GENERATING LAYER %s (%i)',layerName,layerNumber));
    disp(sprintf(';----------------------------------'));
    disp(sprintf('gen zone radtunnel &'));
    disp(sprintf('p0=(%0.2f %2.1f %2.1f) &',X0,Y0,Z0));
    disp(sprintf('p1=(%0.2f %2.1f %2.1f) &',X1,Y1,Z1));
    disp(sprintf('p2=(%0.2f %2.1f %2.1f) &',X2,Y2,Z2));
    disp(sprintf('p3=(%0.2f %2.1f %2.1f) &',X3,Y3,Z3));
    disp(sprintf('size %i %i %i %i &',layerMesh(1),layerMesh(2),layerMesh(3),layerMesh(4)));
    disp(sprintf('ratio %0.2f %2.1f %2.1f %2.1f &',layerRatio(1),layerRatio(2),layerRatio(3),layerRatio(4)));
    disp(sprintf('dim %2.1f %2.1f fill',panelX,panelY));
    disp(sprintf(' '));
    disp(sprintf(' '));
    
    elseif (strcmp(genType,'brick'))
        
    X0=XYZ(1,1);Y0=XYZ(1,2);Z0=XYZ(1,3);
    X1=XYZ(2,1);Y1=XYZ(2,2);Z1=XYZ(2,3);
    X2=XYZ(3,1);Y2=XYZ(3,2);Z2=XYZ(3,3);
    X3=XYZ(4,1);Y3=XYZ(4,2);Z3=XYZ(4,3);
    
    disp(sprintf(';----------------------------------'));
    disp(sprintf(';;GENERATING LAYER %s (%i)',layerName,layerNumber));
    disp(sprintf(';----------------------------------'));
    disp(sprintf('gen zone brick &'));
    disp(sprintf('p0=(%0.2f %2.1f %2.1f) &',X0,Y0,Z0));
    disp(sprintf('p1=(%0.2f %2.1f %2.1f) &',X1,Y1,Z1));
    disp(sprintf('p2=(%0.2f %2.1f %2.1f) &',X2,Y2,Z2));
    disp(sprintf('p3=(%0.2f %2.1f %2.1f) &',X3,Y3,Z3));
    disp(sprintf('size %i %i %i',layerMesh(1),layerMesh(2),layerMesh(3)));
    disp(sprintf(' '));
    end
end


function XYZ = genLayerPoints(LD,LT,PX,PY,PM,genType)

% This function generates the XYZ coordinate of diffrent element
% based on the input values layerDepth,layerThickness,panelX
% panelY, panelMulti
% LD = LAYER DEPTH (USE NEGETIVE NUMBER)
% LT = LAYER THICKNESS (USES POSITIVE NUMBERS)
% PX = PANEL LENGTH (PARALLEL TO CROSSCUT)  
% PY = PANEL WIDTH  (PERPENDICULAR TO CROSSCUT)
% PM = PANEL MULTI

% check error ZB must be smaller than ZT
ZB = LD - LT;       %Z coordinate for botom gp
ZT = LD;            %Z coordinate for top gp
if (ZB >= ZT)
error('ERROR:invalid Layers')    
end

% gen zone radtunnel
if (strcmp(genType,'radtunnel') && PM ~= 1)
    XYZ =      [0       ,0      ,ZT;
               PX*PM    ,0      ,ZT;
               0        ,0      ,ZB;
               0        ,PY*PM  ,ZT];
end

%gen zone brick
if (strcmp(genType,'brick'))
    XYZ = [0    ,0      ,ZB;    %P0
          PX*PM ,0      ,ZB;    %P1
          0     ,PY*PM  ,ZB;    %P2
          0     ,0      ,ZT];   %P3
end


end


function  genInterfaceLayer( layerDepth,panelX,PanelY,...
                lPar1,lPar2,lPar3,lPar4,lPar5,layerName,layerNumber)
%Generates Interface Layer in layerDepth 
%   Detailed explanation goes here

    diary('./Output/gen.f3dat')
    diary on
    disp(sprintf(';----------------------------------'));
    disp(sprintf(';;GENERATING INTERFACE LAYER %s (%i) ',layerName,layerNumber));
    disp(sprintf(';----------------------------------'));
    %P = sum(lPar1,lPar2,lPar3,lPar4,lPar5)
    %disp(sprintf('group layer%.0f fill group layer%.0f',layerNumber,layerNumber));
    %disp(sprintf('gen zone reflect origin 0,0,0 normal -1,0,0 range group layer%.0f',layerNumber));
    disp(sprintf('interface %i face range plane norm (0,0,-1) origin (0,0,%2.1f) dist 0.1',layerNumber,layerDepth));
    disp(sprintf('interface %i prop tens %2.1f ks %2.1f fri %2.1f cohesion %2.1f kn %2.1f',layerNumber,lPar3,lPar2,lPar5,lPar4,lPar1));
    disp(sprintf('interface %i effective=off',layerNumber));
    disp(sprintf(' '));
end





