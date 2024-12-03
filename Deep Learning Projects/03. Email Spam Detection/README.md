# Email Spam Detection
We all receive a lot of emails in our daily life. Some emails are also very meaningless and irrelevant. We call such emails "spam". So, would you like to know which e-mail is spam and which is ham?

## DATASET
Dataset consist of two classes. These are "ham" and "spam". We have **4825** ham data and **747** spam data. The dataset is heavily unbalanced. 
<p align="center">
<img src="https://user-images.githubusercontent.com/81585804/177144875-67ea0a37-2040-4839-bf13-5c2aeb57e2f5.png" width="350" height="250">
</p>

The following two figures show **WordCloud** representation for spam and ham.

<p align="center"> 
<img src="https://user-images.githubusercontent.com/81585804/177145653-a8f04fd5-3983-4283-bc6f-93d372e6d5c4.png" width="410" height="350">
 <img src="https://user-images.githubusercontent.com/81585804/177145809-459c17b8-f064-4ae3-8c9c-3b0c51f61133.png" width="410" height="350">
</p>

## TRAINING
We have trained the data set with the machine learning algorithms. 

* Naive Bayes
* Support Vector Machine
* KNN
* Decision Tree
* Random Forest

Below, for each algorithm you can see the accuracy.

<p align="center"> 
 <img src="https://user-images.githubusercontent.com/81585804/177146582-ba4661f5-d6c1-4f41-801c-5829414f614e.png" width="450" height="350">
</p>

You can also do your predicts for each algorithm or you can choose one for prediction.

```
MultinomialNB() This is a Real email 

SVC(C=1000, gamma=0.001) This is a Real email 

KNeighborsClassifier(n_neighbors=3) This is a Real email 

DecisionTreeClassifier() This is a Real email 

RandomForestClassifier() This is a Real email 
```
