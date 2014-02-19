function genPillarHistory()

load LayerDataFile.mat;
load InitialDataFile.mat;
load panelDataFile.mat;

numberOfPillars = pillarInCol * pillarInRow;

C = pillarCentroidXYZ();
pZ = C(1,3);
pZt = coalLayerDepth;
pZb = coalLayerDepth + coalLayerThickness;

for i = 1:numberOfPillars
    
    [pX,pY]=pillarCornerXY(C(i,:),EW,EC,XC);
    
    genPillarHistory_Stress(i,pX,pY,pZ);
    genPillarHistory_Stain(i,pX,pY,pZt,pZb);
    
    disp(sprintf('hist add fish @stress_%i',i));
    disp(sprintf('hist add fish @strain_%i',i));
    
end

end %function getPillarHistory