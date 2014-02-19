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
    mainMesh,mainRatio,'mainRoof',0)
disp(sprintf('gen zone reflect origin 0,0,%2.1f normal 0,0,-1',mainRoof(1)))
disp(sprintf('del zone range z %2.1f %2.1f',mainRoof(1),mainRoof(1)-panelMulti*max(panelX,panelY)));

%GENERATE ROCK LAYERS
for i=1:size(lType,1)
    if lType(i) == 1
        rockLayerCounter = rockLayerCounter +1;
        genLayer(lDepth(i),lThickness(i),panelX,panelY,panelMulti,...
            layerMesh,layerRatio,cell2mat(lName(i)),rockLayerCounter);
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
    mainMesh,mainRatio,'mainFloor',0)

%GENERATE REFLECTION (X and Y)
disp(sprintf('gen zone reflect origin 0,0,0 normal 0,-1,0'));
disp(sprintf('gen zone reflect origin 0,0,0 normal -1,0,0'));
end

