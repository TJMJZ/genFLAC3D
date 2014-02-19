function genPillarHistory_Stain()
disp(sprintf(';--> PILLAR (5) STRAIN'));
disp(sprintf('def strain_5'));
disp(sprintf('  sum1=0.0'));
disp(sprintf('  sum2=0.0'));
disp(sprintf('  loop m (0,6)'));
disp(sprintf('      x=85+m*0.5'));
disp(sprintf('      loop n (0,2)'));
disp(sprintf('          y=0+n*0.5'));
disp(sprintf('          local pnt1 = gp_near(x,y,0)'));
disp(sprintf('          local pnt2 = gp_near(x,y,4)'));
disp(sprintf('          sum=sum1+gp_zdisp(pnt1)'));
disp(sprintf('          sum2=sum2+gp_zdisp(pnt2)'));
disp(sprintf('      end_loop'));
disp(sprintf('  end_loop'));
disp(sprintf('  strain_5=abs(sum1/(7*3)-sum2/(7*3))/4'));
disp(sprintf('end'));
disp(sprintf('@strain_5'));
disp(sprintf(' '));
end