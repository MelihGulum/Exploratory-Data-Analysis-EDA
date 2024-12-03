import time
from datetime import datetime
import keras
import pandas as pd
from flask import Flask, render_template, request
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['DEBUG'] = True
app.config['MYSQL_HOST'] = "YOUR_HOST"
app.config['MYSQL_USER'] = "YOUR_USERNAME"
app.config['MYSQL_PASSWORD'] = "YOUR_PASSWORD"
app.config['MYSQL_DB'] = "DB"
app.config['MYSQL_CURSORCLASS'] = "DictCursor"
app.config['SECRET_KEY'] = 'A_VERY_SECRET_KEY'

mysql = MySQL(app)

@app.route("/")
def homepage():
    title="NLP"
    return render_template('homepage.html',title=title)

@app.route("/prediction",methods=["POST"])
def prediction():
    title="NLP | Sentiment Classification"

    email = request.form['text']

    from keras.preprocessing.text import Tokenizer
    from keras.preprocessing.sequence import pad_sequences
    from keras.models import Sequential, load_model  # Add 'load_model'
    from joblib import dump, load  # For reading the Tokenizer Pickle

    KERAS_MODEL = "LSTM_79.08.h5"
    TOKENIZER_MODEL = "tokenizer.pkl"

    # KERAS
    SEQUENCE_LENGTH = 300

    # SENTIMENT
    POSITIVE = "POSITIVE"
    NEGATIVE = "NEGATIVE"
    NEUTRAL = "NEUTRAL"
    SENTIMENT_THRESHOLDS = (0.4, 0.7)

    # Load the model and the tokenizer to make predictions
    model = load_model(KERAS_MODEL)
    tokenizer = load(TOKENIZER_MODEL)

    def decode_sentiment(score, include_neutral=True):
        if include_neutral:
            label = NEUTRAL
            if score <= SENTIMENT_THRESHOLDS[0]:
                label = NEGATIVE
            elif score >= SENTIMENT_THRESHOLDS[1]:
                label = POSITIVE

            return label
        else:
            return NEGATIVE if score < 0.5 else POSITIVE

    def predict(text, include_neutral=True):
            start_at = time.time()
            # Tokenize text
            x_test = pad_sequences(tokenizer.texts_to_sequences([text]), maxlen=SEQUENCE_LENGTH)
            # Predict
            score = model.predict([x_test])[0]
            # Decode sentiment
            label = decode_sentiment(score, include_neutral=include_neutral)

            return {"label": label, "score": float(score),
                    "elapsed_time": time.time() - start_at}

    pred = predict(email)

    with open('User Sentences/user_sentiment_sentences.txt', 'a') as f:
        f.write("\n"+"TEXT= "+str(email)+"     PREDICTION= "+pred["label"]+"     SCORE= "+ str(pred["score"]))

    return render_template('homepage.html',title=title,prediction=(pred["label"]),score=(pred["score"]), message=[email][0])

@app.route("/predict",methods=["POST"])
def predict():

    title="NLP | Spam Classification"
    import pandas as pd
    from sklearn.feature_extraction.text import CountVectorizer
    from sklearn.naive_bayes import MultinomialNB

    df = pd.read_csv("datasets/spam.csv", encoding="latin-1")
    df.drop(['Unnamed: 2', 'Unnamed: 3', 'Unnamed: 4'], axis=1, inplace=True)
    # Features and Labels
    df['label'] = df['class'].map({'ham': 0, 'spam': 1})
    X = df['message']
    y = df['label']

    # Extract Feature With CountVectorizer
    cv = CountVectorizer()
    X = cv.fit_transform(X)  # Fit the Data
    from sklearn.model_selection import train_test_split
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=42)

    # Naive Bayes Classifier
    from sklearn.naive_bayes import MultinomialNB
    clf = MultinomialNB()
    clf.fit(X_train, y_train)
    clf.score(X_test, y_test)
    #print(clf.score(X_test, y_test))
    # Alternative Usage of Saved Model
    # joblib.dump(clf, 'NB_spam_model.pkl')
    # NB_spam_model = open('NB_spam_model.pkl','rb')
    # clf = joblib.load(NB_spam_model)

    if request.method == 'POST':
        message = request.form['spam_text']
        data = [message]
        vect = cv.transform(data).toarray()
        my_prediction = clf.predict(vect)

    with open('User Sentences/user_spam_sentences.txt', 'a') as f:
        f.write("\n"+"TEXT= "+str(message)+"     PREDICTION= "+str(my_prediction))
    return render_template('homepage.html',title=title, prediction=my_prediction)


@app.route("/dataset",methods=["POST"])
def dataset():
    title="NLP | Datasets"
    error = ''

    # reading the data in the csv file
    if request.form['data'] =='spam':
        try:
            df_spam = pd.read_csv("datasets/spam.csv", encoding="latin-1")
            df_spam.drop(['Unnamed: 2', 'Unnamed: 3', 'Unnamed: 4'], axis=1, inplace=True)
            myData = df_spam.values
        except Exception as e:
            error = 'Can not open dataset. Make sure you have it'
        if (len(error) == 0):
                return render_template('table.html', title=title, myData=myData)
        else:
                return render_template('homepage.html', title=title, error=error)
    else:
        try:
            DATASET_COLUMNS = ["target", "ids", "date", "flag", "user", "text"]
            DATASET_ENCODING = "ISO-8859-1"
            df_sentiment = pd.read_csv('datasets/training.1600000.processed.noemoticon.csv',
                     encoding =DATASET_ENCODING , names=DATASET_COLUMNS)
            df_sentiment.drop(['ids','date', 'flag','user'], axis=1, inplace=True)
            import random
            random_idx_list = [random.randint(1,len(df_sentiment.text)) for i in range(5572)] # creates random indexes to choose from dataframe
            rand=df_sentiment.loc[random_idx_list,:].head(5572) # Returns the rows with the index and display it
            myData = rand.values
        except Exception as e:
            error = 'Can not open dataset. Make sure you have it'
        if (len(error) == 0):
            return render_template('table.html', title=title, myData=myData)
        else:
            return render_template('homepage.html', title=title, error=error)

@app.route("/project")
def project():
    title="NLP | Project"
    return render_template('project.html', title=title)

@app.route("/contact", methods=['POST', 'GET'])
def contact():
    if request.method == 'GET':
        title="NLP | Contact Us"
        return render_template('contact.html',title=title)

    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        company_name = request.form['company-name']
        message = request.form['message']
        time = datetime.now()

        cursor = mysql.connection.cursor()
        cursor.execute(''' INSERT INTO contact VALUES(%s,%s,%s,%s,%s,%s)''', (id,name, email, company_name, message,time))
        mysql.connection.commit()
        cursor.close()

        title="NLP | Contact Us"
        return render_template('contact.html',title=title)

@app.route("/about")
def about():
    title="NLP | About Us"
    return render_template('about.html',title=title)

