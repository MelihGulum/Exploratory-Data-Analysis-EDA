import cv2
import mediapipe as mp


class handDetector():
    def __init__(self, mode=False, maxHands=2, modComplexity=1, detectionCon=0.9, trackCon=0.9):
        self.mode = mode
        self.maxHands = maxHands
        self.modComplexity = modComplexity
        self.detectionCon = detectionCon
        self.trackCon = trackCon

        self.mpHands = mp.solutions.hands
        self.hands = self.mpHands.Hands(self.mode, self.maxHands,self.modComplexity, self.detectionCon, self.trackCon)
        self.mpDraw = mp.solutions.drawing_utils

    def findHands(self, img, draw=True):
        img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        self.results = self.hands.process(img_rgb)

        if self.results.multi_hand_landmarks:
            for handLms in self.results.multi_hand_landmarks:
                if draw:
                    self.mpDraw.draw_landmarks(img, handLms, self.mpHands.HAND_CONNECTIONS)

        return img

    def findPosition(self, img, handNo=0, draw=True):

        lmList = []
        if self.results.multi_hand_landmarks:
            my_hand = self.results.multi_hand_landmarks[handNo]
            for id, lm in enumerate(my_hand.landmark):
#                   print(id, lm)
                    h, w, c = img.shape
                    cx, cy = int(lm.x*w), int(lm.y*h)
                    lmList.append([id, cx, cy])
#                   print(id, cx, cy)
        return lmList


def main():
    cap = cv2.VideoCapture(0)
    detector = handDetector()

    while True:
        success, img = cap.read()
        img = detector.findHands(img)
#       lmlist = detector.findPosition(img)
#       if len(lmlist) !=0:
#           print(lmlist[4])

        cv2.imshow("Image", img)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break


if __name__ == '__main__':
    main()

