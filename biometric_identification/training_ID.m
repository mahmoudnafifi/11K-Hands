%Copyright (c) 2017 Mahmoud Afifi
%York University - Assiut University

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%Permission is hereby granted, free of charge, to any person obtaining  a copy of this software and associated documentation files (the "Software"), to deal in the Software with restriction for its use for research purpose only, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%Please cite our paper if you use the provided source code, pre-trained models, or the dataset.
%Citation information is provided in the readme file (can be found in the dataset webpage).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

for S=1:2
    if S==1
        side='palmar';
    else
        side='dorsal';
    end
    for subj=[80,100,120]
        ext='mat';
        for fold=[1:10]
            base=fullfile('identification',num2str(fold),strcat('training','_',side),num2str(subj));
            
            [fnames,training_response]=get_fnames_ids(fold,'training',side,subj,ext);
            %load data to memory
            training_data=[];
            for i=1:length(fnames)
                load(fullfile(base,fnames{i}));
                training_data=[training_data;features.LBP,features.low,features.high,features.fusion];
            end
            base=fullfile('identification',num2str(fold),strcat('testing','_',side),num2str(subj));
            [fnames,testing_response]=get_fnames_ids(fold,'testing',side,subj,ext);
            %load data to memory
            testing_data=[];
            for i=1:length(fnames)
                load(fullfile(base,fnames{i}));
                testing_data=[testing_data;features.LBP,features.low,features.high,features.fusion];
                
            end
            
            
            model=sprintf('SVM_11K_%s_%s_%s',side,num2str(subj),num2str(fold));
            conf_name=sprintf('SVM_results_%s_%s_%s.mat',side,num2str(subj),num2str(fold));
            conf_name2=sprintf('SVM_results_%s_%s_wo_lbp_%s.mat',side,num2str(subj),num2str(fold));
            tic;
            
            
            
            SVM_temp = templateSVM('KernelFunction','polynomial','PolynomialOrder',2,...
                'KernelScale','auto','Solver','ISDA','ClipAlphas',false,...
                'IterationLimit',1e7,'Standardize',false);
            options = statset('UseParallel',true);
            
            classifier_low = fitcecoc(training_data(:,532:1062), training_response,...
                'Learners',SVM_temp, 'Verbose',0,'Coding', 'onevsall','ObservationsIn', 'rows','Options',options);
            classifier_high = fitcecoc(training_data(:,1063:1594), training_response,...
                'Learners',SVM_temp, 'Verbose',0,'Coding', 'onevsall','ObservationsIn', 'rows','Options',options);
            classifier_fusion = fitcecoc(training_data(:,1595:end), training_response,...
                'Learners',SVM_temp, 'Verbose',0,'Coding', 'onevsall','ObservationsIn', 'rows','Options',options);
            classifier_lbp = fitcecoc(training_data(:,1:531), training_response,...
                'Learners',SVM_temp, 'Verbose',0,'Coding', 'onevsall','ObservationsIn', 'rows','Options',options);
            classifier_all = fitcecoc(training_data(:,532:end), training_response,...
                'Learners',SVM_temp, 'Verbose',0,'Coding', 'onevsall','ObservationsIn', 'rows','Options',options);
            
            Classifier.low=classifier_low;
            Classifier.high=classifier_high;
            Classifier.fusion=classifier_fusion;
            Classifier.lbp=classifier_lbp;
            Classifier.all=classifier_all;
            save(model,'Classifier');
            
            t_training=toc;
            
            
            
            ind=randperm(size(testing_data,1));
            testing_data=testing_data(ind,:);
            testing_response=testing_response(ind,:);
            
            
            
            tic
            
            % Pass CNN image features to trained classifier
            
            [L1,scores1] = predict(classifier_low, testing_data(:,532:1062));
            [L2,scores2] = predict(classifier_high, testing_data(:,1063:1594));
            [L3,scores3] = predict(classifier_fusion, testing_data(:,1595:end));
            [L4,scores4] = predict(classifier_lbp, testing_data(:,1:531));
            [L5, scores5] = predict(classifier_all,testing_data(:,532:end));
            scores=(((scores1+scores2)/2)+scores3)/3+scores4;
            predictedLabels=cell(size(scores,1),1);
            inds=max(scores,[],2)==scores;
            for ro=1:size(inds,1)
                response=(find(inds(ro,:)));
                predictedLabels{ro}=classifier_high.ClassNames{response};
            end
            
            
            
            t_testing=toc;
            
            % Tabulate the results using a confusion matrix.
            confMat = confusionmat(testing_response, predictedLabels);
            % Convert confusion matrix into percentage form
            confMat = bsxfun(@rdivide,confMat,sum(confMat,2));
            save(conf_name,'confMat');
            sprintf('The result for %s: %f',model,mean(diag(confMat)))
            
            % Tabulate the results using a confusion matrix.
            confMat = confusionmat(testing_response, L5);
            % Convert confusion matrix into percentage form
            confMat = bsxfun(@rdivide,confMat,sum(confMat,2));
            save(conf_name2,'confMat');
            sprintf('The result for %s without LBP: %f',model,mean(diag(confMat)))
            
            sprintf('Time training: %f - testing: %f',t_training,(t_testing/length(predictedLabels)))
        end
    end
end