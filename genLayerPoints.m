function XYZ = genLayerPoints(LD,LT,PX,PY,PM)

        % This function generates the XYZ coordinate of brick element
        % based on the input values layerDepth,layerThickness and
        % MAX_LENGHTH
        % LD = LAYER DEPTH (USE NEGETIVE NUMBER)
        % LT = LAYER THICKNESS (USES POSITIVE NUMBERS)
        % PX = PANEL LENGTH (PARALLEL TO CROSSCUT)  
        % PY = PANEL WIDTH  (PERPENDICULAR TO CROSSCUT)
        % PM = PANEL MULTI 
        % check error ZB must be smaller than ZT
        ZB = LD - LT;
        ZT = LD; 
        
        XYZ =      [0,0,ZT;
                    PX*PM,0,ZT;
                    0,0,ZB;
                    0,PY*PM,ZT];