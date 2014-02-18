function [X,Y,Z]=excRange(pX,pY,excX,excY,excZ)
  % X(1)->X(4) for entry
  %X(5)->X(8) for crosscut
  X = [pX(1)   excX(1) excX(2) pX(2)   excX(2) excX(1) excX(2) excX(1)];
  Y = [excY(4) excY(1) excY(4) excY(1) pY(1)   excY(1) excY(4) pY(4)];
  Z = [excZ(2) excZ(1) excZ(2) excZ(1) excZ(2) excZ(1) excZ(2) excZ(1)];
end