function createMain()
%% Create main.f3dat
% main.f3dat will call all the fiels for the project
load inputDataFile.mat

if outputType == 0
diary('./Output/main.f3dat')
else
diary('./Output/single.f3dat')
end
diary on

disp(sprintf(';**************************************************'));
disp(sprintf(';Pillar without interface generator Ver 0.01'));
disp(sprintf(';Author : Ali Soltani'));
disp(sprintf(';Generated %s',date()));
disp(sprintf(';**************************************************'));
disp(sprintf(';input.xls imported'));
disp(sprintf(';'));
disp(sprintf(';------------------ INITIAL VALUES ----------------'));
disp(sprintf('; Number of pillar in X : %i ',pillarInRow));
disp(sprintf('; Number of pillar in Y : %i ',pillarInCol));
disp(sprintf('; '));
disp(sprintf('; '));
disp(sprintf(';-------------- PILLAR/PANEL DIM ------------------'));
disp(sprintf('; Entry Width :   %2.1f ',EW));
disp(sprintf('; Pillar X :      %2.1f      (width across entry)',pEW));
disp(sprintf('; Pillar Y :      %2.1f      (width across cross-section)',pCW));
disp(sprintf('; '));
disp(sprintf('; Panel  X :      %2.1f      ',panelX*2));
disp(sprintf('; Panel  Y :      %2.1f      ',panelY*2));
disp(sprintf('; PanelMulti :    %2.1f      ',panelMulti));
disp(sprintf(';--------------------------------------------------'));
disp(sprintf(' '));
disp(sprintf('new project'));
%disp(sprintf('title '%s' ',title)); Error in FLAC3d ' not the same char 
disp(sprintf(' '));
if outputType == 0
disp(sprintf('call gen.f3dat'))
if myDebug == 1 
disp(sprintf('pause'))
end
disp(sprintf('call prop.f3dat'))
if myDebug == 1 
disp(sprintf('pause'))
end
disp(sprintf('call BC.f3dat'))
if myDebug == 1 
disp(sprintf('pause'))
end
disp(sprintf('call plots.f3dat'))
if myDebug == 1 
disp(sprintf('pause'))
end
disp(sprintf('call solvei.f3dat'))
if myDebug == 1 
disp(sprintf('pause'))
end
disp(sprintf('call exc.f3dat'))
if myDebug == 1 
disp(sprintf('pause'))
end
disp(sprintf('call solvef.f3dat'))
if myDebug == 1 
disp(sprintf('pause'))
end
disp(sprintf(';end main'))

diary('./Output/gen.f3dat')
end
end