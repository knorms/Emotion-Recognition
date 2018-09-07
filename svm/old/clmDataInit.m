%store clm data points in struct for use by svm_classify gets rid of empty data and performs procrustes alignment
function [data, failed]  = clmDataInit(num_extreme_frames, fileStructArray)
    % only run clmFileNavigator if data hasn't been passed in
    if ~exist('fileStructArray','var')
        fileStructArray = clmFileNavigator();
    end
    
    % By default include final 3 expression frames
    if ~exist('num_extreme_frames', 'var')
        num_extreme_frames = 3;
    end
    
    % Collect data on images that failed to converge
    subj = strings([length(fileStructArray),1]);
    fail_n = zeros([length(fileStructArray),1]);
    fail_e1 = zeros([length(fileStructArray),1]);
    fail_e2 = zeros([length(fileStructArray),1]);
    fail_e3 = zeros([length(fileStructArray),1]);
    
    data = struct('neutral',{},'extreme',{}, 'indicator', {}, 'label', {}, 'extPath', {}, ...
                         'neutPath', {}, 'e_align', {}, 'difference', {});
    
    [~, inputSize] = size(fileStructArray);
    
    i = 1;
    for n = 1:4:inputSize
        neutral = fileStructArray(1,n);
        extreme1 = fileStructArray(1,n+1);
        extreme2 = fileStructArray(1,n+2);
        extreme3 = fileStructArray(1,n+3);
        label = clmGetLabel(extreme3.path);
        
        tmp = strsplit(neutral.path,'/');
        tmp = tmp(end);
        tmp = extractBefore(tmp, (strlength(tmp)-4));
        subj(i) = tmp;
        
        
        if neutral.data(1,1) ==0 % failure to converge
            fail_n(i) = 1;
        end
        
        if(extreme1.data(1,1) ~= 0) % failure to converge
            if (num_extreme_frames==3) % keeping last 3 frames
            [~, e_align1] = procrustes(neutral.data,extreme1.data);
            myStruct1 = struct('neutral', neutral.data, 'extreme', extreme1.data, 'indicator', 1, ...
                               'label', label, 'extPath', extreme1.path, 'neutPath', neutral.path, ...
                               'e_align', e_align1, 'difference', neutral.data - e_align1);
            data(end+1) = myStruct1;
            end
        else
           fail_e1(i) = 1;
        end
        
        if(extreme2.data(1,1) ~= 0)
            if (num_extreme_frames>=2) % keeping at least last 2 frames
                [~, e_align2] = procrustes(neutral.data,extreme2.data);
                myStruct2 = struct('neutral', neutral.data, 'extreme', extreme2.data, 'indicator', 2, ...
                                   'label', label, 'extPath', extreme2.path, 'neutPath', neutral.path, ...
                                   'e_align', e_align2, 'difference', neutral.data - e_align2);
                data(end+1) = myStruct2;
            end
        else
           fail_e2(i) = 1;
        end
        
        if(extreme3.data(1,1) ~= 0) % failure to converge, always keep peak frame
            [~, e_align3] = procrustes(neutral.data,extreme3.data);
            myStruct3 = struct('neutral', neutral.data, 'extreme', extreme3.data, 'indicator', 3, ...
                               'label', label, 'extPath', extreme3.path, 'neutPath', neutral.path, ...
                               'e_align', e_align3, 'difference', neutral.data - e_align3);
            data(end+1) = myStruct3;
         else
           fail_e3(i) = 1;
        end
        i  = i + 1;
    end
    failed = table(subj,fail_n, fail_e1, fail_e2, fail_e3);
end
