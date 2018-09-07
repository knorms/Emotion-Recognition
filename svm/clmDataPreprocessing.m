function finalData = clmDataPreprocessing(data)

%% normalize: subtract local mean from x and y vectors separately
%[~, dataSize] = size(data);
%
% for n = 1:dataSize
%     meanX = mean(data(n).difference(:,1));
%     meanY = mean(data(n).difference(:,2));
%     stdX = std(data(n).difference(:,1));
%     stdY = std(data(n).difference(:,2));
%     data(n).difference(:,1) = (data(n).difference(:,1) - meanX)/(stdX);
%     data(n).difference(:,2) = (data(n).difference(:,2) - meanY)/(stdY);
%     %was originally dividing by 2*std but that worsened results:
%     %with division by 2 (average acc with 30 runs) 0.6145
%     %without division by 2 (average acc with 30 runs) 0.6301
% end

%% normalize: subtract local mean from each feature vector

for i=1:length(data)
   data(i).difference = data(i).difference ./ std(data(i).difference);
   data(i).difference = data(i).difference-mean(data(i).difference);
end

%% normalize: subtract global mean from the feature vectors


%% change label attributes to be binary

% for i=1:length(data)
%     if (data(i).label == 1)
%         data(i).label = [0,0,0,0,0,0,1];
%     end
%     if (data(i).label == 2)
%         data(i).label = [0,0,0,0,0,1,0];
%     end
%     if (data(i).label == 3)
%         data(i).label = [0,0,0,0,1,0,0];
%     end
%     if (data(i).label == 4)
%         data(i).label = [0,0,0,1,0,0,0];
%     end
%     if (data(i).label == 5)
%         data(i).label = [0,0,1,0,0,0,0];
%     end
%     if (data(i).label == 6)
%         data(i).label = [0,1,0,0,0,0,0];
%     end
%     if (data(i).label == 7)
%         data(i).label = [1,0,0,0,0,0,0];
%     end
% end

%% return prepared data
finalData = data;

end