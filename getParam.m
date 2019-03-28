%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [param] = getParam


param.szIn=[224 224];
param.szOut=531; %because of the output of ..  lbpFeatures = extractLBPFeatures(I(:,:,4),'CellSize',[64 64]); is 531 (for consistency)
param.DataAugmentation='none'; %'randcrop' | 'randfliplr' | cell array of 'randcrop' and 'randfliplr'
param.Normalization='zerocenter'; %'none' 
param.WeightLearnRateFactor=20;
param.BiasLearnRateFactor=20;
param.WeightL2Factor=0.8;
param.numClasses=2; %m and f
end

