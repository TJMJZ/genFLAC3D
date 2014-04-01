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

createMain();                           %create main.f3dat


%if outputType == 0

%else
%diary('./Output/single.f3dat')
%end

%gen.3fdat
createLayer();                          %generate layers and interface

%prop.3fdat
createProperties(1);                    %apply initial properties to layers

%BC.3fdat
createBC();                             %apply boun


%plot.3fdat
createPlot();                           % create plots and history



%solvei.3fdat
createSolve(1);                    % Initial Solve
createResult(1);                        %write results to table files


%exc.3fdat
createExcavate();                       %Room and Pillar Excavation
createProperties(2);                    %apply properties to layers after excavation

%solvef.3fdat
createSolve(2);                    %Second Solve
createResult(2);                        %write results to table files

diary off