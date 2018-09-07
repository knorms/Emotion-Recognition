function label = clmGetLabel(path)
    label = -1
    path = strsplit(path,"_");    
    A = dir('../Emotion');
    for file = A'
       if(strcmp(file.name,path(1))==1)           
           file.name;
            B = dir(strcat(file.folder,'/',file.name));
            for numFolder = B'
                if(strcmp(numFolder.name,path(2)))
                   C = dir(strcat(numFolder.folder,'/',numFolder.name));
                   for textFile = C'                       
                       if(strcmp(textFile.name,".")==0&&strcmp(textFile.name,"..")==0&&strcmp(textFile.name,".DS_Store")==0)
                           text = dlmread(strcat(textFile.folder,'/',textFile.name), ' ');                        
                           label = text(4);
                       end
                   end
                end
            end
       end
    end
end