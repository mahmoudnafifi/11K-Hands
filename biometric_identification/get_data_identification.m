%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%get biometric identification training and testing data

%please locate directories of .txt files in the same directory of this code.

%all images should be located in the following directory (please change the name accordingly).


%NOTE:
%run get_all_features.m first if you want to extract all features and save them as .mat files besides the original image.
%Then, remove the comment from line 53 to extract only .mat files to train the SVM classifiers.

baseDir='hands'; %you can get it from the webpage of the dataset

mkdir('identification');

for i=[1,2,3,4,5,6,7,8,9,10]
    
    
    mkdir(fullfile('identification',num2str(i)));
    
    sides={'p','d'};
    sets={'training','testing'};
    
    for S=1:2
        
        newDir_=sprintf('identification\\%s\\%s_',num2str(i),sets{S});
        
        for s=1:2
            if s==1
                newDir=strcat(newDir_,'palmar');
            else
                newDir=strcat(newDir_,'dorsal');
            end
            mkdir(newDir);
            
            
            for subj=[80,100,120]
                mkdir(fullfile(newDir,num2str(subj)));
                
                
                fileID = fopen(fullfile('.\',num2str(i),sprintf('id_imgs_%s_%s_%s.txt',sets{S},sides{s},num2str(subj))),'r');
                imageNames = textscan(fileID,'%s\r\n'); %change it to '%s\n' for Linux users
                imageNames=imageNames{1};
                fclose(fileID);
                
                fileID = fopen(fullfile('.\',num2str(i),sprintf('id_%s_%s_%s.txt',sets{S},sides{s},num2str(subj))),'r');
                ids = textscan(fileID,'%s\r\n'); %change it to '%s\n' for Linux users
                ids=ids{1};
                fclose(fileID);
                
                for j=1:length(imageNames)
                    n=imageNames{j};
					%n=strcat(n(1:end-3),'mat');
                    id=ids{j};
                    [~,name,ext] = fileparts(n);
                    new_n=strcat(id,'_',name,ext);
                    copyfile(fullfile(baseDir,n),fullfile(newDir,num2str(subj),new_n));
                end
            end
        end
    end
end
