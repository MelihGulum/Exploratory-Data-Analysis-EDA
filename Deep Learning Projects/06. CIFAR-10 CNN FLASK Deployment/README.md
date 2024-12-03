# CIFAR-10 CNN and FLASK Deployment
This project has been done in the field of image processing, which is one of the pursuits of artificial intelligence. In the project ,well known CIFAR10 dataset and CNN architecture, which has proven itself successfully in image processing from deep learning is used.

1. [ DATASET ](#DATASET)
2. [ Deep Learning - CNN ](#DeepLearning-CNN)
3. [ FLASK ](#FLASK)
4. [ How to Run ](#HowtoRun)

<a name="DATASET"></a>
## 1. DATASET
The [CIFAR-10](https://www.cs.toronto.edu/~kriz/cifar.html) dataset consists of 60000 32x32 colour images in 10 classes, with 6000 images per class. There are 50000 training images and 10000 test images. It was collected by Alex Krizhevsky, Vinod Nair, and Geoffrey Hinton.

<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/176235421-94e66358-a64d-4de9-b30f-67057755cf70.png" width="350" height="250">
</p>

<a name="DeepLearning-CNN"></a>
## 2. Deep Learning - CNN 
First we normalized the data and then made it categorical. Afterwards for data augmentation we used ImageDataGenerator. CNN architecture is shown belown. There are some changes in the model. These are: 
* This model has been strengthened by increasing its complexity. 
* Optimizer is chosen as Adam and default parameters set.
* ReduceLROnPlateau and EarlyStopping callbacks added to prevent overfitting and overtraining.

<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/176241200-1da85e69-edef-4029-9253-a7d45e21f99d.png" width="800" height="250">
</p>

After the model training is finished, the accuracy and loss graphs of the training are shown in the following two figures. The accuracy of the model is **%91.74**.
<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/176241918-49af7597-30bb-4e0c-83b9-ded38d1c9f45.png" width="350" height="250">
</p>

<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/176242139-eac5db1e-cce6-4c0f-9fff-3537bc6cc704.png" width="350" height="250">
</p>

<a name="FLASK"></a>
## 3. FLASK
Flask is a micro web framework written in Python. It is classified as a microframework because it does not require particular tools or libraries. 
* You can load a local image or a url.
* The top 3 predictions of the image that loaded and their percentage will be shown in redirected page.
The following two figure are outputs of the web programming, FLASK.

<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/176243667-85bc3c1c-9428-4729-93d9-d26167256ddc.png" width="700" height="400">
</p>

<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/176243750-8bf26887-b475-4af9-a631-fc29575535ed.png" width="700" height="400">
</p>

<a name="HowtoRun"></a>
## 4. How to Run


1. Fork this repository.
 ```console
$ git clone https://github.com/MelihGulum/CIFAR-10-CNN-FLASK-Deployment.git

```

2. Load the dependencies of the project

**NOTE:** This dependencies not including the Deep Learning part. Colab meet all dependencies (such as tensorflow).

 ```console
pip install -r requirements.txt
```

3. Now you can run app.py. But if you want you can run .ipynb and you can build your own model. It is up to you. 
