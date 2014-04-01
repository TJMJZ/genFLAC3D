function createProperties(PROP)
load inputDataFile.mat


if lThickness(1) <= 0
    lThickness(1) = max(panelX,panelY)*panelMulti; 
end

if lThickness(end) <= 0
    lThickness(end) = max(panelX,panelY)*panelMulti;
end


if PROP == 1

    if outputType == 0
    diary('./Output/prop.f3dat')
    else
    diary('./Output/single.f3dat')
    end

disp(sprintf(';----------------------------------'));
disp(sprintf(';INITIAL MATERIAL MODEL'));
disp(sprintf(';----------------------------------'));

for i=1:size(lType,1)
    if (lType(i) == 1 || lType(i) == 0)
        if i == 1 
            disp(sprintf('model mech %s range z %2.1f %2.1f',cell2mat(lMechType1(i)),lDepth(i)+lThickness(i),lDepth(i)))
        else
            disp(sprintf('model mech %s range z %2.1f %2.1f',cell2mat(lMechType1(i)),lDepth(i)-lThickness(i),lDepth(i)))
        end
        if strcmp(lMechType1(i),'elas')
        
            if i == 1
                disp(sprintf('prop bulk %2.1f shear %2.1f range z %2.1f %2.1f',lPar1(i),lPar2(i),lDepth(i)+lThickness(i),lDepth(i)));
            else 
                disp(sprintf('prop bulk %2.1f shear %2.1f range z %2.1f %2.1f',lPar1(i),lPar2(i),lDepth(i)-lThickness(i),lDepth(i)));
            end
        else if strcmp(lMechType1(i),'mohr')
                if i == 1
                    disp(sprintf('prop bulk %2.1f shear %2.1f tens %2.1f coh %2.1f fric %2.1f range z %2.1f %2.1f',lPar1(i),lPar2(i),lPar3(i),lPar4(i),lPar5(i),lDepth(i)+lThickness(i),lDepth(i)));
                else
                    disp(sprintf('prop bulk %2.1f shear %2.1f tens %2.1f coh %2.1f fric %2.1f range z %2.1f %2.1f',lPar1(i),lPar2(i),lPar3(i),lPar4(i),lPar5(i),lDepth(i)-lThickness(i),lDepth(i))); 
                end
            end
        end
    else if lType(i) == 2
            
        end
    end
end
end


if PROP == 2
% Change Material Model



disp(sprintf(';----------------------------------'));
disp(sprintf(';SECONDARY MATERIAL MODEL'));
disp(sprintf(';----------------------------------'));

%disp(sprintf('prop bulk %2.1f shear %2.1f tens %2.1f coh %2.1f fric %2.1f ',dBulk,dShear,dTens,dCoh,dFric));
for i=1:size(lType,1)
    if (lType(i) == 1 || lType(i) == 0)
        if i ==1
        disp(sprintf('model mech %s range z %2.1f %2.1f',cell2mat(lMechType2(i)),lDepth(i)+lThickness(i),lDepth(i)))
        else
        disp(sprintf('model mech %s range z %2.1f %2.1f',cell2mat(lMechType2(i)),lDepth(i)-lThickness(i),lDepth(i)))    
        end
        if strcmp(lMechType1(i),'elas')
            if i == 1
                disp(sprintf('prop bulk %2.1f shear %2.1f range z %2.1f %2.1f',lPar1(i),lPar2(i),lDepth(i)+lThickness(i),lDepth(i)));
            else
                disp(sprintf('prop bulk %2.1f shear %2.1f range z %2.1f %2.1f',lPar1(i),lPar2(i),lDepth(i)-lThickness(i),lDepth(i)));
            end
        
        else if strcmp(lMechType1(i),'mohr')
                if i == 1
                    disp(sprintf('prop bulk %2.1f shear %2.1f tens %2.1f coh %2.1f fric %2.1f range z %2.1f %2.1f',lPar1(i),lPar2(i),lPar3(i),lPar4(i),lPar5(i),lDepth(i)+lThickness(i),lDepth(i)));
                else
                    disp(sprintf('prop bulk %2.1f shear %2.1f tens %2.1f coh %2.1f fric %2.1f range z %2.1f %2.1f',lPar1(i),lPar2(i),lPar3(i),lPar4(i),lPar5(i),lDepth(i)-lThickness(i),lDepth(i)));
                end
            end
        end
    else if lType(i) == 2
            
        end
    end
end
end

end %functions createProperties 
