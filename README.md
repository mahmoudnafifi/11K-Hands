# 11K Hands: Gender recognition and biometric identification using a large dataset of hand images

<p align="center"><img src="https://drive.google.com/uc?export=view&id=0BwO0RMrZJCioY0tCYkZRUjY1bm8" style="width: 300px; max-width: 90%; height: auto" title="Click for the larger version." /></p>

This is the Matlab implementation of the paper:
Mahmoud Afifi, "11K Hands: Gender recognition and biometric identification using a large dataset of hand images." Multimedia Tools and Applications, 2019.

[Project webpage](https://sites.google.com/view/11khands)


To run this code, you need to download the trained models using download_trained_models.m or download them from our website:

The provided files are:

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


--------------------------------------------------------------------------------------------------

Project webpage: https://sites.google.com/view/11khands

### Publication:
Mahmoud Afifi, "11K Hands: Gender recognition and biometric identification using a large dataset of hand images." Multimedia Tools and Applications, 2019.
