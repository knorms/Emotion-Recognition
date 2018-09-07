function emotion = emotion_detector(neutral, extreme)
%import image data as taken from clm_trackr

data = dataInit();
[~, ~, ~, Mdl] = svm_classify(data);

[~, e_align] = procrustes(neutral,extreme);
emotion_feature = neutral - e_align;

confidences = zeros([1,length(Mdl)]);
for i = 1:length(Mdl)
    [~, score] = predict(Mdl{i}, emotion_feature(1:136));
    confidences(:,i) = score(:,2);
end
emotion = confidences

end