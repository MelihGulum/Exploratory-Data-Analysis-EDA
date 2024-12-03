from keras.models import load_model
from time import sleep
from keras.preprocessing.image import img_to_array
from keras.preprocessing import image
import cv2
import os
import numpy as np
import json


with open("parameters.json",) as f:
    parameters = json.load(f)


classifier =load_model('FER-CNN.h5')
parameters["emotion_labels"]

#loading image
parameters["base_dir"]
parameters["image_name"]
full_path=parameters["base_dir"]+parameters["image_name"]

full_size_image = cv2.imread(full_path)
print("Image Loaded")

gray=cv2.cvtColor(full_size_image,cv2.COLOR_RGB2GRAY)
face = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
faces = face.detectMultiScale(gray, 1.3  , 10)

#Function for rectangle's corner points.
def coordinates():
        parameters["image_name"]
        image_name = os.path.splitext(parameters["image_name"])
        with open(f'images/{image_name[0]}.txt', 'w') as f:
                f.write(f"{int(np.argmax(yhat))} {x} {y} {x + w} {y + h}")

#Function to insert desired values into database.
def database():
    import mysql.connector
    from datetime import datetime

    time = datetime.now()
    name=parameters["emotion_labels"][int(np.argmax(yhat))]
    coords = [x, y, x+w, y+h]

    state=""
    parameters["okay_list"]
    if name in parameters["okay_list"]:
        state= "Okay"
    else:
        state="NOT Okay"

    mydb = mysql.connector.connect(
        host="Your_host",
        user="user",
        password="your_password",
        database="your_database_name"
    )

    mycursor = mydb.cursor()
    sql = "INSERT INTO pixselect (path, coordinates, state, class_name, time) VALUES (%s,%s,%s,%s,%s)"
    val = (full_path,str(coords), state,name , time)
    mycursor.execute(sql, val)
    mydb.commit()

    print(mycursor.rowcount, "record inserted.")

#detecting faces
for (x, y, w, h) in faces:
        roi_gray = gray[y:y + h, x:x + w]
        image = cv2.resize(roi_gray, (48, 48))

        #predicting the emotion
        image = image.astype('float32') / 255.0
        image = img_to_array(image)
        cropped_img = np.expand_dims(image, axis=0)
        yhat= classifier.predict(cropped_img)

        cv2.putText(full_size_image, parameters["emotion_labels"][int(np.argmax(yhat))], (x, y), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 1, cv2.LINE_AA)
        cv2.rectangle(full_size_image, (x, y), (x + w, y + h), (0, 255, 0), 1)

        coordinates()

        print("Emotion: "+parameters["emotion_labels"][int(np.argmax(yhat))])

cv2.imshow('Emotion', full_size_image)
cv2.waitKey()

database()