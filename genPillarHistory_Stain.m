function genPillarHistory_Stain(i,pX,pY,pZt,pZb)
load('InitialDataFile.mat','mainMesh');

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
disp(sprintf('  strain_%i=abs((sumZdisp1-sumZdisp2)/((pZt-pZb)*%i*i) )',i,meshInX,meshInY));
disp(sprintf('end'));
disp(sprintf('@strain_5'));
disp(sprintf(' '));
end