function  genInterfaceLayer( layerDepth,panelX,PanelY,...
                lPar1,lPar2,lPar3,lPar4,lPar5,layerName,layerNumber)
%Generates Interface Layer in layerDepth 
%   Detailed explanation goes here

    XYZ = genInterfaceLayerXYZ(layerDepth,panelX,PanelY);
    
    X0=XYZ(1,1);Y0=XYZ(1,2);Z0=XYZ(1,3);
    X1=XYZ(2,1);Y1=XYZ(2,2);Z1=XYZ(2,3);
    X2=XYZ(3,1);Y2=XYZ(3,2);Z2=XYZ(3,3);
    X3=XYZ(4,1);Y3=XYZ(4,2);Z3=XYZ(4,3);
    
    diary('gen.dat')
    diary on
    disp(sprintf(' '));
    disp(sprintf(';----------------------------------'));
    disp(sprintf(';;GENERATING INTERFACE LAYER %s (%i) ',layerName,layerNumber));
    disp(sprintf(';----------------------------------'));
    %P = sum(lPar1,lPar2,lPar3,lPar4,lPar5)
    %disp(sprintf('group layer%.0f fill group layer%.0f',layerNumber,layerNumber));
    %disp(sprintf('gen zone reflect origin 0,0,0 normal -1,0,0 range group layer%.0f',layerNumber));
    disp(sprintf('interface %i face range plane norm (0,0,-1) origin (0,0,%i) dist 0.1',...
        layerNumber,layerDepth));
    disp(sprintf('interface %i prop kn %i ks %i tens %i cohesion %i friction %i',layerNumber,lPar1,lPar2,lPar3,lPar4,lPar5));
    disp(sprintf('interface %i effective=off',layerNumber));
   
    disp(sprintf(' '));
end

