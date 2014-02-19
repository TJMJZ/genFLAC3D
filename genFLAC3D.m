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

createMain();                           %create main.f3dat

createLayer();                          %generate layers
createInterface();                      %generate interface between layers

createProperties1();                    %apply initial properties to layers
createBC();                             %apply boun

createPlot();                           % create plots and history

createSolve1();                         % Initial Solve
createResult1();                        %write results to table files

createExcavate();                       %Room and Pillar Excavation
createProperties2();                    %apply properties to layers after excavation

createSolve2();                         %Second Solve
createResult2();                        %write results to table files