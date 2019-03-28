%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function features = getfeatures(I,net,withLBP)

I = preprocessing(I);

if withLBP==1
    features.LBP = extractLBPFeatures(I(:,:,4),'CellSize',[64 64]);
end

imwrite(I,'temp.tiff');

testingImage = imageDatastore('temp.tiff');
 
featureLayer = 'fc9_1';
features.low = reshape ( activations(net, testingImage, featureLayer),[1,531]);
featureLayer = 'fc9_2_2';
features.high = reshape(activations(net, testingImage, featureLayer),[1,531]);
featureLayer = 'avpool';
features.fusion = reshape(activations(net, testingImage, featureLayer),[1,2*531]);
end

