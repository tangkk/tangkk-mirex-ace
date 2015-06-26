 function [bdrys, basegram, uppergram] = midEndDecode(S, btrack, meparam, df, enPlot)

nslices = size(S, 2);
ntones = size(S, 1);

% interface the original salience to a gestaltized salience
Sg = S;

if meparam.enGesComp
st = 0.0;
Sg = compensateLongSalience(Sg,meparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(Sg, 1:nslices, 1:ntones, 'slice', 'semitone', 'positive gestalt note salience matrix');
end
end

if meparam.enGesRed
st = 0.0;
Sg = reduceShortSalience(Sg,meparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(Sg, 1:nslices, 1:ntones, 'slice', 'semitone', 'negative gestalt note salience matrix');
end
end

if meparam.useBassOnsetSegment || meparam.useBassOnsetMedianSegment
Shc = harmonicSegmentation(Sg, meparam.wgmax, 0, enPlot);
end

if meparam.useOriginalSalience
    SpreSeg = S;
elseif meparam.useGestaltSalience
    SpreSeg = Sg;
end

% use different segmentation methods
if meparam.noSegmentation
    bdrys = 1:nslices;
elseif meparam.useBassOnsetSegment
    bdrys = Shc;
elseif meparam.useWgSegment
    bdrys = 1:meparam.wgmax:nslices;
elseif meparam.useBeatSyncSegment
    bdrys = btrack;
elseif meparam.useBassOnsetMedianSegment
    bdrys = 1:round(median(Shc(2:end) - Shc(1:end-1))):nslices;
end

if bdrys(end) ~= nslices % including the end slice
    bdrys = [bdrys nslices];
end
if bdrys(1) ~= 1
    bdrys = [1 bdrys];
end

if meparam.noSegmentation
    Sseg = SpreSeg;
else
    Sseg = zeros(size(SpreSeg,1), length(bdrys) - 1);
    for j = 1:size(Sseg,2)
        if meparam.useMedianFilter
            Sseg(:,j) = median(SpreSeg(:,bdrys(j):bdrys(j+1)),2);
        elseif meparam.useMeanFilter
            Sseg(:,j) = mean(SpreSeg(:,bdrys(j):bdrys(j+1)),2);
        end
    end
end
if df && enPlot
myImagePlot(Sseg, 1:size(Sseg,2), 1:ntones, 'segmentation',...
    'semitone', 'note salience segmentation matrix');
end

ntones = size(Sseg,1);
nsegs = size(Sseg,2);
if meparam.enProfiling
ht = hann(ntones); ht = ht ./ norm(ht,1);
hb = [hann(ntones/2);zeros(ntones/2,1)]; hb = hb ./ norm(hb,1);
mht = repmat(ht,1,nsegs);
mhb = repmat(hb,1,nsegs);
Stsegout = Sseg .* mht;
Sbsegout = Sseg .* mhb;
if df && enPlot
myImagePlot(Stsegout, 1:nsegs, 1:ntones, 'slice', 'semitone', 'treble note salience matrix');
end
if df && enPlot
myImagePlot(Sbsegout, 1:nsegs, 1:ntones, 'slice', 'semitone', 'bass note salience matrix');
end
end

% compute basegram and uppergram (based on harmonic change matrix)
if meparam.enProfiling && meparam.btchromagram
    % note this is to compute chromagram
    basegram = computeChromagram(Sbsegout);
    uppergram = computeChromagram(Stsegout);
elseif meparam.enProfiling
    basegram = computeBasegram(Sbsegout);
    uppergram = computeUppergram(Stsegout);
else
    basegram = computeBasegram(Sseg);
    uppergram = computeUppergram(Sseg);
end

% normalize grams (whether global or local)
uppergram = normalizeGram(uppergram,meparam.normalization);
basegram = normalizeGram(basegram,meparam.normalization);

bassnotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
treblenotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
if df && enPlot
myImagePlot(basegram, 1:nsegs, 1:12, 'segmentation progression order', 'semitone',...
    'basegram', 1:12, bassnotenames);
myImagePlot(uppergram, 1:nsegs, 1:12, 'segmentation progression order', 'semitone',...
    'uppergram', 1:12, treblenotenames);
end
