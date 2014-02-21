function importPanel(pillarInRow,pillarInCol)
load initialDataFile.mat
% Importing Panel data
% Layers.xls "    'Layer Type',Litohology,Depth,Thickness'"
inputPanel = importdata('./Data/panel.xls');
 %[row,col]=size(inputPanel.data);
 %Error checking (check column adn row 
 %clearvars col
EC         = inputPanel.data(1,3); %entry spacing
XC         = inputPanel.data(2,3); %crosscut spacing
EW         = inputPanel.data(3,3); %entry width
pEW        = inputPanel.data(4,3); %pillar size in entry
pCW        = inputPanel.data(5,3); %pillar size in crosscut
panelX      = pillarInRow*(EW + pEW)/2; 
panelY      = pillarInCol*(EW + pCW)/2;
panelMax    = max(panelX,panelY);
clearvars inputPanel;
save('PanelDataFile');

end