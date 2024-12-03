from flask import Flask, render_template, request
import smtplib
from flask_mysqldb import MySQL
from datetime import datetime
import tensorflow as tf
import keras
import librosa
import numpy as np
import math
#from werkzeug.utils import secure_filename
#import os


app = Flask(__name__)


app.config['MYSQL_HOST'] = "YOUR_HOST"
app.config['MYSQL_USER'] = "YOUR_USERNAME"
app.config['MYSQL_PASSWORD'] = "YOUR_PASSWORD"
app.config['MYSQL_DB'] = "YOUR_DB?NAME"
app.config['MYSQL_CURSORCLASS'] = "DictCursor"

#app.config['SECRET_KEY'] = 'SECRET_KEY'
#app.config['UPLOADED_PHOTOS'] = ''

mysql = MySQL(app)

model = keras.models.load_model("MusicGenre_CNN_79.73.h5")

@app.route("/")
def homepage():
    title="MGC"
    return render_template('homepage.html', title=title)

@app.route("/prediction", methods=["POST"])
def prediction():
    title="MGC | Prediction"

    #if request.method == 'POST' and 'myfile' in request.files:
        #audio = request.files['myfile']
        #filename = secure_filename(audio.filename)
        #audio.save(os.path.join(app.config['UPLOADED_PHOTOS'], filename))
        #print(audio.filename, type(audio), audio.filename.split('.')[0])

    audio = request.form['myfile']

    if audio.endswith(".mp3"):
        import subprocess
        import os.path
        extension = os.path.splitext(audio)[0]
        subprocess.call(['ffmpeg', '-i', audio, extension+'.wav'])

        from pydub import AudioSegment
        t1 = 60 * 1000  # Works in milliseconds
        t2 = 90 * 1000
        newAudio = AudioSegment.from_wav(extension+'.wav')
        newAudio = newAudio[t1:t2]
        newAudio.export(extension+'.wav', format="wav")  # Exports to a wav file in the current path.
        audio=extension+'.wav'
    # Audio files pre-processing
    if request.method == 'POST':
        def process_input(audio_file, track_duration):

            SAMPLE_RATE = 22050
            NUM_MFCC = 13
            N_FTT = 2048
            HOP_LENGTH = 512
            TRACK_DURATION = track_duration  # measured in seconds
            SAMPLES_PER_TRACK = SAMPLE_RATE * TRACK_DURATION
            NUM_SEGMENTS = 10

            samples_per_segment = int(SAMPLES_PER_TRACK / NUM_SEGMENTS)
            num_mfcc_vectors_per_segment = math.ceil(samples_per_segment / HOP_LENGTH)

            signal, sample_rate = librosa.load(audio_file, sr=SAMPLE_RATE)

            for d in range(10):
                # calculate start and finish sample for current segment
                start = samples_per_segment * d
                finish = start + samples_per_segment

                # extract mfcc
                mfcc = librosa.feature.mfcc(signal[start:finish], sample_rate, n_mfcc=NUM_MFCC, n_fft=N_FTT,
                                            hop_length=HOP_LENGTH)
                mfcc = mfcc.T

                return mfcc

    audio_file = process_input(audio, 30)
    genre_dict = {0: "disco", 1: "pop", 2: "classical", 3: "metal", 4: "rock", 5: "blues", 6: "hiphop", 7: "reggae",
                  8: "country", 9: "jazz"}
    X_to_predict = audio_file[np.newaxis, ..., np.newaxis]

    pred = model.predict(X_to_predict)
    pred = np.argmax(pred)


    prob = model.predict(X_to_predict)
    for result in prob:
        proba =(str("{:.2f}".format((max(result)*100))))
        #print(tf.greater(result, .5))


    np.set_printoptions(formatter={'float': lambda x: "{0:0.3f}".format(x)})
    all_proba=(result)
    #print(all_proba)

    #sorting array for to get second and third
    L = np.argsort(all_proba,axis=0)
    #print(L)

    return render_template('prediction.html', title=title,
                           prediction=genre_dict[int(pred)],probability=proba,
                           second_prediction=genre_dict[L[-2]],second_probability=("{:.2f}".format((all_proba[L[-2]]*100))),
                           third_prediction=genre_dict[L[-3]],third_probability=("{:.2f}".format((all_proba[L[-3]]*100))))


@app.route("/about")
def about():
    title="MGC | About"
    return render_template('about.html', title=title)


@app.route("/project")
def project():
    title="MGC | Project"
    return render_template('project.html', title=title)


@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'GET':
        return "Login via the login Form"

    if request.method == 'POST':
        full_name = request.form['full_name']
        email = request.form['email']
        phone_number = request.form['phone_number']
        url = request.form['url']
        message = request.form['message']
        time = datetime.now()


        # turn on "https://myaccount.google.com/u/2/lesssecureapps?pli=1&rapt=AEjHL4Nuusfw1m0UmLhUNWSbum-otyPP2oUPRocsGAncxSghtxlAlkwoBVdkbFtd9b2qRLBP75xed49Bm01pEpRhscnwknqduw"
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.starttls()
        server.login("your_email_adress","your_password")
        server.sendmail("your_email_adress",email,message)

        cursor = mysql.connection.cursor()
        cursor.execute(''' INSERT INTO Contacts VALUES(%s,%s,%s,%s,%s,%s,%s)''', (id,full_name, email, phone_number, url, message,time))
        mysql.connection.commit()
        cursor.close()

        title = "MGC | Contact"
        return render_template('contact.html', title=title)
@app.route("/contact")
def contact():
    title="MGC | Contact"
    return render_template('contact.html', title=title)




