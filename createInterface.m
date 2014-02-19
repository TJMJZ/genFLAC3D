function createInterface()
% CREATE LAYERS
diary('./Output/gen.f3dat')
diary on

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