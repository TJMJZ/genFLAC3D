function clearOldFiles();
%% Delete old output file
% This clears old files
delete('./Output/main.f3dat')
delete('./Output/gen.f3dat')
delete('./Output/prop.f3dat')
delete('./Output/BC.f3dat')
delete('./Output/plots.f3dat')
delete('./Output/solvei.f3dat')
delete('./Output/exc.f3dat')
delete('./Output/solvef.f3dat')
end