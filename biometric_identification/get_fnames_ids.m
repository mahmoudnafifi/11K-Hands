%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%get filenames and ids
function [fnames,ids]=get_fnames_ids(fold,phase,side,subj,ext)
%fold: integer from 1 to 10
%phase: 'training' or 'testing'
%side: 'dorsal' or 'palmar'
%subj: integer 80,100, or 120
%ext: 'jpg' or 'mat' (use 'mat' if you have extracted and saved all
%features as .mat file in the same directory
if nargin==4
    ext='jpg';
end
base=fullfile('identification',num2str(fold),strcat(phase,'_',side),num2str(subj));

files=dir(fullfile(base,strcat('*.',ext)));
fnames=cell(length(files),1);
ids=cell(length(files),1);

for i=1:length(files)
    fnames{i}=files(i).name;
    parts=strsplit(fnames{i},'_');
    ids{i}=cell2mat(parts(1));
end
end
