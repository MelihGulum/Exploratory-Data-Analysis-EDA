from keras.models import load_model
from time import sleep
from keras.preprocessing.image import img_to_array
from keras.preprocessing import image
import cv2
import os
import numpy as np


face_cascade =cv2.CascadeClassifier("haarcascade_frontalface_default.xml")
classifier =load_model('FER-CNN.h5')

emotion_labels = ['Angry','Fear','Happy','Neutral', 'Sad']


cap = cv2.VideoCapture(0)
while True:
    _, frame = cap.read()
    image = cv2.resize(frame, (600, 500))
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    face_rects = face_cascade.detectMultiScale(gray,scaleFactor=1.3, minNeighbors=5)

    for (x, y, w, h) in face_rects:
        cv2.rectangle(frame, (x, y - 50), (x + w+50, y + h + 10), (0, 255, 0), 2)
        roi_gray_frame = gray[y:y + h, x:x + w]
        image = cv2.resize(roi_gray_frame, (48, 48))

        if np.sum([image])!=0:
            image = image.astype('float32') / 255.0
            image = img_to_array(image)
            cropped_img = np.expand_dims(image, axis=0)
            #print(cropped_img.shape)

            prediction = classifier.predict(cropped_img)

            for result in prediction:
                proba = (str("{:.2f}".format((max(result) * 100))))
                # print(tf.greater(result, .5))
            #print(proba)
            prediction = np.argmax(prediction)

            label = emotion_labels[prediction]

            #print(label)

            cv2.putText(frame,label,(x,y-55),cv2.FONT_HERSHEY_SIMPLEX,1,(0,255,0),2)
            cv2.putText(frame, proba, (x+130, y - 55), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

        else:
            pass

    cv2.imshow('Emotion Detector',frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()