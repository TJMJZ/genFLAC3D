function C = pillarCentroidXYZ()
    %Gives the centroid coordination of pillars
load inputDataFile.mat
    nC = pillarInCol;
    nR = pillarInRow;
    EH = coalLayerThickness;
    CZ = coalLayerDepth+(EH/2);
    
    xmin = -panelX+EW/2 + pEW/2;
    ymin = -panelY+EW/2 + pCW/2;
    sX   = EW + pEW;
    sY   = EW + pCW;
    for i=0:nR-1
        for j=0:nC-1
            C1=xmin+i*sX;
            C2=ymin+j*sY;
            
            if (i == 0 && j ==0)
                C = [C1 C2 CZ];
            else
                C = [C;C1 C2 CZ];
            end
        end
    end

end %function pillarCentroid