% this function generates raw cv data for each dataset in the cvlist

function cvRawGen(cvrawfolder, cvlistfolder)

A_ = dir(cvlistfolder);
A = {A_.name};

for i = 3:length(A)
    cvlist = A{i};
    gtlist = [cvlistfolder,cvlist];
    
    % 1seg
%     savename = [cvrawfolder, cvlist(1:end-4), '-1seg.mat'];
%     trainingDataGenNSeg(savename, gtlist, 1, 0, 0);
    
    % 2seg
%     savename = [cvrawfolder, cvlist(1:end-4), '-2seg.mat'];
%     trainingDataGenNSeg(savename, gtlist, 2, 0, 0);
    
    % 3seg
%     savename = [cvrawfolder, cvlist(1:end-4), '-3seg.mat'];
%     trainingDataGenNSeg(savename, gtlist, 3, 0, 0);
    
    % 6seg
%     savename = [cvrawfolder, cvlist(1:end-4), '-6seg.mat'];
%     trainingDataGenNSeg(savename, gtlist, 6, 0, 0);
    
    % 9seg
%     savename = [cvrawfolder, cvlist(1:end-4), '-9seg.mat'];
%     trainingDataGenNSeg(savename, gtlist, 9, 0, 0);
    
    % 12seg
%     savename = [cvrawfolder, cvlist(1:end-4), '-12seg.mat'];
%     trainingDataGenNSeg(savename, gtlist, 12, 0, 0);

    % songwise
    savename = [cvrawfolder, cvlist(1:end-4), '-songwise.mat'];
    trainingDataGenSongWise(savename, gtlist, 0, 0);
end
