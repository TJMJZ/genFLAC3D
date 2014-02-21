function clearOldFiles()
%% Delete old output file
% This clears old files
delete('./Output/*.f3dat')
delete('./Output/Pillar_SS/*.f3dat')
% copies project file and important fish scripts
copyfile('./FLAC3D_Template/*','./Output');

end