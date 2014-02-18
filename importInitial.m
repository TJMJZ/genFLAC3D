function importInitial()
% Initial Values
pillarInRow       = 2;
pillarInCol       = 2;

density     = 162;
poisson     = 0.2;

layerMesh   =[10 4 10 4];
mainMesh    =[3 5 3 4];

layerRatio  = [1 1.2 1 1.2];
mainRatio   = [1 1.2 1 1.2];

panelMulti  =1;
dBulk=1e9;
dShear=1e8;
dTens=1e9;
dCoh=220;
dFric=0;
save('InitialDataFile');
end