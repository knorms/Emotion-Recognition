%find the associated ck+ emotion label given the filepath for the clm data points
function label = clmGetLabel(path)
    split = strsplit(path, '/');
    halfPath = split(end);
    split2 = strsplit(halfPath{1}, '_');
    split3 = strsplit(split2{3}, '.');
    
    fileName = strcat(split2{1}, '_', split2{2}, '_', split3{1}, '_emotion.txt');
    fullPath = strcat('../Emotion/', split2{1}, '/', split2{2}, '/', fileName);
    dirPath = strcat('../Emotion/', split2{1}, '/', split2{2}, '/');
    
    A = dir(dirPath);
    [numFiles, ~] = size(A);
    for m = 1:numFiles
        file = A(m, 1);
        if (strcmp(file.name,'.')~=1 && strcmp(file.name,'..')~=1 && strcmp(file.name,'.DS_Store')~=1)
            label = dlmread(fullPath);
        end
    end
end