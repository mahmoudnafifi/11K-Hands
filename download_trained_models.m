%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%download our trained models

PC_NAME='mafifi'; %change it 
disp('Downloading dorsal-side model...');
disp('Hint: you can skip it (comment out the 5th line of the setup.m), if you have downloaded it or have your own data!');
web('https://drive.google.com/open?id=0Byh0abzpiSu5ZmNtR1pMeWl3UnM');
str = input('When the download of ours_d_1.mat done, write Y .. Done? (Y/N)','s');
if strcmpi(str,'y')==0
    error('You have to wait untill finishing the download, then write Y');
end
movefile(fullfile('C:\Users',PC_NAME,'Downloads\O_d_1.mat'),'O_d_1.mat');
disp('Downloading palm-side model...');
disp('Hint: you can skip it (comment out the 5th line of the setup.m), if you have downloaded it or have your own data!');
web('https://drive.google.com/open?id=0B6CktEG1p54WVnJqdkdCbGloM2M');
str = input('When the download of ours_d_1.mat done, write Y .. Done? (Y/N)','s');
if strcmpi(str,'y')==0
    error('You have to wait untill finishing the download, then write Y');
end
disp('Done!');

movefile(fullfile('C:\Users',PC_NAME,'Downloads','O_p_7.mat'),'O_p_7.mat');
