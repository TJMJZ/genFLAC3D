function genPillarHistory_Stress()
disp(sprintf(';--> PILLAR (5) STRESS'));
disp(sprintf('def stress_5'));
disp(sprintf('  sum=0.0'));
disp(sprintf('  loop m (0,5)'));
disp(sprintf('      x=85.25+m*0.5'));
disp(sprintf('      loop n (0,1)'));
disp(sprintf('          y=0.25+m*0.5'));
disp(sprintf('          local pnt = z_near(x,y,2.25)'));
disp(sprintf('          sum=sum+z_szz(pnt)'));
disp(sprintf('      end_loop'));
disp(sprintf('  end_loop'));
disp(sprintf('  stress_5=(abs(sum)/(6*2))/144'));
disp(sprintf('end'));
disp(sprintf('@stress_5'));
disp(sprintf(' '));
end