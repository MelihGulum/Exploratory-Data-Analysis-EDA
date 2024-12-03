# **Urban Sounds Flask Deployment 🎵**
Welcome to **Urban Sounds Flask Deployment**, a dynamic project blending deep learning and web development to classify urban sounds. This repository showcases an end-to-end pipeline, from data preprocessing to deploying a Flask-based application capable of predicting urban sound classes with high accuracy.

The project is powered by a **Convolutional Neural Network (CNN)** trained on the UrbanSound8K dataset, achieving a remarkable **94.5% accuracy**. With an intuitive user interface, users can upload **both audio files and image files** (such as spectrograms) and get real-time predictions for urban sound categories such as sirens, dog barking, or engine idling. This feature makes the platform versatile for different input types, enhancing its practical usability in diverse scenarios.

Whether you are a researcher exploring urban noise or a developer looking to deploy an AI-powered application, this repository offers a seamless integration of machine learning and web deployment.

### **Key Highlights:**

- **AI Roadmap:** Comprehensive pipeline covering EDA, preprocessing, hyperparameter tuning with Optuna, model training, testing, and performance visualization.
- **Flexible Deployment:** Supports both Development (SQLite) and Production (PostgreSQL) environments for seamless scalability.
- **Interactive Web App:** Built using Flask, featuring clean UI/UX, dark mode support, and a database to manage predictions.
- **Visual Insights:** Includes spectrogram visualizations, loss and accuracy plots, and model architecture diagrams. 

Dive into the repository to explore the intersection of AI innovation and practical deployment! 🚀

# **📂 About the Dataset** 
The UrbanSound8K dataset is a collection of 8,732 labeled sound excerpts (≤ 4s) from field recordings. It contains 10 urban sound categories, including:


<p align="center">   
  <img src="https://github.com/user-attachments/assets/f4c45012-c839-411b-87d4-06da099a42b2" alt="URBANSOUND "width="50%" height="50%">
</p>
 <p align="center"> <em>URBANSOUND (Image by Author)</em> </p><br>


The dataset is structured into 10 cross-validation folds and provides metadata such as class labels, fold IDs, and file paths. It’s a valuable resource for audio classification tasks. Learn more on the UrbanSound8K dataset homepage.

# **🧠 AI Pipeline**
The AI pipeline for this project follows these steps:

1. **EDA & Data Visualization:** Initial data exploration and spectrogram visualizations.
2. **Feature Extraction:** Generating audio features and spectrograms (optional).
3. **Preprocessing:** Data normalization and augmentation.
4. **Train-Test Split:** Splitting the data for training and testing.
5. **Hyperparameter Tuning:** Using Optuna to optimize CNN architecture (optional).
6. **Model Compilation & Training:** Training a CNN using Keras/TensorFlow.
7. **Performance Evaluation:** Visualizing accuracy, loss, confusion matrix, and predictions.
8. **Model Export:** Saving the best-performing model (UrbanSound_CNN_94.5.h5).

# **🌐 Flask Deployment Overview**
The Flask app transforms the AI model into an interactive web application:

* **Development Config:** Uses SQLite for local testing.
* **Production Config:** Supports PostgreSQL for scalable deployment.
* **UI/UX Features:**
   - Upload audio files and image files for predictions.
   - Displays spectrograms of uploaded audio files.
   - Shows predictions for both audio and image categories.
* **Key Components:**
   - app.py: The main entry point for the Flask application.
   - templates/: Contains HTML files for the web pages.
   - static/: Holds CSS, JavaScript, and image assets.

# **🌟 Features and Highlights**
* **High-Accuracy Model:** CNN achieving 94.5% classification accuracy.
* **Interactive App:** Interactive App: User-friendly interface for real-time predictions of audio and image files.
* **Data Insights:** Includes spectrogram and model performance visualizations.
* **Customizable Deployment:** Scales from development to production environments.

# **Screenshots**
<p align="center">   
  <img src="https://github.com/user-attachments/assets/84829500-a6d4-4307-bafb-0d86c5757cfc" alt="Project Demo "width="70%" height="80%">
</p>
 <p align="center"> <em>Project Demo (Image by Author)</em> </p><br>

 
### **Dark Mode**
 <p align="center">   
  <img src="https://github.com/user-attachments/assets/19f58a74-7057-47a2-b59b-ea3dca2f7f86" alt="Project Dark Mode Demo "width="70%" height="80%">
</p>
 <p align="center"> <em>Project Dark Mode Demo (Image by Author)</em> </p><br>


# **🛠 Requirements**
* Python 3.8+
* Libraries: TensorFlow, Keras, Librosa, Optuna, Flask, NumPy, Pandas, Matplotlib, Seaborn 
* Install dependencies with:
```pip install -r requirements.txt```

