function importDataFile()
% Initial Values
inputExcel = importdata('./Data/input.xls');
%[row,col]=size(inputLayer.data);
 %Error checking (check column 
 %clearvars col
 
%%%%%%%%%%%%%%%%%%%%%%%%%%
%ADVANCE SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
pillarInRow     = inputExcel.data.Adv(1,2);     
pillarInCol     = inputExcel.data.Adv(2,2); 
density         = inputExcel.data.Adv(3,2);  
poisson         = inputExcel.data.Adv(4,2);     
panelMulti      = inputExcel.data.Adv(5,2);
outputType      = inputExcel.data.Adv(6,2); % 0 multi file 1- one file
mySolveStep     = inputExcel.data.Adv(7,2);
myDebug         = inputExcel.data.Adv(8,2);
myDebugStep     = inputExcel.data.Adv(9,2);
myZONK          = inputExcel.data.Adv(10,2);
genType         = inputExcel.textdata.Adv(11,2);


if strcmp(genType,'radtunnel')
layerMesh   =[10 4 10 4];    
mainMesh    =[10 4 10 4];     

layerRatio  = [1 1.2 1 1.2];       
mainRatio   = [1 1.2 1 1.2];       
elseif strcmp(genType,'brick')
layerMesh   =[10 10 3];     
mainMesh    =[10 10 3];     
layerRatio  = [1 1 1];       
mainRatio   = [1 1 1];      
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
%PANEL SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%
EC         = inputExcel.data.Panel(1,3); %entry spacing
XC         = inputExcel.data.Panel(2,3); %crosscut spacing
EW         = inputExcel.data.Panel(3,3); %entry width
pEW        = inputExcel.data.Panel(4,3); %pillar size in entry
pCW        = inputExcel.data.Panel(5,3); %pillar size in crosscut
panelX      = pillarInRow*(EW + pEW)/2; 
panelY      = pillarInCol*(EW + pCW)/2;
panelMax    = max(panelX,panelY);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%LAYER SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%

lType       = inputExcel.data.Layers(:,1);     % 0 for main roof/floor 1 - rock layer 2 - rock layer
lName       = inputExcel.textdata.Layers([2:end],2); %Layer name (coal must be present)
lRockType   = inputExcel.textdata.Layers([2:end],3); %Rock type (sandstone, coal, etc)
lThickness  = inputExcel.data.Layers(:,4);     %Layer thinkness (0 for main floor/roof and interface)
lDepth      = inputExcel.data.Layers(:,5);     %Depth of top face of layer (must be negative)
lMechType1  = inputExcel.textdata.Layers([2:end],6);%Mech Type -- (mohr,elas,null are currently valid)
lMechType2  = inputExcel.textdata.Layers([2:end],7);%Mech Type -- (mohr,elas,null are currently valid)
lPar1       = inputExcel.data.Layers(:,8);     %Bulk / KN
lPar2       = inputExcel.data.Layers(:,9);     %Shear / KS
lPar3       = inputExcel.data.Layers(:,10);     %Tens / tebs
lPar4       = inputExcel.data.Layers(:,11);    % coh / coh
lPar5       = inputExcel.data.Layers(:,12);    % fric / fric

% FINDING COAL LAYAER
for i=1:size(lName,1)
   if strcmp(cell2mat(lName(i)),'coal')
       coalLayerNumber = i;
   end
end

coalLayerThickness = lThickness(coalLayerNumber);
coalLayerDepth     = lDepth(coalLayerNumber);

clearvars col row inputExcel i;

save('inputDataFile');

end