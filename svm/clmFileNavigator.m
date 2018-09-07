%load all clm coordinate data 
function fileStructArray = clmFileNavigator()
    A = dir('./clmtracker_data/');
    [numFiles, ~] = size(A);

    fileStructArray = struct('path', {}, 'data', {});  
    
    for m = 1:numFiles
        file = A(m, 1);

        if (strcmp(file.name,'.')~=1 && strcmp(file.name,'..')~=1 && strcmp(file.name,'.DS_Store')~=1)
            halfPath = strcat(file.folder, '/');
            fullPath = strcat(halfPath, file.name);
            
            coordinates = zeros(71,2);
            counter = 1;
            %open file
            fileID = fopen(fullPath);
            tline = fgetl(fileID);
            while ischar(tline)
                if(strcmp('    [', tline))
                    %next will be x value
                    tline = fgetl(fileID);
                    coordinates(counter, 1) = str2num(tline);
                    %next will be y value
                    tline = fgetl(fileID);
                    coordinates(counter, 2) = str2num(tline);
                    tline = fgetl(fileID);
                    counter = counter + 1;
                end
                tline = fgetl(fileID);
            end
            fileStruct = struct('path', fullPath, 'data', coordinates); 
            fileStructArray(end + 1) = fileStruct;
        end
        
    end
end