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
load('HandInfo.mat');

load('ours_d_1.mat');

a={HandInfo.aspectOfHand}; ind_d=find(contains(a,'dorsal'));

a={HandInfo.imageName};

for i=1:length(ind_d)
    name=a{ind_d(i)};
    features=getfeatures(imread(fullfile(base,name)),net,0);
    save(fullfile(base,strcat(name(1:end-4),'.mat')),'features'); 
end


load('ours_p_7.mat');

a={HandInfo.aspectOfHand}; ind_p=find(contains(a,'palm'));

a={HandInfo.imageName};

for i=1:length(ind_p)
    name=a{ind_p(i)};
    features=getfeatures(imread(fullfile(base,name)),net,1);
    save(fullfile(base,strcat(name(1:end-4),'.mat')),'features'); 
end




