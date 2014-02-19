function createProperties1()

% BOUNDRY CONDITION
%apply material prop
load initialDataFile.mat
load LayerDataFile.mat


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
end
