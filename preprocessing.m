%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function O=  preprocessing(I)

I=im2double(I);
low=imguidedfilter(I,'DegreeOfSmoothing',100,'NeighborhoodSize',[10,10]);
glow=rgb2gray(low);
high=imadjust((rgb2gray(I)+(eps/100))./(glow+(eps/100)));
low=imresize(low,[224,224]);
high=imresize(high,[224,224]);
O=zeros(224,224,4); O(:,:,1:3)=low; O(:,:,4)=high;
O = uint8(O*255);
end