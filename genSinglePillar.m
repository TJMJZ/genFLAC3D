function  genSinglePillar()
%% Single Pillar generator for FLAC3D
% This code generates 1 pillars in a development panel

density     = 162;
poisson     = 0.2;

layerMesh   =[3 4 3 4];
mainMesh    =[3 5 3 4];

layerRatio  =[1 1 1 1.2];
mainRatio   = [1 1.2 1 1.2];

panelMulti  =2;

dBulk=1e9;
dShear=1e8;
dTens=1e9;
dCoh=220;
dFric=0;

%% Delete old output file
% This 
delete('./Output/main.f3dat')
delete('./Output/gen.f3dat')
delete('./Output/prop.f3dat')
delete('./Output/BC.f3dat')
delete('./Output/plots.f3dat')
delete('./Output/solvei.f3dat')
delete('./Output/exc.f3dat')
delete('./Output/solvef.f3dat')
%% Create main.f3dat
% main.f3dat will call all the fiels for the project
diary('./Output/main.f3dat')
diary on
disp(sprintf('call gen.f3dat'))
disp(sprintf('call prop.f3dat'))
disp(sprintf('call BC.f3dat'))
disp(sprintf('call plots.f3dat'))
disp(sprintf('call solvei.f3dat'))
disp(sprintf('call exc.f3dat'))
disp(sprintf('call solvef.f3dat'))
disp(sprintf(';end main'))

diary('./Output/gen.f3dat')
%% Create Header for main
disp(sprintf(';--------------------------------------------------'));
disp(sprintf(';Pillar without interface generator Ver 0.01'));
disp(sprintf(';Author : Ali Soltani'));
disp(sprintf(';--------------------------------------------------'));
disp(sprintf(' '));
disp(sprintf('new project'));
%disp(sprintf('title '%s' ',title)); Error in FLAC3d ' not the same char 
disp(sprintf(' '));
%% Importing layers data
diary off;
% Layers.xls "    'Layer Type',Litohology,Depth,Thickness'"
inputLayer = importdata('./Data/layers.xls');
[row,col]=size(inputLayer.data);
 %Error checking (check column 
 %clearvars col
lName      = inputLayer.textdata([2:end],2); 

lType       = inputLayer.data(:,1);
lThickness  = inputLayer.data(:,4);
lDepth      = inputLayer.data(:,5);
lPar1       = inputLayer.data(:,6);  %Bulk / KN
lPar2       = inputLayer.data(:,7);  %Shear / KS
lPar3       = inputLayer.data(:,8);  %Tens / tebs
lPar4       = inputLayer.data(:,9);  % coh / coh
lPar5       = inputLayer.data(:,10); % fric / fric


%clearvars col row inputLayer;
%% Importing Panel data
% Layers.xls "    'Layer Type',Litohology,Depth,Thickness'"
inputPanel = importdata('./Data/panel.xls');
[row,col]=size(inputPanel.data);
 %Error checking (check column adn row 
 %clearvars col
EC         = inputPanel.data(1,3); %entry spacing
XC         = inputPanel.data(2,3); %crosscut spacing
EW         = inputPanel.data(3,3); %entry width
pEW        = inputPanel.data(4,3); %pillar size in entry
pCW        = inputPanel.data(5,3); %pillar size in crosscut
panelX      = EW + pEW; 
panelY      = EW + pCW;
panelMax    = max(panelX,panelY);
clearvars inputPanel row col;
%% FINDING COAL LAYAER
for i=1:size(lName,1)
   if strcmp(cell2mat(lName(i)),'coal')
       coalLayerNumber = i;
   end
end
%% GENERATE LAYERS
diary('./Output/gen.f3dat')
diary on
rockLayerCounter    = 0;
interfaceLayerCount  = 0;
%GENERATE MAIN LAYERS
mainRoof  = [lDepth(1),max(panelX,panelY)*panelMulti];   %,'mainRoof',0]
genLayer(mainRoof(1),mainRoof(2),panelX,panelY,panelMulti,...
    mainMesh,mainRatio,'mainRoof',0)
disp(sprintf('gen zone reflect origin 0,0,%2.1f normal 0,0,-1',mainRoof(1)))
disp(sprintf('del zone range z %2.1f %2.1f',mainRoof(1),mainRoof(1)-panelMulti*max(panelX,panelY)));

%GENERATE ROCK LAYERS
for i=1:size(lType,1)
    if lType(i) == 1
        rockLayerCounter = rockLayerCounter +1;
        genLayer(lDepth(i),lThickness(i),panelX,panelY,panelMulti,...
            layerMesh,layerRatio,cell2mat(lName(i)),rockLayerCounter);
    else if lType(i) == 2
            %interfaceLayerCount = interfaceLayerCount +1;
         %genInterfaceLayer(lDepth(i),panelX,panelY,...
             %lPar1(i),lPar2(i),lPar3(i),lPar4(i),lPar5(i),cell2mat(lName(i)),...
             %interfaceLayerCount);
        end
    end
end

mainFloor = [lDepth(end),max(panelX,panelY)*panelMulti,panelX,panelY]; %,'mainFloor',0]
genLayer(mainFloor(1),mainFloor(2),mainFloor(3),mainFloor(4),panelMulti,...
    mainMesh,mainRatio,'mainFloor',0)

disp(sprintf('gen zone reflect origin 0,0,0 normal 0,-1,0'));
disp(sprintf('gen zone reflect origin 0,0,0 normal -1,0,0'));
%deepest = max(layerDepth);
%% BOUNDRY CONDITION
%apply material prop
diary('./Output/prop.f3dat')
disp(sprintf(';----------------------------------'));
disp(sprintf(';INITIAL MATERIAL MODEL'));
disp(sprintf(';----------------------------------'));
disp(sprintf('model mech elas'))
disp(sprintf('prop bulk %2.1f shear %2.1f',dBulk,dShear));
for i=1:size(lType,1)
    if lType(i) == 1
        disp(sprintf('prop bulk %2.1f shear %2.1f range z %2.1f %2.1f',...
            lPar1(i),lPar2(i),lDepth(i)-lThickness(i),lDepth(i)));
    else if lType(i) == 2
            
        end
    end
end


diary('./Output/BC.f3dat')
disp(sprintf(';----------------------------------'));
disp(sprintf(';SET GRAVITY'));
disp(sprintf(';----------------------------------'));
disp(sprintf(';set gravity 0,0,-32'))
disp(sprintf(';ini density 1000.0'))

vStress_Multi = 1.2;
hStress_Multi = (poisson)/(1-poisson);

vStress = vStress_Multi*abs(lDepth(1));
hStress = hStress_Multi*vStress;

zmax    =   lDepth(1)+panelMax*panelMulti;
zmax_t  =   zmax+0.1;
zmax_b  =   zmax-0.1;

zmin    =   lDepth(end)-panelMax*panelMulti;
zmin_t  =   zmin+0.1;
zmin_b  =   zmin-0.1;

xmax    =   panelX*panelMulti;
xmax_t  =   xmax+0.1;
xmax_b  =   xmax-0.1;

xmin    =   -panelX*panelMulti;
xmin_t  =   xmin+0.1;
xmin_b  =   xmin-0.1;

ymax    =   panelY*panelMulti;
ymax_t  =   ymax+0.1;
ymax_b  =   ymax-0.1;

ymin    =   -panelY*panelMulti;
ymin_t  =   ymin+0.1;
ymin_b  =   ymin-0.1;

disp(sprintf(';----------------------------------'));
disp(sprintf(';DEFINE FIX CONDITION'));
disp(sprintf(';----------------------------------'));
disp(sprintf('fix x range x %2.1f %2.1f',xmin_b,xmin_t));
disp(sprintf('fix x range x %2.1f %2.1f',xmax_b,xmax_t));
disp(sprintf('fix y range y %2.1f %2.1f',ymin_b,ymin_t));
disp(sprintf('fix y range y %2.1f %2.1f',ymax_b,ymax_t));
disp(sprintf('fix z range z %2.1f %2.1f',zmin_b,zmin_t));
disp(sprintf(' '));
disp(sprintf(';----------------------------------'));
disp(sprintf(';INITIAL STRESS'));
disp(sprintf(';----------------------------------'));
disp(sprintf(';ini szz -%2.1f ',vStress));
disp(sprintf(';ini sxx -%2.1f ',hStress));
disp(sprintf(';ini syy -%2.1f ',hStress));
disp(sprintf(' '));
disp(sprintf(';ini szz -1 grad 0,0,%2.1f',vStress_Multi));
disp(sprintf(';ini sxx -1 grad 0,0,%2.1f',hStress_Multi));
disp(sprintf(';ini syy -1 grad 0,0,%2.1f',hStress_Multi));
disp(sprintf(' '));
disp(sprintf(';----------------------------------'));
disp(sprintf(';APPLY VERTICAL STRESS'));
disp(sprintf(';----------------------------------'));
disp(sprintf('apply szz -%2.1f range z %2.1f1,%2.1f',vStress,zmax_b,zmax_t));
disp(sprintf(' '));
%% Plot
diary('./Output/plots.f3dat')
disp(sprintf(';----------------------------------'));
disp(sprintf(';CREATING HISTORY AND PLOT'));
disp(sprintf(';----------------------------------'));
disp(sprintf('hist nstep 10'))
disp(sprintf('hist add unbal'))
disp(sprintf('plot create view uBAL'))
disp(sprintf(' '));
%% Initial Solve
diary('./Output/solvei.f3dat')
disp(sprintf(';----------------------------------'));
disp(sprintf(';SOLVING INITIAL STATE'));
disp(sprintf(';----------------------------------'));
disp(sprintf('solve'))
disp(sprintf('save initial'))
disp(sprintf('ini xdisp=0 ydisp=0 zdisp=0'));
disp(sprintf(' '));

%% Room and Pillar Excavation

diary('./Output/exc.f3dat')    
disp(sprintf(';----------------------------------'));
disp(sprintf(';EXCAVATE ENTRIES AND CROSSCUTS'));
disp(sprintf(';----------------------------------'));
excSinglePillar(lThickness(coalLayerNumber),EW,lDepth(coalLayerNumber),EC,XC)

%% Change Material Model
disp(sprintf(';----------------------------------'));
disp(sprintf(';SECONDARY MATERIAL MODEL'));
disp(sprintf(';----------------------------------'));
disp(sprintf('model mech mohr'))
disp(sprintf('prop bulk %2.1f shear %2.1f tens %2.1f coh %2.1f fric %2.1f ',dBulk,dShear,dTens,dCoh,dFric));
for i=1:size(lType,1)
    if lType(i) == 1
        disp(sprintf('prop bulk %2.1f shear %2.1f tens %2.1f coh %2.1f fric %2.1f range z %2.1f %2.1f',...
        lPar1(i),lPar2(i),lPar3(i),lPar4(i),lPar5(i),lDepth(i)-lThickness(i),lDepth(i)));
    else if lType(i) == 2
            
        end
    end
end
%% Second Solve
diary('./Output/solvef.f3dat')  
disp(sprintf(';----------------------------------'));
disp(sprintf(';SOLVING EXCAVATION STATE'));
disp(sprintf(';----------------------------------'));
disp(sprintf(';solve'))
disp(sprintf(';call zonk3D.f3fis'));
disp(sprintf(';save final'))
disp(sprintf(' '));

