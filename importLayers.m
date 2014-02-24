function  importLayers()
% Importing layers data
% Layers.xls "    'Layer Type',Litohology,Depth,Thickness'"
inputLayer = importdata('./Data/layers.xls');
%[row,col]=size(inputLayer.data);
 %Error checking (check column 
 %clearvars col
lType       = inputLayer.data(:,1);
lName      = inputLayer.textdata([2:end],2); 
lRockType   = inputLayer.data(:,3);
lThickness  = inputLayer.data(:,4);
lDepth      = inputLayer.data(:,5);
lMechType   = inputLayer.data(:,6);
lPar1       = inputLayer.data(:,7);  %Bulk / KN
lPar2       = inputLayer.data(:,8);  %Shear / KS
lPar3       = inputLayer.data(:,9);  %Tens / tebs
lPar4       = inputLayer.data(:,10);  % coh / coh
lPar5       = inputLayer.data(:,11); % fric / fric

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

