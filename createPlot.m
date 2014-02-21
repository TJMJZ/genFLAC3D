function createPlot()

load LayerDataFile
load panelDataFile
load initialDataFile

Z = coalLayerDepth - coalLayerThickness/2;
disp(sprintf(';----------------------------------'));
disp(sprintf(';CREATING HISTORY AND PLOT'));
disp(sprintf(';----------------------------------'));
disp(sprintf('hist nstep 10'))
disp(sprintf('hist add unbal'))
disp(sprintf('plot create view ModelView'))
disp(sprintf('plot add zone colorby g'))
disp(sprintf('plot create view SZZ_P'))
disp(sprintf('plot current view 3'))
disp(sprintf('plot add zcontour szz'))
disp(sprintf('plot cut add plane normal 0,0,-1 origin 0,0,%2.1f',Z))
disp(sprintf('plot set center 0,0,%2.1f',Z))
disp(sprintf('plot set distance 150'))
disp(sprintf('plot set eye 0,0,1'))
disp(sprintf(' '));

genPillarHistory();

end

function genPillarHistory()

load LayerDataFile.mat;
load InitialDataFile.mat;
load panelDataFile.mat;

numberOfPillars = pillarInCol * pillarInRow;

C = pillarCentroidXYZ();
pZ = C(1,3);
pZt = coalLayerDepth;
pZb = coalLayerDepth + coalLayerThickness;

for i = 1:numberOfPillars
    
    [pX,pY]=pillarCornerXY(C(i,:),EW,EC,XC);
    
    genPillarHistory_Stress(i,pX,pY,pZ,mainMesh);
    genPillarHistory_Stain(i,pX,pY,pZt,pZb,mainMesh);
    
    disp(sprintf('hist add fish @stress_%i',i));
    disp(sprintf('hist add fish @strain_%i',i));
    
end

end %function getPillarHistory

function genPillarHistory_Stress(i,pX,pY,pZ,mainMesh)

meshInX = mainMesh(1,1);
meshInY = mainMesh(1,3);

minX = min(pX);
minY = min(pY);

maxX = max(pX);
maxY = max(pY);
pZ = pZ(1);

meshSizeX = (maxX - minX)/meshInX;
meshSizeY = (maxY - minY)/meshInY;

disp(sprintf(' '));
disp(sprintf(';---------------------> PILLAR (%i) STRESS',i));
disp(sprintf('def stress_%i',i));
disp(sprintf('  local sumSZZ=0.0'));
disp(sprintf('  loop mX (0,%i)',meshInX+1));
disp(sprintf('      local x = %2.1f + mX * %2.1f ',minX,meshSizeX));
disp(sprintf('      loop nX (0,%i)',meshInY+1));
disp(sprintf('          local y = %2.1f + nX * %2.1f ',minY,meshSizeY));
disp(sprintf('          local pnt = z_near(x,y,%2.1f)',pZ));
disp(sprintf('          sumZZ = sumZZ + z_szz(pnt)'));
disp(sprintf('      end_loop'));
disp(sprintf('  end_loop'));
disp(sprintf('  stress_%i=(abs(sumZZ)/((%i*%i)*144))',i,meshSizeX,meshSizeY));
disp(sprintf('end'));
disp(sprintf('@stress_%i',i));
disp(sprintf(' '));
end %function getPillarHistory_Stress


function genPillarHistory_Stain(i,pX,pY,pZt,pZb,mainMesh)


meshInX = mainMesh(1,1);
meshInY = mainMesh(1,3);

minX = min(pX);
minY = min(pY);

maxX = max(pX);
maxY = max(pY);

meshSizeX = (maxX - minX)/meshInX;
meshSizeY = (maxY - minY)/meshInY;

disp(sprintf(';---------------------> PILLAR (%i) STRAIN',i));
disp(sprintf('def strain_%i',i));
disp(sprintf('  sumZdisp1=0.0'));
disp(sprintf('  sumZdisp2=0.0'));
disp(sprintf('  loop mX (0,%i)',meshInX+1));
disp(sprintf('      local x = %2.1f + mX * %2.1f ',minX,meshSizeX));
disp(sprintf('      loop nX (0,%i)',meshInY+1));
disp(sprintf('          local y = %2.1f + nX * %2.1f ',minY,meshSizeY));
disp(sprintf('          local pnt1 = gp_near(x,y,%2.1f)',pZt));
disp(sprintf('          local pnt2 = gp_near(x,y,%2.1f)',pZb));
disp(sprintf('          sumZdisp1 = sumZdisp1 + gp_zdisp(pnt1)'));
disp(sprintf('          sumZdisp2 = sumZdisp2 + gp_zdisp(pnt2)'));
disp(sprintf('      end_loop'));
disp(sprintf('  end_loop'));
disp(sprintf('  strain_%i=abs((sumZdisp1-sumZdisp2)/((%2.1f-(%2.1f))*%i*%i))',i,pZt,pZb,meshInX,meshInY));
disp(sprintf('end'));
disp(sprintf('@strain_%i',i));
disp(sprintf(' '));
end %function getPillarHistory_Strain

