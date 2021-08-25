# required
# pip install opencv-python

import cv2
import os
arr = os.listdir()


for filename in arr:
    if(filename.endswith(".jpg") or filename.endswith(".png")):
        print(filename)
        img = cv2.imread(filename)
        height, width, channels = img.shape


        # 720x1640
        if(height == 1640):
            print(filename)
            y = 80
            h = 1640-160
            x = 0
            w = 720
            crop_img = img[y:y+h, x:x+w]
            cv2.imwrite(filename,crop_img)
            print(filename + " images resized")