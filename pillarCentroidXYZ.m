function C = pillarCentroidXYZ()
    %Gives the centroid coordination of pillars
    load initialDataFile.mat
    load LayerDataFile.mat
    load panelDataFile.mat
    nC = pillarInCol;
    nR = pillarInRow;
    EH = coalLayerThickness;
    CZ = coalLayerDepth+(EH/2);
    
    xmin = -panelX+EW/2 + pEW/2;
    ymin = -panelY+EW/2 + pCW/2;
    sX   = EW + pEW;
    sY   = EW + pCW;
    for i=1:nR
        for j=1:nC
            C1=xmin+i*sX;
            C2=ymin+j*sY;
            
            if (i == 1 && j ==1)
                C = [C1 C2 CZ];
            else
                C = [C;C1 C2 CZ];
            end
        end
    end

end %function pillarCentroid