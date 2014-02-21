function createInterface()
% CREATE LAYERS

load LayerDataFile
load panelDataFile
load initialDataFile

rockLayerCounter    = 0;
interfaceLayerCount  = 0;

%GENERATE ROCK LAYERS
for i=1:size(lType,1)
    if lType(i) == 1
        %rockLayerCounter = rockLayerCounter +1;
        %genLayer(lDepth(i),lThickness(i),panelX,panelY,panelMulti,...
            %layerMesh,layerRatio,cell2mat(lName(i)),rockLayerCounter);
    else if lType(i) == 2
            interfaceLayerCount = interfaceLayerCount +1;
            genInterfaceLayer(lDepth(i),panelX,panelY,...
            lPar1(i),lPar2(i),lPar3(i),lPar4(i),lPar5(i),cell2mat(lName(i)),...
            interfaceLayerCount);
        end
    end
end



disp(sprintf(';FISH to loop through all gridpoints on interfaces and replace with cohesion/friction functions'));

disp(sprintf('def intprop'));
disp(sprintf('while_stepping'));
disp(sprintf('local _i = i_head'));
disp(sprintf('loop while _i # null ; loop through all interfaces'));
disp(sprintf('  local _in = i_node_head(_i)'));
disp(sprintf('  loop while _in # null ; loop through all nodes on this interface'));
disp(sprintf('local _nstress = in_nstr(_in) ; see page 2-99 FISH Reference'));
disp(sprintf('if _nstress < = 72000  then'));
disp(sprintf('        in_prop(_in, ''cohesion'') = 21600'));
disp(sprintf('        in_prop(_in, ''friction'') = 20'));
disp(sprintf('endif'));
disp(sprintf('if _nstress > 72000  then'));
disp(sprintf('    in_prop(_in, ''cohesion'')= 47805.86'));
disp(sprintf('    in_prop(_in, ''friction'')= 0'))
disp(sprintf('endif'));
disp(sprintf('    _in = in_next(_in)'));
disp(sprintf('  endloop'));
disp(sprintf('  _i = i_next(_i)'));
disp(sprintf('endloop'));
disp(sprintf('end'));


end


function  genInterfaceLayer( layerDepth,panelX,PanelY,...
                lPar1,lPar2,lPar3,lPar4,lPar5,layerName,layerNumber)
%Generates Interface Layer in layerDepth 
%   Detailed explanation goes here

    XYZ = genInterfaceLayerXYZ(layerDepth,panelX,PanelY);
    
    X0=XYZ(1,1);Y0=XYZ(1,2);Z0=XYZ(1,3);
    X1=XYZ(2,1);Y1=XYZ(2,2);Z1=XYZ(2,3);
    X2=XYZ(3,1);Y2=XYZ(3,2);Z2=XYZ(3,3);
    X3=XYZ(4,1);Y3=XYZ(4,2);Z3=XYZ(4,3);
    
    diary('./Output/gen.f3dat')
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



