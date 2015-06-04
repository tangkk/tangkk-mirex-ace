function [dfout,m] = adapt_thresh(df,pre,post);




df = df(:)';
% uses juan's adaptive median threshold

alpha = 9;
thresh=0.033;
fn = @mean;

if(nargin<2)
    pre = 8;
    post = 7;
end

%df = df-min(df);
%alpha norm
%df = df/real(mean(abs(df+eps).^alpha).^(1/alpha));   




% low pass filtering

%[b,a]=butter(2,0.28);

%b = [0.1600 0.3200 0.1600];
%a = [1.0000 -0.5949 0.2348];


%df=filtfilt(b,a,df);


% median threshold

N=length(df);

for i=1:min(post,N)
	k=min(i+pre,N);
	m(i)=feval(fn,df(1:k));
  %  m2(i) = feval(@mean,df(1:k));
end

if N>(post+pre)
	m=[m feval(fn,buffer(df,post+pre+1,post+pre,'nodelay'))];
end

% if N>(post+pre)
% 	m2=[m2 feval(@mean,buffer(df,post+pre+1,post+pre,'nodelay'))];
% end

for i=N+(1-pre:0)
	j=max(i-post,1);
	m(i)=feval(fn,df(j:end));
%    m2(i)=feval(@mean,df(j:end));
end

%df = (df- m*thresh);
df = df-m;

dfout = (df>0).*df;
%dfout = df;