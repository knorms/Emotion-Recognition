# Emotion-Recognition

A full write-up is included in the Final Project Report. Some excerpt are included below for easy access.

## Abstract

Humans assess the emotions of others constantly and modulate their behavior based on the emotions they perceive. Reading human emotions via computer vision may be an important step towards improving human-computer interac- tions. In this paper we discuss the development of both image and video-based emotion detection systems. We use the extended Cohn-Kanade (CK+) emotion recognition database, which includes front-facing images of neutral to expressive faces and the x,y coordinates of facial landmarks. We gather alternate landmark data using the clmtrackr JavaScript li- brary. Next, we train support vector machines (SVMs) in Matlab and JavaScript using normalized landmark data. Finally, we classify test images and images from a live video feed using our trained SVMs.

In Matlab we achieved an average emotion classification accuracy of 99.28% and 76.20% using the given CK+ landmarks and the extracted clmtrackr feature points, respectively. In JavaScript, we achieve a maximum accuracy of 80.33% using clmtrackr feature points. Finally, we apply the trained JavaScript SVM to live video and qualitatively asses it’s accuracy. Surprise and sadness are identified the most accurately. Happiness is frequently confused with dis- gust, which in turn may be mistaken for anger. The detector is unable to identify fear. Future work to improve the live emotion detector would involve improving the quality of the training data, by both obtaining a more comprehensive im- age dataset and using a more accurate facial feature point extractor for static images.

## Methods
We used the Cohn-Kanade extended (CK+) database [1] for emotion recognition. CK+ contains 327 filmed emotion sequences performed by 123 different subjects 18-50yo, ma- jority female (69%) and Euro-American (81%) and includes validated emotion labels for 7 basic emotions: anger, disgust, happiness, sadness, surprise, and contempt.
We tested two sources of facial feature points: 1) 68 pre-calculated facial landmarks included with the CK+ data, and 2) 71 facial feature points calculated using the JavaScript clmtrackr library [2].

The first portion of this project was dedicated to building a support vector machine on MATLAB trained on the landmark data provided by the CK+ study. 
Next we trained a Support Vector Machine (SVM) using NodeJS for live emotion detection.
The feature vectors, which were obtained by calculating the difference between each emotion and the average neutral face and normalizing in MATLAB, were imported into Javascript.
We set up a server-to-client interaction to run an http server for clmtrackr using NodeJS to run the pretrained SVM classifier on continuously captured feature point data.

References
[1] P. Lucey, J. Cohn, T. Kanade, J. Saragih, Z. Ambadar, and I. Matthews. The extended cohn-kanade dataset (ck+): A com- plete expression dataset for action unit and emotion-specified expression. In Proceedings of the Third International Work- shop on CVPR for Human Communicative Behavior Analysis (CVPR4HB 2010), pages 94–101, San Francisco, USA, 2010. 1, 2, 5
[2] A. Mathias. clmtrackr: Javascript library for precise track- ing of facial features via contrained local models. https: //github.com/auduno/clmtrackr, 2014. [Online; accessed 2017-12-18]. 1, 2
