function structArray = ckFileNavigator(num_extreme_frames)
    % By default only include the final peak expression
    if ~exist('num_extreme_frames', 'var')
        num_extreme_frames = 1;
    end

    A = dir('../Landmarks/');
    [numFolders, ~] = size(A);

    structArray = struct('neutral',{},'extreme',{}, 'label', {}, 'path', {},'indicator',{});

    for m = 1:numFolders
        directory = A(m, 1);
        if (strcmp(directory.name,'.')~=1 && strcmp(directory.name,'..')~=1 && strcmp(directory.name,'.DS_Store')~=1)
            halfPath = strcat(directory.folder, '/');
            fullPath = strcat(halfPath, directory.name);
            B = dir(fullPath);
            [numSubFolders, ~] = size(B);

            for n = 1:numSubFolders
                subDirectory = B(n, 1);
                if (strcmp(subDirectory.name,'.')~=1 && strcmp(subDirectory.name,'..')~=1 && strcmp(subDirectory.name,'.DS_Store')~=1)
                    subHalfPath = strcat(subDirectory.folder, '/');
                    subFullPath = strcat(subHalfPath, subDirectory.name);
                    C = dir(subFullPath);
                    [numFiles, ~] = size(C);

                    for l = 1:numFiles
                        neutral = C(l, 1);
                        if (strcmp(neutral.name,'.')~=1 && strcmp(neutral.name,'..')~=1 && strcmp(neutral.name,'.DS_Store')~=1)
                            neutralHalfPath = strcat(neutral.folder, '/');
                            neutralFullPath = strcat(neutralHalfPath, neutral.name);
                            neutralData = dlmread(neutralFullPath, ' ');
                            break
                        end
                    end 

                    for i = 1:num_extreme_frames
                        p = i-1;
                        extreme = C(numFiles-p, 1);
                        extremeHalfPath = strcat(extreme.folder, '/');
                        extremeFullPath = strcat(extremeHalfPath, extreme.name);
                        extremeData = dlmread(extremeFullPath, ' ');
                        eval(['extremeData' num2str(num_extreme_frames-p) '= extremeData;']);
                    end

                    labelPathFirst = extremeHalfPath(1:end-19);
                    labelPathSecond = extremeHalfPath(end-9:end);
                    finalLabelPath = strcat(labelPathFirst, 'Emotion');
                    finalLabelPath = strcat(finalLabelPath, labelPathSecond);
                    labelDir = dir(finalLabelPath);
                    [labelDirSize, ~] = size(labelDir);

                    for p = 1:labelDirSize
                        labelStruct = labelDir(p);
                        if (strcmp(labelStruct.name,'.')~=1 && strcmp(labelStruct.name,'..')~=1 && strcmp(labelStruct.name,'.DS_Store')~=1)
                            labelPathFinal =  strcat(labelStruct.folder, '/');
                            labelPathFinal = strcat(labelPathFinal, labelStruct.name);
                            labelData = dlmread(labelPathFinal, ' ');
                            
                            for i = 1:num_extreme_frames
                                myStruct = struct('neutral', neutralData, 'extreme', eval(['extremeData' num2str(i)]), 'label',...
                                                   labelData, 'path', labelPathFinal, 'indicator', i);
                                structArray(end + 1) = myStruct;
                            end
                        end 
                    end
                end
            end
        end
    end
end