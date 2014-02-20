function  genFLAC3D()
% Single Pillar generator for FLAC3D
% This code generates X x Y pillars in a development panel

importInitial();                        % Initial Values
load initialDataFile.mat
importLayers();                         % imports layers data
load layerDataFile.mat
importPanel();                          % imports panel data
load panelDataFile.mat

clearOldFiles();                        %clear old files

diary on
diary('./Output/main.f3dat')
createMain();                           %create main.f3dat

diary('./Output/gen.f3dat')
createLayer();                          %generate layers
%createInterface();                      %generate interface between layers

diary('./Output/prop.f3dat')
createProperties1();                    %apply initial properties to layers
diary('./Output/BC.f3dat')
createBC();                             %apply boun

diary('./Output/plots.f3dat')
createPlot();                           % create plots and history

diary('./Output/solvei.f3dat')
createSolve1();                         % Initial Solve
createResult1();                        %write results to table files

diary('./Output/exc.f3dat') 
createProperties2();                    %apply properties to layers after excavation
createExcavate();                       %Room and Pillar Excavation


diary('./Output/solvef.f3dat')  
createSolve2();                         %Second Solve
createResult2();                        %write results to table files

diary off