function  genFLAC3D()
% Single Pillar generator for FLAC3D
% This code generates X x Y pillars in a development panel

importInitial();                        % Initial Values
load initialDataFile.mat
importLayers();                         % imports layers data
load layerDataFile.mat
importPanel();                          % imports panel data
load panelDataFile.mat

numError = importChecker();

if numError~=0
    error('ERROR FOUND IN INPUTS !'); 
end

clearOldFiles();                        %clear old files


diary('./Output/main.f3dat')
diary on

createMain();                           %create main.f3dat

diary('./Output/gen.f3dat')
createLayer();                          %generate layers and interface

diary('./Output/prop.f3dat')
createProperties(1);                    %apply initial properties to layers

diary('./Output/BC.f3dat')
createBC();                             %apply boun

diary('./Output/plots.f3dat')
createPlot();                           % create plots and history

diary('./Output/solvei.f3dat')
createSolve(1,2000);                         % Initial Solve

createResult(1);                        %write results to table files

diary('./Output/exc.f3dat') 
createProperties(2);                    %apply properties to layers after excavation

createExcavate();                       %Room and Pillar Excavation

diary('./Output/solvef.f3dat')  
createSolve(2,2000);                         %Second Solve

createResult(2);                        %write results to table files

diary off