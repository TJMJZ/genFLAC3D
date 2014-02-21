function createLayer()
% CREATE LAYERS

load LayerDataFile
load panelDataFile
load initialDataFile

rockLayerCounter    = 0;
interfaceLayerCount  = 0;
%GENERATE MAIN ROOF LAYERS

mainRoof  = [lDepth(1),max(panelX,panelY)*panelMulti];   %,'mainRoof',0]
genLayer(mainRoof(1),mainRoof(2),panelX,panelY,panelMulti,...
    mainMesh,mainRatio,'mainRoof',0,genType)
disp(sprintf('gen zone reflect origin 0,0,%2.1f normal 0,0,-1',mainRoof(1)))
disp(sprintf('del zone range z %2.1f %2.1f',mainRoof(1),mainRoof(1)-panelMulti*max(panelX,panelY)));

%GENERATE ROCK LAYERS
for i=1:size(lType,1)
    if lType(i) == 1
        rockLayerCounter = rockLayerCounter +1;
        genLayer(lDepth(i),lThickness(i),panelX,panelY,panelMulti,...
            layerMesh,layerRatio,cell2mat(lName(i)),rockLayerCounter,genType);
    else if lType(i) == 2
            %interfaceLayerCount = interfaceLayerCount +1;
            %genInterfaceLayer(lDepth(i),panelX,panelY,...
            %lPar1(i),lPar2(i),lPar3(i),lPar4(i),lPar5(i),cell2mat(lName(i)),...
            %interfaceLayerCount);
        end
    end
end
%GENERATE MAIN FLOOR LAYERS
mainFloor = [lDepth(end),max(panelX,panelY)*panelMulti,panelX,panelY]; %,'mainFloor',0]
genLayer(mainFloor(1),mainFloor(2),mainFloor(3),mainFloor(4),panelMulti,...
    mainMesh,mainRatio,'mainFloor',0,genType)

%GENERATE REFLECTION (X and Y)
disp(sprintf('gen zone reflect origin 0,0,0 normal 0,-1,0'));
disp(sprintf('gen zone reflect origin 0,0,0 normal -1,0,0'));
end

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
    
    disp(sprintf(' '));
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
    
    elseif (strcmp(genType,'brick'))
        
    X0=XYZ(1,1);Y0=XYZ(1,2);Z0=XYZ(1,3);
    X1=XYZ(2,1);Y1=XYZ(2,2);Z1=XYZ(2,3);
    X2=XYZ(3,1);Y2=XYZ(3,2);Z2=XYZ(3,3);
    X3=XYZ(4,1);Y3=XYZ(4,2);Z3=XYZ(4,3);
    
    disp(sprintf(' '));
    disp(sprintf(';----------------------------------'));
    disp(sprintf(';;GENERATING LAYER %s (%i)',layerName,layerNumber));
    disp(sprintf(';----------------------------------'));
    disp(sprintf('gen zone brick &'));
    disp(sprintf('p0=(%0.2f %2.1f %2.1f) &',X0,Y0,Z0));
    disp(sprintf('p1=(%0.2f %2.1f %2.1f) &',X1,Y1,Z1));
    disp(sprintf('p2=(%0.2f %2.1f %2.1f) &',X2,Y2,Z2));
    disp(sprintf('p3=(%0.2f %2.1f %2.1f) &',X3,Y3,Z3));
    disp(sprintf('size %i %i %i',layerMesh(1),layerMesh(2),layerMesh(3)));
    
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
