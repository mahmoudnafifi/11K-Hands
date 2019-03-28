%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function apply_preprocessing_to_all(f, newf)
g={'male','female'};
mkdir(fullfile(pwd,newf));
for G=1:2
    images=dir(fullfile(f,g{G},'*.jpg'));
    mkdir(fullfile(pwd,newf,g{G}));
    for i=1:length(images)
        I=(imread(fullfile(f,g{G},images(i).name)));
        out=preprocessing(I);
        imwrite(out,(fullfile(newf,g{G},strcat(images(i).name(1:end-3),'tiff'))));
    end
end