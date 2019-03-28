%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get gender classification training and testing data

%please locate directories of .txt files in the same directory of this code.

%all images should be located in the following directory (please change the name accordingly).



baseDir='hands'; %you can get it from the webpage of the dataset

mkdir('gender');

for i=[1,2,3,4,5,6,7,8,9,10]
    
    
    mkdir(fullfile('gender',num2str(i)));
    
    sides={'p','d'};
    sets={'training','testing'};
    for S=1:2
        
        newDir_=sprintf('gender\\%s\\%s_',num2str(i),sets{S});

        for s=1:2
            if s==1
                newDir=strcat(newDir_,'palmar');
            else
                newDir=strcat(newDir_,'dorsal');
            end
            mkdir(newDir);
            mkdir(fullfile(newDir,'male'));
            mkdir(fullfile(newDir,'female'));
            
            fileID = fopen(fullfile('.\',num2str(i),sprintf('g_imgs_%s_%s.txt',sets{S},sides{s})),'r');
            imageNames = textscan(fileID,'%s\r\n'); %change it to '%s\n' for Linux users
            imageNames=imageNames{1};
            fclose(fileID);
            
            fileID = fopen(fullfile('.\',num2str(i),sprintf('g_%s_%s.txt',sets{S},sides{s})),'r');
            gender = textscan(fileID,'%s\r\n'); %change it to '%s\n' for Linux users
            gender=gender{1};
            fclose(fileID);
            
            for j=1:length(imageNames)
                n=imageNames{j};
                %n=strcat(n(1:end-3),'tiff');
                copyfile(fullfile(baseDir,n),fullfile(newDir,gender{j},n));
            end
        end
    end
end
