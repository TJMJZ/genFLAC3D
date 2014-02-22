function numError = importChecker()
numError = 0;
% This function checks imported data and does not let program continue
% if there is an input error present
load LayerDataFile
load panelDataFile
load initialDataFile


%check panelMulti input
if (panelMulti < 1)
    numError=numError+ 1;
    disp('ERROR : panelMulti is less than one')
end

%check panelMulti and genType compatibility
if (strcmp(genType,'radtunnel') && panelMulti  == 1)
    numError=numError+ 1;
    disp('ERROR : panelMulti and genType do not match')
    
elseif (strcmp(genType,'radtunnel') && panelMulti  > 1)
    %OK
elseif (strcmp(genType,'brick') && panelMulti >= 1)
    %OK
else
    numError=numError+ 1;
    disp('ERROR : genType not found')
end


end