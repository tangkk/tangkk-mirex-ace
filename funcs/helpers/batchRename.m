function batchRename(path)

% Get all mp3 files in the current folder
files = dir([path '*.mp3']);
% Loop through each
for id = 1:length(files)
    % Get the file name (minus the extension)
    [~, f] = fileparts(files(id).name);
    movefile([path files(id).name], [path 'T' num2str(id) '.mp3']);
end