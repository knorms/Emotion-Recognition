% Run CK+ native landmark data import and run svm

%% Get CK+ Landmark Data
frames = 3; % specify how many expressive frames to include (1 === peak expression only)
% for frames = 1:3 %loop through all frame options
fprintf("Expressive Frames: %d\n",frames)
data = ckFileNavigator(frames); 
data  = ckDataInit(data);

%% Run SVM Classify
[predicted_emotions, data_val, category_lbls, perc_corr, C, Mdl] = svm_classify(data);

%% Print SVM Outcome and save confusion matrix image
fprintf("Percent Correct: %.2f%%\n",perc_corr*100);
%saveas(gcf, ['../../presentation/ck_conf_' num2str(frames) 'frames.bmp'], 'bmp');
% end

%% Investigate distribution of data
labels = [data(:).label];
[y,x] = hist(labels,unique(labels));
bar(x,y)
xticklabels(category_lbls)
set(gca, 'FontSize',12)
for i1=1:numel(y)
    text(x(i1),y(i1),num2str(y(i1),'%0.0f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
% saveas(gcf, '../../presentation/data_emotion_distrib.bmp', 'bmp');