import os
from datetime import datetime, date

import cv2
import librosa
import librosa.display
import matplotlib.pyplot
import numpy as np
from flask import Flask, Blueprint, render_template, request
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image
from tensorflow.keras.utils import load_img, img_to_array

views  = Blueprint('views', __name__)

model = load_model("UrbanSound_CNN_94.5.h5")
class_names = ["Air Conditioner", "Car Horn", "Children Playing", "Dog Bark",
               "Drilling", "Engine Idling", "Gun Shot","Jackhammer", "Siren", "Street Music"]

ALLOWED_EXT = set(['jpg' , 'jpeg' , 'png' ])

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXT

def make_prediction(file, model):
    image = cv2.resize(cv2.imread(file), (64, 64))
    image = image.astype('float32') / 255.0
    image = img_to_array(image)

    image = np.expand_dims(image, axis=0)
    result = model.predict(image)

    dict_result = {}
    for i in range(10):
        dict_result[result[0][i]] = class_names[i]

    res = result[0]
    res.sort()
    res = res[::-1]
    prob = res[:3]

    prob_result = []
    class_result = []
    for i in range(3):
        prob_result.append((prob[i] * 100).round(2))
        class_result.append(dict_result[prob[i]])

    predictions = {
        "class1": class_result[0],
        "class2": class_result[1],
        "class3": class_result[2],
        "prob1": prob_result[0],
        "prob2": prob_result[1],
        "prob3": prob_result[2],
    }
    return predictions



@views.route("/")
@views.route("/home")
def home():
    title = "UrbanSounds"
    return render_template('home.html', title=title)

@views.route("/about")
def about():
    title = "UrbanSounds"
    return render_template('about.html', title=title)

@views.route("/contact", methods=['GET', 'POST'])
def contact():
    title = "UrbanSounds"
    from .models import Post
    from . import db

    if request.method == "POST":
        firstname = request.form.get('firstname')
        lastname = request.form.get('lastname')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')

        new_msg = Post(firstname=firstname,
                       lastname=lastname,
                       email=email,
                       phone=phone,
                       message=message,
                       date_posted=datetime.now())
        new_msg.save()
        print(firstname, lastname, email, phone, message)

    return render_template('contact.html', title=title)

@views.route("/list")
def list():
    from .models import Post,Error
    from app import db
    from app import app

    title = "UrbanSounds"
    page = db.paginate(db.select(Post))
    errors = db.paginate(db.select(Error))
    return render_template('list.html', title=title , page=page, errors=errors)

@views.route("/prediction", methods=["GET", "POST"])
def prediction():
    title = "UrbanSounds"
    error = ''
    target_img = os.path.join(os.getcwd(), 'app/static/loaded_images')

    if request.method == "POST":
        if 'myfile' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['myfile']
        if file.filename.endswith(".wav"):
                try:
                    x, sr = librosa.load(file)
                    mel_spectrogram = librosa.feature.melspectrogram(y=x)
                    image = librosa.amplitude_to_db(mel_spectrogram, ref=np.max)
                    image = librosa.display.specshow(image)
                    path = os.path.join(target_img, file.filename.removesuffix(".wav"))
                    matplotlib.pyplot.savefig(path, bbox_inches="tight", pad_inches=0)
                    matplotlib.pyplot.close()
                    file = path + ".png"

                    predictions = make_prediction(file, model)

                except Exception as e:
                    print(str(e))
                    error = 'Something went wrong with the audio. Please try again'

                if (len(error) == 0):
                    return render_template('prediction-success.html',title=title, predictions=predictions)
                else:
                    return render_template('prediction.html',title=title, error=error)
        else:
                if file and allowed_file(file.filename):
                    file.save(os.path.join(target_img, file.filename))
                    file = os.path.join(target_img, file.filename)

                    predictions = make_prediction(file, model)

                else:
                        error = "Please upload images of jpg , jpeg and png extension only"

                if(len(error) == 0):
                        return  render_template('prediction-success.html' ,title=title, predictions = predictions)
                else:
                        return render_template('prediction.html' , title=title, error = error)
    else:
        return render_template('prediction.html', title=title)


@views.app_errorhandler(404)
def error_404(error):
    from .models import Error
    from . import db
    title = "UrbanSounds"
    new_error = Error(time=datetime.now(),
                      error="404 Not Found",
                      url=request.url)
    new_error.save()
    return render_template('errors/page-404.html',title=title), 404

@views.app_errorhandler(500)
def error_500(error):
    from .models import Error
    from . import db
    title = "UrbanSounds"
    new_error = Error(time=datetime.now(),
                      error="500 Internal Server Error",
                      url=request.url)
    new_error.save()
    return render_template('errors/page-500.html',title=title), 500