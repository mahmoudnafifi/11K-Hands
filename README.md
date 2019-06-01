# 11K Hands: Gender recognition and biometric identification using a large dataset of hand images

<p align="center"><img src="https://drive.google.com/uc?export=view&id=0BwO0RMrZJCioY0tCYkZRUjY1bm8" style="width: 300px; max-width: 90%; height: auto" title="Click for the larger version." /></p>

This is the Matlab implementation of the paper:
Mahmoud Afifi, "11K Hands: Gender recognition and biometric identification using a large dataset of hand images." Multimedia Tools and Applications, 2019.

[Project webpage](https://sites.google.com/view/11khands)


To run this code, you need to download the trained models from our [project webpage](https://sites.google.com/view/11khands). The provided files include models for gender classification and biometric identification.

Gender classification files are:

1. demo.m: a demo to test our model.
2. get_data.m: extract training and testing images from the main directory of the hand images.
3. CNN_training.m: train our model, or other CNN architectures (AlexNet, VGG-16, VGG-19, or GoogleNet).
4. Apply_preprocessing_to_all.m: to apply our preprocessing to all images before train using CNN. In this case, you can comment out lines (23-27) of CNN_training.m. Note: the code will write all images as 4-D images (.TIFF). 
5. getModel.m: return the CNN architecture.
6. getParam.m: return the training parameters.
7. plotTrainingAccuracy.m: used to plot the progress during the training process.
8. preprocessing.m: return 4-D image contains the smoothed version of the image in the first 3 layers and the detail layer in the fourth layer of the image. 
9. readAndPreprocessImage_*.m: required to adjust the size of the image before the training process.
10. training_SVM.m: train SVM using the extracted features of our trained model. 
11. twoStream.m: return the architecture of our two-stream CNN.
12. getfeatures.m: return the CNN features and LBP features required for the SVM training process.
13. get_all_features.m: extract features from all images to feed the SVM classifier in the SVM training process.
14. SVM_d_9.m and SVM_p_2.m: is the trained SVM classifiers to be used in the demo.m


Biometric classification files are:
1. preprocessing.m: return 4-D image contains the smoothed version of the image in the first 3 layers and the detail layer in the fourth layer of the image. 
2. Apply_preprocessing_to_all.m: to apply our preprocessing to all images before train.
3. getfeatures.m: return the CNN features and LBP features required for the training process.
4. get_all_features.m: extract features from all images to feed the SVM classifier in the SVM training process.
5. get_data_identification.m: extract training and testing images from the main directory of the hand images. You have to first use get_all_features.m to get all features from images, then use this code to extract all training/testing sets of the features not the images.
6. training_ID.m: train SVM classifiers (it loops through all sets described in the paper)
7. get_fnames_ids.m: get file names and ids for train SVM classifiers.
8. test.m: to test a particular classifier. You can download them from our webpage.
Run steps 2, 4, 5, then 6 to re-train the SVM classifiers.


Note:
Because of the 4-D images, you are going to get an error states the following:
Error using imageInputLayer>iParseInputArguments (line 59)
The value of 'InputSize' is invalid. Expected input image size to be a 2 or 3 element vector. For a 3-element vector, the
third element must be 3 or 1.

To fix it,  do the following:

a- Open Matlab  (run as administrator)

b- Write:

`edit imageInputLayer.m`

c- Replace the following code:
```
function tf = iIsValidRGBImageSize(sz)
tf = numel(sz) == 3 && sz(end) == 3;
end
```
with the modified function:
```
function tf = iIsValidRGBImageSize(sz)
tf = numel(sz) == 3 && (sz(end) == 3 || sz(end) == 4);
end
```
d- Save 



### Example of testing biometric identification
Please follow the following steps to re-produce our results for biometric identification.
1. Download source code for biometric identification. Also can be found [here](https://drive.google.com/file/d/1Fmk1KCbIzSfQVGsISwFUwhp2HykGE43R/view).

2. Download the dataset from our [project webpage](https://sites.google.com/view/11khands) (a direct download link is available [here](https://drive.google.com/file/d/0BwO0RMrZJCiocGlvdnJxb0lTaHM/view)).

3. Download the trained CNN model. Assume we are interested in dorsal-side hand images, so download the trained model for dorsal images from [here](https://drive.google.com/file/d/0Byh0abzpiSu5ZmNtR1pMeWl3UnM/view).

4. Download the SVM trained classifier (it should be for the same side). Here we will use an SVM classifier for dorsal images without LBP features for Experiment #1 for 100 subjects (for more information please read our paper or see the [project webpage](https://sites.google.com/view/11khands)). The SVM model is available [here](https://drive.google.com/file/d/0B6CktEG1p54WTk5EX0RqQlRqS2s/view).

5. Download the IDs for experiments from [here](https://drive.google.com/drive/folders/0BwO0RMrZJCioZTNTdThFUGh5bG8). In this example, we are interested in experiment #1 for 100 subjcts.

6. Run `get_data_identification.m` code (also is available [here](https://drive.google.com/file/d/0BwO0RMrZJCioWEhLMWhYMVgtdGc/view)) that automatically extracts images for each experiment. You can modify it to only extract images for experiment 1. Do not forget to change the directory in the code to the directory you saved hand images in. It will create for you a directory named `identification`.

Now, we have everything. So, let's test experiment 1 (100 subjects) for dorsal-side images.

7. Load trained CNN
8. Load trained classifier
9. Run this code:
```
	base = 'identification\1\testing_dorsal\100'; %that is the base directory for experiment1 testing images
	images = dir(fullfile(base,'*.jpg')); %get all image names
	images = {images(:).name}; %convert them to cell (just easier in future use)
	acc= 0; %set accuracy to 0
	for i = 1 : length(images) %for each image
		I = imread(fullfile(base,images{i})); %read it
		ID = test( I, net, Classifier,false); %get predicted ID
		parts = strsplit(images{i},'_');  %each image name has the following format ID_originalImageName.jpg
		ID_gt = parts{1} ; %get the ground truth ID (the part before first underscore)
		if strcmpi(ID_gt,ID{1}) %if ground truth match predicted ID, increment the accuracy
			acc = acc + 1;
		end
	end

	acc = acc/length(images) %report the accuracy (total true predictions over total number of images)
```

It should give you 0.9646 ~ 0.965 (as reported in the project webpage and our paper). 

--------------------------------------------------------------------------------------------------

Project webpage: https://sites.google.com/view/11khands

### Publication:
Mahmoud Afifi, "11K Hands: Gender recognition and biometric identification using a large dataset of hand images." Multimedia Tools and Applications, 2019.
