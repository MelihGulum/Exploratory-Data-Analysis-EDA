# Diabetes Classification

This project focuses on analyzing the [Pima Indians Diabetes](https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database) dataset through Exploratory Data Analysis (EDA), feature engineering, and machine learning model building to predict diabetes occurrence. The goal is to build an accurate prediction model by handling missing values, detecting and handling outliers, extracting relevant features, and visualizing data insights. Various machine learning models are trained and evaluated to determine the best-performing algorithm.

## **Table of Contents**
* About the Dataset
* Project Overview
* Summary

## **About the Dataset**
The **Pima Indians Diabetes dataset** contains 768 observations of medical records for women aged 21 years and above. The outcome variable (Outcome) indicates whether a patient has diabetes (1) or not (0). The dataset includes the following features:

* **Pregnancies:** Number of pregnancies
* **Glucose:** Plasma glucose concentration after a 2-hour oral glucose tolerance test
* **BloodPressure:** Diastolic blood pressure (mm Hg)
* **SkinThickness:** Triceps skinfold thickness (mm)
* **Insulin:** 2-Hour serum insulin (mu U/ml)
* **BMI:** Body mass index (weight in kg/(height in m)^2)
* **DiabetesPedigreeFunction:** A score representing the likelihood of diabetes based on family history
* **Age:** Age in years
* **Target variable:** Outcome 1 indicates having diabetes; 0 indicates not having diabetes. 

## **Project Overview**
The project is divided into the following sections:

### **A. EDA** 
* **Missing Value Handling:** Identify and impute missing values in critical features like Insulin and SkinThickness.
* **Outlier Detection & Handling:** Use statistical methods to detect and handle outliers for better model accuracy.
* **Correlation Analysis:** Analyze feature correlations to understand their relationships with the target variable.
* **Feature Extraction:** Create new features (e.g., BMI categories, Age bins) to improve model interpretability and predictive performance.

### **B. Visualization**
* **Outliers:** Visualize outliers before and after handling them.
* **Distribution Plots:** Analyze the distribution of key features to understand their spread and variability.
* **Diabetes Ratio:** Visualize the ratio of diabetes occurrences within the dataset.
* **Visualization of Extracted Features:** Visualize newly engineered features and their contribution to the model.

### **C. Machine Learning**
* Build various machine learning models such as Logistic Regression, Decision Trees, Random Forest, and XGBoost to predict diabetes.
* Perform hyperparameter tuning to optimize model performance.

### **D. Model Performance**
* Evaluate model performance using metrics such as accuracy, precision, recall, and AUC-ROC.
* Compare the effectiveness of different models and identify the best-performing one.

### **E. Conclusion**
* Summarize the key insights and model performance.
* Provide recommendations for further improvements and next steps.
| Algorithm | Baseline Accuracy <br>Without Data Preprocess | Baseline Accuracy  <br>With Data Preprocess | Optimization
|  :---: | :---: |  :---: | :---:
| LR | 0.7671 | 0.8731 | - |
| KNN | 0.7182 | 0.8535 | 0.8616 |
| CART | 0.7312 | 0.8354 | 0.8615 |
| RF | 0.7752 | 0.8893 | 0.8828|
| GBM | 0.7638 | 0.8893 | -  |
| XGBoost | 0.7508 | 0.8909 | 0.8974 |
| LightGBM | 0.7378 | 0.8925 | 0.9007 |


## **Summary** 
This project provides an end-to-end approach to analyzing and modeling the Diabetes dataset:

* **Key Features:** Features such as Glucose, Insulin, and BMI play a significant role in predicting diabetes.
* **Model Performance:** LightGBM outperformed baseline models after hyperparameter tuning, achieving the highest accuracy.

By following a structured workflow from data cleaning to model evaluation, this project highlights best practices in feature engineering, visualization, and machine learning.