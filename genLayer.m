function  genLayer(layerDepth,layerThickness,panelX,panelY,panelMulti,...
                layerMesh,layerRatio,layerName,layerNumber,genType)
%Generates Layer for Room and Pillar 
%   layerDepth = top coordination of rock seam

    XYZ = genLayerPoints(layerDepth,layerThickness,panelX,panelY,panelMulti,genType);
    
    
    if (strcmp(genType,'radtunnel') && panelMulti ~= 1)

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
    
    disp(sprintf(' '));
    disp(sprintf(';----------------------------------'));
    disp(sprintf(';;GENERATING LAYER %s (%i)',layerName,layerNumber));
    disp(sprintf(';----------------------------------'));
    disp(sprintf('gen zone brick &'));
    disp(sprintf('p0=(%0.2f %2.1f %2.1f) &',X0,Y0,Z0));
    disp(sprintf('p1=(%0.2f %2.1f %2.1f) &',X1,Y1,Z1));
    disp(sprintf('p2=(%0.2f %2.1f %2.1f) &',X2,Y2,Z2));
    disp(sprintf('size %i %i %i %i &',layerMesh(1),layerMesh(2),layerMesh(3),layerMesh(4)));
    
    end
end

