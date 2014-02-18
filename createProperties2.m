function createProperties2()
load LayerDataFile.mat
load InitialDataFile.mat

% Change Material Model
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


end