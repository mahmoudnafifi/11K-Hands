%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Please download ours_p_7.mat and ours_d_1.mat from the dataset webpage or
%from the links provided in download_trained_models.m


inputImg='test\m_p.jpg';

CNNfile='ours_p_7.mat'; load(CNNfile); %loaded as net

I=imread(inputImg);

I=preprocessing(I);

imwrite(I,'temp.tiff');

testingImage = imageDatastore('temp.tiff');
disp('CNN result:')
[YPred] = classify(net,testingImage)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SVM_='SVM_p_2.mat'; load(SVM_); %loaded as classifier

I=imread(inputImg);

features = getfeatures(I,net,0);
f=[features.low,features.high,features.fusion];
predictedLabel = predict(classifier, f);
if predictedLabel==0
    disp('Female');
else
    disp('Male');
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputImg='test\f_d.jpg';

CNNfile='ours_d_1.mat'; load(CNNfile); %loaded as net

I=imread(inputImg);

I=preprocessing(I);

imwrite(I,'temp.tiff');

testingImage = imageDatastore('temp.tiff');
disp('CNN result:')
[YPred] = classify(net,testingImage)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SVM_='SVM_d_9.mat'; load(SVM_); %loaded as classifier

I=imread(inputImg);

features = getfeatures(I,net,0);
f=[features.low,features.high,features.fusion];
predictedLabel = predict(classifier, f);
if predictedLabel==0
    disp('Female');
else
    disp('Male');
end
