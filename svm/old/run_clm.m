% Run CLM data import, display stats on failures to converge, run svm

%% Get CLM Data
% frames = 3; % specify how many expressive frames to include (1 === peak expression only)
for frames = 1:3 %loop through all frame options
fprintf("Expressive Frames: %d\n",frames)
[data, failed]  = clmDataInit(frames);%would default to frames = 3 if frames arg not included

%% Run SVM Classify
[predicted_emotions, data_val, category_lbls, perc_corr, C, Mdl] = svm_classify(data);

%% Print SVM Outcome and save confusion matrix image
fprintf("Percent Correct: %.2f%%\n",perc_corr*100);
saveas(gcf, ['../../presentation/clm_conf_' num2str(frames) 'frames.bmp'], 'bmp');
end

%% Print Stats on CLM Failures to Converge
data_pts = size(failed,1)*.75;

all4failed = failed.fail_e1==1 & failed.fail_e2==1 & failed.fail_e3 == 1 & failed.fail_n == 1;
fprintf("%d of %d (%.1f%%) failed all 4 frames (neutral + three expression)\n", ...
    sum(all4failed), data_pts, sum(all4failed)/data_pts);

neutfailed = failed.fail_n == 1;
fprintf("%d of %d (%.2f%%) failed neutral\n", ...
    sum(neutfailed), data_pts, sum(neutfailed)*100/data_pts);

extr1failed = failed.fail_e1 == 1;
fprintf("%d of %d (%.2f%%) Failed extreme1 (3rd-to-last frame)\n", ...
    sum(extr1failed), data_pts, sum(extr1failed)*100/data_pts);

extr2failed = failed.fail_e2 == 1;
fprintf("%d of %d (%.2f%%) failed extreme2 (2rd-to-last frame)\n", ...
    sum(extr2failed), data_pts, sum(extr2failed)*100/data_pts);

extr3failed = failed.fail_e3 == 1;
fprintf("%d of %d (%.2f%%) failed extreme3 (last/peak expression frame)\n", ...
    sum(extr3failed), data_pts, sum(extr3failed)*100/data_pts);

for frames = 1:3
if frames == 3
    failed_any = failed.fail_e1==1 | failed.fail_e2==1 | failed.fail_e3 == 1 | failed.fail_n == 1;
elseif frames == 2
    failed_any = failed.fail_e2==1 | failed.fail_e3 == 1 | failed.fail_n == 1;
elseif frames == 1
    failed_any = failed.fail_e3 == 1 | failed.fail_n == 1;
end

data_pts = size(failed,1)*.25*frames;

fprintf("\n%d of %d (%.2f%%) datapoints unusable with %d frames due to some failure to converge\n",...
    sum(failed_any),data_pts, (sum(failed_any)/data_pts)*100, frames);
end