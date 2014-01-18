function [excX,excY,excZ]=excXYZ(pX,pY,EW,EH,coalDepth)
scale = EW/2;
excX = [ pX(1) + scale ; pX(2)-scale ; pX(3)-scale; pX(4)+scale];
excY = [ pY(1) + scale ; pY(2)+scale ; pY(3)-scale; pY(4)-scale];
excZ = [ coalDepth ;coalDepth-EH];
end