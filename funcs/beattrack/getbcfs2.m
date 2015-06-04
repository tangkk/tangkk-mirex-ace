function [bcf,frame,beats] = getbcfs2(fname,beats);



if nargin<2

    [x fs] = wavread(fname);
    x = mean(x,2);
    if fs~=44100
        x = resample(x,44100,fs);
    end
    p = bt_parms;

    df = get_dfs(x(1:4:end),bt_parms(0.01161*4));
    [beats,timesig] = newtt_mm(df{1},p);
    beats = beatadjust(beats,df{1});
end



beats = beats(:)';

finfo = audioinfo(fname);
siz = [finfo.TotalSamples, finfo.NumChannels];
% siz = wavread(fname,'size');
[x fs] = audioread(fname);
x = mean(x,2);
%  if siz(2)>1
%      x = mean(x')';
%  end

if fs ~= 44100
    x = resample(x,44100,fs);
end

beats = round(beats);
beats(beats>length(x)) = [];
beats = sort(beats);
%beats = beats - 4096;
%beats(beats<1) = 1;

%  
%  spark = sparsekernel(110, 880, 36, 44100/16, 0.054);
%  spark(1025:end,:) = [];
spark = 1;

for k=1:length(beats)-1
%      [spec(k,:),mfcc(k,:), cq(k,:),hpcp(k,:),chroma(k,:)] = chromaframe(x(beats(k):beats(k+1)),spark);
    [spec(k,:)] = chromaframe(x(beats(k):beats(k+1)),spark);

end



for k=1:size(spec,1)-1,

%     bcf.spec(k) = dobeatkl(spec(k,:),spec(k+1,:));
%     bcf.cq(k) = dobeatkl(cq(k,:).^2,cq(k+1,:).^2);
%     bcf.hpcp(k) = dobeatkl(hpcp(k,:).^2,hpcp(k+1,:).^2);
%     bcf.chroma(k) = dobeatkl(chroma(k,:).^2,chroma(k+1,:).^2);
%     bcf.mfcc(k) = dobeatkl(mfcc(k,:).^2,mfcc(k+1,:).^2);
    bcf.spec(k) = dojsdiv2(spec(k,:),spec(k+1,:));
%      bcf.cq(k) = dojsdiv2(cq(k,:),cq(k+1,:));
%      bcf.hpcp(k) = dojsdiv2(hpcp(k,:),hpcp(k+1,:));
%      bcf.chroma(k) = dojsdiv2(chroma(k,:),chroma(k+1,:));
%      bcf.mfcc(k) = dojsdiv2(mfcc(k,:),mfcc(k+1,:));

end


%  bcf.spec=adapt_thresh(bcf.spec,2,1);

frame.spec = spec;

%  % my added bit
%  temp = 0*spec;
%  for i=1:length(temp)-1
%  	temp(i)=spec(i)+0.2/spec(i+1);
%  end
%  frame.spec = temp;



%  frame.cq = cq;
%  frame.hpcp = hpcp;
%  frame.chroma = chroma;
%  frame.mfcc = mfcc;

% for i=1:222, [c,n] = meterTracker(wavread(files(i+2).name),44100); kc{i} = round(44100*c.measures); kn{i} = round(44100*n.measures); if~mod(i,10),i,end; clear c; clear n; end
