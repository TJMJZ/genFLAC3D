function createBC()
load initialDataFile.mat
load LayerDataFile.mat
load panelDataFile.mat

disp(sprintf(';----------------------------------'));
disp(sprintf(';SET GRAVITY'));
disp(sprintf(';----------------------------------'));
disp(sprintf(';set gravity 0,0,-32'))
disp(sprintf(';ini density 1000.0'))

vStress_Multi = 1.2;
hStress_Multi = (poisson)/(1-poisson);

vStress = vStress_Multi*abs(lDepth(1));
hStress = hStress_Multi*vStress;

zmax    =   lDepth(1)+panelMax*panelMulti;
zmax_t  =   zmax+0.1;
zmax_b  =   zmax-0.1;

zmin    =   lDepth(end)-panelMax*panelMulti;
zmin_t  =   zmin+0.1;
zmin_b  =   zmin-0.1;

xmax    =   panelX*panelMulti;
xmax_t  =   xmax+0.1;
xmax_b  =   xmax-0.1;

xmin    =   -panelX*panelMulti;
xmin_t  =   xmin+0.1;
xmin_b  =   xmin-0.1;

ymax    =   panelY*panelMulti;
ymax_t  =   ymax+0.1;
ymax_b  =   ymax-0.1;

ymin    =   -panelY*panelMulti;
ymin_t  =   ymin+0.1;
ymin_b  =   ymin-0.1;

disp(sprintf(';----------------------------------'));
disp(sprintf(';DEFINE FIX CONDITION'));
disp(sprintf(';----------------------------------'));
disp(sprintf('fix x range x %2.1f %2.1f',xmin_b,xmin_t));
disp(sprintf('fix x range x %2.1f %2.1f',xmax_b,xmax_t));
disp(sprintf('fix y range y %2.1f %2.1f',ymin_b,ymin_t));
disp(sprintf('fix y range y %2.1f %2.1f',ymax_b,ymax_t));
disp(sprintf('fix z range z %2.1f %2.1f',zmin_b,zmin_t));
disp(sprintf(' '));
disp(sprintf(';----------------------------------'));
disp(sprintf(';INITIAL STRESS'));
disp(sprintf(';----------------------------------'));
disp(sprintf(';ini szz -%2.1f ',vStress));
disp(sprintf(';ini sxx -%2.1f ',hStress));
disp(sprintf(';ini syy -%2.1f ',hStress));
disp(sprintf(' '));
disp(sprintf(';ini szz -1 grad 0,0,%2.1f',vStress_Multi));
disp(sprintf(';ini sxx -1 grad 0,0,%2.1f',hStress_Multi));
disp(sprintf(';ini syy -1 grad 0,0,%2.1f',hStress_Multi));
disp(sprintf(' '));
disp(sprintf(';----------------------------------'));
disp(sprintf(';APPLY VERTICAL STRESS'));
disp(sprintf(';----------------------------------'));
disp(sprintf('apply szz -%2.1f range z %2.1f1,%2.1f',vStress,zmax_b,zmax_t));
disp(sprintf(' '));

end