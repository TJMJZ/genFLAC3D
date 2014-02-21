function createSolve(SOLVE,STEPS)
load InitialDataFile.mat


if SOLVE == 1

    disp(sprintf(';----------------------------------'));
    disp(sprintf(';SOLVING INITIAL STATE'));
    disp(sprintf(';----------------------------------'));
    if myDebug ==1
        disp(sprintf('step 500'))
    else
        disp(sprintf('step %i',STEPS))
    end
        disp(sprintf('save initial'))
        disp(sprintf('ini xdisp=0 ydisp=0 zdisp=0'));
        disp(sprintf(' '));

elseif SOLVE ==2
        disp(sprintf(';----------------------------------'));
        disp(sprintf(';SOLVING EXCAVATION STATE'));
        disp(sprintf(';----------------------------------'));
    if myDebug ==1
        disp(sprintf('step 500'))
    else
        disp(sprintf('step %i',STEPS))
        disp(sprintf(';call zonk3D.f3fis'));
    end
        disp(sprintf('save final'))
        disp(sprintf(' '));
    end

end
