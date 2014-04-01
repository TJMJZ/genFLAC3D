function importInitial()
% Initial Values
inputLayer = importdata('./Data/input.xls');
%[row,col]=size(inputLayer.data);
 %Error checking (check column 
 %clearvars col
pillarInRow     = inputLayer.data.Adv(1,2);     
pillarInCol     = inputLayer.data.Adv(2,2); 
density         = inputLayer.data.Adv(3,2);  
poisson         = inputLayer.data.Adv(4,2);     
panelMulti      = inputLayer.data.Adv(5,2);
outputType      = inputLayer.data.Adv(6,2); % 0 multi file 1- one file
mySolveStep     = inputLayer.data.Adv(7,2);
myDebug         = inputLayer.data.Adv(8,2);
myDebugStep     = inputLayer.data.Adv(9,2);
myZONK          = inputLayer.data.Adv(10,2);
genType         = inputLayer.textdata.Adv(11,2);


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

save('InitialDataFile');

end