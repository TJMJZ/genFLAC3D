function  importLayers()
% Importing layers data
diary off;
% Layers.xls "    'Layer Type',Litohology,Depth,Thickness'"
inputLayer = importdata('./Data/layers.xls');
%[row,col]=size(inputLayer.data);
 %Error checking (check column 
 %clearvars col
lName      = inputLayer.textdata([2:end],2); 

lType       = inputLayer.data(:,1);
lThickness  = inputLayer.data(:,4);
lDepth      = inputLayer.data(:,5);
lPar1       = inputLayer.data(:,6);  %Bulk / KN
lPar2       = inputLayer.data(:,7);  %Shear / KS
lPar3       = inputLayer.data(:,8);  %Tens / tebs
lPar4       = inputLayer.data(:,9);  % coh / coh
lPar5       = inputLayer.data(:,10); % fric / fric

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

