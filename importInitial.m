function importInitial()
% Initial Values
pillarInRow       = 2;
pillarInCol       = 2;

density     = 162;
poisson     = 0.2;


panelMulti  = 1;
dBulk=1e9;
dShear=1e8;
dTens=1e9;
dCoh=220;
dFric=0;

myDebug = 0;

% brick, radtunnel
%genType = 'radtunnel';
genType = 'brick';

if strcmp(genType,'radtunnel')
layerMesh   =[10 4 10 4];    
mainMesh    =[10 4 10 4];     

layerRatio  = [1 1.2 1 1.2];       
mainRatio   = [1 1.2 1 1.2];       
elseif strcmp(genType,'brick')
layerMesh   =[10 10 3];     
mainMesh    =[10 10 3];     
layerRatio  = [1 1 1];       
mainRatio   = [1 1 1];      
end

save('InitialDataFile');

end