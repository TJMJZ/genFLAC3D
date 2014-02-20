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
    XYZ =      [0,0,ZT;
               PX*PM,0,ZT;
               0,0,ZB;
               0,PY*PM,ZT];
end

%gen zone brick
if (strcmp(genType,'brick'))
    XYZ = [0,0,0;
          0,0,0;
          0,0,0];
end


end