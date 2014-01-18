function XYZ = genInterfaceLayerXYZ(LD,PX,PY)

        % This function generates the XYZ coordinate of brick element
        % based on the input values layerDepth,layerThickness and
        % MAX_LENGHTH
        % LD = LAYER DEPTH (USE NEGETIVE NUMBER)
        % LT = LAYER THICKNESS (USES POSITIVE NUMBERS)
        % PX = PANEL LENGTH (PARALLEL TO CROSSCUT)  
        % PY = PANEL WIDTH  (PERPENDICULAR TO CROSSCUT)
        
        % check error ZB must be smaller than ZT
        
        
        XYZ =      [0,0,0;
                    0,0,0;
                    0,0,0;
                    0,0,0];