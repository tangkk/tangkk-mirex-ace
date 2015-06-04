function out = getmeasures4(fname,ts);

if nargin<2
	% optional argument to hand label the timesignature
    ts = 0;
end

sz = wavread(fname,'size');

[x fs] = wavread(fname);
x = mean(x,2);

if fs~=11025,
    x = resample(x,11025,fs);
end

x = x + randn(length(x),1) * 0.0000001;

df = get_dfs(x,bt_parms(0.01161*4));
disp 'onset detection function'

[beats,localscore,timesig] = newtt_hmm_dp(df{1});
disp 'beats'

% [bcf,frame] = getbcfs2(fname,beats);
% if~timesig, timesig = 4; end
% 
% if ts
%     measures = bcfm(bcf.spec,beats,ts);
% else
%     measures = bcfm(bcf.spec,beats,timesig);
% end
reduced_fs = 86.12;
% x = resample(x,reduced_fs,11025);
% x = abs(x);
winlength = round(reduced_fs/10/2)*2;
win = gausswin(winlength);
earlybeats = [0 mean([beats(2:end);beats(1:end-1)])];




% for iBeat = 1:length(beats)
%     beatindex = max(round(beats(iBeat)/(44100/reduced_fs)),winlength/2+1);
%     earlybeatindex = max(round(earlybeats(iBeat)/(44100/reduced_fs)),winlength/2+1);
% %     beatstrength = sum(x(beatindex-winlength/2+(1:winlength)) .* win);
%     beatstrength = sum(localscore(beatindex-winlength/2+(1:winlength))' .* win);
% %     earlybeatstrength = sum(x(earlybeatindex-winlength/2+(1:winlength))
% %     .* win);
%     earlybeatstrength = sum(localscore(earlybeatindex-winlength/2+(1:winlength))' .* win);    
%     if earlybeatstrength > 1.5 * beatstrength
%         beats(iBeat) = earlybeats(iBeat);
%     end
% end

out.beats = beats/44100;
% out.measures = measures/44100;
% out.timesig = timesig;
% out.df = df{1};
