
# Gender Detection using a Webcam

This project implements a **real-time gender detection system** using deep learning. It leverages a convolutional neural network (CNN) to detect faces from a live webcam feed and predict gender as either "man" or "woman." The system is built using **TensorFlow/Keras** for deep learning and **OpenCV** for real-time video processing.

# **EĞİTİM GÖRSEL**


# **Overview**
Gender detection is a common application of deep learning, often used in social and human-computer interaction applications. This project provides an end-to-end implementation, starting from data preprocessing and model training to real-time webcam-based prediction.

The trained model detects human faces from the live webcam feed, processes the face images, and predicts the gender with confidence scores. This project can be used for research, educational purposes, or as a starting point for similar deep learning projects.

## **I. Features**
- **Real-time Face Detection:** Uses OpenCV to detect faces from live webcam feed.
- **Gender Classification:** CNN-based gender prediction, classifying faces as either "man" or "woman".
- **Data Augmentation:** Image augmentation applied during training to improve model generalization.
- **Training Visualization:** Graphs showing the evolution of accuracy and loss over epochs for both training and validation sets.

## **II. Architecture**
The deep learning model is implemented using a multi-layer **convolutional neural network (CNN)**. The key components of the architecture include:

- **Convolutional Layers:** For automatic feature extraction from input images.
- **Batch Normalization and Dropout:** To stabilize and regularize the model, preventing overfitting.
- **Max Pooling Layers:** To down-sample feature maps, reducing spatial dimensions.
- **Fully Connected Layers:** For final classification using sigmoid activation.

## **III.Technologies Used**
- **TensorFlow / Keras:** For building and training the CNN model.
- **OpenCV:** For capturing webcam input and performing face detection.
- **NumPy:** For array and matrix operations.
- **Matplotlib:** For plotting training and validation metrics.

## **IV. Dataset**
The model is trained on a custom dataset of face images organized into two categories:
- **Man:** Images of men.
- **Woman:** Images of women.
The dataset is preprocessed by resizing images to 96x96 pixels and normalizing pixel values to the range [0,1].

## **VI. Usage**
### **Running Gender Detection**
To use the gender detection in real-time via webcam, simply run the script:
```python
python detect_gender_webcam.py
```
The model will continuously detect faces from the webcam feed and classify them as "man" or "woman" with a confidence score.
* Press Q to quit the application.

### **VII. Model Training**
#### **a. Data Preprocessing**
The images in the dataset are preprocessed by:
- **Resizing:** All images are resized to 96x96.
- **Normalization:** Pixel values are scaled to the [0, 1] range.
- **Label Encoding:** Labels are encoded as binary categories (0 for "man" and 1 for "woman").
#### **b. Training the Model**
The training script (train.py) splits the dataset into training and validation sets (80/20 split). It uses data augmentation to randomly alter images during training to improve model robustness.

Training is performed for 100 epochs, and both loss and accuracy are tracked for the training and validation datasets.

To retrain the gender detection model, use the following script:
```python
python train.py
```

The train.py script will load images from gender_dataset_face/, preprocess them, augment the dataset, and train the CNN model. Training results (accuracy and loss) are saved and visualized.

## **VIII. Results**
The model's performance metrics for training and validation sets are visualized in the plot above. As seen in the graph, the model achieves stable performance after several epochs, with training loss decreasing and accuracy improving.

The spikes in validation loss are indicative of overfitting on certain epochs, but overall, the model generalizes well to unseen data.