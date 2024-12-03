# **Airline Passenger Satisfaction Analysis**

This project aims to analyze airline passenger satisfaction by exploring various features that contribute to overall satisfaction levels. By leveraging advanced data analysis and machine learning techniques, we strive to understand the factors influencing passenger experiences and to build predictive models that can enhance airline services.

## **About the Dataset**
The [dataset](https://www.kaggle.com/datasets/teejmahal20/airline-passenger-satisfaction) used for this analysis comprises passenger feedback on various aspects of their airline experience, including service quality, comfort, cleanliness, and amenities. It contains both numerical and categorical features, providing a rich basis for exploratory data analysis and modeling.

## **Project Overview**
The project is structured into two main notebooks, each focusing on different stages of the data analysis and modeling process.

### **Notebook 1: Exploratory Data Analysis (EDA) and Preprocessing**
1. **Import Libraries and Load Dataset**
    - Essential libraries are imported, and the dataset is loaded for analysis.

2. **Helper Functions**
    - **Helper Functions for Numeric Analysis**: Functions to summarize and analyze numerical data.
    - **Helper Functions for Visualizations**: Custom visualization functions to enhance EDA.
    - **Helper Functions for Target Analysis**: Functions specifically for analyzing the target variable.
3. **Exploratory Data Analysis (EDA)**
    - **Numerical EDA**: Summary Statistics
        - **Train Data**: Summary statistics for training data.
        - **Test Data**: Summary statistics for testing data.
        - **Target Variable Analysis**: Insights on the distribution and characteristics of the target variable.
    - **Visual EDA: Data Visualization**: Various visualizations to explore relationships and patterns in the data.
4. **Data Preprocessing**
    * **Data Cleaning and Reduction:** Steps taken to clean the dataset and reduce dimensionality if necessary.
    * **Handling Missing Data:** Strategies employed to address missing values.
    * **Outlier Detection and Treatment:** Identification and treatment of outliers in the dataset.
    * **Feature Engineering:** Creation of new features to enhance model performance.
    * **Data Scaling and Encoding:** Techniques applied to scale numerical features and encode categorical features.
5. **Save Preprocessed Data:** The preprocessed dataset is saved for subsequent modeling tasks.

### **Notebook 2: Modeling and Evaluation**
1. **Import Libraries and Load Preprocessed Dataset:** Load necessary libraries and the preprocessed dataset for modeling.

2. **Model Development**

    * **Baseline Model Evaluation:** Initial evaluation of various models to establish a performance baseline.
    * **Hyperparameter Tuning with Optuna**
        * **LightGBM Optimization**: Tuning hyperparameters for the LightGBM model.
        * **CatBoost Optimization**: Tuning hyperparameters for the CatBoost model.
        * **XGBoost Optimization:** Tuning hyperparameters for the XGBoost model.
    * **Feature Selection Using SHAP Values:** Utilizing SHAP values to identify important features for model building.
3. **Final Model Evaluation**
    * **Comparison of Full Feature Model vs. SHAP Selected Feature Model:** Evaluating and comparing the performance of the models using all features versus those selected via SHAP.
    * **Predictions on the Test Set and Final Evaluation Metrics:** Generating predictions on the test set and calculating final evaluation metrics.
    * **Save the Final Model:** The final model is saved for future predictions and usage.

## **Summary**
This project provides an in-depth exploration of factors affecting airline passenger satisfaction, employing advanced data analysis and machine learning techniques. Through meticulous EDA, preprocessing, and modeling, we aim to deliver actionable insights and a robust predictive model. The findings and methodologies presented in this project can serve as a foundation for improving airline services and enhancing passenger experiences.
