function [measures,db] = bcfm(bcf,beats,timesig)


if timesig == 0
	timesig =4;
end
% extract measures from bcf and timesig.

for k=1:timesig,
    db(k) = mean(bcf(k:timesig:end));
end

[val,downbeat] = max(db);



if(downbeat ==timesig),
    downbeat = 0;
end

downbeat = downbeat+1;

measures = beats(downbeat:timesig:end);


if 0

    % for extracting batchwise measures...
    for i=1:222,
        meas{1,i} = bcfm(bcfs{i}.spec,anns.beats{i},anns.timesig{i});
        %  meas{2,i} = bcfm(bcf{i}.specs,anns.beats{i},anns.timesig{i});
        meas{2,i} = bcfm(bcfs{i}.cq,anns.beats{i},anns.timesig{i});
        %  meas{4,i} = bcfm(bcf{i}.cqs,anns.beats{i},anns.timesig{i});
        meas{3,i} = bcfm(bcfs{i}.hpcp,anns.beats{i},anns.timesig{i});
        %  meas{6,i} = bcfm(bcf{i}.hpcps,anns.beats{i},anns.timesig{i});
        meas{4,i} = bcfm(bcfs{i}.chroma,anns.beats{i},anns.timesig{i});
        %  meas{8,i} = bcfm(bcf{i}.chromas,anns.beats{i},anns.timesig{i});
        meas{5,i} =  bcfm(bcfs{i}.mfcc,anns.beats{i},anns.timesig{i});
       % y = bcfs{i}.spec+bcfs{i}.cq+bcfs{i}.hpcp+bcfs{i}.chroma+bcfs{i}.mfcc;
      %  meas{6,i} =  bcfm(y,anns.beats{i},anns.timesig{i});

%         % voting mechanism.. find which measures are the same...
%         zz = zeros(5);
%         for k=1:5, 
%             for j=1:5,
%                 zz(k,j) = double(~~sum(meas{k,i}==meas{j,i})); 
%             end
%         end
%         
%         for p=1:5, zz(p,p) = 0; end
%         % find which is similar to another        
%         [val,ind] = max(sum(zz));
%         % and put these in place...
%         meas{6,i} = meas{ind,i};
%         
        
    end
    % and their evaluation
    for j=1:5
        for i=1:222,
            % only need rcl
            [m.rcl(j,i), m.rtot(j,i), m.acl(j,i), m.atot(j,i)]  = cont_eval(anns.actmeasures{i},meas{j,i},0.1);
        end
    end
end

if 0

    % for extracting batchwise measures...
    for i=1:222,
        meas{1,i} = bcfm(bcf{i}.spec,beats{i},timesig{i});
      %  meas{2,i} = bcfm(bcf{i}.specs,anns.beats{i},anns.timesig{i});
        meas{2,i} = bcfm(bcf{i}.cq,beats{i},timesig{i});
      %  meas{4,i} = bcfm(bcf{i}.cqs,anns.beats{i},anns.timesig{i});
        meas{3,i} = bcfm(bcf{i}.hpcp,beats{i},timesig{i});
      %  meas{6,i} = bcfm(bcf{i}.hpcps,anns.beats{i},anns.timesig{i});
        meas{4,i} = bcfm(bcf{i}.chroma,beats{i},timesig{i});
      %  meas{8,i} = bcfm(bcf{i}.chromas,anns.beats{i},anns.timesig{i});
    end
    % and their evaluation
    for j=1:4
        for i=1:222,
            % only need rcl
            [m.rcl(j,i), m.rtot(j,i), m.acl(j,i), m.atot(j,i)]  = cont_eval(anns.actmeasures{i},meas{j,i},0.1);
        end
    end
end

%new classification approach
if 0
fname = '95_HipHopFatty';
[bcf,frame,beats] = getbcfs2(fname); y = kmeans(frame.spec,4);
measures = bcfm(~~abs(diff(y)),beats,4);
figure(1);subplot(311); imagesc(10*log(1+abs(frame.spec'))); axis xy; colormap('hot'); subplot(312); stem(y); axis tight; subplot(313); stem(~~abs(diff(y))); axis tight;
out = playbeats(measures,wavread(fname),44100); wavwrite(out,44100,'~/Desktop/z2.wav');
end
