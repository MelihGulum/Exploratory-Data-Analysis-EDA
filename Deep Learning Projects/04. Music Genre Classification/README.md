<p align="center"> 
  <img src="static/img/MGC-logo.png" alt="MGC Logo" width="350px" height="100px">
</p>


<h2 id="table-of-contents"> :book: Table of Contents</h2>

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about_the_project"> ABOUT THE PROJECT</a></li>
    <li><a href="#dataset">  DATASET</a></li>
    <li><a href="#preprocess"> PREPROCESS</a></li>
    <li><a href="#deep_learning"> DEEP LEARNING</a></li>
    <li><a href="#web_application_flask"> WEB APPLICATION - FLASK</a></li>
    <ul>
        <li><a href="#database">DATABASE</a></li>
        <li><a href="#mp3">MP3</a></li>
	<li><a href="#screenshots">SCREENSHOTS</a></li>
     </ul>
    <li><a href="#how_to_run"> HOW TO RUN</a></li>
  </ol>
</details>

<h2 id="dataset"> :pencil: About The Project</h2>
<p align="justify">This project aims to classify music genres. Music Genre Classification is an Audio Signal Processing project. <strong>Signal Processing</strong> is one of the sub-fields of Deep Learning apart from <em>Image Processing</em> and <em>Natural Language Processing</em>. The GTZAN dataset consists of "<strong>wav</strong>" audio files. The Librosa library was used to extract the features of these audio files (more on Preprocess section). Different architectures have been created to classification (NN, LSTM, CNN...).</p><br>



<h2 id="preprocess"> :floppy_disk: DATASET</h2>
<p align="justify">The <a href="https://www.kaggle.com/datasets/andradaolteanu/gtzan-dataset-music-genre-classification">GTZAN</a> dataset was used. Briefly, the data set consists of 10 classes and the CSV file contains many attributes such as MFCC, Chroma, RMS. In addition, there are two different CSV in the dataset, whose attributes are extracted on the basis of 3 seconds and 30 seconds. </p>
<p align="center">   
  <img src="https://user-images.githubusercontent.com/81585804/204538070-b036f85f-a95b-4a92-858c-d64687081f1a.png" alt="The Classes of GTZAN "width="45%" height="45%">
</p>
 <p align="center"> <em>The Classes of GTZAN (Image by Author)</em> </p><br>



<h2 id="preprocess"> :hammer_and_wrench: PREPROCESS</h2>
<p align="justify"> As I said earlier, Librosa was used for feature extraction. Features in CSV were not used. I extracted my own features instead of existing features. These features are the top 13 of the MFCCs. Each data was read sequentially. At the same time, the MFCC features are extracted and their labels are respectively added to a json file. </p>
<p align="justify">The code cell below, can be seen how MFCC's are extracted.</p>

```python
y, sample_rate = librosa.load(file_path, sr=SAMPLE_RATE)
librosa.feature.mfcc(y, sample_rate, n_mfcc=13, n_fft=2048, hop_length=512)
```

<br>

<h2 id="deep_learning"> :desktop_computer: DEEP LEARNING</h2>
<p align="justify">Various architectures were built for training. Some of these are ANN, Vanilla LSTM, Stacked LSTM and various CNN architectures. The best was CNN architecture. Later the model was strengthened with regularizer, normalization etc. In short, the model consisted of <em>three Convolutional Layers</em> and an <em>output layer</em>. Pooling Layer and Normalization Layers follow Conv Layer. The accuracy of the model on the test dataset is almost <strong>80%</strong>. The model architecture can be seen below.</p>
  <img src="https://user-images.githubusercontent.com/81585804/204745883-6e15c799-f11e-4439-a034-09e208442ea6.png" alt="Model Architecture" height="100px;">
 <p align="center"> <em>Model Architecture (Image by Author)</em> </p><br>
 
 
 
<h2 id="web_application_flask"> :rocket: WEB APPLICATION - FLASK</h2>
<p align="justify">After the Deep Learning part was over, it was time for the Web Application part. Flask was used to do this. The Web Application consists of 4 pages. These are <strong>Home</strong> (where the audio file is uploaded), <strong>Project</strong> (a brief description of the project here), <strong>About</strong> (dedicated to the team), and finally the <strong>Contact</strong> page.</p>



<h3 id="database"> :package: DATABASE</h3>
<p align="justify">Users can contact the team on the Contact Page. After users submit the form, various information is saved/logged in the <strong>MySQL</strong> database and mailed to the predefined email address.</p>
<p align="justify">SQL query that saves data to MySQL database:</p>

```sql
CREATE TABLE contacts (
	id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	fullname VARCHAR(30) NOT NULL,
	email VARCHAR(30) NOT NULL,
	phone_number VARCHAR(50),
	url VARCHAR(50),
	message VARCHAR(200),
	reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
	);
```


<h3 id="mp3"> :musical_note: MP3</h3>
<p align="justify">The model cannot predict MP3 audio files. That's why FFMPEG was used ( :warning: <em>but first, path must be saved on system environments</em>). FFMPEG converts uploaded mp3 files to wav files. </p>



<h3 id="screenshots"> :camera: SCREENSHOTS</h3>
<p align="center"> 
  <img src="https://user-images.githubusercontent.com/81585804/204807317-1a3edabd-d173-436e-b0a9-080d59ac7104.gif" alt="Screenshots" width="70%" height="70%">
</p><br>


<h2 id="how_to_run"> :running: HOW TO RUN</h2>
1.Fork this repository.

 ```console
git clone https://github.com/MelihGulum/Music-Genre-Classification.git
```

2.Load the dependencies of the project

```console
pip install -r requirements.txt
```

3.Now you can run project.

```console
flask --app MGC_flask.py --debug run
```
 








