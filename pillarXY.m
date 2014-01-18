function [x,y]=pillarXY(c,entryWitdh,entrySpacing,crosscutSpacing)
%Inputs:
% c = pillar center coordinate [X,Y]

pillarX = entrySpacing - entryWitdh;
pillarY = crosscutSpacing - entryWitdh;
cx = c(1);
cy = c(2);

X1 = cx + pillarX/2;
X2 = cx - pillarX/2;
Y1 = cy + pillarY/2;
Y2 = cy - pillarY/2;

x=[X1 X2 X2 X1];
y=[Y1 Y1 Y2 Y2];

end