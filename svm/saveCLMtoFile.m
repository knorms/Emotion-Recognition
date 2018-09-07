function saveCLMtoFile(processedData)
difference = zeros(numel(processedData),71*2);
for i = 1:numel(processedData)
    difference(i,:) = reshape(processedData(i).difference,1,[]);
end

emotion_labels = [processedData(:).label];

%% Divide testing & validation
arr = randperm(length(difference));
diff_train = difference( arr(1:floor(length(difference)*0.80)), : );
diff_val = difference( arr(floor(length(difference)*0.80)+1:end), : );

emo_train = emotion_labels( arr(1:floor(length(difference)*0.80)) );
emo_val = emotion_labels( arr(floor(length(difference)*0.80)+1:end) );

%% Save text files
save('diff_train.txt','diff_train','-ascii');
save('diff_val.txt','diff_val','-ascii');

save('emo_train.txt','emo_train','-ascii');
save('emo_val.txt','emo_val','-ascii');

end