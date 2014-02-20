function createExcavate()
    load initialDataFile.mat
    load LayerDataFile.mat
    load panelDataFile.mat
    nC = pillarInCol;
    nR = pillarInRow;
    numberOfPillar = nC * nR;
    EH = coalLayerThickness;
    coalDepth = coalLayerDepth;
    
    disp(sprintf(';----------------------------------'));
    disp(sprintf(';EXCAVATE ENTRIES AND CROSSCUTS'));
    disp(sprintf(';----------------------------------'));
    
    C = pillarCentroidXYZ();
    
    for i=1:numberOfPillar
    [pX,pY]=pillarCornerXY(C(i,:),EW,EC,XC);
    [excX,excY,excZ]=excavateXYZ(pX,pY,EW,EH,coalDepth);
    [X,Y,Z]=excavateRange(pX,pY,excX,excY,excZ);
    %disp(sprintf(';range name entry1 x=%2.1f,%2.1f y=%2.1f,%2.1f z=%2.1f,%2.1f',X(1),X(2),Y(1),Y(2),Z(1),Z(2)));
    %disp(sprintf(';range name entry2 x=%2.1f,%2.1f y=%2.1f,%2.1f z=%2.1f,%2.1f',X(3),X(4),Y(3),Y(4),Z(3),Z(4)));
    %disp(sprintf(';range name xcut1 x=%2.1f,%2.1f y=%2.1f,%2.1f z=%2.1f,%2.1f',X(5),X(6),Y(5),Y(6),Z(5),Z(6)));
    %disp(sprintf(';range name xcut2 x=%2.1f,%2.1f y=%2.1f,%2.1f z=%2.1f,%2.1f',X(7),X(8),Y(7),Y(8),Z(7),Z(8)));
    %disp(sprintf(';model mech null range nrange entry1'));
    %disp(sprintf(';model mech null range nrange entry2'));
    %disp(sprintf(';model mech null range nrange xcut1'));
    %disp(sprintf(';model mech null range nrange xcut2'));
 
     disp(sprintf('group zone zonk range x=%2.1f,%2.1f y=%2.1f,%2.1f z=%2.1f,%2.1f',...
        X(1),X(2),Y(1),Y(2),Z(1),Z(2)));
    disp(sprintf('group zone zonk range x=%2.1f,%2.1f y=%2.1f,%2.1f z=%2.1f,%2.1f',...
        X(3),X(4),Y(3),Y(4),Z(3),Z(4)));
    disp(sprintf('group zone zonk range x=%2.1f,%2.1f y=%2.1f,%2.1f z=%2.1f,%2.1f',...
        X(5),X(6),Y(5),Y(6),Z(5),Z(6)));
    disp(sprintf('group zone zonk range x=%2.1f,%2.1f y=%2.1f,%2.1f z=%2.1f,%2.1f',...
        X(7),X(8),Y(7),Y(8),Z(7),Z(8)));
    
    end
 
 disp(sprintf(';model mech null range group zonk'));
end