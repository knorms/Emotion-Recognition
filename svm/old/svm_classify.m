function [predicted_emotions, data_val, category_lbls, perc_corr, C, Mdl] = svm_classify(data)
% Emotions: 0=neutral, 1=anger, 2=contempt, 3=disgust, 4=fear, 5=happy, 6=sadness, 7=surprise
category_lbls = {'anger', 'contempt', 'disgust', 'fear', 'happy', 'sadness', 'surprise'};

%% Split into Train and Validation
arr = randperm(length(data));
data_train = data(arr(1:floor(length(data)*0.8)));
data_val = data(arr((floor(length(data)*0.8)):end));

%% Prepare Train Data
dimensionality = 2*size(data(1).difference, 1);
train_labels = [data_train(:).label]';
train_feats = zeros([length(data_train), dimensionality]);
for i = 1:length(data_train)
    train_feats(i,:) = reshape(data_train(i).difference,1,[]);
end

categories = sort(unique(train_labels));

%% Train an SVM for each category (one vs. all)
Mdl = cell(numel(categories),1); % create a on v all model for each category

for i = 1:numel(categories)
    lbls = train_labels == categories(i);
    Mdl{i} = fitcsvm(train_feats, lbls);
end

%% Prepare Validation Data
val_labels = [data_val(:).label]';
val_feats = zeros([length(data_val), dimensionality]);
for i = 1:length(data_val)
    val_feats(i,:) = reshape(data_val(i).difference,1,[]);
end

%% Evaluate Test Images against each SVM
confidences = zeros([length(data_val),numel(categories)]);

for i = 1:numel(categories)
    [~, score] = predict(Mdl{i}, val_feats);
    confidences(:,i) = score(:,2); % confidence automatically calculated by predict
end

%% Assign to most confident match
[~, id] = max(confidences,[],2);
predicted_emotions = categories(id);

perc_corr = sum(val_labels == predicted_emotions)/length(predicted_emotions);
C = confusionmat(val_labels, predicted_emotions);

%% Graph Confusion Matrix
imshow(C,[], 'InitialMagnification', 7000);
colorbar
axis on
xticklabels(category_lbls)
yticklabels(category_lbls)
set(gca, 'xaxisLocation', 'top', 'FontSize',15)
end
