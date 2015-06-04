function [path,obs,prob,wv,tmat,posterior]= tempo_hmm(df,step,tempo,tightness)


%  if nargin<4
%  	step = 128;
%  	tempo = 0;
%  	tightness = 8;
%  end

if nargin<3
	step = 128;
	tempo = 0;
end

% df = df/alpha_norm(9,df);
df = qnormalise(df,9,2);
p = bt_parms;
winlen = 512;



df = [df(:)' zeros(1,winlen/2)]; % add half a frame... then fix last 2 values
% try using matlab hmm to do tempo tracking...
df = df(:)';

pin = 0;
pend = length(df) - winlen;
n = [1:128];
%  p.rayparam = 33;

if tempo
	mu = p.fact/tempo;
	sigma = mu/4;
	wv = exp(-0.5 * ((n - mu)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
else
	wv = (n ./ p.rayparam .^ 2) .* exp(-n .^ 2 ./ (2*p.rayparam .^ 2));
end

wv = sunity(wv);
lenwv = length(wv);
%  wv = ~~wv;

ct = 0;
while(pin<pend)


	ct = ct+1;
	segment = adapt_thresh(df(pin+1:pin+winlen));
%  	acf(:,ct) = (ftacf(segment));
	acf(:,ct) = [ ftacf(segment(:))' zeros(1,512-winlen)]';

	[temp,rcf] = getperiod(acf(:,ct),wv,0,128,1,p.lowest);
	temp2 = adapt_thresh(rcf);
%  	st = sum(temp2);
%  	temp3 = zeros(1,lenwv);
%  	tempmat = zeros(lenwv);
%  	for i=1:lenwv,
%  		for j=1:lenwv,
%  			tempmat(i,j) = (temp2(i)+temp2(j));
%  		end
%  		tempmat(i,i) = 0;
%  	end;	
%  	temp3 = sum(tempmat); %plot(temp3); pause;
	temp3=temp2;
	temp3 = temp3'.*(acf(1:length(temp3),ct));
%  	temp3 = acf(1:length(wv),ct);
%  	temp(1:10) = 0;
%  	temp(118:end) = 0;
%  	temp3(1:10) = 0;

%  	for i=1:lenwv,
%  		temp4(i) = temp2(i)+st;
%  	end
%  	keyboard
% 	obs(:,ct) = sunity(temp3(:)); %% WAS NOT COMMENTED WHEN MATTHEW GAVE IT
% 	TO ME.
    obs(:,ct) = sunity(rcf) + 0.001*rand(1,length(rcf));
%  	obs(:,ct) = (temp3(:));
%  	keyboard
%  	obs(:,ct) = sunity(adapt_thresh(rcf(:)));


	pin = pin+step;
end



tmat = zeros(128);
% make transition matrix
for i=20:118, tmat(:,i) = sunity(normpdf(n,i,8))'; end;
%  %  [alpha, beta, gamma] = fwdback(wv,tmat,obs);
%  figure; mesh(tmat); 

%  t = textread('/home/studio/Desktop/tmat.txt');
%  
%  tmat = reshape(t,128,128);
%  %  figure(1); mesh(tmat);
%  
%  for i=1:size(tmat,1)
%  	tmat(i,:) = 1/128+filtfilt(gausswin(9),1,tmat(i,:));
%  end
%  
%  for i=1:size(tmat,2)
%  	tmat(:,i) = 1/128+filtfilt(gausswin(9),1,tmat(:,i));
%  end
%  for i=1:size(tmat,2)
%  	tmat(:,i) = sunity(tmat(:,i));
%  end
%  %  figure; mesh(tmat); 
%  tmat(1:20,:) = 0;
%  tmat(:,1:20) = 0;
%  tmat(120:128,:) = 0;
%  tmat(:,120:128) = 0;



%  figure(2);  mesh(tmat);

%  keyboard
% [path,posterior] = viterbi_path(wv,tmat,obs);
path = viterbi_path(wv,tmat,obs);
% try tracking backwards.. probably doesn't matter
%% FIXME - forwards backwards?
%  [path,posterior] = viterbi_path(wv,tmat,fliplr(obs));
%  path = fliplr(path);
%  path

%  obs = obs/sum(sum(obs));

% 
% for i=1:length(path),
% % 	prob(i) = sum(obs(path(i)-2:path(i)+2,i));
% 
%     prob(i) = sum(obs(path(i)-2:path(i)+2,i));
% 
% %     range = max(min(size(obs,1),path(i)-2:path(i)+2),1);
% %     prob(i) = sum(obs(range,i));
% 
% 	%path(i)= refineperiod(path(i),acf(:,i),0);
% end

path = [path path(end)*ones(1,2)];
prob = 1;


%  path = interp(path,2);

% for i=1:222, [r(1,i),r(2,i),r(3,i),r(4,i)]=cont_eval(anns.beats{i},beats{i},0.175);end; mean(r')
