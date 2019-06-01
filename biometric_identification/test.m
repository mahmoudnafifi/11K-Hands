%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ID = test( image, model, classifier, with_LBP )

%image: RGB image.
%model: our two-stream trained CNN model, you can download from the webpage. Note: use the proper CNN. For example, if you are working with dorsal-side hand images, use a CNN that has been trained on the dorsal side.
%classifier: trained SVM classifier
%with_LBP: boolean value, it should be true if the classifier was trained with the LBP features, false otherwise.

if nargin==3
    with_LBP=false;
end

I=preprocessing(image);

features=getfeatures(I,model,with_LBP);

if with_LBP==true
    f=[features.LBP,features.low,features.high,features.fusion];
    [~,scores1] = predict(classifier.low, f(:,532:1062));
    [~,scores2] = predict(classifier.high, f(:,1063:1594));
    [~,scores3] = predict(classifier.fusion, f(:,1595:end));
    [~,scores4] = predict(classifier.lbp, f(:,1:531));
    scores=(((scores1+scores2)/2)+scores3)/3+scores4;
    inds=max(scores,[],2)==scores;
    response=(find(inds(1,:)));
    ID=classifier.high.ClassNames{response};
    
else
    f=[features.low,features.high,features.fusion];
    ID = predict(classifier.all,f);
end


end

