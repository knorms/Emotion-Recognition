frames = 3;
[clm_data, ~]  = clmDataInit(frames);

ck_data = ckFileNavigator(frames); 
ck_data  = ckDataInit(ck_data);
%% Corresponding datapoints from CLM and CK+
%{
cheak left, chin center, cheak right,
eyebrow left left-corner, eyebrow left right-corner
eyebrow right left-corner, eyebrow right right-corner
mouth: left corner, top middle, right corner, bottom middle
mouth: top lip bottom middle, bottom lip top middle
%}
corr_clm = [1,8,15,20,23,19,16,24,26,31,29,45,48,51,54,61,58]; %offset by 1 because diagram starts at 0
corr_ck  = [1,9,17,18,22,23,27,37,40,43,46,49,52,55,58,63,67];

% mouth landmarks
% corr_clm = [45,46,47,48,49,50,51,52,53,54,55,56];
% corr_ck =  [49,50,51,52,53,54,55,56,57,58,59,60];

%% Compare Landmarks
avgdist = [];
for idx = 1:numel(clm_data)
    path = strsplit(clm_data(idx).extPath,'/');
    path = strsplit(path{end},".");
    path = path{1};
    
    clm_pts = clm_data(idx).extreme;
    
    id_ck = 0;
    for i = 1:numel(ck_data)
        if contains(ck_data(i).path, path)
            id_ck = i;
            break;
        end
    end
    if id_ck == 0
        continue;
    end
    ck_pts = ck_data(id_ck).extreme;


    for i = 1:numel(corr_clm)
        avgdist(end+1,1) = clm_data(idx).label;
        avgdist(end, 2) = pdist2(clm_pts(corr_clm(i),:),ck_pts(corr_ck(i),:),'euclidean');
    end
end

%% break out stats by emotion
category_lbls = {'anger', 'contempt', 'disgust', 'fear', 'happy', 'sadness', 'surprise'};

for i = 1:numel(category_lbls)
    fprintf("*** %s ***\n",category_lbls{i});
    ids = find(avgdist(:,1)==i);
    vals = avgdist(ids,2);
    fprintf("mean: %.2f\nstd: %.2f\nmin: %.2f\nmax: %.2f\n",...
        mean(vals), std(vals),min(vals), max(vals));
end
