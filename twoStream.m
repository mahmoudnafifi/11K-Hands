%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [lgraph]=twoStream(net1,net2,param)

outSize=param.szOut;
inputlayer = imageInputLayer([224,224,4],...
    'DataAugmentation',param.DataAugmentation,...
    'Normalization',param.Normalization,...
    'Name','inputlayer');


%% conv1 (modified)
conv1_1=net1.Layers(2);
conv1_2=net2.Layers(2);

Weights_=zeros([size(conv1_1.Weights,1),size(conv1_1.Weights,2),...
    size(conv1_1.Weights,3)+1,size(conv1_1.Weights,4)]);
Weights_(:,:,1:3,:)=conv1_1.Weights(:,:,:,:);
Weights_(:,:,4,:)=conv1_2.Weights(:,:,:,:);

Weights=Weights_;
Weights(:,:,4,:)=0;
skipConv1 = convolution2dLayer(size(Weights,1),size(Weights,4),'Stride',3,'Name','skipConv1',...
    'Padding',2,'WeightL2Factor',1,...
     'WeightLearnRateFactor',0,...
    'BiasLearnRateFactor',0);
skipConv1.Weights = Weights;
skipConv1.Bias = conv1_1.Bias;

Weights=Weights_;
Weights(:,:,1:3,:)=0;
%pattern=repmat([0,1],[2,1,1,96]);
skipConv2 = convolution2dLayer(size(Weights,1),size(Weights,4),'Stride',3,'Name','skipConv2',...
    'Padding',2,'WeightL2Factor',1,...
     'WeightLearnRateFactor',0,...
    'BiasLearnRateFactor',0);

skipConv2.Weights = Weights;
skipConv2.Bias = conv1_2.Bias;

clear conv1_2 conv1_1 Weights_

layers=[skipConv1;net1.Layers(3:end-3);net2.Layers(3:end-3)];
layers(2).Name='relu1_1';
layers(3).Name='norm1_1';
layers(4).Name='pool1_1';
layers(5).Name='conv2_1';
layers(6).Name='relu2_1';
layers(7).Name='norm2_1';
layers(8).Name='pool2_1';
layers(9).Name='conv3_1';
layers(10).Name='relu3_1';
layers(11).Name='conv4_1';
layers(12).Name='relu4_1';
layers(13).Name='conv5_1';
layers(14).Name='relu5_1';
layers(15).Name='pool5_1';
layers(16).Name='fc6_1';
layers(17).Name='relu6_1';
layers(18).Name='drop6_1';
layers(19).Name='fc7_1';
layers(20).Name='relu7_1';
layers(21).Name='drop7_1';
layers(22).Name='fc8_1';
layers(23).Name='relu8_1';
layers(24).Name='drop8_1';
layers(25).Name='fc9_1';

layers(26).Name='relu1_2';
layers(27).Name='norm1_2';
layers(28).Name='pool1_2';
layers(29).Name='conv2_2';
layers(30).Name='relu2_2';
layers(31).Name='norm2_2';
layers(32).Name='pool2_2';
layers(33).Name='conv3_2';
layers(34).Name='relu3_2';
layers(35).Name='conv4_2';
layers(36).Name='relu4_2';
layers(37).Name='conv5_2';
layers(38).Name='relu5_2';
layers(39).Name='pool5_2';
layers(40).Name='fc6_2';
layers(41).Name='relu6_2';
layers(42).Name='drop6_2';
layers(43).Name='fc7_2';
layers(44).Name='relu7_2';
layers(45).Name='drop7_2';
layers(46).Name='fc8_2';
layers(47).Name='relu8_2';
layers(48).Name='drop8_2';
layers(49).Name='fc9_2';
layers(50).Name='relu9_2';
layers(51).Name='drop9_2';
layers(end).Name='fc9_2_2';
fusion=fullyConnectedLayer(param.numClasses,'Name','fc_fusion','WeightLearnRateFactor',param.WeightLearnRateFactor*2);

layers=[inputlayer;layers;
    depthConcatenationLayer(2,'Name','append');
    averagePooling2dLayer(1,'Stride',2,'Name','avpool');
    fusion
    softmaxLayer;
    classificationLayer];
    layers(end-1).Name='softmax';
    layers(end).Name='classificationLayer';
lgraph = layerGraph(layers);


lgraph = addLayers(lgraph,skipConv2);
lgraph = connectLayers(lgraph,'inputlayer','skipConv2');
lgraph = disconnectLayers(lgraph,'fc9_1','relu1_2');
lgraph = connectLayers(lgraph,'skipConv2','relu1_2');
lgraph = connectLayers(lgraph,'fc9_1','append/in2');

 lgraph.Layers

figure
plot(lgraph);
figure;



end