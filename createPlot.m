function createPlot()

diary('./Output/plots.f3dat')
disp(sprintf(';----------------------------------'));
disp(sprintf(';CREATING HISTORY AND PLOT'));
disp(sprintf(';----------------------------------'));
disp(sprintf('hist nstep 10'))
disp(sprintf('hist add unbal'))
disp(sprintf('plot create view uBAL'))
disp(sprintf(' '));

end

