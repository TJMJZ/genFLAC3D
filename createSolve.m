function createSolve(SOLVE)
load inputDataFile.mat

if SOLVE == 1
    
    if outputType == 0
    diary('./Output/solvei.f3dat')
    else
    diary('./Output/single.f3dat')
    end
    
    disp(sprintf(';----------------------------------'));
    disp(sprintf(';SOLVING INITIAL STATE'));
    disp(sprintf(';----------------------------------'));
    if myDebug ==1
        disp(sprintf('step %i',myDebugStep))
    else
        if mySolveStep == 0
            disp(sprintf('solve'))
        else
            disp(sprintf('step %i',mySolveStep))
        end
    end
        disp(sprintf('save initial'))
        disp(sprintf('ini xdisp=0 ydisp=0 zdisp=0'));
        disp(sprintf(' '));

elseif SOLVE ==2
    
    if outputType == 0
    diary('./Output/solvef.f3dat')
    else
    diary('./Output/single.f3dat')
    end
        disp(sprintf(';----------------------------------'));
        disp(sprintf(';SOLVING EXCAVATION STATE'));
        disp(sprintf(';----------------------------------'));
        
    if myDebug ==1
        disp(sprintf('step %i',myDebugStep))
    else
        if myZONK == 1
            disp(sprintf('call zonk3D.f3fis'));
        else
            if mySolveStep == 0
                disp(sprintf('solve'));
            else  
                disp(sprintf('step %i',mySolveStep));
            end
        end
        
    end
        disp(sprintf('save final'))
        disp(sprintf(' '));
    end

end
