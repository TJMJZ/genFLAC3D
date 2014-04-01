function createResult(RESULT)
load inputDataFile.mat


if RESULT ==1
    disp(sprintf(''))
    disp(sprintf(';>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'))
    disp(sprintf(';write pillar stress-strain data to file'))
    disp(sprintf(';>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'))
    disp(sprintf(''))
    for i=1:pillarInRow*pillarInCol
        disp(sprintf('hist write %i vs %i table %i',2*i,2*i+1,i+100))
        disp(sprintf('table %i write  Pillar_SS\\pSS_1_%i',i+100,i))
    end
    disp(sprintf(''))
elseif RESULT ==2
    disp(sprintf(''))
    disp(sprintf(';>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'))
    disp(sprintf(';write pillar stress-strain data to file'))
    disp(sprintf(';>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'))
    disp(sprintf(''))
    for i=1:pillarInRow*pillarInCol
        disp(sprintf('hist write %i vs %i table %i',2*i,2*i+1,i+100))
        disp(sprintf('table %i write  Pillar_SS\\pSS_2_%i',i+100,i))
    end
end
disp(sprintf('plot set distance 150'))
disp(sprintf('plot bitmap filename=SZZ.PNG'))
end