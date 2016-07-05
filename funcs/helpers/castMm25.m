% cast the ground truth label to majmin labels
function nch = castMm25(och)

och_ = castGtLabel(och, 1, 0);
nch = castGtLabel(och_, 0, 1);