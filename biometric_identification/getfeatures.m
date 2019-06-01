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

if withLBP==1
    features.LBP = extractLBPFeatures(I(:,:,4),'CellSize',[64 64]);
end

featureLayer = 'fc9_1';
features.low = activations(net, I, featureLayer,'OutputAs', 'columns')';
featureLayer = 'fc9_2_2';
features.high = activations(net, I, featureLayer,'OutputAs', 'columns')';
featureLayer = 'avpool';
features.fusion = activations(net, I, featureLayer,'OutputAs', 'columns')';

end

