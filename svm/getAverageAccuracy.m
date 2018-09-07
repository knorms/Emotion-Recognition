function [avg, avgByEmotion] = getAverageAccuracy(data) 
    percentCorrectByEmotion = zeros(8,7);
    for i=1:5
        [pe, dv, cl, pc, c, mdl,pcbe] = svm_classify(data);
         percentCorrect(i) = pc;   
         percentCorrectByEmotion(i,:) = pcbe;
    end
    avg = mean(percentCorrect);
    
    
    percentCorrectByEmotion;
    avgByEmotion = zeros(1,7);
    for i=1:length(pcbe)
        avgByEmotion(1,i) = mean(percentCorrectByEmotion(:,i));
    end
    avgByEmotion = 0;
end