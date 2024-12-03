from tensorflow.keras.preprocessing.image import img_to_array
from tensorflow.keras.models import load_model
import numpy as np
import cv2
import hand_detection as hd

# load model
model = load_model('CNN.h5')

class_names = ["A", "B", "C", "D", "E", "F",
               "G", "H", "I", "J", "K", "L",
               "M", "N", "O", "P", "Q", "R",
               "S", "T", "U", "V", "W", "X",
               "Y", "Z", "del", "nothing", "space"]

cap = cv2.VideoCapture(0)
detector = hd.handDetector()
samples_to_predict = []


def listToString(s):
    # initialize an empty string
    str1 = ""

    # traverse in the string
    for ele in s:
        str1 += ele

        # return string
    return str1


while True:
    success, img = cap.read()
    image = detector.findHands(img)
    landmark_list = detector.findPosition(img)

    # get corner points of face rectangle
    (startX, startY) = 50, 50
    (endX, endY) = 300, 300
    rec = cv2.rectangle(img, (startX, startY), (endX, endY), 255, 4)

    # mask = np.zeros(img.shape[:2], dtype="uint8")
    # Draw the desired region to crop out in white
    # rec = cv2.rectangle(mask, (startX, startY), (endX, endY), (255), -1)
    # masked = cv2.bitwise_and(img, img, mask=mask)

    cropped_video = img[50:300, 50:300]
    if len(landmark_list) != 0:
        #       print(landmark_list[0][1])
        if (startX <= landmark_list[0][1] <= endX) and (startY <= landmark_list[0][2] <= endY):
            image = cv2.resize(cropped_video, (64, 64))
            image = image.astype('float32') / 255.0
            x = img_to_array(image)
            x = np.expand_dims(image, axis=0)

            prediction = model.predict(x)
            prediction = np.argmax(prediction)
            label = class_names[prediction]

            for i in label:
                samples_to_predict.append(label)
                # print(samples_to_predict)
                # print(len(samples_to_predict))
            # print(set(samples_to_predict))

            string_labels = listToString(samples_to_predict)
            if len(string_labels) >= 10:
                import re

                consecutive = [match[1] for match in re.findall(r'((\w)\2{9,})', string_labels)]
                cv2.putText(img, format(consecutive), (90, 40), cv2.FONT_HERSHEY_SIMPLEX,
                            0.7, (0, 255, 0), 2)

            cv2.putText(img, label, (90, 90), cv2.FONT_HERSHEY_SIMPLEX,
                        0.7, (0, 255, 0), 2)

    cv2.imshow("Image", img)

    # cv2.imwrite("face-" + ".jpg", cropped_video)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
