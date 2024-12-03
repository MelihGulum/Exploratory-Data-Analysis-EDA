<br>
<div align="center">
  <img src="https://user-images.githubusercontent.com/81585804/209670788-a3cbb670-fc6e-4a38-973a-994d9e506a17.png" alt="MGC Logo" width="500px" height="150px">
  <h1>Sentiment Analysis and Spam Classification</h1>
 
   <!-- Badges -->
  <p>
    <a href="https://github.com/MelihGulum/Sentiment-Analysis-and-Spam-Classification/graphs/contributors">
      <img src="https://img.shields.io/github/contributors/MelihGulum/Sentiment-Analysis-and-Spam-Classification" alt="contributors" /></a>
    <a href="">
      <img src="https://img.shields.io/github/last-commit/MelihGulum/Sentiment-Analysis-and-Spam-Classification" alt="last update" /></a>
    <a href="https://github.com/MelihGulum/Sentiment-Analysis-and-Spam-Classification/network/members">
      <img src="https://img.shields.io/github/forks/MelihGulum/Sentiment-Analysis-and-Spam-Classification" alt="forks" /></a>
    <a href="https://github.com/MelihGulum/Sentiment-Analysis-and-Spam-Classification/stargazers">
      <img src="https://img.shields.io/github/stars/MelihGulum/Sentiment-Analysis-and-Spam-Classification" alt="stars" /></a>
    <a href="https://github.com/MelihGulum/Sentiment-Analysis-and-Spam-Classification/issues/">
      <img src="https://img.shields.io/github/issues/MelihGulum/Sentiment-Analysis-and-Spam-Classification" alt="open issues" /></a>
  </p>
</div>

# :notebook_with_decorative_cover: Table of Contents

- [ABOUT THE PROJECT](#star2-about-the-project)
  * [Screenshots](#camera-screenshots)
  * [Tech Stack](#space_invader-tech-stack)
  * [Features](#dart-features)
- [DATASETS](#cd-datasets)
- [DEEP LEARNING](#robot-deep-learning)
- [FLASK](#computer-flask)
  * [Database](#card_index_dividers-database)
  * [Multi-Language](#world_map-multi-language)
- [HOW TO RUN](#runner-how-to-run)


## :star2: About the Project
This study is a Natural Language Processing project which is one of the artificial intelligence applications. This project was carried out in order to analyze the sentiment from Twitter comments and to understand whether the text message (SMS) received on the phone is unsolicited message (spam). Later, it was integrated into the web and a more understandable and simple graphical interface was created for the users.
### :camera: Screenshots

<div align="center"> 
  <img src="https://user-images.githubusercontent.com/81585804/209660461-d7f8b685-5081-4961-af20-5ea5be9f2383.gif" alt="Screenshots" width="70%" height="70%">
</div>

### :space_invader: Tech Stack
<details>
  <summary>Client</summary>
  <ul>
    <li>HTML</li>
    <li>CSS</li>
    <li>JavaScript</li>
  </ul>
</details>

<details>
  <summary>Server</summary>
  <ul>
    <li>Python - Flask</li>
  </ul>
</details>

<details>
  <summary>Database</summary>
  <ul>
    <li>MySQL</li>
  </ul>
</details>

### :dart: Features

- Prediction of the sentiment of the given sentences
- Classification of SMS as spam or ham
- You can create a new dataset (via User Sentences)
- Recording the messages sent from the user to the database
- Vanilla language switcher 
- Searching for a specific word in datasets

## 	:cd: Datasets
Two different data sets were used in the project. The first is <a href="https://www.kaggle.com/datasets/kazanova/sentiment140">Sentiment140</a>, which is used for sentiment analysis. Sentimen140 is consist of 1.6 million tweets and labelled as "<em>positive</em>" or "<em>negative</em>". The second is the <a href="https://www.kaggle.com/datasets/uciml/sms-spam-collection-dataset">SMS Spam Collection Dataset</a> used for sms classification. SMS Spam Collection Dataset contains almost 5.6k English SMS. Also, this dataset is labeled as two classes too (Spam - Ham). The spam class contains about 5k of data.

⚠️ If you want to examine the dataset, please do not forget to add the datasets to the dataset folder.

## :robot: Deep Learning
In this section, topics such as ***model training*** and ***preprocessing*** will be discussed. The Sentiment dataset has been cleaned of some special characters like "@, http, 0-9". In addition, the stop words have been removed. Then, <a href="https://en.wikipedia.org/wiki/Word2vec">Word2vec</a> was trained from these tokens. After that, these texts are pad_sequenced with a maximum length of 300. After the embedding layer was created, the vanilla **LSTM** model was builded. The final accuracy of the model is **79.10%**. The model architecture can be seen in the figure below.

 <br><img src="https://user-images.githubusercontent.com/81585804/209803521-84b0ac0c-493b-457e-8a24-d372bc3acc03.png" alt="Model Architecture">
 <p align="center"> <em>Model Architecture (Image by Author)</em> </p>
 
 The Spam dataset was trained with ***Multinomial Naive Bayes*** algorithm is a Bayesian learning approach popular in Natural Language Processing (NLP).

## :computer: Flask
The Web Application consists of 5 pages which can be seen in the gif above. These are Home, Project, About, Contact and finally Dataset page.

### :card_index_dividers: Database
Users can submit their opinions, suggestions or problems about the project after filling out the form on the Contact page. Some information in the form is recorded in the database.

SQL query that saves data to MySQL database:

```sql
CREATE TABLE contact (
	id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	email VARCHAR(30) NOT NULL,
	company_name VARCHAR(50),
	message VARCHAR(200),
	reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
	);
```


### :world_map: Multi-Language
Web App offers you two different language support. One is in **English** and the other is in **Turkish**. This option is made with vanilla Javascript and is open for development.

## :runner: How to Run
1.Fork this repository.

 ```console
git clone https://github.com/MelihGulum/Sentiment-Analysis-and-Spam-Classification.git
```

2.Load the dependencies of the project

```console
pip install -r requirements.txt
```

3.Now you can run project.

```console
flask --app app.py --debug run
```
