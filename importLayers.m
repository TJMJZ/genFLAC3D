function  importLayers()
% Importing layers data
% Layers.xls "    'Layer Type',Litohology,Depth,Thickness'"
inputLayer = importdata('./Data/layers.xls');
%[row,col]=size(inputLayer.data);
 %Error checking (check column 
 %clearvars col
lType       = inputLayer.data(:,1);     % 0 for main roof/floor 1 - rock layer 2 - rock layer
lName       = inputLayer.textdata([2:end],2); %Layer name (coal must be present)
lRockType   = inputLayer.textdata([2:end],3); %Rock type (sandstone, coal, etc)
lThickness  = inputLayer.data(:,4);     %Layer thinkness (0 for main floor/roof and interface)
lDepth      = inputLayer.data(:,5);     %Depth of top face of layer (must be negative)
lMechType1  = inputLayer.textdata([2:end],6);%Mech Type -- (mohr,elas,null are currently valid)
lMechType2  = inputLayer.textdata([2:end],7);%Mech Type -- (mohr,elas,null are currently valid)
lPar1       = inputLayer.data(:,8);     %Bulk / KN
lPar2       = inputLayer.data(:,9);     %Shear / KS
lPar3       = inputLayer.data(:,10);     %Tens / tebs
lPar4       = inputLayer.data(:,11);    % coh / coh
lPar5       = inputLayer.data(:,12);    % fric / fric

% FINDING COAL LAYAER
for i=1:size(lName,1)
   if strcmp(cell2mat(lName(i)),'coal')
       coalLayerNumber = i;
   end
end

coalLayerThickness = lThickness(coalLayerNumber);
coalLayerDepth     = lDepth(coalLayerNumber);

clearvars col row inputLayer i;
save('LayerDataFile');
end

