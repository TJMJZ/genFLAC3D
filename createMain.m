function createMain()
%% Create main.f3dat
% main.f3dat will call all the fiels for the project
copyfile('./FLAC3D_Template/*','./Output');
diary('./Output/main.f3dat')
diary on
disp(sprintf(';--------------------------------------------------'));
disp(sprintf(';Pillar without interface generator Ver 0.01'));
disp(sprintf(';Author : Ali Soltani'));
disp(sprintf(' '));
disp(sprintf(' '));
disp(sprintf(';------------------ INITIAL VALUES ----------------'));
disp(sprintf('; Number of pillar in X : '));
disp(sprintf('; Number of pillar in Y :'));
disp(sprintf(' '));
disp(sprintf(' '));
disp(sprintf(';-------------- PILLAR/PANEL DIM ------------------'));
disp(sprintf('; Entry Width : '));
disp(sprintf('; Pillar X :               (width in entry)  '));
disp(sprintf('; Pillar Y :               (width in cross-section) '));
disp(sprintf(';--------------------------------------------------'));
disp(sprintf(' '));
disp(sprintf('new project'));
%disp(sprintf('title '%s' ',title)); Error in FLAC3d ' not the same char 
disp(sprintf(' '));
disp(sprintf('call gen.f3dat'))
disp(sprintf('call prop.f3dat'))
disp(sprintf('call BC.f3dat'))
disp(sprintf('call plots.f3dat'))
disp(sprintf('call solvei.f3dat'))
disp(sprintf('call exc.f3dat'))
disp(sprintf('call solvef.f3dat'))
disp(sprintf(';end main'))

diary('./Output/gen.f3dat')
end