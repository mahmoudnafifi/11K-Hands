%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%get all features
base='hands';

load('o_p_1.mat');

images=fullfile(base,'*.tiff');
for i=1:length(images)
    features=getfeatures(imread(fullfile(base,images(i).name)),net,1);
    save('features',fullfile(base,strcat(images(i).name(1:end-4),'.mat')));
    
end