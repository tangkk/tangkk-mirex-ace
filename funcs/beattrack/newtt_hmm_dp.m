function [beats,localscore,timesig,ppath] = newtt_hmm_dp(df,tempo)

if nargin<2
	tempo = 0;
end

beats = [];

p = bt_parms;

df = df(:)';
%  
% df = df/alpha_norm(9,df);
df = qnormalise(df,9,2);

% work out period track with viterbi decoding
[ppath,obs,prob,wv]= tempo_hmm(df,p.step,tempo);

%  ppp=textread('home/studio/Desktop/path.txt');
%  ppp = [ppp(:)' ppp(end)*ones(1,2)];
%  ppath = ppp;

ppath(ppath<20) = 20;
dp = abs(diff(ppath));
dp = [0 dp(:)'];
dp(dp>16) = 16; 
%  plot(dp),pause(0.01);
% now incorporate ellis' dynamic programming,
% but for time-varying period....! 


tempmat = (ppath'*ones(1,p.step))';
pd = round(tempmat(:));
%  length(pd)


%  df = abs(diff(df));
% prob = 0.5+0.5*prob/max(prob);
% prob = 4*prob;

%  prob = 4*prob/max(prob);


%  a=ftacf(adapt_thresh(df));
%  a=a(1:512);
%  [tmp,r]=getperiod(a,wv,0,128,1,0);
%  r=sunity(r);
%  val=max(r);
%  tightness = 100*val;
tightness= [4]; % want to try and get a tightness out of the signal automatically...

	
alpha=0.8;
mpd = round(median(ppath));
templt = exp(-0.5*(([-mpd:mpd]/(mpd/32)).^2));
localscore = conv(templt,df);
% this removes the offset imposed by the filtering...

localscore = localscore(round(length(templt)/2)+[1:length(df)]);
localscore = localscore/sum(localscore);


aacf = ftacf(localscore);
[timesig] = findmeter_mm(aacf(1:512),mpd);

%  %  subplot(311); plot(localscore);
%  %  al = localscore;
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %%%% little bootstrap on phase
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  apin = 0;
%  awinlen=512;
%  astep = 128;
%  apend = length(localscore)-2*awinlen;
%  ak = 0;
%  while (apin<apend)
%  	ak = ak+1;
%  	align = getalignment2(localscore(apin+1:apin+awinlen),ones(1,pd(ak)),pd(ak),0);
%  	try
%  		localscore(apin+align-4:apin+align+4) = (1+gausswin(9)').*localscore(apin+align-4:apin+align+4);
%  	catch
%  		temp_a = 1;
%  	end	
%  	apin=apin+astep;
%  end
%  
%  %  subplot(312); plot(localscore);
%  %  subplot(313); plot(al-localscore);
backlink = zeros(1,length(localscore));
cumscore = zeros(1,length(localscore));

starting = 1;
for i = 1:length(localscore)
%  	pause;
%  	i
% search range for previous beat
	prange = round(-2*pd(i)):-round(pd(i))/2;

%   want to update tightness based on periodicity change..
	% or as andrew does.. whether it's an important beat.
	% Skewed window
	mu = -pd(i);
%  	tightness = prob(ceil(i/128));
%  	sigma = pd(i)/4;
%  	txwt = exp(-0.5 * ((prange - mu)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
	txwt = exp( -0.5*  (  (  ( tightness    - 1* log(1+dp(ceil(i/128))) )   *   log(prange/-pd(i))).^2)  );
%  	txwt = -(prange ./ mu.^ 2) .* exp(-prange .^ 2 ./ (2*mu .^ 2));
%  	txwt = txwt.^2;
%  	keyboard
	timerange = i + prange;

% Are we reaching back before time zero?
	zpad = max(0, min(1-timerange(1),length(prange)));
% Search over all possible predecessors and apply transition 
% weighting
	scorecands = txwt .* [zeros(1,zpad),cumscore(timerange(zpad+1:end))];
% Find best predecessor beat
	[vv,xx] = max(scorecands);
% Add on local score
	cumscore(i) = alpha*vv + (1-alpha)*localscore(i);

% special case to catch first onset
%  if starting == 1 & localscore(i) > 100*abs(vv)
	if starting == 1 & localscore(i) < 0.01*max(localscore);
		backlink(i) = -1;
	else
		backlink(i) = timerange(xx);
		% prevent it from resetting, even through a stretch of silence
		starting = 0;
	end

end


%try
%	align = getalignment2(localscore(end-1024:end),ones(1,2*pd(end)),2*pd(end),0);
%catch
	align = getalignment2(localscore(end-512:end),ones(1,1*pd(end)),1*pd(end),0);
%end

b = [];
b = length(df) - align;

%  b = bestendx;

while backlink(b(end)) > 0
b = [b,backlink(b(end))];
end


b = fliplr(b);

% return beat times in secs
beats = (b*512); % seems to be an offset.
beats(beats<1) = [];
%  
%  otherbeats{kk} = b;
%  score(kk) = dfscore(b,df);		
%  [val,ind] = max(score);
%  beats = otherbeats{ind};
%  beats = 512*(length(df)-beats/512); 
%  beats = sort(beats);
