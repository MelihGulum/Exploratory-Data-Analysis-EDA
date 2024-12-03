
# Face Mask Detection

This project implements a face mask detection system using deep learning, leveraging the **MobileNetV2** architecture for real-time predictions. The solution can detect whether individuals are wearing face masks in both images and video streams, making it highly useful for monitoring compliance in public spaces during situations like the COVID-19 pandemic.

## **Table of Contents**
* Overview
* Project Structure
* Requirements
* Usage
    - Training the Model
    - Detecting Masks in Images
    - Detecting Masks in Videos
* Model Performance

## **Overview**
The system detects faces in images or video streams, and classifies each detected face as either:
* With Mask
* Without Mask

We utilize a pre-trained MobileNetV2 model, fine-tuning it with a custom dataset of images containing masked and unmasked faces. The model processes each face to make predictions in real-time.

## **Project Structure**
The project contains the following main files:

* train_mask_detector.py: Script to train the mask detector model from scratch using a dataset of images​.
* detect_mask_image.py: Script to detect masks on individual images using the trained model​.
* detect_mask_video.py: Script to detect masks in real-time video streams (e.g., from a webcam)​.

## **Usage**
### **Training the Model**
To train the mask detector model from scratch, you need a dataset of images categorized into "with_mask" and "without_mask." The script will load and preprocess the images, then train a deep learning model based on MobileNetV2. After training, the model will be saved as mask_detector.model.

Run the training script:

```python 
python train_mask_detector.py
```

This script will:
* Load the images from the dataset directory.
* Train the model using MobileNetV2 as a base, with custom fully connected layers added on top.
* Output the training results and save the model for future inference.

### **Detecting Masks in Images**
To detect masks in a static image, use the detect_mask_image.py script. Provide the path to the image file, and the script will display the image with bounding boxes and mask/no mask labels for each detected face.

Example:
```python 
python detect_mask_image.py --image examples/example_01.png
```

### **Detecting Masks in Videos**
To perform real-time mask detection from a video stream, run the detect_mask_video.py script. It will use your computer's webcam by default, but you can modify the video source if needed.

```python
python detect_mask_video.py
```
Press q to stop the video stream.

## **Model Performance**