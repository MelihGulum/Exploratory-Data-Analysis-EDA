
# Heart Attack Prediction Project

This project focuses on predicting heart attack occurrences using a dataset containing clinical and health-related features. The workflow includes exploratory data analysis (EDA), feature engineering, handling missing values and outliers, and building machine learning models to predict the likelihood of heart disease.

This notebook was originally prepared for Global AI Hub's live YouTube stream as part of their Machine Learning Bootcamp.

## **About the Dataset**
The [dataset](https://www.kaggle.com/datasets/johnsmith88/heart-disease-dataset) used contains various clinical attributes and a target variable indicating heart attack occurrences. Key features include:

1. **Age** : Age of the patient
2. **Sex** : Sex of the patient
3. **exang**: exercise induced angina
    - 1: yes
    - 0: no
4. **ca**: number of major vessels (0-3)
5. **cp** : Chest Pain type chest pain type
    - Value 1: typical angina
    - Value 2: atypical angina
    - Value 3: non-anginal pain
    - Value 4: asymptomatic trtbps : resting blood pressure (in mm Hg)
6. **chol** : cholestoral in mg/dl fetched via BMI sensor
7. **fbs** : fasting blood sugar > 120 mg/dl
    - 1: true
    - 0: false)
8. **rest_ecg** : resting electrocardiographic results
    - Value 0: normal
    - Value 1: having ST-T wave abnormality (T wave inversions and/or ST elevation or depression of > 0.05 mV)
    - Value 2: showing probable or definite left ventricular hypertrophy by Estes' criteria thalach : maximum heart rate achieved
9. **thalachh**: Maximum heart rate achieved during a stress test exng: Exercise induced angina 
  - 0: no
  - 1: yes
10. **oldpeak:** ST depression induced by exercise relative to rest (unit -> depression)
11. **slp:** Slope of the peak exercise ST segment (
    - 0: Upsloping
    - 1: Flat
    - 2: Downsloping
12. **caa:** Number of major vessels (0-4) colored by fluoroscopy thall: Thalium stress test result 
  - 0: Normal
  - 1: Fixed defect
  - 2: Reversible defect
  - 3: Not described
13. **target** :
    - 0: less chance of heart attack
    - 1: more chance of heart attack



## **Project Overview**
1. **EDA (Exploratory Data Analysis)**
    - **Data Inspection:** Analyze basic statistics and inspect for missing values, outliers, and inconsistencies.
    - **Correlation Analysis:** Evaluate feature correlations using heatmaps and correlation coefficients to identify potential relationships with the target variable.
2. **Visualization**
    - **Distribution Analysis:** Visualize distributions of key features like Age, RestingBP, Cholesterol, and others using histograms and boxplots.
    - **Heart Attack Distribution:** Visualize the proportion of patients with and without a heart attack (target variable) using bar plots.
    - **Pairwise Feature Interaction:** Explore feature relationships, such as MaxHR vs. Oldpeak, and how they influence heart attack risk.
3. **Feature Engineering**
    - **Missing Value Handling:** Detect and handle missing values.
    - **Outlier Detection and Handling:** Identify and handle outliers for features like RestingBP and Cholesterol to improve data quality.
    - **Feature Extraction:** Create new meaningful features based on existing ones, like binning age ranges or deriving features based on patient conditions.
    - **Encoding & Scaling:** Perform encoding of categorical variables (e.g., ChestPainType, Sex) and scale numerical features to standardize the data.
4. **Modeling**
    - **Multiple Models:** Train several machine learning models, including:

       - Logistic Regression
       - K-Nearest Neighbors (KNN)
       - Decision Tree
    These models are evaluated for their performance in predicting heart attack risk.

    - **Model Evaluation:** Compare the models based on accuracy, precision, recall, and other relevant metrics to choose the best-performing model for this dataset.
        - **Note: The notebook does not include hyperparameter tuning. The model is kept simple and straightforward to serve as a baseline for future improvements.**

## **For Future Work**
- **Hyperparameter Tuning:** Apply techniques like grid search or random search to optimize model parameters.
- **Advanced Models:** Experiment with more complex algorithms like Random Forest, XGBoost, or Gradient Boosting to improve prediction performance.
- **Feature Importance:** Use advanced techniques such as SHAP values or feature importance from tree-based models to better interpret the model's decisions.

