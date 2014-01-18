function  genLayer( layerDepth,layerThickness,panelX,panelY,panelMulti,...
                layerMesh,layerRatio,layerName,layerNumber)
%Generates Layer for Room and Pillar 
%   layerDepth = top coordination of rock seam

    XYZ = genLayerPoints(layerDepth,layerThickness,panelX,panelY,panelMulti);
    
    X0=XYZ(1,1);Y0=XYZ(1,2);Z0=XYZ(1,3);
    X1=XYZ(2,1);Y1=XYZ(2,2);Z1=XYZ(2,3);
    X2=XYZ(3,1);Y2=XYZ(3,2);Z2=XYZ(3,3);
    X3=XYZ(4,1);Y3=XYZ(4,2);Z3=XYZ(4,3);
    
    diary('./Output/gen.f3dat')
    diary on
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

    
    %if layerNumber == 1
    %    disp(sprintf('group zone layer%i',layerNumber));
    %else 
    %    disp(sprintf('group zone layer%i range &',layerNumber));
    %    layerCounter = layerNumber -1;
    %    for i = layerCounter:-1:2
    %    disp(sprintf(' group layer%i not &',i));
    %    end
    %    disp(sprintf(' group layer1 not'));
    %end
    %disp(sprintf('gen zone reflect origin 0,0,0 normal -1,0,0 range group layer%.0f',layerNumber));
    %disp(sprintf('interface %.0f face range y %2.1f',layerNumber,Y2));
    %disp(sprintf('model mech mohr range group layer%i',layerNumber));
    %disp(sprintf('prop bulk %i she %i ten %i &', lPar1, lPar2, lPar3));
    %disp(sprintf('coh %i fric %i range group layer%i',lPar4,lPar5,layerNumber));
    %disp(sprintf(';;'));
    disp(sprintf(' '));
end

