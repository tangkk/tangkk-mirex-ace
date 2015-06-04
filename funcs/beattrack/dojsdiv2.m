function sd = dojsdiv2(pre,post);

pre = pre-min(pre);
post = post-min(post);
pre = pre(:)';
post = post(:)';
pre = pre+eps;
post = post+eps;
pre = pre/sum(pre);

pi1 = 0.5;
pi2 = 0.5;

% normalise to sum to unity
pre = pre/(sum(pre)+eps);
post = post/(sum(post)+eps);

% combined distribution
a1 = pi1*pre + pi2*post;

%sd = -sum(a1.*log(a1)) + pi1*sum(pre.*log(pre)) + pi2*sum(post.*log(post));


sd = sum((-a1.*log(a1)) + pi1*(pre.*log(pre)) + pi2*(post.*log(post)));
