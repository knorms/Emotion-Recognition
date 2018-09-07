import glob
import os
abs_path = '/Users/knorms/Dropbox/1430_Computer_Vision/final_proj/data/Emotion'
os.chdir(abs_path)

sessions = glob.glob("./S*/*")
os.chdir('../../clmtrackr-dev/examples/') # move examples folder where cohn-kanade-images folder has been moved

# Saves files to Data
emo = open("../../emotion_lbls.txt",'w')
img = open("../../img_list.txt",'w')
pts = open("../../aam_points.txt",'w')

for sess in sessions:
    emotion_file = glob.glob(abs_path+sess[1:]+"/*.txt")
    if not emotion_file: continue #if no emotion file, skip

    # Create list of emotion labels
    # First frame neutral, last two==emotion
    f = open(emotion_file[0],'r')
    emotion = float(f.read().strip())
    emo.write(str(0.0)+" ")
    emo.write(str(emotion)+" ")
    emo.write(str(emotion)+" ")

    # Compile image file paths, first neutral frame and last two frames
    tmp = sorted(glob.glob("./cohn-kanade-images/"+sess[2:]+"/*.png"))
    img.write(tmp[0]+" ")
    img.write(tmp[-3]+" ")
    img.write(tmp[-2]+" ")
    img.write(tmp[-1]+" ")

    # Compile AAM file paths
    tmp = sorted(glob.glob(abs_path+"/../Landmarks/"+sess[2:]+"/*.txt"))
    for i in [0,-3,-2,-1]:
        f = open(tmp[i],'r')
        points = f.read().split()
        for point in points:
            pts.write(point+" ")


emo.close()
img.close()
pts.close()


""" How to read in the data

emo = open("../../emotion_lbls.txt",'r')
emo = emo.read().split()
pts = open("../../aam_points.txt",'r')
pts = pts.read().split()

data = []
for i in range(len(emo)):
    data.append([
    pts[i*68*2:i*68*2+68*2],
    emo[i]
    ])
"""
