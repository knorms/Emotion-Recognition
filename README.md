# Emotion-Recognition

A full write-up is included in the Final Project Report. Abstract included below for easy access.

## Abstract

Humans assess the emotions of others constantly and modulate their behavior based on the emotions they perceive. Reading human emotions via computer vision may be an important step towards improving human-computer interac- tions. In this paper we discuss the development of both image and video-based emotion detection systems. We use the extended Cohn-Kanade (CK+) emotion recognition database, which includes front-facing images of neutral to expressive faces and the x,y coordinates of facial landmarks. We gather alternate landmark data using the clmtrackr JavaScript li- brary. Next, we train support vector machines (SVMs) in Matlab and JavaScript using normalized landmark data. Finally, we classify test images and images from a live video feed using our trained SVMs.

In Matlab we achieved an average emotion classification accuracy of 99.28% and 76.20% using the given CK+ landmarks and the extracted clmtrackr feature points, respectively. In JavaScript, we achieve a maximum accuracy of 80.33% using clmtrackr feature points. Finally, we apply the trained JavaScript SVM to live video and qualitatively asses it’s accuracy. Surprise and sadness are identified the most accurately. Happiness is frequently confused with dis- gust, which in turn may be mistaken for anger. The detector is unable to identify fear. Future work to improve the live emotion detector would involve improving the quality of the training data, by both obtaining a more comprehensive im- age dataset and using a more accurate facial feature point extractor for static images.
