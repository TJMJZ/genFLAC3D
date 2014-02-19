function genPillarHistory_Stress(i,pX,pY,pZ)

load('InitialDataFile.mat','mainMesh');

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
disp(sprintf('  stress_%i=(abs(sumZZ)/((%i*%i)*144)',i,meshSizeX,meshSizeY));
disp(sprintf('end'));
disp(sprintf('@stress_%i',i));
disp(sprintf(' '));
end