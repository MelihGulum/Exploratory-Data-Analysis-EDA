# Facial-Emotion-Recognition

The challenge is consist of two part. The first part making a prediction of 5 classes with any kind of AI model. The second part is that insert desired values into database. Such as rectangle’s corner, loaded image’s path and so on.

## 1. Dataset:
I used the FER2013 dataset fort his challenge. It consists of 7 class. These are “Angry”, “Disgust”, “Fear”, “Happy”, “Neutral”, “Sad”, “Suprise”. FER2013 is a well studied dataset and has been used in ICML competitions and several research papers. It is one of the more challenging datasets with human-level accuracy only at **65±5%** and the highest performing published works achieving 75.2% test accuracy I drop two class (Disgust and Suprise). Afterwards I assigned Sad and Angry as “NOT Okay”. On the other hand the other 3 class assigned as “Okay”.

<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/180644734-e8c04654-73bd-4190-aa3f-c6bde8bc0cfd.png" width="600" height="250">
</p>

You can see the test and training data numbers in the figure below.

<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/180644823-bf0acc7a-f342-4adb-837e-c10164ac4dd1.png" width="350" height="250">
 <img src="https://user-images.githubusercontent.com/81585804/180644825-46f144b0-c74a-4d8a-8355-0e9dac8ede96.png" width="350" height="250">
</p>


## 2. AI:
Tradionally CNN is for mostly used for Image Processing and I kept this tradition. My  model is similiar with VGG architecture. Before training I generate some artificial data with the help of ImageDataGenerator. Then, set some training parameters like batch size (64) and epoch (100). Final test accuracy is **68.5±3%.**


<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/180644754-4ad646a8-5e95-4a5b-9324-9265bd2c08c3.png" width="450" height="250">
 <img src="https://user-images.githubusercontent.com/81585804/180644755-ce2b4073-ac3b-4c4e-9f48-b6285ce860af.png" width="450" height="250">
</p>


## 3. Outputs:
* You can make real-time predictions with **FER_video.py**.
* You can guess the facial emotions of uploaded image with the **FER_image.py**. In addition, FER_image.py creates a separate text file and prints its predicted class and the coordinates of the detected face to txt file.

Here are some test examples:
<p align="center">
  <img src=https://user-images.githubusercontent.com/81585804/180645055-a03cb091-7aa7-4fe5-bda0-abafda6382fd.jpg alt="drawing" width="250" height="250"/>
  <img src=https://user-images.githubusercontent.com/81585804/180645056-2f920d79-6b3c-4483-9fc3-ebb2f8f5e4b1.jpg alt="drawing" width="250" height="250"/> 
  <img src=https://user-images.githubusercontent.com/81585804/180645057-5bacd6a3-af6d-42fb-9d8d-bd5989e8b371.jpg alt="drawing" width="250" height="250"/>
  <img src=https://user-images.githubusercontent.com/81585804/180645058-3d56cbf7-9a38-42c3-96cf-70d9aab0289f.jpg alt="drawing" width="250" height="250"/>
  <img src=https://user-images.githubusercontent.com/81585804/180645061-d1ae158f-9891-4500-9c2f-029974ae33ea.jpg alt="drawing" width="250" height="250"/>
</p>

## 4. Database:
In this challenge I used MYSQL database. The table has 6 column and these are “id”, “path”, “coordinates”, “state”, “time”, “class_name”. 

 ```console
CREATE TABLE `fer` (
  `id` int(6) UNSIGNED NOT NULL,
  `path` varchar(50) NOT NULL,
  `coordinates` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `class_name` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL
)
```

## 5. How to Run

1. Fork this repository.
 ```console
$ git clone https://github.com/MelihGulum/Facial-Emotion-Recognition.git

```

2. Load the dependencies of the project

**NOTE:** This dependencies not including the Deep Learning part. Colab meet all dependencies (such as tensorflow).

 ```console
pip install -r requirements.txt
```

3. Now you can run FER_video.py or FER_image.py. But if you want you can run .ipynb and you can build your own model. It is up to you. 
