function out = getmeasures3(x,fs,ts);

if nargin<2
	% optional argument to hand label the timesignature
    ts = 0;
end


% [x fs] = wavread(fname);
% x = mean(x,2);

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



out.beats = beats/44100;
% out.measures = measures/44100;
% out.timesig = timesig;
% out.df = df{1};
