function clearOldFiles()
%% Delete old output file
% This clears old files
if exist('Output') == 0
    mkdir 'Output';
    mkdir 'Output/Pillar_SS';
else if exist('Output/Pillar_SS') == 0
        mkdir 'Output/Pillar_SS';
    end
delete('./Output/*.f3dat')
delete('./Output/Pillar_SS/*.f3dat')
% copies project file and important fish scripts
copyfile('./FLAC3D_Template/*','./Output');

end