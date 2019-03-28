%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [layers]=getModel(param,M,net1,net2)

if M~=3
    net1=[];
    net2=[];
 
end

%% input layer 
if M==1
inputlayer = imageInputLayer([param.szIn,3],...
    'DataAugmentation',param.DataAugmentation,...
    'Normalization',param.Normalization,...
    'Name','inputlayer');
elseif M==2
inputlayer = imageInputLayer([param.szIn,1],...
    'DataAugmentation',param.DataAugmentation,...
    'Normalization',param.Normalization,...
    'Name','inputlayer');
elseif M==3
   [layers]=twoStream(net1,net2,param);
   return;
end

%% alexnet (from 2:23)
if M==1 || M==2
net = alexnet;
layersTransfer = net.Layers(2:16);
clear net;
else
end

%% conv1 (modified)
conv1=layersTransfer(1);
if M==1
    Weights=zeros([size(conv1.Weights,1),size(conv1.Weights,2),...
    3,size(conv1.Weights,4)]);
elseif M==2
    Weights=zeros([size(conv1.Weights,1),size(conv1.Weights,2),...
    1,size(conv1.Weights,4)]);
end
Bias=conv1.Bias;
if M==1
    Weights=conv1.Weights;
elseif M==2
     Weights=(0.2989*conv1.Weights(:,:,1,:)+0.5870*conv1.Weights(:,:,2,:)+0.1140*conv1.Weights(:,:,3,:)); %to Y'UV
end
    if M==1
conv1  = convolution2dLayer(size(Weights,1),size(Weights,4),'Stride',3,...
    'Padding',0,'WeightL2Factor',param.WeightL2Factor,'Name','conv1',...
     'WeightLearnRateFactor',param.WeightLearnRateFactor*2,...
    'BiasLearnRateFactor',param.BiasLearnRateFactor);
    elseif M==2
        conv1  = convolution2dLayer(size(Weights,1),size(Weights,4),'Stride',3,...
    'Padding',0,'WeightL2Factor',param.WeightL2Factor,'Name','conv1',...
     'WeightLearnRateFactor',param.WeightLearnRateFactor,...
    'BiasLearnRateFactor',param.BiasLearnRateFactor);
    end
        
conv1.Weights = Weights;
conv1.Bias =Bias;
layersTransfer=layersTransfer(2:end);

%% fully connected layers
% fc6

fc6= fullyConnectedLayer(4096,...
    'WeightL2Factor',param.WeightL2Factor,...
    'WeightLearnRateFactor',param.WeightLearnRateFactor*2,...
    'BiasLearnRateFactor',param.BiasLearnRateFactor*2,...
    'Name','fc6');


relu6 = reluLayer('Name','relu6');
drop6=dropoutLayer(0.5,'Name','drop6');

% fc7
fc7= fullyConnectedLayer(4096,...
    'WeightL2Factor',param.WeightL2Factor,...
    'WeightLearnRateFactor',param.WeightLearnRateFactor*2,...
    'BiasLearnRateFactor',param.BiasLearnRateFactor*2,...
    'Name','fc7');

relu7 = reluLayer('Name','relu7');
drop7=dropoutLayer(0.5,'Name','drop7');

if M==1
% fc8




fc8= fullyConnectedLayer(2048,...
    'WeightL2Factor',param.WeightL2Factor,...
    'WeightLearnRateFactor',param.WeightLearnRateFactor*2,...
    'BiasLearnRateFactor',param.BiasLearnRateFactor*2,...
    'Name','fc8');

relu8 = reluLayer('Name','relu8');

drop8=dropoutLayer(0.5,'Name','drop8');

% fc9
outSize=param.szOut;



fc9= fullyConnectedLayer(outSize,...
    'WeightL2Factor',param.WeightL2Factor,...
    'WeightLearnRateFactor',param.WeightLearnRateFactor*2,...
    'BiasLearnRateFactor',param.BiasLearnRateFactor*2,...
    'Name','fc9');


fc=[fc6;relu6;drop6;fc7;relu7;drop7;fc8;relu8;drop8;fc9];
elseif M==2
    
% fc8



fc8= fullyConnectedLayer(2048,...
    'WeightL2Factor',param.WeightL2Factor,...
    'WeightLearnRateFactor',param.WeightLearnRateFactor*2,...
    'BiasLearnRateFactor',param.BiasLearnRateFactor*2,...
    'Name','fc8');

relu8 = reluLayer('Name','relu8');


drop8=dropoutLayer(0.5,'Name','drop8');

% fc9




fc9= fullyConnectedLayer(2048,...
    'WeightL2Factor',param.WeightL2Factor,...
    'WeightLearnRateFactor',param.WeightLearnRateFactor*2,...
    'BiasLearnRateFactor',param.BiasLearnRateFactor*2,...
    'Name','fc9');
relu9 = reluLayer('Name','relu9');

drop9=dropoutLayer(0.5,'Name','drop9');

outSize=param.szOut;




fc9_= fullyConnectedLayer(outSize,...
    'WeightL2Factor',param.WeightL2Factor,...
    'WeightLearnRateFactor',param.WeightLearnRateFactor*2,...
    'BiasLearnRateFactor',param.BiasLearnRateFactor*2,...
    'Name','fc9_2');





fc=[fc6;relu6;drop6;fc7;relu7;drop7;fc8;relu8;drop8;fc9;relu9;drop9;fc9_];

end
%% classification layer
cl=[fullyConnectedLayer(param.numClasses,'WeightLearnRateFactor',...
    param.WeightLearnRateFactor,'BiasLearnRateFactor',...
    param.BiasLearnRateFactor,'Name','fc10')
    softmaxLayer
    classificationLayer];

layers = [inputlayer;conv1;layersTransfer;fc;cl]
